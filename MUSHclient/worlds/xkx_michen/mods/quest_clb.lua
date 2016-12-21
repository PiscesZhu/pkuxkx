---------------------------------------------------------------------------
-- File name   : quest_clb.lua
-- Description : 长乐帮任务机器人
--
-- Author: Michen (xmichen@gmail.com)
-- Version:	2014.05
---------------------------------------------------------------------------

qclb={}

qclb.collect_id=nil
qclb.collect_room=0
qclb.score=0
qclb.learnskill=nil

--[[
祁连山碎石沙路
1348
1349
祁连山螳螂岭
1346
祁连山萧家桥
1374
祁连山紫柏坡
1344
福建泉州弥陀岩
1284
福建泉州山路
1286
1287
1290
--/d/shaolin/yidao
华山村南村口
821
华山村黄土路
936
藏边大雪山山路
942
944
611
612 --maybe bug
终南山小路
607
937
--]]
qclb.start=function()
	qclb.update()
	trigrpon("q_clb")
	run("score;cha;jifa;hp")
	busytest(qclb.do_check)
end

qclb.do_check=function()
	if me.skills["huagong-dafa"]==nil or me.skills["huagong-dafa"]["lv"]<=80 then
		qclb.learnskill="huagong-dafa"
	elseif me.skills["poison"]==nil or me.skills["poison"]["lv"]<=80 then
		qclb.learnskill="poison"
	elseif me.skills["force"]==nil or me.skills["force"]["lv"]<=80 then
		qclb.learnskill="force"
	elseif me.skills["chousui-zhang"]==nil or me.skills["chousui-zhang"]["lv"]<=80 then
		qclb.learnskill="chousui-zhang"
	elseif me.skills["sanyin-zhua"]==nil or me.skills["sanyin-zhua"]["lv"]<=80 then
		qclb.learnskill="sanyin-zhua"
	elseif me.skills["zhaixinggong"]==nil or me.skills["zhaixinggong"]["lv"]<=80 then
		qclb.learnskill="zhaixinggong"
	elseif me.skills["dodge"]==nil or me.skills["dodge"]["lv"]<=80 then
		qclb.learnskill="dodge"
	elseif me.skills["strike"]==nil or me.skills["strike"]["lv"]<=80 then
		qclb.learnskill="strike"
	elseif me.skills["claw"]==nil or me.skills["claw"]["lv"]<=80 then
		qclb.learnskill="claw"
	elseif me.skills["parry"]==nil or me.skills["parry"]["lv"]<=80 then
		qclb.learnskill="parry"
	elseif me.skills["tianshan-zhang"]==nil or me.skills["tianshan-zhang"]["lv"]<=80 then
		qclb.learnskill="tianshan-zhang"
	elseif me.skills["staff"]==nil or me.skills["staff"]["lv"]<=80 then
		qclb.learnskill="staff"
	end
	if qclb.score>=100 and me.menpai=="xx" then
		print("去帮主那边学学")
		run("n;n;n")
		run("ask situ about skills")
		busytest(qclb.learnBZ)
		return
	end
	if me.hp["pot"]>(me.hp["potmax"]/2) and me.masterroom~=nil then
		print("去用潜能")
		qclb.gomaster()
		return
	end
	qclb.askjob()
end

qclb.askjob=function()
	local askjob_tri={
		"^贝海石说道：你去把(.+)找来。$",
		"^贝海石说道：(.+)不是刚问过我吗？$",
		"^贝海石说道：(.+)这个月还没有交摊费，快去要来",
		"^贝海石说道：你去把(.+)的(.+)杀了。$",
		"对方正忙着呢，你等会儿在问话吧。",
		"^贝海石说道：(.+)莫非是想打听我帮的秘密吧。",
		"^贝海石说道：去踩盘的弟兄们回来讲，(.+)的镖车将经过(.+)。",
		"这里没有 bei haishi 这个人。",
	}
	local l_tri=linktri(askjob_tri)
	run("ask bei haishi about job")
	wait.make(function()
		local l,w=wait.regexp(l_tri,2)
		if l==nil then
			print("ask job 意外错误！！！！！")
			busytest(qclb.askjob)
			return
		end
		if string.find(l,"不是刚问过我吗？") or string.find(l,"对方正忙着呢，你等会儿在问话吧。") or string.find(l,"这里没有 bei haishi 这个人") then
			--do_dazuo(me.hp["neili"]+10, "neili", qclb.askjob, qclb.askjob)
			run("dazuo 20")
			busytest(qclb.askjob)
		end
		if string.find(l,"^贝海石说道：你去把(.+)找来。$") then
			qclb.lastjobtime=os.time()
			infoNote("exp", l)
			print("找东西去："..w[3])
			run("dazuo 20")
			busytest(qclb.askjob)
			--do_dazuo(me.hp["neili"]+10, "maxneili", qclb.askjob, qclb.askjob)
			--tprint(w)
		end
		if string.find(l,"^贝海石说道：(.+)这个月还没有交摊费，快去要来") then
			qclb.lastjobtime=os.time()
			infoNote("exp", l)
			--tprint(w)
			print("要钱去："..w[5])
			qclb.do_gocollect(w[5])
		end
		if string.find(l,"^贝海石说道：你去把(.+)的(.+)杀了。$") then
			qclb.lastjobtime=os.time()
			infoNote("exp", l)
			print("杀人去："..w[6].." 的 "..w[7])
			local where=findnpcinroom(w[7])
			infoNote("exp","找到以下房间ID："..where)
			run("dazuo 20")
			busytest(qclb.askjob)
			--do_dazuo(me.hp["neili"]+10, "neili", qclb.askjob, qclb.askjob)
			--tprint(w)
		end
		if string.find(l,"^贝海石说道：(.+)莫非是想打听我帮的秘密吧。") then
			run("n;n;n;ask situ heng about join;s;s;s")
			busytest(qclb.askjob)
		end
		if string.find(l,askjob_tri[7]) then
			qclb.lastjobtime=os.time()
			infoNote("exp", l)
			print("截镖去："..w[10].." 的 "..w[9])
			local wherejb=fjarea(w[10])
			local where=findroomno(wherejb["name"], wherejb["zone"])
			infoNote("exp","找到以下房间ID："..where)
			run("dazuo 20")
			busytest(qclb.askjob)
		end
	end)
end

function qclb.do_gocollect(place)
	qclb.collect_id=nil
	qclb.collect_room=0
	if place=="扬州客店" then
		qclb.collect_id="xiao er"
		qclb.collect_room=955
	elseif place=="扬州醉仙楼" then
		qclb.collect_id="xian laoban"
		qclb.collect_room=947
	elseif place=="扬州打铁铺" then
		qclb.collect_id="wang tiejiang"
		qclb.collect_room=1023
	elseif place=="扬州药铺" then
		qclb.collect_id="ping yizhi"
		qclb.collect_room=1024
	elseif place=="扬州钱庄" then
		qclb.collect_id="huang zhen"
		qclb.collect_room=1028
	elseif place=="扬州杂货铺" then
		qclb.collect_id="yang yongfu"
		qclb.collect_room=1019
	elseif place=="扬州书院" then
		qclb.collect_id="zhu xi"
		qclb.collect_room=0				-- 这小伙子整天教学，全是BUSY状态，不做了，1020
	elseif place=="扬州当铺" then
		qclb.collect_id="tang nan"
		qclb.collect_room=1017
	elseif place=="扬州聚金阁" then
		qclb.collect_id="niu zhanggui"
		qclb.collect_room=992
	elseif place=="扬州丽春院" then
		qclb.collect_id="wei chunfang"
		qclb.collect_room=996
	elseif place=="扬州高升酒馆" then
		qclb.collect_id="xiao er"
		qclb.collect_room=994
	elseif place=="扬州果品摊" then
		qclb.collect_id="xiao fan"
		qclb.collect_room=1003
	elseif place=="扬州马厩" then
		qclb.collect_id="ma fu"
		qclb.collect_room=959
	elseif place=="长白山香肉馆" then
		qclb.collect_id="lao ban"							-- 非GB要过河，GB进去会被赶出来，不做
		qclb.collect_room=0
	elseif place=="大理薛记成衣铺" then
		qclb.collect_id="xue laoban"
		qclb.collect_room=283
	elseif place=="大理药铺" then
		qclb.collect_id="he hongyao"
		qclb.collect_room=282
	elseif place=="大理石铺" then
		qclb.collect_id="shi jiang"
		qclb.collect_room=284
	elseif place=="大理太和居" then
		qclb.collect_id="song laoban"
		qclb.collect_room=280
	elseif place=="大理马厩" then
		qclb.collect_id="ma fu"
		qclb.collect_room=212
	elseif place=="峨嵋山草棚" then
		qclb.collect_id="xiao fan"
		qclb.collect_room=615
	elseif place=="佛山英雄会馆" then
		qclb.collect_id="feng yiming"
		qclb.collect_room=103
	elseif place=="佛山英雄楼" then
		qclb.collect_id="feng qi"
		qclb.collect_room=105
	elseif place=="佛山油条铺" then
		qclb.collect_id="wang laohan"
		qclb.collect_room=109
	elseif place=="佛山英雄典当" then
		qclb.collect_id="lao chaofeng"
		qclb.collect_room=111
	elseif place=="杭州天外天客店" then
		qclb.collect_id="xiao er"
		qclb.collect_room=1257
	elseif place=="杭州铁匠铺" then
		qclb.collect_id="ou yezi"
		qclb.collect_room=1256
	elseif place=="杭州楼外楼" then
		qclb.collect_id="xiao er"
		qclb.collect_room=1255
	elseif place=="兰州铁面当铺" then
		qclb.collect_id="lao chaofeng"
		qclb.collect_room=1387
	elseif place=="兰州杂货铺" then
		qclb.collect_id="xiao fan"
		qclb.collect_room=1387
	elseif place=="兰州羊肉馆" then
		qclb.collect_id="xiao er"
		qclb.collect_room=1384
	elseif place=="古浪皮货药材店" then
		qclb.collect_id="huo ji"
		qclb.collect_room=1399
	elseif place=="古浪学馆" then
		qclb.collect_id="lao xiucai"
		qclb.collect_room=1398
	elseif place=="永登客店" then
		qclb.collect_id="xiao er"
		qclb.collect_room=1389
	elseif place=="永登马厩" then
		qclb.collect_id="ma fu"
		qclb.collect_room=1390
	elseif place=="泉州鸿福楼" then
		qclb.collect_id="xiao er"
		qclb.collect_room=19
	elseif place=="泉州马厩" then
		qclb.collect_id="ma fu"
		qclb.collect_room=21
	elseif place=="泉州杂货铺" then
		qclb.collect_id="chen apo"
		if me.score["sex"]~=nil and me.score["sex"]~=1 then
			qclb.collect_room=27
		else
			qclb.collect_room=0						--27  男的进不去，不做
		end
	elseif place=="泉州学堂" then
		qclb.collect_id="ouyang zhan"
		qclb.collect_room=83
	elseif place=="泉州鸿翔绸缎庄" then
		qclb.collect_id="xu laoban"
		qclb.collect_room=71
	elseif place=="泉州万国烟雨楼" then
		qclb.collect_id="xiao er"
		qclb.collect_room=72
	elseif place=="泉州淘然茶居" then
		qclb.collect_id="tao lao"
		qclb.collect_room=59
	elseif place=="泉州打铁铺" then
		qclb.collect_id="tie jiang"
		qclb.collect_room=58
	elseif place=="华山村马厩" then
		qclb.collect_id="ma fu"
		qclb.collect_room=830
	elseif place=="华山村杂货店" then
		qclb.collect_id="li si"
		qclb.collect_room=831
	elseif place=="华山村草棚" then
		qclb.collect_id="seller"
		qclb.collect_room=837
	elseif place=="华山村铁匠铺" then
		qclb.collect_id="feng"
		qclb.collect_room=833
	elseif place=="华山村私塾" then
		qclb.collect_id="lao xiucai"
		qclb.collect_room=819
	elseif place=="华山玉泉院" then
		qclb.collect_id="li tiezui"
		qclb.collect_room=922
	elseif place=="伊犁马厩" then
		qclb.collect_id="ma fu"
		qclb.collect_room=1332
	elseif place=="伊犁巴扎" then
		qclb.collect_id="maimaiti"
		qclb.collect_room=1334
	end
	if qclb.collect_room>0 then
		me.expcheck=1
		run("hp")
		do_walkgo(qclb.collect_room,0,qclb.do_collect,qclb.go_bei)
	else
		busytest(qclb.start)
	end
end

qclb.go_bei= function()
	qclb.getscore()
	do_walkgo(1102,0,qclb.start,qclb.go_bei)
end

qclb.do_collect=function()
	local job_tri={
		"你太累了，先歇会儿。",
		
		".*对你说道：(.+)辛苦了，这一点摊费是小的该付的。",
		
		"你刚向此人要过钱。",
		"你还是等此人醒来后再收括钱吧。",
		"此人正忙着。",
		".*大怒道：什么(.+)，还不快滚！！！",
		
		"你现在没有帮务缠身。",
		"你当前的帮务不是收摊费。",
		"收什么摊费？",
		"帮令岂能瞎用？",
		"你已经不是此帮的人了。",
		"你要向谁收括钱？",
		"这儿没有这个人。",
		"你找错人了。",
		"你还没到(.+)收什么摊费？",
	}
	local l_tri=linktri(job_tri)
	run("collect "..qclb.collect_id)
	wait.make(function()
		local l,w=wait.regexp(l_tri,2)
		if l==nil then
			print("超时")
			busytest(qclb.do_collect)
			return
		end
		if findstring(l,job_tri[1]) then
		--if string.find(l,"你太累了，先歇会儿。") then
			run("yun refresh;yun regenerate")
			busytest(qclb.do_collect)
		end
		if findstring(l,job_tri[3],job_tri[4],job_tri[5],job_tri[6]) then
		--if string.find(l,"你刚向此人要过钱。") or string.find(l,"你还是等此人醒来后再收括钱吧。") or string.find(l,"此人正忙着。") or string.find(l,"大怒道：什么") then
			busytest(qclb.do_collect)
		end
		if findstring(l,job_tri[7],job_tri[8],job_tri[9],job_tri[10],job_tri[11],job_tri[12],job_tri[13],job_tri[14],job_tri[15]) then
			qclb.go_bei()
		end
		
		if findstring(l,job_tri[2]) then
		--if string.find(l,"辛苦了，这一点摊费是小的该付的。") then
			me.expcheck=1
			local f=function()
				local msg="本次工作获得经验"..me.addexp.."点，潜能"..me.addpot.."点。"
				print(msg)
				infoNote("exp", msg)
				qclb.go_bei()
			end
			gethp(f)
		end
	end)
end

qclb.getscore=function()
	local job_tri={
		"你挣了(.+)点功劳点。",
	}
				
	local l_tri=linktri(job_tri)
	run("find score ")
	wait.make(function()
		local l,w=wait.regexp(l_tri,2)
		if l==nil then
			qclb.score=0
			return
		end
		if findstring(l,job_tri[1]) then
			qclb.score=ctonum(w[3])
		end
	end)
end

qclb.learnBZ=function()
	local learn_tri={
		".*瞎了眼没见我正忙着？！",													-- 等会继续学

		".*你先歇会儿吧。",																-- 吸口气继续学
		
		".*司徒横大怒道：快滚！我只教星宿弟子功夫！",						-- 不学了，走人
		".*你还没征求帮主同意呢。",
		".*你听了帮主的指导，对「",	
		
		".*居然超过老子了。",
		".*摇了摇头道：你得去门派中正式拜师才能继续提高",
		".*摇了摇头道：帮主没学过。",
	}
	local _ftri=linktri(learn_tri)
	run("xue "..qclb.learnskill)
	wait.make(function()
		local l,w=wait.regexp(_ftri,5)
		if l==nil then
			busytest(learnBZ)
			--do_dazuo(me.hp["neili"]+10,"neili",qclb.learnBZ,qclb.learnBZ)
			return
		end
		if findstring(l,learn_tri[1]) then
			busytest(learnBZ)
			--do_dazuo(me.hp["neili"]+10,"neili",qclb.learnBZ,qclb.learnBZ)
			return
		end
		if findstring(l,learn_tri[2]) then
			run("yun regenerate")
			delay(10, qclb.learnBZ)
			return
		end
		if findstring(l,learn_tri[3],learn_tri[4],learn_tri[5],learn_tri[6],learn_tri[7],learn_tri[8]) then
			qclb.getscore()
			run("s;s;s")
			busytest(qclb.start)
			return
		end
	end)
end

qclb.gomaster=function()
	do_walkgo(me.masterroom,0,qclb.learn,qclb.gomaster)
end

qclb.learn=function()
	do_qxuexi(me.masterid,nil,nil,10,qclb.go_sleep,qclb.go_sleep)
end
qclb.go_sleep=function()
	do_walkgo(1108,0,qclb.sleep,qclb.go_sleep)
end
qclb.sleep=function()
	run("sleep")
end

qclb.is_wakeup=function(n,l,w)
	run("e;ask situ about 香主;e;drink zhou;drink zhou")
	qclb.go_bei()
end

qclb.update=function()
	addtri("qclb_wakeup","^(> > |> |)你一觉醒来，只觉精力充沛。该活动一下了。$","q_clb","qclb.is_wakeup")
end