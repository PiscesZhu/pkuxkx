mp_qz={}
mp_qz_pre={}
mp_qz_watch={}
mp_qz_start={}
mp_qz_boyao={}
mp_qz_boyao_ti={}

bdz={
	askqiu=0,
	askzhao=0,
	doing=0,
}
qzjob=""
yaoname=""
mpjobLimited_pre=0
--me.quit=1

function mp_qz.haveyao()
	return tonumber(have.heshouwu)+tonumber(have.shengdi)+tonumber(have.chuanbei)+tonumber(have.shengdi)+tonumber(have.jinyinhua)+tonumber(have.jugeng)+tonumber(have.huanglian)+tonumber(have.gouzhizi)+tonumber(have.fuling)
end
------------------------------------------------------------------------------------
-- mp_qz_pre
------------------------------------------------------------------------------------
function mp_qz_pre.dosomething1(n,l,w)
	local _f,_tb
	wait.make(function()
		if findstring(l,"你目前还没有任何为 busyover=goboyao 的变量设定。") then
			closeclass("mp_qz_pre")
			openclass("mp_qz_boyao")
			boyaocmd=""
			alias.flytoid(763)
		end
		if findstring(l,"你目前还没有任何为 busyover=golz 的变量设定。") then
			closeclass("mp_qz_pre")
			openclass("mp_qz_start")
			alias.flytoid(723)
		end
		if findstring(l,"你目前还没有任何为 busyover=goquit 的变量设定。") then
			_tb={780,809,810,779,778,777,}
			alias.flytoid(_tb[math.random(1,6)])
		end
		if findstring(l,"对方正忙着呢，你等会儿在问话吧。","你忙着呢，你等会儿在问话吧。") then
			alias.resetidle()
			_f=function() run("ask qiu chuji about job") end
			wait.time(1);_f()
		end
		if findstring(l,"你目前还没有任何为 checkexpover=mp 的变量设定。") then
			alias.resetidle()
			--if add.exp>10 and mpLimited.MarkExp<me.menpaiLimited then mpLimited.MarkExp=me.menpaiLimited end
			--if add.exp<10 then
			--	if mpjobLimited_pre~=nil and mpjobLimited_pre>1 then
			--		Simulate("你忽然心烦意乱，无法集中精神，看来是练北斗阵太久了（模拟）\n")
			--	else
			--		mpjobLimited_pre=mpjobLimited_pre+1
			--		print("出现lz上限未满，但未获得exp情况（"..mpjobLimited_pre.."/3）次")
			--	end
			--else mpjobLimited_pre=0 end
			if add.exp>10 and mpLimited.MarkExp<me.menpaiLimited then
				mpLimited.MarkExp=me.menpaiLimited
			else
				if mpjobLimited_pre~=nil and mpjobLimited_pre>1 then
					mpjobLimited_pre=0
					Simulate("你忽然心烦意乱，无法集中精神，看来是练北斗阵太久了（模拟）\n")
				else
					mpjobLimited_pre=mpjobLimited_pre+1
					print("出现lz上限未满，但未获得exp情况（"..mpjobLimited_pre.."/3）次")
				end
			end
			alias.checkbusy("lz")
		end
		if findstring(l,"数码世界，数字地图，780就是这里！","数码世界，数字地图，809就是这里！","数码世界，数字地图，810就是这里！","数码世界，数字地图，779就是这里！","数码世界，数字地图，778就是这里！","数码世界，数字地图，777就是这里！") then
			alias.resetidle()
			openclass("quit")
		end
		if findstring(l,"这里没有 qiu chuji 这个人。") then
			alias.resetidle()
			bdz.askqiu=0
			bdz.askzhao=0
			bdz.doing=0
			_f=function() run("ask qiu chuji about job") end
			wait.time(5);_f()
		end
		if findstring(l,"数码世界，数字地图，"..tostring(me.menpaiJobStart).."就是这里！") then
			alias.resetidle()
			bdz.doing=0
			if bdz.askqiu==0 then
				run("ask qiu chuji about job")
			else
				closeclass("mp_qz_pre")
				openclass("mp_qz_start")
				alias.flytoid(723)
			end
		end
		if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
			alias.resetidle()
			alias.flytoid(me.menpaiJobStart)
		end
		if findstring(l,"你目前还没有任何为 busyover=lz 的变量设定。") then
			alias.yjl()
			alias.et()
			alias.uw()
			alias.startworkflow()
		end
		if findstring(w[0],"你向丘处机打听有关「job」的消息。\n丘处机说道：你还在忙着干别的事呢！","你向丘处机打听有关「job」的消息。\n丘处机说道：你去好好练习一下剑法、身法和招架吧","你向丘处机打听有关「job」的消息。\n丘处机说道：现在没什么要紧的事去作，你去休息吧。") then
			alias.resetidle()
			bdz.askqiu=0
			bdz.askzhao=0
			bdz.doing=0
			_f=function() run("ask qiu chuji about job") end
			wait.time(1);_f()
		end
	end)
end
function mp_qz_pre.dosomething2(n,l,w)
	if findstring(w[0],"你向丘处机打听有关「job」的消息。\n丘处机皱了皱眉，似乎想对你说些什么。\n丘处机说道：你还没完成任务，就又想要新的？") then
		alias.resetidle()
		bdz.askqiu=0
		bdz.askzhao=0
		bdz.doing=0
		if qzjob=="bdz" then alias.checkbusy("golz")
		else alias.checkbusy("goquit") end
		--elseif tonumber(me.quit)~=nil and tonumber(me.quit)>0 then alias.checkbusy("goquit")
		--elseif mp_qz.haveyao()>0 then
		--	if have.fuling>0 then run("give qiu fuling") end
		--	if have.gouzhizi>0 then run("give qiu zi") end
		--	if have.huanglian>0 then run("give qiu huanglian") end
		--	if have.jugeng>0 then run("give qiu jugeng") end
		--	if have.jinyinhua>0 then run("give qiu hua") end
		--	if have.shengdi>0 then run("give qiu shengdi") end
		--	if have.chuanbei>0 then run("give qiu chuanbei") end
		--	if have.heshouwu>0 then run("give qiu heshouwu") end
		--	run("ask qiu about job")
		--else alias.checkbusy("goboyao") end
	end
	if findstring(w[0],"你向丘处机打听有关「job」的消息。\n丘处机点了点头。\n丘处机说道：好，最近炼丹用的草药都用完了，你去山下树林里去采一些回来。") then
		alias.resetidle()
		bdz.askqiu=0
		bdz.askzhao=0
		bdz.doing=0
		--qzjob="boyao"
		--if tonumber(me.quit)~=nil and tonumber(me.quit)>0 then alias.checkbusy("goquit") else alias.checkbusy("goboyao") end
		alias.checkbusy("goquit")
	end
	if findstring(w[0],"你向丘处机打听有关「job」的消息。\n丘处机点了点头。\n丘处机说道：好，最近听说有强敌要进攻我重阳宫。") then
		alias.resetidle()
		bdz.askqiu=1
		bdz.askzhao=0
		bdz.doing=0
		qzjob="bdz"
		alias.checkbusy("golz")
	end
end
------------------------------------------------------------------------------------
-- mp_qz_start
------------------------------------------------------------------------------------
function mp_qz_start.dosomething1(n,l,w)
	local _f,_tb
	wait.make(function()
		if findstring(l,"你把正在运行的真气强行压回丹田，站了起来。") then
			if havefj>0 then
				alias.uw()
				alias.startworkflow()
			else run("hp;set check=neili") end
		end
		if findstring(l,"你吐气纳息，硬生生地将内息压了下去，缓缓站了起来。","你硬生生收回招式，不继续练习了。") then
			if havefj>0 then
				alias.uw()
				alias.startworkflow()
			else
				alias.yjl()
				run("hp;set check=neili")
			end
		end
		if findstring(l,"赵志敬身子向后一纵，使一招.+，退出「天罡北斗阵」。") then
			if bdz.doing==0 and bdz.askzhao==0 then
				run("halt")
				if isopen("dazuo") then closeclass("dazuo") end
				if isopen("skills_lian") then closeclass("skills_lian") end
				if isopen("skills_jingyao") then closeclass("skills_jingyao") end
				run("ask zhao zhijing about 天罡北斗阵")
			elseif bdz.doing>0 then
				bdz.askqiu=0
				bdz.askzhao=0
				bdz.doing=0
				closeclass("mp_qz_start")
				openclass("mp_qz_pre")
				alias.checkexp("mp")
			end
		end
		if findstring(l,"你目前还没有任何为 checkhp=addneili 的变量设定。") then
			if havefj>0 and hp.neili>(hp.maxneili*set_neili_job/100) then alias.tdz() end
		end
		if findstring(l,"这里没有 zhao zhijing 这个人。") then
			if tonumber(roomno_now)==723 then
				alias.resetidle()
				bdz.askzhao=0
				bdz.doing=0
				alias.dz(set_neili)
			end
		end
		if findstring(l,"一个.+弟子走了过来,对你报拳道：“在下奉"..me.fjmasternick.."之命，请你速回.+处晋见”。") then
			run("halt")
			if bdz.doing>0 then run("nu") end
		end
		if findstring(l,"你收起手上的.+精要，不继续看了。") then
			alias.resetidle()
			if havefj>0 then
				alias.uw()
				alias.startworkflow()
			else run("yun regenerate;hp;set check=neili") end
		end
		if findstring(l,"赵志敬道："..me.charname.."请做好准备！") then
			alias.resetidle()
			if isopen("dazuo") then closeclass("dazuo") end
			if isopen("skills_lian") then closeclass("skills_lian") end
			if isopen("skills_jingyao") then closeclass("skills_jingyao") end
			run("halt")
			if mpweapon=="staff" then alias.wi(staffid) else alias.wi(mpweapon) end
			_f=function() run("ask zhao zhijing about 天罡北斗阵") end
			wait.time(3);_f()
		end
		if findstring(l,"赵志敬清了清喉咙，大声说道：好，时辰已到，现在开始练习「天罡北斗阵」！") then
			alias.resetidle()
			if bdz.doing==0 and bdz.askzhao==1 then bdz.doing=1 end
		end
		if findstring(l,"你目前还没有任何为 lian=over 的变量设定。") then
			alias.resetidle()
			if have.jingyao>0 and hp.pot>0 then
				-- #if @debug {#say 读精要}
				openclass("skills_jingyao")
				alias.dujingyao()
			else
				-- #if @debug {#say 没有精要或没有潜能，进行打坐}
				alias.dz("addneili")
			end
		end
		if findstring(l,"你忙着呢，你等会儿在问话吧。") then
			alias.resetidle()
			if bdz.doing==0 then
				_f=function() run("ask zhao zhijing about 天罡北斗阵") end
				wait.time(1);_f()
			end
		end
		if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
			alias.resetidle()
			if havefj>0 then alias.startfj() else alias.lianwu() end
		end
		if findstring(l,"数码世界，数字地图，723就是这里！") then
			alias.resetidle()
			run("ask zhao zhijing about 天罡北斗阵")
		end
		if findstring(l,"你身子向后一纵，使一招.+，退出「天罡北斗阵」。","你体力不支，只好身子向后一纵") then
			alias.resetidle()
			bdz.askqiu=0
			bdz.askzhao=0
			bdz.doing=0
			closeclass("mp_qz_start")
			openclass("mp_qz_pre")
			alias.checkexp("mp")
		end
		if findstring(l,"对方正忙着呢，你等会儿在问话吧。") then
			alias.resetidle()
			bdz.askzhao=0
			bdz.doing=0
			alias.dz(set_neili)
		end
		if findstring(l,"但是很显然的，赵志敬现在的状况没有办法给") then
			alias.resetidle()
			bdz.askzhao=0
			bdz.doing=0
			run("yun lifeheal zhao")
			_f=function() run("ask zhao zhijing about 天罡北斗阵") end
			wait.time(3);_f()
		end
	end)
end
function mp_qz_start.dosomething2(n,l,w)
	if findstring(w[0],"你现在不忙。\n重阳宫大门 - ") then
		alias.resetidle()
		bdz.askqiu=0
		bdz.askzhao=0
		bdz.doing=0
		closeclass("mp_qz_start")
		openclass("mp_qz_pre")
		alias.checkexp("mp")
	end
	if findstring(w[0],"你向赵志敬打听有关「天罡北斗阵」的消息。\n赵志敬说道：没有掌门人的许可，不得自行练习「天罡北斗阵」！") then
		alias.resetidle()
		bdz.askqiu=0
		bdz.askzhao=0
		bdz.doing=0
		closeclass("mp_qz_start")
		openclass("mp_qz_pre")
		alias.flytoid(me.menpaiJobStart)
	end
	if findstring(w[0],"你向赵志敬打听有关「天罡北斗阵」的消息。\n赵志敬说道：可惜现在人已够了！","你向赵志敬打听有关「天罡北斗阵」的消息。\n赵志敬说道：没看到我正在忙吗？") then
		alias.resetidle()
		bdz.askqiu=1
		bdz.askzhao=0
		bdz.doing=0
		alias.dz(set_neili)
	end
	if findstring(w[0],"你向赵志敬打听有关「天罡北斗阵」的消息。\n赵志敬说道：没看到我全身是伤吗？") then
		alias.resetidle()
		bdz.askqiu=1
		bdz.askzhao=0
		bdz.doing=0
		run("yun lifeheal zhao")
		alias.dz(set_neili)
	end
	if findstring(w[0],"你向赵志敬打听有关「天罡北斗阵」的消息。\n赵志敬说道：好，你先做好准备，等一会儿就让你跟随贫道一起练习「天罡北斗阵」！","你向赵志敬打听有关「天罡北斗阵」的消息。\n赵志敬说道：急什么？时辰一到就会开始练习「天罡北斗阵」！") then
		alias.resetidle()
		bdz.askqiu=1
		bdz.askzhao=1
		bdz.doing=0
		alias.dz(set_neili)
	end
end
function mp_qz_start.dosomething3(n,l,w)
	if findstring(w[0],"你向赵志敬打听有关「天罡北斗阵」的消息。\n赵志敬.+\n赵志敬说道：好，你先做好准备，等一会儿就让你跟随贫道一起练习「天罡北斗阵」！") then
		alias.resetidle()
		bdz.askqiu=1
		bdz.askzhao=1
		bdz.doing=0
		alias.dz(set_neili)
	end
end
function mp_qz_start.dosomething4(n,l,w)
	if findstring(w[0],"你向赵志敬打听有关「天罡北斗阵」的消息。\n赵志敬.+\n赵志敬.+\n赵志敬说道：好，你先做好准备，等一会儿就让你跟随贫道一起练习「天罡北斗阵」！") then
		alias.resetidle()
		bdz.askqiu=1
		bdz.askzhao=1
		bdz.doing=0
		alias.dz(set_neili)
	end
end
function mp_qz_start.dosomething5(n,l,w)
	if findstring(w[0],"你向赵志敬打听有关「天罡北斗阵」的消息。\n赵志敬.+\n赵志敬.+\n赵志敬.+\n赵志敬说道：好，你先做好准备，等一会儿就让你跟随贫道一起练习「天罡北斗阵」！") then
		alias.resetidle()
		bdz.askqiu=1
		bdz.askzhao=1
		bdz.doing=0
		alias.dz(set_neili)
	end
end
------------------------------------------------------------------------------------
-- mp_qz_watch
------------------------------------------------------------------------------------
function mp_qz_watch.dosomething1(n,l,w)
	if findstring(l,"位上的你大喝一声，一招","位上的你气沉丹田，暗运神功","位上的你身形向上飘起","位上的你手中剑一指，纵起丈余，一式","位上的你踏奇门，走偏锋","位上的你挺身而出，步法精妙，长袖飘飘，攻势如虹。","位上的你向前迈去一大步，使出","位上的你运力一抖剑，一式","位上的你左手捏着剑诀，右足踏开一招") then
		alias.resetidle()
		run("hp")
		if havefj>0 then run("halt;nu") end
	end
	if findstring(l,"你用药锄拨动着四周的灌木杂草，仔细地看有没有草药！") then
		alias.resetidle()
	end
	if findstring(l,"你忽然心烦意乱，无法集中精神，看来是练北斗阵太久了") then
		if mpLimited.mpexp<4000 and mpjobLimited_pre<1 then
			print("可能是系统BUG，没到上限，但由于是0 EXP，所以系统输出了上限到达提示")
		else
			mpJobLimited=1
			mpjobLimited_pre=0
			print("统计到的lz上限为："..tostring(mpLimited.mpexp))
			if mpLimited.MarkTime<(os.time()-3600) then
				-- #if @debug {#say 到lz时间却仍然busy，推迟2分钟}
				mpLimited.MarkTime=os.time()-3600+120
			end
		end
	end
end
------------------------------------------------------------------------------------
-- mp_qz_boyao
------------------------------------------------------------------------------------
function mp_qz_boyao.dosomething1(n,l,w)
	local _f,a,b,c
	if findstring(l,"有一天，你踩着七色云彩来迎娶『丘处机』") then
		run("give qiu "..yaoname)
	end
	if findstring(l,"小豹子对著你大吼，想杀死你！","小豹子发出连串低吼，突然暴起攻击你！","小豹子怒吼一声，扑了过来攻击你！","突然从草丛中惊起一只小豹子，它大概受了惊吓，发疯似地向你发起进攻！") then
		boyaocmd="kill baozi"
	end
	if findstring(l,"突然从草丛中惊起一只蜜蜂，它大概受了惊吓，发疯似地向你发起进攻！") then
		boyaocmd="kill bee"
	end
	if findstring(l,"突然从草丛中惊起一只梅花鹿，它大概受了惊吓，发疯似地向你发起进攻！") then
		boyaocmd="kill deer"
	end
	if findstring(l,"突然从草丛中惊起一只猴子，它大概受了惊吓，发疯似地向你发起进攻！") then
		boyaocmd="kill monkey"
	end
	if findstring(l,"突然从草丛中惊起一只毒蛇，它大概受了惊吓，发疯似地向你发起进攻！") then
		boyaocmd="kill snake"
	end
	if findstring(l,"突然从草丛中惊起一只乌鸦，它大概受了惊吓，发疯似地向你发起进攻！") then
		boyaocmd="kill wuya"
	end
	if findstring(l,"突然从草丛中惊起一只野兔，它大概受了惊吓，发疯似地向你发起进攻！") then
		boyaocmd="kill ye tu"
	end
	if findstring(l,"数码世界，数字地图，803就是这里！","数码世界，数字地图，800就是这里！") then
		run("get chu from pzy")
	end
	if findstring(l,"你目前还没有任何为 busyover=wa 的变量设定。") then
		alias.resetidle()
		wait.make(function()
			_f=function() alias.yjl();run("wa") end
			wait.time(2);_f()
		end)
	end
	if findstring(l,"你目前还没有任何为 busyover=wayao 的变量设定。") then
		alias.resetidle()
		if mp_qz.haveyao()>=2 then alias.flytonpc("丘处机") else openclass("mp_qz_boyao_ti") end
	end
	if findstring(l,"数码世界，数字地图，763就是这里！") then
		alias.resetidle()
		openclass("mp_qz_boyao_ti")
		boyaocmd=""
	end
	if findstring(l,"你把四周的灌木杂草都翻遍了，可是没发现什么，看来这里没指望了！") then
		alias.resetidle()
		closeclass("mp_qz_boyao_ti")
		alias.checkbusy("move")
	end
	if findstring(l,"你没有工具，无法拨开灌木山草寻找草药！") then
		alias.resetidle()
		closeclass("mp_qz_boyao_ti")
		if me.sex then alias.flytoid(803) else alias.flytoid(800) end
	end
	a,b,c=string.find(l,"你过分紧张，一失手，药锄把(.+)切为两截，掉在地上不见了！")
	if c~=nil then
		alias.resetidle()
		boyaocmd=""
		closeclass("mp_qz_boyao_ti")
		if findstring(c,"何首乌") then
			have.heshouwu=have.heshouwu-1
			yaoname="heshouwu"
		end
		if findstring(c,"川贝") then
			have.chuanbei=have.chuanbei-1
			yaoname="chuanbei"
		end
		if findstring(c,"生地") then
			have.shengdi=have.shengdi-1
			yaoname="shengdi"
		end
		if findstring(c,"金银花") then
			have.jinyinhua=have.jinyinhua-1
			yaoname="hua"
		end
		if findstring(c,"菊梗") then
			have.jugeng=have.jugeng-1
			yaoname="jugeng"
		end
		if findstring(c,"黄连") then
			have.huanglian=have.huanglian-1
			yaoname="huanglian"
		end
		if findstring(c,"枸枳子") then
			have.gouzhizi=have.gouzhizi-1
			yaoname="zi"
		end
		if findstring(c,"茯苓") then
			have.fuling=have.fuling-1
			yaoname="fuling"
		end
	end
	a,b,c=string.find(l,"你用药锄小心翼翼的把(.+)从土中起出！")
	if c~=nil then
		alias.resetidle()
		boyaocmd=""
		closeclass("mp_qz_boyao_ti")
		if findstring(c,"何首乌") then
			have.heshouwu=have.heshouwu+1
			yaoname="heshouwu"
		end
		if findstring(c,"川贝") then
			have.chuanbei=have.chuanbei+1
			yaoname="chuanbei"
		end
		if findstring(c,"生地") then
			have.shengdi=have.shengdi+1
			yaoname="shengdi"
		end
		if findstring(c,"金银花") then
			have.jinyinhua=have.jinyinhua+1
			yaoname="hua"
		end
		if findstring(c,"菊梗") then
			have.jugeng=have.jugeng+1
			yaoname="jugeng"
		end
		if findstring(c,"黄连") then
			have.huanglian=have.huanglian+1
			yaoname="huanglian"
		end
		if findstring(c,"枸枳子") then
			have.gouzhizi=have.gouzhizi+1
			yaoname="zi"
		end
		if findstring(c,"茯苓") then
			have.fuling=have.fuling+1
			yaoname="fuling"
		end
		alias.checkbusy("wayao")
	end
	if findstring(l,"你用药锄不断的拨动着四周的山草，忽然发现杂草之中有一株特别的草！") then
		alias.resetidle()
		boyaocmd=""
		closeclass("mp_qz_boyao_ti")
		alias.checkbusy("wa")
	end
	if findstring(l,"你从.+身上搜出一把药锄。") then
		alias.startmp()
	end
	if findstring(l,"你找不到 pzy 这样东西。") then
		alias.close_mp()
		openclass("quit")
		-- alias.startworkflow()
	end
	if findstring(l,"你目前还没有任何为 busyover=move 的变量设定。") then
		run("yun refresh;halt;s;n")
		boyaocmd=""
		wait.make(function()
			_f=function() openclass("mp_qz_boyao_ti") end
			wait.time(1);_f()
		end)
	end
	if findstring(l,"这里已经找过了，再找也找不出什么了！") then
		run("yun refresh;s;n")
	end
end
function mp_qz_boyao.dosomething2(n,l,w)
	local a,b,c
	a,b,c=string.find(w[0],"丘处机说道：(.+)%?\n你给丘处机.+。")
	if c~=nil then
		if findstring(c,"何首乌") then
			have.heshouwu=have.heshouwu-1
			yaoname="heshouwu"
		end
		if findstring(c,"川贝") then
			have.chuanbei=have.chuanbei-1
			yaoname="chuanbei"
		end
		if findstring(c,"生地") then
			have.shengdi=have.shengdi-1
			yaoname="shengdi"
		end
		if findstring(c,"金银花") then
			have.jinyinhua=have.jinyinhua-1
			yaoname="hua"
		end
		if findstring(c,"菊梗") then
			have.jugeng=have.jugeng-1
			yaoname="jugeng"
		end
		if findstring(c,"黄连") then
			have.huanglian=have.huanglian-1
			yaoname="huanglian"
		end
		if findstring(c,"枸枳子") then
			have.gouzhizi=have.gouzhizi-1
			yaoname="zi"
		end
		if findstring(c,"茯苓") then
			have.fuling=have.fuling-1
			yaoname="fuling"
		end
	end
	if findstring(w[0],"丘处机轻轻地拍了拍你的头。\n丘处机说道："..me.charname.."干的不错，下去休息一下吧！") then
		alias.resetidle()
		closeclass("mp_qz_boyao")
		openclass("mp_qz_pre")
		alias.checkexp("mp")
	end
end
------------------------------------------------------------------------------------
-- mp_qz_boyao_ti
------------------------------------------------------------------------------------
function mp_qz_boyao_ti.dosomething1(n,l,w)
	local _tb
	if findstring(l,"你对著.+喝道：「.+」") then
		if findstring(boyaocmd,"baozi") then
			_tb=utils.split(fjpfm,"|")
			boyaocmd=_tb[1]
			alias.uw()
			if string.len(mpweapon)>0 then
				if mpweapon=="staff" then alias.wi(staffid) else alias.wi(mpweapon) end
			else alias.uw() end
			run("jiali "..mpjiali..";jiajin "..mpjiajin)
		else boyaocmd="" end
	end
	if findstring(l,"猴子倒在地上，挣扎了几下就死了。","蜜蜂掉在地上，挣扎了几下就死了。","你用药锄拨动着四周的灌木杂草，仔细地看有没有草药！","乌鸦发出一声凄厉的鸣叫，栽倒在地上死了。","小豹子惨嚎一声，死了！","野兔凄惨的嚎了几声，死了。") then
		boyaocmd=""
	end
	if findstring(l,"小豹子低低地吼了一声，滚倒在地上晕了过去。") then
		boyaocmd="kill baozi"
	end
	if findstring(l,"梅花鹿长声悲嘶，乒地一声摔倒在地上。") then
		boyaocmd="kill deer"
	end
	if findstring(l,"猴子脚下一个不稳，跌在地上昏了过去。") then
		boyaocmd="kill monkey"
	end
	if findstring(l,"野兔长声悲嘶，乒地一声摔倒在地上。") then
		boyaocmd="kill ye tu"
	end
end
function mp_qz_boyao_ti.timer()
	run("hp")
	if stat.havedu>0 then alias.startliaoshang()
	elseif havefj>0 then alias.startfj()
	else
		run(boyaocmd)
		run("bo")
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function mp_qz.update()
	local  mp_qz_boyao_triggerlist={
	       {name="mp_qz_boyao_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_qz_boyao.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_qz_boyao_triggerlist) do
		addtri(v.name,v.regexp,"mp_qz_boyao",v.script,v.line)
	end
	local _tb2={
		"丘处机说道：.+%?\\n你给丘处机.+。\\Z",
		"丘处机轻轻地拍了拍你的头。\\n丘处机说道(.+)\\Z",
	}
	local  mp_qz_boyao_m_triggerlist={
	       {name="mp_qz_boyao_m_dosth2",line=2,regexp=linktri2(_tb2),script=function(n,l,w)    mp_qz_boyao.dosomething2(n,l,w)  end,},
	}
	for k,v in pairs(mp_qz_boyao_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_qz_boyao",v.script,v.line)
	end
	closeclass("mp_qz_boyao")
	
	local  mp_qz_boyao_ti_triggerlist={
	       {name="mp_qz_boyao_ti_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_qz_boyao_ti.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_qz_boyao_ti_triggerlist) do
		addtri(v.name,v.regexp,"mp_qz_boyao_ti",v.script,v.line)
	end
	AddTimer("mp_qz_boyao_ti_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "mp_qz_boyao_ti.timer")
	SetTimerOption("mp_qz_boyao_ti_timer", "group", "mp_qz_boyao_ti")
	closeclass("mp_qz_boyao_ti")
	
	local  mp_qz_pre_triggerlist={
	       {name="mp_qz_pre_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_qz_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_qz_pre_triggerlist) do
		addtri(v.name,v.regexp,"mp_qz_pre",v.script,v.line)
	end
	local _tb2={
		"你向丘处机打听有关「job」的消息。\\n(.+)\\Z",
	}
	local _tb3={
		"你向丘处机打听有关「job」的消息。\\n(.+)\\n(.+)\\Z",
	}
	local  mp_qz_pre_m_triggerlist={
	       {name="mp_qz_pre_m_dosth2",line=2,regexp=linktri2(_tb2),script=function(n,l,w)    mp_qz_pre.dosomething1(n,l,w)  end,},
	       {name="mp_qz_pre_m_dosth3",line=3,regexp=linktri2(_tb3),script=function(n,l,w)    mp_qz_pre.dosomething2(n,l,w)  end,},
	}
	for k,v in pairs(mp_qz_pre_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_qz_pre",v.script,v.line)
	end
	closeclass("mp_qz_pre")
	
	local  mp_qz_start_triggerlist={
	       {name="mp_qz_start_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_qz_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_qz_start_triggerlist) do
		addtri(v.name,v.regexp,"mp_qz_start",v.script,v.line)
	end
	local _tb2={
		"你现在不忙。\\n(.+)\\Z",
		"你向赵志敬打听有关「天罡北斗阵」的消息。\\n(.+)\\Z",
	}
	local _tb3={
		"你向赵志敬打听有关「天罡北斗阵」的消息。\\n(.+)\\n(.+)\\Z",
	}
	local _tb4={
		"你向赵志敬打听有关「天罡北斗阵」的消息。\\n(.+)\\n(.+)\\n(.+)\\Z",
	}
	local _tb5={
		"你向赵志敬打听有关「天罡北斗阵」的消息。\\n(.+)\\n(.+)\\n(.+)\\n(.+)\\Z",
	}
	local  mp_qz_start_m_triggerlist={
	       {name="mp_qz_start_m_dosth2",line=2,regexp=linktri2(_tb2),script=function(n,l,w)    mp_qz_start.dosomething2(n,l,w)  end,},
	       {name="mp_qz_start_m_dosth3",line=3,regexp=linktri2(_tb3),script=function(n,l,w)    mp_qz_start.dosomething3(n,l,w)  end,},
	       {name="mp_qz_start_m_dosth4",line=4,regexp=linktri2(_tb4),script=function(n,l,w)    mp_qz_start.dosomething4(n,l,w)  end,},
	       {name="mp_qz_start_m_dosth5",line=5,regexp=linktri2(_tb5),script=function(n,l,w)    mp_qz_start.dosomething5(n,l,w)  end,},
	}
	for k,v in pairs(mp_qz_start_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_qz_start",v.script,v.line)
	end
	closeclass("mp_qz_start")

	local  mp_qz_watch_triggerlist={
	       {name="mp_qz_watch_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_qz_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_qz_watch_triggerlist) do
		addtri(v.name,v.regexp,"mp_qz_watch",v.script,v.line)
	end
	local noecho_trilist={
			".*崔志方.*",".*王志坦.*",".*李志常.*",".*尹志平.*",".*陈志益.*",".*申志凡.*",
			".*达尔巴.*",".*霍都.*",".*金轮法王.*",".*梁子翁.*",".*欧阳克.*",".*彭连虎.*",".*沙通天.*",".*尹克西.*",
			".*结果只是轻轻地划破他的皮肉.*",
			".*结果只是轻轻地碰到.*",
			".*造成一处瘀青.*",
			".*砍出一道伤口.*",
			".*刺出一个创口.*",
			".*被他格开了.*",
			".*血淋淋的伤口.*",
			".*血肉模糊的血窟窿.*",
			".*刺破他的皮肉.*",
			".*被他挡开了.*",
			".*细长的血痕.*",
			".*就地一滚.*",
			".*天罡北斗阵法.*",
			".*天罡北斗阵暗合.*",
			".*天罡北斗阵越缩.*",
			".*天罡北斗阵气势.*",
			"位上的.+大喝一声，一招","位上的.+气沉丹田，暗运神功","位上的.+身形向上飘起","位上的.+手中剑一指，纵起丈余，一式","位上的.+踏奇门，走偏锋","位上的.+挺身而出，步法精妙，长袖飘飘，攻势如虹。","位上的.+向前迈去一大步，使出","位上的.+运力一抖剑，一式","位上的.+左手捏着剑诀，右足踏开一招",
			}
	local _noechotri=linktri(noecho_trilist)

	addtri("mp_qz_watch_gag_dosth1",_noechotri,"mp_qz_watch","")
	SetTriggerOption("mp_qz_watch_gag_dosth1","omit_from_output",1)
	closeclass("mp_qz_watch")
end
mp_qz.update()
