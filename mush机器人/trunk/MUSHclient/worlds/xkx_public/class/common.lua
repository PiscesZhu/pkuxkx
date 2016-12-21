common={}
login={}
aoyao={
	yaoName="紫金通脉丹",
	yaoid="dan",
	buyNameList="老山参|鹿茸|麝香|雪莲|茯苓",
	buyidList="lao shanshen|lurong|shexiang|xuelian|fuling",
	buyno=1,
	needgold=401,
}
bidu={}
cure={}
boat={}
boat_yell={}
dazuo={}
fang={}
liaoshang={}
qudu={}
quit={}
quitdis={}
shizhe={}
tongmai={}
yinyun={}
safego=""
------------------------------------------------------------------------------------
-- login
------------------------------------------------------------------------------------
function login.dosomething1(n,l,w)
	local _f,_t
	wait.make(function()
		--if findstring(l,"但是很显然的，郝大通现在的状况没有办法给你任何答覆。","看起来郝大通并不想跟你较量。","这里没有 hao datong 这个人。") then
		--	_f=function() alias.flytonpc("谭处端") end
		--	wait.time(2);_f()
		--end
		--if findstring(l,"但是很显然的，谭处端现在的状况没有办法给你任何答覆。","看起来谭处端并不想跟你较量。","这里没有 tan chuduan 这个人。") then
		--	_f=function() alias.flytonpc("郝大通") end
		--	wait.time(2);_f()
		--end
		--if findstring(l,"郝大通对你说道：这里是广宁殿，其它的老头子不便多说。") then
		--	run("fight hao datong;perform sanhua;halt;set sanhua=over")
		--end
		if findstring(l,"你目前还没有任何为 check=jifa 的变量设定。") then
			--if jifa.forcename=="xuanyinzhenqi" then alias.jfhbmz();_t="hbmz" else Execute("/alias.jf"..me.menpai.."()");_t="" end
			-- if setting~=me.menpai.._t then Execute("/alias.set"..me.menpai.._t.."()") end
			if me.menpai=="em" then run("put fuling in yaodai") end
			if me.menpai=="bt" then run("put fuling in yaodai;convert she") end
			--if me.menpai=="qz" then run("jifa strike sanhua-juding;bei none;bei sanhua-juding");alias.flytonpc("谭处端")
			--else closeclass("login");alias.startworkflow() end
			if me.menpai=="xs" and tonumber(roomno_now)==439 then openclass("mp_xs_npc1");alias.xslianwu() else alias.flytoid(1282) end
		end
		if findstring(l,"数码世界，数字地图，1282就是这里！") then
			alias.resetidle()
			run("mo bi")
			closeclass("login")
			alias.startworkflow()
		end
		--if findstring(l,"你目前还没有任何为 sanhua=over 的变量设定。") then
		--	closeclass("login")
		--	alias.jfqz()
		--	_f=function() alias.startworkflow() end
		--	wait.time(1);_f()
		--end
		if findstring(l,"您目前的权限是：") then
			run("get all;score;jifa")
			if me.menpai=="dl" then run("drop pao")
			elseif me.menpai=="th" then run("drop robe")
			else run("drop cloth") end
			alias.ch()
			run("wear all;hp;set check=jifa")
		end
		if findstring(l,"重新连线完毕。") then
			run("score;jifa")
			alias.ch()
			run("hp;set check=jifa")
		end
		if findstring(l,"请您输入密码") then
			Execute(me.pwd)
			Execute("yes")
			--run(me.pwd..";yes")
		end
		if findstring(l,"对不起，由於连接过於频繁，你的地址被暂时封锁。") then
			Disconnect()
		end
		--if findstring(l,"谭处端对你说道：这里是藏经阁二楼，其它的老头子不便多说。") then
		--	run("fight tan chuduan;perform sanhua;halt;set sanhua=over")
		--end
		--if findstring(l,"有一天，你踩着七色云彩来迎娶『郝大通』") then
		--	run("ask hao datong about here")
		--end
		--if findstring(l,"有一天，你踩着七色云彩来迎娶『谭处端』") then
		--	run("ask tan chuduan about here")
		--end
	end)
end
------------------------------------------------------------------------------------
-- aoyao
------------------------------------------------------------------------------------
function aoyao.dosomething1(n,l,w)
	local _f,_tb
	if findstring(l,"药炉下正燃着火。") then
		aoyao.fire=1
	end
	if findstring(l,"你深吸一口气，停了下来。") then
		alias.resetidle()
		DeleteTimer("aoyao_timer")
		alias.checkbusy("miehuo")
	end
	if findstring(l,"炭火渐渐明亮，看来可以开始了。") then
		alias.resetidle()
		run("aoyao")
	end
	if findstring(l,".+将炭火熄灭。") then
		aoyao.fire=0
	end
	if findstring(l,"你熬这么多药干吗？") then
		alias.resetidle()
		run("set aoyao=false")
		closeclass("close_aoyao")
	end
	if findstring(l,"你开炉一看，炉中之物象一团浆糊一样，看来没什么用。","你取出药材一看，已经烧成一团焦炭。") then
		alias.checkbusy("false")
	end
	if findstring(l,"哟，抱歉啊，我这儿正忙着呢……您请稍候。") then
		wait.make(function()
			_f=function()
						_tb=utils.split(aoyao.buyidList)
						run("buy ".._tb[aoyao.buyno])
				end
			wait.time(1);_f()
		end)
	end
	if findstring(l,"这里没有 wang tongzhi 这个人。") then
		run("set aoyao=flase")
		alias.close_aoyao()
	end
	if findstring(l,"你打开了自己的谣言频道。") then
		run("tune rumor")
	end
	if findstring(l,"你目前还没有任何为 busyover=false 的变量设定。") then
		_tb=utils.split(aoyao.buyidList,"|")
		for k,v in ipairs(_tb) do
			run("drop "..v)
		end
		run("set aoyao=false")
		alias.close_aoyao()
	end
	if findstring(l,"你目前还没有任何为 busyover=miehuo 的变量设定。") then
		alias.resetidle()
		run("mie huo;open lip;qu yao")
	end
	if findstring(l,"你目前还没有任何为 busyover=quyao 的变量设定。") then
		run("set aoyao=true")
		alias.close_aoyao()
	end
	if findstring(l,"你目前还没有任何为 checkfire=yes 的变量设定。") then
		alias.resetidle()
		if aoyao.fire>0 then
			wait.make(function()
				_f=function()
							run("look lu;set checkfire=yes")
							aoyao.fire=0
					end
				wait.time(2);_f()
			end)
		else
			run("open lip")
			_tb=utils.split(aoyao.buyidList,"|")
			for k,v in ipairs(_tb) do
				run("add "..v.." in lu")
			end
			run("pour water;close lip;burn coal")
			AddTimer("aoyao_timer", 0, 0, 5, "", timer_flag.Enabled + timer_flag.Replace, "alias.resetidle")
			SetTimerOption("aoyao_timer", "group", "aoyao")
		end
	end
	if findstring(l,"你向王通治打听有关「你妈可好？」的消息。") then
		alias.resetidle()
		_tb=utils.split(aoyao.buyidList,"|")
		run("buy ".._tb[aoyao.buyno])
	end
	if findstring(l,"数码世界，数字地图，[6|2057]就是这里！") then
		alias.resetidle()
		run("look lu;set checkfire=yes")
		aoyao.fire=0
	end
	if findstring(l,"有一天，你踩着七色云彩来迎娶『王通治』") then
		alias.resetidle()
		run("ask wang tongzhi about 你妈可好？")
	end
	if findstring(l,"你从药炉中取出一") then
		if w[3]==aoyao.yaoName then alias.checkbusy("quyao") end
	end
	if findstring(l,"你从王通治那里买下了一") then
		_tb=utils.split(aoyao.buyNameList,"|")
		if w[4]==_tb[aoyao.buyno] then
			aoyao.buyno=aoyao.buyno+1
			_tb=utils.split(aoyao.buyidList,"|")
			if aoyao.buyno<=table.getn(_tb) then
				wait.make(function()
					_f=function() run("buy ".._tb[aoyao.buyno]) end
					wait.time(1);_f()
				end)
			else
				if aoyao.address=="wai" then
					aoyao.address="nei"
					alias.flytoid(2057)
				else
					aoyao.address="wai"
					alias.flytoid(6)
				end
			end
		end
	end
end
------------------------------------------------------------------------------------
-- bidu
------------------------------------------------------------------------------------
function bidu.dosomething1(n,l,w)
	if findstring(l,"你目前还没有任何为 busyover=bidu 的变量设定。") then run("hp;yun bidu") end
	if findstring(l,"你闭目而坐，急呼缓吸，过了一顿饭工夫，脸色略复红润。","你无法在战斗中运功疗毒") then alias.checkbusy("bidu") end
	if findstring(l,"你并未中毒") then
		closeclass("bidu")
		stat.havedu=0
		Execute("/alias.start"..workflow.nowjob.."()")
	end
end
------------------------------------------------------------------------------------
-- cure
------------------------------------------------------------------------------------
function cure.dosomething1(n,l,w)
	if findstring(l,"你目前还没有任何为 busyover=cure 的变量设定。") then run("hp;yun cure") end
	if findstring(l,"你所学的内功中没有这种功能。","你现在不须要疗精！") then
		closeclass("cure")
		stat.havedu=0
		Execute("/alias.start"..workflow.nowjob.."()")
	end
	if findstring(l,"你在身上划一道伤口，挤出一些淤血，气沉丹田，开始凝神疗精。") then
		wait.make(function()
			local _f=function() run("yun cure") end
			wait.time(0.5);_f()
		end)
	end
end
------------------------------------------------------------------------------------
-- boat
------------------------------------------------------------------------------------
function boat.dosomething1(n,l,w)
	local _f,a,b,c
	wait.make(function()
		if findstring(l,"说“到啦，上岸吧”，随即把一块踏脚板搭上堤岸。","船夫扳桨划船，在湖中行了数里，缓缓停泊在岸边，将一块踏脚板搭上了堤岸。") then
			alias.resetidle()
			boatDirection="out"
			if isopen("dazuo") then alias.tdz()
			else
				if isopen("skills_lian") then
					tuna=0
					alias.tlw()
				else run("halt") end
			end
			alias.trymove(boatDirection)
		end
		if findstring(l,"练内功要有间隙，太劳累会走火入魔的。") then
			if tunanum>0 then
				_f=function() run("tuna "..tunanum) end
				wait.time(1);_f()
			end
		end
		if findstring(l,"你的内力不够，无法施展一苇渡江绝技！") then
			alias.resetidle()
			if me.menpai=="sl" then
				_f=function() run("yun du") end
				wait.time(2);_f()
			end
		end
		if findstring(l,"你刚刚压制住身上伤势，还是不要妄动真气。") then
			alias.resetidle()
			yunbusy=1
		end
		if findstring(l,"你猛吸几口大气，站了起来。") then
			run("yun regenerate")
		end
		if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
			alias.resetidle()
			if workflow.nowjob=="xue" and usepot=="lingwu" then closeclass("skills_lingwu") else skills_num=1;alias.lianwu() end
		end
		if findstring(l,"你目前还没有任何为 lian=over 的变量设定。") then
			alias.resetidle()
			if tuna~=nil and tonumber(tuna)>0 then
				-- 所有技能练满，吐纳了
				tunanum=math.ceil(tonumber(hp.maxjing/2))
				run("tuna "..tunanum)
			end
		end
		if findstring(l,"松花江化冻了，你喊") then
			alias.resetidle()
			checkyell=1
			if skillslist["shaolin-shenfa"]==nil then skillslist["shaolin-shenfa"]={} end
			if skillslist["shaolin-shenfa"]["lvl"]==nil then skillslist["shaolin-shenfa"]["lvl"]=1 end
			if skillslist["hunyuan-yiqi"]==nil then skillslist["hunyuan-yiqi"]={} end
			if skillslist["hunyuan-yiqi"]["lvl"]==nil then skillslist["hunyuan-yiqi"]["lvl"]=1 end
			if (me.menpai=="sl" and me.master=="觉心" and skillslist["shaolin-shenfa"]["lvl"]>200 and skillslist["hunyuan-yiqi"]["lvl"]>160 and hp.maxneili>2000) then run("yun du") else run("yell boat") end
		end
		if findstring(l,"接著你一跃而起，脚尖在苇枝上一点，两袖飘飘，箭一般地在水面上穿了过去。") then
			alias.movefinish()
		end
		if findstring(l,"你目前还没有任何为 boat=out 的变量设定。") then
			alias.resetidle()
			closeclass("boat")
			if workflow.nowjob=="xue" and usepot=="lingwu" then
				openclass("skills_lingwu")
			else
				if _G[workflow.nowjob.."weapon"]~=nil and string.len(_G[workflow.nowjob.."weapon"])>0 then
					alias.wi(_G[workflow.nowjob.."weapon"])
				else
					alias.uw()
				end
			end
			if tunanum~=nil and tunanum>0 then run("yun regenerate") end
			if gps_gyz_go_e_boat==1 then
				run("w")
				gps_gyz_go_e_boat=0
			end
			alias.movefinish()
		end
		if findstring(l,"你目前还没有任何为 boat=enter 的变量设定。") then
			alias.resetidle()
			run("yell boat")
			if isopen("dazuo") then run("set checkhp="..type_dz)
			else
				if not isopen("skills_lian") then alias.dz(set_neili_global)
				else run("hp;set lian") end
			end
		end
		if findstring(l,"你目前还没有任何为 checkmove=yes 的变量设定。") then
			if trymovesuccess then run("set boat="..boatDirection)
			else
				_f=function() run("halt");alias.trymove(boatDirection) end
				wait.time(0.3);_f()
			end
		end
		if findstring(l,"你目前还没有任何为 checkyell=yes 的变量设定。") then
			if checkyell==0 then
				gpserrnum=1
				run("set walk off")
			end
		end
		if findstring(l,"你目前还没有任何为 checkyunbusy=yes 的变量设定。") then
			if yunbusy>0 and me.menpai=="sl" then
				yunbusy=0
				_f=function() run("yun du;set checkyunbusy=yes") end
				wait.time(2);_f()
			end
		end
		if findstring(l,"你鼓足中气，长啸一声：“船家！”","你使出吃奶的力气喊了一声：“船家”","你吸了口气，一声“船家”，声音中正平和地远远传了出去。") then
			alias.resetidle()
			checkyell=1
			openclass("boat_yell")
		end
		if findstring(l,"你见江面结冻，便壮起胆子踩冰而过。") then
			alias.resetidle()
			checkyell=1
			if gps_dmkz_cc==0 then run("e") else run("w") end
			alias.close_boat()
			alias.close_gps_dealwith()
			alias.movefinish()
		end
		if findstring(l,"一叶扁舟缓缓地驶了过来") then
			alias.resetidle()
			openclass("boat_yell")
		end
		if findstring(l,"你的动作还没有完成，不能移动。") then
			trymovesuccess=false
		end
	end)
end
------------------------------------------------------------------------------------
-- boat_yell
------------------------------------------------------------------------------------
function boat_yell.dosomething1(n,l,w)
	local _f,a,b,c
	wait.make(function()
		if findstring(l,"湖面上的船家来来往往，一无反应……") then
			alias.resetidle()
			closeclass("boat_yell")
			if gps_gyz_go_e_boat==0 then
				run("e")
				gps_gyz_go_e_boat=1
				_f=function() run("yell boat") end
				wait.time(1);_f()
			else
				run("w")
				gps_gyz_go_e_boat=0
				_f=function() run("yell boat") end
				wait.time(1);_f()
			end
		end
		if findstring(l,"可是这时侯夜色已深，湖面上的船家大都歇息了，祗有西边的湖岸还有扁舟往返。") then
			alias.resetidle()
			closeclass("boat_yell")
			gps_gyz_go_e_boat=0
			_f=function() run("w;yell boat") end
			wait.time(0.5);_f()
		end
		a,b,c=string.find(l,"只听得(.+)面上隐隐传来：“别急嘛，这儿正忙着呐……”")
		if c~=nil then
			alias.resetidle()
			closeclass("boat_yell")
			if string.find(c,"湖") then
				if gps_gyz_go_e_boat==0 then
					run("e")
					gps_gyz_go_e_boat=1
					_f=function() run("yell boat") end
					wait.time(1);_f()
				else
					run("w")
					gps_gyz_go_e_boat=0
					_f=function() run("yell boat") end
					wait.time(1);_f()
				end
			else
				if not isopen("dazuo") and not isopen("skills_lian") then alias.dz(set_neili_global) end
				if roomname=="汉水南岸" or roomname=="汉水北岸" then run("h;w;sw;nw") end
				if roomname=="汉水畔" then run("h;ne;e;se") end
				_f=function() run("yell boat") end
				wait.time(1);_f()
			end
		end
		if findstring(l,"岸边一只渡船上的老艄公说道：正等着你呢，上来吧。","岸边一只渡船上的船夫说道：正等着你呢，上来吧。","一条渔船应声慢慢驶了过来","一叶扁舟缓缓地驶了过来") then
			alias.resetidle()
			closeclass("boat_yell")
			boatDirection="enter"
			run("halt")
			alias.trymove(boatDirection)
		end
	end)
end
------------------------------------------------------------------------------------
-- dazuo
------------------------------------------------------------------------------------
function dazuo.dosomething1(n,l,w)
	local _f,_t,a,b,c
	wait.make(function()
		if findstring(l,"战斗中不能练内功，会走火入魔。","战斗中运功疗伤？找死吗？") then
			if not isopen("fj_escape") then
				_f=function() run("dazuo 10") end
				wait.time(3);_f()
			end
		end
		if findstring(l,"这里空气不好，不能打坐。") then
			if not isopen("mp_bt_watch") then
				-- bt会处理成飞到欧阳峰处打坐，所以这里通过class判断排除bt
				run(safego..";dazuo 10")
			end
		end
		if findstring(l,"你一觉醒来，只觉精力充沛。该活动一下了。") then alias.resetidle();run("hp;dazuo 10") end
		if hp.neili<hp.maxneili/2 and me.menpai=="gb" then alias.resetidle();run("sleep") end
		if findstring(l,"呆在武庙里，你只觉得心慌意乱，怎么也集中不起精神来！") then run("e;dazuo 10") end
		if findstring(l,"练内功要有间隙，太劳累会走火入魔的。") then
			alias.resetidle()
			_f=function() run("dazuo "..dz()) end
			wait.time(1);_f()
		end
		if findstring(l,"你缓缓坐起身来调匀呼吸，将混天功真气流遍全身。","你就地盘坐，默运玄阴真气疗伤，一股内息自丹田而起游走全身。","你就地盘坐，运使紫霞神功疗伤，内息返诸柔善，鸣天鼓，饮玉浆，荡华池，叩金梁，流通周身脉络。","你盘膝坐下，调气护伤，运气在周身大穴运转。","你潜运内力，在周身穴道流转疗伤，调匀气息。","你全身放松，坐下来开始运功疗伤。","你一运气，立时便觉丹田中一股暖意升将上来。","你就地盘坐，默运摩天云气疗伤，一股内息自丹田而起游走全身。"
		,"你脚下缓缓踏著八卦方位，步法暗合五行九宫，一边潜运碧涛玄功调理伤势。") then
			if hp.healthqi<95 then openclass("dazuo_resetidle") end
		end
		if findstring(l,"你并未受到内伤。","你催运混元功疗伤片刻，体内真气运转无碍，内伤已经平复，当即站起身来。","你催运玄阴真气疗伤片刻，体内真气运转无碍，内伤已经平复，当即站起身来。","你催运紫霞功疗伤多时，一道真气在体内运转无碍，内伤已经平复，当即站起身来。","你依法盘旋得数下，真气便如是细流归支流、支流汇大川，内息畅通无碍。","你运功良久，自觉经脉顺畅，内伤尽去，神元气足地站了起来。","你只觉内息运转顺畅，将真气还合丹田，站起身来。","你催运摩天云气疗伤片刻，体内真气运转无碍，内伤已经平复，当即站起身来。","你缓步行走多时，自觉经脉顺畅，内伤尽去，在东方乙木之位停下了步伐。") then
			alias.resetidle()
			--need_yunheal=0
			closeclass("dazuo_resetidle")
			run("dazuo "..dz())
		end
		if findstring(l,"你刚刚压制住身上伤势，还是不要妄动真气。") then
			alias.resetidle()
			--_f=function() run("yun heal") end
			_f=function() run("dazuo 10") end
			wait.time(3);_f()
		end
		a,b,c=string.find(l,"你目前还没有任何为 checkhp=(.+) 的变量设定。")
		if c~=nil then
			alias.resetidle()
			alias.setmpLimitedMark()
			type_dz=c
			if jifa.forcename=="motianyunqi" then run("yun shougong") end
			if stat.havedu>0 then alias.startliaoshang()
			else
				if hp.healthqi<100 and hp.neili>hp.maxneili then 
					--run("yun heal")
					alias.yunheal()
				else
					--if hp.qi<(hp.maxqi*2/3) then run("yun recover;hp;set checkhp="..type_dz)
					if hp.qi<(hp.maxqi/2) then
						if jifa.force<100 then
							print("jifaforce不达标,等待3秒自然恢复")
							_f=function() run("hp;set checkhp="..type_dz) end
							wait.time(3);_f()
						else
							run("yun recover;hp;set checkhp="..type_dz)
						end
					else
						if tonumber(type_dz)~=nil and tonumber(type_dz)>0 then
							if hp.neili>(hp.maxneili*tonumber(type_dz)/100) then alias.tdz() else run("dazuo "..dz()) end
						else
							if (hp.maxneili*2-hp.neili)<dz() then
								if (hp.maxneili*2-hp.neili+1)<10 then _t=10 else _t=hp.maxneili*2-hp.neili+1 end
								run("dazuo ".._t)
							else
								if roomno_now==1801 and me.menpai=="bt" then alias.yunbt() else run("dazuo "..dz()) end
							end
						end
					end
				end
			end
		end
		--if findstring(l,"你深深吸了几口气，强行压制住了身上的伤势。") then
		--	alias.resetidle()
		--	need_yunheal=1
		--end
		if findstring(l,"你是来作客还是来练功啊？") then
			run("se;e;dazuo 10")
		end
		--if findstring(l,"你体内的真气不够。","你现在正忙着呢。","你已经受伤过重，只怕一运真气便有生命危险！") then
		--	alias.resetidle()
		--	run("hp")
			--_f=function() run("yun heal") end
		--	_f=function() run("dazuo 10") end
		--	wait.time(5);_f()
		--end
		if findstring(l,"你现在精不够，无法控制内息的流动！") then
			alias.resetidle()
			if stat.havedu>0 or hp.healthjing<85 then alias.startliaoshang()
			else
				_f=function() run("yun regenerate;dazuo "..dz()) end
				wait.time(1);_f()
			end
		end
		if findstring(l,"你在倒立中，怎么还能分出心神来做其它事情？！") then
			alias.resetidle()
			run("release yuanshi;dazuo "..dz())
		end
		if findstring(l,"你还是老老实实地跪著吧，别做其他事了。","你正在用心领悟功夫，没闲暇做其它事情！") then
			alias.resetidle()
			run("stand;dazuo "..dz())
		end
		if findstring(l,"你正在运功疗伤，忽觉内息後继乏力，祗得暂缓疗伤，站起身来。") then
			alias.resetidle()
			closeclass("dazuo_resetidle")
			--_f=function() run("yun heal") end
			_f=function() run("dazuo 10") end
			wait.time(5);_f()
		end
		if findstring(l,"数码世界，数字地图，"..tostring(me.dazuobaseid).."就是这里！") then
			alias.dz(type_dz)
		end
		if findstring(l,"你运功完毕，深深吸了口气，站了起来。") then
			alias.resetidle()
			if (hp.food<hp.maxfood and hp.water<hp.maxwater) then alias.et() end
			if (hp.water<30) then run("drink jiudai") end
			if not isopen("boat") then
				if (hp.neili>(hp.maxneili*set_neili_global/100) and type_dz=="addneili") then
					-- 在增加内力模式，当内力快满前发生一次检查job的触发，在其他模块里面进行触发处理
					if (havefj>0 and not isopen("mp_xs_watch")) or (mpJobLimited==0 and not isopen("mp_xs_watch")) then
						alias.close_dz()
						alias.startworkflow()
					else
						if string.len(resumejob)>0 then
							run(resumejob)
							resumejob=""
						end
					end
				end
			end
			run("hp;set checkhp="..type_dz)
			--if need_yunheal==1 and hp.neili>hp.maxneili then run("yun heal") else run("hp;set checkhp="..type_dz) end
		end
	end)
end
------------------------------------------------------------------------------------
-- fang
------------------------------------------------------------------------------------
function fang.dosomething1(n,l,w)
	local a,b,c
	a,b,c=string.find(l,"[> ]*(.+)倒在地上，挣扎了几下就死了。")
	if c~=nil and c==killname then
		run("jiajin basic;jiali 0")
		npcfaint=true
		alias.checkbusy("killover")
	end	
	if findstring(l,"你的眼前一黑，接著什么也不知道了") then
		print("他妈的，被干翻了～～")
		closeclass("fang")
	end
	if findstring(l,"你目前还没有任何为 killover=yes 的变量设定。") then
		closeclass("fang")
		Execute("/alias.start"..workflow.nowjob.."()")
	end
end
------------------------------------------------------------------------------------
-- liaoshang
------------------------------------------------------------------------------------
function liaoshang.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"沉思了一会说道：阁下所中的.+已并无异样....","沉思了一会说道：阁下所中的.+已深入心脉，请容在下为您医治。","说道：先看看你的脉象吧。","你口念咒语『神马都是浮云,虾米都是尘土』，『武馆休息室』立马到达！","你身不由几的微微一跳，只觉的一股热气从顶门直透下来。","你突然觉得一股暖流自顶而入，口中吐出几口黑血，眼前一黑就什么也看不见了！","便提起你的手把了一会脉。") then alias.resetidle() end
		if findstring(l,"沉思了一会说道：阁下所中的.+已并无异样，实在无从治起。","在你的耳边悄声说道：你没有中毒！") then
			closeclass("liaoshang")
			stat.havedu=0
			run("e")
			Execute("/alias.start"..workflow.nowjob.."()")
		end
		if findstring(l,"慢慢地一阵眩晕感传来，你终于又有了知觉") then
			alias.resetidle()
			stat.havedu=0
			alias.checkbusy("liaoshang")
		end
		if findstring(l,"你目前还没有任何为 busyover=liaoshang 的变量设定。") then
			run("sleep")
		end
		if findstring(l,"你一觉醒来，只觉精力充沛。该活动一下了。") then
			alias.resetidle()
			stat.havedu=0
			run("e")
			Execute("/alias.start"..workflow.nowjob.."()")
		end
		if findstring(l,"你口念咒语『神马都是浮云,虾米都是尘土』，『武馆休息室』立马到达！") then
			alias.resetidle()
			run("ask "..dummy.id.." about liaoshang")
		end
		--if findstring(l,"在你的耳边悄声说道：去武馆睡房吧！") then
		--	_f=function() alias.flyto("武馆休息室") end
		--	wait.time(2);_f()
		--end
		if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。","这里没有 ","在你的耳边悄声说道：小样！我不是这么随便的人～～") then
			alias.flytonpc("何红药")
		end
		--if findstring(l,"你口念咒语『神马都是浮云,虾米都是尘土』，『当铺』立马到达！") then
		if findstring(l,"有一天，你踩着七色云彩来迎娶『何红药』") then
			alias.resetidle()
			run("buy shouwu jing")
		end
		if findstring(l,"穷光蛋，一边呆着去！") then
			alias.checkitems()
		end
		if findstring(l,"你从何红药那里买下了一棵首乌精。") then
			run("fu shouwu jing")
			closeclass("liaoshang")
			stat.havedu=0
			Execute("/alias.start"..workflow.nowjob.."()")
		end
		if findstring(l,"你想买的东西我这里没有。") then
			print("等死吧")
			closeclass("liaoshang")
			stat.havedu=0
			Execute("/alias.start"..workflow.nowjob.."()")
		end
	end)
end
------------------------------------------------------------------------------------
-- qudu
------------------------------------------------------------------------------------
function qudu.dosomething1(n,l,w)
	if findstring(l,"你目前还没有任何为 busyover=qudu 的变量设定。") then
		run("hp;yun qudu")
	end
	if findstring(l,"你并未中毒") then
		closeclass("qudu")
		stat.havedu=0
		Execute("/alias.start"..workflow.nowjob.."()")
	end
	if findstring(l,"你头下脚上，倒运气息，气血逆行，想让","你无法在战斗中运功疗毒") then
		alias.checkbusy("qudu")
	end
end
------------------------------------------------------------------------------------
-- quit
------------------------------------------------------------------------------------
function quit.dosomething1(n,l,w)
	if findstring(l,"欢迎下次再来！") then
		cmd.nums=0
		closeclass("quit")
		alias.initialize_variable()
		wait.make(function()
			local _f=function() Connect() end
			wait.time(5);_f()
		end)
	end
	if findstring(l,"开始退出游戏，进行中……") then
		stat.quiting=1
		cmd.nums=0
	end
end
function quit.timer()
	alias.resetidle()
	if stat.quiting==nil or stat.quiting==0 then run("halt;quit") end
	run("yun recover")
	alias.yjl()
	run("hp")
end
------------------------------------------------------------------------------------
-- quitdis
------------------------------------------------------------------------------------
function quitdis.dosomething1(n,l,w)
	if findstring(l,"开始退出游戏，进行中……") then
		notconnect=1
		Disconnect()
	end
end
------------------------------------------------------------------------------------
-- shizhe
------------------------------------------------------------------------------------
function shizhe.dosomething1(n,l,w)
	if findstring(l,"你的眼前一黑，接著什么也不知道了") then
		haveshizhe=0
		print("他妈的，被干翻了～～")
		closeclass("shizhe")
	end
	if findstring(l,"日月神教使者倒在地上，手脚几下抽动便死了！","日月神教使者突然卖一破绽，跳出战圈，逃了！","日月神教使者悻然说道：算你够狠！老子先不奉陪了！咱们走着瞧！") then
		haveshizhe=0
		run("jiajin basic;jiali 0")
		npcfaint=true
		alias.checkbusy("killover")
	end
	if findstring(l,"你目前还没有任何为 killover=yes 的变量设定。") then
		closeclass("shizhe")
		Execute("/alias.start"..workflow.nowjob.."()")
	end
end
------------------------------------------------------------------------------------
-- tongmai
------------------------------------------------------------------------------------
function tongmai.timer()
	stat.haveyyz=0
end
function tongmai.timer1()
	DeleteTimer("tongmai_timer")
end
function tongmai.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"在你的耳边悄声说道：没有内力治疗！") then
			closeclass("tongmai")
			stat.haveyyz=0
			AddTimer("tongmai_timer", 0, 0, 1, "", timer_flag.Enabled + timer_flag.Replace, "tongmai.timer")
			AddTimer("tongmai_timer1", 0, 0, 120, "", timer_flag.Enabled + timer_flag.Replace + timer_flag.OneShot, "tongmai.timer1")
			Execute("/alias.start"..workflow.nowjob.."()")
		end
		if findstring(l,"在你的耳边悄声说道：你的一阳指已治愈！") then
			closeclass("tongmai")
			stat.haveyyz=0
			run("e")
			Execute("/alias.start"..workflow.nowjob.."()")
		end
		if findstring(l,"在你的耳边悄声说道：小样！我不是这么随便的人～～","这里没有 ") then
			closeclass("tongmai")
			stat.haveyyz=0
			AddTimer("tongmai_timer", 0, 0, 1, "", timer_flag.Enabled + timer_flag.Replace, "tongmai.timer")
			AddTimer("tongmai_timer1", 0, 0, 300, "", timer_flag.Enabled + timer_flag.Replace + timer_flag.OneShot, "tongmai.timer1")
			Execute("/alias.start"..workflow.nowjob.."()")
		end
		if findstring(l,"你忙着呢，你等会儿在问话吧。") then
			alias.resetidle()
			_f=function() run("ask "..dummy.id.." about tongmai") end
			wait.time(2);_f()
		end
		if findstring(l,"你感到一股劲力直侵你身上要穴，隐隐生疼。","你突然觉得身体一轻，各路要穴似乎都被打通，不再疼痛。","五指轻抚下，只见你不住口吐鲜血，但是气色却比方才好了许多。") then
			alias.resetidle()
		end
		if findstring(l,"数码世界，数字地图，950就是这里！") then
			alias.resetidle()
			run("ask "..dummy.id.." about tongmai")
		end
	end)
end
------------------------------------------------------------------------------------
-- qudu
------------------------------------------------------------------------------------
function yinyun.dosomething1(n,l,w)
	if findstring(l,"你目前还没有任何为 busyover=yinyun 的变量设定。") then
		run("hp;yun yinyun")
	end
	if findstring(l,"你并未中毒") then
		closeclass("yinyun")
		stat.havedu=0
		Execute("/alias.start"..workflow.nowjob.."()")
	end
	if findstring(l,"你将内力循环一周，身子如灌甘露，丹田里的真气似香烟缭绕","你无法在战斗中运功疗毒") then
		alias.checkbusy("yinyun")
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function common.update()
	_tb={
		"你目前还没有任何为 busyover=yinyun 的变量设定。",
		"你并未中毒",
		"你将内力循环一周，身子如灌甘露，丹田里的真气似香烟缭绕",
		"你无法在战斗中运功疗毒",
	}
	local  yinyun_triggerlist={
	       {name="yinyun_dosth1",regexp=linktri(_tb),script=function(n,l,w)    yinyun.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(yinyun_triggerlist) do
		addtri(v.name,v.regexp,"yinyun",v.script,v.line)
	end
	closeclass("yinyun")
	
	_tb={
		dummy.name.."在你的耳边悄声说道：没有内力治疗！",
		dummy.name.."在你的耳边悄声说道：你的一阳指已治愈！",
		dummy.name.."在你的耳边悄声说道：小样！我不是这么随便的人～～",
		"你忙着呢，你等会儿在问话吧。",
		"你感到一股劲力直侵你身上要穴，隐隐生疼。",
		"你突然觉得身体一轻，各路要穴似乎都被打通，不再疼痛。",
		"数码世界，数字地图，950就是这里！",
		"在"..dummy.name.."五指轻抚下，只见你不住口吐鲜血，但是气色却比方才好了许多。",
		"这里没有 "..dummy.id.." 这个人。",
	}
	local  tongmai_triggerlist={
	       {name="tongmai_dosth1",regexp=linktri(_tb),script=function(n,l,w)    tongmai.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(tongmai_triggerlist) do
		addtri(v.name,v.regexp,"tongmai",v.script,v.line)
	end
	closeclass("tongmai")
	
	_tb={
		"你的眼前一黑，接著什么也不知道了....",
		"日月神教使者倒在地上，手脚几下抽动便死了！",
		"日月神教使者突然卖一破绽，跳出战圈，逃了！",
		"日月神教使者悻然说道：算你够狠！老子先不奉陪了！咱们走着瞧！",
		"你目前还没有任何为 killover=yes 的变量设定。",
	}
	local  shizhe_triggerlist={
	       {name="shizhe_dosth1",regexp=linktri(_tb),script=function(n,l,w)    shizhe.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(shizhe_triggerlist) do
		addtri(v.name,v.regexp,"shizhe",v.script,v.line)
	end
	closeclass("shizhe")
	
	_tb={
		"欢迎下次再来！",
		"开始退出游戏，进行中……",
	}
	local  quit_triggerlist={
	       {name="quit_dosth1",regexp=linktri(_tb),script=function(n,l,w)    quit.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(quit_triggerlist) do
		addtri(v.name,v.regexp,"quit",v.script,v.line)
	end
	AddTimer("quit_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "quit.timer")
	SetTimerOption("quit_timer", "group", "quit")
	closeclass("quit")
	
	_tb={
		"开始退出游戏，进行中……",
	}
	local  quitdis_triggerlist={
	       {name="quitdis_dosth1",regexp=linktri(_tb),script=function(n,l,w)    quitdis.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(quitdis_triggerlist) do
		addtri(v.name,v.regexp,"quitdis",v.script,v.line)
	end
	closeclass("quitdis")
	
	_tb={
		"你目前还没有任何为 busyover=qudu 的变量设定。",
		"你并未中毒",
		"你头下脚上，倒运气息，气血逆行，想让.+从进入身子之处回出。",
		"你无法在战斗中运功疗毒",
	}
	local  qudu_triggerlist={
	       {name="qudu_dosth1",regexp=linktri(_tb),script=function(n,l,w)    qudu.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(qudu_triggerlist) do
		addtri(v.name,v.regexp,"qudu",v.script,v.line)
	end
	closeclass("qudu")
	
	_tb={
		dummy.name.."沉思了一会说道：阁下所中的.+已并无异样....",
		dummy.name.."沉思了一会说道：阁下所中的.+已并无异样，实在无从治起。",
		dummy.name.."沉思了一会说道：阁下所中的.+已深入心脉，请容在下为您医治。",
		dummy.name.."说道：先看看你的脉象吧。",
		dummy.name.."在你的耳边悄声说道：你没有中毒！",
		dummy.name.."在你的耳边悄声说道：去武馆睡房吧！",
		dummy.name.."在你的耳边悄声说道：小样！我不是这么随便的人～～",
		"慢慢地一阵眩晕感传来，你终于又有了知觉....",
		"你从唐楠那里买下了一棵首乌精。",
		"你从何红药那里买下了一棵首乌精。",
		"你口念咒语『神马都是浮云,虾米都是尘土』，『当铺』立马到达！",
		"你口念咒语『神马都是浮云,虾米都是尘土』，『武馆休息室』立马到达！",
		"你口念咒语『神马都是浮云,虾米都是尘土』，『武庙』立马到达！",
		"有一天，你踩着七色云彩来迎娶『何红药』",
		"你目前还没有任何为 busyover=liaoshang 的变量设定。",
		"你目前还没有任何为 dealwithitems=over 的变量设定。",
		"你身不由几的微微一跳，只觉的一股热气从顶门直透下来。",
		"你突然觉得一股暖流自顶而入，口中吐出几口黑血，眼前一黑就什么也看不见了！",
		"你想买的东西我这里没有。",
		"你一觉醒来，只觉精力充沛。该活动一下了。",
		"穷光蛋，一边呆着去！",
		"说着"..dummy.name.."便提起你的手把了一会脉。",
		"这里没有 "..dummy.id.." 这个人。",
	}
	local  liaoshang_triggerlist={
	       {name="liaoshang_dosth1",regexp=linktri(_tb),script=function(n,l,w)    liaoshang.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(liaoshang_triggerlist) do
		addtri(v.name,v.regexp,"liaoshang",v.script,v.line)
	end
	closeclass("liaoshang")
	
	_tb={
		"(.+)倒在地上，挣扎了几下就死了。",
		"你的眼前一黑，接著什么也不知道了....",
		"你目前还没有任何为 killover=yes 的变量设定。",
	}
	local  fang_triggerlist={
	       {name="fang_dosth1",regexp=linktri(_tb),script=function(n,l,w)    fang.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(fang_triggerlist) do
		addtri(v.name,v.regexp,"fang",v.script,v.line)
	end
	closeclass("fang")
	
	local  dazuo_triggerlist={
	       {name="dazuo_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    dazuo.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dazuo_triggerlist) do
		addtri(v.name,v.regexp,"dazuo",v.script,v.line)
	end
	closeclass("dazuo")
	
	_tb={
		".+说“到啦，上岸吧”，随即把一块踏脚板搭上堤岸。",
		"练内功要有间隙，太劳累会走火入魔的。",
		"你的内力不够，无法施展一苇渡江绝技！",
		"你刚刚压制住身上伤势，还是不要妄动真气。",
		"你猛吸几口大气，站了起来。",
		"你目前还没有任何为 dazuo=over 的变量设定。",
		"你目前还没有任何为 lian=over 的变量设定。",
		"松花江化冻了，你喊\\(yell\\)条船过江吧。",
		"船夫扳桨划船，在湖中行了数里，缓缓停泊在岸边，将一块踏脚板搭上了堤岸。",
		"接著你一跃而起，脚尖在苇枝上一点，两袖飘飘，箭一般地在水面上穿了过去。",
		"你目前还没有任何为 boat=enter 的变量设定。",
		"你目前还没有任何为 boat=out 的变量设定。",
		"你目前还没有任何为 checkmove=yes 的变量设定。",
		"你目前还没有任何为 checkyell=yes 的变量设定。",
		"你目前还没有任何为 checkyunbusy=yes 的变量设定。",
		"你鼓足中气，长啸一声：“船家！”",
		"你见江面结冻，便壮起胆子踩冰而过。",
		"你使出吃奶的力气喊了一声：“船家”",
		"你吸了口气，一声“船家”，声音中正平和地远远传了出去。",
		"一叶扁舟缓缓地驶了过来",
		"你的动作还没有完成，不能移动。",
	}
	local  boat_triggerlist={
	       {name="boat_dosth1",regexp=linktri(_tb),script=function(n,l,w)    boat.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(boat_triggerlist) do
		addtri(v.name,v.regexp,"boat",v.script,v.line)
	end
	closeclass("boat")
	
	_tb={
		"湖面上的船家来来往往，一无反应……",
		"可是这时侯夜色已深，湖面上的船家大都歇息了，祗有西边的湖岸还有扁舟往返。",
		"只听得(.+)面上隐隐传来：“别急嘛，这儿正忙着呐……”",
		"岸边一只渡船上的(老艄公|船夫)说道：正等着你呢，上来吧。",
		"(一条渔船应声慢慢|一叶扁舟缓缓地)驶了过来",
	}
	local  boat_yell_triggerlist={
	       {name="boat_yell_dosth1",regexp=linktri(_tb),script=function(n,l,w)    boat_yell.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(boat_yell_triggerlist) do
		addtri(v.name,v.regexp,"boat_yell",v.script,v.line)
	end
	closeclass("boat_yell")
	
	_tb={
		"你目前还没有任何为 busyover=cure 的变量设定。",
		"你所学的内功中没有这种功能。",
		"你现在不须要疗精！",
		"你在身上划一道伤口，挤出一些淤血，气沉丹田，开始凝神疗精。",
	}
	local  cure_triggerlist={
	       {name="cure_dosth1",regexp=linktri(_tb),script=function(n,l,w)    cure.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(cure_triggerlist) do
		addtri(v.name,v.regexp,"cure",v.script,v.line)
	end
	closeclass("cure")
	
	_tb={
		"你目前还没有任何为 busyover=bidu 的变量设定。",
		"你闭目而坐，急呼缓吸，过了一顿饭工夫，脸色略复红润。",
		"你并未中毒",
		"你无法在战斗中运功疗毒",
	}
	local  bidu_triggerlist={
	       {name="bidu_dosth1",regexp=linktri(_tb),script=function(n,l,w)    bidu.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(bidu_triggerlist) do
		addtri(v.name,v.regexp,"bidu",v.script,v.line)
	end
	closeclass("bidu")
	
	_tb={
		"药炉下正燃着火。",
		"你深吸一口气，停了下来。",
		"炭火渐渐明亮，看来可以开始了。",
		".+将炭火熄灭。",
		"你熬这么多药干吗？",
		"你开炉一看，炉中之物象一团浆糊一样，看来没什么用。",
		"你取出药材一看，已经烧成一团焦炭。",
		"哟，抱歉啊，我这儿正忙着呢……您请稍候。",
		"这里没有 wang tongzhi 这个人。",
		"你打开了自己的谣言频道。",
		"你目前还没有任何为 busyover=false 的变量设定。",
		"你目前还没有任何为 busyover=miehuo 的变量设定。",
		"你目前还没有任何为 busyover=quyao 的变量设定。",
		"你目前还没有任何为 checkfire=yes 的变量设定。",
		"你向王通治打听有关「你妈可好？」的消息。",
		"数码世界，数字地图，[6|2057]就是这里！",
		"有一天，你踩着七色云彩来迎娶『王通治』",
		"你从药炉中取出一.{2}(.+)",
		"你从王通治那里买下了一.{2}(.+)。",
	}
	local  aoyao_triggerlist={
	       {name="aoyao_dosth1",regexp=linktri(_tb),script=function(n,l,w)    aoyao.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(aoyao_triggerlist) do
		addtri(v.name,v.regexp,"aoyao",v.script,v.line)
	end
	closeclass("aoyao")
	
	_tb={
		--"但是很显然的，郝大通现在的状况没有办法给你任何答覆。",
		--"但是很显然的，谭处端现在的状况没有办法给你任何答覆。",
		--"郝大通对你说道：这里是广宁殿，其它的老头子不便多说。",
		--"看起来郝大通并不想跟你较量。",
		--"看起来谭处端并不想跟你较量。",
		--"谭处端对你说道：这里是藏经阁二楼，其它的老头子不便多说。",
		--"有一天，你踩着七色云彩来迎娶『郝大通』",
		--"有一天，你踩着七色云彩来迎娶『谭处端』",
		--"这里没有 hao datong 这个人。",
		--"这里没有 tan chuduan 这个人。",
		--"你目前还没有任何为 sanhua=over 的变量设定。",
		"你目前还没有任何为 check=jifa 的变量设定。",
		"您目前的权限是：",
		"请您输入密码",
		"数码世界，数字地图，1282就是这里！",
		".+重新连线完毕。",
		".+对不起，由於连接过於频繁，你的地址被暂时封锁。",
	}
	local  login_triggerlist={
	       {name="login_dosth1",regexp=linktri(_tb),script=function(n,l,w)    login.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(login_triggerlist) do
		addtri(v.name,v.regexp,"login",v.script,v.line)
	end
	closeclass("login")
end

common.update()
