mp_sl={}
mp_sl_pre={}
mp_sl_start={}
mp_sl_watch={}

fs={
	searchid=5,
	findseng=0,
	searchstep=1,
	searchlist="west|southdown|southdown|southdown|eastdown|southdown|southdown|east",
}
------------------------------------------------------------------------------------
-- mp_sl_pre
------------------------------------------------------------------------------------
function mp_sl_pre.dosomething1(n,l,w)
	local _f,_tb
	wait.make(function()
		if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
			if not isopen("boat") then
				alias.resetidle()
				alias.startworkflow()
			end
		end
		if findstring(l,"你目前还没有任何为 searchseng=yes 的变量设定。") then
			if fs.findseng>0 then
				run("hp")
				closeclass("mp_"..me.menpai.."_pre")
				openclass("mp_"..me.menpai.."_start")
				run("jiali "..mpjiali..";jiajin "..mpjiajin)
				alias.yjl()
				if string.len(mpweapon)>0 then
					if mpweapon=="staff" then alias.wi(staffid) else alias.wi(mpweapon) end
				else alias.uw() end
				_tb=utils.split(mpyun,"|")
				for k,v in ipairs(_tb) do run(v) end
				run("fight seng")
				_tb=utils.split(mppfm,"|")
				for k,v in ipairs(_tb) do run(v.." seng") end
			else
				if fs.searchstep==1 then
					_tb=utils.split(fs.searchlist,"|")
					if fs.searchid>=table.getn(_tb) then fs.searchstep=0 end
					run("go ".._tb[fs.searchid])
					fs.searchid=fs.searchid+fs.searchstep
				elseif fs.searchstep==0 then
					fs.searchstep=-1
					_tb=utils.split(fs.searchlist,"|")
					run("go "..invDirection(_tb[fs.searchid]))
					fs.searchid=fs.searchid+fs.searchstep
				else
					_tb=utils.split(fs.searchlist,"|")
					run("go "..invDirection(_tb[fs.searchid]))
					if fs.searchid==1 then
						fs.searchid=0
						fs.searchstep=1
					end
					fs.searchid=fs.searchid+fs.searchstep
				end
				if cmd.nums<cmd.setnums then run("set searchseng=yes")
				else
					alias.yjl()
					_f=function() run("set searchseng=yes") end
					wait.time(2);_f()
				end
			end
		end
		if findstring(l,"你目前还没有任何为 checkhp=addneili 的变量设定。") then
			if havefj>0 and hp.neili>(hp.maxneili*set_neili_job/100) then alias.tdz() end
		end
		if findstring(l,"这个方向没有出路。") then
			alias.close_mp()
			_f=function() alias.startmp() end
			wait.time(2);_f()
		end
		if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
			alias.flytoid(me.menpaiJobStart)
		end
		if findstring(l,"你目前还没有任何为 checkexpover=mp 的变量设定。") then
			alias.resetidle()
			if add.exp>10 and mpLimited.MarkExp<me.menpaiLimited then mpLimited.MarkExp=tonumber(me.menpaiLimited) end
			alias.checkbusy("fs")
		end
		if findstring(l,"石级旁边的草丛中忽然跃起一个身影，挡住了你！") then
			alias.resetidle()
			fs.findseng=1
		end
		if findstring(l,"数码世界，数字地图，"..tostring(me.menpaiJobStart).."就是这里！") then
			alias.resetidle()
			fs.searchid=1
			fs.findseng=0
			fs.searchstep=1
			alias.dz(set_neili_global)
		end
		if findstring(l,"你目前还没有任何为 busyover=fs 的变量设定。") then
			alias.yjl()
			alias.et()
			alias.uw()
			if hp.neili<(hp.maxneili*set_neili_global/100) then alias.dz(set_neili) else alias.startworkflow() end
		end
	end)
end
------------------------------------------------------------------------------------
-- mp_sl_start
------------------------------------------------------------------------------------
function mp_sl_start.dosomething1(n,l,w)
	local _tb
	if findstring(l,"你目前还没有任何为 checkhp=fs 的变量设定。") then
		alias.resetidle()
		if hp.jingli<(hp.maxjingli*2/3) and hp.neili<500 then run("giveup") end
		if hp.neili<200 then run("giveup") end
		if hp.qi<(hp.maxqi*100/hp.healthqi/2) then run("yun recover") end
		if hp.jingli<(hp.maxjingli/2) then alias.yjl() end
		_tb=utils.split(mppfm,"|")
		for k,v in ipairs(_tb) do run(v.." seng") end
	end
	if findstring(l,"游方僧人倒在地上，挣扎了几下就死了。","游方僧人冷笑道：“少林和尚个个都是贪生怕死之辈！”","游方僧人大笑三声，扬长而去。","游方僧人离开了。") then
		fs.findseng=0
		openclass("mp_"..me.menpai.."_pre")
		closeclass("mp_"..me.menpai.."_start")
		run("hp")
		alias.checkbusy("fs")
	end
	if findstring(l,"游方僧人双手一拱，恭敬地离开了。","这里没有 seng。") then
		fs.findseng=0
		openclass("mp_"..me.menpai.."_pre")
		closeclass("mp_"..me.menpai.."_start")
		alias.checkexp("mp")
	end
	if findstring(l,"你脸色微变，说道：佩服，佩服！","你向后退了几步，说道：这场比试算我输了，佩服，佩服","你向后一纵，躬身做揖说道：阁下武艺不凡，果然高明","游方僧人哈哈大笑，说道：承让了！","游方僧人胜了这招，向后跃开三尺，笑道：承让！","游方僧人双手一拱，笑著说道：承让！","游方僧人已经无法战斗了。","游方僧人.+已戳在了你","游方僧人.+指轻弹，一片排山倒海的暗劲顿时涌出，击在你的.+穴上！","游方僧人指端微伸，劲力无影无踪地发出，你顿时全身酸麻，已被点中了","结果你被他攻了个措手不及，浑身被漫天鞭影裹在其中，动弹不得！") then
		run("giveup")
	end
	if findstring(l,"游方僧人看起来已经力不从心了。","游方僧人摇头晃脑、歪歪斜斜地站都站不稳，眼看就要倒在地上。","游方僧人已经一副头重脚轻的模样，正在勉力支撑著不倒下去。") then
		run("jiajin 50")
	end
	if findstring(l,"你手中无刀，无法再化内力为火光，不得不收回燃木刀法。") then
		alias.wi("dao")
	end
end
function mp_sl_start.timer()
	run("hp;set checkhp=fs")
end
------------------------------------------------------------------------------------
-- mp_sl_watch
------------------------------------------------------------------------------------
function mp_sl_watch.dosomething1(n,l,w)
	if findstring(l,"你实在是太疲劳，该去休息一下了！") then
		mpJobLimited=1
		print("统计到的fs上限为："..tostring(mpLimited.mpexp))
		mpLimited.MarkExp=tonumber(mpLimited.mpexp)
		if mpLimited.MarkTime<(os.time()-3600) then
			-- 到fs时间却仍然busy，推迟2分钟
			mpLimited.MarkTime=tonumber(os.time()-3600+120)
		end
	end
	if findstring(l,"借花献佛只能对战斗中的对手使用。") then
		run("fight seng")
	end
	if findstring(l,"你此时心念空明，悟彻佛家神通，刀锋过处，招数就如一叶一叶的莲花花瓣自手中源源不断地弹出！","你内息运转不断，功力节节提升，出手越来越快，“混元一气功”催在刀上所发出的热浪把游方僧人压得喘不过气来！","你手中.+刀连环不断向前劈出，却都以弧形收回，刀势犹若片片莲花花瓣。") then
		alias.yjl()
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function mp_sl.update()
	local  mp_sl_pre_triggerlist={
	       {name="mp_sl_pre_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_sl_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_sl_pre_triggerlist) do
		addtri(v.name,v.regexp,"mp_sl_pre",v.script,v.line)
	end
	closeclass("mp_sl_pre")
	
	local  mp_sl_start_triggerlist={
	       {name="mp_sl_start_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_sl_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_sl_start_triggerlist) do
		addtri(v.name,v.regexp,"mp_sl_start",v.script,v.line)
	end
	AddTimer("mp_sl_start_timer", 0, 0, 3, "", timer_flag.Enabled + timer_flag.Replace, "mp_sl_start.timer")
	SetTimerOption("mp_sl_start_timer", "group", "mp_sl_start")
	closeclass("mp_sl_start")
	
	local  mp_sl_watch_triggerlist={
	       {name="mp_sl_watch_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_sl_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_sl_watch_triggerlist) do
		addtri(v.name,v.regexp,"mp_sl_watch",v.script,v.line)
	end
	closeclass("mp_sl_watch")
end
mp_sl.update()

