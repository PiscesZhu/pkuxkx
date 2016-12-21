askyou={}
askyou["ok"]=nil
askyou["fail"]=nil
youxunname="you xun"
do_askyou=function(_npcname,askyou_ok,askyou_fail)
	askyou["npcname"]=_npcname
	askyou["ok"]=askyou_ok
	askyou["fail"]=askyou_fail
	askyou.npcalive=false
	go(youxunloc,askyou.cmd,askyou_end_fail)
end

askyou["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(askyou[s])
	end
	askyou["ok"]=nil
	askyou["fail"]=nil
end

askyou_end_ok=function()
	askyou["end"]("ok")
end

askyou_end_fail=function()
	askyou["end"]("fail")
end

askyou["cmd"]=function()
	askyou.npcalive=false
	catch("askyou","ask "..youxunname.." about "..askyou["npcname"])
	infoend(askyou.askend)
end
askyou.askend=function()
	if askyou.npcalive then
		busytest(askyou_end_ok)
	else
		busytest(askyou_end_fail)
	end
end
askyouok=function(n,l,w)
	askyou.npcalive=true
end
