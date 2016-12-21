---------------------------------------------------------------------------
-- File name   : quest_qzwd.lua
-- Description : 千蛛万毒手模块，嘿嘿
--
-- Author: Michen (xmichen@gmail.com)
-- Version:	2014.05
---------------------------------------------------------------------------

print("quest:QZWD Loading ok!")

--[[
抓虫 
打坐
xiulian
晕了之后的处理
丢到丹凤洞要处理

酒泉 1350		ne 1349 山间荒地 1427 
石屋洞 1153 迷宫洞口 山洞深处(灵蛇岛)1763 use fire;enter   甬道(华山 1953
蒙古包(move qi) 1787
武馆休息室 37

%if( (%eval( %eval( %stime( %time( yy-mm-dd hh:nn:ss))-@mark.sTime)/60)/60)>0, %if( (%eval( %eval( %stime( %time( yy-mm-dd hh:nn:ss))-@mark.sTime)/60)/60/24)>0, %eval( %eval( %eval( %eval( %stime( %time( yy-mm-dd hh:nn:ss))-@mark.sTime)/60)/60)/24)天%mod( %eval( %eval( %eval( %stime( %time( yy-mm-dd hh:nn:ss))-@mark.sTime)/60)/60), 24)小时, %eval( %eval( %eval( %stime( %time( yy-mm-dd hh:nn:ss))-@mark.sTime)/60)/60)小时)%mod( %eval( %eval( %stime( %time( yy-mm-dd hh:nn:ss))-@mark.sTime)/60), 60)分钟, %mod( %eval( %eval( %stime( %time( yy-mm-dd hh:nn:ss))-@mark.sTime)/60), 60)分钟)

yin li 1772   e;get fire
--]]
qqzwd={
	have_spider=true,
	sleep_room=37,
	xiulian_room=1350,
	spider_id=0,
}

spider_locate={
	{1324,1325,1349,1427},					--毒蜘蛛
	{1953,1153,1349,1427},					--花蛛
	{1787,1953,1153,1349},					--彩雪蛛
}

function qqzwd.start()
	qqzwd.update()
	trigrpon("q_qzwd")
	run("score;cha;jifa")
	run("get ji from shi he;drink ji;put ji in shi he")
	gethp(qqzwd.check)
end

function qqzwd.check()
	if me.hp["neili"]<(me.hp["neilimax"]*2*0.9) then
		do_dazuo(me.hp["neilimax"]*2*0.9, "neili",qqzwd.check,qqzwd.check)
		return
	end
	busytest(qqzwd.xiulian)
end

function qqzwd.xiulian()
	local msg_tri={
		"这里不能练习。",
		
		"你正忙着呢。",
		"很明显, (.+)现在没法干这个。",
		"你的内力太低。",
		
		"你得找些毒蜘蛛来才能练千蛛万毒手。",
		"(.+)无法用来练千蛛万毒手。",
		
		"你从怀里取出锦盒，打开盒盖，将双手两根食指伸进盒中。",
	}

	local _ftri=linktri(msg_tri)
	run("xiulian")
	wait.make(function()
		local l,w=wait.regexp(_ftri,2)
		if l==nil then
			--wait.time(1)
			qqzwd.xiulian()
			return
		end
		if findstring(l,msg_tri[1]) then
			do_walkgo(1350,qqzwd.start,qqzwd.start)
			return
		end
		if findstring(l,msg_tri[2],msg_tri[3],msg_tri[4]) then
			qqzwd.start()
			return
		end
		if findstring(l,msg_tri[5],msg_tri[6]) then
			run("get all from jin he;drop zhusi;cha")
			busytest(qqzwd.getzhizhu)
			return
		end
	end)
end

function qqzwd.getzhizhu()
	local where=0
	qqzwd.spider_id=qqzwd.spider_id+1
	
	if me.skills["qianzhu-wandu"]["lv"]<80 then
		if qqzwd.spider_id>#spider_locate[1] then qqzwd.spider_id=1;run("yun refresh") end
		where=spider_locate[1][qqzwd.spider_id]
	elseif me.skills["qianzhu-wandu"]["lv"]<150 then
		if qqzwd.spider_id>#spider_locate[2] then qqzwd.spider_id=1;run("yun refresh") end
		where=spider_locate[2][qqzwd.spider_id]
	else
		if qqzwd.spider_id>#spider_locate[3] then qqzwd.spider_id=1;run("yun refresh") end
		where=spider_locate[3][qqzwd.spider_id]
	end
	do_walkgo(where,qqzwd.do_zhua,qqzwd.getzhizhu)
end
function qqzwd.do_zhua()
	if me.skills["qianzhu-wandu"]["lv"]<80 then
		-- 没事干 
	elseif me.skills["qianzhu-wandu"]["lv"]<150 then
		run("zhua hua zhu")
	else
		run("move qi;zhua caixue zhu")
	end
	run("zhua zhizhu")
	qqzwd.sleep_wakeup()
end

function qqzwd.xiulian_over(n,l,w)
	gethp(qqzwd.check)
end
function qqzwd.faint_wakeup(n,l,w)
	-- 如果是GB，就走到练习的地方睡觉
	-- 如果是其它门派，看看就去泉州睡觉好了
	run("yun refresh")
	if me.menpai=="gb" then qqzwd.sleep_room=qqzwd.xiulian_room else qqzwd.sleep_room=37 end
	do_walkgo(qqzwd.sleep_room,qqzwd.do_sleep,qqzwd.faint_wakeup)
end
function qqzwd.do_sleep()
	run("sleep")
end
function qqzwd.sleep_wakeup(n,l,w)
	do_walkgo(qqzwd.xiulian_room,qqzwd.start,qqzwd.sleep_wakeup)
end

function qqzwd.update()
	addtri("qqzwd_faint_wakeup","^(> > |> |)慢慢地一阵眩晕感传来，你终于又有了知觉....","q_qzwd","qqzwd.faint_wakeup")
	addtri("qqzwd_xiulian_over","^(> > |> |)你运功完毕， 长长的吐了口气。","q_qzwd","qqzwd.xiulian_over")
	addtri("qqzwd_sleep_wakeup","^(> > |> |)你一觉醒来，只觉精力充沛。该活动一下了。","q_qzwd","qqzwd.sleep_wakeup")
end

