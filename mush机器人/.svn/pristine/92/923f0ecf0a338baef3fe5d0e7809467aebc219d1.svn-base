mp_xs={}
mp_xs_pre={}
mp_xs_npc1={}
mp_xs_npc2={}
mp_xs_start={}
mp_xs_watch={}
mp_xs_lzjob={}

if lzjob==nil then lzjob={} end
lzjob.name=""
lzjob.area=""

burnnpc={
	no=1,
	nl="小姗",
	rl="1026",
	room=0,
	name="",
	id="",
	--corpse=0
}

function alias.checkburnnpc()
	local _tb
	if tonumber(hp.exp)<=80000 then
		burnnpc.nl="小姗|祖千秋|马光佐"
		burnnpc.rl="1026|1304|925"
	end
	if tonumber(hp.exp)>80000 and tonumber(hp.exp)<=120000 then
		burnnpc.nl="方碧琳|日本浪人|日本浪人|日本浪人"
		burnnpc.rl="403|66|67|77"
	end
	if tonumber(hp.exp)>120000 and tonumber(hp.exp)<=200000 then
		burnnpc.nl="钟万仇|左全|静真"
		burnnpc.rl="328|1983|399"
	end
	if tonumber(hp.exp)>200000 and tonumber(hp.exp)<=250000 then
		burnnpc.nl="贝锦仪|静闲|静迦|李明霞"
		burnnpc.rl="380|343|361|350"
	end
	if tonumber(hp.exp)>250000 and tonumber(hp.exp)<=350000 then
		burnnpc.nl="静照|花铁干|陆天抒|刘承风"
		burnnpc.rl="400|418|419|647"
	end
	if tonumber(hp.exp)>350000 and tonumber(hp.exp)<=500000 then
		burnnpc.nl="水岱|静空|静虚|静玄"
		burnnpc.rl="419|397|367|363"
	end
	if tonumber(hp.exp)>500000 and tonumber(hp.exp)<=750000 then
		burnnpc.nl="说不得|张中|冷谦"
		burnnpc.rl="556|586|584"
	end
	if tonumber(hp.exp)>750000 and tonumber(hp.exp)<=800000 then
		burnnpc.nl="玄痛大师|玄苦大师|玄难大师|玉真子|李莫愁"
		burnnpc.rl="1653|1620|1634|1707|1271"
	end
	if tonumber(hp.exp)>800000 and tonumber(hp.exp)<=1200000 then
		burnnpc.nl="渡难|渡劫|渡厄"
		burnnpc.rl="1791|1791|1791"
	end
	if tonumber(hp.exp)>1200000 and tonumber(hp.exp)<=1700000 then
		burnnpc.nl="萧远山|血刀老祖"
		burnnpc.rl="1537|416"
	end
	if tonumber(hp.exp)>1700000 and tonumber(hp.exp)<=2000000 then
		burnnpc.nl="血刀老祖|殷天正"
		burnnpc.rl="416|1232"
	end
	if tonumber(hp.exp)>2000000 then
		burnnpc.nl="砸缸的"
		burnnpc.rl="439"
	end
	burnnpc.no=burnnpc.no+1
	_tb=utils.split(burnnpc.nl,"|")
	if burnnpc.no>table.getn(_tb) then burnnpc.no=1 end
	closeclass("mp_xs_npc1")
	closeclass("mp_xs_npc2")
	openclass("mp_xs_pre")
	run("hp;set goburnnpc")
end
function alias.checkburnitems()
	have.faling=0
	have.lubo=0
	have.kulouguan=0
	have.rentoulian=0
	have.luboneedfill=1
	run("drop jiasha;remove all;unwield fa ling;unwield lubo")
	alias.uw()
	openclass("check_items")
	openclass("mp_xs_start")
	run("i;look lubo;set checkburnitems")
end
function alias.guanyou()
	wait.make(function()
		_f=function()
			cmd.nums=0
			run("sd;n;nu")
			if me.suyou==nil then me.suyou=0 end
			if me.suyou>49 then
				for i=1,3,1 do run("pour suyou guan into gang;give suyou guan to zhiri lama") end
			else
				for i=1,3,1 do run("give suyou guan to zhiri lama") end
			end
			run("ask zhiri lama about 敬奉;sd;w;n;n")
			roomno_now=428
			alias.dz(set_neili_global)
		end
		wait.time(2);_f()
	end)
end
function alias.xslianwu()
	alias.uw()
	skills_num=1
	alias.lianwu()
end
------------------------------------------------------------------------------------
-- mp_xs_pre
------------------------------------------------------------------------------------
function mp_xs_pre.dosomething1(n,l,w)
	local _f,a,b,c,d
	--wait.make(function()
		if not isopen("boat") and findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
			alias.resetidle()
			if havefj>0 then alias.startworkflow() else
				print("目前酥油有 "..tostring(me.suyou).." 斛(多于20斛则开始烧尸体否则lzjob)")
				if me.suyou>=20 then alias.checkburnnpc() 
				else
					closeclass("mp_xs_pre")
					openclass("mp_xs_lzjob")
					alias.flytoid(428)
				end
			end
		end
		if findstring(l,"你目前还没有任何为 goburnnpc 的变量设定。") then
			alias.resetidle()
			_tb=utils.split(burnnpc.nl,"|")
			burnnpc.name=_tb[burnnpc.no]
			_tb=utils.split(burnnpc.rl,"|")
			burnnpc.room=tonumber(_tb[burnnpc.no])
			print("准备去烧"..burnnpc.name.."，地图id "..tostring(burnnpc.room))
			run("drop skeleton;drop corpse")
			closeclass("mp_xs_pre")
			if tonumber(burnnpc.room)==439 then openclass("mp_xs_npc1") else openclass("mp_xs_npc2") end
			alias.flytoid(burnnpc.room)
		end
		if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
			alias.resetidle()
			--if tonumber(roomno_now)==424 then alias.flytoid(439) else alias.flytoid(417) end
			alias.flytoid(417)
		end
		--if findstring(l,"数码世界，数字地图，423就是这里！") then
		--	alias.resetidle()
		--	alias.dz(set_neili_global)
		--end
		--if findstring(l,"数码世界，数字地图，439就是这里！") then
		--	alias.resetidle()
		--	if me.suyou==nil then me.suyou=0 end
		--	if me.suyou>49 then
		--		for i=1,3,1 do run("pour suyou guan into gang;give suyou guan to zhiri lama") end
		--	else
		--		for i=1,3,1 do run("give suyou guan to zhiri lama") end
				--for i=1,have.syguan,1 do run("give suyou guan to zhiri lama") end
		--	end
		--	run("ask zhiri lama about 敬奉;sd")
		--	alias.flytoid(423)
		--end
		if findstring(l,"你目前还没有任何为 busyover=ke 的变量设定。") then
			alias.resetidle()
			--closeclass("dazuo")
			run("halt;get suyou guan")
			if tonumber(roomno_now)==417 then alias.flytoid(420)
			elseif tonumber(roomno_now)==420 then alias.flytoid(443)
			elseif tonumber(roomno_now)==443 then alias.flytoid(424)
			--elseif tonumber(roomno_now)==424 then alias.flytoid(439) end
			elseif tonumber(roomno_now)==424 then alias.guanyou() end
		end
		if findstring(l,"数码世界，数字地图，417就是这里！","数码世界，数字地图，420就是这里！","数码世界，数字地图，443就是这里！","数码世界，数字地图，424就是这里！") then
			alias.resetidle()
			--closeclass("dazuo")
			run("get suyou guan;kill jinxiang ke")
			--alias.checkbusy("ke")
		end
		if findstring(l,"这里没有这个人。","进香客倒在地上，挣扎了几下就死了。") then
			alias.resetidle()
			alias.checkbusy("ke")
		end
	--end)
end
------------------------------------------------------------------------------------
-- mp_xs_npc1
------------------------------------------------------------------------------------
function mp_xs_npc1.dosomething1(n,l,w)
	local _f,a,b,c,d,e
	wait.make(function()
		alias.resetidle()
		if findstring(l,"数码世界，数字地图，"..tostring(burnnpc.room).."就是这里！") then
			burnnpc.name=""
			burnnpc.time=os.time()
			alias.xslianwu()
			--DeleteTimer("xs_npc1_wait_timer")
			--AddTimer("xs_npc1_wait_timer",0,0,120,"",timer_flag.Enabled + timer_flag.OneShot, Simulate("已等候2分钟"))
		end
		if tostring(burnnpc.name)=="" and (findstring(l,"倒在地上，挣扎了几下就死了。") or os.time()>(burnnpc.time+120)) then
		--if tostring(burnnpc.name)=="" and findstring(l,"已等候2分钟","倒在地上，挣扎了几下就死了。") then
			closeclass("skills_lian")
			closeclass("dazuo")
			burnnpc.time=os.time()
			alias.uw()
			run("halt;sd")
			if havefj>0 then alias.startworkflow() else run("halt;nu");alias.xslianwu() end
			--if havefj>0 then DeleteTimer("xs_npc1_wait_timer");alias.startworkflow() else run("halt;nu");alias.xslianwu() end
		end
		a,b,c=string.find(l,"[> ]*(.+)说道：听说这里存放着喇嘛用的酥油，老子今天特地过来看看，识相的赶快给我滚开")
		if c~=nil then
			closeclass("skills_lian")
			closeclass("dazuo")
			alias.uw()
			burnnpc.name=c
			run("halt;yun refresh;yun regenerate;yun recover;id here")
			if jifa.forcename=="longxiangbanruo" then run("yun longxiang;yun daoqi") end
			if string.len(mpweapon)>0 then
				if mpweapon=="staff" then alias.wi(staffid) else alias.wi(mpweapon) end
			else alias.uw() end
		end
		a,b,c,d=string.find(l,"^"..burnnpc.name.."%s+=%s+(%w+)%s+(%w+),%s*")
		if c~=nil and d~=nil then
			burnnpc.id=string.lower(c).." "..string.lower(d)
		end
		a,b,c,d,e=string.find(l,"^"..burnnpc.name.."%((%w+) (%w+)%)")
		if c~=nil and d~=nil and e~=nil then
			burnnpc.id=string.lower(d).." "..string.lower(e)
		end
		a,b,c,d,e=string.find(l,"[> ]*(.+)对(.+)大声喝道：.+竟敢不识好歹？！")
		if c~=nil and d~=nil then
			if d=="你" then 
				run("set killburnnpc")
			else
				burnnpc.name=""
				burnnpc.id=""
				alias.xslianwu()
			end
		end
		if findstring(l,"你目前还没有任何为 killburnnpc 的变量设定。") then
			run("halt")
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
			killid=burnnpc.id
			killname=burnnpc.name
			killskill=mpweapon
			killpfm=mppfm
			killyun=mpyun
			killjiali=mpjiali
			killjiajin=mpjiajin
			run("jiali "..mpjiali..";jiajin "..mpjiajin)
			if string.len(mpweapon)>0 then
			if mpweapon=="staff" then alias.wi(staffid) else alias.wi(mpweapon) end
			else alias.uw() end
			run("kill "..burnnpc.id)
			_tb=utils.split(mppfm,"|")
			for k,v in ipairs(_tb) do run(v.." "..burnnpc.id) end
		end
		if findstring(l,"你目前还没有任何为 killover=yes 的变量设定。") then
			closeclass("mp_xs_npc1")
			DeleteTimer("xs_npc1_wait_timer")
			run("get all from corpse;drop all")
			--if fjweapon~="" then run("get "..fjweapon) end
			--if mpweapon~="" then run("get "..mpweapon) end
			--if ftbweapon~="" then run("get "..ftbweapon) end
			if have.jingyao>0 then run("get jing yao") end
			run("get "..weapon_now..";get jiudai;get shi he;get fire;get gold;get coin;get jinchuang yao;get fa ling;get lubo;get kulou guan;get rentou lian;get corpse;sd")
			alias.checkburnitems()
		end
	end)
end
------------------------------------------------------------------------------------
-- mp_xs_npc2
------------------------------------------------------------------------------------
function mp_xs_npc2.dosomething1(n,l,w)
	local _f,a,b,c,d
	wait.make(function()
		if findstring(l,"数码世界，数字地图，"..tostring(burnnpc.room).."就是这里！") then
			alias.resetidle()
			burnnpc.id=""
			_f=function() run("halt;yun refresh;yun regenerate;yun recover;id here;set killburnnpc") end
			wait.time(1.5);_f()
		end
		a,b,c,d=string.find(l,"^"..burnnpc.name.."%s+=%s+(%w+)%s+(%w+),%s*")
		if c~=nil and d~=nil then
			burnnpc.id=string.lower(c).." "..string.lower(d)
		end
		if findstring(l,"你目前还没有任何为 killburnnpc 的变量设定。") then
			alias.resetidle()
			run("halt")
			if tostring(burnnpc.id)=="" then
				print(burnnpc.name.."已死，有事烧纸")
				if havefj>0 then alias.startworkflow() else alias.checkburnnpc() end
			else
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
				killid=burnnpc.id
				killname=burnnpc.name
				killskill=mpweapon
				killpfm=mppfm
				killyun=mpyun
				killjiali=mpjiali
				killjiajin=mpjiajin
				run("jiali "..mpjiali..";jiajin "..mpjiajin)
				if string.len(mpweapon)>0 then
					if mpweapon=="staff" then alias.wi(staffid) else alias.wi(mpweapon) end
				else alias.uw() end
				run("kill "..burnnpc.id)
				_tb=utils.split(mppfm,"|")
				for k,v in ipairs(_tb) do run(v.." "..burnnpc.id) end
			end
		end
		if findstring(l,"你目前还没有任何为 killover=yes 的变量设定。") then
			alias.resetidle()
			closeclass("mp_xs_npc2")
			run("get all from corpse;drop all")
			--if fjweapon~="" then run("get "..fjweapon) end
			--if mpweapon~="" then run("get "..mpweapon) end
			--if ftbweapon~="" then run("get "..ftbweapon) end
			if have.jingyao>0 then run("get jing yao") end
			run("get "..weapon_now..";get jiudai;get shi he;get fire;get gold;get coin;get jinchuang yao;get fa ling;get lubo;get kulou guan;get rentou lian;get corpse")
			alias.checkburnitems()
		end
	end)
end
------------------------------------------------------------------------------------
-- mp_xs_start
------------------------------------------------------------------------------------
function mp_xs_start.dosomething1(n,l,w)
	local _f,a,b,c
	wait.make(function()
		--if findstring(l,"你目前还没有任何为 busyover=getcorpse 的变量设定。") then
		--	alias.resetidle()
			--_f=function() run("get all from corpse;drop all;get jiudai;get shi he;get fire;get gold;get coin;get fa ling;get lubo;get kulou guan;get rentou lian;get "..weapon_now..";get "..weapon_now..";get corpse") end
			--wait.time(2);_f()
		--	run("get all from corpse;drop all;get jiudai;get shi he;get fire;get gold;get coin;get fa ling;get lubo;get kulou guan;get rentou lian;get "..weapon_now..";get "..weapon_now..";get corpse")
		--	alias.checkburnitems()
		--end
		if findstring(l,"你目前还没有任何为 checkburnitems 的变量设定。") then
			alias.resetidle()
			closeclass("check_items")
			if (have.faling<1 or have.lubo<1 or have.kulouguan<1 or have.rentoulian<1) then
				run("drop skeleton;drop corpse")
				alias.startworkflow()
			else
				-- #if @debug {#say 装备齐全，开始烧尸}
				alias.flytoid(437)
			end
		end
		if findstring(l,"数码世界，数字地图，437就是这里！") then
			alias.resetidle()
			if have.luboneedfill~=nil and have.luboneedfill==1 then run("fill lubo") end
			alias.checkbusy("fill")
		end
		if findstring(l,"你目前还没有任何为 busyover=fill 的变量设定。") then
			alias.resetidle()
			alias.dz(100)
		end
		if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
			alias.resetidle()
			--if tonumber(roomno_now)~=422 or tonumber(roomno_now)~=425 then alias.flytoid(422) end
			alias.flytoid(425)
		end
		--if findstring(l,"数码世界，数字地图，422就是这里！","数码世界，数字地图，425就是这里！") then
		if findstring(l,"数码世界，数字地图，425就是这里！") then
			alias.resetidle()
			--burnnpc.corpse=0
			if havefj>0 then run("drop skeleton;drop corpse");alias.startworkflow() else
			--	run("id;set checkcorpse")
				run("ask ge lunbu about 准备法事")
			end
		end
		if findstring(l,"对方正忙着呢，你等会儿在问话吧。","你跟这儿凑什么热闹？","以你的禅宗和内功修为还不足以帮助别人护法！") then
			alias.resetidle()
			--alias.checkbusy("burn")
			_f=function() if tonumber(roomno_now)==425 then roomno_now=422;run("s;ask ge lunbu about 准备法事") else roomno_now=425;run("n;ask ge lunbu about 准备法事") end end
			wait.time(0.5);_f()
		end
		--if findstring(l,".+的尸体%s+=%s+corpse") then
		--	burnnpc.corpse=1
		--end
		--if findstring(l,"你目前还没有任何为 checkcorpse 的变量设定。") then
		--	alias.resetidle()
		--	if burnnpc.corpse==1 then run("ask ge lunbu about 准备法事") else run("guard") end
		--end
		a,b,c=string.find(l,"葛伦布说道：(.+)上人请为亡灵超度吧！")
		if c~=nil then
			alias.resetidle()
			run("yield no;halt")
			if me.charname==c then
				-- #if @debug {#say 正常开始烧尸}
				run("light fa tan")
				alias.dz()
			else
				-- #if @debug {#say 别人抢缸，放弃本次烧尸}
				alias.checkbusy("burn")
			end
		end
		if findstring(l,"你盘腿打坐，神光内蕴，口中念念有辞，渐渐有一丝魂魄在你面前凝聚成形") then
			alias.resetidle()
		end
		if findstring(l,"一丝魂魄升出祭坛，冉冉而起。魂魄受你佛法感召，徘徊不去。") then
			alias.resetidle()
			closeclass("dazuo")
			run("halt;wield lubo;spray fa tan;unwield lubo;wield fa ling;dazuo")
		end
		if findstring(l,"魂魄越聚越多，竟然呈出人形！ 你手指人形，口念真言，指引往生之路。") then
			alias.resetidle()
			run("wave fa ling;unwield fa ling")
		end
		if findstring(l,"你双手抱拳朗声说道：这位上人安心做法事，让.+来为你护法","你口中朗朗诵出《不动明王经》！") then
			alias.resetidle()
		end
		if findstring(l,"大院里光茫四起，一声巨响过后，又恢复了平静。超度完毕。","慢慢地一阵眩晕感传来，你终于又有了知觉","酥油灯慢慢熄灭了，你睁开双眼。。。。") then
			alias.resetidle()
			alias.checkexp("mp")
			alias.checkbusy("burn")
		end
		if findstring(l,"你目前还没有任何为 busyover=burn 的变量设定。") then
			alias.resetidle()
			run("yun refresh;yun recover;yun regenerate;drop skeleton;drop corpse")
			alias.startworkflow()
		end
		if findstring(l,"你烧了太多尸体了，先去做些别的事情吧！","你做了太多相同的事情了，先去做些别的事情吧！") then
			mpJobLimited=1
			print("统计到的burn上限为："..tostring(mpLimited.mpexp))
			mpLimited.MarkExp=tonumber(mpLimited.mpexp)
			if mpLimited.MarkTime<(os.time()-3600) then
				-- #if @debug {#say 到burn时间却仍然busy，推迟2分钟}
				mpLimited.MarkTime=tonumber(os.time()-3600+120)
			end
		end
	end)
end
function mp_xs_start.dosomething2(n,l,w)
	if findstring(w[0],"你向葛伦布打听有关「准备法事」的消息。\n葛伦布说道：.+法事做到一半後不知跑哪里去了？真不象话！","你向葛伦布打听有关「准备法事」的消息。\n葛伦布说道：.+请继续做法事。","你向葛伦布打听有关「准备法事」的消息。\n葛伦布说道："..me.charname..".+是要给哪位施主做法事呀？") then
		alias.resetidle()
		run("give corpse to ge lunbu;yun regenerate;yun refresh;yun recover;yield yes;fight ge lunbu;fight ge lunbu 2")
		alias.dz()
	end
	if findstring(w[0],"你向葛伦布打听有关「准备法事」的消息。\n葛伦布说道：.+正在做法事，这位.+请一旁稍候。") then
		alias.resetidle()
		run("guard")
	end
	if findstring(w[0],"你向葛伦布打听有关「准备法事」的消息。\n葛伦布说道：.+在本寺敬奉的酥油太少了，先去弄些酥油来吧。","你向葛伦布打听有关「准备法事」的消息。\n葛伦布说道：做法事用的酥油不够用了，请.+弄些酥油来吧。") then
		alias.resetidle()
		alias.checkbusy("burn")
	end
	if findstring(w[0],"你向葛伦布打听有关「准备法事」的消息。\n但是很显然的，葛伦布现在的状况没有办法给你任何答覆。","你向葛伦布打听有关「准备法事」的消息。\n葛伦布说道：.+刚做完法事，祭坛还未熄，待我等清理完後.+再来做法事吧。") then
		alias.resetidle()
		wait.make(function()
		_f=function() if tonumber(roomno_now)==425 then roomno_now=422;run("s;ask ge lunbu about 准备法事") else roomno_now=425;run("n;ask ge lunbu about 准备法事") end end
		wait.time(0.5);_f()
		end)
	end
end
------------------------------------------------------------------------------------
-- mp_xs_lzjob
------------------------------------------------------------------------------------
function mp_xs_lzjob.dosomething1(n,l,w)
	local _f
	--wait.make(function()
		--if findstring(l,"这里不准战斗。") then
		--	run("ask "..tostring(npcid).." about 酥油罐")
		--end
		if findstring(l,"数码世界，数字地图，428就是这里！") then
			alias.resetidle()
			run("ask lingzhi shangren about abandon")
			alias.dz(set_neili_global)
		end
		if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。","你目前还没有任何为 lian=over 的变量设定。") then
			alias.resetidle()
			closeclass("skills_lian")
			closeclass("dazuo")
			if havefj>0 then alias.startworkflow()
			else
				lzjob.name=""
				lzjob.area=""
				run("ask lingzhi shangren about job;set checklzjob")
			end
		end
		--if findstring(l,"你目前还没有任何为 lian=over 的变量设定。") then
		--	alias.resetidle()
		--	if not isopen("boat") then
		--		closeclass("skills_lian")
		--		closeclass("dazuo")
		--		if havefj>0 then alias.startworkflow() else alias.dz("addneili") end
		--	end
		--end
		if findstring(l,"你目前还没有任何为 checklzjob 的变量设定。") then
			alias.resetidle()
			if lzjob.name=="" or lzjob.area=="" then alias.xslianwu()
			else
				closeclass("mp_xs_lzjob")
				openclass("ftb")
				openclass("ftb_ask")
				closeclass("ftb_pre")
				closeclass("ftb_start")
				flytoareastartid=0
				workflow.nowjob="lzjob"
				nextJobGodazuobase=1
				ftbnum=1
				ftbarea=lzjob.area
				ftbareanum=5
				alias.lzarea(ftbarea)
				print("lzjob开始找人 地点:"..lzjob.area..","..ftbzone..","..ftbroom..",姓名:"..lzjob.name)
				addlog("lzjob开始找人 地点:"..lzjob.area..","..ftbzone..","..ftbroom..",姓名:"..lzjob.name)
				if findstring(ftbroom,"丹凤洞") then ftbroom="羊肠小路" end
				run("halt")
				alias.uw()
				alias.flytoarea(ftbroom,ftbzone,tonumber(ftbareanum)+1)
			end
		end
	--end)
end
--function mp_xs_lzjob.dosomething2(n,l,w)
--	if findstring(w[0],"你向灵智上人打听有关「job」的消息。\n灵智上人说道：现在没有任务给你，等一会儿在来吧") then
--		if havefj>0 then alias.startworkflow() else alias.xslianwu() end
		--if havefj>0 then alias.startworkflow() else alias.startxue() end
--	end
--end
--function mp_xs_lzjob.dosomething3(n,l,w)
--	if findstring(w[0],"你向灵智上人打听有关「job」的消息。\n灵智上人皱了皱眉，似乎想对你说些什么。\n灵智上人说道：.+好象还没有完成任务吧？") then
--		if havefj>0 then alias.startworkflow() else alias.xslianwu() end
--	end
--end
function mp_xs_lzjob.dosomething4(n,l,w)
	local a,b,c,d
	a,b,c,d=string.find(w[0],"你向灵智上人打听有关「job」的消息。\n灵智上人轻轻地拍了拍你的头。\n灵智上人说道：(.+)偷了我们的酥油，据说他已经到了(.+)附近！\n灵智上人说道：请尽快给我解决他，我不想再看到这个人了！")
	if c~=nil and d~=nil then
		lzjob.name=c
		lzjob.area=d
	end
end
------------------------------------------------------------------------------------
-- mp_xs_watch
------------------------------------------------------------------------------------
function mp_xs_watch.dosomething1(n,l,w)
	if findstring(l,"[> ]*"..burnnpc.name.."脚下一个不稳，跌在地上昏了过去。","你不在战斗中。") then
		--run("kill "..burnnpc.id)
		rekill=1
	end
end
function mp_xs_watch.dosomething2(n,l,w)
	local a,b,c
	a,b,c=string.find(w[0],"你向值日喇嘛打听有关「敬奉」的消息。\n值日喇嘛说道：.+目前在本寺中敬奉的酥油量是满的，一共有(.+)斛")
	if c~=nil then
		me.suyou=ctonum(c)
	end
	a,b,c=string.find(w[0],"你向值日喇嘛打听有关「敬奉」的消息。\n值日喇嘛说道：.+目前在本寺中敬奉的酥油也就只剩下(.+)斛")
	if c~=nil then
		me.suyou=ctonum(c)
	end
	a,b,c=string.find(w[0],"你向值日喇嘛打听有关「敬奉」的消息。\n值日喇嘛说道：.+目前在本寺中敬奉的酥油有(.+)斛")
	if c~=nil then
		me.suyou=ctonum(c)
	end
	if findstring(w[0],"你向值日喇嘛打听有关「敬奉」的消息。\n值日喇嘛说道：还敢问？.+将本寺供奉的酥油都用完了！","你向值日喇嘛打听有关「敬奉」的消息。\n值日喇嘛叹了口气，说道：你这个.+，在本寺中敬奉的酥油快用完了，现在只剩有") then
		me.suyou=0
	end
end
function mp_xs_watch.dosomething3(n,l,w)
	local a,b,c
	a,b,c=string.find(w[0],"你向值日喇嘛打听有关「敬奉」的消息。\n值日喇嘛对着你点了点头。\n值日喇嘛说道：.+目前在本寺中敬奉的酥油还剩(.+)斛")
	if c~=nil then
		me.suyou=ctonum(c)
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function mp_xs.update()
	local  mp_xs_pre_triggerlist={
	       {name="mp_xs_pre_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_xs_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_xs_pre_triggerlist) do
		addtri(v.name,v.regexp,"mp_xs_pre",v.script,v.line)
	end
	closeclass("mp_xs_pre")
	
	local  mp_xs_npc1_triggerlist={
	       {name="mp_xs_npc1_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_xs_npc1.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_xs_npc1_triggerlist) do
		addtri(v.name,v.regexp,"mp_xs_npc1",v.script,v.line)
	end
	closeclass("mp_xs_npc1")
	
	local  mp_xs_npc2_triggerlist={
	       {name="mp_xs_npc2_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_xs_npc2.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_xs_npc2_triggerlist) do
		addtri(v.name,v.regexp,"mp_xs_npc2",v.script,v.line)
	end
	closeclass("mp_xs_npc2")
	
	local  mp_xs_start_triggerlist={
	       {name="mp_xs_start_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_xs_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_xs_start_triggerlist) do
		addtri(v.name,v.regexp,"mp_xs_start",v.script,v.line)
	end
	local _tb2={
		"你向葛伦布打听有关「准备法事」的消息。\\n(.+)\\Z",
	}
	local  mp_xs_start_m_triggerlist={
	       {name="mp_xs_start_m_dosth2",line=2,regexp=linktri2(_tb2),script=function(n,l,w)    mp_xs_start.dosomething2(n,l,w)  end,},
	}
	for k,v in pairs(mp_xs_start_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_xs_start",v.script,v.line)
	end
	closeclass("mp_xs_start")
	
	local  mp_xs_watch_triggerlist={
	       {name="mp_xs_watch_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_xs_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_xs_watch_triggerlist) do
		addtri(v.name,v.regexp,"mp_xs_watch",v.script,v.line)
	end
	local _tb2={
		"你向值日喇嘛打听有关「敬奉」的消息。\\n(.+)\\Z",
	}
	local _tb3={
		"你向值日喇嘛打听有关「敬奉」的消息。\\n(.+)\\n(.+)\\Z",
	}
	local  mp_xs_watch_m_triggerlist={
	       {name="mp_xs_watch_m_dosth2",line=2,regexp=linktri2(_tb2),script=function(n,l,w)    mp_xs_watch.dosomething2(n,l,w)  end,},
	       {name="mp_xs_watch_m_dosth3",line=3,regexp=linktri2(_tb3),script=function(n,l,w)    mp_xs_watch.dosomething3(n,l,w)  end,},
	}
	for k,v in pairs(mp_xs_watch_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_xs_watch",v.script,v.line)
	end

	local noecho_trilist={
			"你身上没有这样东西",
			"你并没有装备这样东西",
			"你附近没有这样东西",
			"你丢下",
			"这位上人请一旁稍候",
			"走了过来",
			"急步往",
			}
	local _noechotri=linktri(noecho_trilist)

	addtri("mp_xs_watch_gag_dosth1",_noechotri,"mp_xs_watch","")
	SetTriggerOption("mp_xs_watch_gag_dosth1","omit_from_output",1)
	
	closeclass("mp_xs_watch")
	
	local  mp_xs_lzjob_triggerlist={
	       {name="mp_xs_lzjob_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_xs_lzjob.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_xs_lzjob_triggerlist) do
		addtri(v.name,v.regexp,"mp_xs_lzjob",v.script,v.line)
	end
--	local _tb2={
--		"你向灵智上人打听有关「job」的消息。\\n(.+)\\Z",
--	}
--	local _tb3={
--		"你向灵智上人打听有关「job」的消息。\\n(.+)\\n(.+)\\Z",
--	}
	local _tb4={
		"你向灵智上人打听有关「job」的消息。\\n(.+)\\n(.+)\\n(.+)\\Z",
	}
	local  mp_xs_lzjob_m_triggerlist={
--	       {name="mp_xs_lzjob_m_dosth2",line=2,regexp=linktri2(_tb2),script=function(n,l,w)    mp_xs_lzjob.dosomething2(n,l,w)  end,},
--	       {name="mp_xs_lzjob_m_dosth3",line=3,regexp=linktri2(_tb3),script=function(n,l,w)    mp_xs_lzjob.dosomething3(n,l,w)  end,},
	       {name="mp_xs_lzjob_m_dosth4",line=4,regexp=linktri2(_tb4),script=function(n,l,w)    mp_xs_lzjob.dosomething4(n,l,w)  end,},
	}
	for k,v in pairs(mp_xs_lzjob_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_xs_lzjob",v.script,v.line)
	end
	closeclass("mp_xs_lzjob")
end
mp_xs.update()

