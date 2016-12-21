drawmap={}
drawmap["ok"]=nil
drawmap["fail"]=nil
drawmap["pathindex"]=0
drawmap["pathlist"]={citypath["yz"],citypath["xi"],citypath["wg"],citypath["zn"],citypath["sz"],citypath["hz"],citypath["cd"],citypath["rz"],citypath["ss"],citypath["fs"],citypath["nh"],citypath["fz"],citypath["qz"],citypath["hs"],citypath["xx"],citypath["ts"],citypath["lz"],citypath["gw"],citypath["dl"],citypath["xy"]}
do_drawmap=function(drawmap_ok,drawmap_fail)
	drawmap["ok"]=drawmap_ok
	drawmap["fail"]=drawmap_fail
	busytest(drawmap["main"])

end

drawmap["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(drawmap[s])
	end
	hook(hooks.fight,nil)
	drawmap["ok"]=nil
	drawmap["fail"]=nil
end

drawmap_end_ok=function()
	drawmap["end"]("ok")
end

drawmap_end_fail=function()
	drawmap["end"]("fail")
end

drawmap["step"]=function()
	run("yun regenerate;map here")
	busytest(steppath["next"])
end

drawmap["main"]=function()
		hook(hooks.fight,nil)
	if quest.stop then
		drawmap["end"]()
		return
	end
	getstatus(drawmap["check"])
end

drawmap["check"]=function()
	if do_check(drawmap["main"]) then
	elseif checkstudy(drawmap["main"]) then
	else
		busytest(drawmap["gopath"])
	end
end

drawmap["gopath"]=function()
	drawmap["pathindex"]=drawmap["pathindex"]+1
	if drawmap["pathindex"]>#drawmap["pathlist"] then
		drawmap["end"]("ok")
		return
	end
	hook(hooks.fight,drawmap.recon)
	do_steppath(drawmap["pathlist"][drawmap["pathindex"]],drawmap["step"],drawmap["main"],drawmap["main"],drawmap["main"])
end
drawmap.recon=function()
	drawmapreconloc=_roomid
	hook(hooks.logok,drawmap.resume)
	recon()
end


drawmap.resume=function()
	hook(hooks.isbusy,nil)
	if walking==steppath then
		busytest(drawmap["step"])
	else
		busytest(drawmap["main"])
	end
end
