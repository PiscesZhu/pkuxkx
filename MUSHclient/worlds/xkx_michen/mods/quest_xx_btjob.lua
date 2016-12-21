---------------------------------------------------------------------------
-- File name   : quest_xx_btjob.lua
-- Description : 星宿派到白驼打工放蛇,设置的是咬家丁，所以只能到80K
--						目前有个问题，如果设置经验不优先，那么一小时就2K不到，非常慢
--						如果设置经验优先，到上限的时候基本上是没有事情做的...
--
-- Author: Michen (xmichen@gmail.com)
-- Version:	2014.05
---------------------------------------------------------------------------

print("quest:xx do bt job Loading ok!")

qxxbt={
	nowplace=0,
	sucked=false,
	keplace=926,
	masterplace=0,
	masterid=nil,
	limit=false,
	expfirst=true,		-- 是否经验优先
}

qxxbt.npcplace={
	{924,"jiading","家丁",},
	{923,"jiading","家丁",},
	{1057,"shou","趟子手",},
	{1026,"shan","小姗",},
	--{1056,"porter","挑夫",},
}
function qxxbt.start()
	qxxbt.update()
	trigrpon("q_xxbt")
	run("get ji from shi he;drink ji;put ji in shi he")
	run("score;cha")
	busytest(qxxbt.startcheck)
end

function qxxbt.startcheck()
	run("convert she")
	gethp(qxxbt.check)
end

function qxxbt.check()
	if me.hp["qi_percent"] < 100 then
		run("yun heal")
		busytest(qxxbt.startcheck)
		return
	end
	if (me.hp["pot"]>(me.hp["potmax"]/2) and qxxbt.expfirst==false) or qxxbt.limit then
		-- 去用潜能
		if me.score["gold"]>10 then		-- literate
			if (me.skills["literate"]["lv"]==nil or me.skills["literate"]["lv"]<30) then	-- xue xiucai
				qxxbt.masterid="xiucai"
				qxxbt.masterplace=819
			elseif me.skills["literate"]["lv"]<100 then												-- xue ouyang
				qxxbt.masterid="ouyang"
				qxxbt.masterplace=83
			else																										-- xue zhuxi
				qxxbt.masterid="zhu"
				qxxbt.masterplace=1020
			end
		else											-- xue master
			qxxbt.masterid=me.masterid
			qxxbt.masterplace=me.masterroom
		end
		qxxbt.limit=false
		qxxbt.gomaster()
	else
		-- 去放蛇
		if me.hp["neili"]<=(me.hp["neilimax"]*8/5) then
			do_dazuo(me.hp["neilimax"]*8/5, "neili",qxxbt.start,qxxbt.start)
			return
		else
			if me.hp["qi"]<100 then
				delay(15,qxxbt.startcheck)
			else
				qxxbt.gonpc()
			end
		end
	end
end
		
function qxxbt.gomaster()
	do_walkgo(qxxbt.masterplace,qxxbt.learnmaster,qxxbt.gomaster)
end
function qxxbt.gosleep()
	do_walkgo(37,qxxbt.dosleep,qxxbt.gosleep)
end
function qxxbt.dosleep()
	run("sleep")
end

function qxxbt.wakeup(n,l,w)
	do_walkgo(qxxbt.keplace,qxxbt.start,qxxbt.start)
end

function qxxbt.learnmaster()
	if qxxbt.masterid=="xiucai" or qxxbt.masterid=="ouyang" or qxxbt.masterid=="zhu" then
		do_qxuexi(qxxbt.masterid,"literate",nil,10,qxxbt.gosleep,qxxbt.gosleep)
	else
		do_qxuexi(qxxbt.masterid,nil,nil,10,qxxbt.gosleep,qxxbt.gosleep)
	end
end

function qxxbt.gonpc()
	local where=0
	qxxbt.nowplace=qxxbt.nowplace+1
	
	if qxxbt.nowplace>#qxxbt.npcplace then qxxbt.nowplace=1 end
	where=qxxbt.npcplace[qxxbt.nowplace][1]
		
	do_walkgo(where,qxxbt.findnpc,qxxbt.gonpc)
end
function qxxbt.findnpc()
	local msg_tri={
		"你对着"..qxxbt.npcplace[qxxbt.nowplace][3].."狠狠的一锤当头敲下，狞笑道：你给我发呆去吧！",
		"你要对谁做 idle 这个动作？",
	}

	local _ftri=linktri(msg_tri)
	qxxbt.sucked=false
	run("yield yes;idle "..qxxbt.npcplace[qxxbt.nowplace][2])
	wait.make(function()
		local l,w=wait.regexp(_ftri,2)
		if l==nil then
			--wait.time(1)
			qxxbt.findnpc()
			return
		end
		if findstring(l,msg_tri[1]) then
			-- 开始抽血吧
			qxxbt.train()
			return
		end
		if findstring(l,msg_tri[2]) then
			qxxbt.gonpc()
			return
		end
	end)
end

function qxxbt.train()
	if qxxbt.sucked==false then
		run("convert staff;attack "..qxxbt.npcplace[qxxbt.nowplace][2])
		delay(2,qxxbt.train)
	else
		run("score;cha;hp")
		do_walkgo(qxxbt.keplace,qxxbt.startcheck,qxxbt.train)
	end
end

function qxxbt.trainsuck()
	qxxbt.sucked=true
end

function qxxbt.joblimit()
	qxxbt.limit=true
end

function qxxbt.update()
	addtri("qxxbt_trainsuck","^(> > |> |)结果怪蛇一口咬住(.+)的咽喉，猛猛地吸起血来。","q_xxbt","qxxbt.trainsuck")
	addtri("qxxbt_traindie","^(> > |> |)(.+)倒在地上，挣扎了几下就死了。","q_xxbt","qxxbt.trainsuck")
	addtri("qxxbt_wakeup","^(> > |> |)你一觉醒来，只觉精力充沛。该活动一下了。","q_xxbt","qxxbt.wakeup")
	addtri("qxxbt_joblimit","^(> > |> |)你忽然心里一阵说不出的疲惫，可能是最近喂蛇太多了","q_xxbt","qxxbt.joblimit")
	
end
--[[
--这里并无此人！
#CLASS {FStrain}
#TRIGGER {你目前还没有任何为 startfs 的变量设定。} {per=0;pernpc=0;badfs=0;jiajin basic;idle @npcid}
#TRIGGER {@npcname倒在地上，挣扎了几下就死了。} {idle @npcid}
#TRIGGER {你对着@npcname狠狠的一锤当头敲下，狞笑道：你给我发呆去吧！} {#ti 1 {convert staff;attack @npcid};#ts 2}
#TRIGGER {你要对谁做 idle 这个动作？} {#t- fstrain
@backfs
#wa 1000
#NOP add fsdidian 1
startfs}
#TRIGGER {结果怪蛇一口咬住@npcname的咽喉，猛猛地吸起血来。} {stop she;convert she;tj=1;hp;#t+ fsback;#t- fstrain;#ti 1 {h;w;wu};#ts 1}
#TRIGGER {^???你运功完毕，深深吸了口气，站了起来。} {hp;#if @qirate<100 {yun heal};#if @qi<@max_qi*4/5 {yun recover};#if (@now_neili<@max_neili*5/3) {dazuo 300} {set startfs}}
#TRIGGER {你忽然心里一阵说不出的疲惫，可能是最近喂蛇太多了} {badfs=1}
#TRIGGER {你刚刚压制住身上伤势，还是不要妄动真气。} {#t- FStrain;#wa 1000;#t+ FStrain;yun heal}
--]]