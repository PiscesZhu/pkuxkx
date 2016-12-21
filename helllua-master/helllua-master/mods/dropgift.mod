dropinbudailist={}
dropinbudailist["xuanyuan dan"]=true
dropinbudailist["Xuanyuan dan"]=true
dropinbudailist["ÐùÔ¯²¹ÐÄµ¤"]=true
if jiuzhuanfull==true then
	dropinbudailist["jiuzhuan jindan"]=true
	dropinbudailist["¾Å×ª½ðµ¤"]=true
end


dropgift={}
dropgift["ok"]=nil
dropgift["fail"]=nil
dropgift.baoguofull=false
dropgift.baoguoheavy=false
dropgift.enterchatfail=false
dropgift.gift=""
chatroom=nil
do_dropgift=function(giftid,dropgift_ok,dropgift_fail)
	dropgift["ok"]=dropgift_ok
	dropgift["fail"]=dropgift_fail
	dropgift.gift=giftid
	if dropgift.gift==nil or dropgift.gift=="" then
		dropgift_end_fail()
		return
	end
	dropgift.enterchatfail=false
	if chatroom==nil then
		getmudvar()
		infoend(dropgift.main)
	else
		dropgift.main()
	end
end
dropgift.main=function()
	busytest(dropgift.gochat)
end
dropgift["end"]=function(s)
	EnableTriggerGroup("enterchatfail",false)
	if ((s~="")and(s~=nil)) then
		call(dropgift[s])
	end
	dropgift["ok"]=nil
	dropgift["fail"]=nil
end

dropgift_end_ok=function()
	dropgift["end"]("ok")
end

dropgift_end_fail=function()
	dropgift["end"]("fail")
end


dropgift.gochat=function()
	if canenterchat()==true then
		EnableTriggerGroup("enterchatfail",true)
		go(chatroomloc,dropgift.arrive,dropgift.testbaoguo)
	else
		busytest(dropgift.testbaoguo)
	end
end
dropgift.arrive=function()
	busytest(dropgift.arrivechat)
end

dropgift.arrivechat=function()
	EnableTriggerGroup("enterchatfail",false)
	if dropongroundlist[dropgift.gift]==true then
		run("drop "..dropgift.gift)
		busytest(dropgift_end_ok)
		return
	end
	if dropinbudailist[dropgift.gift]==true  then
		getbagitems("budai of here")
		busytest(dropgift.budaiarrive)
		return
	end
	if itemsnum("baoguo")==0 then
		if room_obj["baoguo"]~=nil then
			run("get baoguo")
		else
			item["go"]("baoguo",1,dropgift.putgift,dropgift_end_fail)
			return
		end
	end
	dropgift.putgift()
end
dropgift.budaiarrive=function()
	if bagscount["budai of here"]==0 then
		jiuzhuancount=0
	else
		jiuzhuancount=getnum(bags["budai of here"]["jiuzhuan jindan"])
	end
	if jiuzhuancount>17 and dropgift.gift=="jiuzhuan jindan" then
		if itemsnum("baoguo")==0 then
			if room_obj["baoguo"]~=nil then
				run("get baoguo")
			else
				item["go"]("baoguo",1,dropgift.putgift,dropgift_end_fail)
				return
			end
		end
		dropgift.putgift()
		return
	end
	_dgneedbudai=false
	if bags["budai of here"]~=nil then
	for i,v in pairs(bags["budai of here"]) do
		if dropinbudailist[i]~= true then
		_dgneedbudai=true
		break;
		end
	end
	else
		_dgneedbudai=true
	end
	if _dgneedbudai==true or room_obj["budai"]==nil then
		item["go"]("budai",1,dropgift.budaiok,dropgift_end_fail)
	else
		dropgift.putbudai()
	end
end
dropgift.budaiok=function()
	go(chatroomloc,dropgift.dropbudai,dropgift_end_fail)
end
dropgift.dropbudai=function()
	run("drop budai;l")
	dropgift.putbudai()
end
dropgift.putbudai=function()
	run("put "..dropgift.gift.." in budai of here")
	dropgift_end_ok()
end

dropgift.testbaoguo=function()
	if itemsnum("baoguo")==0 then
			item["go"]("baoguo",1,dropgift.putgift,dropgift_end_fail)
	else
		busytest(dropgift.putgift)
	end
end

dropgift_enterchatfail=function(n,l,w)
	dropgift.enterchatfail=true
	walk["end"]("fail")
end

dropgift.putgift=function()
	dropgift.baoguofull=false
	dropgift.baoguoheavy=false
	catch("giftbaoguofail","put "..dropgift.gift.." in baoguo")
	infoend(dropgift.putgiftok)
end

giftbaoguofail=function(n,l,w)
	dropgift.baoguofull=true
end

giftbaoguoheavy=function(n,l,w)
	dropgift.baoguoheavy=true
end

dropgift.putgiftok=function()
	if dropgift.baoguofull==true then
		busytest(dropgift.buybaoguo)
	elseif dropgift.baoguoheavy==true then
		run("drop baoguo")
		item["go"]("baoguo",1,dropgift.putgift,dropgift_end_fail)
	else
		busytest(dropgift.testdropbaoguo)
	end
end

dropgift.buybaoguo=function()
	run("drop baoguo")
	item["go"]("baoguo",itemsnum("baoguo")+1,dropgift.putbaoguo,dropgift_end_fail)
end

dropgift.putbaoguo=function()
	go(chatroomloc,dropgift.putbaoguocmd,dropgfit_end_fail)
end

dropgift.putbaoguocmd=function()
	run("get baoguo;put baoguo in baoguo 2")
	busytest(dropgift.testdropbaoguo)
end

dropgift.testdropbaoguo=function()
	if canenterchat()==true then
		go(chatroomloc,dropgift.dropbaoguo,dropgfit_end_fail)
	else
		busytest(dropgift_end_ok)
	end
end
dropgift.dropbaoguo=function()
	run("drop baoguo;l")
	busytest(dropgift_end_ok)
end
canenterchat=function()
	if chatroom=="" or chatroom==nil or dropgift.enterchatfail==true then
		return false
	else
		return true
	end
end

checkgiftdrop=function(_droplist,drop_ok,drop_fail)
	for i,v in pairs(_droplist) do
		if itemsnum(i)>0 then
			do_dropgift(v,drop_ok,drop_fail)
			return true
		end
	end
end
