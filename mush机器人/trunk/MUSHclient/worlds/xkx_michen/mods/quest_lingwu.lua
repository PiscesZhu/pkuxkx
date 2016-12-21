---------------------------------------------------------------------------
-- File name   : quest_lingwu.lua
-- Description : 早先写的古墓采蜜之后去学习技能的部分
--						JOB全部采用模块化之后，这个也要改改了
--
-- Author: Michen (xmichen@gmail.com)
-- Version:	2014.05
---------------------------------------------------------------------------
qlingwu={}

qlingwu["ok"]=nil
qlingwu["fail"]=nil

local lwnum=1

-- 开始领悟
qlingwu.start=function()
	quest.stop=false
	qlingwu.update()
	trigrpon("q_qlingwu")
	run("set brief 1;score;cha;jifa;hp")
	local Ic=Item.new()
	Ic:CatchStart()
	busytest(do_lingwu)
end

qlingwu["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(qlingwu[s])
	end
	
	trigrpoff("q_qlingwu")
	qlingwu["ok"]=nil
	qlingwu["fail"]=nil
end

-- 开始领悟
do_lingwu=function(qlingwu_ok,qlingwu_fail)
	qlingwu["ok"]=qlingwu_ok
	qlingwu["fail"]=qlingwu_fail
	call(qlingwu.main)
end

-- 领悟主函数
qlingwu.main=function()
	if quest.stop then
		qlingwu["end"]()
		return
	end
	gethp(qlingwu.check)
end

-- 领悟过程
function qlingwu.check()
	if me.hp["jing"]<=(me.hp["jingmax"]*2/3) then
		run("yun regenerate")
	end
	if me.hp["neili"]<=(me.hp["neilimax"]*8/5) then
		do_dazuo(me.hp["neilimax"]*8/5, "neili", qlingwu.main)
		return
	end
	if me.hp["pot"]>0 then
		run("read "..Xue_skills[lwnum])
		busytest(qlingwu.main)
	else
		call(qlingwu.backjob)
	end
end

function qlingwu.is_lingwu_full()
	lwnum=lwnum+1
	if Xue_skills[lwnum]==nil then
		-- 所有技能都学完了，回去工作吧
		busytest(qlingwu.backjob)
	end
end
function qlingwu.is_lingwu_done()
	lwnum=1
	-- 潜能用光了，回去工作吧
	busytest(qlingwu.backjob)
end

qlingwu.backjob=function()
	trigrpoff("q_qlingwu")
	run("w;n;n;n")
	qgmcaimi.start()
end

qlingwu.allstop=function()
	quest.stop=true
end

qlingwu.resume=function()
	Note("==::::已经手动继续领悟！::::==")
	quest.stop=false
	qlingwu.update()
	trigrpon("q_qlingwu")
	run("cha;jifa;hp")
	busytest(qlingwu.main)
end

----------------------------
AddAlias("alias_lingwu_start","#lingwu","",alias_flag.Enabled + alias_flag.Replace,"qlingwu.start")
AddAlias("alias_lingwu_stop","#lwstop","",alias_flag.Enabled + alias_flag.Replace,"qlingwu.allstop")

AddAlias("alias_lingwu_continue","#lwgoon","",alias_flag.Enabled + alias_flag.Replace,"qlingwu.resume")

SetAliasOption("alias_lingwu_start","group","job_lingwu");
SetAliasOption("alias_lingwu_stop","group","job_lingwu");
SetAliasOption("alias_lingwu_continue","group","job_lingwu")

----------------------------
qlingwu.update=function()
	addtri("is_lingwu_full","^(> |)你对着石壁琢磨了一回儿，觉得石壁上对(\\S+)的记载对你来说太浅显了。","q_qlingwu","qlingwu.is_lingwu_full")
	addtri("is_lingwu_full1","^(> |)也许是缺乏实战经验，你对石壁上面所绘的(\\S+)总是无法领会。","q_qlingwu","qlingwu.is_lingwu_full")
	addtri("is_lingwu_done","^(> |)你的潜能不够！","q_qlingwu","qlingwu.is_lingwu_done")
end


