---------------------------------------------------------------------------
-- File name   : michen_fight.lua
-- Description : 打架部份，目前只做了kill模块，而且PFM部份处理不是很满意
--
-- Author: Michen (xmichen@gmail.com)
-- Version:	2014.05
---------------------------------------------------------------------------

--[[
这里面要有所有技能的状态触发，用来标识技能使用状态
KILL的函数里面，只在一个循环周期进行hp;set no_more killnpc的检查
根据不同的技能状态，HP状态，选择使用不同的命令
do_killnpc(blocker_name, blocker_id,true,false,1,0,alias.blocker_ok,alias,blocker_fail)
上面为主调用函数，参数分别为：NPC名字，NPC ID，是否使用PFM击杀，是否throw NPC，杀完之后调用的函数，杀人失败时调用的函数
--]]

print("Loading Michen fight mod OK!")

fight={
	npcname=nil,												-- NPC 中文名
	npcid=nil,														-- NPC ID
	usepfm=false,												-- 是否使用PFM
	usethrow=false,
	throwing="coin",
	jiajin=1,
	jiali=0,
	
	run=false,													-- 是否要跑路
	yunbusy=0,
	rejiajin=false,												-- 是否要加精
	reyun=false,												-- 是否要运心法
	npcfaint=false,												-- NPC是否晕了
	safego=nil,
	safeback=nil,
}

function fight:finish()
end
function fight:fail()
end

fight_end_ok=function()
	trigrpoff("q_fight")
	trigrpoff("q_fight_escape")
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
	fight.finish()
end
fight_end_fail=function()
	trigrpoff("q_fight")
	trigrpoff("q_fight_escape")
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
	fight.fail()
end

function do_killnpc(npcname,npcid,usepfm,throw,jiajin,jiali,fight_ok,fight_fail)
	if fight_ok~=nil then
		fight.finish=function()
			fight_ok()
		end
	else fight.finish=nil end
	if fight_fail~=nil then
		fight.fail=function()
			fight_fail()
		end
	else fight.fail=nil end
	
	if usepfm~=nil then fight.usepfm=usepfm end
	if npcname==nil or npcid==nil then
		print("你要杀谁？？？")
		fight_end_fail()
		return
	end
	fight.jiajin=jiajin
	fight.jiiali=jiali
	fight.usethrow=throw
	fight.npcname=npcname
	fight.npcid=npcid
	fight.npcfaint=false
	fight.run=false
	fight.ryunbusy=0
	fight.rrejiajin=false												-- 是否要加精
	fight.rreyun=false												-- 是否要运心法
	fight.safego=nil
	fight.safeback=nil
	
	fight.update()
	trigrpon("q_fight")
	
	fight.pre()
end

function fight.pre()
	run("halt;yun recover;yun regenerate;yun refresh")
	local Ic=Item.new()
	Ic:CatchStart()
	Ic.CatchEnd=function(pp)
		gethp(fight.do_pre)
	end
end

function fight.do_pre()													-- 打架前的准备工作			这里只做一些最基本的检查，YUN HEAL要不要都要考虑下
	if me.hp["qi_percent"]<10 or me.hp["jing_percent"]<10 then							-- 这都快死了吧。。。
		print("你自己都快挂了，还打个毛线啊？")
			fight_end_fail()
		return
	end
	if me.hp["qi_percent"]<100 then
		run("yun heal")
		busytest(fight.pre)
	end
	if fight.usepfm then							-- 这里要分门派使用不同的yun 技能，要看看是不是需要做手动配置？
		run(GetVariable("yun"))
	end
	if usethrow then
		if me.items["coin"]~=nil and me.items["coin"]>=1 then
			fight.throwing="coin"
		elseif me.items["silver"]~=nil and me.items["silver"]>=1 then
			fight.throwing="silver"
		elseif me.items["gold"]~=nil and me.items["gold"]>=1 then
			fight.throwing="gold"
		else
			usethrow=false
		end
	end
	run("jiajin "..fight.jiajin)
	run("jiali "..fight.jiali)
	if usethrow then
		run("throw "..fight.throwthing.." at "..fight.npcid)
	else
		run("kill "..fight.npcid)
	end
	fight.do_fight()
end

function fight.do_fight()
	local fight_tri={
		'设定环境变量：no_more = "killnpc"$',
	}
	local _ftri=linktri(fight_tri)
	run("hp;set no_more killnpc")
	wait.make(function()
		local l,w=wait.regexp(_ftri,3)
		if l==nil then
			--wait.time(2)
			fight.do_fight()
			return
		end
		----------------------------------------------------------------------
		---- 击杀NPC过程中的定时检查开始
		----------------------------------------------------------------------
		if findstrlist(l,fight_tri) then
			-- 如果武器没装备，并且身上没有相应武器，halt,捡起来，再装备
			-- 如果武器没装备，并且身上有相应武器，直接装备
			-- 如果halt过，这里要重新kill
			-- 如果eff_qi<60，标记为要跑路
			if me.hp["qi_percent"]<60 then
				print("受伤严重，准备跑路！！！！")
				fight.run=true
			end
			if me.hp["jingli"]<(me.hp["jinglimax"]*2/3) and me.hp["neili"]<500 then
				print("精力不足，准备跑路！！！！")
				fight.run=true
			end
			if me.hp["neili"]<(me.hp["neilimax"]/10) then
				print("内力不足，准备跑路！！！！")
				fight.run=true
			end
			if fight.yunbusy>=3 and (me.hp["jingli"]<(me.hp["jinglimax"]/3) or me.hp["qi"]<(me.hp["qimax"]*100/me.hp["qi_percent"]/2)) then
				print("yunbusy严重，准备跑路！！！！")
				fight.run=true
			end
			if fight.run then	-- 开始跑路！
				trigrpon("q_fight_escape")
				fight.escape()
			else						-- 正常打
				if me.hp["qi"]<(me.hp["qimax"]*100/me.hp["qi_percent"]/2) then run("yun recover") end
				if me.hp["jing"]<(me.hp["jingmax"]/2) then run("yun regenerate") end
				if me.hp["jingli"]<(me.hp["jinglimax"]/3) then
					run("jiajin basic")
					if me.hp["jiajl"]>50 then fight.rejiajin=true end
				end
				if me.hp["jingli"]<(me.hp["jinglimax"]/2) then run("yun refresh") end
				if fight.reyun then
					-- 运心法 循环心法变量，YUN
					run(GetVariable("yun"))
				end
				if fight.npcfaint==false then
					run(GetVariable("pfm"))
				end
			end
		end
		wait.time(2)
		fight.do_fight()
		----------------------------------------------------------------------
		---- 击杀NPC过程中的定时检查结束
		----------------------------------------------------------------------
	end)
end

function fight.escape()
	fight.safego=SafeEntrance(roomno_now)
	fight.safeback=opposite_dir(exits)
	if exits~=nil then
		run("halt;"..fight.safego..";18mo "..fight.npcid)
	else
		fight.fight_escape2()
	end
end

function fight.fight_npcfaint(n,l,w)
	if w[2]==fight.npcname then
		fight.npcfaint=true
		run("jiajin basic;jiali 0")
		if usethrow then
			fight.safego=SafeEntrance(roomno_now)
			fight.safeback=opposite_dir(exits)
			run("halt;get armor from "..fight.npcid..";drop armor;drop armor;drop gold;get "..fight.npcid)
			run(fight.safego)
			run("drop "..fight.npcid)
			run(fight.safeback)
			run("get gold;get armor;wear armor")
			busytest(fight_end_ok)
		end
	end
end
function fight.fight_npcdie(n,l,w)
	if w[2]==fight.npcname then
		fight.npcfaint=true
		run("jiajin basic;jiali 0")
		print("杀人完毕")
		busytest(fight_end_ok)
	end
end
function fight.fight_escape1(n,l,w)
	print("逃跑成功")
	fight_end_fail()
end
function fight.fight_escape2(n,l,w)
	if fight.run then
		run("look;set resetSafe=yes")
	end
end
function fight.fight_escape7(n,l,w)
	local index=math.random(1,#roominfo["exits"])
	fight.safego=roominfo["exits"][index]
	fight.safeback=opposite_dir(exits)
end
function fight.fight_escape3(n,l,w)
	run("halt;"..fight.safego..";18mo "..fight.npcid)
end
function fight.fight_escape4(n,l,w)
	print("无法逃，需要退出")
	do_quit()
end
function fight.update()
	addtri("fight_npcfaint","^(> > |> |)(.+)脚下一个不稳，跌在地上昏了过去。$","q_fight","fight.fight_npcfaint")
	addtri("fight_npcdie","^(> > |> |)(.+)倒在地上，挣扎了几下就死了。$","q_fight","fight.fight_npcdie")
	
	addtri("fight_escape1","^(> > |> |)你要对谁做 18mo 这个动作？$","q_fight_escape","fight.fight_escape1")
	addtri("fight_escape2","^(> > |> |)这个方向没有出路。$","q_fight_escape","fight.fight_escape2")
	addtri("fight_escape3","^(> > |> |)你哼了一声，问(.+)道：「你会唱“十八摸”罢？唱一曲来听听。$","q_fight_escape","fight.fight_escape3")
	addtri("fight_escape4","^(> > |> |)草寇向你一阵阴笑：爽快的将宝贝交出来，不然叫你后悔莫及！$","q_fight_escape","fight.fight_escape4")
	addtri("fight_escape5","^(> > |> |)山贼大吼道：赶快将宝贝交出来，不然你就别指望活着离开！$","q_fight_escape","fight.fight_escape4")
	addtri("fight_escape6","^(> > |> |)星宿派弟子恶狠狠地威胁道：快将宝贝交出来，否则取你狗命！$","q_fight_escape","fight.fight_escape4")
	addtri("fight_escape7","^(> > |> |)你目前还没有任何为 resetSafe=yes 的变量设定。$","q_fight_escape","fight.fight_escape7")
end
