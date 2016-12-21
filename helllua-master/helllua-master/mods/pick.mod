quest.savemoney["pick"]=true
pick={}
pick["inv"]={}
pick["index"]=1
pick["ok"]=nil
pick["fail"]=fail
pick.full=false
do_pick=function(pick_ok,pick_fail)
	pick["ok"]=pick_ok
	pick["fail"]=pick_fail
	busytest(pick["main"])
end
pick["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(pick[s])
	end
	EnableTriggerGroup("pick",false)
	pick["ok"]=nil
	pick["fail"]=nil
end
pick["main"]=function()
	if quest.stop then
		pick["end"]()
		return
	end
	getstatus(pick["check"])
end

pick["check"]=function()
	if do_check(pick["main"]) then
	elseif checksell(picklist,pick["main"]) then
	else
		pickbegin(cxpath[pickpathlist[math.random(1,#pickpathlist)]])
	end
end

makepicklist=function()
	pick["list"]={}
	for i,v in pairs(room_obj) do
		if picklist[i]~=nil then
			for t = 1,v["num"],1 do
				pick["list"][(#pick["list"]+1)]=i
			end
		end
	end
	pickitem()
end

pickbegin=function(_cxpath)
	pick.full=false
	EnableTriggerGroup("pick",true)
	do_steppath(_cxpath,pickstep,pick["fail"],pick["ok"],pick["fail"])
end
pickitem=function()
	if pick.full==true then
		busytest(pickinvfull)
		return
	end
	pick["index"]=pick["index"]+1
	if pick["index"]<=(#pick["list"]) then
		run("get "..picklist[pick["list"][pick["index"]]].id)
		busytest(pickitem)
	else
			steppath["next"]()
	end
end

pickinvfull=function()
	_roomid=steppath["getnextroom"]()
	steppath["end"]("ok")
end

pick_full=function(n,l,w)
	if picklist[pick["list"][pick["index"]]]==nil then return end
	EnableTriggerGroup("pick",false)
	if w[3]==picklist[pick["list"][pick["index"]]].cname or w[2]=="你身上的东西实在是太多了，没法再拿东西了。" then
		pick.full=true
	end
end

pickstep=function()
	pick["index"]=0
	busytest(makepicklist)
end


picklist={}
picklist["yin lun"]={name="yin lun",id="yin lun",cname="银轮"}
picklist["long sword"]={name="long sword",id="long sword",cname="长剑"}
picklist["iron blade"]={name="iron blade",id="iron blade",cname="钢刀"}
picklist["gangzhang"]={name="gangzhang",id="gangzhang",cname="钢杖"}


