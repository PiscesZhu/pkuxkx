---------------------------------------------------------------------------
-- File name   : quest_gumu.lua
-- Description : 古墓派全自动机器人
--
-- Author: Michen (xmichen@gmail.com)
-- Version:	2014.05
---------------------------------------------------------------------------

-- 采蜜地点		2076
-- 领悟地点		2065
-- LOVE地点		607

qgm={}
qgm.JOBD={}
qgm.JOBD.gumu_love=0
qgm.JOBD.gumu_love_limit=false
qgm.JOBD.caimi=0
qgm.JOBD.caimi_limit=false

function qgm.start()
	-- 开始部份可以挂一个计时器，每1分钟检查一次
	-- 如果任务时间到了，设定标记，从LINGWU模块跳出
	
	AddTimer("gm_job_check",0,1,0,"", timer_flag.Enabled,"qgm.gm_job_check")
	qgm.check()
end

function qgm.gm_job_check()
	-- GM的主要任务已经过了10分钟，可以去做了
	if (os.time()-qgm.JOBD.gumu_love)>600 then
		me.canjob=true
		return
	end
	-- 采蜜时间重置，可以做采蜜任务了
	if (os.time()-qgm.JOBD.caimi)>1800 then
		qgm.JOBD.caimi_limit=false
		me.canjob=true
		return
	end
end

function qgm.startlingwu()
	do_lw(qgm.lw_over,qgm.lw_over)
end

function qgm.startlove()
	--do_gmlove(qgm.job1_over,qgm.job1_fail)
end

function qgm.startcaimi()
	do_gmcaimi(qgm.job2_over,qgm.job2_fail)
end

function qgm.check()
	run("get ji from he;drink ji;put ji in he")
	-- 如果潜能优先经验，这边就检查一下，如果潜能满了，就先去用潜能
	
	
	-- LOVE任务每十分钟做一次，如果达到上限了，要过一个小时再搞
	--if JOBD.gumu_love_limit==false and (os.time()-qgm.JOBD.gumu_love)>600 then
	-- 感觉好象没必要，反正老是遇到有毒的，先试试每十分钟就做一次吧
	if (os.time()-qgm.JOBD.gumu_love)>600 then
		do_walkgo(607,qgm.startlove,qgm.startlove)
		--run("w;w;enter guan;turn left;d;ed;ed;ed;e;eu;out;n;e;se;e;s")
		--do_gmlove(qgm.job1_over,qgm.job1_fail)
		return
	end
	-- 这里任务达到上限之后，以最后一次的任务时间算起，等一个小时，不知道合理不合理
	if qgm.JOBD.caimi_limit==false or (qgm.JOBD.caimi_limit==true and (os.time()-qgm.JOBD.caimi)>1800) then
		do_walkgo(2076,qgm.startcaimi,qgm.startcaimi)
		--run("e;n;n")
		--do_gmcaimi(qgm.job2_over,qgm.job2_fail)
		return
	end
	-- 这边是正常去使用潜能的部份
	if me.hp["pot"]>20 then
		do_walkgo(2065,qgm.startlingwu,qgm.startlingwu)
	else
		do_dazuo(1, "maxneiliadd",qgm.check,qgm.check)
	end
	--run("w;w;enter guan;turn left")
	--do_lw(qgm.lw_over,qgm.lw_over)
end

function qgm.lw_over()
	--run("u;e;e")
	if qlw.skill==nil or qlian.skill==nil then
		do_dazuo(1, "maxneiliadd",qgm.check,qgm.check)
	else
		busytest(qgm.check)
	end
	--busytest(qgm.check)
end

function qgm.job1_over()
	qgm.JOBD.gumu_love=os.time()
	if me.addexp<100 then
		qgm.JOBD.gumu_love_limit=true
	end
	--run("n;w;nw;w;s;enter;wd;w;wu;wu;wu;u;u;e;e")
	busytest(qgm.check)
end

function qgm.job1_fail()
	qgm.JOBD.gumu_love=os.time()
	--run("n;w;nw;w;s;enter;wd;w;wu;wu;wu;u;u;e;e")
	busytest(qgm.check)
end

function qgm.job2_over()
	qgm.JOBD.caimi=os.time()
	if me.addexp<10 then
		qgm.JOBD.caimi_limit=true
	end
	--run("n;n;s;s;w")
	busytest(qgm.check)
end

function qgm.job2_fail()
	qgm.JOBD.caimi=os.time()
	--run("n;n;s;s;w")
	busytest(qgm.check)
end