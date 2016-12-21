xinfa={}
xf_hs={}
xf_em={}
xf_em_resetidle={}
xf_sl={}
sl_sj={}
sl_zc={}
xf_wd={}
wd_xtjf={}
wd_xtjf_fight={}
xf_mj={}

zuochan=0
zuochan_checkchui=0
zuochan_time=0
------------------------------------------------------------------------------------
-- xf_hs
------------------------------------------------------------------------------------
function xf_hs.dosomething1(n,l,w)
	if findstring(l,"你口念咒语『神马都是浮云,虾米都是尘土』，『紫气台』立马到达！") then
		run("look cloud")
	end
	if findstring(l,"你现在正忙着呢！哪有时间看云彩？") then
		alias.resetidle()
		wait.make(function()
			local _f=function() run("look cloud") end
			wait.time(1);_f()
		end)
	end
	if findstring(l,"你的内息在体内流畅地运行了几周，只觉全身舒畅。","你领悟了紫氤吟的几个疑难！","你领悟了正气诀的几个疑难！","你领悟了紫霞功的几个疑难！") then
		alias.resetidle()
		alias.checkbusy("lookcloud")
	end
	if findstring(l,"只见云雾翻滚，四周的山峦飘浮其中，如同仙境一般。") then
		alias.resetidle()
		guanyuntime=0
		alias.startworkflow()
	end
	if findstring(l,"你目前还没有任何为 busyover=lookcloud 的变量设定。") then
		alias.resetidle()
		alias.setmpLimitedMark()
		if havefj>0 then
			alias.startworkflow()
		else
			run("yun regenerate;look cloud")
		end
	end
	if findstring(w[0],"你看着这瑰丽奇景，忽然想起师父的平日的教导，\n深觉自己对匡扶武林正气做得不够，不禁一阵羞愧。") then
		alias.startworkflow()
	end
end
------------------------------------------------------------------------------------
-- xf_em
------------------------------------------------------------------------------------
function xf_em.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"你盘膝坐下，闭上眼睛开始修练。") then
			openclass("xf_em_resetidle")
		end
		if findstring(l,"一个.+弟子走了过来,对你报拳道：“在下奉掌门灭绝师太之命，请你速回.+处晋见”。") then
			run("halt")
		end
		if findstring(l,"忽然外面传来一阵噪杂声，你只觉心烦意乱，不能静心修练") then
			alias.resetidle()
			if havefj>0 then
				alias.startworkflow()
			else
				_f=function() run("jingzuo") end
				wait.time(2);_f()
			end
		end
		if findstring(l,"你的潜能增加了零点！") then
			alias.resetidle()
			closeclass("xf_em_resetidle")
			if havefj>0 then
				alias.startworkflow()
			elseif mpJobLimited>0 and skillsfull>0 then
				run("jingzuo")
			else
				alias.startworkflow()
			end
		end
		if findstring(l,"你缓缓睁开眼睛，长舒一口气站了起来。") then
			alias.resetidle()
			closeclass("xf_em_resetidle")
			if havefj>0 then
				alias.startworkflow()
			else
				run("jingzuo")
			end
		end
		if findstring(l,"你心烦意乱，睁开眼睛站了起来。") then
			alias.resetidle()
			closeclass("xf_em_resetidle")
			alias.startworkflow()
		end
		if findstring(l,"你现在体力不够，难以凝聚体能静修。") then
			alias.resetidle()
			run("yun recover")
			if havefj>0 then
				alias.startworkflow()
			else
				_f=function() run("jingzuo") end
				wait.time(1);_f()
			end
		end
		if findstring(l,"数码世界，数字地图，370就是这里！") then
			alias.resetidle()
			run("yun regenerate;yun recover")
			alias.yjl()
			run("jingzuo")
		end
		if findstring(l,"你现在精不够，无法控制心魔静修。") then
			alias.resetidle()
			alias.yunem()
			if havefj>0 then
				alias.startworkflow()
			else
				_f=function() run("yun regenerate;jingzuo") end
				wait.time(1);_f()
			end
		end
	end)
end
------------------------------------------------------------------------------------
-- xf_em_resetidle
------------------------------------------------------------------------------------
function xf_em_resetidle.timer()
	alias.resetidle()
end
------------------------------------------------------------------------------------
-- sl_sj
------------------------------------------------------------------------------------
function sl_sj.dosomething1(n,l,w)
	local _f,a,b,c,d
	wait.make(function()
		if findstring(l,"你诵经过度，精力不足，无法继续！") then
			_f=function() run("yun regenerate;yun refresh;ask kumu about job") end
			wait.time(1);_f()
		end
		if findstring(l,"你向枯木禅师打听有关「job」的消息。","你敲击木鱼高声诵吟：") then
			alias.resetidle()
		end
		a,b,c,d=string.find(l,"禅宗心法%s+%(buddhism%)%s+ - %S+%s+(%d+)/%s*(%d+)")
		if c~=nil and d~=nil then
			if tonumber(d)>((tonumber(c)+1)*(tonumber(c)+1)) then zuochan=1 else zuochan=0 end
		end
		if findstring(l,"你目前还没有任何为 busyover=songjing 的变量设定。") then
			alias.close_xinfa()
			alias.startworkflow()
		end
		if findstring(l,"你忙着呢，你等会儿在问话吧。") then
			alias.resetidle()
			_f=function() if havefj>0 or zuochan>0 then alias.checkbusy("songjing") else run("ask kumu about job") end end
			wait.time(1);_f()
		end
		if findstring(l,"数码世界，数字地图，1131就是这里！") then
			alias.resetidle()
			run("ask kumu about job")
		end
		if findstring(l,"一名小僧过来对你说道：大师辛苦了，您休息一下吧。") then
			alias.resetidle()
			run("skills -e")
			if havefj>0 or zuochan>0 then alias.checkbusy("songjing") else run("ask kumu about job") end
		end
		if findstring(w[0],"你向枯木禅师打听有关「job」的消息。\n枯木禅师说道：本寺撞钟诵经时辰已过，大师下次再来吧。") then
			alias.resetidle()
			alias.close_xinfa()
			alias.startworkflow()
		end
	end)
end
function sl_sj.timer()
	alias.resetidle()
end
------------------------------------------------------------------------------------
-- sl_zc
------------------------------------------------------------------------------------
function sl_zc.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"你进入了佛我两忘的境界，顿时淡泊了习武好胜之心。") then
			alias.resetidle()
			zuochan_time=0
			run("set checkreback")
		end
		if findstring(l,"你从佛我两忘的幻境中又回到了尘世。") then
			alias.resetidle()
			zuochen_reback=1
		end
		if findstring(l,"你目前还没有任何为 checkreback 的变量设定。") then
			alias.resetidle()
			if zuochen_reback==1 then
				print("忘我时间："..zuochan_time.." 秒")
				alias.close_xinfa()
				zuochan=0
				alias.jfsl()
				alias.startworkflow()
			else
				_f=function()
							print("忘我时间："..zuochan_time.." 秒")
							zuochan_time=zuochan_time+10
							run("set checkreback")
					end
				wait.time(10);_f()
			end
		end
		if findstring(l,"你捡起一把木鱼槌。") then
			if zuochan_checkchui==1 then
				zuochan_checkchui=0
				alias.flytoid(1641)
			end
		end
		if findstring(l,"你附近没有这样东西。") then
			if zuochan_checkchui==1 then
				zuochan_checkchui=0
				alias.startworkflow()
			end
		end
		if findstring(l,"你刚坐禅过。") then
			alias.close_xinfa()
			alias.startworkflow()
		end
		if findstring(l,"数码世界，数字地图，1703就是这里！") then
			alias.resetidle()
			run("drop chui;get chui")
		end
		if findstring(l,"你正在使用金刚不坏体神功，没办法静修。","数码世界，数字地图，1641就是这里！") then
			alias.resetidle()
			zuochen_reback=0
			run("yun sangong;yun regenerate;yun recover;yun refresh;zuochan")
		end
	end)
end
------------------------------------------------------------------------------------
-- wd_xtjf
------------------------------------------------------------------------------------
function wd_xtjf.dosomething1(n,l,w)
	local _f,a,b,c
	wait.make(function()
		if findstring(l,"你身行向后一跃，跳出战圈不打了。") then
			if isopen("wd_xtjf_fight") then
				alias.resetidle()
				closeclass("wd_xtjf_fight")
				run("halt")
				alias.uw()
				alias.checkbusy("tongren")
			end
		end
		if findstring(l,"铜人已经无法战斗了。") then
			closeclass("wd_xtjf_fight")
			_f=function() alias.flytonext() end
			wait.time(1);_f()
		end
		if findstring(l,"这个铜人已经被打坏了！","铜人已经无法战斗了。","铜人脚下一个不稳，跌在地上昏了过去。","铜人倒在地上，挣扎了几下就死了。","你想攻击谁？","看起来铜人并不想跟你较量") then
			alias.resetidle()
			closeclass("wd_xtjf_fight")
			_f=function() if tongren~=nil and tongren==3 then alias.flytonpc("铜人") else alias.flytonext() end end
			wait.time(2);_f()
		end
		if findstring(l,"[> ]*(.+)哈哈大笑，说道：承让了！","你脸色微变，说道：佩服，佩服！","你向后一纵，躬身做揖说道：阁下武艺不凡，果然高明！","[> ]*(.+)胜了这招，向后跃开三尺，笑道：承让！","[> ]*(.+)双手一拱，笑著说道：承让！","铜人脸色微变，说道：佩服，佩服！","铜人向后退了几步，说道：这场比试算我输了，佩服，佩服！","铜人向后一纵，躬身做揖说道：阁下武艺不凡，果然高明！","这场比试算我输了，佩服，佩服！") then
			alias.resetidle()
			closeclass("wd_xtjf_fight")
			run("halt")
			alias.uw()
			alias.checkbusy("tongren")
		end
		if findstring(l,"你目前还没有任何为 busyover=tongren 的变量设定。") then
			alias.resetidle()
			alias.jfwd()
			run("hp;set check=neili")
		end
		if findstring(l,"你目前还没有任何为 check=neili 的变量设定。") then
			alias.resetidle()
			if havefj>0 then
				alias.startworkflow()
			elseif hp.neili<(hp.maxneili*set_neili_job/100) then
				alias.dz(set_neili)
			else
				openclass("wd_xtjf_fight")
				run("jifa sword xuantie-jianfa;jifa parry none;jifa dodge none;bei none;fight tong ren")
			end
		end
		a,b,c=string.find(l,"双飞，三飞，大家一起飞，先×3 个『 铜人 』中的第 (%d+) 个～～")
		if c~=nil then
			alias.resetidle()
			tongren=tonumber(c)
			openclass("wd_xtjf_fight")
			run("jifa sword xuantie-jianfa;jifa parry none;jifa dodge none;bei none;fight tong ren")
		end
		if findstring(l,"你对著铜人说道.+领教壮士的高招！") then
			alias.resetidle()
			alias.uw()
			alias.wi("zhongjian")
			run("unset no_parry;jifa dodge tiyunzong;jifa parry xuantie-jianfa;bei taiji-quan mian-zhang")
		end
	end)
end
------------------------------------------------------------------------------------
-- wd_xtjf_fight
------------------------------------------------------------------------------------
function wd_xtjf_fight.timer()
	alias.resetidle()
	run("hp")
	if havefj>0 then run("halt") end
end
------------------------------------------------------------------------------------
-- xf_mj
------------------------------------------------------------------------------------
function xf_mj.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"你的潜能不足","请明早再来朝拜") then chaobaitime=0;alias.startworkflow() end
		if findstring(l,"你的二宗三际修为不够","你的二宗三际修为已经大成") then workflow.xf=0;alias.startworkflow() end
		if findstring(l,"你目前还没有任何为 chaobai 的变量设定。") then
			run("yun regenerate")
			_f=function() for i=1,10,1 do run("chaobai") end end
			wait.time(1);_f()
			run("set chaobai")
		end
		if roomname=="新门吊桥" and findstring(l,"这个方向没有出路。") then	alias.startworkflow() end
		if findstring(l,"数码世界，数字地图，56就是这里！") then run("set chaobai")	end
	end)
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function xinfa.update()
	local  xf_hs_triggerlist={
	       {name="xf_hs_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    xf_hs.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(xf_hs_triggerlist) do
		addtri(v.name,v.regexp,"xf_hs",v.script,v.line)
	end
	local _tb={
		"你看着这瑰丽奇景，忽然想起师父的平日的教导，\\n深觉自己对匡扶武林正气做得不够，不禁一阵羞愧。\\Z",
	}
	local  xf_hs_m_triggerlist={
	       {name="xf_hs_m_dosth1",line=2,regexp=linktri(_tb),script=function(n,l,w)    xf_hs.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(xf_hs_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"xf_hs",v.script,v.line)
	end
	closeclass("xf_hs")
	
	local  xf_em_triggerlist={
	       {name="xf_em_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    xf_em.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(xf_em_triggerlist) do
		addtri(v.name,v.regexp,"xf_em",v.script,v.line)
	end
	closeclass("xf_em")
	
	AddTimer("xf_em_resetidle_timer", 0, 0, 5, "", timer_flag.Enabled + timer_flag.Replace, "xf_em_resetidle.timer")
	SetTimerOption("xf_em_resetidle_timer", "group", "xf_em_resetidle")
	closeclass("xf_em_resetidle")
	
	local  sl_sj_triggerlist={
	       {name="sl_sj_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    sl_sj.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(sl_sj_triggerlist) do
		addtri(v.name,v.regexp,"sl_sj",v.script,v.line)
	end
	local _tb={
		"你向枯木禅师打听有关「job」的消息。\\n枯木禅师说道：本寺撞钟诵经时辰已过，大师下次再来吧。\\Z",
	}
	local  sl_sj_m_triggerlist={
	       {name="sl_sj_m_dosth1",line=2,regexp=linktri(_tb),script=function(n,l,w)    sl_sj.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(sl_sj_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"sl_sj",v.script,v.line)
	end
	AddTimer("sl_sj_timer", 0, 0, 10, "", timer_flag.Enabled + timer_flag.Replace, "sl_sj.timer")
	SetTimerOption("sl_sj_timer", "group", "sl_sj")
	closeclass("sl_sj")
	
	local  sl_zc_triggerlist={
	       {name="sl_zc_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    sl_zc.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(sl_zc_triggerlist) do
		addtri(v.name,v.regexp,"sl_zc",v.script,v.line)
	end
	closeclass("sl_zc")
	
	local  wd_xtjf_triggerlist={
	       {name="wd_xtjf_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    wd_xtjf.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(wd_xtjf_triggerlist) do
		addtri(v.name,v.regexp,"wd_xtjf",v.script,v.line)
	end
	closeclass("wd_xtjf")
	
	AddTimer("wd_xtjf_fight_timer", 0, 0, 5, "", timer_flag.Enabled + timer_flag.Replace, "wd_xtjf_fight.timer")
	SetTimerOption("wd_xtjf_fight_timer", "group", "wd_xtjf_fight")
	closeclass("wd_xtjf_fight")
	
	local  xf_mj_triggerlist={
	       {name="xf_mj_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    xf_mj.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(xf_mj_triggerlist) do
		addtri(v.name,v.regexp,"xf_mj",v.script,v.line)
	end
	closeclass("xf_em")
end
xinfa.update()
