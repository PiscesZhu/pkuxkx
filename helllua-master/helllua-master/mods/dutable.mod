dutable={}
dutable["ok"]=nil
dutable["fail"]=nil

do_dutable=function(dutable_ok,dutable_fail)
	dutable["ok"]=dutable_ok
	dutable["fail"]=dutable_fail
	busytest(dutable.main)
end

dutable["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(dutable[s])
	end
	dutable["ok"]=nil
	dutable["fail"]=nil
end

dutable_end_ok=function()
	dutable["end"]("ok")
end

dutable_end_fail=function()
	dutable["end"]("fail")
end

dutable.items={}
dutable.yxl={}
dutable.items["干粮"]={min=1000,max=1000}
dutable.items["牛皮水袋"]={min=8,max=8}
dutable.items={}
dutable.yxl["yingxiong ling"]={min=1,max=1}
dutable.checkyxl=function()
	if me.fam=="少林派" then return false end
	return checkitems(dutable.yxl,dutable["main"],dutable["main"])
end
dutable.main=function()
	if quest.stop then
		dutable["end"]()
		return
	end
	if _roomid==-1 then go(0,dutable.main,dutable.main) end
	if _roomid~=1938 then
		getstatus(dutable["check"])
	else
		getstatus(dutable.cmd)
	end
end

dutable.loop=function()
	busytest(dutable.loopcmd)
end
dutable.loopcmd=function()
	do_dutable(dutable.loop,dutable.loop)
end

dutable.check=function()
	if do_check(dutable["main"]) then
	elseif checkitems(dutable.items,dutable["main"],dutable["main"]) then
	elseif dutable.checkyxl() then
	else
		go(1938,dutable.main,dutable.main)
	end
end

dutable.cmd=function()
	if itemsnum("牛皮水袋")==0 or itemsnum("干粮")==0 then
		run("quit")
		return
	end
	if testneili() then
			dazuo(dutable.main)
	else
			run("du table;du table;du table;du table")
			busytest(dutable.main)
	end
end

canwu={}
canwu["ok"]=nil
canwu["fail"]=nil

do_canwu=function(canwu_ok,canwu_fail)
	canwu["ok"]=canwu_ok
	canwu["fail"]=canwu_fail
	busytest(canwu.main)
end

canwu["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(canwu[s])
	end
	canwu["ok"]=nil
	canwu["fail"]=nil
end

canwu_end_ok=function()
	canwu["end"]("ok")
end

canwu_end_fail=function()
	canwu["end"]("fail")
end

canwu.cmd=function()
	run("canwu xisui jing;canwu xisui jing;canwu xisui jing;canwu xisui jing")
	getstatus(canwu.main)
end
canwu.restok=function()
	getstatus(canwu.main)
end
canwu.main=function()
	if quest.stop then
		dutable["end"]()
		return
	end
	if _roomid==-1 then go(0,canwu.main,canwu.main) end
	if _roomid==1924 then
		go(1913,canwu.main,canwu_end_fail)
		return
	elseif _roomid~=1913 then
		getstatus(canwu["check"])
	elseif itemsnum("牛皮水袋")==0 or itemsnum("干粮")==0 then
		run("quit")
		discon()
		return
	elseif checkrest(canwu.restok,canwu.mian,1924) then
	else
		delay(1,canwu.cmd)
	end
end

canwu.loop=function()
	busytest(canwu.loopcmd)
end
canwu.loopcmd=function()
	do_canwu(canwu.loop,canwu.loop)
end

canwu.check=function()
	if do_check(canwu["main"]) then
	elseif checkitems(dutable.items,canwu["main"],canwu["main"]) then
	elseif canwu.checkyxl() then
	else
		go(1913,canwu.main,canwu.main)
	end
end
canwu.checkyxl=function()
	if me.fam=="少林派" then return false end
	return checkitems(dutable.yxl,canwu["main"],canwu["main"])
end



-------------------



thinkwall={}
thinkwall["ok"]=nil
thinkwall["fail"]=nil

do_thinkwall=function(thinkwall_ok,thinkwall_fail)
	thinkwall["ok"]=thinkwall_ok
	thinkwall["fail"]=thinkwall_fail
	busytest(thinkwall.main)
end

thinkwall["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(thinkwall[s])
	end
	thinkwall["ok"]=nil
	thinkwall["fail"]=nil
end

thinkwall_end_ok=function()
	thinkwall["end"]("ok")
end

thinkwall_end_fail=function()
	thinkwall["end"]("fail")
end

thinkwall.main=function()
	if quest.stop then
		thinkwall["end"]()
		return
	end
	getstatus(thinkwall.check)
end

thinkwall.check=function()
	if do_check(thinkwall["main"]) then
	else
		go(2571,thinkwall.arrive,thinkwall_end_fail)
	end
end

thinkwall.arrive=function()
	run("think wall")
	busytest(thinkwall.main)
end
