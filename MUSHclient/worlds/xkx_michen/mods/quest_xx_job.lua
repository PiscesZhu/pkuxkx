---------------------------------------------------------------------------
-- File name   : quest_xx_job.lua
-- Description : 星宿门派任务机器人
-- Author: Michen (xmichen@gmail.com)
-- Version:	2014.05.01
---------------------------------------------------------------------------

--[[
流程思路：
EXP>150K会出NPC
EXP>100K xiulian会中毒

如果食物饮水少了，去厨房吃东西
如果潜能够了，去学习

--]]

print("quest:XX menpai Loading ok!")
qxxmp={}

qxxmp["ok"]=nil
qxxmp["fail"]=nil

-- 开始任务
qxxmp.start=function()
	SetVariable ("autologin","qxxmp.start()")

	quest.stop=false
	qxxmp.update()
	trigrpon("q_xxmp")
	run("get all;unset wimpy;unset no_parry;set brief 1;tune rumor;tune chat;tune xkx;set brief 1;score;cha;jifa;hp")
	gethp(qxxmp.do_pre)
end

-- 准备工作,检查食物，潜能，经验上限
qxxmp.do_pre=function()
	if me.hp["water"]<(me.hp["watermax"]/2) or me.hp["food"]<(me.hp["foodmax"]/2) then
		qxxmp.do_goeat()
		return
	end
	if me.hp["pot"]>(me.hp["potmax"]*4/5) then
		qxxmp.casemaster()
		qxxmp.do_gousepot()
		return
	end
	if qxxmp.joblimit then
		-- 经验上限了
		return
	end
	qxxmp.do_askjob()
end

qxxmp.do_gousepot=function()
end

qxxmp.casemaster=function()
	if me.master=="天狼子" then
		gomaster="s;s"
		backmaster="n;n"
	elseif me.master=="狮吼子" then
		gomaster="s;s;su"
		backmaster="nd;n;n"
	elseif me.master=="丁春秋" then
		gomaster=""
		backmaster=""
	end
end

qxxmp.do_goeat=function()
	run("s;s;e;serve;get pear;get rice;get niurou;get jiu;drink jiu;drink jiu;drink jiu;eat niurou;eat rice;eat pear")
	busytest(qxxmp.do_backeat)
end
qxxmp.do_backeat=function()
	run("drop pear;drop rice;drop niurou;w;n;n")
	gethp(qxxmp.do_pre)
end

qxxmp.do_askjob=function()
	local askjob_tri={
		".+好小子，上一个工作没有完成就敢来问我工作。$",
		".+老仙我最近练功需要一些毒丹，你到后山拿些来给我吧。",
	}
	local l_tri=linktri(askjob_tri)
	run("ask ding chunqiu about job")
	wait.make(function()
		local l,w=wait.regexp(l_tri,2)
		if l==nil then
			Note("师傅没在，或者正忙着")
			-- yun chongmai之类的::::::::::::::::::::::::::::::::::::::::::::::::::
			return
		end
		if string.find(l,"好小子，上一个工作没有完成就敢来问我工作。") then
			-- 检查身上要是没有wa guan，就要relogin了
			local Ic=Item.new()
			Ic:CatchStart()
			Ic.CatchEnd=function(pp)
				if me.items["wa guan"]>=1 then		-- 继续工作
					busytest(qxxmp.do_gojob)
				else
					-- relogin
					run("s;quit")
				end
			end
			return
		end
		if string.find(l,"老仙我最近练功需要一些毒丹，你到后山拿些来给我吧。") then
			-- 开始任务
			busytest(qxxmp.do_gojob)
			return
		end
	end)
end

qxxmp.do_gojob=function()
	run("s;nw;ne;n")
	busytest(qxxmp.do_search)
end

qxxmp.do_search=function()
	-- 如果有钱，先捡钱
	-- 如果有BUG，抓BUG
	-- 如果有NPC,先搞定NPC
	local search_tri={
		"你找到虫子用什么来盛呢？$",
		"你先休息一下吧。",
		"你上一个动作还没有完成。",
		"您先吧敌人料理了在说吧。",
		"你最好先回去复命，别让老仙等急了。",
		"找来有什么用？",
		--"你又找了找，发现没有丝毫毒虫的踪迹，只好离开这里，到别的地方寻找。",
		"突然间一只小虫子钻了出来，迅速地爬动着。",
		"突然间从树后越出一个人，高喊一声：“星宿奸人，拿命来！”",
		"你眼前.+一闪，哇，.+",
		--".+你弯下了腰，伸手将残枝败叶拨开，仔细寻找毒虫的踪迹。",
	}
	local l_tri=linktri(search_tri)
	run("get gold;search bug")
	wait.make(function()
		local l,w=wait.regexp(l_tri,2)
		if l==nil then
			--Note("search bug意外错误！！！！！！！！！")
			busytest(qxxmp.do_search)
			return
		end
		if string.find(l,"你找到虫子用什么来盛呢？") or string.find(l,"找来有什么用？") then
			-- 回去要任务，不给waguan就要relogin了
			busytest(qxxmp.milinback)
			return
		end
		if string.find(l,"你最好先回去复命，别让老仙等急了。") then
			-- 已经抓到虫了，先XIULIAN，再给老仙
			busytest(qxxmp.milinback)
			return
		end
		if string.find(l,"你先休息一下吧。") then
			run("yun refresh")
			busytest(qxxmp.do_search)
			return
		end
		if string.find(l,"你上一个动作还没有完成。") or string.find(l,"你眼前") then
			busytest(qxxmp.do_search)
			return
		end
		if string.find(l,"您先吧敌人料理了在说吧。") then
			-- 正在战斗中，杀人先
			return
		end
		if string.find(l,"突然间一只小虫子钻了出来，迅速地爬动着。") then
			-- 看看要不要抓虫子，EXP<150K是必须抓，>150K考虑也必须抓，如果这个做到上限了，就去树林HG MMR
			qxxmp.do_checknpcid()
			return
		end
		if string.find(l,"突然间从树后越出一个人，高喊一声：“星宿奸人，拿命来！”") then
			-- 开始要搞NPC了
			return
		end
	end)
end

qxxmp.do_checknpcid=function()
	checkidhere("星宿毒蛛|绿竹蝎|朱睛蛙|毒蛾|七心甲虫|野蜂|蓝鼎蜘蛛")
	busytest(qxxmp.do_getnpcid)
end
qxxmp.do_getnpcid=function()
	bugid=npcid
	busytest(qxxmp.do_catch)
end
qxxmp.do_catch=function()
	local catch_tri={
		".+这里没有这个生物。$",
		".+这东西最好不要抓。",
		".+你正忙着呢。",
		".+已经有毒虫了，修炼吧。",
		".+别人找出来的，你好意思抓吗？",
		".+你举起手中的瓦罐猛地将",
		".+你猛的出手用瓦罐扣向",
	}
	local l_tri=linktri(catch_tri)
	run("kou "..bugid)
	wait.make(function()
		local l,w=wait.regexp(l_tri,2)
		if l==nil then
			Note("catch bug意外错误！！！！！！！！！")
			busytest(qxxmp.do_catch)
			return
		end
		if string.find(l,"这里没有这个生物。") or string.find(l,"这东西最好不要抓。") or string.find(l,"别人找出来的，你好意思抓吗？") then
			busytest(qxxmp.do_search)
			return
		end
		if string.find(l,"你正忙着呢。") or string.find(l,"你猛的出手用瓦罐扣向") then
			busytest(qxxmp.do_catch)
			return
		end
		if string.find(l,"你举起手中的瓦罐猛地将") or string.find(l,"已经有毒虫了，修炼吧。") then
			busytest(qxxmp.milinback)
			return
		end
	end)
end
 	 
-- 从密林走出来
qxxmp.milinback=function()
	--[[
	1=n,nw,ne,s		out=s				xxh5						s;look
	2=s,w					out=w,e,s										w;look
	3=se,e					out=e,s											e;s;look
	4=w,e					out=w				shankou					w;look
	5=w						out=w,w			shankou					w;w;look
	6=ne,e					out=e				xxroad10					e;look
	7=ne,sw				out=sw,e			xxroad10					sw;look
	8=ne,sw				out=sw,sw,e	xxroad10					sw;look
	9=sw,e				out=e				xxh2						e;look
	10=s,w				out=w				yinshan					w;look
	11=s,w				out=w				saimachang				w;look
	12=s,w				out=w				silk1							w;look
	--]]
	if roominfo["name"]=="星宿密林" then
		print(table.concat(roominfo["exits"],"|"))
		if table.concat(roominfo["exits"],"|")=="north|northeast|northwest|south" then
			run("s")
		elseif table.concat(roominfo["exits"],"|")=="south|west" then
			run("w")
		elseif table.concat(roominfo["exits"],"|")=="east|southeast" then
			run("e;s")
		elseif table.concat(roominfo["exits"],"|")=="east|west" then
			run("w")
		elseif table.concat(roominfo["exits"],"|")=="west" then
			run("w;w")
		elseif table.concat(roominfo["exits"],"|")=="east|northeast" then
			run("e")
		elseif table.concat(roominfo["exits"],"|")=="northeast|southwest" then
			run("sw")
		elseif table.concat(roominfo["exits"],"|")=="east|southwest" then
			run("e")
		end
		busytest(qxxmp.milinback)
	else
		busytest(qxxmp.backding)
	end
end

qxxmp.backding=function()
	if roominfo["name"]=="日月洞" then
		run("ysis ding")
		busytest(qxxmp.do_xiulian)
		return
	end
	if roominfo["name"]=="星宿海" then
		if table.concat(roominfo["exits"],"|")=="north|southeast|southwest" then
			run("sw;se;n")
		end
		if table.concat(roominfo["exits"],"|")=="north|northeast|northwest|south" then
			run("n")
		end
	end
	if roominfo["name"] =="山口" then
		run("wu")
		getroom(gps_gangou_xx)
		return
	end
	if roominfo["name"]=="银山道" then
		getroom(gps_gangou_xx)
		return
	end
	if roominfo["name"]=="丝绸之路" then
		run("w;nw;w;nw;w;wu;wu")
		getroom(gps_gangou_xx)
		return
	end
	if roominfo["name"]=="赛马场" then
		run("se;s;s;s;w;wu;wu")
		getroom(gps_gangou_xx)
		return
	end
	if roominfo["name"]=="山谷深处" then
		run("su;eu;s;s;sd;ed;nu;nd;n;n")
	end
	getroom(qxxmp.backding)
end

local lastfx=nil
-- 过干沟出星宿
gps_gangou_yl=function()
	local nextfx=nil
	if roominfo["name"]=="银山道" then
		if table.getn(roominfo["exits"])==2 then
			lastfx=nil
			print("过干沟出星宿...成功！")
			return
		end
	end
	if roominfo["name"]=="干沟" then
		table.foreach(roominfo["exits"], function(i, fx)
			if fx~="northup" and fx~="westup" and fx~=lastfx then
				nextfx=fx
				lastfx=opposite_dir(nextfx)
			end
		end)
	end
	run(nextfx)
	getroom(gps_gangou_yl)
end
-- 过干沟到星宿
gps_gangou_xx=function()
	local nextfx=nil
	if roominfo["name"]=="干沟" then
		if table.getn(roominfo["exits"])>=3 then
			lastfx=nil
			print("过干沟到星宿...成功！")
			run("nu;nd;n;n")
			getroom(qxxmp.backding)
			return
		else
			table.foreach(roominfo["exits"], function(i, fx)
				if fx~=lastfx then
					nextfx=fx
					lastfx=opposite_dir(nextfx)
				end
			end)
		end
	end
	if roominfo["name"]=="银山道" then		-- eastdown
		table.foreach(roominfo["exits"], function(i, fx)
			if fx~="eastdown" then
				nextfx=fx
				lastfx=opposite_dir(nextfx)
			end
		end)
	end
	run(nextfx)
	getroom(gps_gangou_xx)
end

qxxmp.do_xiulian=function()
	local xiulian_tri={
		".+你正忙着呢。$",
		".+没有毒虫，你想要用空气修行吗？",
		".+将血吸完，肚子高高涨起，啪地一身掉进罐底，挣扎了几下，死了。",
		".+肚子高高涨起，啪地一身掉进罐底。",
	}
	local l_tri=linktri(xiulian_tri)
	run("xiulian")
	wait.make(function()
		local l,w=wait.regexp(l_tri,30)
		if l==nil then
			Note("xiulian意外错误！！！！！！！！！")
			busytest(qxxmp.start)
			return
		end
		if string.find(l,"你正忙着呢。") or string.find(l,"肚子高高涨起，啪地一身掉进罐底。") then
			busytest(qxxmp.do_xiulian)
			return
		end
		if string.find(l,"没有毒虫，你想要用空气修行吗？") then
			busytest(qxxmp.start)
			return
		end
		if string.find(l,"将血吸完，肚子高高涨起，啪地一身掉进罐底，挣扎了几下，死了。") then
			busytest(qxxmp.givedantoding)
			return
		end
	end)
end

qxxmp.givedantoding=function()
	run("give du dan to ding chunqiu")
	gethp(qxxmp.do_pre)
end

qxxmp.update=function()
end
