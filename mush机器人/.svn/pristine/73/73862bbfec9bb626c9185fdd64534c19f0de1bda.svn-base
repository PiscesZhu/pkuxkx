mp_bt={}
mp_bt_pre={}
mp_bt_start={}
mp_bt_watch={}

function alias.searchxy1()
	xy.findxy=0
	xy.roomno=0
	run("look;set searchxy=1801")
	roomono_now=1801
	run("open door;d;set searchxy=2024")
	roomono_now=2024
	run("n;set searchxy=2025")
	roomono_now=2025
	run("open door;d;set searchxy=2026")
	roomono_now=2026
	run("open door;u;set searchxy=2025")
	roomono_now=2025
	run("s;set searchxy=2024")
	roomono_now=2024
	run("open door;u;set searchxy=1801")
	roomono_now=1801
	run("e;set searchxy=1800")
	roomono_now=1800
	run("e;set searchxy=1799")
	roomono_now=1799
	run("e;set searchxy=1798")
	roomono_now=1798
	run("n;set searchxy=1807")
	roomono_now=1807
	run("nw;set searchxy=1808")
	roomono_now=1808
	run("se;set searchxy=1807")
	roomono_now=1807
	run("s;set searchxy=1798")
	roomono_now=1798
	run("e;set searchxy=1797")
	roomono_now=1797
	run("set searchxy=step1")
end
function alias.searchxy2()
	xy.findxy=0
	xy.roomno=0
	run("look;set searchxy=1797")
	roomono_now=1797
	run("n;set searchxy=1809")
	roomono_now=1809
	run("n;set searchxy=1810")
	roomono_now=1810
	run("s;set searchxy=1809")
	roomono_now=1809
	run("s;set searchxy=1797")
	roomono_now=1797
	run("ed;set searchxy=1811")
	roomono_now=1811
	run("nw;set searchxy=1812")
	roomono_now=1812
	run("n;set searchxy=1813")
	roomono_now=1813
	run("nw;set searchxy=1814")
	roomono_now=1814
	run("e;set searchxy=1815")
	roomono_now=1815
	run("w;set searchxy=1814")
	roomono_now=1814
	run("se;set searchxy=1813")
	roomono_now=1813
	run("s;set searchxy=1812")
	roomono_now=1812
	run("se;set searchxy=1811")
	roomono_now=1811
	run("e;set searchxy=1816")
	roomono_now=1816
	run("set searchxy=step2")
end
function alias.searchxy3()
	xy.findxy=0
	xy.roomno=0
	run("look;set searchxy=1816")
	roomono_now=1816
	run("w;set searchxy=1811")
	roomono_now=1811
	run("wu;set searchxy=1797")
	roomono_now=1797
	run("s;set searchxy=1806")
	roomono_now=1806
	run("sw;set searchxy=1805")
	roomono_now=1805
	run("nw;set searchxy=1802")
	roomono_now=1802
	run("sw;set searchxy=1804")
	roomono_now=1804
	run("ne;set searchxy=1802")
	roomono_now=1802
	run("w;set searchxy=1803")
	roomono_now=1803
	run("e;set searchxy=1802")
	roomono_now=1802
	run("n;set searchxy=1798")
	roomono_now=1798
	run("w;set searchxy=1799")
	roomono_now=1799
	run("w;set searchxy=1800")
	roomono_now=1800
	run("w;set searchxy=1801")
	roomono_now=1801
	run("set searchxy=step3")
end
------------------------------------------------------------------------------------
-- mp_bt_pre
------------------------------------------------------------------------------------
function mp_bt_pre.dosomething1(n,l,w)
	local _f,a,b,c
	wait.make(function()
		if findstring(l,"  巡庄武师 辛遗%(Xin yi%)") then
			xy.findxy=1
		end
		a,b,c=string.find(l,"你目前还没有任何为 searchxy=(%d+) 的变量设定。")
		if c~=nil and tonumber(c)>0 then
			if xy.findxy>0 and xy.roomno==0 then
				xy.roomno=tonumber(c)
				print("在"..tostring(xy.roomno).."发现辛遗")
			end
		end
		if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
			if not isopen("boat") then
				if roomno_now==me.menpaiJobStart then
					xy.findxy=0
					if mpweapon=="staff" then alias.wi(staffid) else alias.wi(mpweapon) end
					_f=function() alias.searchxy1() end
					wait.time(1);_f()
				else alias.flytoid(me.menpaiJobStart) end
			end
		end
		if findstring(l,"你目前还没有任何为 checkexpover=mp 的变量设定。") then
			alias.resetidle()
			if xy.xyLimited>0 and xy.biteLimited>0 then xy.limitedResume=xy.limitedResume+1 end
			alias.checkbusy("xy")
		end
		if findstring(l,"你目前还没有任何为 searchxy=false 的变量设定。") then
			alias.resetidle()
			alias.startworkflow()
		end
		if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
			alias.resetidle()
			if mpJobLimited>0 then alias.startworkflow() else alias.dz(set_neili) end
		end
		if findstring(l,"数码世界，数字地图，"..tostring(me.menpaiJobStart).."就是这里！") then
			alias.resetidle()
			needquit=0
			if not isopen("dazuo") then
				if mpweapon=="staff" then alias.wi(staffid) else alias.wi(mpweapon) end
				_f=function() alias.searchxy1() end
				wait.time(2);_f()
			end
		end
		if findstring(l,"你目前还没有任何为 searchxy=step1 的变量设定。") then
			alias.yjl()
			if xy.findxy>0 then
				print("目标房间："..tostring(xy.roomno))
				closeclass("mp_bt_pre")
				openclass("mp_bt_start")
				xy.name=""
				alias.flytoid(xy.roomno)
			else
				if havefj>0 then alias.startworkflow()
				else
					_f=function() alias.searchxy2() end
					wait.time(2);_f()
				end
			end
		end
		if findstring(l,"你目前还没有任何为 searchxy=step2 的变量设定。") then
			alias.yjl()
			if xy.findxy>0 then
				print("目标房间："..tostring(xy.roomno))
				closeclass("mp_bt_pre")
				openclass("mp_bt_start")
				xy.name=""
				alias.flytoid(xy.roomno)
			else
				if havefj>0 then alias.startworkflow()
				else
					_f=function() alias.searchxy3() end
					wait.time(2);_f()
				end
			end
		end
		if findstring(l,"你目前还没有任何为 searchxy=step3 的变量设定。") then
			alias.yjl()
			if xy.findxy>0 then
				print("目标房间："..tostring(xy.roomno))
				closeclass("mp_bt_pre")
				openclass("mp_bt_start")
				xy.name=""
				alias.flytoid(xy.roomno)
			else run("set searchxy=false") end
		end
		if findstring(l,"你目前还没有任何为 busyover=xy 的变量设定。") then
			alias.yjl()
			alias.et()
			run("get gold from corpse")
			alias.startworkflow()
		end
	end)
end
------------------------------------------------------------------------------------
-- mp_bt_start
------------------------------------------------------------------------------------
function mp_bt_start.dosomething1(n,l,w)
	local _f,a,b,c,d,_tb
	if findstring(l,"对方正忙着呢，你等会儿在问话吧。") then
		wait.make(function()
			_f=function()
						alias.resetidle()
						run("ask xin yi about 外敌入侵")
				end
			wait.time(1);_f()
		end)
	end
	a,b,c=string.find(l,"看起来(.+)想杀死你！")
	if c~=nil then
		if string.len(xy.name)==0 then
			xy.name=c
			run("id here")
		end
	end
	a,b,c,d=string.find(l,xy.name.."%s+=%s+(%w+) (%w+), %w+")
	if c~=nil and d~=nil and xy.name~="辛遗" and xy.name~="" then
		xy.id=string.lower(c).." "..string.lower(d)
		alias.resetidle()
		run("hp")
		openclass("kill")
		run("set no_parry 1")
		openclass("kill_"..me.menpai)
		closeclass("kill_run")
		AddTimer("kill_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "kill.timer")
		SetTimerOption("kill_timer", "group", "kill")
		runaway=false
		npcfaint=false
		killRunSuccess=false
		killid=xy.id
		killname=xy.name
		killskill=mpweapon
		killpfm=mppfm
		killyun=mpyun
		killjiali=mpjiali
		killjiajin=mpjiajin
		run("jiali "..mpjiali..";jiajin "..mpjiajin)
		wait.make(function()
			_f=function()
						_tb=utils.split(mpyun,"|")
						for k,v in ipairs(_tb) do run(v) end
						if xy.pfm() then
							if mpweapon=="staff" then alias.wi(staffid) else alias.wi(mpweapon) end
						else alias.uw() end
						run("kill "..xy.id..";convert staff;attack "..xy.id)
						if xy.pfm() then
							_tb=utils.split(mppfm,"|")
							run(_tb[pfmid].." "..xy.id)
						end
				end
			wait.time(1.5);_f()
		end)
	end
	if findstring(l,"这里没有 xin yi 这个人。") then
		closeclass("mp_bt_start")
		openclass("mp_bt_pre")
		run("set searchxy=false")
	end
	if findstring(l,"数码世界，数字地图，"..tostring(xy.roomno).."就是这里！") then
		alias.resetidle()
		if not isopen("dazuo") then run("ask xin yi about 外敌入侵") end
	end
	if findstring(l,"你目前还没有任何为 killover= 的变量设定。","你目前还没有任何为 killover=yes 的变量设定。") then
		closeclass("mp_bt_start")
		openclass("mp_bt_pre")
		alias.checkexp("mp")
	end
	if findstring(l,"杖对你而言太重了。") then
		alias.close_kill()
		needquit=1
		alias.flytoid(1803)
	end
	if findstring(w[0],"你向辛遗打听有关「外敌入侵」的消息。\n辛遗说道：您说的是，这里可不能让外敌进入。") then
		closeclass("mp_bt_start")
		openclass("mp_bt_pre")
		run("set searchxy=false")
	end
end
------------------------------------------------------------------------------------
-- mp_bt_watch
------------------------------------------------------------------------------------
function mp_bt_watch.dosomething1(n,l,w)
	local a,b,c
	if findstring(l,"你忽然心里一阵说不出的疲惫，可能是最近喂蛇太多了。") then
		if xy.xyLimited>0 then xy.biteLimited=1 end
		if xy.xyLimited>0 and (xy.limitedResume+1)>=5 then
			mpJobLimited=1
			print("统计到的xy+bite上限为："..tostring(mpLimited.mpexp))
			mpLimited.MarkExp=tonumber(mpLimited.mpexp)
			run("perform heji")
			if mpLimited.MarkTime<(os.time()-3600) then
				-- #if @debug {#say 到xy时间却仍然busy，推迟2分钟}
				mpLimited.MarkTime=tonumber(os.time()-3600+120)
			end
		end
	end
	if findstring(l,"你心中感觉到一阵厌烦，看来是应该去换点别的工作做了。") then
		xy.xyLimited=1
		if xy.biteLimited>0 and (xy.limitedResume+1)>=5 then
			mpJobLimited=1
			print("统计到的xy+bite上限为："..tostring(mpLimited.mpexp))
			mpLimited.MarkExp=tonumber(mpLimited.mpexp)
			run("perform heji")
			if mpLimited.MarkTime<(os.time()-3600) then
				-- #if @debug {#say 到xy时间却仍然busy，推迟2分钟}
				mpLimited.MarkTime=tonumber(os.time()-3600+120)
			end
		end
	end
	if findstring(l,"你只觉得“神门穴”上一阵酸麻，手指无力，.+杖拿捏不稳，抛在地下！","你只觉得手中.+杖把持不定，脱手飞出！","你.+臂麻木，哐当一声，.+杖掉到了地上。") then
		if not isopen("kill") then
			run("hp")
			openclass("kill")
			run("set no_parry 1")
			openclass("kill_"..me.menpai)
			closeclass("kill_run")
			AddTimer("kill_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "kill.timer")
			SetTimerOption("kill_timer", "group", "kill")
			runaway=false
			npcfaint=false
			killRunSuccess=false
			killid=""
			killname=""
			killskill=mpweapon
			killpfm=mppfm
			killyun=mpyun
			killjiali=mpjiali
			killjiajin=mpjiajin
			run("jiali "..fjjiali..";jiajin "..fjjiajin)
			have.staff=have.staff-1
			wieldweapon=1
			getweapon=1
		end
	end
	if findstring(l,"只听见.+一声，你手中的.+杖已经断为两截！") then
		if not isopen("kill") then
			run("hp")
			openclass("kill")
			run("set no_parry 1")
			openclass("kill_"..me.menpai)
			closeclass("kill_run")
			AddTimer("kill_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "kill.timer")
			SetTimerOption("kill_timer", "group", "kill")
			runaway=false
			npcfaint=false
			killRunSuccess=false
			killid=""
			killname=""
			killskill=mpweapon
			killpfm=mppfm
			killyun=mpyun
			killjiali=mpjiali
			killjiajin=mpjiajin
			run("jiali "..fjjiali..";jiajin "..fjjiajin)
			have.staff=have.staff-1
			wieldweapon=1
		end
	end
	if findstring(l,"你.+臂麻木，无力再使.+") then
		if not isopen("kill") then
			run("hp")
			openclass("kill")
			run("set no_parry 1")
			openclass("kill_"..me.menpai)
			closeclass("kill_run")
			AddTimer("kill_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "kill.timer")
			SetTimerOption("kill_timer", "group", "kill")
			runaway=false
			npcfaint=false
			killRunSuccess=false
			killid=""
			killname=""
			killskill=mpweapon
			killpfm=mppfm
			killyun=mpyun
			killjiali=mpjiali
			killjiajin=mpjiajin
			run("jiali "..fjjiali..";jiajin "..fjjiajin)
			--if jifa.forcename=="xuanyinzhenqi" then alias.jfhbmz() else Execute("/alias.jf"..me.menpai.."()") end
		end
	end
	if findstring(l,"数码世界，数字地图，1803就是这里！") then
		if needquit>0 then
			openclass("quit")
			stat.quiting=0
		end
	end
	if findstring(l,"结果怪蛇一口咬住"..xy.name.."的咽喉，猛猛地吸起血来。") then
		if xy.checkfirstbite>0 then xy.checkfirstbite=0 end
	end
	if findstring(l,"你手握蛇杖手舞足蹈，好像发疯一般。") then
		run("convert staff")
	end
	if findstring(l,"这里空气不好，不能打坐。") then
		alias.flytoid(1801)
	end
	a,b,c=string.find(l,"通过击杀入侵来的名门正派，你获得(%d+)点实战经验！")
	if c~=nil then
		xy.xyexp=tonumber(c)
	end
	if findstring(w[0],"你向辛遗打听有关「外敌入侵」的消息。\n辛遗说道：让我先喘口气………\n辛遗说道：刚才的贼人可吓死我了……您亲手把他除掉了么？") then
		needquit=1
		alias.flytoid(1803)
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function mp_bt.update()
	local  mp_bt_pre_triggerlist={
	       {name="mp_bt_pre_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_bt_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_bt_pre_triggerlist) do
		addtri(v.name,v.regexp,"mp_bt_pre",v.script,v.line)
	end
	closeclass("mp_bt_pre")
	
	local  mp_bt_start_triggerlist={
	       {name="mp_bt_start_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_bt_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_bt_start_triggerlist) do
		addtri(v.name,v.regexp,"mp_bt_start",v.script,v.line)
	end	
	local _tb2={
		"你向辛遗打听有关「外敌入侵」的消息。\\n辛遗说道：您说的是，这里可不能让外敌进入。\\Z",
	}
	local  mp_bt_start_m_triggerlist={
	       {name="mp_bt_start_m_dosth2",line=2,regexp=linktri2(_tb2),script=function(n,l,w)    mp_bt_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_bt_start_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_bt_start",v.script,v.line)
	end
	closeclass("mp_bt_start")
	
	local  mp_bt_watch_triggerlist={
	       {name="mp_bt_watch_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_bt_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_bt_watch_triggerlist) do
		addtri(v.name,v.regexp,"mp_bt_watch",v.script,v.line)
	end	
	local _tb3={
		"你向辛遗打听有关「外敌入侵」的消息。\\n辛遗说道：让我先喘口气………\\n辛遗说道：刚才的贼人可吓死我了……您亲手把他除掉了么？\\Z",
	}
	local  mp_bt_watch_m_triggerlist={
	       {name="mp_bt_watch_m_dosth3",line=3,regexp=linktri2(_tb3),script=function(n,l,w)    mp_bt_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_bt_watch_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_bt_watch",v.script,v.line)
	end
	closeclass("mp_bt_watch")
end
mp_bt.update()

