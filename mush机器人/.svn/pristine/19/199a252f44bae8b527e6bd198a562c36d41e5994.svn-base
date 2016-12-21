mp_mj={}
mp_mj_pre={}
mp_mj_yudi={}
mp_mj_wxq={}
mp_mj_wxqjob={}
mp_mj_tyjob={}
mp_mj_watch={}

mj.haveyd=0
mj.yd1="s|w|nw|wu|sw|se|sd|s|sw|sd|s|sd|sd|se|se|sd|sd|nu|nu|nw|nw|nu|nu|n|nu|nw|n|ne"
mj.yd2="s|w|nw|wu|sw|se|sd|s|sw|sd|s|sd|sd|se|se|sd|sd|nu|nu|nw|nw|nu|nu|n|nu|nw|n|ne|u|e|w|w|e|nu|w|e|nu|ne|sw|nw|se|nu|se|nw|nw|se|sw|ne|ne|sw|nu|e|s|n|n|s|w|w|s|n|n|s|e|enter|e|w|w|n|w"
mj.search=""
mj.searchid=1
mj.ydnpc=0
mj.npcname=""

mj.tyjobnpc=""
mj.tyjobnpcid=""

function alias.wxqask()
	if roomno_now==466 then run("ask tang yang about 木桶;ask tang yang about job")
	elseif roomno_now==554 then run("ask yan yuan about 铁锹;ask yan yuan about job")
	elseif roomno_now==449 then run("ask wen cangsong about 斧头;ask wen cangsong about job")
	elseif roomno_now==597 then run("ask zhuang zheng about 铁锹;ask zhuang zheng about job")
	elseif roomno_now==444 then run("ask xin ran about job")
	elseif roomno_now==596 then run("ask wu jincao about 精铁;ask wu jincao about 打铁")
	else alias.flytonpc("唐洋")	end
end
function alias.mjlianwu()
	alias.uw()
	skills_num=1
	alias.lianwu()
end
------------------------------------------------------------------------------------
-- mp_mj_pre
------------------------------------------------------------------------------------
function mp_mj_pre.dosomething1(n,l,w)
	if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
		alias.resetidle()
		alias.flytoid(596)
	end
	if findstring(l,"数码世界，数字地图，596就是这里！") then
		alias.resetidle()
		alias.dz(set_neili_global)
	end
	if not isopen("boat") and findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
		alias.resetidle()
		closeclass("mp_mj_pre")
		if mj.yudi~=nil and mj.yudi~=0 and mj.haveyd==1 then
			openclass("mp_mj_yudi")
			run("wavefighter fighter;wavefighter fighter;menpai")
			alias.flytonpc("吴劲草")
		elseif havefj>0 then 
			alias.startworkflow()
		elseif mj.wxq~=nil and mj.wxq~=0 then
			--openclass("mp_mj_wxq")
			--alias.flytonpc("唐洋")
			print("还没做好")
			alias.startworkflow()
		elseif mj.tyjob~=nil and mj.tyjob~=0 then
			openclass("mp_mj_tyjob")
			alias.flytonpc("殷野王")
		else
			--if hp.pot<hp.maxpot then alias.flytonpc("杨逍") else alias.mjlianwu() end
			openclass("mp_mj_pre")
			alias.mjlianwu()
		end
	end
	if not isopen("boat") and findstring(l,"你目前还没有任何为 lian=over 的变量设定。") then
		alias.dz("addneili")
	end
	--if findstring(l,"有一天，你踩着七色云彩来迎娶『杨逍』") then
	--	alias.resetidle()
		--if hp.pot<hp.maxpot then run("ask yang xiao about 奖励") end
	--end
	if findstring(l,"你目前还没有任何为 checkexpover=mp 的变量设定。") then
		alias.resetidle()
		if add.exp>10 and mpLimited.MarkExp<me.menpaiLimited then mpLimited.MarkExp=tonumber(me.menpaiLimited) end
		if add.exp<10 then
			mpJobLimited=1
			print("统计到的yudi上限为："..mpLimited.mpexp)
			mpLimited.MarkExp=mpLimited.mpexp
			if mpLimited.MarkTime<(os.time()-3600) then
				-- 到时间却仍然busy，推迟2分钟
				mpLimited.MarkTime=tonumber(os.time()-3600+120)
			end
		end
		if fjjf~=nil and fjjf~="" then alias.jf(fjjf) end
		alias.startworkflow()
	end
end
------------------------------------------------------------------------------------
-- mp_mj_yudi
------------------------------------------------------------------------------------
function mp_mj_yudi.dosomething1(n,l,w)
	local _f,_tb,a,b,c,d,e,f
	wait.make(function()
	if findstring(l,"有一天，你踩着七色云彩来迎娶『吴劲草』") then
		alias.resetidle()
		if mj.yudi>1 then mj.search=mj.yd2 else mj.search=mj.yd1 end
		mj.searchid=1
		mj.ydnpc=0
		mj.npcname=""
		if mpjf~=nil and mpjf~="" then alias.jf(mpjf) end
		alias.dz(set_neili_global)
	end
	if not isopen("boat") and findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
		alias.resetidle()
		if mj.haveyd==1 then
			if string.len(mpweapon)>0 then
				if mpweapon=="staff" then alias.wi(staffid) else alias.wi(mpweapon) end
			else alias.uw() end
			run("unset no_parry;yield no;jiali "..mpjiali..";jiajin "..mpjiajin)
			run("set search=yes")
		else
			closeclass("mp_mj_yudi")
			openclass("mp_mj_pre")
			alias.checkexp("mp")
		end
	end
	if findstring(l,"你目前还没有任何为 search=yes 的变量设定。") then
		alias.resetidle()
		if mj.haveyd==0 then alias.flytonpc("吴劲草")
		elseif mj.ydnpc>0 then
			_tb=utils.split(mpyun,"|")
			for k,v in ipairs(_tb) do run(v) end
			openclass("kill")
			closeclass("kill_run")
			AddTimer("kill_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "kill.timer")
			SetTimerOption("kill_timer", "group", "kill")
			reyun=1
			runaway=false
			npcfaint=false
			killRunSuccess=false
			killid=""
			killname="npc"
			killskill=mpweapon
			killpfm=mppfm
			killyun=mpyun
			killjiali=mpjiali
			killjiajin=mpjiajin
			_tb=utils.split(mppfm,"|")
			for k,v in ipairs(_tb) do run(v) end
		else
			closeclass("kill")
			_tb=utils.split(mj.search,"|")
			if tonumber(mj.searchid)>tonumber(table.getn(_tb)) then
				alias.flytoid(585)
			else
				run("halt;".._tb[mj.searchid])
				mj.searchid=mj.searchid+1
				run("set search=yes")
			end
		end
	end
	if findstring(l,"你目前还没有任何为 check=kill 的变量设定。") then
		print("有"..mj.ydnpc.."个敌人")
		if mj.ydnpc==0 or mj.ydnpc>=mj.yuditp then
			alias.close_kill()
			alias.checkbusy("yudikill")
		elseif (hp.healthqi<70 or hp.neili<(hp.maxneili*70/100)) then
			alias.close_kill()
			alias.flytoid(585)
		elseif mj.npcname~="" then
			run("kill "..mj.npcname)
		end
	end
	if findstring(l,"你目前还没有任何为 busyover=yudikill 的变量设定。") then
		run("set search=yes")
	end
	if findstring(l,"你受伤过重","你已经受伤过重","你已经陷入半昏迷状态","你受了相当重的伤","你伤重之下已经难以支撑","你摇头晃脑","你已经一副头重脚轻的模样") then
		alias.close_kill()
		alias.flytoid(585)
	end
	if findstring(l,"数码世界，数字地图，585就是这里！") then
		_f=function() run("yun regenerate;yun refresh;yun recover")	end
		wait.time(2);_f()
		alias.flytonpc("吴劲草")
	end
	--a,b,c=string.find(l,"[> ]*(.+)脚下一个不稳，跌在地上昏了过去。")
	--if c~=nil and not findstring(c,"幻影","->","：") then
	--	mj.npcname=c
	--	run("id here")
	--end
	--a,b,c,d=string.find(l,"^"..mj.npcname.."%s+=%s+(%w+)%s+(%w+),%s*")
	--if c~=nil and d~=nil then mj.npcname=string.lower(d).." "..string.lower(e) end
	if findstring(l,"你只觉真气运转不畅") then
		reyun=1
	end
	if findstring(l,"你已经催动","你脸上青气大盛","你正在运用") then
		reyun=0
	end
	a,b,c,d,e=string.find(l,"[华山|峨嵋|少林|武当]+派弟子%s(.+)%((%w+)%s+(.+)")
	--print(c,"|",d,"|",e)
	if c~=nil and d~=nil and e~=nil and not findstring(c,"强盗","江湖侠士","魔教弟子") then
		if findstring(e,"昏迷不醒") then mj.npcname=string.lower(d) else mj.npcname="" end
		if hp.exp>=650000 or (hp.exp<650000 and findstring(e,"战斗中","昏迷不醒")) then	mj.ydnpc=mj.ydnpc+1	end
	end
	end)
end
------------------------------------------------------------------------------------
-- mp_mj_wxq
------------------------------------------------------------------------------------
function mp_mj_wxq.dosomething1(n,l,w)
	local a,b,c
	if findstring(l,"有一天，你踩着七色云彩来迎娶『.+』") then
		alias.resetidle()
		if havefj>0 then alias.startworkflow() else alias.dz(set_neili_global) end
	end
	if not isopen("boat") and findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
		alias.resetidle()
		alias.wxqask()
		run("checkling")
	end
	a,b,c=string.find(l,"明教任务(.+)")
	if c~=nil and findstring(c,"挑  水") then alias.flytonpc("唐洋")
	elseif c~=nil and findstring(c,"挖地道") then alias.flytonpc("颜垣")
	elseif c~=nil and findstring(c,"砍  树") then alias.flytonpc("闻苍松")
	elseif c~=nil and findstring(c,"采集铁矿") then alias.flytonpc("庄铮")
	elseif c~=nil and findstring(c,"打造火枪") then alias.flytoid(596)
	elseif c~=nil and findstring(c,"无") then alias.wxqask() end
	if findstring(l,"数码世界，数字地图，.+就是这里！") then openclass("mp_mj_wxqjob") end
	if findstring(l,"你小心翼翼地","你挥动铁锹","你挥动大斧","你将铁锹拿在手上","你挥动大铁锤","你放进燃料","精铁已经开始溶化了","你往火枪模子里") then
		alias.resetidle()
	end
	if findstring(l,"木桶这东西可装不了水","你把木桶里的水全部倒进大水缸里","你又挖通了一段地道","你使劲一抬，将刚砍下来的树干扛到肩上","你将一小块乌金矿石拿起来","你已经有一块矿石","我不是已給你铁锤了么","精铁终于炼出来了","你捡起一块硝磺石","火枪已经制成") then
		alias.resetidle()
		closeclass("mp_mj_wxqjob")
		alias.checkbusy("jobover")
	end
	if findstring(l,"你目前还没有任何为 busyover=jobover 的变量设定。") then
		alias.resetidle()
		if roomno_now==461 then alias.flytoid(469)
		elseif roomno_now==469 then roomno_now=466;run("h;w;s;ask tang yang about job;checkling")
		elseif roomname=="地道" then alias.flytoid(554) 
		elseif roomno_now==446 or roomno_now==450 then alias.flytoid(449) 
		elseif roomno_now==590 then alias.flytoid(596) 
		elseif roomno_now==596 then _tb={594,595};alias.flytoid(_tb[math.random(1,2)])
		elseif roomno_now==594 or roomno_now==595 then run("h;nw;n;n;give jing tie to wu jincao")
		elseif roomno_now==539 then alias.flytoid(599) 
		elseif roomno_now==599 then run("h;w;w;give huo qiang to xin ran")
		end
	end
	if findstring(l,"这个火炉已经有人在用了") then
		alias.resetidle()
		if roomno_now==594 then alias.flytoid(595) else alias.flytoid(594) end
	end
end
function mp_mj_wxq.dosomething2(n,l,w)
	local a,b,c,d
	a,b,c,d=string.find(w[0],"你向(.+)打听有关「.+」的消息。\n(.+)")
	if c~=nil and d~=nil and findstring(d,"现在最好去其他旗主那里看看有没有合适的任务") then
		if roomno_now==466 then alias.flytonpc("颜垣")
		elseif roomno_now==554 then alias.flytonpc("闻苍松")
		elseif roomno_now==449 then alias.flytonpc("庄铮")
		elseif roomno_now==597 then alias.flytonpc("辛然")
		elseif roomno_now==444 then alias.flytonpc("唐洋")
		end
	end
end
------------------------------------------------------------------------------------
-- mp_mj_wxqjob
------------------------------------------------------------------------------------
function mp_mj_wxqjob.timer()
	if roomno_now==461 or roomno_now==469 then run("fill tong;dao water into gang")
	elseif roomname=="地道" then run("dig north")
	elseif roomno_now==446 or roomno_now==450 then run("kang shu gan;wield axe;chop tree;unwield axe")
	elseif roomno_now==590 or roomno_now==594 or roomno_now==595 then run("dig;tou 矿石 in 火炉;da 铁")
	elseif roomno_now==539 then run("get xiaohuang shi")
	elseif roomno_now==599 then run("fang 精铁 in 熔炉;dao 铁水 in 火枪模子;add 硝磺 in 火枪模子")
	end
end
------------------------------------------------------------------------------------
-- mp_mj_tyjob
------------------------------------------------------------------------------------
function mp_mj_tyjob.dosomething1(n,l,w)
	local a,b,c,d,e
	a,b,c=string.find(w[0],"有一天，你踩着七色云彩来迎娶『(.+)』")
	if c~=nil and findstring(c,"殷野王") then
		if havefj>0 then alias.startworkflow() else run("ask yin yewang about job") end
	elseif c~=nil and findstring(c,"杨逍","韦一笑","周颠","冷谦","彭莹玉","张中","说不得","清平道人","哈斯","肖济民","吴宝琴","庄铮","吴劲草","唐洋","辛然","颜垣","闻苍松") then
		mj.tyjobnpc=c
		mj.tyjobnpcid=""
		run("id here;set checknpc")
	end
	if not isopen("boat") and findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
		alias.resetidle()
		AddTimer("mj_tyjob_wait_timer",0,0,30,"",timer_flag.Enabled + timer_flag.OneShot, "alias.tlw")
		alias.mjlianwu()
	end
	if findstring(l,"你目前还没有任何为 lian=over 的变量设定。") then
		alias.resetidle()
		closeclass("skills_lian")
		closeclass("dazuo")
		DeleteTimer("mj_tyjob_wait_timer")
		alias.uw()
		if havefj>0 then alias.startworkflow() else run("h;ask yin yewang about job") end
	end
	a,b,c,d=string.find(l,"^"..tostring(mj.tyjobnpc).."%s+=%s+(%w+)%s+(%w+),%s*")
	if c~=nil and d~=nil then
		mj.tyjobnpcid=string.lower(c).." "..string.lower(d)
	end
	if findstring(l,"你目前还没有任何为 checknpc 的变量设定。") then
		alias.resetidle()
		if mj.tyjobnpcid~=nil and mj.tyjobnpcid~="" then run("halt;give mihan to "..mj.tyjobnpcid) end
		alias.flytonpc("殷野王")
	end
	if findstring(l,"双飞，三飞，大家一起飞，先×4 个『 周颠 』中的第.+ 个～～") then
		run("give mihan to zhou dian")
		alias.flytonext()
	end
	if findstring(l,"全部NPC搜索完毕！") then
		alias.flytonpc("殷野王")
	end
end
function mp_mj_tyjob.dosomething2(n,l,w)
	a,b,c=string.find(w[0],"你向殷野王打听有关「job」的消息。\n殷野王(.+)")
	if c~=nil and findstring(c,"最近.+总跟我教做对","教主叫你把.+找来","皱了皱眉，似乎想说什么") then
		run("ask yin yewang about abandon")
		alias.dz(set_neili_global)
	end
end
function mp_mj_tyjob.dosomething3(n,l,w)
	if findstring(w[0],"你向殷野王打听有关「job」的消息。\n殷野王拍了拍你的肩膀。\n殷野王说道：很好，我会禀告教主嘉奖你的！") then
		closeclass("mp_mj_tyjob")
		openclass("mp_mj_pre")
		alias.checkexp("mp")
	end
	a,b,c=string.find(w[0],"你向殷野王打听有关「job」的消息。\n殷野王给你一封密函。\n殷野王说道：教主叫你把这封信送给(.+)，事关重大，快去快回！")
	if c~=nil and findstring(c,"杨逍") then alias.flytonpc("杨逍")
	elseif c~=nil and findstring(c,"韦蝠王") then alias.flytonpc("韦一笑")
	elseif c~=nil and findstring(c,"周颠") then alias.flytonpc("周颠")
	elseif c~=nil and findstring(c,"冷谦") then alias.flytonpc("冷谦")
	elseif c~=nil and findstring(c,"彭莹玉") then alias.flytonpc("彭莹玉")
	elseif c~=nil and findstring(c,"张中") then alias.flytonpc("张中")
	elseif c~=nil and findstring(c,"说不得") then alias.flytonpc("说不得")
	elseif c~=nil and findstring(c,"清平道人") then alias.flytonpc("清平道人")
	elseif c~=nil and findstring(c,"哈斯") then alias.flytonpc("哈斯")
	elseif c~=nil and findstring(c,"肖济民") then alias.flytonpc("肖济民")
	elseif c~=nil and findstring(c,"吴宝琴") then alias.flytonpc("吴宝琴")
	elseif c~=nil and findstring(c,"庄铮") then alias.flytonpc("庄铮")
	elseif c~=nil and findstring(c,"吴劲草") then alias.flytonpc("吴劲草")
	elseif c~=nil and findstring(c,"唐洋") then alias.flytonpc("唐洋")
	elseif c~=nil and findstring(c,"辛然") then alias.flytonpc("辛然")
	elseif c~=nil and findstring(c,"颜垣") then alias.flytonpc("颜垣")
	elseif c~=nil and findstring(c,"闻苍松") then alias.flytonpc("闻苍松")
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function mp_mj.update()
	local  mp_mj_pre_triggerlist={
	       {name="mp_mj_pre_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_mj_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_mj_pre_triggerlist) do
		addtri(v.name,v.regexp,"mp_mj_pre",v.script,v.line)
	end
	closeclass("mp_mj_pre")
	
	local  mp_mj_yudi_triggerlist={
	       {name="mp_mj_yudi_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_mj_yudi.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_mj_yudi_triggerlist) do
		addtri(v.name,v.regexp,"mp_mj_yudi",v.script,v.line)
	end
	closeclass("mp_mj_yudi")
	
	local  mp_mj_wxq_triggerlist={
	       {name="mp_mj_wxq_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_mj_wxq.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_mj_wxq_triggerlist) do
		addtri(v.name,v.regexp,"mp_mj_wxq",v.script,v.line)
	end
	local _tb2={
		"你向.+打听有关「.+」的消息。\\n(.+)\\Z",
	}
	local  mp_mj_wxq_m_triggerlist={
			{name="mp_mj_wxq_m_dosth2",line=2,regexp=linktri2(_tb2),script=function(n,l,w)    mp_mj_wxq.dosomething2(n,l,w)  end,},
	}
	for k,v in pairs(mp_mj_wxq_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_mj_wxq",v.script,v.line)
	end
	closeclass("mp_mj_wxq")
	AddTimer("mp_mj_wxqjob_timer", 0, 0, 1, "", timer_flag.Enabled + timer_flag.Replace, "mp_mj_wxqjob.timer")
	SetTimerOption("mp_mj_wxqjob_timer", "group", "mp_mj_wxqjob")
	closeclass("mp_mj_wxqjob")
	
	local  mp_mj_tyjob_triggerlist={
	       {name="mp_mj_tyjob_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_mj_tyjob.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_mj_tyjob_triggerlist) do
		addtri(v.name,v.regexp,"mp_mj_tyjob",v.script,v.line)
	end
	local _tb2={
		"你向殷野王打听有关「job」的消息。\\n(.+)\\Z",
	}
	local _tb3={
		"你向殷野王打听有关「job」的消息。\\n(.+)\\n(.+)\\Z",
	}
	local  mp_mj_tyjob_m_triggerlist={
			{name="mp_mj_tyjob_m_dosth2",line=2,regexp=linktri2(_tb2),script=function(n,l,w)    mp_mj_tyjob.dosomething2(n,l,w)  end,},
			{name="mp_mj_tyjob_m_dosth3",line=3,regexp=linktri2(_tb3),script=function(n,l,w)    mp_mj_tyjob.dosomething3(n,l,w)  end,},
	}
	for k,v in pairs(mp_mj_tyjob_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_mj_tyjob",v.script,v.line)
	end
	closeclass("mp_mj_tyjob")
	
	local noecho_trilist={
			"你正忙着呢",
			"你现在不忙。",
			"这里没有这个人。",
			"什么？",
			"你并没有装备这样东西作为武器",
			"只能对战斗中的对手使用",
			}
	local _noechotri=linktri(noecho_trilist)

	addtri("mp_mj_watch_gag_dosth1",_noechotri,"mp_mj_watch","")
	SetTriggerOption("mp_mj_watch_gag_dosth1","omit_from_output",1)
end
mp_mj.update()