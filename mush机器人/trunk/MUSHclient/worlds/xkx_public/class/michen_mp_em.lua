mp_em={}
mp_em_pre={}
mp_em_start={}
mp_em_watch={}

if per==nil then per={} end
per.findnpc=0
------------------------------------------------------------------------------------
-- mp_em_pre
------------------------------------------------------------------------------------
function mp_em_pre.dosomething1(n,l,w)
	local _tb
	if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
		if not isopen("boat") then
			alias.resetidle()
			alias.startworkflow()
		end
	end
	if findstring(l,"你目前还没有任何为 searchnpc=yes 的变量设定。") then
		if per.findnpc>0 then
			run("put fuling in yaodai")
			alias.yjl()
			closeclass("mp_"..me.menpai.."_pre")
			openclass("mp_"..me.menpai.."_start")
			run("jiali "..tostring(mpjiali)..";jiajin "..tostring(mpjiajin))
			if string.len(mpweapon)>0 then
				if mpweapon=="staff" then alias.wi(staffid) else alias.wi(mpweapon) end
			else alias.uw() end
			_tb=utils.split(mpyun,"|")
			for k,v in ipairs(_tb) do run(v) end
			run("kill "..per.npcid)
			_tb=utils.split(mppfm,"|")
			for k,v in ipairs(_tb) do run(v.." "..per.npcid) end
			run("halt;persuade "..per.npcid)
		else
			run(per.way)
			run("set searchnpc=yes")
		end
	end
	if findstring(l,"你目前还没有任何为 checkhp=addneili 的变量设定。") then
		if havefj>0 and hp.neili>(hp.maxneili*set_neili_job/100) then alias.tdz() end
	end
	if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
		alias.flytoid(me.menpaiJobStart)
	end
	if findstring(l,"你目前还没有任何为 checkexpover=mp 的变量设定。") then
		alias.resetidle()
		if (add.exp>10 and mpLimited.MarkExp<me.menpaiLimited) then mpLimited.MarkExp=tonumber(me.menpaiLimited) end
		alias.checkbusy("per")
	end
	if findstring(l,"数码世界，数字地图，"..tostring(me.menpaiJobStart).."就是这里！") then
		alias.resetidle()
		run("get fuling from yaodai")
		alias.yunem()
		per.findnpc=0
		run(per.way..";set searchnpc=yes")
	end
	if findstring(l,"你目前还没有任何为 busyover=per 的变量设定。") then
		alias.yjl()
		alias.uw()
		if hp.neili<(hp.maxneili*set_neili_job/100) then alias.dz(set_neili)
		else
			alias.yunem()
			alias.startworkflow()
		end
	end
end
------------------------------------------------------------------------------------
-- mp_em_start
------------------------------------------------------------------------------------
function mp_em_start.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"对手正欲取其性命，若听你劝岂不是要见阎王了。") then
			_f=function() run("kill "..per.npcid..";halt;persuade "..per.npcid) end
			wait.time(1);_f()
		end
		if findstring(w[0],"对你理也不理","你刚劝服过他，想必这次不会再听你劝了。","你正在劝服别人！","你身行向后一跃，跳出战圈不打了。\n你现在正忙着！") then
			_f=function() run("halt;persuade "..per.npcid) end
			wait.time(2);_f()
		end
		if findstring(l,"你目前还没有任何为 checkhp=per 的变量设定。") then
			run("hp")
			if hp.qi<(hp.maxqi*100/hp.healthqi/2) then run("yun recover") end
			if hp.jingli<(hp.maxjingli/5) then alias.yjl() end
		end
		if findstring(l,"山贼死了！","星宿弟子死了！","草寇死了！","马贼死了！","山贼突然卖一破绽，跳出战圈，逃了","星宿弟子突然卖一破绽，跳出战圈，逃了","草寇突然卖一破绽，跳出战圈，逃了","马贼突然卖一破绽，跳出战圈，逃了") then
			run("halt;persuade "..per.npcid)
		end
		if findstring(l,"只见.+往后一纵，说道：好！.+良言相劝，暂且罢手。","只见.+往后一纵，说道：好！.+在此相劝，看在人家的面子上，这次就算了。") then
			per.findnpc=0
			openclass("mp_"..me.menpai.."_pre")
			closeclass("mp_"..me.menpai.."_start")
			alias.checkbusy("per")
		end
		if findstring(l,"受到你佛法感招，决定罢手不斗。") then
			per.findnpc=0
			openclass("mp_"..me.menpai.."_pre")
			closeclass("mp_"..me.menpai.."_start")
			alias.checkexp("mp")
		end
		if findstring(l,"你想劝服谁？") then
			per.findnpc=0
			openclass("mp_"..me.menpai.."_pre")
			closeclass("mp_"..me.menpai.."_start")
			alias.startworkflow()
		end
	end)
end
function mp_em_start.timer()
	run("set checkhp=per")
end
------------------------------------------------------------------------------------
-- mp_em_watch
------------------------------------------------------------------------------------
function mp_em_watch.dosomething1(n,l,w)
	if findstring(l,"你劝着劝着，忽然觉得神困体乏，看来需要休息一段时间了。") then
		mpJobLimited=1
		print("统计到的per上限为："..tostring(mpLimited.mpexp))
		mpLimited.MarkExp=mpLimited.mpexp
		if mpLimited.MarkTime<(os.time()-3600) then
			-- #if @debug {#say 到per时间却仍然busy，推迟2分钟}
			mpLimited.MarkTime=tonumber(os.time()-3600+120)
		end
	end
	if findstring(l,"「慢着！」，一个星宿派弟子走了出来，拦住了.+。","突然一个大汉从石坊后闪了出来拦住.+，竟是一个山贼！","突然一个大汉由西边的树林跳了出来，拦住了.+。","只听得一阵播草声，一个草寇自草堆里钻了出来拦住.+。","草寇向你一阵阴笑：爽快的将宝贝交出来，不然叫你后悔莫及！","马贼凶巴巴地叫道：放聪明点，快将宝贝交出来！ ","山贼大吼道：赶快将宝贝交出来，不然你就别指望活着离开！","星宿派弟子恶狠狠地威胁道：快将宝贝交出来，否则取你狗命！") then
		per.findnpc=1
	end
	if findstring(l,"你太累了，休息一会儿再劝吧") then
		run("yun regenerate;halt;persuade"..per.npcid)
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function mp_em.update()
	local  mp_em_pre_triggerlist={
	       {name="mp_em_pre_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_em_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_em_pre_triggerlist) do
		addtri(v.name,v.regexp,"mp_em_pre",v.script,v.line)
	end
	closeclass("mp_em_pre")
	
	local  mp_em_start_triggerlist={
	       {name="mp_em_start_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_em_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_em_start_triggerlist) do
		addtri(v.name,v.regexp,"mp_em_start",v.script,v.line)
	end
	local _tb2={
		"你身行向后一跃，跳出战圈不打了。\\n你现在正忙着！\\Z",
	}
	local  mp_em_start_m_triggerlist={
	       {name="mp_em_start_m_dosth2",line=2,regexp=linktri2(_tb2),script=function(n,l,w)    mp_em_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_em_start_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_em_start",v.script,v.line)
	end
	AddTimer("mp_em_start_timer", 0, 0, 3, "", timer_flag.Enabled + timer_flag.Replace, "mp_em_start.timer")
	SetTimerOption("mp_em_start_timer", "group", "mp_em_start")
	closeclass("mp_em_start")
	
	local  mp_em_watch_triggerlist={
	       {name="mp_em_watch_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_em_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_em_watch_triggerlist) do
		addtri(v.name,v.regexp,"mp_em_watch",v.script,v.line)
	end	
	closeclass("mp_em_watch")
end
mp_em.update()

