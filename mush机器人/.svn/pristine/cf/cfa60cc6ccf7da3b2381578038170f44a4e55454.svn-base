mp_hs={}
mp_hs_pre={}
mp_hs_watch={}
mp_hs_start={}

mmr={
	searchlist="s|w|s|s|e|n|ne|se|sw|n|w|n",
	searchroomno="2010|2011|2012|2013|2014|2015|2016|2018|2017|2016|2010|841",
	searchid=3,
	findmmr=0,
	name="",
	id="",
	targetNum=3,
	havenum=1,
	oneexp=149,
	corpseid=-1,
	err=0,
	givenum=0,
}

------------------------------------------------------------------------------------
-- mp_hs_pre
------------------------------------------------------------------------------------
function mp_hs_pre.dosomething1(n,l,w)
	local _f,_tb,a,b,c
	wait.make(function()
		if findstring(l,"你目前还没有任何为 giveling=yes 的变量设定。") then
			if mmr.givenum>0 then
				if mpLimited.mpexp<4750 or os.time()>(mpLimited.MarkTime+3600) then
					print("给岳令牌 "..mmr.givenum.." 个")
					run("give yue "..mmr.givenum.." ling")
					mmr.havenum=mmr.havenum+mmr.givenum
					have.ling=have.ling-mmr.givenum
					print("剩余"..have.ling.."个")
				else
					print("给岳令牌 "..have.ling.." 个")
					for i=1,20,1 do run("give yue ling") end
					run("set check=mmrLimited")
					mmr.havenum=have.ling
					have.ling=0
				end
			else
				print("给令完成，当前MPEXP值 "..mpLimited.mpexp)
				if hp.neili<(hp.maxneili*set_neili_global/100) then alias.dz(set_neili) else alias.startworkflow() end
			end
		end
		if findstring(l,"你目前还没有任何为 check=mmrLimited 的变量设定。") then
			if mpJobLimited>0 then
				print("本次统计到的真正mmr上限为："..mpLimited.mpexp)
				if mpLimited.stat()==0 then
					-- 到给令时间岳却不收令，推迟给令2分钟
					mpLimited.MarkTime=os.time()-3600+120
				end
				mpLimited.MarkExp=mpLimited.mpexp
				alias.setTargetNum()
				if hp.neili<(hp.maxneili*set_neili_global/100) then alias.dz(set_neili) else alias.startworkflow() end
			else alias.checkexp("mp") end
		end
		if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
			if not isopen("boat") then
				alias.resetidle()
				alias.startworkflow()
			end
		end
		if findstring(l,"你没有那么多的青铜令牌。") then
			if have.ling~=nil and have.ling>0 then
				print("要给的令不是自己的")
				mmr.havenum=mmr.havenum-1
				have.ling=have.ling+mmr.givenum
				have.ling=have.ling-1
				run("set giveling=yes")
			else
				print("给令完成，当前MPEXP值 "..mpLimited.mpexp)
				if hp.neili<(hp.maxneili*set_neili_global/100) then alias.dz(set_neili) else alias.startworkflow() end
			end
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『岳不群』") then
			print("当前MPEXP值 "..mpLimited.mpexp)
			print("有令牌 "..have.ling.."个")
			mmr.havenum=0
			_f=function()
						for i=1,20,1 do run("give yue ling") end
						run("set check=mmrLimited")
						mmr.havenum=have.ling
						have.ling=0
				end
			wait.time(1);_f()
		end
		if findstring(l,"东西的数量至少是一个。") then
			print("给令完成，当前MPEXP值 "..mpLimited.mpexp)
			if hp.neili<(hp.maxneili*set_neili_global/100) then alias.dz(set_neili) else alias.startworkflow() end
		end
		a,b,c=string.find(l,"看起来(.+)想杀死你！")
		if c~=nil then
			mmr.name=c
			mmr.findmmr=1
		end
		if findstring(l,"岳不群向你置问道：这令牌似乎不是你的。你是怎麽得来的？") then
			alias.resetidle()
		end
		if findstring(l,"你目前还没有任何为 searchmmr=yes 的变量设定。") then
			alias.resetidle()
			safego="/alias.flytoid("..me.menpaiJobStart..")"
			SaveBack="south"
			if mmr.err>0 then
				alias.flytoid(me.menpaiJobStart)
			else
				if mmr.findmmr>0 then
					closeclass("mp_hs_pre")
					openclass("mp_hs_start")
					run("id here;set checkmmrid=yes")
					alias.yjl()
				else
					_tb=utils.split(mmr.searchlist,"|")
					if mmr.searchid>table.getn(_tb) then mmr.searchid=1 end
					run(_tb[mmr.searchid])
					_tb=utils.split(mmr.searchroomno,"|")
					roomno_now=_tb[mmr.searchid]
					mmr.searchid=mmr.searchid+1
					if cmd.nums<20 then
						run("set searchmmr=yes")
					else
						alias.yjl()
						_f=function() run("set searchmmr=yes") end
						wait.time(2);_f()
					end
				end
			end
		end
		if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
			alias.resetidle()
			if have.ling>=mmr.targetNum and have.ling>0 then
				if mpJobLimited>0 then alias.startworkflow() else alias.flytonpc("岳不群") end
			else alias.flytoid(me.menpaiJobStart) end
		end
		a,b,c=string.find(l,"数码世界，数字地图，(%d+)就是这里！")
		if c~=nil and tonumber(c)==tonumber(me.menpaiJobStart) then
			alias.resetidle()
			mmr.findmmr=0
			mmr.searchid=1
			mmr.err=0
			mmr.id=""
			mmr.name=""
			alias.dz(set_neili)
		end
		if findstring(l,"你目前还没有任何为 checkexpover=mp 的变量设定。") then
			alias.resetidle()
			alias.yjl()
			alias.et()
			if add.exp>10 and mmr.havenum>10 then mmr.oneexp=math.floor(add.exp/mmr.havenum) end
			alias.setTargetNum()
			if mpLimited.mpexp>me.menpaiLimited then
				mpJobLimited=1
				print("本次统计到的mmr上限为："..mpLimited.mpexp)
				if mpLimited.mpexp<me.menpaiLimited then mpLimited.MarkExp=me.menpaiLimited else mpLimited.MarkExp=mpLimited.mpexp end
			end
			print("给令完成，当前MPEXP值 "..mpLimited.mpexp)
			if hp.neili<(hp.maxneili*set_neili_global/100) then alias.dz(set_neili) else alias.startworkflow() end
		end
		if findstring(l,"你目前还没有任何为 busyover=mmr 的变量设定。") then
			alias.resetidle()
			alias.yjl()
			alias.et()
			if hp.neili<(hp.maxneili*set_neili_global/100) then alias.dz(set_neili) else alias.startworkflow() end
		end
		a,b,c=string.find(w[0],"岳不群说道：短时间内如此多敌人？\n岳不群说道：(.+)，这些令牌你先收着，让我好好筹划御敌大计。")
		if c~=nil and c==me.charname then
			mpJobLimited=1
		end
		a,b,c=string.find(w[0],"岳不群皱着眉头说道：这是邪派的青铜令，他们到底有何企图？\n岳不群说道：(.+)你做得非常好！快下去休息吧。")
		if c~=nil and c==me.charname then
			alias.resetidle()
			mpJobLimited=0
		end
	end)
end
------------------------------------------------------------------------------------
-- mp_hs_start
------------------------------------------------------------------------------------
function mp_hs_start.dosomething1(n,l,w)
	local _tb,a,b,c,d,e,f
	if findstring(l,"你是气宗弟子，不到生死关头最好不要使用剑宗绝技，免遭同门耻笑！") then
		pfmid=pfmid+1
	end
	if findstring(l,"你目前还没有任何为 killover=yes 的变量设定。") then
		alias.resetidle()
		run("get silver;get silver from corpse")
		if have.getlingdummy==nil or have.getlingdummy==0 then
			if mmr.corpseid>1 then run("get ling from corpse "..mmr.corpseid) else run("get ling from corpse") end
		end
		mmr.corpseid=-1
		alias.yjl()
		run("set getling=yes")
	end
	if findstring(l,"你目前还没有任何为 getling=yes 的变量设定。") then
		alias.resetidle()
		closeclass("mp_hs_start")
		openclass("mp_hs_pre")
		mmr.findmmr=0
		mmr.err=0
		mmr.id=""
		mmr.name=""
		if not isopen("check_items") then
			print("目前有令牌 "..have.ling.." 个，目标为 "..mmr.targetNum.."个，上次上限时点到目前的工作经验为："..mpLimited.mpexp)
		end
		if have.ling>=mmr.targetNum or (stat.leidong==nil or stat.leidong==0) or hp.neili<(hp.maxneili*set_neili_job/100) then
			alias.checkitems()
		else
			run("halt")
			alias.startworkflow()
		end
	end
	a,b,c=string.find(l,"[> ]*(.+)悻悻说道：算你跑得快，老子真倒霉！")
	if c~=nil and c==mmr.name then
		alias.resetidle()
		if hp.neili<(hp.maxneili*set_neili_global/100) then alias.dz(set_neili) else alias.startworkflow() end
	end
	a,b,c,d,e,f=string.find(l,"(%S+)%s+=%s+(%w+) (%w+), (%w+)")
	if c~=nil and d~=nil and e~=nil and d~=nil and c==mmr.name then
		alias.resetidle()
		run("hp")
		mmr.id=d.." "..e
		have.getlingdummy=0
		_tb=utils.split(mpyun,"|")
		for k,v in ipairs(_tb) do run(v) end
		openclass("kill")
		run("unset no_parry")
		openclass("kill_"..me.menpai)
		closeclass("kill_run")
		AddTimer("kill_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "kill.timer")
		SetTimerOption("kill_timer", "group", "kill")
		runaway=false
		npcfaint=false
		killRunSuccess=false
		if tonumber(stat.leidong)~=nil and stat.leidong>0 then pfmid=2 else pfmid=1 end
		killid=mmr.id
		killname=mmr.name
		killskill=mpweapon
		killpfm=mppfm
		killyun=mpyun
		killjiali=mpjiali
		killjiajin=mpjiajin
		run("jiali "..mpjiali..";jiajin "..mpjiajin)
		_tb=utils.split(mppfm,"|")
		if findstring(_tb[pfmid],"leidong") then
			alias.uw()
			if me.master=="风清扬" and mpweapon=="jian" then run("jifa dodge dugu-jiujian") else run("jifa parry pishi-poyu") end
		else
			if mpweapon=="staff" then alias.wi(staffid) else alias.wi(mpweapon) end
			wieldweapon=1
			if me.master=="风清扬" and mpweapon=="jian" then run("jifa dodge dugu-jiujian")
			else
				if mpweapon=="jian" then run("jifa parry huashan-jianfa")
				else
					if mpweapon=="staff" or mpweapon=="qin" then run("jifa parry jinhua-zhang") end
				end
			end
		end
		run("kill "..mmr.id)
		_tb=utils.split(mppfm,"|")
		if pfmid<=table.getn(_tb) then run(_tb[pfmid].." "..mmr.id) end
	end
end
------------------------------------------------------------------------------------
-- mp_hs_watch
------------------------------------------------------------------------------------
function mp_hs_watch.dosomething1(n,l,w)
	local a,b,c
	if findstring(l,".+给你一面青铜令牌。") then
		have.getlingdummy=1
		alias.resetidle()
		have.ling=have.ling+1
		alias.setTargetNum()
	end
	if findstring(l,".+在你的耳边悄声说道：你白忙活了，这个尸体没令！") then
		have.getlingdummy=1
		alias.resetidle()
		alias.setTargetNum()
	end
	if findstring(l,"这个方向没有出路。") then
		mmr.err=1
	end
	if findstring(l,"你从.+的尸体身上搜出一面青铜令牌。") then
		alias.resetidle()
		have.ling=have.ling+1
		alias.setTargetNum()
	end
	a,b,c=string.find(l,"[> ]*(.-)倒在地上，挣扎了几下就死了。")
	if c~=nil then
		if c==mmr.name then mmr.corpseid=0 end
		if mmr.corpseid>=0 then mmr.corpseid=mmr.corpseid+1 end
	end
	a,b,c=string.find(l,"[> ]*(.-)急步往.-离开。")
	if c~=nil and c==mmr.name then
		alias.checkbusy("killover")
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function mp_hs.update()
	local  mp_hs_pre_triggerlist={
	       {name="mp_hs_pre_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_hs_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_hs_pre_triggerlist) do
		addtri(v.name,v.regexp,"mp_hs_pre",v.script,v.line)
	end
	local _tb={
		"岳不群说道：短时间内如此多敌人？\\n岳不群说道：(.+)，这些令牌你先收着，让我好好筹划御敌大计。\\Z",
		"岳不群皱着眉头说道：这是邪派的青铜令，他们到底有何企图？\\n岳不群说道：(.+)你做得非常好！快下去休息吧。\\Z",
	}
	local  mp_hs_pre_m_triggerlist={
	       {name="mp_hs_pre_m_dosth1",line=2,regexp=linktri2(_tb),script=function(n,l,w)    mp_hs_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_hs_pre_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_hs_pre",v.script,v.line)
	end
	closeclass("mp_hs_pre")
	
	local  mp_hs_start_triggerlist={
	       {name="mp_hs_start_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_hs_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_hs_start_triggerlist) do
		addtri(v.name,v.regexp,"mp_hs_start",v.script,v.line)
	end
	closeclass("mp_hs_start")
	
	local  mp_hs_watch_triggerlist={
	       {name="mp_hs_watch_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_hs_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_hs_watch_triggerlist) do
		addtri(v.name,v.regexp,"mp_hs_watch",v.script,v.line)
	end
	closeclass("mp_hs_watch")
end
mp_hs.update()
