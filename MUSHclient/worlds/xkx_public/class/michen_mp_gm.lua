mp_gm={}
mp_gm_pre={}
mp_gm_caimi={}
mp_gm_caimi_t={}
mp_gm_watch={}
mp_gm_job3={}

caimicmd=""
gmjob3time=os.time()
gm_exits=""
gm_exitlist={}
love_enter=""
npcinfo={
	name="",
	id="",
}
havejob3=0
------------------------------------------------------------------------------------
-- mp_gm_pre
------------------------------------------------------------------------------------
function mp_gm_pre.dosomething1(n,l,w)
	if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
		alias.resetidle()
		alias.flytoid(me.menpaiJobStart)
	end
	if findstring(l,"数码世界，数字地图，"..tostring(me.menpaiJobStart).."就是这里！") then
		alias.resetidle()
		-- 防止刚好回去的时候出了JOB3
		if havejob3>0 then
			alias.flytoid(607)
			openclass("mp_gm_job3")
		else
			openclass("mp_gm_caimi")
			openclass("mp_gm_caimi_t")
		end
	end
	if findstring(l,"你目前还没有任何为 checkexpover=mp 的变量设定。") then
		alias.resetidle()
		if (tonumber(add.exp)>10 and mpLimited.MarkExp<me.menpaiLimited) then mpLimited.MarkExp=tonumber(me.menpaiLimited) end
		if (tonumber(add.exp)<10) then mpJobLimited=1 end
		alias.startworkflow()
	end
end
------------------------------------------------------------------------------------
-- mp_gm_caimi
------------------------------------------------------------------------------------
function mp_gm_caimi.dosomething1(n,l,w)
	if findstring(l,"你目前还没有任何为 busyover=caimiover 的变量设定。") then
		alias.resetidle()
		run("yun refresh;get ji from he;drink ji;put ji in he;s;pour bottle")
		if have.yufengjiang==nil or have.yufengjiang<10 then run("search yufengjiang") end
		run("n")
		alias.checkexp("mp")
	end
end
------------------------------------------------------------------------------------
-- mp_gm_caimi_t
------------------------------------------------------------------------------------
function mp_gm_caimi_t.dosomething1(n,l,w)
	if findstring(l,"你弄了很久，终于装满了一瓶蜂蜜。") then
		alias.resetidle()
		closeclass("mp_gm_caimi_t")
		alias.checkbusy("caimiover")
	end
	if findstring(l,"你小心翼翼的把蜂巢中的蜂蜜收集到瓶子里。") then
		alias.resetidle()
		caimicmd=""
	end
	if findstring(l,"你累死了，歇会儿吧！") then
		alias.resetidle()
		caimicmd="yun refresh"
	end
	if findstring(l,"蜂巢中似乎已经没有蜂蜜了。") then
		alias.resetidle()
		caimicmd="zhaofeng"
	end
end
function mp_gm_caimi_t.timer()
	if stat.havedu>0 then alias.startliaoshang()
	else
		if string.len(caimicmd)>0 then run(caimicmd) end
		run("collect")
	end
end
------------------------------------------------------------------------------------
-- mp_gm_watch
------------------------------------------------------------------------------------
function mp_gm_watch.dosomething1(n,l,w)
	if findstring(l,"你忽然听到刚刚经过的路边大宅里传来了一阵女人的哭声。") then
		havejob3=1
		gmjob3time=os.time()
	end
end
------------------------------------------------------------------------------------
-- mp_gm_job3
------------------------------------------------------------------------------------
function mp_gm_job3.dosomething1(n,l,w)
	local _f,a,b,c,d,e
	wait.make(function()
		if findstring(l,"数码世界，数字地图，607就是这里！") then
			alias.resetidle()
			love_enter=""
			havejob3=0
			gmjob3time=os.time()
			findpath={}
			findpathnow=1
			walkedpath={}
			npcinfo={name="",id="",}
			findpath[findpathnow]={}
			findpathold=1
			-- 开始等待JOB3来临
			if hp.neili<(hp.maxneili*set_neili_job/100) then alias.dz(set_neili)
			else run("yun refresh;n;s;n;s;n;s;n;s;look;set checkjob3=yes") end
		end
		if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。","你目前还没有任何为 lian=over 的变量设定。") then
			DeleteTimer("gm_job3_wait_timer")
			alias.uw()
			if string.len(love_enter)<=0 then
				alias.resetidle()
				run("yun refresh;n;s;n;s;n;s;n;s;look;set checkjob3=yes")
			end
		end
		a,b,c=string.find(l,"^%s+这里[明显|唯一]+的出口是 (.*)。$")
		if c~=nil then
			gm_exits=c
			gm_exitlist=(string.gsub(gm_exits, " 和 ", "、"))
			gm_exitlist=strexplit(gm_exitlist, "、")
		end
		a,b,c=string.find(l,"%S+ %- (.+)$")
		if c~=nil then
			gm_exits=c
			gm_exitlist=(string.gsub(gm_exits, " 和 ", "、"))
			gm_exitlist=strexplit(gm_exitlist, "、")
		end
		if findstring(l,"你目前还没有任何为 checkjob3=yes 的变量设定。") then
			alias.resetidle()
			-- 超过五分钟没来任务，就回去玩玩别的先
			if (os.time()-gmjob3time)>300 then
				DeleteTimer("gm_job3_wait_timer")
				alias.startworkflow()
				return
			end
			run("hp")
			-- 查看下出口出来没，出来了就可以进去了，没出来的话，等几秒再来一下
			for k,v in pairs(gm_exitlist) do
				if v~="north" and v~="west" and v~="northeast" then
					love_enter=v
				end
			end
			if string.len(love_enter)<=0 then
				_f=function()
							if hp.neili<(hp.maxneili*set_neili_job/100) then alias.dz(set_neili)
							else
								AddTimer("gm_job3_wait_timer",0,0,30,"",timer_flag.Enabled + timer_flag.OneShot, "alias.tlw")
								alias.lianwu()
							end
					end
				wait.time(3);_f()
			else
				DeleteTimer("gm_job3_wait_timer")
				havejob3=0
				findpath={}
				findpathnow=1
				walkedpath={}
				npcinfo={name="",id="",}
				findpath[findpathnow]={}
				findpath[findpathnow][love_enter]=2
				findpathnow=findpath[findpathnow][love_enter]
				walkedpath[1]=love_enter		-- 保存到行走过的方向中，出来的时候用
				run(love_enter)
				findpathold=1
				findpatholdfx=love_enter
				run("set findpath=doing")
			end
		end
		a,b,c,d,e=string.find(l,"(%S+) (.+)%((.+)%)")
		if c~=nil and d~=nil and e~=nil then
			if findstring(c,"大财主","药材商","地主","三省巡抚","振威将军","小吏","大学士") then
				npcinfo["name"]=d
				npcinfo["id"]=string.lower(e)
				fjselectnpc.menpai=""
				fjselectnpc.weapon=1
			end
		end
		a,b,c=string.find(l,"此人早年曾经拜在(.+)门下学艺。")
		if c~=nil then
			if findstring(c,"大理段家") then fjselectnpc.menpai="dl" end
			if findstring(c,"全真教") then fjselectnpc.menpai="qz" end
			if findstring(c,"武当派") then fjselectnpc.menpai="wd" end
			if findstring(c,"少林派") then fjselectnpc.menpai="sl" end
			if findstring(c,"桃花岛") then fjselectnpc.menpai="th" end
			if findstring(c,"峨嵋派") then fjselectnpc.menpai="em" end
			if findstring(c,"华山派") then fjselectnpc.menpai="hs" end
			if findstring(c,"星宿派") then fjselectnpc.menpai="xx" end
			if findstring(c,"白驼山") then fjselectnpc.menpai="bt" end
			if findstring(c,"雪山派") then fjselectnpc.menpai="xs" end
			if findstring(c,"密宗") then fjselectnpc.menpai="xs" end
			if findstring(c,"明教") then fjselectnpc.menpai="mj" end
			if findstring(c,"丐帮") then fjselectnpc.menpai="gb" end
		end
		a,b,c=string.find(l,"□(.+)%(.+%)")
		if c~=nil then
			if not findstring(c,"皮背心") then
				if findstring(c,"剑") then fjselectnpc.weapon=2 end
				if findstring(c,"箫") then fjselectnpc.weapon=3 end
				if findstring(c,"刀") then fjselectnpc.weapon=4 end
				if findstring(c,"棒") then fjselectnpc.weapon=5 end
				if findstring(c,"轮") then fjselectnpc.weapon=6 end
				if findstring(c,"杖") then fjselectnpc.weapon=7 end
				if findstring(c,"鞭") then fjselectnpc.weapon=8 end
			end
		end
		if findstring(l,"你目前还没有任何为 checkmenpai=yes 的变量设定。") then
			alias.resetidle()
			fjnpc=fjselectnpc.menpai.." "..case_weapon(fjselectnpc.weapon)
			if selectfjnpc()>0 then
				-- 杀！
				addlog("开杀 JOB3 NPC="..fjnpc)
				_tb=utils.split(fjyun,"|")
				for k,v in ipairs(_tb) do run(v) end
				reyun=0
				killid=npcinfo["id"]
				killname=npcinfo["name"]
				killskill=fjweapon
				killpfm=fjpfm
				killyun=fjyun
				killjiali=fjjiali
				killjiajin=fjjiajin
				run("jiali "..fjjiali..";jiajin "..fjjiajin)
				run("halt;ask "..killid.." about 哭声")
			else
				-- 不杀！
				addlog("不杀 JOB3 NPC="..fjnpc)
				npcinfo={name="",id="",}
				alias.checkbusy("goback")
			end
		end
		if findstring(l,"老子教训老婆，关你什么事情。") then
			alias.resetidle()
			addlog("不是我的NPC")
			npcinfo={name="",id="",}
			alias.checkbusy("goback")
		end
		if findstring(l,"这里没有 "..npcinfo["id"].." 这个人。") then
			alias.resetidle()
			addlog("NPC已经走开了")
			npcinfo={name="",id="",}
			pcall(mp_gm_job3.findnpc)
		end
		if findstring(l,"对方正忙着呢，你等会儿在问话吧。","你正忙着呢，你等会儿在问话吧。") then
			alias.resetidle()
			_f=function() run("halt;ask "..killid.." about 哭声") end
			wait.time(1);_f()
		end
		if findstring(l,"哪里来的多管闲事的女人，找死啊！") then
			alias.resetidle()
			openclass("kill")
			openclass("kill_"..me.menpai)
			closeclass("kill_run")
			AddTimer("kill_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "kill.timer")
			SetTimerOption("kill_timer", "group", "kill")
			runaway=false
			npcfaint=false
			killRunSuccess=false
			pfmid=1
			rekill=1
			if string.len(fjweapon)>0 then
				if fjweapon=="staff" then alias.wi(staffid) else alias.wi(fjweapon) end
			else alias.uw() end
		end
		if findstring(l,"你目前还没有任何为 killover=yes 的变量设定。") then
			alias.resetidle()
			run("get gold from corpse;get beixin from corpse;drop beixin;drop beixin;get beixin;wear all")
			alias.checkexp("job3")
		end
		if findstring(l,"你目前还没有任何为 checkexpover=job3 的变量设定。") then
			alias.resetidle()
			if add.exp>10 and mpLimited.MarkExp<me.menpaiLimited then mpLimited.MarkExp=tonumber(me.menpaiLimited) end
			if add.exp<10 then
				mpJobLimited=1
				print("统计到的job3上限为："..mpLimited.mpexp)
				mpLimited.MarkExp=tonumber(mpLimited.mpexp)
				if mpLimited.MarkTime<(os.time()-3600) then
					-- 到时间却仍然busy，推迟2分钟
					mpLimited.MarkTime=tonumber(os.time()-3600+120)
				end
			end
			alias.checkbusy("goback")
		end
		if findstring(l,"你目前还没有任何为 busyover=goback 的变量设定。") then
			alias.resetidle()
			pcall(mp_gm_job3.goback)
		end
		if findstring(l,"你目前还没有任何为 goback=over 的变量设定。") then
			alias.resetidle()
			run("n")
			alias.startworkflow()
		end
		if findstring(l,"你目前还没有任何为 findpath=doing 的变量设定。") then
			alias.resetidle()
			pcall(mp_gm_job3.findnpc)
		end
	end)
end
function mp_gm_job3.goback()
	while #walkedpath>=1 do
		run(invDirection(walkedpath[table.getn(walkedpath)]))
		table.remove(walkedpath)
	end
	run("set goback=over")
end
-- 遍历房间搜索NPC中
function mp_gm_job3.findnpc()
	alias.resetidle()
	-- 如果回到了入口房间都没找到，那就BYEBYE闪人
	if findpathnow==1 then
		local msg="GM love job:MLGB，累的半死都没找着人！！！再见BYEBYE!！！"
		print(msg)
		alias.startworkflow()
		return
	end

	-- 先判断有没有找到NPC，有找到了，就直接开干，下面就都不用处理了
	if npcinfo["id"]~=nil and string.len(npcinfo["id"])>0 then
		-- 这里要处理杀人了：：：：：：：：：：：：：：：：：：：：：：：：：：：：
		run("look "..npcinfo["id"]..";set checkmenpai=yes")
	else
   
		-- 这里开始判断当前房间的出口，排除已经走过的，把剩下的加到队列中，然后继续走
		-- 这是一个新房间，之前没有记录
		if findpath[findpathnow]==nil then
			table.insert(findpath, {})
			for key, value in ipairs(gm_exitlist) do
				findpath[findpathnow][value]=0
				if value==invDirection(findpatholdfx) then
					findpath[findpathnow][value]=findpathold
				end
			end
			--Note("新房间----------------------")
			--tprint(findpath)
		else -- 这个房间之前已经有记录了
			for key, value in ipairs(gm_exitlist) do
				if findpath[findpathnow][value]==nil then
					findpath[findpathnow][value]=0
				end
			end
			--Note("旧房间----------------------")
			--tprint(findpath)
		end
		
		-- 在当前房间找一个没走过的出口
		--tprint(roominfo["exits"])
		local exits=nil
		for key, value in pairs(findpath[findpathnow]) do
			--Note("查找.."..key..".."..value)
			if value==0 then
				exits=key
			end
		end
		--Note("循环结束")
		-- 如果当前房间出口都已经走过了，那就走出口ID最小的那个，往回走
		local tmp=99999
		if exits==nil then
			for key, value in pairs(findpath[findpathnow]) do
				if value<tmp then
					tmp=value
					exits=key
				end
			end
		else
			-- 走的是新房间，要设置下
			findpath[findpathnow][exits]=table.getn(findpath)+1
		end
		walkedpath[table.getn(walkedpath)+1]=exits			-- 保存到行走过的方向中，出来的时候用
		run(exits)
		findpathold=findpathnow
		findpathnow=findpath[findpathnow][exits]
		findpatholdfx=exits
		run("set findpath=doing")
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function mp_gm.update()
	local  mp_gm_pre_triggerlist={
	       {name="mp_gm_pre_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_gm_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gm_pre_triggerlist) do
		addtri(v.name,v.regexp,"mp_gm_pre",v.script,v.line)
	end
	closeclass("mp_gm_pre")
	
	local  mp_gm_caimi_triggerlist={
	       {name="mp_gm_caimi_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_gm_caimi.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gm_caimi_triggerlist) do
		addtri(v.name,v.regexp,"mp_gm_caimi",v.script,v.line)
	end
	closeclass("mp_gm_caimi")
	
	local  mp_gm_caimi_t_triggerlist={
	       {name="mp_gm_caimi_t_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_gm_caimi_t.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gm_caimi_t_triggerlist) do
		addtri(v.name,v.regexp,"mp_gm_caimi_t",v.script,v.line)
	end
	AddTimer("mp_gm_caimi_t_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "mp_gm_caimi_t.timer")
	SetTimerOption("mp_gm_caimi_t_timer", "group", "mp_gm_caimi_t")
	closeclass("mp_gm_caimi_t")
	
	local  mp_gm_watch_triggerlist={
	       {name="mp_gm_watch_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_gm_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gm_watch_triggerlist) do
		addtri(v.name,v.regexp,"mp_gm_watch",v.script,v.line)
	end	
	closeclass("mp_gm_watch")
	
	local  mp_gm_job3_triggerlist={
	       {name="mp_gm_job3_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_gm_job3.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gm_job3_triggerlist) do
		addtri(v.name,v.regexp,"mp_gm_job3",v.script,v.line)
	end	
	closeclass("mp_gm_job3")
end
mp_gm.update()

