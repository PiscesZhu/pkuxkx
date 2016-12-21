info={}
info.fail=2
info.retry=1
info.answer=3
askinfo=function(npc,content,times)
	if times==nil then times=1 end
	info.answer=0
	if infolist[npc]~=nil then
		setinfoname(infolist[npc]["name"])
		trigrpon("info")
		content1="ask "..infolist[npc]["id"].." about "..content
		content=content1
		for i=2,times,1 do
			content=content..";"..content1
		end
		content=[[yun regenerate;]]..content
		npchere(infolist[npc]["id"],content)
		trigrpoff("info")
	end
end

setinfoname=function(str)
	SetTriggerOption ("info_fail", "match", "^(> )*("..str..")(摇摇头，说道：没听说过。|疑惑地看着你，摇了摇头。|睁大眼睛望着你，显然不知道你在说什么。|耸了耸肩，很抱歉地说：无可奉告。|说道：嗯....这我可不清楚，你最好问问别人吧。|想了一会儿，说道：对不起，你问的事我实在没有印象。)")
	SetTriggerOption ("info_retry", "match", "^(> )*("..str..")说道：(阿嚏！有点感冒，不好意思。|等...等等，你说什么？没听清楚。|嗯，稍等啊，就好... 好了，你刚才说啥？|这个... 这个... 哦，好了，啊？你问我呢？|唉呦！... 不好意思，是你问我么？|就好... 就好... 好了，你说啥？|你干啥？没看我忙着呢么？|!)")
end

info_fail=function()
	info.answer=info.fail
end

info_retry=function()
	if info.answer<info.retry then
		info.answer=info.retry
	end
end

-------------------------------

askinfolist={}
askinfolist["ok"]=nil
askinfolist["fail"]=nil
askinfolist["content"]=""
askinfolist["list"]={}
askinfolist.hook=nil
askinfolist.ailsettri=nil
askinfolist["index"]=0
ailre=rex.new("([0-9]+)")
do_askinfolist=function(content,aillist,ailsettri,ailtest,askinfolist_ok,askinfolist_fail)
	askinfolist["ok"]=askinfolist_ok
	askinfolist["fail"]=askinfolist_fail
	askinfolist["content"]=content
	askinfolist["list"]={}
	askinfolist["index"]=0
	askinfolist.hook=ailtest
	askinfolist.ailsettri=ailsettri
	local i=0
	n=ailre:gmatch(aillist,function (m, t)
		i=i+1
		askinfolist["list"][i]=m
	end)
	busytest(askinfolist.main)
end

askinfolist.main=function()
	askinfolist["index"]=askinfolist["index"]+1
	if #askinfolist["list"]<askinfolist["index"] then
		busytest(askinfolist_end_fail)
	else
		if infolist[askinfolist["list"][askinfolist["index"]]]~=nil then
			go(infolist[askinfolist["list"][askinfolist["index"]]].loc,askinfolist.arrive,askinfolist.main)
		else
			askinfolist.main()
		end
	end
end

askinfolist.arrive=function()
	busytest(askinfolist.askcmd)
end

askinfolist.askcmd=function()
	print("询问"..askinfolist["list"][askinfolist["index"]].."号卧底")
	if askinfolist.ailsettri~=nil then
		askinfolist.ailsettri(infolist[askinfolist["list"][askinfolist["index"]]].name)
	end
	askinfo(askinfolist["list"][askinfolist["index"]],askinfolist["content"])
	infoend(askinfolist.asktest)
end

askinfolist.asktest=function()
	if npc.nobody==1 or info.answer==2 then
		 askinfolist.main()
	elseif info.answer==1 then
		askinfolist.arrive()
	else
		call(askinfolist.hook)
	end
end

askinfolist["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(askinfolist[s])
	end
	askinfolist["ok"]=nil
	askinfolist["fail"]=nil
	askinfolist.alisettri=nil
	askinfolist.hook=nil
end

askinfolist_end_ok=function()
	askinfolist["end"]("ok")
end

askinfolist_end_fail=function()
	askinfolist["end"]("fail")
end



