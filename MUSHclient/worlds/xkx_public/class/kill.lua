-- 看不懂的话千万别乱改，谢谢罗~

kill={}
kill_run={}
kill_dl={}
kill_gb={}
kill_hs={}
kill_qz={}
kill_sl={}
kill_bt={}
kill_xs={}
kill_em={}
kill_gm={}
kill_xx={}

------------------------------------------------------------------------------------
-- kill
------------------------------------------------------------------------------------
function kill.timer()
	if isopen("mp_mj_yudi") then mj.ydnpc=0;run("look") end
	run("hp;set check=kill")
end
function kill.dokill(id,name,class)
	if isopen("kill") or fjroomid>0 then
		alias.initialize_trigger()
		print("正在战斗！危险！退出重连！！")
		openclass("quit")
		stat.quiting=0
	else
		alias.initialize_trigger()
		if cm.doing~=nil and tonumber(cm.doing)>0 then
			print("冲脉中")
			run("halt;yun recover")
		end
		run("halt;halt")
		_tb=utils.split(fjyun,"|")
		for k,v in ipairs(_tb) do run(v) end
		reyun=0
		npcfaint=false
		killRunSuccess=false
		run("unset no_parry")
		openclass("kill")
		openclass("kill_"..me.menpai)
		closeclass("kill_run")
		AddTimer("kill_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "kill.timer")
		SetTimerOption("kill_timer", "group", "kill")
		runaway=false
		alias.uw()
		if me.menpai=="hs" and fjweapon~="" then
			if stat.leidong>0 then
				pfmid=2
				if fjweapon=="staff" then alias.wi(staffid) else alias.wi(fjweapon) end
			else
				pfmid=1
				alias.uw()
			end
		else
			pfmid=1
			if string.len(fjweapon)==0 then
				if fjweapon=="staff" then alias.wi(staffid) else alias.wi(fjweapon) end
			else alias.uw() end
		end
		killid=id
		killname=name
		killskill=fjweapon
		killpfm=fjpfm
		killyun=fjyun
		killjiali=fjjiali
		killjiajin=fjjiajin
		run("jiali "..fjjiali..";jiajin "..fjjiajin)
		if me.menpai=="bt" then run("convert staff;attack "..killid) end
		if me.menpai=="mj" then run("order fighter do attack "..killid..";order fighter 2 do attack "..killid) end
		run("kill "..killid)
		--_tb=utils.split(fjpfm,"|")
		--if pfmid<=table.getn(_tb) then if kmq() then alias.kmq() else run(_tb[pfmid].." "..killid) end end
		--_tb=utils.split(killpfm,"|")
		alias.pfm()
		openclass(class)
	end
end
function kill.dosomething1(n,l,w)
	local _tb,_f,a,b,c,_t
	if findstring(l,"你捡起一.+杖。") then have.staff=have.staff+1 end
	if findstring(l,"你捡起一.+剑。") then have.jian=have.jian+1 end
	if findstring(l,"你捡起一.+刀。") then have.dao=have.dao+1 end
	if findstring(l,"你捡起一.+棒。") then have.stick=have.stick+1 end
	if findstring(l,"你刚刚压制住身上伤势，还是不要妄动真气。") then yunbusy=yunbusy+1 end
	if findstring(l,"你目前还没有任何为 check=kill 的变量设定。") then
		if wieldweapon>0 and killskill~="" then
			if workflow.nowjob=="fj" or workflow.nowjob=="ftb" or workflow.nowjob=="mp" then _t=workflow.nowjob else _t="fj" end
			if have[_G[_t.."weapon"]]~=nil and have[_G[_t.."weapon"]]>0 then
				if killskill=="staff" then alias.wi(staffid) else alias.wi(killskill) end
			else
				rekill=1
				run("halt;get ".._G[_t.."weapon"])
			end
		end
		if rekill>0 then run("kill "..tostring(killid)) end
		if hp.healthqi<60 then runaway=true;print("受伤严重") end
		if (hp.jingli<(hp.maxjingli*2/3) and hp.neili<500) then runaway=true;print("没有精力") end
		if hp.neili<(hp.maxneili*2/10) then runaway=true;print("没有内力") end
		if (yunbusy>=3 and (hp.jingli<(hp.maxjingli/3) or hp.qi<(hp.maxqi*100/hp.healthqi/2)) and jifa.forcename~="huagongdafa") then runaway=true;print("yunbusy严重") end
		if not runaway then
			if me.menpai=="xx" and reyun>0 then run("yun hua") end
			if hp.qi<(hp.maxqi*100/hp.healthqi/2) and jifa.forcename~="huagongdafa" then run("yun recover") end
			if hp.jing<(hp.maxjing/2) then run("yun regenerate") end
			if hp.jingli<(hp.maxjingli*1/3) then
				run("jiajin basic")
				if hp.jiajin>50 then rejiajin=true end
			end
			if (me.menpai=="wd" and killskill=="jian") then
				-- 武当派用chan，运精力要特色处理
				if hp.jingli<(hp.maxjingli/3) then alias.yjl() end
			else
				if string.len(killskill)>0 then
					-- 使用武器时一般都jiajin max，所以要经常yjl
					if hp.jingli<(hp.maxjingli/2) then alias.yjl() end
				else
					-- 空手技能差不多没一半精力时再yjl
					if hp.jingli<(hp.maxjingli/2) then alias.yjl() end
				end
			end
			if reyun~=nil and reyun>0 then
				_tb=utils.split(killyun,"|")
				for k,v in ipairs(_tb) do run(v) end
			end
			_tb=utils.split(killpfm,"|")
			if pfmid==nil or pfmid>table.getn(_tb) then pfmid=1 end
			alias.pfm()
			--if not npcfaint and pfmid<=table.getn(_tb) and xy.pfm()>0 then
			--	if kmq() then alias.kmq() else run(_tb[pfmid].." "..killid) end
			--end
		else
			print("准备逃跑")
			if not isopen("kill_run") then
				openclass("kill_run")
				run("halt")
				if jifa.forcename=="motianyunqi" then run("yun shougong") end
				if me.menpai=="bt" then run("stop she;stop she;stop she;convert she") end
				run("go "..alias.SafeEntrance(roomno_now)..";18mo "..killid)
			end
		end
	end
	if findstring(l,"你转身不灵，难以闪避，只得挺右手相抵。到此地步，已是高手比拼真力。") then
		if not isopen("kill_run") then
			openclass("kill_run")
			if jifa.forcename=="motianyunqi" then run("yun shougong") end
			run("halt;go "..alias.SafeEntrance(roomno_now)..";18mo "..killid)
		end
	end
	a,b,c=string.find(l,"你(.+)")
	if c~=nil and	not findstring(c,"变量设定") then
		alias.resetidle()
	end
	if findstring(l,"你目前还没有任何为 busyover=killover 的变量设定。") then
		if skillslist["cuff"]==nil then skillslist["cuff"]={} end
		if skillslist["cuff"]["lvl"]==nil then skillslist["cuff"]["lvl"]=1 end
		if (me.xtbl+skillslist["cuff"]["lvl"]/10)==me.bl and me.menpai=="hs" then stat.leidong=0 end
		if jifa.forcename=="motianyunqi" then run("yun shougong") end
		if me.shen<0 and (me.menpai=="wd" or me.menpai=="em" or me.menpai=="qz") then
			closeclass("kill")
			openclass("quit")
			openclass("quitdis")
		elseif me.shen>0 and me.menpai=="xx" then
			closeclass("kill")
			openclass("quit")
			openclass("quitdis")
		else alias.killover() end
	end
	if findstring(l,"你所使用的外功中没有这种功能。") then
		_tb=utils.split(killpfm,"|")
		if findstring(_tb[pfmid],"leidong","jingmo","nian","qiankun","piaomiao") then alias.uw();return end
		if killskill=="staff" then alias.wi(staffid) else alias.wi(killskill) end
	end
	--if findstring(l,"你.+臂麻木，无力再使.+", "你请先用 enable 指令选择你要使用的外功。") then
	--	if jifa.forcename=="xuanyinzhenqi" then alias.jfhbmz() else Execute("/alias.jf"..me.menpai.."()") end
	--end
	if findstring(l,"你伸了伸腰，长长地吸了口气。") then
		if rejiajin then
			run("jiajin "..killjiajin)
			rejiajin=false
		end
	end
	if findstring(l,"你将.+剑插回剑鞘。","你将.+剑绕回腰间。","你将.+剑插入了剑鞘。") then alias.resetidle() end
	a,b,c=string.find(l,"只听见.+一声，你手中的(.+)已经断为两截！")
	if c~=nil then
		alias.resetidle()
		if findstring(c,"扁担","瑶琴","杖") then have.staff=have.staff-1 end
		if findstring(c,"剑") then have.jian=have.jian-1 end
		if findstring(c,"刀") then have.dao=have.dao-1 end
		if findstring(c,"棒") then have.stick=have.stick-1 end
		wieldweapon=1
	end
	a,b,c=string.find(l,"你只觉得“神门穴”上一阵酸麻，手指无力，(.+)拿捏不稳，抛在地下！")
	if c~=nil then
		alias.resetidle()
		if findstring(c,"扁担","瑶琴","杖") then have.staff=have.staff-1 end
		if findstring(c,"剑") then have.jian=have.jian-1 end
		if findstring(c,"刀") then have.dao=have.dao-1 end
		if findstring(c,"棒") then have.stick=have.stick-1 end
		wieldweapon=1
		getweapon=1
	end
	a,b,c=string.find(l,"你只觉得手中(.+)把持不定，脱手飞出！")
	if c~=nil then
		alias.resetidle()
		if findstring(c,"扁担","瑶琴","杖") then have.staff=have.staff-1 end
		if findstring(c,"剑") then have.jian=have.jian-1 end
		if findstring(c,"刀") then have.dao=have.dao-1 end
		if findstring(c,"棒") then have.stick=have.stick-1 end
		wieldweapon=1
		getweapon=1
	end
	a,b,c=string.find(l,"你只觉虎口一热，(.+)顿时脱手而出")
	if c~=nil then
		alias.resetidle()
		if findstring(c,"扁担","瑶琴","杖") then have.staff=have.staff-1 end
		if findstring(c,"剑") then have.jian=have.jian-1 end
		if findstring(c,"刀") then have.dao=have.dao-1 end
		if findstring(c,"棒") then have.stick=have.stick-1 end
		wieldweapon=1
		getweapon=1
	end
	a,b,c=string.find(l,"你.+臂麻木，哐当一声，(.+)掉到了地上。")
	if c~=nil then
		alias.resetidle()
		if findstring(c,"扁担","瑶琴","杖") then have.staff=have.staff-1 end
		if findstring(c,"剑") then have.jian=have.jian-1 end
		if findstring(c,"刀") then have.dao=have.dao-1 end
		if findstring(c,"棒") then have.stick=have.stick-1 end
		wieldweapon=1
		getweapon=1
	end
	if findstring(l,"这里没有这个人。") then
		if isopen("ftb_start") and not isopen("gps_dealwith") then
			-- 只有在做斧头帮时才处理这个。
			alias.resetidle()
			closeclass("kill")
			ftbnpcindex=ftbnpcindex+1
			_tb=utils.split(ftbnpcid,"|")
			if ftbnpcindex<=table.getn(_tb) then
				npcid=_tb[ftbnpcindex]
				_tb=utils.split(ftbnpcname,"|")
				npcname=_tb[ftbnpcindex]
				run("ask "..npcid.." about 刺客")
			else
				npcfind=0
				ftbnpcindex=1
				if cmd.nums<cmd.setnums then
					if string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end
				else
					wait.make(function()
						_f=function()
									if string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end
							end
						wait.time(1);_f()
					end)
				end
			end
		end
	end
	if findstring(l,"这里没有 "..tostring(killid).."。") then
		alias.resetidle()
		alias.checkbusy("killover")
	end
	if findstring(l,"「.+」只能在战斗中使用。") then alias.resetidle();run("kill "..killid) end
	a,b,c=string.find(l,"[> ]*(.+)深深吸了几口气，强行压制住了身上的伤势。")
	if c~=nil then
		alias.resetidle()
		if c==killname and not findstring(c,"幻影","->","：") then
			run("jiajin "..killjiajin..";jiali "..killjiali)
		end
	end
	a,b,c=string.find(l,"[> ]*(.+)倒在地上，挣扎了几下就死了。")
	if c==killname and c~=nil then
		alias.resetidle()
		if not findstring(c,"幻影","->","：") then
			run("jiajin basic;jiali 0;score")
			npcfaint=true
			alias.checkbusy("killover")
		end
	end
	a,b,c=string.find(l,"[> ]*(.+)已经陷入半昏迷状态，随时都可能摔倒晕去。")
	if c~=nil then
		alias.resetidle()
		if c==killname and not findstring(c,"幻影","->","：") and not npcfaint then
			if me.menpai=="sl" then run("jiajin 50") end
		end
	end
	a,b,c=string.find(l,"[> ]*(.+)脚下一个不稳，跌在地上昏了过去。")
	if c~=nil then
		alias.resetidle()
		if c==killname and not findstring(c,"幻影","->","：") then
			run("jiajin basic;jiali 0")
			npcfaint=true
			reyun=0
		end
	end
	if findstring(l,"你这招内劲所注，力道强横之极，.+竟将"..tostring(killname).."拦腰削成了上下两截！") then
		alias.resetidle()
		run("score")
		alias.checkbusy("killover")
	end
	if findstring(l,"你对著"..tostring(killname).."喝道：「.+」") then
		alias.resetidle()
		rekill=0
	end
	--if findstring(l,"你所使用的外功中没有这种功能。") then
	--	alias.resetidle()
	--	alias.uw(staffid)
	--	alias.uw("jian")
	--	alias.uw("dao")
	--	alias.uw("stick")
	--	alias.uw("qin")
	--end
	if findstring(l,"你已经装备著了。") then wieldweapon=0 end
	if findstring(l,"你.+握在手中","你.+取出白龙剑") then alias.resetidle();wieldweapon=0 end
	if killname==nil then killname="" end
	if findstring(l,"一个肥头大耳的家丁跑了过来，诡异的朝你一笑，熟练地拖走了"..tostring(killname).."的尸体。","[> ]*"..tostring(killname).."急急忙忙离开了。") then
		alias.resetidle()
		run("jiajin basic;jiali 0")
		npcfaint=true
		run("score")
		alias.checkbusy("killover")
	end
	if findstring(w[0],"看来该找机会逃跑了%.%.%.\n(%S+) %-") then
		-- 逃离打架现场，关闭Kill模块
		alias.yjl()
		run("yun recover")
		alias.close_kill()
		alias.startworkflow()
	end
end
------------------------------------------------------------------------------------
-- kill_run
------------------------------------------------------------------------------------
function kill_run.dosomething1(n,l,w)
	local _f,_tb,a,b,c
	wait.make(function()
		a,b,c=string.find(l,"^%s+这里唯一的出口是 (.+)。")
		if c~=nil then
			entrance=c
			xkxGPS.setEntrance(entrance)
		end
		a,b,c=string.find(l,"^%s+这里明显的出口是 (.+)。")
		if c~=nil then
			entrance=c
			xkxGPS.setEntrance(entrance)
		end
		if findstring(l,"草寇向你一阵阴笑：爽快的将宝贝交出来，不然叫你后悔莫及！","山贼大吼道：赶快将宝贝交出来，不然你就别指望活着离开！","星宿派弟子恶狠狠地威胁道：快将宝贝交出来，否则取你狗命！") then
			alias.initialize_trigger()
			print("无法逃，需要退出。")
			openclass("quit")
			stat.quiting=0
		end
		if findstring(l,"你哼了一声，问(.+)道：「你会唱“十八摸”罢？唱一曲来听听。」") then
			_f=function()
						run("halt")
						alias.yjl()
						run(safego..";18mo "..killid)
				end
			wait.time(0.2);_f()
		end
		if findstring(l,"你目前还没有任何为 resetSafe=yes 的变量设定。") then
			alias.resetidle()
			_tb=utils.split(xkxGPS.entrance,"|")
			safego=_tb[math.random(table.getn(_tb))]
			SafeBack=invDirection(safego)
		end
		if findstring(l,"你要对谁做 18mo 这个动作？") then
			if not killRunSuccess then
				print("逃跑成功！")
				alias.resetidle()
				alias.close_kill()
				if isopen("mp_dl_start") then dl.needquit=1 end
				alias.startworkflow()
			end
		end
		if findstring(l,"你在.+的耳边悄声说道：等着瞧，兔子！","有话慢慢说, 不要着急") then
			_f=function()
						_tb=utils.split(killid," ")
						run("halt;"..safego..";whisper ".._tb[1].." 等着瞧，兔子！")
				end
			wait.time(0.2);_f()
		end
		if findstring(l,"这个方向没有出路。") then
			if runaway then run("look;set resetSafe=yes") end
		end
	end)
end
------------------------------------------------------------------------------------
-- kill_dl
------------------------------------------------------------------------------------
function kill_dl.dosomething1(n,l,w)
	if findstring(l,"你感到丹田真气混浊，运转的枯荣心法渐渐散去。") then
		reyun=1
	end
	if findstring(l,"你双掌合十，运转枯荣心法，一股真气自丹田而生，沿心脉流转不息，脸上一枯一荣闪现，片刻即回复正常。","你已在运转枯荣心法了。") then
		reyun=0
	end
	if findstring(l,"你龙行虎步，隐有君王之色，信手点去，一指戳在了","你面色凝重，气贯丹田，单指缓缓戳出，一股内力破空而出，正中","你向前疾跨一步，左手需晃一招，右手双指直戳，点中了") then
		alias.dl_with_ailao()
	end
end
------------------------------------------------------------------------------------
-- kill_gb
------------------------------------------------------------------------------------
function kill_gb.dosomething1(n,l,w)
	local _tb
	if findstring(l,"你的混天气功运行完毕，将内力收回丹田。","你只觉真气运转不畅，不得不放慢步法，调息吐纳。") then
		stat.huntianup=0
		reyun=1
	end
	if findstring(l,"你微一凝神，运起混天气功，全身骨节发出一阵爆豆般的声响","你脸上青气大盛，脚下缓缓踩著九宫八卦方位，头顶冒出腾腾白气，四面隐隐传来潮涌之声，碧涛玄功已发挥到极致！","你身行向后一跃，跳出战圈不打了。") then
		reyun=0
	end
	if findstring(l,"[> ]*(.+)目前正自顾不暇，放胆攻击吧。") then
		_tb=utils.split(killpfm,"|")
		if pfmid<table.getn(_tb) then pfmid=pfmid+1 end
	end
	if findstring(l,"你脸上青气一闪，双手暗含内力，每一掌推出都带着一股掌风！") then
		_tb=utils.split(killpfm,"|")
		if pfmid<table.getn(_tb) then pfmid=pfmid+1 end
	end
	if findstring(w[0],"你使出打狗棒法「缠」字诀，幻出连山棒影，将.+吞没！\n结果他被你缠了个手忙脚乱，一时无法还招进攻！") then
		_tb=utils.split(killpfm,"|")
		if pfmid<table.getn(_tb) then pfmid=pfmid+1 end
	end
end
------------------------------------------------------------------------------------
-- kill_hs
------------------------------------------------------------------------------------
function kill_hs.dosomething1(n,l,w)
	local _tb
	if findstring(l,"你当即将紫霞神功都运到了.+剑上，呼的一剑，朝.+当头直劈！","你微一运劲，只觉丹田内息紊乱，无力使出绝招！","你正在使用「雷动九天」，无法分神使用其他招数。","你正在使用气宗绝技，不能施展「夺命连环三仙剑」。") then
		pfmid=pfmid+1
	end
	if findstring(l,"只听得你一声大喝，拳风突然变得猛劲之极，身法却更加飘忽难测！","你已在使用雷动九天了！") then
		pfmid=pfmid+1
		if killskill~=nil and string.len(killskill)>0 then
			wieldweapon=1
			if killskill=="staff" then alias.wi(staffid) else alias.wi(killskill) end
		end
	end
	if findstring(l,"你缓缓吸了一口气，将内劲收回丹田。") then
		if findstring(killpfm,"leidong") and not npcfaint then
			wieldweapon=0
			alias.uw()
			run("perform leidong")
			pfmid=1
		end
	end
	if findstring(l,"你「唰」的一声抽出一柄.-剑握在手中。","你已经装备著了。") then
		if me.master=="风清扬" then run("jifa dodge dugu-jiujian") else run("jifa parry huashan-jianfa") end
	end
	if findstring(l,"你将手中的.-剑插回剑鞘。") then
		if me.master=="风清扬" then run("jifa dodge dugu-jiujian") else run("jifa parry pishi-poyu") end
	end
	if findstring(l,"经过一阵调息运气，你觉得丹田中原本紊乱的内息恢复了正常。") then
		_tb=utils.split(killpfm,"|")
		for k,v in ipairs(_tb) do
			if findstring(v,"sanxian") then pfmid=k end
		end
	end
end
------------------------------------------------------------------------------------
-- kill_qz
------------------------------------------------------------------------------------
function kill_qz.dosomething1(n,l,w)
	local _tb
	if findstring(l,"你长啸一声，拳法陡然加快，拳力一变，却是大盈若冲，其用不穷。","你挥出一拳，势若千军，魔教弟子不敢怠慢，凝神以对！","你连续几拳，拳力似乎有些变化，正是大成若缺，其用不弊。","你轻轻挥出一拳，看似没什么力道，张志光却不敢掉以轻心。") then
		pfmid=pfmid+1
		_tb=utils.split(killpfm,"|")
		if pfmid>table.getn(_tb) then pfmid=1 end
	end
	if findstring(l,"你大喝一声，剑招突变，.+剑逼出雪亮光芒，一剑化为.+剑") then
		pfmid=pfmid+1
		_tb=utils.split(killpfm,"|")
		if pfmid>table.getn(_tb) then pfmid=1 end
		st=0
	end
	if findstring(l,"你运起纯阳神通功，片刻之间，白气笼罩全身，双眼精光四射，身手分外矫健，进退神速，与平时判若两人。") then
		st=st+1
		if st>=2 then pfmid=pfmid+1 end
		_tb=utils.split(killpfm,"|")
		if pfmid>table.getn(_tb) then pfmid=1 end
	end
	if findstring(l,"你吸了一口气，将内力收回丹田，剑招也恢复正常！") then
		pfmid=1
	end
end
------------------------------------------------------------------------------------
-- kill_sl
------------------------------------------------------------------------------------
function kill_sl.dosomething1(n,l,w)
	if findstring(l,"你此时心念空明，悟彻佛家神通，刀锋过处，招数就如一叶一叶的莲花花瓣自手中源源不断地弹出！","你内息运转不断，功力节节提升，出手越来越快，“混元一气功”催在刀上所发出的热浪把.+压得喘不过气来！","你手中.+刀连环不断向前劈出，却都以弧形收回，刀势犹若片片莲花花瓣。") then
		alias.yjl()
	end
end
------------------------------------------------------------------------------------
-- kill_bt
------------------------------------------------------------------------------------
function kill_bt.dosomething1(n,l,w)
	local a,b,c
	if findstring(l,"这不是你的蛇，它不会听从你的指挥的。") then
		run(safego)
		run("convert she")
	end
	if findstring(l,"怪蛇看了看你，突然似箭一般跃起，准确地落在蛇杖上，盘了起来。","蛇杖上已有一条蛇了，怪蛇挤不上去！") then
		closeclass("kill_"..me.menpai)
		closeclass("kill")
		run("set killover="..killaction)
		killaction=""
	end
	if findstring(l,"你有放蛇出来吗？") then
		run("convert staff")
	end
	if findstring(l,"你只能在战斗中与怪蛇配合。") then
		alias.resetidle()
		alias.checkbusy("killover")
	end
	if findstring(l,"怪蛇正在战斗中，无法收入蛇杖之上。") then
		run("stop she "..sheid)
		wait.make(function()
			local _f=function() run("convert she") end
			wait.time(1);_f()
		end)
	end
	if findstring(l,"[> ]*"..killname.."脚下一个不稳，跌在地上昏了过去。") then
		alias.resetidle()
		run("kill "..killid)
		sheid=1
		run("stop she "..sheid)
		if skillslist["hamagong"]==nil then skillslist["hamagong"]={} end
		if skillslist["hamagong"]["lvl"]==nil then skillslist["hamagong"]["lvl"]=1 end
		if addforce~=nil and addforce>0 and skillslist["hamagong"]~=nil and skillslist["hamagong"]["lvl"]~=nil and skillslist["hamagong"]["lvl"]<me.maxlvl and skillslist["hamagong"]["lvl"]<751 then
			addforce=0
			alias.uw()
			run("perform puji")
		end
	end
end
function kill_bt.dosomething2(n,l,w)
	if findstring(w[0],"你用蛇杖示意怪蛇停下来。\n可是怪蛇理都不理。") then
		sheid=sheid+1
		run("stop she "..sheid)
	end
	if findstring(w[0],"从现在起你用零点内力伤敌。\n什么？") then
		-- #if @debug {#say 出现蛇已在staff上，但还要继续收蛇}
		closeclass("kill_"..me.menpai)
		closeclass("kill")
		run("set killover="..killaction)
	end
	if findstring(w[0],"你发现(.+)的身法中有些许破绽。\n如果这时偷袭成功，可以打的对手全无还手之力。") then
		if xy.pfm()>0 then run("perform shoot") end
	end
end
------------------------------------------------------------------------------------
-- kill_xs
------------------------------------------------------------------------------------
function kill_xs.dosomething1(n,l,w)
	local _tb
	if findstring(l,"你纵跃退後，立时呜呜、嗡嗡、轰轰之声大作，金光闪闪，银光烁烁，.+只轮子从.+个不同方位飞袭出来！","在空中旋转飞行之势已弱，当当当几声，都落到了地上。",".+在你身旁绕了个圈子，你伸手一招，那飞行中的.+便重新飞回你的手中！") then
		pfmid=pfmid+1
		_tb=utils.split(killpfm,"|")
		if pfmid>table.getn(_tb) then pfmid=1 end
	end
	if findstring(l,"你需要五个轮子才能使用「五轮大转」。") then
		alias.uw()
		pfmid=pfmid+1
		_tb=utils.split(killpfm,"|")
		if pfmid>table.getn(_tb) then pfmid=1 end
	end
end
------------------------------------------------------------------------------------
-- kill_em
------------------------------------------------------------------------------------
function kill_em.dosomething1(n,l,w)
	if findstring(l,"佛光普照乃是内家功夫，你现在内力不足，使不出这一招。","佛光普照乃是内家功夫，掌上不带内力使不出来") then
		alias.max()
	end
	if findstring(l,"忽见你眼中红光时隐时现，一下子变得神采弈弈。") then
		reyun=0
	end
	if findstring(l,"你所聚太阴炼形法之气已散开，你又恢复了原状。","你刚刚才使用了太阴炼形法，在这么短时间内重复使用是非常有害的！") then
		reyun=1
	end
	if findstring(l,"紧接着，你御剑成风，剑招快闪绝伦，闪电般攻出了峨嵋.+绝剑。") then
		alias.yjl()
	end
end
------------------------------------------------------------------------------------
-- kill_gm
------------------------------------------------------------------------------------
function kill_gm.dosomething1(n,l,w)
	if findstring(l,"你玉女心经心法渐渐散去，神情逐渐恢复常态。") then
		reyun=1
	end
	if findstring(l,"只见你微微一笑，神情安宁，眼中竟似没有他人一样。") then
		reyun=0
	end
	if findstring(l,"你已经在双剑和璧了。","你的左右互搏不够熟练，不能很好的使出双剑合璧的精妙之处！","必须持有双剑才能和璧左右互搏！","你的剑法修为不够！","你突然间左手抽出另一把剑，双手使出截然不同的剑法，正是左右互搏绝技。") then
		pfmid=pfmid+1
		_tb=utils.split(killpfm,"|")
		if pfmid>table.getn(_tb) then pfmid=1 end
	end
end
------------------------------------------------------------------------------------
-- kill_xx
------------------------------------------------------------------------------------
function kill_xx.dosomething1(n,l,w)
	if findstring(l,"你微觉疲惫，只好将护体的内力收回。") then
		reyun=1
	end
	if findstring(l,"你面色陡变，两只手交叉并与胸前，潜运内功，将化功大法功力布满全身！","你已经在运用化功大法护住周身大穴。") then
		reyun=0
	end
	if findstring(l,"你觉得.+的内力自手掌源源不绝地流了进来。",".+已经内力涣散，你已经无法从他体内吸取任何真气了！","你吸取的内力充塞全身，无法再吸取内力！","突然你阴阴一笑，瞅准机会，右手猛地向.+拍去！\n.+转身不灵，难以闪避，只得挺右手相抵。到此地步，已是高手比拼真力") then
		xx.suck=2
	end
	if findstring(l,"你觉得.+的真气自手掌源源不绝地流了进来。",".+已经真气涣散，你已经无法从他体内吸取真气了！") then
		xx.suck=1
	end
	if findstring(w[0],"你转手间已经将连环化功施展开来，但见人影交错间你精神瞬时振奋",".+已经内力涣散，你已经无法从他体内吸取任何真气了！",".+已经真气涣散，你已经无法从他体内吸取真气了！") then
		xx.suck=2
		run("yun huagong "..killid)
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function kill.update()
	local  kill_triggerlist={
	       {name="kill_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    kill.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(kill_triggerlist) do
		addtri(v.name,v.regexp,"kill",v.script,v.line)
	end
	local  kill_m_triggerlist={
	       {name="kill_m_dosth1",line=2,regexp="^(> > > |> > |> |)看来该找机会逃跑了\\.\\.\\.\\n\\S+ -\\Z",script=function(n,l,w)    kill.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(kill_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"kill",v.script,v.line)
	end
	closeclass("kill")
	
	local  kill_run_triggerlist={
	       {name="kill_run_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    kill_run.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(kill_run_triggerlist) do
		addtri(v.name,v.regexp,"kill_run",v.script,v.line)
	end
	closeclass("kill_run")
	
	local  kill_dl_triggerlist={
	       {name="kill_dl_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    kill_dl.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(kill_dl_triggerlist) do
		addtri(v.name,v.regexp,"kill_dl",v.script,v.line)
	end
	closeclass("kill_dl")
	
	local  kill_gb_triggerlist={
	       {name="kill_gb_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    kill_gb.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(kill_gb_triggerlist) do
		addtri(v.name,v.regexp,"kill_gb",v.script,v.line)
	end
	local  kill_gb_m_triggerlist={
	       {name="kill_gb_m_dosth1",line=2,regexp="^(> > > |> > |> |)你使出打狗棒法「缠」字诀，幻出连山棒影，将.+吞没！\\n结果他被你缠了个手忙脚乱，一时无法还招进攻！\\Z",script=function(n,l,w)    kill_gb.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(kill_gb_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"kill_gb",v.script,v.line)
	end
	closeclass("kill_gb")
	
	local  kill_hs_triggerlist={
	       {name="kill_hs_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    kill_hs.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(kill_hs_triggerlist) do
		addtri(v.name,v.regexp,"kill_hs",v.script,v.line)
	end
	closeclass("kill_hs")
	
	local  kill_qz_triggerlist={
	       {name="kill_qz_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    kill_qz.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(kill_qz_triggerlist) do
		addtri(v.name,v.regexp,"kill_qz",v.script,v.line)
	end
	closeclass("kill_qz")
	
	local  kill_sl_triggerlist={
	       {name="kill_sl_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    kill_sl.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(kill_sl_triggerlist) do
		addtri(v.name,v.regexp,"kill_sl",v.script,v.line)
	end
	closeclass("kill_sl")
	
	local  kill_bt_triggerlist={
	       {name="kill_bt_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    kill_bt.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(kill_bt_triggerlist) do
		addtri(v.name,v.regexp,"kill_bt",v.script,v.line)
	end
	local _tb2={
		"你用蛇杖示意怪蛇停下来。\\n可是怪蛇理都不理。\\Z",
		"从现在起你用零点内力伤敌。\\n什么？\\Z",
		"你发现(.+)的身法中有些许破绽。\\n如果这时偷袭成功，可以打的对手全无还手之力。\\Z",
	}
	local  kill_bt_m_triggerlist={
	       {name="kill_bt_m_dosth2",line=2,regexp=linktri(_tb2),script=function(n,l,w)    kill_bt.dosomething2(n,l,w)  end,},
	}
	for k,v in pairs(kill_bt_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"kill_bt",v.script,v.line)
	end
	closeclass("kill_bt")
	
	local  kill_xs_triggerlist={
	       {name="kill_xs_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    kill_xs.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(kill_xs_triggerlist) do
		addtri(v.name,v.regexp,"kill_xs",v.script,v.line)
	end
	closeclass("kill_xs")
	
	local  kill_em_triggerlist={
	       {name="kill_em_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    kill_em.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(kill_em_triggerlist) do
		addtri(v.name,v.regexp,"kill_em",v.script,v.line)
	end
	closeclass("kill_em")
	
	local  kill_gm_triggerlist={
	       {name="kill_gm_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    kill_gm.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(kill_gm_triggerlist) do
		addtri(v.name,v.regexp,"kill_gm",v.script,v.line)
	end
	closeclass("kill_gm")
	
	local  kill_xx_triggerlist={
	       {name="kill_xx_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    kill_xx.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(kill_xx_triggerlist) do
		addtri(v.name,v.regexp,"kill_xx",v.script,v.line)
	end
	local  kill_xx_m_triggerlist={
	       {name="kill_xx_m_dosth1",line=2,regexp="^(> > > |> > |> |)突然你阴阴一笑，瞅准机会，右手猛地向.+拍去！\\n.+转身不灵，难以闪避，只得挺右手相抵。到此地步，已是高手比拼真力\\Z",script=function(n,l,w)    kill_xx.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(kill_xx_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"kill_xx",v.script,v.line)
	end
	closeclass("kill_xx")
end
kill.update()