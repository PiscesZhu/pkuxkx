exitback={east="w",e="w",south="n",s="n",west="e",w="e",north="s",n="s",southeast="nw",se="nw",southwest="ne",sw="ne",northeast="sw",ne="sw",northwest="se",nw="se",eastup="wd",eu="wd",eastdown="wu",ed="wu",southup="nd",su="nd",southdown="nu",sd="nu",westup="ed",wu="ed",westdown="eu",wd="eu",northup="sd",nu="sd",northdown="su",nd="su",up="d",u="d",down="u",d="u",enter="out",out="enter",cross="cross"}


 defsearchdepth=5

do_search=function(fstep,ffail,search_ok,search_fail,depth)
	walking=searchfor
	if depth==nil then
		_searchdepth=defsearchdepth
	else
		_searchdepth=depth
	end
	hook(hooks.steptimeout,searchfor["steptimeout"])
	searchfor["init"]()
	searchfor["ok"]=search_ok
	searchfor["fail"]=search_fail
	walkend=searchfor["end"]
	hook(hooks.step,fstep)
	hook(hooks.searchfrofail,ffail)
	searchfor["nextroom"]=_roomid
	run("l")
end


searchfor={}
_searchdepth=defsearchdepth
searchfor["nextroom"]=0
searchfor["steptimeout"]=function()
	if hashook(hooks.steptimeout) then
		searchfor["guarded"]()
	end
end
searchfor["end"]=function(s)
	hook(hooks.steptimeout,nil)
	hook(hooks.step,nil)
	hook(hooks.searchfrofail,nil)
	walking=nil
	EnableTriggerGroup("search",false)
	if ((s~="")and(s~=nil)) then
		call(searchfor[s])
	end
	searchfor["ok"]=nil
	searchfor["fail"]=nil
end

searchfor["init"]=function()
	_searchfordata={}
	_searchfordata[1]=nil
	_searchfordata[2]=nil
	_searchfordata[3]=nil
	_searchfordata[4]=nil
	_searchfordata[5]=nil
	_searchfordata[6]=nil--每层的出口数据，一个列表，以层为参数
	_searchforback={}--每层的返回数据，一个列表，以层为参数
	_searchforcount={}--每层的出口总数，一个数字，以层为参数
	_searchforindex={}--每层的当前出口，一个数字，以层为参数
	_searchforlevel=1 --当前层数
	_stepcallback=nil
	searchfor["step"]=0
	_searchforcallbackfaild=nil
	EnableTriggerGroup("search",true)
end
searchfor["nextcmd"]=function(exit)
	if searchfor["nextroom"]~=-1 then _roomid=searchfor["nextroom"] else _roomid=-1 end
	if (_searchfordata[_searchforlevel]==nil) then
		_searchfordata[_searchforlevel]={}
		_searchforindex[_searchforlevel]=0
		_searchforcount[_searchforlevel]=0
		if exit==nil then exit={} end
		for k,v in pairs(exit) do
			if (exitback[v]~=nil) and (exitback[exitback[searchfor["step"]]]~=exitback[v]) then
				_searchforcount[_searchforlevel]=_searchforcount[_searchforlevel]+1
				_searchfordata[_searchforlevel][_searchforcount[_searchforlevel]]=v
			end
		end
	end
	_searchforindex[_searchforlevel]=_searchforindex[_searchforlevel]+1
	if ((_searchforindex[_searchforlevel]>_searchforcount[_searchforlevel])or(_searchforlevel>_searchdepth)) then
		if (_searchforlevel==1) then
			callhook(hooks.searchfrofail)
			searchfor["end"]("fail")
			return false
		end
		searchfor["step"]=_searchforback[_searchforlevel]
		_searchforlevel=_searchforlevel-1
	else
		searchfor["step"]=_searchfordata[_searchforlevel][_searchforindex[_searchforlevel]]
		_searchforlevel=_searchforlevel+1
		_searchfordata[_searchforlevel]=nil
		_searchforback[_searchforlevel]=exitback[searchfor["step"]]
	end
	if _roomid~=-1 then
		searchfor["nextroom"]=getexitroom(_roomid,searchfor["step"])
	else
		searchfor["nextroom"]=-1
	end
	return true
end
searchfor["next"]=function(exit)
	if _roomname~=nil and _roomname~="" then
		if maze[_roomname]~=nil then
			if _roomname~=mazename then
				mazename=_roomname
				searchfor["nextcmd"](exit)
			end
			mazestep=searchfor["step"]
			maze[_roomname]()
			return
		end
	end
	initmaze()
	if searchfor["nextcmd"](exit)~=false then
		run(searchfor["step"])
	end
end
searchfor["guarded"]=function()
	ResetTimer("on_steptimeout")
	if not(hashook(hooks.steptimeout)) then return end
	if not(hashook(hooks.step)) then return end
	searchfor["nextroom"]=getexitroom(searchfor["nextroom"],exitback[searchfor["step"]])
	_searchforlevel=_searchforlevel-1
	searchfor["next"](nil)
end
xiaoerguard=function(name, line, wildcards)
	searchfor["guarded"]()
end



--------------------------------


steppath={}
steppath["maxstep"]=0
do_steppath=function(path,pstep,pfail,path_ok,path_fail,path_maxstep,path_onmaxstep)
	walking=steppath
	steppath["path"]=path
	steppath["ok"]=path_ok
	steppath["fail"]=path_fail
	walkend=steppath["end"]
	steppath["pstep"]=pstep
	steppath["pfail"]=pfail
	steppath["maxstep"]=getnum(path_maxstep)
	steppath["steptype"]=0
	steppath["onmaxstep"]=path_onmaxstep
	EnableTriggerGroup("steppath",true)
	do_walk(path[1]["loc"],steppath["arrive"],path_fail)
end
steppath["arrive"]=function()
	walking=steppath
	hook(hooks.steptimeout,steppath_fail)
	hook(hooks.step,steppath["pstep"])
	hook(hooks.maxstep,steppath["onmaxstep"])
	hook(hooks.searchfrofail,steppath["pfail"])
	steppath["index"]=0
	steppath["step"]=nil
	steppath["steppath"]=0
	steppath["nextroom"]=_roomid
	steppath["next"]()
	if steppath["maxstep"]>1 then
		steppath["steppath"]=1
		steppath.resume=steppath["runmaxstep"]
		doghook()
		busytest(steppath["runmaxstep"])
	end

end
steppath["end"]=function(s)
	hook(hooks.steptimeout,nil)
	hook(hooks.step,nil)
	hook(hooks.maxstep,nil)
	hook(hooks.searchfrofail,nil)
	walking=nil
	EnableTriggerGroup("steppath",false)
	if ((s~="")and(s~=nil)) then
		call(steppath[s])
	end
	steppath.resume=nil
	dogunhook()
	steppath["ok"]=nil
	steppath["fail"]=nil

end
steppath["nextmaxstep"]=function()
	if steppath["maxstep"]<2 or walking~=steppath then return end
	if _roomid==-1 then
		do_walk(steppath["path"][1]["loc"],steppath["arrive"],path_fail)
		return
	end
	if (steppath["index"]>#steppath["path"]) then
		steppath["end"]("ok")
		return
	end
	busytest(steppath["runmaxstep"])
end

steppath["runmaxstep"]=function()
	local steps,steptype=getmaxstepsinpath(steppath["path"],steppath["index"],steppath["maxstep"])
	steppath["steptype"]=steptype
	if steptype==1 then
		steps=steps..walkmaxstepmcmd
	end
	run(steps)
end

steppath["next"]=function()
	if _roomname~=nil and _roomname~="" then
		if maze[_roomname]~=nil then
			if _roomname~=mazename then
				mazename=_roomname
				steppath["index"]=steppath["index"]+1
				_roomid=steppath["nextroom"]
				steppath["step"]=steppath["path"][steppath["index"]]["step"]
				steppath["nextroom"]=getexitroom(_roomid,steppath["step"])
			end
			mazestep=steppath["step"]
			maze[_roomname]()
			return
		end
	end
	initmaze()
	steppath["index"]=steppath["index"]+1
	_roomid=steppath["nextroom"]
	if (steppath["index"]>#steppath["path"])then
		if steppath["maxstep"]<2 then
			steppath["end"]("ok")
		end
		return
	end
		steppath["step"]=steppath["path"][steppath["index"]]["step"]
		steppath["nextroom"]=getexitroom(_roomid,steppath["step"])
	if steppath["maxstep"]<2 then
		run(steppath["step"])
	elseif  steppath["steptype"]==2 then
		run(walkmaxstepmcmd)
	end
end

steppath["getnextroom"]=function()
	if _roomname~=nil and _roomname~="" then
		if maze[_roomname]~=nil then
			if _roomname==mazename then
				return(_roomid)
			end
		end
	end
	return steppath["nextroom"]
end

steppath_fail=function(n,l,w)
	local nextsameroom=getnextsameroom(_roomid)
	if nextsameroom>-1 then
		steppath["index"]=nextsameroom
		if (steppath["index"]==#steppath["path"]) then
			steppath["end"]("ok")
			return
			end
		steppath["step"]=steppath["path"][steppath["index"]]["step"]
		steppath["nextroom"]=getexitroom(_roomid,steppath["step"])
		run(steppath["step"])
	else
		steppath["end"]("fail")
	end
end

getnextsameroom=function(thisloc)
	for v=steppath["index"]+1,#steppath["path"],1 do
		if steppath["path"][v]["loc"]==thisloc then return v end
	end
	return -1
end
