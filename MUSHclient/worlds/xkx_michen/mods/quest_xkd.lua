---------------------------------------------------------------------------
-- File name   : quest_xkd.lua
-- Description : 侠客岛新手机器人，练到经验9.7K，内力>970
-- Author: Michen (xmichen@gmail.com)
-- Version:	2014.04.25
---------------------------------------------------------------------------
--/Hyperlink("hi","test\n","test2","blue","green",0)

print("quest:XKD Loading ok!")
qxkd={}

qxkd["ok"]=nil
qxkd["fail"]=nil

qxkd.fishing_ok=false
qxkd.lowneili=false
qxkd.lowjing=false
qxkd.noforce=false
qxkd.noexp=false
qxkd.nopot=false
qxkd.xuexue=1
qxkd.learncmd=nil
qxkd.needdazuo=false
qxkd.addneili=false

-- 开始任务
qxkd.start=function()
	SetVariable ("autologin","qxkd.start()")
	qxkd.fishing_ok=false
	qxkd.lowneili=false
	qxkd.lowjing=false
	qxkd.noforce=false
	qxkd.noexp=false
	qxkd.nopot=false
	qxkd.xuexue=1
	qxkd.learncmd=nil
	qxkd.needdazuo=false
	qxkd.addneili=false

	quest.stop=false
	qxkd.update()
	trigrpon("q_xkd")
	run("unset wimpy;set brief 1;tune rumor;tune chat;tune xkx;set brief 1;score;cha;jifa;hp;look")
	busytest(qxkd.checkwhere)
end

-- 结束任务
qxkd.allstop=function()
	SetVariable ("autologin","")
	quest.stop=true
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
	rigrpoff("q_xkd")
	inittri()
end

-- 检查当前位置，决定开始做什么，把在当前位置需要初始化做的事情放在这里面
-- 具体执行的东西在另外的函数里
-- 这里一般是重新连线进来的时候做的
qxkd.checkwhere=function()
	if roominfo["name"]=="望海亭" then
		-- 开始钓鱼
		run("get all;s;drop all;n;hp;move stone")
		busytest(qxkd.do_fishing)
		return
	elseif roominfo["name"]=="石室" then
		-- 开始读墙
		busytest(qxkd.do_studywall)
		return
	elseif roominfo["name"]=="沙滩" then
		run("n;n;n;n")
		run("get all;s;drop all;n;hp;move stone")
		busytest(qxkd.do_fishing)
		return
	elseif roominfo["name"]=="书房" then
		qxkd.xuexue=1
		qxkd.learncmd="xue shi literate 10"
		busytest(qxkd.do_learn)
		return
	elseif roominfo["name"]=="山顶" then
		qxkd.xuexue=2
		qxkd.learncmd="xue huangyi force 10"
		busytest(qxkd.do_learn)
		return
	elseif roominfo["name"]=="瀑布" then
		qxkd.xuexue=6
		qxkd.learncmd="xue dizi strike 10"
		busytest(qxkd.do_learn)
		return
	elseif roominfo["name"]=="休息室" then
		qxkd.xuexue=1
		qxkd.learncmd="xue shi literate 10"
		run("e;e")
		busytest(qxkd.do_learn)
	elseif roominfo["name"]=="甬道" then
		gethp(qxkd.checkdazuo)
	end
end

-- 正式的钓鱼函数
qxkd.do_fishing=function()
	run("fishing")
	if me.hp["exp"]>9700 then
		-- 经验够了，转去打坐:::::::::::::::::::::::::::::可能不在这里处理，效率会更高一点点
		qxkd.needdazuo=true
		run("halt;halt;nu;drop cloth;drop rain coat;drop rain coat;climb tree;wear all;jump fall;n;w;sleep")
		return
	elseif qxkd.fishing_ok then
		-- 钓到鱼了，去学习
		qxkd.fishing_ok=false
		run("halt;drop si yu;drop si yu;drop si yu;s;give hong dianwa to da han;give hong dianwa to da han;give hong dianwa to da han;s;s;give qili fuzi to yan bai;give qili fuzi to yan bai;give qili fuzi to yan bai;n;n;n;nu;drop cloth;drop rain coat;drop rain coat;climb tree;wear all;jump fall;s;e;drink;drink;drink;w;n;e;n;ask si pu about 腊八粥;get zhou;eat zhou;drop zhou;drop zhou;drop zhou;ask si pu about 岛主;enter;n;open door;enter;n")
		busytest(qxkd.do_studywall)
		return
	else
		-- 没钓到鱼，继续
		busytest(qxkd.do_fishing)
		return
	end
end

-- 正式的读墙函数
-- 没精神时yun regenerate
-- 第一次学到内功的时候要激发下
-- 没内力去，回去睡觉再来读
-- 实战经验不够了，去睡觉，然后去学师傅
-- 潜能不够了，去睡觉，然后去钓鱼
qxkd.do_studywall=function()
	run("study wall")
	if qxkd.noforce then		-- 没有激发内功
		qxkd.noforce=false
		run("jifa force taixuan-gong;yun regenerate")
		busytest(qxkd.do_studywall)
		return
	elseif qxkd.lowjing then	-- 精神不够
		qxkd.lowjing=false
		run("yun regenerate")
		busytest(qxkd.do_studywall)
		return
	elseif qxkd.lowneili then	-- 没内力了
		--qxkd.lowneili=false 这个可以用到睡醒后的判断
		run("s;open door;out;s;out;s;w;n;w;cha;sleep")
		return
	elseif qxkd.noexp then		-- 经验不够
		run("s;open door;out;s;out;s;w;n;w;cha;hp;sleep")
		return
	elseif qxkd.nopot then		-- 没潜能了
		run("s;open door;out;s;out;s;w;n;w;hp;sleep")
		return
	else
		busytest(qxkd.do_studywall)
		return
	end
end

-- 判断要学什么，并且返回到相应地点的路径
qxkd.golearn=function()
	local path=nil
	if qxkd.xuexue==1 then
		path="e;e"
		qxkd.learncmd="xue shi literate 10"
	elseif qxkd.xuexue==2 then
		path="e;s;out;sd;s;eu;eu"
		qxkd.learncmd="xue huangyi force 10"
	elseif qxkd.xuexue==3 then
		path="e;s;out;sd;s;eu;eu"
		qxkd.learncmd="xue huangyi dodge 10"
	elseif qxkd.xuexue==4 then
		path="e;s;out;sd;s;eu;eu"
		qxkd.learncmd="xue huangyi parry 10"
	elseif qxkd.xuexue==5 then
		path="e;s;out;sd;s;eu;eu"
		qxkd.learncmd="xue huangyi sword 10"
	elseif qxkd.xuexue==6 then
		path="e;s;out"
		qxkd.learncmd="xue dizi strike 10"
	else	-- 回去钓鱼
		path="e;s;out;sd;move stone;hp"
		qxkd.learncmd=nil
	end
	return path
end

-- 判断要学什么，并且返回到相应地点的路径  这个是已经在学了
qxkd.golearn2=function()
	qxkd.xuexue=qxkd.xuexue+1
	local path=nil
	if qxkd.xuexue==2 then
		path="w;s;out;sd;s;eu;eu"
		qxkd.learncmd="xue huangyi force 10"
	elseif qxkd.xuexue==3 then
		path="hi huangyi"
		qxkd.learncmd="xue huangyi dodge 10"
	elseif qxkd.xuexue==4 then
		path="hi huangyi"
		qxkd.learncmd="xue huangyi parry 10"
	elseif qxkd.xuexue==5 then
		path="hi huangyi"
		qxkd.learncmd="xue huangyi sword 10"
	elseif qxkd.xuexue==6 then
		path="wd;wd;n;nu"
		qxkd.learncmd="xue dizi strike 10"
	else	-- 回去钓鱼
		path="sd;move stone;hp"
		qxkd.learncmd=nil
	end
	if qxkd.xuexue>=7 then
		qxkd.xuexue=1
	end
	return path
end

-- 正式的学习函数
qxkd.do_learn=function()
	local learnfail_tri={
		"^(> |)(黄衣弟子|蓝衣弟子|老学士)现在正忙着呢。$",
		"^(> |)(黄衣弟子|蓝衣弟子|老学士)看起来太累了，没办法教你什么。$",
		"^(> |)你现在精神不佳，无法定下心来思考！$",
		"^(> |)这项技能你的程度已经不输你师父了。$",
		"^(> |)你的实战经验还不足，不能继续学习这项技能！$",
		"^(> |)你的潜能不够，没有办法再成长了。$",
		"^(> |)你开始向.+请教有关.+的疑问。$",
	}
	local l_tri=linktri(learnfail_tri)
	run(qxkd.learncmd)
	wait.make(function()
		local l,w=wait.regexp(l_tri,5)
		if l==nil then
			Note("学习遇到未知错误，尝试重新开始机器人。")
			busytest(qxkd.start)
			return
		end
		if string.find(l,"现在正忙着呢。")  or string.find(l,"看起来太累了，没办法教你什么。") or string.find(l,"你现在精神不佳，无法定下心来思考！") then
			busytest(qxkd.do_learn)
			return
		end
		if string.find(l,"你开始向") then
			run("dance")
			return
		end
		if string.find(l,"这项技能你的程度已经不输你师父了。") or string.find(l,"你的实战经验还不足，不能继续学习这项技能！") then
			local golearn=qxkd.golearn2()
			run(golearn)
			if qxkd.learncmd==nil then
				busytest(qxkd.do_fishing)
			else
				busytest(qxkd.do_learn)
			end
			return
		end
		if string.find(l,"你的潜能不够，没有办法再成长了。") then
			run("halt")
			if qxkd.xuexue==1 then
				run("w;s;out;sd")
			else
				run("wd;wd;n;sd")
			end
			run("move stone;hp")
			busytest(qxkd.do_fishing)
			return
		end
	end)
end

-- 打坐模块
qxkd.checkdazuo=function()
	if me.hp["neilimax"]>970 then
		run("halt;quit")
		Disconnect()
		return
	end
	
	if qxkd.addneili then				-- 内力增加了！
		qxkd.addneili=false
		run("halt;s;e;n;ask si pu about 腊八粥;get zhou;eat zhou;drop zhou;drop zhou;drop zhou;s;w;s;e;drink;drink;drink;drink;drink;w;n;n;w;sleep")
		return
	end
	
	local qq=me.hp["neilimax"]*2-me.hp["neili"]
	if me.hp["qi"]>20 then
		if me.hp["qi"]>qq then
			run("dazuo "..qq)
		elseif me.hp["qi"]>10 then
			run("dazuo 10")
		else
			DoAfterSpecial(9, 'gethp(qxkd.checkdazuo)', 12)
		end
	else
			DoAfterSpecial(9, 'gethp(qxkd.checkdazuo)', 12)
	end
end

-- 下面是触发器相关处理函数
qxkd.is_studywall_wakeup=function(n,l,w)
	if qxkd.lowneili then			-- 没内力的处理
		qxkd.lowneili=false
		run("e;s;e;n;ask si pu about 岛主;enter;n;open door;enter;n")
		busytest(qxkd.do_studywall)
		return
	elseif qxkd.noexp then		-- 经验不够的处理
		qxkd.noexp=false
		local golearn=qxkd.golearn()
		run(golearn)
		if qxkd.learncmd==nil then
			busytest(qxkd.do_fishing)
		else
			busytest(qxkd.do_learn)
		end
		return
	elseif qxkd.nopot then		-- 没潜能的处理
		qxkd.nopot=false
		run("e;s;out;sd;move stone;hp")
		busytest(qxkd.do_fishing)
		return
	elseif qxkd.needdazuo then		-- 打坐中
		run("e")
		gethp(qxkd.checkdazuo)
		return
	else
		run("e;s;out;sd;move stone;hp")
		busytest(qxkd.do_fishing)
		return
	end
end

qxkd.is_fishing_done=function(n,l,w)
	qxkd.fishing_ok=true		-- qxkd.do_fishing 里重置
end
qxkd.is_studywall_lowneili=function(n,l,w)
	qxkd.lowneili=true			-- qxkd.is_studywall_wakeup 里重置
end
qxkd.is_studywall_lowjing=function(n,l,w)
	qxkd.lowjing=true			-- qxkd.do_studywall 里重置
end
qxkd.is_studywall_noforce=function(n,l,w)
	qxkd.noforce=true			-- qxkd.do_studywall 里重置
end
qxkd.is_studywall_noexp=function(n,l,w)
	qxkd.noexp=true				-- qxkd.is_studywall_wakeup 里重置
end
qxkd.is_studywall_nopot=function(n,l,w)
	qxkd.nopot=true				-- qxkd.is_studywall_wakeup 里重置
end

qxkd.is_studywall_dazuoover=function(n,l,w)
	gethp(qxkd.checkdazuo)
end
qxkd.is_studywall_addneili=function(n,l,w)
	qxkd.addneili=true			-- qxkd.checkdazuo 里重置
end
qxkd.is_studywall_faintover=function(n,l,w)
	DoAfter(9, "yun refresh;w;sleep")
end
qxkd.is_studywall_lowjingdz=function(n,l,w)
	DoAfterSpecial(9, 'gethp(qxkd.checkdazuo)', 12)
end
qxkd.is_studywall_begod=function(n,l,w)
	run("dazuo 10")
end

qxkd.is_studywall_learnover=function(n,l,w)
	run("halt")
	if w[2]=="蓝衣弟子" then
		run("drop cloth;drop rain coat;drop rain coat;climb tree;wear rain coat;jump fall;n")
	end
	if w[2]=="黄衣弟子" then
		run("wd;wd;n;nu;drop cloth;drop rain coat;drop rain coat;climb tree;wear rain coat;jump fall;n")
	end
	if w[2]=="老学士" then
		run("w")
	end
	qxkd.noexp=true
	run("w;cha;sleep")
end

qxkd.update=function()
	addtri("is_fishing_done","^(> |)你看着手中的鱼儿，满意地站了起来$","q_xkd","qxkd.is_fishing_done")
	addtri("is_studywall_lowneili","^(> |)你的内力不够。$","q_xkd","qxkd.is_studywall_lowneili")
	addtri("is_studywall_lowjing","^(> |)你的精神不好，先休息一会吧！$","q_xkd","qxkd.is_studywall_lowjing")
	addtri("is_studywall_noforce","^(> |)你请先用 enable 指令选择你要使用的内功。$","q_xkd","qxkd.is_studywall_noforce")
	addtri("is_studywall_noexp","^(> |)你的实战经验不够。$","q_xkd","qxkd.is_studywall_noexp")
	addtri("is_studywall_nopot","^(> |)你的潜能不够。$","q_xkd","qxkd.is_studywall_nopot")
	addtri("is_studywall_wakeup","^(> |)你一觉醒来，只觉精力充沛。该活动一下了。$","q_xkd","qxkd.is_studywall_wakeup")
	addtri("is_studywall_learnover","^(> |)(黄衣弟子|蓝衣弟子|老学士)教导完毕，见你若有所悟，会心地点了点头。$","q_xkd","qxkd.is_studywall_learnover")
	
	addtri("is_studywall_dazuoover","^(> |)你运功完毕，深深吸了口气，站了起来。$","q_xkd","qxkd.is_studywall_dazuoover")
	addtri("is_studywall_addneili","^(> |)你的内力增加了","q_xkd","qxkd.is_studywall_addneili")
	addtri("is_studywall_faintover","^(> |)慢慢地你终于又有了知觉...","q_xkd","qxkd.is_studywall_faintover")
	addtri("is_studywall_lowjingdz","^(> |)你现在精不够，无法控制内息","q_xkd","qxkd.is_studywall_lowjingdz")
	addtri("is_studywall_begod","^(> |)没有达到那个境界$","q_xkd","qxkd.is_studywall_begod")
end

AddAlias("alias_qxkd_start","#xkdstart","",alias_flag.Enabled + alias_flag.Replace,"qxkd.start")
AddAlias("alias_qxkd_stop","#xkdstop","",alias_flag.Enabled + alias_flag.Replace,"qxkd.allstop")

SetAliasOption("alias_qxkd_start","group","job_xkd")
SetAliasOption("alias_qxkd_stop","group","job_xkd")

--[[
#CLASS {dazuo}
#TRIGGER {^???你运功完毕，深深吸了口气，站了起来。} {hp} "" {color}
#TRIGGER {^???你的内力增加了} {#t- dazuo;#wa 2000;halt;#wa 2000;halt;#wa 3000;halt;h;s;e;n;ask si pu about 腊八粥;eat zhou;drop zhou;s;w;s;e;#5 drink;w;n;n;w;#t+ dazuo;sleep} "" {color}
#TRIGGER {慢慢地你终于又有了知觉...} {#wa 9000;yun refresh;w;sleep}
#TRIGGER {^???你现在精不够，无法控制内息} {#wa 9000;hp} "" {color}
#TRIGGER {没有达到那个境界} {dazuo 10}
#TRIGGER {^???你一觉醒来，只觉精力充沛。该活动一下了} {e;hp} "" {color}
#TRIGGER {^???气血：%s(%d)/%s%d%s~(*~%~)%s内力：%s(%d)%s/%s(%d)} {q=%1;nl=%2;maxnl=%3;#math qq (@maxnl*2-@nl);#if @maxnl>950 {halt;quit;#di} {#if @q>20 {#if (@qq>(@q-10)) {dazuo 10} {dazuo @qq}} {#wa 9000;hp}}}
#CLASS 0

#CLASS {wenti}
#TRIGGER {^???你一觉醒来，只觉精力充沛。该活动一下了} {#t- wenti;#t+ xue;#wa 1000;e;s;e;n;ask si pu about 岛主;enter;n;open door;enter;n;#wa 1000;study wall}
#CLASS {xue} {enable}
#TRIGGER {^???突然你觉得墙壁上的小字如蝌蚪般活动了起来，体内真气随着蝌蚪流转了起来。} {study wall}
#TRIGGER {^???你发现壁上笔划均有贯串之意，} {study wall}
#TRIGGER {^???看着墙上的蝌蚪文，你发现体中真气不知为何蠢蠢欲动。} {study wall}
#TRIGGER {^???你的实战经验不够。} {#wa 1000;s;open door;out;s;out;s;w;n;w;save;cha;hp;sleep}
#TRIGGER {^???你的精神不好，先休息一会吧！} {halt;yun regenerate}
#TRIGGER {^???你的内力不够。} {#t- xue;#t+ wenti;s;open door;out;s;out;s;w;n;w;save;cha;#wa 5000;sleep}
#TRIGGER {^???蓝衣弟子教导完毕，见你若有所悟，会心地点了点头。} {halt;drop cloth;drop rain coat;drop rain coat;climb tree;wear rain coat;jump fall;n;w;save;cha;sleep}
#TRIGGER {^???黄衣弟子教导完毕，见你若有所悟，会心地点了点头。} {halt;wd;wd;n;nu;drop cloth;drop rain coat;drop rain coat;climb tree;wear rain coat;jump fall;n;w;save;cha;sleep}
#TRIGGER {^???老学士教导完毕，见你若有所悟，会心地点了点头。} {halt;w;w;save;cha;sleep}
#TRIGGER {^???你深深吸了几口气，精神看起来好多了。} {study wall}
#TRIGGER {^???你的潜能不够。} {halt;#wa 1000;s;open door;out;s;out;s;w;n;w;#t- xue;#t- wenti;#t+ fishing;save;hp;sleep}
#TRIGGER {^???你一觉醒来，只觉精力充沛。该活动一下了。} {xuebusy=0;#if @xuexue=1 {e;e;alias xx xue shi literate 10;xx};#if @xuexue=2 {e;s;out;sd;s;eu;eu;alias xx xue huangyi force 10;xx};#if @xuexue=3 {e;s;out;sd;s;eu;eu;alias xx xue huangyi dodge 10;xx};#if @xuexue=4 {e;s;out;sd;s;eu;eu;alias xx xue huangyi parry 10;xx};#if @xuexue=5 {e;s;out;sd;s;eu;eu;alias xx xue huangyi sword 10;xx};#if @xuexue=6 {e;s;out;alias xx xue dizi strike 10;xx};#if @xuexue=7 {e;s;out;sd;#t- xue;#t+ fishing;fishing;s;n;fishing;hp}}
#TRIGGER {^???{黄衣弟子|蓝衣弟子|老学士}现在正忙着呢。} {#wa 500;xx}
#TRIGGER {^???你的潜能不够，没有办法再成长了。} {halt;#if @xuexue=1 {w;s;out;sd;#t- xue;#t+ fishing;move stone;fishing;s;n;fishing;hp} {wd;wd;n;sd;#t- xue;#t+ fishing;move stone;fishing;s;n;fishing;hp}}
#TRIGGER {^???你的实战经验还不足，不能继续学习这项技能！} {#if @xuebusy=0 {xuebusy=1;#if @xuexue=2 {alias xx xue huangyi dodge 30;xx};#if @xuexue=3 {alias xx xue huangyi parry 30;xx};#if @xuexue=4 {alias xx xue huangyi sword 30;xx}} {xuebusy=0;#if @xuexue=2 {alias xx xue huangyi parry 30;xx};#if @xuexue=3 {alias xx xue huangyi sword 30;xx}}}
#TRIGGER {^???{黄衣弟子|蓝衣弟子|老学士}看起来太累了，没办法教你什么。} {#wa 500;xx}
#TRIGGER {^???你现在精神不佳，无法定下心来思考！} {halt;#wa 1000;xx}
#TRIGGER {^???这项技能你的程度已经不输你师父了。} {halt;#add xuexue 1;#wa 3000;#if @xuexue=2 {w;s;out;sd;s;eu;eu;alias xx xue huangyi force 30;xx};#if @xuexue=3 {alias xx xue huangyi dodge 30;xx};#if @xuexue=4 {alias xx xue huangyi parry 30;xx};#if @xuexue=5 {alias xx xue huangyi sword 30;xx};#if @xuexue=6 {wd;wd;n;nu;alias xx xue dizi strike 30;xx};#if @xuexue=7 {sd;#t- xue;#t+ fishing;fishing;s;n;fishing;hp}}
#TRIGGER {^???你请先用*指令选择你要使用的内功。} {jifa force taixuan-gong;yun regenerate}
--]]

--[[
#TRIGGER {^???你看着手中的鱼儿，满意地站了起来} {#wa 1000;#3 drop si yu;s;#3 give hong dianwa to da han;s;s;#3 give qili fuzi to yan bai;n;n;n;nu;drop cloth;drop rain coat;drop rain coat;climb tree;wear all;jump fall}
#TRIGGER {^???你走近瀑布，纵身跃了进去。} {#t- fishing;#t- wenti;s;e;#3 drink;#wa 3000;halt;w;n;e;n;ask si pu about 腊八粥;#wa 1000;get zhou;#wa 1000;eat zhou;#wa 1000;#3 drop zhou;#wa 1000;ask si pu about 岛主;enter;n;open door;enter;n;#t- fishing;#t+ xue;study wall}
#TRIGGER {^???你无聊地站了起来，喃喃地骂道：今天运气怎麽这麽烂。} {#wa 1000;fishing}
#TRIGGER {^??? 饮水*经验：%s(%d)} {expexp=%1;#if %1>9700 {#t- fishing;#t- xue;#t- wenti;#t+ dazuo;set brief 1;#ti 1 {sing2};#ts 120;halt;halt;nu;drop cloth;drop rain coat;drop rain coat;climb tree;wear all;jump fall;n;w;sleep}}
#TRIGGER {^???你一觉醒来，只觉精力充沛。该活动一下了} {e;s;out;sd;#t- xue;#t+ fishing;move stone;fishing;s;n;fishing;hp} "" {color}
--]]

--[[
望海亭		钓鱼地点

--]]