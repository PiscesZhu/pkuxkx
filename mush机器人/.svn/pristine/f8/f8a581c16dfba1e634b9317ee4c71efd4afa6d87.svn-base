mp_dl={}
mp_dl_pre={}
mp_dl_watch={}
mp_dl_work={}
mp_dl_start={}
mp_dl_dowork={}


dl.dlcen="sd|sd|se|eu|e|n|enter|out|s|eu|eu|n|nu|n|s|sd|s|e|se|e|s|u|d|n|e|ne|eu|ed|wu|wd|sw|w|w|sw|w|wu|wd|sd|nw|n|enter|out|s|se|s|nw|wd|eu|se|se|s|n|nw|n|nu|nu|nw|nu|nu"
dl.dleast="sw|w|wu|wd|nu|eu|e|n|enter|out|s|eu|eu|n|nu|n|s|sd|s|e|se|e|s|u|d|n|e|ne|eu|ed|ne|e|u|d|w|sw|su|nd|sw|su|sd|ed|s|eu|wd|n|e|w|n|w|u|d|e|s|wu|nu|nd|ne|wu|wd|sw|w|w"
dl.dlwest="wu|wu|wu|wd|wd|n|w|enter|out|e|n|se|nw|nu|n|e|e|ne|sw|w|w|s|sd|s|s|s|s|wu|w|e|ed|se|s|n|ne|wu|n|eu|sd|sw|se|ed|wu|nw|ne|nu|ed|ed|ed"
dl.dlsouth="s|s|s|e|w|sw|sw|s|n|n|s|w|u|d|e|ne|ne|s|eu|e|w|s|n|n|u|u|d|d|s|wd|se|se|nw|s|w|e|nw|sw|ne|se|n|nw|n|n|n|n"
dl.dlnorth="n|ne|e|w|n|s|sw|nw|sw|w|w|s|sd|se|su|wd|n|w|enter|out|e|n|nu|n|e|e|ne|nd|n|nu|nu|nd|su|eu|eu|wd|s|n|n|s|wd|sd|sd|s|su|se|s"
dl.needquit=0

dl.zeiid=""
dl.zeiname=""
------------------------------------------------------------------------------------
-- mp_dl_pre
------------------------------------------------------------------------------------
function mp_dl_pre.dosomething1(n,l,w)
	local _f,a,b,c
		if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
			alias.resetidle()
			alias.dz(100)
		end
		if not isopen("boat") and findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
			alias.resetidle()
			if dl.needquit>0 then alias.flytoid(177) else alias.flytonpc(dl.jobnpc) end
		end
		if findstring(l,"数码世界，数字地图，177就是这里！") then
			alias.resetidle()
			dl.needquit=0
			openclass("quit")
		end
		a,b,c=string.find(l,"有一天，你踩着七色云彩来迎娶『(.+)』")
		if c~=nil and findstring(c,"范骅") then run("ask fan ye about 治安")
		elseif c~=nil and findstring(c,"巴天石") then run("ask ba tianshi about 治安")
		elseif c~=nil and findstring(c,"华赫艮") then run("ask hua hegen about 治安")
		elseif c~=nil and findstring(c,"段陉") then
			run("give "..dl.zeiid.." to duan xing;ask duan xing about 功劳;ask duan xing about 升职")
			alias.checkexp("mp")
		end
		if findstring(l,"你忙着呢，你等会儿在问话吧。","对方正忙着呢，你等会儿在问话吧。") then
			alias.resetidle()
			wait.make(function()
			_f=function()
				if roomno_now==181 then run("ask hua hegen about 治安")
				elseif roomno_now==180 then	run("ask ba tianshi about 治安")
				elseif roomno_now==182 then run("ask fan ye about 治安")
				end
			end
			wait.time(1);_f()
			end)
		end
		if findstring(l,"你目前还没有任何为 checkexpover=mp 的变量设定。") then
			alias.resetidle()
			if add.exp>10 and mpLimited.MarkExp<me.menpaiLimited then mpLimited.MarkExp=tonumber(me.menpaiLimited) end
			if add.exp<10 then
				mpJobLimited=1
				print("统计到的arrest上限为："..mpLimited.mpexp)
				mpLimited.MarkExp=mpLimited.mpexp
				if mpLimited.MarkTime<(os.time()-3600) then
					-- 到arrest时间却仍然busy，推迟2分钟
					mpLimited.MarkTime=tonumber(os.time()-3600+120)
				end
			end
			--alias.checkbusy("arrest")
			if havefj>0 or me.menpai~="dl" then alias.startworkflow()
			else
				closeclass("mp_dl_pre")
				openclass("mp_dl_work")
				closeclass("mp_dl_dowork")
				alias.flytoid(289)
			end
		end
		--if findstring(w[0],"你向[范骅|巴天石|华赫艮]+打听有关「治安」的消息。\n[范骅|巴天石|华赫艮]+说道：你先把你手头的活干完吧") then
		--	alias.resetidle()
		--	dl.needquit=1
		--	alias.flytoid(177)
		--end
		--if findstring(w[0],"你向[范骅|巴天石|华赫艮]+打听有关「治安」的消息。\n[范骅|巴天石|华赫艮]+[说道：.+和我大理素无瓜葛|轻轻地拍了拍你的头|皱了皱眉，似乎想对你说些什么]+") then
		--	do_dl_job=0
		--	alias.startworkflow()
		--end
		--if findstring(w[0],"你向[范骅|巴天石|华赫艮]+打听有关「治安」的消息。\n[范骅|巴天石|华赫艮]+说道：我这里现在没什么要紧的事情") then
		--	alias.resetidle()
		--	if havefj>0 then alias.startworkflow()
		--	else
				--if findstring(c,"范骅") then alias.flytonpc("巴天石") end
				--if findstring(c,"巴天石") then alias.flytonpc("华赫艮") end
				--if findstring(c,"华赫艮") then alias.flytonpc("范骅") end
		--		if roomno_now==181 then run("ask hua hegen about 治安")
		--		elseif roomno_now==180 then	run("ask ba tianshi about 治安")
		--		elseif roomno_now==182 then run("ask fan ye about 治安")
		--		else alias.flytonpc(dl.jobnpc) end
		--	end
		--end
		--a,b,c=string.find(w[0],"你向[范骅|巴天石|华赫艮]+打听有关「治安」的消息。\n[范骅|巴天石|华赫艮]+说(.+)")
		a,b,c=string.find(w[0],"你向[范骅|巴天石|华赫艮]+打听有关「治安」的消息。\n[范骅|巴天石|华赫艮]+(.+)")
		if c~=nil and findstring(c,"和我大理素无瓜葛","轻轻地拍了拍你的头","似乎想对你说些什么") then
			alias.resetidle()
			do_dl_job=0
			alias.startworkflow()
		end
		if c~=nil and findstring(c,"你先把你手头的活干完吧") then
			alias.resetidle()
			dl.needquit=1
			alias.flytoid(177)
		end
		if c~=nil and findstring(c,"我这里现在没什么要紧的事情") then
			alias.resetidle()
			if havefj>0 then alias.startworkflow()
			else
				if roomno_now==181 then run("ask hua hegen about 治安")
				elseif roomno_now==180 then	run("ask ba tianshi about 治安")
				elseif roomno_now==182 then run("ask fan ye about 治安")
				else alias.flytonpc(dl.jobnpc) end
			end
		end
		if c~=nil and findstring(c,"北方","北面","北部","乌弄城","剑川") then
			alias.resetidle()
			print("任务在北部")
			dl.search=dl.dlnorth
			dl.searchroom=169
			closeclass("mp_dl_pre")
			openclass("mp_dl_start")
			dl.searchjs=0
			alias.flytoid(169)
		end
		if c~=nil and findstring(c,"东方","东面","东部","阳宗镇","星云湖畔","步雄部","罗伽甸","滇池","沿池堤岸") then
			alias.resetidle()
			print("任务在东部")
			dl.search=dl.dleast
			dl.searchroom=251
			closeclass("mp_dl_pre")
			openclass("mp_dl_start")
			dl.searchjs=0
			alias.flytoid(251)
		end
		if c~=nil and findstring(c,"南面","南方","南部","喜州城","妃丽湖","鲁望镇","武定镇","河西镇","龙口城") then
			alias.resetidle()
			print("任务在南部")
			dl.search=dl.dlsouth
			dl.searchroom=143
			closeclass("mp_dl_pre")
			openclass("mp_dl_start")
			dl.searchjs=0
			alias.flytoid(143)
		end
		if c~=nil and findstring(c,"西方","西面","西部","巴的甸","蜜纳甸","碧罗雪山","泸水沿岸","易溪部","阿头部","镇雄","葛鲁城") then
			alias.resetidle()
			print("任务在西部")
			dl.search=dl.dlwest
			dl.searchroom=171
			closeclass("mp_dl_pre")
			openclass("mp_dl_start")
			dl.searchjs=0
			alias.flytoid(171)
		end
		if c~=nil and findstring(c,"中方","中面","中部","黑龙岭","石刻经幢","金汁河畔","大叠水瀑布") then
			alias.resetidle()
			print("任务在中部")
			dl.search=dl.dlcen
			dl.searchroom=231
			closeclass("mp_dl_pre")
			openclass("mp_dl_start")
			dl.searchjs=0
			alias.flytoid(231)
		end
end
------------------------------------------------------------------------------------
-- mp_dl_start
------------------------------------------------------------------------------------
function mp_dl_start.dosomething1(n,l,w)
	local _f,_tb,a,b,c,d,e,f
	wait.make(function()
		a,b,c=string.find(l,"数码世界，数字地图，(%d+)就是这里！")
		if c~=nil and (tonumber(c)==143 or tonumber(c)==169 or tonumber(c)==171 or tonumber(c)==231 or tonumber(c)==251) then
			alias.resetidle()
			dl.findzei=0
			dl.searchid=1
			dl.err=0
			alias.dz(set_neili_job)
		end
		if not isopen("boat") and findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
			alias.resetidle()
			alias.uw()
			run("wield chain;set search=yes")
		end
		if findstring(l,"你目前还没有任何为 checkzei=yes 的变量设定。") then
			alias.resetidle()
			if (dl.findzei==nil or dl.findzei==0) or (dl.err~=nil and dl.err>10) then run("set search=yes")
			else
				if dl.findzei~=nil and dl.findzei<2 then
					-- run("fight "..dl.zeiid..";halt")
					run("arrest "..dl.zeiid)
					_f=function() run("set checkzei=yes") end
					wait.time(2);_f()
				end
			end
		end
		if findstring(l,"你目前还没有任何为 search=yes 的变量设定。") then
			alias.resetidle()
			if dl.err~=nil and dl.err>5 then alias.flytoid(dl.searchroom)
			else
				if dl.findzei~=nil and dl.findzei>0 then
					run("arrest "..dl.zeiid..";ask "..dl.zeiid.." about 治安;set checkzei=yes")
					alias.yjl()
				else
					_tb=utils.split(dl.search,"|")
					if tonumber(dl.searchid)>tonumber(table.getn(_tb)) then dl.searchid=1
					dl.searchjs=dl.searchjs+1
					if dl.searchjs>20 then 
						closeclass("mp_dl_start")
						openclass("mp_dl_pre")
						dl.needquit=1
						alias.flytoid(177)
					end
					end
					run("halt;".._tb[dl.searchid])
					dl.searchid=dl.searchid+1
					run("set search=yes")
					--_f=function() run("set search=yes") end
					--wait.time(0.5);_f()
				end
			end
		end
		a,b,c,d,e,f=string.find(l,"(%S+) (%S+)%((%w+) (%w+)%)")
		if c~=nil and d~=nil and e~=nil and f~=nil then
			if dl.findzei==nil or dl.findzei==0 and string.find("帮匪|草寇|盗匪|盗贼|盗贼王|地痞|独行盗|恶霸|流寇|流氓|流氓头|路霸|毛贼|蒙面客|强盗|强盗头|抢匪|山大王|山贼|山贼头|山寨大王|土匪|土匪头|无赖|小贼|一品堂杀手|贼头",d) then
				dl.findzei=1
				dl.zeiname=d
				dl.zeiid=string.lower(e).." "..string.lower(f)
			end
		end
		if findstring(l,"你喝道：大胆！竟敢在本官面前行抢！走！见官去！","你高喊一声：大理境内休得撒野！走！跟我见官去！","你喝道：可恶！竟敢在此调戏良家妇女！跟我回去见官！") then
			alias.resetidle()
			dl.findzei=2
			_tb=utils.split(mpyun,"|")
			for k,v in ipairs(_tb) do run(v) end
			openclass("kill")
			run("unset no_parry;unwield chain")
			openclass("kill_"..me.menpai)
			closeclass("kill_run")
			AddTimer("kill_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "kill.timer")
			SetTimerOption("kill_timer", "group", "kill")
			reyun=1
			runaway=false
			npcfaint=false
			killRunSuccess=false
			killid=dl.zeiid
			killname=dl.zeiname
			killskill=mpweapon
			killpfm=mppfm
			killyun=mpyun
			killjiali=mpjiali
			killjiajin=mpjiajin
			run("yield no;jiali "..mpjiali..";jiajin "..mpjiajin)
			if string.len(mpweapon)>0 then
				if mpweapon=="staff" then alias.wi(staffid) else alias.wi(mpweapon) end
			else alias.uw() end
			_tb=utils.split(mppfm,"|")
			for k,v in ipairs(_tb) do run(v) end
		end
		if findstring(l,"你目前还没有任何为 killover=yes 的变量设定。","对方还没有完全昏迷，先等等吧。") then
			alias.resetidle()
			_f=function() for i=1,3,1 do run("get "..dl.zeiid.." "..i) end end
			wait.time(1);_f()
		end
		if findstring(l,"你将"..dl.zeiname.."扶了起来背在背上。") then
			alias.resetidle()
			closeclass("mp_dl_start")
			openclass("mp_dl_pre")
			alias.flytonpc("段陉")
		end
		if findstring(l,"人家没在惹事生非，你锁捕不了") then
			dl.findzei=1
			dl.err=1
		end
		if findstring(l,"这里并无此人！","这个方向没有出路。") then
			if dl.err==nil then dl.err=0 end
			dl.err=dl.err+1
		end
		if findstring(l,"此人已经交给其他官员处理","这不是活物","这里没有.+这个人。") then
			dl.findzei=0
		end
		if findstring(l,"你受伤过重","你已经受伤过重","你已经陷入半昏迷状态","你受了相当重的伤","你伤重之下已经难以支撑") then
			dl.needquit=1
			alias.startworkflow()
		end
		a,b,c=string.find(l,"[> ]*"..dl.zeiname.."+(.+)")
		if c~=nil and dl.findzei>0 and findstring(c,"跌在地上昏了过去") then
			alias.resetidle()
			run("yield yes;halt")
			alias.checkbusy("killover")
		end
		if c~=nil and dl.findzei>0 and findstring(c,"挣扎了几下就死了","急匆匆地走了") then
			alias.resetidle()
			dl.needquit=1
			alias.startworkflow()
		end
		if c~=nil and dl.findzei>0 and findstring(c,"对你而言太重了") then
			alias.resetidle()
			_f=function()
			--if fjweapon~="" then run("get "..fjweapon) end
			--if mpweapon~="" then run("get "..mpweapon) end
			--if ftbweapon~="" then run("get "..ftbweapon) end
			for i=1,3,1 do run("get all from "..dl.zeiid.." "..i) end
			if have.jingyao>0 then run("get jing yao") end
			run("drop all;get "..weapon_now..";get chain;get huachu;get tengjia;get jiudai;get shi he;get fire;get gold;get coin;get jinchuang yao")
			for i=1,3,1 do run("get "..dl.zeiid.." "..i) end
			end
			wait.time(2);_f()
		end
	end)
end
function mp_dl_start.dosomething2(n,l,w)
	local _f,_tb,a,b,c
	--wait.make(function()
		a,b,c=string.find(w[0],"你向"..dl.zeiname.."打听有关「治安」的消息。\n"..dl.zeiname.."+(.+)")
		if c~=nil and findstring(c,"大理是个好地方","「嘿嘿嘿」奸笑了几声") then
			dl.findzei=1
			run("follow "..dl.zeiid)
		end
		if c~=nil and findstring(c,"大理的风景怡人","「呵呵呵」地笑了几声","无可奉告","没听说过","睁大眼睛望着你","这我可不清楚","你问的事我实在没有印象","你在说外国话吧","你说什么鸟语","我也能假装会说外国话") then
			dl.findzei=0
		end
	--end)
end
--function mp_dl_start.dosomething3(n,l,w)
	--local _f,_tb,a,b,c,d
	--wait.make(function()
	--	if findstring(l,"你向"..dl.zeiname.."打听有关「治安」的消息。\n"..dl.zeiname.."「嘿嘿嘿」奸笑了几声。\n"..dl.zeiname.."说道：大理是个好地方，我都流连忘返啦，嘿嘿") then
	--		dl.findzei=1
	--		run("follow "..dl.zeiid)
	--	end
	--	if findstring(l,"你向"..dl.zeiname.."打听有关「治安」的消息。\n"..dl.zeiname.."「呵呵呵」地笑了几声。\n"..dl.zeiname.."说道：大理的风景怡人，治安方面还算可以。") then
	--		dl.findzei=0
	--	end
	--end)
--end
------------------------------------------------------------------------------------
-- mp_dl_work
------------------------------------------------------------------------------------
function mp_dl_work.dosomething1(n,l,w)
	local _f,a,b,c
	wait.make(function()
		if findstring(l,"你目前还没有任何为 busyover=work 的变量设定。") then
		alias.resetidle()
			if havefj>0 or dl.worked>0 then
				run("get all")
				alias.flytonpc("何红药")
			else run("ask huajiang about check;ask huajiang about 干活") end
		end
		if not isopen("dealwith_sellyao") and findstring(l,"有一天，你踩着七色云彩来迎娶『何红药』") then
			alias.resetidle()
			if hp.neili<(hp.maxneili*160/100) then alias.checkdrugbusy("da xueteng") end
			alias.checkitems()
		end
		if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
			alias.resetidle()
			alias.startworkflow()
		end
		if not isopen("boat") and findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
			alias.resetidle()
			if dl.dohuajiangwork>0 then
				print("开始种花")
				run("find huachu")
				alias.flytoid(200)
			else
				--alias.checkbusy("work")
				alias.startworkflow()
			end
		end
		if findstring(l,"你从泥里挖出一个大血藤") then
			have.xueteng=have.xueteng+1
		end
		if findstring(l,"你丢下一棵大血藤","你吃下一.+大血藤") then
			have.xueteng=have.xueteng-1
		end
		if findstring(l,"你从泥里挖出一个当归") then
			have.danggui=have.danggui+1
		end
		if findstring(l,"你丢下一棵当归") then
			have.danggui=have.danggui-1
		end
		if findstring(l,"你忙着呢，你等会儿在问话吧。") then
			alias.resetidle()
			_f=function() run("ask huajiang about check;ask huajiang about 干活") end
			wait.time(2);_f()
		end
		if findstring(l,"数码世界，数字地图，200就是这里！") then
			alias.resetidle()
			if havefj>0 then alias.startworkflow()
			else run("ask huajiang about check;ask huajiang about 干活") end
		end
		if findstring(l,"数码世界，数字地图，289就是这里！") then
			alias.resetidle()
			dl.worked=0
			_f=function() run("open door;enter;drop huachu;remove all;give tengjia to gu ducheng;set no_accept 0;ask gu ducheng about 藤甲;set no_accept 1;wear all") end
			wait.time(2);_f()
			alias.dz(100)
		end
		if findstring(w[0],"花匠对你点点头，满意地说：“够了，够了，今天的活就干到这里吧。\n花匠对你竖起大拇指：“你如此勤勉，有朝一日必成一个大花匠。") then
			alias.resetidle()
			closeclass("mp_dl_dowork")
			alias.checkbusy("work")
		end
		if findstring(w[0],"你向花匠打听有关「干活」的消息。\n花匠说道：您干了不少活了") then
			alias.resetidle()
			dl.worked=1
			alias.checkbusy("work")
		end
		if findstring(w[0],"你向花匠打听有关「干活」的消息。\n花匠说道：好极了。我这里正需要人手修整园子，你帮我除草松土吧。","你向花匠打听有关「干活」的消息。\n花匠说道：你先把手头的活干完再说吧。") then
			alias.uw()
			run("wield huachu")
			openclass("mp_dl_dowork")
		end
		a,b,c=string.find(w[0],"你向花匠打听有关「check」的消息。\n花匠对着你点了点头。\n花匠说道：到目前为止你一共做了(%d+)个任务！")
		if c~=nil then
			dl.workcs=tonumber(c)
		end
	end)
end
------------------------------------------------------------------------------------
-- mp_dl_dowork
------------------------------------------------------------------------------------
function mp_dl_dowork.timer()
	alias.resetidle()
	if have.xueteng>0 then if hp.neili<(hp.maxneili*160/100) then alias.checkdrugbusy("da xueteng") end;run("drop da xueteng") end
	if have.danggui>0 then run("drop dang gui") end
	run("work")
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function mp_dl.update()
	AddTimer("mp_dl_dowork_timer", 0, 0, 1, "", timer_flag.Enabled + timer_flag.Replace, "mp_dl_dowork.timer")
	SetTimerOption("mp_dl_dowork_timer", "group", "mp_dl_dowork")
	closeclass("mp_dl_dowork")
	
	local  mp_dl_pre_triggerlist={
	       {name="mp_dl_pre_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_dl_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_dl_pre_triggerlist) do
		addtri(v.name,v.regexp,"mp_dl_pre",v.script,v.line)
	end
	local  mp_dl_pre_m_triggerlist={
	       {name="mp_dl_pre_m_dosth1",line=2,regexp="^(> > > |> > |> |)你向(范骅|巴天石|华赫艮+)打听有关「治安」的消息。\\n(.+)\\Z",script=function(n,l,w)    mp_dl_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_dl_pre_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_dl_pre",v.script,v.line)
	end
	closeclass("mp_dl_pre")
	
	local  mp_dl_start_triggerlist={
	       {name="mp_dl_start_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_dl_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_dl_start_triggerlist) do
		addtri(v.name,v.regexp,"mp_dl_start",v.script,v.line)
	end
	local  mp_dl_start_m_triggerlist={
	       {name="mp_dl_start_m_dosth1",line=2,regexp="^(> > > |> > |> |)你向.+打听有关「治安」的消息。\\n(.+)\\Z",script=function(n,l,w)    mp_dl_start.dosomething2(n,l,w)  end,},
	      -- {name="mp_dl_start_m_dosth2",line=3,regexp="^(> > > |> > |> |)你向.+打听有关「治安」的消息。\\n(.+)\\n(.+)\\Z",script=function(n,l,w)    mp_dl_start.dosomething3(n,l,w)  end,},
	}
	for k,v in pairs(mp_dl_start_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_dl_start",v.script,v.line)
	end
	closeclass("mp_dl_start")
	
	local  mp_dl_work_triggerlist={
	       {name="mp_dl_work_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_dl_work.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_dl_work_triggerlist) do
		addtri(v.name,v.regexp,"mp_dl_work",v.script,v.line)
	end
	local _tb={
		"你向花匠打听有关「干活」的消息。\\n(.+)\\Z",
		"花匠对你点点头，满意地说：“够了，够了，今天的活就干到这里吧。\\n(.+)\\Z",
	}
	local _tb3={
		"你向花匠打听有关「check」的消息。\\n花匠对着你点了点头。\\n(.+)\\Z",
	}
	local  mp_dl_work_m_triggerlist={
	       {name="mp_dl_work_m_dosth1",line=2,regexp=linktri(_tb),script=function(n,l,w)    mp_dl_work.dosomething1(n,l,w)  end,},
	       {name="mp_dl_work_m_dosth2",line=3,regexp=linktri(_tb3),script=function(n,l,w)    mp_dl_work.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_dl_work_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_dl_work",v.script,v.line)
	end
	closeclass("mp_dl_work")
	
	local noecho_trilist={
			"你身上没有这样东西",
			"你身行向后一跃",
			".+领教壮士的高招",
			".+在下只好奉陪",
			"你正忙着呢",
			"你现在不忙",
			"人家没在惹事生非，你锁捕不了！",
			}
	local _noechotri=linktri(noecho_trilist)

	addtri("mp_dl_watch_gag_dosth1",_noechotri,"mp_dl_watch","")
	SetTriggerOption("mp_dl_watch_gag_dosth1","omit_from_output",1)
end
mp_dl.update()
