mp_xx={}
mp_xx_pre={}
mp_xx_start={}
mp_xx_watch={}
mp_xx_pre_sandu={}
mp_xx_pre_suck={}
mp_xx_start_catch={}
mp_xx_start_sandu={}
mp_xx_start_search={}
mp_xx_xiulian={}
mp_xx_kmmr={}

xx={
	needsandu=0,
	suck=0,
	sucknow=1,
	suckid="",
	suckname="",
	suckroom=0,
	npcname="",
	npcid="",
	bugout=0,
	bugname="",
	bugid="",
	havebug=0,
}
mmr={
	searchlist="s|w|s|s|e|n|ne|se|sw|n|w|n",
	searchroomno="2010|2011|2012|2013|2014|2015|2016|2018|2017|2016|2010|841",
	searchid=3,
	findmmr=0,
	name="",
	id="",
	targetNum=30,
	havenum=1,
	oneexp=149,
	corpseid=-1,
	err=0,
	givenum=0,
}
xxsuck_list={}
table.insert(xxsuck_list,{suckid="haoshou",suckname="星宿派号手",suckroom=1437})
table.insert(xxsuck_list,{suckid="gushou",suckname="星宿派鼓手",suckroom=1437})
table.insert(xxsuck_list,{suckid="boshou",suckname="星宿派钹手",suckroom=1437})
table.insert(xxsuck_list,{suckid="haoshou",suckname="星宿派号手",suckroom=1435})
table.insert(xxsuck_list,{suckid="gushou",suckname="星宿派鼓手",suckroom=1435})
table.insert(xxsuck_list,{suckid="boshou",suckname="星宿派钹手",suckroom=1435})
table.insert(xxsuck_list,{suckid="haoshou",suckname="星宿派号手",suckroom=1444})
table.insert(xxsuck_list,{suckid="gushou",suckname="星宿派鼓手",suckroom=1444})
table.insert(xxsuck_list,{suckid="boshou",suckname="星宿派钹手",suckroom=1444})
table.insert(xxsuck_list,{suckid="haoshou",suckname="星宿派号手",suckroom=1440})
table.insert(xxsuck_list,{suckid="gushou",suckname="星宿派鼓手",suckroom=1440})
table.insert(xxsuck_list,{suckid="boshou",suckname="星宿派钹手",suckroom=1440})
table.insert(xxsuck_list,{suckid="haoshou",suckname="星宿派号手",suckroom=1441})
table.insert(xxsuck_list,{suckid="gushou",suckname="星宿派鼓手",suckroom=1441})
table.insert(xxsuck_list,{suckid="boshou",suckname="星宿派钹手",suckroom=1441})
table.insert(xxsuck_list,{suckid="boshou",suckname="星宿派钹手",suckroom=1329})
table.insert(xxsuck_list,{suckid="hazakh",suckname="哈萨克",suckroom=1328})
table.insert(xxsuck_list,{suckid="binu",suckname="婢女",suckroom=1327})
table.insert(xxsuck_list,{suckid="woman",suckname="维吾尔族妇女",suckroom=1333})
table.insert(xxsuck_list,{suckid="kid",suckname="小孩",suckroom=1336})
table.insert(xxsuck_list,{suckid="hu",suckname="胡老爷",suckroom=1336})
--table.insert(xxsuck_list,{suckid="li",suckname="李文秀",suckroom=1335})
table.insert(xxsuck_list,{suckid="girl",suckname="锡伯少女",suckroom=1447})
table.insert(xxsuck_list,{suckid="girl",suckname="锡伯少女",suckroom=1447})
table.insert(xxsuck_list,{suckid="sheng",suckname="书生",suckroom=1376})
table.insert(xxsuck_list,{suckid="dao",suckname="道童",suckroom=1376})
table.insert(xxsuck_list,{suckid="lama",suckname="小喇嘛",suckroom=1376})
table.insert(xxsuck_list,{suckid="ke",suckname="刀客",suckroom=1373})
table.insert(xxsuck_list,{suckid="boy",suckname="牧童",suckroom=939})
table.insert(xxsuck_list,{suckid="boy",suckname="牧童",suckroom=939})
table.insert(xxsuck_list,{suckid="girl",suckname="女孩",suckroom=820})
table.insert(xxsuck_list,{suckid="boy",suckname="男孩",suckroom=820})
table.insert(xxsuck_list,{suckid="man",suckname="穷汉",suckroom=827})
table.insert(xxsuck_list,{suckid="girl",suckname="女孩",suckroom=832})
table.insert(xxsuck_list,{suckid="kid",suckname="小孩",suckroom=813})
table.insert(xxsuck_list,{suckid="kid",suckname="小孩",suckroom=813})
table.insert(xxsuck_list,{suckid="boy",suckname="男孩",suckroom=838})
------------------------------------------------------------------------------------
-- mp_xx_pre
------------------------------------------------------------------------------------
function mp_xx_pre.dosomething1(n,l,w)
	if findstring(l,"你目前还没有任何为 checkhp 的变量设定。") then
		alias.resetidle()
		-- #if @debug {#say 开始检查状态（中毒或状态不好就去suck npc）}
		if stat.havedu>0 or hp.healthjing<100 or hp.healthqi<100 or hp.neili<(hp.maxneili*120/100) then
			print("开始suck内力")
			xx.suckid=xxsuck_list[xx.sucknow]["suckid"]
			xx.suckname=xxsuck_list[xx.sucknow]["suckname"]
			xx.suckroom=xxsuck_list[xx.sucknow]["suckroom"]
			alias.flytoid(xx.suckroom)
		else
			run("yun regenerate;yun refresh;yun recover")
			if havefj>0 then alias.startworkflow()
			else
				closeclass("mp_xx_pre")
				closeclass("mp_xx_pre_suck")
				closeclass("mp_xx_pre_sandu")
				--if xx.needsandu>0 and hp.exp>150000 then
				if hp.exp>150000 then
					print("开始search bug")
					openclass("mp_xx_start")
					alias.flytoid(1442)
				else
					print("开始kmmr")
					openclass("mp_xx_kmmr")
					alias.flytoid(841)
				end
			end
		end
	end
	if findstring(l,"数码世界，数字地图，"..tostring(xx.suckroom).."就是这里！") then
		alias.resetidle()
		run("ask "..tostring(xx.suckid).." about 吸吸大法")
	end
	if findstring(l,"这里没有 "..tostring(xx.suckid)) then
		alias.resetidle()
		xx.sucknow=xx.sucknow+1
		run("yield no")
		alias.checkbusy("pre")
	end
	if findstring(l,"你向"..tostring(xx.suckname).."打听有关「吸吸大法」的消息。") then
		alias.resetidle()
		run("yield yes;kill "..tostring(xx.suckid)..";yun jiemai "..tostring(xx.suckid))
		openclass("mp_xx_pre_suck")
	end
	if findstring(l,"你忙着呢，你等会儿在问话吧。","对方正忙着呢，你等会儿在问话吧。") then
		alias.resetidle()
		wait.make(function()
		_f=function() run("ask "..tostring(xx.suckid).." about 吸吸大法") end
		wait.time(1);_f()
		end)
	end
	if findstring(l,"^[> ]*"..tostring(xx.suckname).."已经.+涣散，你已经无法从他体内吸取") then
		alias.resetidle()
		run("yield no")
	end
	if findstring(l,"^[> ]*"..tostring(xx.suckname).."脚下一个不稳，跌在地上昏了过去。") then
		alias.resetidle()
		closeclass("mp_xx_pre_suck")
		closeclass("mp_xx_pre_sandu")
		if stat.havedu>0 then
			print("需要散毒")
			run("yield yes")
			openclass("mp_xx_pre_sandu")
		else run("yield no") end
	end
	if findstring(l,"^[> ]*"..tostring(xx.suckname).."倒在地上，挣扎了几下就死了。") then
		alias.resetidle()
		closeclass("mp_xx_pre_suck")
		closeclass("mp_xx_pre_sandu")
		xx.sucknow=xx.sucknow+1
		run("yield no")
		alias.checkbusy("pre")
	end
	if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
		alias.resetidle()
		--xx.sucknow=1
		if hp.neili<500 then alias.dz(set_neili) else alias.checkbusy("pre") end
	end
	if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
		alias.resetidle()
		if not isopen("boat") then run("hp;set checkhp") end
	end
	if findstring(l,"你目前还没有任何为 busyover=pre 的变量设定。") then
		alias.resetidle()
		if xx.sucknow>table.getn(xxsuck_list) then xx.sucknow=1 end
		run("hp;set checkhp")
		--if xx.sucknow>table.getn(xxsuck_list) then 
		--	xx.sucknow=1
		--	alias.dz(set_neili)
		--else
		--	run("yun regenerate;yun refresh;yun recover;hp;set checkhp")
		--end
	end
end
------------------------------------------------------------------------------------
-- mp_xx_pre_sandu
------------------------------------------------------------------------------------
function mp_xx_pre_sandu.timer()
	alias.resetidle()
	alias.uw()
	run("perform sandu")
end
------------------------------------------------------------------------------------
-- mp_xx_pre_suck
------------------------------------------------------------------------------------
function mp_xx_pre_suck.timer()
	alias.resetidle()
	run("yun jiemai "..tostring(xx.suckid)..";yun jiexin "..tostring(xx.suckid))
end
------------------------------------------------------------------------------------
-- mp_xx_start
------------------------------------------------------------------------------------
function mp_xx_start.dosomething1(n,l,w)
	local _tb,a,b,c,d
	if findstring(l,"你目前还没有任何为 killover=yes 的变量设定。") then
		alias.checkexp("mp")
	end
	if findstring(l,"你目前还没有任何为 checkexpover=mp 的变量设定。") then
		alias.resetidle()
		if add.exp>10 and mpLimited.MarkExp<me.menpaiLimited then mpLimited.MarkExp=tonumber(me.menpaiLimited) end
		if add.exp<10 then
			mpJobLimited=1
			print("统计到的SUCK上限为："..mpLimited.mpexp)
			mpLimited.MarkExp=tonumber(mpLimited.mpexp)
			if mpLimited.MarkTime<(os.time()-3600) then
				-- 到时间却仍然busy，推迟2分钟
				mpLimited.MarkTime=tonumber(os.time()-3600+120)
			end
		end
		alias.checkbusy("sb")
	end
	if findstring(l,"你目前还没有任何为 busyover=goquit 的变量设定。") then
		alias.flytoid(1436)
	end
	if findstring(l,"数码世界，数字地图，1442就是这里！") then
		alias.resetidle()
		if xx_xiulian>0 then
			run("give du dan to ding chunqiu;give du dan to ding chunqiu;give du dan to ding chunqiu")
		end
		run("give ling pai to ding chunqiu;give ling pai to ding chunqiu;give ling pai to ding chunqiu")
		run("ask ding about job")
	end
	if findstring(l,"你目前还没有任何为 killnpc 的变量设定。") then
		alias.resetidle()
		if string.len(mpweapon)==0 then run("blow di") end
		_tb=utils.split(mpyun,"|")
		for k,v in ipairs(_tb) do run(v) end
		openclass("kill")
		run("unset no_parry")
		openclass("kill_"..me.menpai)
		closeclass("kill_run")
		AddTimer("kill_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "kill.timer")
		SetTimerOption("kill_timer", "group", "kill")
		xx.suck=2
		reyun=1
		runaway=false
		npcfaint=false
		killRunSuccess=false
		killid=xx.npcid
		killname=xx.npcname
		killskill=mpweapon
		killpfm=mppfm
		killyun=mpyun
		killjiali=mpjiali
		killjiajin=mpjiajin
		run("jiali "..mpjiali..";jiajin "..mpjiajin)
		if string.len(mpweapon)>0 then
			if mpweapon=="staff" then alias.wi(staffid) else alias.wi(mpweapon) end
		else alias.uw() end
		run("kill "..tostring(killid))
		_tb=utils.split(mppfm,"|")
		for k,v in ipairs(_tb) do run(tostring(v).." "..tostring(xx.npcid)) end
	end
	if findstring(l,"^[> ]*"..tostring(xx.bugname).."突然钻到一片树叶下面，踪影全无。","这东西最好不要抓。","别人找出来的，你好意思抓吗？","这里没有这个生物。") then
		if not isopen("kill") then
			alias.resetidle()
			closeclass("mp_xx_start_catch")
			openclass("mp_xx_start_search")
			run("yield no")
			xx.bugname=""
			xx.bugout=0
		end
	end
	if findstring(l,"你最好先回去复命，别让老仙等急了。") then
		alias.resetidle()
		closeclass("mp_xx_start_catch")
		openclass("mp_xx_xiulian")
		alias.checkbusy("xiulian")
	end
	if findstring(l,"你举起手中的瓦罐猛地将"..tostring(xx.bugname).."扣住，然后小心翼翼地将瓦罐翻起来盖住。","已经有毒虫了，修炼吧。") then
		alias.resetidle()
		closeclass("mp_xx_start_catch")
		openclass("mp_xx_xiulian")
		run("yield no")
		xx.havebug=1
		alias.checkbusy("xiulian")
	end
	if findstring(l,"你找到虫子用什么来盛呢？") then
		alias.resetidle()
		closeclass("mp_xx_start_sandu")
		closeclass("mp_xx_start_search")
		print("瓦罐摔破了，需要relogin")
		run("get gold")
		alias.checkbusy("goquit")
	end
	if findstring(l,"^[> ]*"..tostring(xx.npcname).."脚下一个不稳，跌在地上昏了过去。") then
		alias.resetidle()
		closeclass("mp_xx_start_sandu")
		closeclass("mp_xx_start_search")
		if xx.needsandu>0 or stat.havedu>0 then
			print("需要散毒")
			run("yield yes")
			openclass("mp_xx_start_sandu")
		else run("yield no") end
		rekill=1
	end
	if findstring(l,"^[> ]*"..tostring(xx.npcname).."倒在地上，挣扎了几下就死了。") then
		alias.resetidle()
		closeclass("mp_xx_start_sandu")
		closeclass("mp_xx_start_search")
	end
	if findstring(l,"你目前还没有任何为 busyover=sb 的变量设定。") then
		alias.resetidle()
		closeclass("mp_xx_start_sandu")
		closeclass("mp_xx_start_search")
		alias.uw()
		run("get ling pai;yun regenerate;yun refresh;yun recover")
		alias.startworkflow()
		--if havefj>0 then alias.startworkflow() else openclass("mp_xx_start_search") end
	end
	if findstring(l,"数码世界，数字地图，1436就是这里！") then
		alias.resetidle()
		run("n;give du dan to ding chunqiu;give du dan to ding chunqiu;give du dan to ding chunqiu;give ling pai to ding chunqiu;give ling pai to ding chunqiu;give ling pai to ding chunqiu;s")
		openclass("quit")
	end
	a,b,c=string.find(l,"看起来(.+)想杀死你！")
	if c~=nil and findstring(c,"星宿毒蛛","绿竹蝎","朱睛蛙","毒蛾","七心甲虫","野蜂","蓝鼎蜘蛛") then
		alias.resetidle()
		xx.bugname=c
		if xx.bugname=="星宿毒蛛" then xx.bugid="zhu" end
		if xx.bugname=="绿竹蝎" then xx.bugid="xie" end
		if xx.bugname=="朱睛蛙" then xx.bugid="wa" end
		if xx.bugname=="毒蛾" then xx.bugid="e" end
		if xx.bugname=="七心甲虫" then xx.bugid="chong" end
		if xx.bugname=="野蜂" then xx.bugid="bee" end
		if xx.bugname=="蓝鼎蜘蛛" then xx.bugid="bee" end
		if xx_xiulian>0 then
			closeclass("mp_xx_start_search")
			openclass("mp_xx_start_catch")
			run("yield yes")
		else
			run("yield no")
		--	run("yield no;kill "..tostring(xx.bugid))
		end
	end
	if c~=nil and findstring(c,"白衫怪客","叶三山","高克新","静慈","刘志修","觉慈","觉兴","觉欲") then
		alias.resetidle()
		xx.npcname=c
	end
	if findstring(w[0],"你向丁春秋打听有关「job」的消息。\n丁春秋说道：“老仙我最近练功需要一些毒丹，你到后山拿些来给我吧。”","你向丁春秋打听有关「job」的消息。\n丁春秋说道：好小子，上一个工作没有完成就敢来问我工作。") then
		alias.resetidle()
		alias.et()
		run("yield no;s;ne;nw;n")
		alias.wi()
		xx.npcname=""
		closeclass("mp_xx_start_sandu")
		openclass("mp_xx_start_search")
	end
	if findstring(l,"你中毒了！") then
		stat.havedu=1
	end
	a,b,c,d=string.find(l,tostring(xx.npcname).."%s+=%s+(%w+)%s+(%w+),%s+")
	if c~=nil and d~=nil then
		xx.npcid=string.lower(c).." "..string.lower(d)
	end
	a,b,c=string.find(l,tostring(xx.npcname).."%s+=%s+(%w+),%s+")
	if c~=nil then
		xx.npcid=string.lower(c)
	end
end
------------------------------------------------------------------------------------
-- mp_xx_start_catch
------------------------------------------------------------------------------------
function mp_xx_start_catch.timer()
	alias.resetidle()
	run("kou "..tostring(xx.bugid))
end
------------------------------------------------------------------------------------
-- mp_xx_start_sandu
------------------------------------------------------------------------------------
function mp_xx_start_sandu.timer()
	alias.resetidle()
	alias.uw()
	run("kill "..xx.npcid..";perform sandu")
end
------------------------------------------------------------------------------------
-- mp_xx_start_search
------------------------------------------------------------------------------------
function mp_xx_start_search.timer()
	alias.resetidle()
	if xx.npcname~="" then
		closeclass("mp_xx_start_search")
		run("id here;set killnpc")
	else
		if havefj>0 then alias.startworkflow() else run("search bug") end
	end
end
------------------------------------------------------------------------------------
-- mp_xx_watch
------------------------------------------------------------------------------------
function mp_xx_watch.dosomething1(n,l,w)
	if findstring(l,"你一掌拍在.+胸口，不料.+内力太弱，你反不能把毒气逼出去，功力受损。") then
		stat.havedu=0
		rekill=1
		run("yield no")
	end
	if findstring(l,"你一掌拍在.+胸口，待其运内力抵抗，顺势把周身毒气尽数逼进.+体内。") then
		stat.havedu=0
		rekill=1
		run("yield no")
		xx.needsandu=0
	end
	if findstring(l,"截脉只能在战斗中对对手使用。","截心只能在战斗中对对手使用。") then
		rekill=1
	end
end
------------------------------------------------------------------------------------
-- mp_xx_xiulian
------------------------------------------------------------------------------------
function mp_xx_xiulian.dosomething1(n,l,w)
	if findstring(l,"你目前还没有任何为 busyover=xiulian 的变量设定。") then
		alias.resetidle()
		if havefj>0 then alias.startworkflow() else run("xiulian") end
	end
	if findstring(l,"你将死"..tostring(xx.bugname).."拿出瓦罐，将其肚子剖开，拿出一粒腥如血的丹丸来。","没有毒虫，你想要用空气修行吗？") then
		alias.resetidle()
		closeclass("mp_xx_xiulian")
		xx.bugname=""
		if xx.havebug>0 then
			closeclass("mp_xx_start_sandu")
			closeclass("mp_xx_start_search")
			print("需要relogin")
			alias.checkbusy("goquit")
		else
			alias.uw()
			run("yun regenerate;yun refresh;yun recover")
			alias.startworkflow()
		end
	end
	if findstring(l,"你正忙着呢。") then
		alias.resetidle()
		alias.checkbusy("xiulian")
	end
	if findstring(l,"^[> ]*"..tostring(xx.bugname).."肚子高高涨起，啪地一身掉进罐底。") then
		alias.resetidle()
		run("xiulian")
	end
	if findstring(l,"你运起内力护住全身大穴，然后闭上眼睛将手指伸入瓦罐。") then
		xx.havebug=0
	end
end
------------------------------------------------------------------------------------
-- mp_xx_kmmr
------------------------------------------------------------------------------------
function mp_xx_kmmr.dosomething1(n,l,w)
	local _f,_tb,_t,a,b,c,d,e,f
	if findstring(l,"数码世界，数字地图，841就是这里！") then
		alias.resetidle()
		mmr.findmmr=0
		mmr.searchid=1
		mmr.err=0
		run("yun recover")
		if me.shen<(0-(hp.exp/3)) then
			run("set searchmmr=yes")
		else
			xx.needsandu=1
			alias.startworkflow()
		end
	end
	if findstring(l,"数码世界，数字地图，856就是这里！") then
		alias.resetidle()
		mmr.findmmr=0
		mmr.err=0
		run("drop "..mmr.id..";drop corpse;drop skeleton;yun recover")
		alias.checkexp("mp")
	end
	if findstring(l,"yunbusy严重","受伤严重") then
		closeclass("kill")
		alias.flytoid(856)
	end
	a,b,c=string.find(l,"(.+)脚下一个不稳，跌在地上昏了过去。")
	if c~=nil and c==mmr.name then run("halt");alias.checkbusy("killover") end
	a,b,c=string.find(l,"[> ]*(.-)急步往.-离开。")
	if c~=nil and c==mmr.name then alias.checkbusy("killover") end
	a,b,c=string.find(l,"[> ]*(.-)突然卖一破绽，跳出战圈，逃了！")
	if c~=nil and c==mmr.name then alias.checkbusy("killover") end
	--a,b,c=string.find(l,"[> ]*(.-)急步往.-离开。","[> ]*(.-)突然卖一破绽，跳出战圈，逃了！")
	--if c~=nil and c==mmr.name then
	--	alias.checkbusy("killover")
	--end
	if findstring(l,"你目前还没有任何为 busyover=killover 的变量设定。") then
		alias.resetidle()
		run("get silver;get silver from corpse;get silver from "..mmr.id..";get "..mmr.id)
		alias.flytoid(856)
	end
	if findstring(l,"你目前还没有任何为 checkexpover=mp 的变量设定。") then
		alias.resetidle()
		if add.exp>10 and mpLimited.MarkExp<me.menpaiLimited then mpLimited.MarkExp=tonumber(me.menpaiLimited) end
		if add.exp<10 then
			mpJobLimited=1
			print("统计到的suck上限为："..mpLimited.mpexp)
			mpLimited.MarkExp=tonumber(mpLimited.mpexp)
			if mpLimited.MarkTime<(os.time()-3600) then
				-- 到suck时间却仍然busy，推迟2分钟
				mpLimited.MarkTime=tonumber(os.time()-3600+120)
			end
		end
		alias.startworkflow()
	end
	if findstring(l,"你目前还没有任何为 searchmmr=yes 的变量设定。") then
		alias.resetidle()
		safego="/alias.flytoid(841)"
		SaveBack="south"
		if mmr.err>0 then
			alias.flytoid(841)
		else
			if mmr.findmmr>0 then
				run("id here;set checkmmrid=yes")
				alias.yjl()
			else
				_tb=utils.split(mmr.searchlist,"|")
				if mmr.searchid>table.getn(_tb) then mmr.searchid=1 end
				run(_tb[mmr.searchid])
				_tb=utils.split(mmr.searchroomno,"|")
				roomno_now=_tb[mmr.searchid]
				mmr.searchid=mmr.searchid+1
				--if cmd.nums<20 then
					run("set searchmmr=yes")
				--else
				--	alias.yjl()
				--	_f=function() run("set searchmmr=yes") end
				--	wait.time(2);_f()
				--end
			end
		end
	end
	a,b,c=string.find(l,"看起来(.+)想杀死你！")
	if c~=nil then
		mmr.name=c
		mmr.findmmr=1
	end
	a,b,c,d,e,f=string.find(l,"(%S+)%s+=%s+(%w+) (%w+), (%w+)")
	if c~=nil and d~=nil and e~=nil and d~=nil and c==mmr.name then	mmr.id=d.." "..e end
	if findstring(l,"你目前还没有任何为 checkmmrid=yes 的变量设定。") then
		alias.resetidle()
		if string.len(mpweapon)==0 then run("blow di") end
		_tb=utils.split(mpyun,"|")
		for k,v in ipairs(_tb) do run(v) end
		openclass("kill")
		run("unset no_parry")
		openclass("kill_"..me.menpai)
		closeclass("kill_run")
		AddTimer("kill_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "kill.timer")
		SetTimerOption("kill_timer", "group", "kill")
		xx.suck=2
		reyun=1
		runaway=false
		npcfaint=false
		killRunSuccess=false
		killid=mmr.id
		killname=mmr.name
		killskill=mpweapon
		killpfm=mppfm
		killyun=mpyun
		killjiali=mpjiali
		killjiajin=mpjiajin
		run("jiali "..mpjiali..";jiajin "..mpjiajin)
		if string.len(mpweapon)>0 then
			if mpweapon=="staff" then alias.wi(staffid) else alias.wi(mpweapon) end
		else alias.uw() end
		run("kill "..tostring(killid))
		_tb=utils.split(mppfm,"|")
		for k,v in ipairs(_tb) do run(tostring(v).." "..tostring(killid)) end
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function mp_xx.update()
	local  mp_xx_pre_triggerlist={
	       {name="mp_xx_pre_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_xx_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_xx_pre_triggerlist) do
		addtri(v.name,v.regexp,"mp_xx_pre",v.script,v.line)
	end
	closeclass("mp_xx_pre")
	
	AddTimer("mp_xx_pre_sandu_timer", 0, 0, 1, "", timer_flag.Enabled + timer_flag.Replace, "mp_xx_pre_sandu.timer")
	SetTimerOption("mp_xx_pre_sandu_timer", "group", "mp_xx_pre_sandu")
	closeclass("mp_xx_pre_sandu")
	
	AddTimer("mp_xx_pre_suck_timer", 0, 0, 1, "", timer_flag.Enabled + timer_flag.Replace, "mp_xx_pre_suck.timer")
	SetTimerOption("mp_xx_pre_suck_timer", "group", "mp_xx_pre_suck")
	closeclass("mp_xx_pre_suck")
	
	local  mp_xx_start_triggerlist={
	       {name="mp_xx_start_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_xx_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_xx_start_triggerlist) do
		addtri(v.name,v.regexp,"mp_xx_start",v.script,v.line)
	end	
	local _tb2={
		"突然间从树后越出一个人，高喊一声：“星宿奸人，拿命来！”\\n看起来(.+)想杀死你！\\Z",
		"你向丁春秋打听有关「job」的消息。\\n丁春秋说道：“老仙我最近练功需要一些毒丹，你到后山拿些来给我吧。”\\Z",
		"你向丁春秋打听有关「job」的消息。\\n丁春秋说道：好小子，上一个工作没有完成就敢来问我工作。\\Z",
	}
	local  mp_xx_start_m_triggerlist={
	       {name="mp_xx_start_m_dosth2",line=2,regexp=linktri2(_tb2),script=function(n,l,w)    mp_xx_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_xx_start_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_xx_start",v.script,v.line)
	end
	closeclass("mp_xx_start")
	
	AddTimer("mp_xx_start_catch_timer", 0, 0, 1, "", timer_flag.Enabled + timer_flag.Replace, "mp_xx_start_catch.timer")
	SetTimerOption("mp_xx_start_catch_timer", "group", "mp_xx_start_catch")
	closeclass("mp_xx_start_catch")
	
	AddTimer("mp_xx_start_sandu_timer", 0, 0, 1, "", timer_flag.Enabled + timer_flag.Replace, "mp_xx_start_sandu.timer")
	SetTimerOption("mp_xx_start_sandu_timer", "group", "mp_xx_start_sandu")
	closeclass("mp_xx_start_sandu")
	
	AddTimer("mp_xx_start_search_timer", 0, 0, 1, "", timer_flag.Enabled + timer_flag.Replace, "mp_xx_start_search.timer")
	SetTimerOption("mp_xx_start_search_timer", "group", "mp_xx_start_search")
	closeclass("mp_xx_start_search")
	
	local  mp_xx_watch_triggerlist={
	       {name="mp_xx_watch_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_xx_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_xx_watch_triggerlist) do
		addtri(v.name,v.regexp,"mp_xx_watch",v.script,v.line)
	end	
	closeclass("mp_xx_watch")
	
	local  mp_xx_xiulian_triggerlist={
	       {name="mp_xx_xiulian_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_xx_xiulian.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_xx_xiulian_triggerlist) do
		addtri(v.name,v.regexp,"mp_xx_xiulian",v.script,v.line)
	end	
	closeclass("mp_xx_xiulian")

	local  mp_xx_kmmr_triggerlist={
	       {name="mp_xx_kmmr_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_xx_kmmr.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_xx_kmmr_triggerlist) do
		addtri(v.name,v.regexp,"mp_xx_kmmr",v.script,v.line)
	end	
	closeclass("mp_xx_kmmr")
end
mp_xx.update()

