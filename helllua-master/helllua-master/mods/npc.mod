if stepmaxstep==nil then stepmaxstep=getnum(maxstep) end

npc={name="",id="",loc=-1,nobody=0}

npchere=function(npcid,str)
	npc.nobody=0
	run("shou "..npcid)
	catch("nobody",str..";")
end
npc_nobody=function(n,l,w)
	npc.nobody=1
end
npc_nobody2=function(n,l,w)
	npc.nobody=2
end


searchnpc={}
searchnpc["ok"]=nil
searchnpc["fail"]=nil
searchnpc.roomlist={}
do_searchnpc=function(searchnpc_ok,searchnpc_fail)
	npc.loc=-1
	searchnpc["ok"]=searchnpc_ok
	searchnpc["fail"]=searchnpc_fail
	searchnpc.roomlist={}
	EnableTriggerGroup("npc",true)
	doghook()
	if _roomname~=nil and _roomname~="" then
		if maze[_roomname]~=nil then
			searchnpc_end_fail()
			return
		end
	end
	do_search(searchnpc.step,searchnpc_end_fail,searchnpc_end_ok,searchnpc_end_fail,npcsearchmax)
end

searchnpc["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(searchnpc[s])
	end
	dogunhook()
	searchnpc.roomlist={}
	EnableTriggerGroup("npc",false)
	searchnpc["ok"]=nil
	searchnpc["fail"]=nil
end

searchnpc_end_ok=function()
	searchnpc["end"]("ok")
end

searchnpc_end_fail=function()
	searchnpc["end"]("fail")
end

searchnpc.step=function()
	busytest(searchnpc.test)
end

searchnpc.test=function()
	if room_obj[npc.name]~=nil then
		--if room_obj[npc.name].id~=nil then
			npc.id=room_obj[npc.name].id
		--else
			--npc.id=""
		--end
		if room_obj[npc.name].id~=nil then
			if string.find(room_obj[npc.name].id,"%s")==nil then
				return
			end
		end
		if _roomname~=nil and _roomname~="" then
			if maze[_roomname]==nil then
				_roomid=searchfor["nextroom"]
			end
		end
		print(_roomid)
		searchfor["end"]("ok")
	else
		searchnpc.roomlist[_roomid]=true
		searchfor["next"](getroomexits(searchfor["nextroom"],true,searchnpc.roomlist))
	end
end

npcinpath={}
npcinpath["ok"]=nil
npcinpath["fail"]=nil
npcinpath["loc"]=-1
npcinpath.path=nil
do_npcinpath=function(_path,npcinpath_ok,npcinpath_fail,reportonly)
	npcinpath["ok"]=npcinpath_ok
	npcinpath["fail"]=npcinpath_fail
	npcinpath["loc"]=-1
	npcinpath.reportonly=reportonly
	EnableTriggerGroup("npc",true)
	npcinpath.path=_path
	do_steppath(npcinpath.path,npcinpath.step,npcinpath_end_fail,npcinpath_end_fail,npcinpath_end_fail,stepmaxstep,npcinpath["maxstep"])
end

npcinpath["end"]=function(s)
	EnableTriggerGroup("npc",false)
	if ((s~="")and(s~=nil)) then
		call(npcinpath[s])
	end
	npcinpath["ok"]=nil
	npcinpath["fail"]=nil
end

npcinpath_end_ok=function()
	npcinpath["end"]("ok")
end

npcinpath_end_fail=function()
	npcinpath["end"]("fail")
end
npcinpath.step=function()
	print(steppath["nextroom"])
	if _roomname~=nil and _roomname~="" then
		if maze[_roomname]~=nil then
			busytest(npcinpath.testnpc)
			return
		end
	end
	npcinpath.testnpc()
end
npcinpath.testnpc=function()
	if quest.name=="mq" then
		for i,v in pairs(helpfindnpc) do
			if room_obj[v.name]~=nil then
				if room_obj[v.name].id~=nil then
					if string.find(room_obj[v.name].id,"%s")~=nil then
						helpfindnpcfound(i,_roomid,masterquest.city)
					end
				end
			end
		end
		for i,v in pairs(dragons) do
			if room_obj[v]~= nil then
				dragonfound(v,_roomid)
			end
		end
	end
	if room_obj[npc.name]~=nil then
		if room_obj[npc.name].id~=nil then
			if string.find(room_obj[npc.name].id,"%s")==nil then
				return
			end
		end
		npc.loc=_roomid
		npcinpath["loc"]=_roomid
		npc.id=room_obj[npc.name].id
		testnpcid()
		print("find"..npc.name.."@"..tostring(_roomid))
		if _roomname~=nil and _roomname~="" then
			if maze[_roomname]==nil or _roomname~=mazename then
				_roomid=steppath["nextroom"]
			elseif stepmaxstep>1 then
				npcinpathgokillnpc()
				return
			end
		end
		if stepmaxstep<2 then
			npcinpathgokillnpc()
			return
		end
		steppath["next"]()
	else
		steppath["next"]()
	end
end
npcinpathgokillnpc=function()
			steppath["end"]()
			if _roomid<0 or npc.loc<0 then
				npc.loc=-1
				do_steppath(npcinpath.path,npcinpath.step,npcinpath_end_fail,npcinpath_end_fail,npcinpath_end_fail,stepmaxstep,npcinpath["maxstep"])
				return
			end
			if npcinpath.reportonly~=true then
				if _roomid~=npc.loc then
					p=mapper.getpath(_roomid,npc.loc,0)
					run(p)
				end
				_roomid=npc.loc
				npcinpath_end_ok()
			else
				npcinpath_end_ok()
			end
end
npcinpath["maxstep"]=function()
	if npcinpath["loc"] >-1 then
		npcinpathgokillnpc()
		return
	end
	steppath["nextmaxstep"]()
end


npc_killme=function(n,l,w)
	if _hooklist[hooks.killme]~= nil then
		_hooklist[hooks.killme](w[2])
	end
end

testnpcid=function(obj)

end

getnpcid=function(tid)
	if npc.id~=nil then
		tid=npc.id
	end
	if tid==nil or tid=="" then
		tid=getcnname(npc.name)
	end
	if tid==nil then tid="" end
	return tid
end



-----------------

killnpcinpath={}
killnpcinpath["ok"]=nil
killnpcinpath["fail"]=nil

do_killnpcinpath=function(name,path,killnpcinpath_ok,killnpcinpath_fail,times)
	killnpcinpath.name=name
	killnpcinpath.path=path
	killnpcinpath.id=""
	if times==nil then times=1 end
	killnpcinpath.times=times
	killnpcinpath.count=1
	killnpcinpath["ok"]=killnpcinpath_ok
	killnpcinpath["fail"]=killnpcinpath_fail
	npc.name=name
	busytest(killnpcinpath.main)
end

killnpcinpath["main"]=function()
	if killnpcinpath.times<killnpcinpath.count then
		killnpcinpath_end_fail()
	else
		killnpcinpath.count=killnpcinpath.count+1
		fightpreper()
		eatdrink()
		busytest(killnpcinpath.search)
	end
end

killnpcinpath.search=function()
	do_npcinpath(killnpcinpath.path,killnpcinpath.npcfind,killnpcinpath.main)
end

killnpcinpath.npcfind=function()
	killnpcinpath.id=getnpcid(killnpcinpath.id)
	do_kill(killnpcinpath.id,killnpcinpath_end_ok,killnpcinpath.search2)
end

killnpcinpath.search2=function()
	do_searchnpc(killnpcinpath.npcfind,killnpcinpath.search2fail)
end

killnpcinpath.search2fail=function()
	busytest(killnpcinpath.search)
end

killnpcinpath["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(killnpcinpath[s])
	end
	killnpcinpath["ok"]=nil
	killnpcinpath["fail"]=nil
end

killnpcinpath_end_ok=function()
	killnpcinpath["end"]("ok")
end

killnpcinpath_end_fail=function()
	killnpcinpath["end"]("fail")
end

