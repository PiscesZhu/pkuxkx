---------------------------------------------------------------------------
-- File name   : quest_gumu_caimi.lua
-- Description : GUMU任务一模块
--
-- Author: Michen (xmichen@gmail.com)
-- Version:	2014.05
---------------------------------------------------------------------------

-- 地图位置 737   636

qgmcaimi={}

qgmcaimi["gotmi"]=0
qgmcaimi["yufeng_keep"]=5	-- 身上保留多少个玉蜂浆

function qgmcaimi:finish()
end
function qgmcaimi:fail()
end

qgmcaimi.end_ok=function()
	trigrpoff("q_qgmcaimi")
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
	qgmcaimi.finish()
end
qgmcaimi.end_fail=function()
	trigrpoff("q_qgmcaimi")
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
	qgmcaimi.fail()
end

function do_gmcaimi(job_ok,job_fail)
	if job_ok~=nil then
		qgmcaimi.finish=function()
			job_ok()
		end
	else qgmcaimi.finish=nil end
	if job_fail~=nil then
		qgmcaimi.fail=function()
			job_fail()
		end
	else qgmcaimi.fail=nil end
	qgmcaimi.start()
end

-- 开始任务
qgmcaimi.start=function()
	quest.stop=false
	qgmcaimi.update()
	trigrpon("q_qgmcaimi")
	me.items["yufeng jiang"]=0
	run("set brief 2;score;cha;jifa;hp")
	local Ic=Item.new()
	Ic:CatchStart()
	qgmcaimi["gotmi"]=0
	busytest(qgmcaimi.main)
end

--[[
-- 开始采蜜
do_gmcaimi=function(qgmcaimi_ok,qgmcaimi_fail)
	qgmcaimi["ok"]=qgmcaimi_ok
	qgmcaimi["fail"]=qgmcaimi_fail
	call(qgmcaimi.main)
end
--]]
-- 采蜜主函数
qgmcaimi.main=function()
	if quest.stop then
		qgmcaimi.end_fail()
		return
	end
	me.expcheck=1
	gethp(qgmcaimi.check)
end

-- 检查潜能
function qgmcaimi.checkpot()
	if (Xue_first==True and me.hp["pot"]>=(me.hp["potmax"]*4/5)) then
		trigrpoff("q_qgmcaimi")
		-- 如果潜能达到上限，并且是学习优先，就要去用潜能了
		if Pot_use=="lw" then
			run("s;w;w;w;enter guan;turn left")
			-- 开始领悟
		elseif Pot_use=="xue" then
			run("s;s;e")
			-- 去学习
			qlingwu.start()
		elseif Pot_use=="lit" then
			-- 学读书写字去
		end
	else
		-- 继续工作
		run("n")
		busytest(qgmcaimi.main)
	end
end
-- 采蜜过程
function qgmcaimi.check()
	if qgmcaimi["gotmi"]==0 then
		run("yun refresh;collect")
		wait.make(function()
			local l,w=wait.regexp('^(> |)什么？$', 1)
			if l~=nil then
				Note("地点可能错误了，无法采蜜，需要重新定位。")
				qgmcaimi.end_fail()
				return
			else
				busytest(qgmcaimi.check)
			end
		wait.time(1)
		end)
	end
	if qgmcaimi["gotmi"]==1 then
		qgmcaimi["gotmi"]=0
		me.expcheck=1
		run("s;pour bottle;hp")
		
		-- 检查身上还有没有玉蜂浆，没有就拿一瓶
		local Ic=Item.new()
		Ic:CatchStart()
		Ic.CatchEnd=function(pp)
			msg="GM caimi job:本次工作获得经验"..me.addexp.."点，潜能"..me.addpot.."点。"
			print(msg)
			infoNote("exp", msg)
			if ((me.items["yufeng jiang"]==nil) or (me.items["yufeng jiang"]<qgmcaimi["yufeng_keep"])) then
				run("get yufeng jiang")
				run("search yufengjiang")
				run("n")
				busytest(qgmcaimi.end_ok)
			else
				run("n")
				busytest(qgmcaimi.end_ok)
			end
			-- 如果没有得到经验，就需要换工作了
			--gethp(qgmcaimi.checkpot)
		end
	end
	if qgmcaimi["gotmi"]==2 then
		-- 没有蜜可以采了，要么使用玉蜂浆，要么换工作
		local Ic=Item.new()
		Ic:CatchStart()
		Ic.CatchEnd=function(pp)
			if me.items["yufeng jiang"]~=nil and me.items["yufeng jiang"]>=1 then
				--print("有密")
				qgmcaimi["gotmi"]=0
				run("zhaofeng")
				busytest(qgmcaimi.check)		-- 继续工作
			else
				--print("有你妹")
				-- 换工作！
				qgmcaimi.end_fail()
			end
		end
	end
end

function qgmcaimi.is_collect_done()
	qgmcaimi["gotmi"]=1
end
function qgmcaimi.is_collect_none()
	qgmcaimi["gotmi"]=2
end

qgmcaimi.allstop=function()
	quest.stop=true
end

----------------------------
AddAlias("alias_GMcaimi_start","#gmcaimi","",alias_flag.Enabled + alias_flag.Replace,"qgmcaimi.start")
AddAlias("alias_GMcaimi_stop","#gmcaimistop","",alias_flag.Enabled + alias_flag.Replace,"qgmcaimi.allstop")

AddAlias("alias_GMcaimi_continue","#gmcaimigoon","",alias_flag.Enabled + alias_flag.Replace,"qgmcaimi.resume")

SetAliasOption("alias_GMcaimi_start","group","job_GMcaimi");
SetAliasOption("alias_GMcaimi_stop","group","job_GMcaimi");
SetAliasOption("alias_GMcaimi_continue","group","job_GMcaimi")
----------------------------

qgmcaimi.update=function()
	addtri("is_collect_done","^(> |)你弄了很久，终于装满了一瓶蜂蜜。","q_qgmcaimi","qgmcaimi.is_collect_done")
	addtri("is_collect_done1","^(> |)你已经收集了一瓶玉蜂浆了，快放到厨房去吧。","q_qgmcaimi","qgmcaimi.is_collect_done")
	addtri("is_collect_none","^(> |)蜂巢中似乎已经没有蜂蜜了。","q_qgmcaimi","qgmcaimi.is_collect_none")
end

