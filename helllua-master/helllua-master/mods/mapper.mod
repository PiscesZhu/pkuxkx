assert  (package.loadlib (luapath.."mapper.dll","luaopen_mapper")) ()
mapper={}
mapper.id=mushmapper.getid(GetWorldID())
mapper.open=function(roomsall)
	return mushmapper.openmap(mapper.id,roomsall)
end
mapper.getpath=function(r,t,f)
	return mushmapper.getpath(mapper.id,r,t,f)
end
mapper.getroomid=function(r)
	return mushmapper.getroomid(mapper.id,r)
end

mapper.getexits=function(r)
	return mushmapper.getexits(mapper.id,r)
end
mapper.settags=function(t)
	print(t)
	return mushmapper.settags(mapper.id,t)
end
mapper.setflylist=function(f)
	return mushmapper.setflylist(mapper.id,f)
end

mapper.getroomname=function(r)
	return mushmapper.getroomname(mapper.id,r)
end

mapper.addpath=function(r,p)
	mushmapper.addpath(mapper.id,r,p)
end

mapper.newarea=function(i)
	return mushmapper.newarea(mapper.id,i)
end
mapper.clearroom=function(i)
	return mushmapper.clearroom(mapper.id,i)
end
mapper.readroom=function(r,s)
	mushmapper.readroom(mapper.id,r,s)
end

getexitroom=function (room,dir)

	local exits={}
	local i=0
	local tdir=""
	local texit=""
	if room<0 then return -1 end
	if dir==nil then return room end
	exits=mapper.getexits(room)
	while (i<#exits) do
		i=i+1
		tdir=dir
		texit=exits[i][1]
		if #tdir > #texit then
			texit=texit.."*"
		elseif #tdir < #texit then
			tdir=tdir.."*"
		end
		if (tdir==texit) then return exits[i][2] end
	end
	return -1
end

defdisableroomlist={}
getroomexits=function (room,enterable,disableroomlist)
	local exits={}
	local i=0
	local exitcount=0
	local roomexits={}
	if disableroomlist==nil then
		disableroomlist=defdisableroomlist
	end
	if room<0 then return nil end
	exits=mapper.getexits(room)
	while (i<#exits) do
		i=i+1
		if enterable==true then
			if exits[i][2]==-1 then
				break
			elseif exitback[exits[i][1]]==nil then
				break
			elseif getexitroom(exits[i][2],exitback[exits[i][1]])~=room then
				break
			end
		end
		if disableroomlist[exits[i][2]]==true then break end
		exitcount=exitcount+1
		roomexits[exitcount]=exits[i][1]
	end
	return roomexits
end
