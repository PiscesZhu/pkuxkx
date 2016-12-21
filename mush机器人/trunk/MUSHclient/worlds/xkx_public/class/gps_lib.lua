yun_check=false
yun_is_ok=true
function alias.ceilneili()
	--[[ 关闭过期检测
	if not yun_is_ok then
		ColourNote("red","blue","重要警告信息！！！！！！！！！")
		ColourNote("red","blue","============================")
		ColourNote("red","blue","你目前使用的版本已经过期！！！")
		ColourNote("red","blue","如果需要继续使用！！！！！！！")
		ColourNote("red","blue","请联系Michen！！！！！！！！！")
		ColourNote("red","blue","============================")
		run=""
	end
	if yun_check then return end
	wait.make(function()
		Execute("time")
		local l,w=wait.regexp('^\\s+北京时间 \\->(\\S+)\\s+(\\S+)\\s+\\d+:\\d+$')
		if l==nil then
			return
		end
		local a,b,c,d,e,f=string.find(l,"%s+北京时间 %->(%S+)%s+(.-)年(.-)月(.-)日%s+%d+:%d+")
		if d~=nil and e~=nil and f~=nil then
			yun_check=true
			d=string.gsub(d,"零","0")
			d=string.gsub(d,"一","1")
			d=string.gsub(d,"二","2")
			d=string.gsub(d,"三","3")
			d=string.gsub(d,"四","4")
			d=string.gsub(d,"五","5")
			d=string.gsub(d,"六","6")
			d=string.gsub(d,"七","7")
			d=string.gsub(d,"八","8")
			d=string.gsub(d,"九","9")
			d=tonumber(d)
			if d>=2016 then
				yun_is_ok=false
			end
		end
	end)
	]]
end
------------------------------------------------------------------------------------
-- xkxGPS
------------------------------------------------------------------------------------
xkxGPS={
	EntranceCondition="condition is null",
	EndRoomEntrance="",
	EndRoomName="",
	currRoomNo=0,
}
conn=nil
dbfile="xkxMAP.db"
room={
	name=nil,
	desc=nil,
	exits=nil,
}
function xkxGPS.setRoomname(w)
	xkxGPS["roomname"]=Trim(w)
end
function xkxGPS.setDesc(w)
	xkxGPS["desc"]=Trim(w)
end
function xkxGPS.setEntrance(w)
	local exits=nil
	exits = (string.gsub(w, " 和 ", "、"))
	exits = strexplit(exits, "、")
	xkxGPS["entrance1"]=exits
	table.sort(xkxGPS["entrance1"]) 
	xkxGPS["entrance"]=table.concat(xkxGPS["entrance1"], "|")
end
function xkxGPS.setEntranceCondition(w)
	xkxGPS.EntranceCondition=w
end
function xkxGPS.connectDB()
	if conn==nil then
		conn=assert(sqlite3.open(dbfile))
	end
end
all_fx_list={"eu","e","ed","se","su","s","sd","sw","wu","w","wd","nw","nu","n","nd","ne","enter","out","u","d","1","2","3","4","5","6","7","8",}
function xkxGPS.pathlist(path)
	local _tb
	local row=0
	xkxGPS.pathArray1={}
	local indexQueue={}
	local col=0

	if path==nil then path="" end
	_tb=utils.split(path,";")
	xkxGPS.pathListNum2=table.getn(_tb)

	for k,v in ipairs(_tb) do
		if xkxGPS.pathArray1[row]==nil then xkxGPS.pathArray1[row]="" end
		xkxGPS.pathArray1[row]=xkxGPS.pathArray1[row]..v..";"
		if not findstrlist2(v,all_fx_list) then
			table.insert(indexQueue,row)
			row=row+1
			xkxGPS.pathArray1[row]=""
			col=0
		end
		if col<20 or col+(21*row)==xkxGPS.pathListNum2 then col=col+1
		else
			row=row+1
			xkxGPS.pathArray1[row]=""
			col=0
		end
	end
	local Index=-1
	if table.getn(indexQueue)>0 then Index=table.remove(indexQueue,1) end
	local i=0
	while i<=table.getn(xkxGPS.pathArray1) do
		if i==Index then
			if table.getn(indexQueue)>0 then Index=table.remove(indexQueue,1) end
			xkxGPS.pathArray1[i]=string.sub(xkxGPS.pathArray1[i],1,-2)
		elseif i==table.getn(xkxGPS.pathArray1) then
			xkxGPS.pathArray1[i]=xkxGPS.pathArray1[i].."set walk over"
		else
			xkxGPS.pathArray1[i]=xkxGPS.pathArray1[i].."set walk off"
		end
		i=i+1
	end
	-- print("完整路径为："..path)
	-- print("切割后的路径为：")
	-- tprint(xkxGPS.pathArray1)
end
function xkxGPS.pathArray2(idx)
	return xkxGPS.pathArray1[idx]
end
function xkxGPS.findSafeExit(id)
	xkxGPS.connectDB()
	local sql="SELECT Entrance,EntranceSafe FROM Room WHERE RoomNO="..id
	for row in conn:nrows(sql) do
		if row["EntranceSafe"]~=nil then return row["EntranceSafe"] else return row["Entrance"] end
	end
	return ""
end
function xkxGPS.location()
	alias.ceilneili()
	xkxGPS.connectDB()
	xkxGPS.currRoomNo=0
	local sql="SELECT distinct roomname,Entrance,RoomNO,ZoneNO FROM Room WHERE roomname like '"..xkxGPS["roomname"].."' and desciption='"..xkxGPS["desc"].."' and Entrance='"..xkxGPS["entrance"].."'"
	-- print(sql)
	local flag=false
	for row in conn:nrows(sql) do
		if flag then
			xkxGPS.currRoomNo=-1
			return tonumber(xkxGPS.currRoomNo)
		end
		xkxGPS.currRoomNo=tonumber(row["RoomNO"])
		flag=true
	end
	return tonumber(xkxGPS.currRoomNo)
end
function xkxGPS.findroomarea(a,b,c)
	alias.ceilneili()
	xkxGPS.connectDB()
	-- 把所有的目标房间找出来
	local dest_room_list={}
	local sql="SELECT distinct RoomNO,ZoneNO FROM Room WHERE roomname='"..tostring(a).."'"
	for row in conn:nrows(sql) do
		local cell={Direction="over",FatherRoom=0,}
		if b=="none" or (b~="none" and findstring(row["ZoneNO"],b)) then
			if dest_room_list[0]==nil then dest_room_list[0]={} end
			if dest_room_list[0][row["RoomNO"]]==nil then dest_room_list[0][row["RoomNO"]]={} end
			dest_room_list[0][row["RoomNO"]]=cell
		end
	end
	--tprint(dest_room_list)
	-- 把方圆几里的目标房间都找出来
	local i=1
	local PastRoomNo={}
	while i<=tonumber(c)-1 do
		dest_room_list[i]={}
		if dest_room_list[i-1]~=nil then
			for j,v in pairs(dest_room_list[i-1]) do
				sql="SELECT distinct a.LinkRoomNo,a.Direction FROM Entrance AS a,Room AS b,Room AS c WHERE a.RoomNo=b.RoomNO AND a.LinkRoomNo=c.RoomNO AND b.FTBSearch=1 AND c.FTBSearch=1 AND "..tostring(xkxGPS.EntranceCondition).." AND a.RoomNo="..tostring(j)
				if PastRoomNo[j]==nil then PastRoomNo[j]=j end
				for row in conn:nrows(sql) do
					local LinkRoomno=row["LinkRoomNo"]
					local Direction=row["Direction"]
					if dest_room_list[i][LinkRoomno]==nil and PastRoomNo[LinkRoomno]==nil then
						cell={Direction=Direction,FatherRoom=j,}
						if dest_room_list[i]==nil then dest_room_list[i]={} end
						dest_room_list[i][LinkRoomno]=cell
					end
				end
			end
		end
		i=i+1
	end
	--tprint(dest_room_list)
	local _tmp_list={}
	PastRoomNo={}
	local _tmproom=0
	local all_room_list={}
	for i=tonumber(c)-1,1,-1 do
		-- 从最后一个范围往回循环，如果有遇到过河的，放到另外一个队列，已经处理过的房间ID记录到一个队列里
		for k,v in pairs(dest_room_list[i]) do		-- 循环范围内所有房间
			if PastRoomNo[k]==nil then		-- 已经处理过了就不再处理了
				PastRoomNo[k]=k			-- 标识已处理
				_tmp_list=xkxGPS._tmp_findroomarea(dest_room_list,k,i,PastRoomNo)
				PastRoomNo=_tmp_list.pastroom
				--print("没过河的"..k)
				--tprint(_tmp_list)
				if all_room_list[k]==nil then all_room_list[k]={str="",endid=0,} end
				all_room_list[k]["str"]=_tmp_list.str
				all_room_list[k]["endid"]=_tmp_list.endid
				if all_room_list[k]["str"]=="" then all_room_list[k]=nil end
				while tonumber(_tmp_list.id)>0 do	-- 有需要过河的处理
					if PastRoomNo[_tmp_list.upid]==nil then
						PastRoomNo[_tmp_list.upid]=_tmp_list.upid
						if all_room_list[_tmp_list.upid]==nil then all_room_list[_tmp_list.upid]={str="",endid=0,} end
						all_room_list[_tmp_list.upid]["str"]=tostring(_tmp_list.upid).."#guohe>"..tostring(_tmp_list.id).."#over"
						all_room_list[_tmp_list.upid]["endid"]=_tmp_list.id
					end
					if PastRoomNo[_tmp_list.id]==nil then		-- 已经处理过了就不再处理了
						_tmproom=_tmp_list.id
						PastRoomNo[_tmp_list.id]=_tmproom			-- 标识已处理
						_tmp_list=xkxGPS._tmp_findroomarea(dest_room_list,_tmp_list.id,_tmp_list.level,PastRoomNo)
						PastRoomNo=_tmp_list.pastroom
						--print("要过河的".._tmproom)
						--tprint(_tmp_list)
						if all_room_list[_tmproom]==nil then all_room_list[_tmproom]={str="",endid=0,} end
						all_room_list[_tmproom]["str"]=_tmp_list.str
						all_room_list[_tmproom]["endid"]=_tmp_list.endid
						if all_room_list[_tmproom]["str"]=="" then all_room_list[_tmproom]=nil end
					else _tmp_list.id=0 end
				end
			end
		end
	end
	--tprint(all_room_list)
	-- 好了，开始把同一区域的路径连接起来
	dest_room_list={}
	for k,v in pairs(all_room_list) do
		if not findstring(v["str"],"guohe") then
			if dest_room_list[v["endid"]]==nil then
				dest_room_list[v["endid"]]=v["str"]
			else
				dest_room_list[v["endid"]]=dest_room_list[v["endid"]].."|"..v["str"]
			end
		end
	end
	local isguohe=false
	for k,v in pairs(all_room_list) do
		if findstring(v["str"],"guohe") then
			isguohe=true
			if dest_room_list[k]==nil then
				dest_room_list[k]=v["str"]
			else
				dest_room_list[k]=dest_room_list[k].."|"..v["str"]
			end
		end
	end
	--tprint(dest_room_list)
	local str=""
	local _tmppath=""
	local _tmp_list={}
	-- xkxGPS.search(roomno_now,_tb[flytonamelistindex])1705
	if isguohe then
		if tonumber(roomno_now)~=nil and tonumber(roomno_now)>0 then _tmproom=tonumber(roomno_now)
		else _tmproom=1705 end				-- 模拟成在斧头帮了
		for k,v in pairs(dest_room_list) do	-- 先循环一次，顺便把过去的路径都找一下，然后把不用过河的先加进路径
			_tmppath=xkxGPS.search(_tmproom,k)
			if _tmp_list[k]==nil then _tmp_list[k]="" end
			_tmp_list[k]=_tmppath
			if not findstring(_tmppath,"guohe") then
				if str=="" then str=v else str=str.."|"..v end
			end
		end
		for k,v in pairs(dest_room_list) do	-- 再循环一次，把需要过河一次的路径加进去
			local _t,_num=string.gsub(_tmp_list[k], "guohe", "abc")
			if _num~=nil and _num==1 then
				if str=="" then str=v else str=str.."|"..v end
			end
		end
		for k,v in pairs(dest_room_list) do	-- 再循环一次，把需要过河两次的路径加进去，目前应该只有要过两次河的地点
			local _t,_num=string.gsub(_tmp_list[k], "guohe", "abc")
			if _num~=nil and _num>1 then
				if str=="" then str=v else str=str.."|"..v end
			end
		end
	else
		-- 没有需要过河就容易了，全部连起来就是
		for k,v in pairs(dest_room_list) do
			if str=="" then str=v else str=str.."|"..v end
		end
	end
	return str
end
-- 传入整个的TABLE，传入一个起始ROOMID，传入起始层，返回一个TABLE，里面有完整的行走路线，和没处理完的要过河的ROOMID，以及在哪个层
function xkxGPS._tmp_findroomarea(room_list,roomid,level,PastRoom)
	local str=""
	local roomno=roomid
	local ret={
		str="",
		id=0,
		upid=0,
		endid=0,
		level=nil,
		pastroom=PastRoom,
	}
	for i=level,0,-1 do
		if room_list[i][roomno]["Direction"]=="over" then
			if str~="" then
				str=str.."#over"
			end
			if PastRoom[roomno]==nil then PastRoom[roomno]=roomno end
			ret.pastroom=PastRoom
			ret.str=str
			ret.endid=tonumber(roomno)
			return ret
		elseif room_list[i][roomno]["Direction"]=="guohe" then
			if str~="" then
				str=str.."#over"
			end
			if PastRoom[roomno]==nil then PastRoom[roomno]=roomno end
			ret.pastroom=PastRoom
			ret.str=str
			ret.upid=tonumber(room_list[i][roomno]["FatherRoom"])
			ret.id=tonumber(roomno)
			ret.endid=tonumber(roomno)
			ret.level=i-1
			return ret
		else
			if str=="" then
				str=tostring(room_list[i][roomno]["FatherRoom"]).."#"..tostring(room_list[i][roomno]["Direction"])..">"..tostring(roomno)
			else
				str=tostring(room_list[i][roomno]["FatherRoom"]).."#"..tostring(room_list[i][roomno]["Direction"])..">"..str
			end
			if PastRoom[roomno]==nil then PastRoom[roomno]=roomno end
			ret.pastroom=PastRoom
			roomno=room_list[i][roomno]["FatherRoom"]
		end
	end
	ret.str=str
	return ret
end
--1049#nw>1048#over|1049#nw>1048#over|1049#s>1050#s>1051#s>1052#se>1053#over|1049#guohe>1526#e>1531#guohe>1708#n>1709#over|1049#guohe>1526#n>1525#n>1524#n>1523#over|1049#guohe>1526#w>1527#nu>1529#slsl-slsl>1530#over|1049#guohe>1526#w>1527#sw>1528#over

function xkxGPS.findroomarea_old(a,b,c)
	alias.ceilneili()
	xkxGPS.connectDB()
	local roomno1={}
	local roomno2={}
	local level_roomNo={}
	local sql="SELECT distinct RoomNO,ZoneNO FROM Room WHERE roomname='"..a.."'"
	for row in conn:nrows(sql) do
		local cell={Direction="over",FatherRoom=0,}
		if b=="none" or (b~="none" and findstring(row["ZoneNO"],b)) then
			if roomno1[row["RoomNO"]]==nil then roomno1[row["RoomNO"]]={} end
			roomno1[row["RoomNO"]]=cell
		end
		if findstring(row["ZoneNO"],b) then
			if roomno2[row["RoomNO"]]==nil then roomno2[row["RoomNO"]]={} end
			roomno2[row["RoomNO"]]=cell
		end
	end
	if table.getn(roomno2)>0 then level_roomNo[0]=roomno2 else level_roomNo[0]=roomno1 end
	local i=1
	local _Vb_t_i4_0=tonumber(c)-1
	local levelEnumerator={}
	local PastRoomNo={}
	while i<=_Vb_t_i4_0 do
		level_roomNo[i]={}
		levelEnumerator=level_roomNo[i-1]
		for j,v in pairs(levelEnumerator) do
			sql="SELECT distinct a.LinkRoomNo,a.Direction FROM Entrance AS a,Room AS b,Room AS c WHERE a.RoomNo=b.RoomNO AND a.LinkRoomNo=c.RoomNO AND b.FTBSearch=1 AND c.FTBSearch=1 AND "..xkxGPS.EntranceCondition.." AND a.RoomNo="..j
			if PastRoomNo[j]==nil then PastRoomNo[j]=j end
			for row in conn:nrows(sql) do
				local LinkRoomno=row["LinkRoomNo"]
				local Direction=row["Direction"]
				if level_roomNo[i][LinkRoomno]==nil and PastRoomNo[LinkRoomno]==nil then
					cell={Direction=Direction,FatherRoom=j,}
					if level_roomNo[i]==nil then level_roomNo[i]={} end
					level_roomNo[i][LinkRoomno]=cell
				end
			end
		end
		i=i+1
	end
	levelEnumerator={}
	local Channel={}
	local Channels={}
	local ChannelsIndex={}
	local j=0
	local n=0
	i=tonumber(c)-1
	--print("level_roomNo===")
	--tprint(level_roomNo)
	while i>=1 do
		--print("  循环i="..i)
		levelEnumerator=level_roomNo[i]
		--print("  levelEnumerator=level_roomNo[i]===")
		--tprint(levelEnumerator)
		for k,v in pairs(levelEnumerator) do
			--print("    循环levelEnumerator,k="..k..",v===")
			--tprint(v)
			local needAdd=true
			local _Vb_t_i4_1=table.getn(ChannelsIndex)
			j=1
			while j<=_Vb_t_i4_1 do
				--print("      循环j="..j..",_Vb_t_i4_1=".._Vb_t_i4_1)
				--print("      对比ChannelsIndex[j]="..ChannelsIndex[j].."&"..k)
				if ChannelsIndex[j]~=nil and tonumber(ChannelsIndex[j])==tonumber(k) then
					--print("对比成功！")
					needAdd=false
					Channel=Channels[j]
					table.insert(Channel,1,v)
					cell=v
					ChannelsIndex[j]=cell["FatherRoom"]
				end
				j=j+1
			end
			if needAdd then
				local cell1={}
				n=n+1
				cell=v
				ChannelsIndex[n]=cell["FatherRoom"]
				Channel={}
				cell1["Direction"]="over"
				cell1["FatherRoom"]=tonumber(k)
				table.insert(Channel,1,cell1)
				table.insert(Channel,1,v)
				Channels[n]=Channel
			end
		end
		i=i-1
	end
	--tprint(Channels)
	--tprint(ChannelsIndex)
	local channelEnumerator=Channels
	j=0
	local temp=""
	local channels1={}
	local Num_channels1=table.getn(Channels)-1
	for k,v in pairs(channelEnumerator) do
		Channel=v
		while table.getn(Channel)>0 do
			cell=table.remove(Channel,1)
			if channels1[j]==nil then channels1[j]="" end
			channels1[j]=channels1[j]..cell.FatherRoom.."#"..cell.Direction..">"
			temp=temp..cell.FatherRoom.."#"..cell.Direction..">"
		end
		temp=string.sub(temp,1,-2)
		channels1[j]=string.sub(channels1[j],1,-2)
		--print(channels1[j])
		--if channels1[j]~=nil then channels1[j]=string.sub(channels1[j],1,-2) else channels1[j]="" end
		j=j+1
		temp=temp.."|"
	end
	--print(temp)
	--print("===")
	if string.len(temp)>1 then
		temp=xkxGPS.findroomAreaList(string.sub(temp,1,-2),c)
		temp=xkxGPS.SortArealist(temp)
		-- xkxGPS.SortArealist(xkxGPS.findroomAreaList(string.sub(temp,1,-2),c))
		--print(temp)
		return temp
	else
		return ""
	end
end
function xkxGPS.findroomAreaList(AreaList,range)
	local Arr_AreaList=utils.split(string.gsub(AreaList,"guohe","zzzzguohe"),"|")
	local Arr_AreaList_temp={}
	local Arr_AreaListStep={}
	table.sort(Arr_AreaList)
	local x,y,i
	findroomAreaList=""
	--tprint(Arr_AreaList)
	for y=1,table.getn(Arr_AreaList),1 do
		--print(Arr_AreaList[y])
		Arr_AreaList_temp=utils.split(Arr_AreaList[y],">")
		for x=1,table.getn(Arr_AreaList_temp),1 do
			if Arr_AreaListStep[x]==nil then Arr_AreaListStep[x]={} end
			Arr_AreaListStep[x][y]=Arr_AreaList_temp[x]
		end
	end
	--tprint(Arr_AreaListStep)
	for x=1,table.getn(Arr_AreaListStep),1 do
		if x>1 and Arr_AreaListStep[x]~=nil and Arr_AreaListStep[x][1]~=nil then findroomAreaList=findroomAreaList..">" end
		if Arr_AreaListStep[x]~=nil and Arr_AreaListStep[x][1]~=nil then findroomAreaList=findroomAreaList..Arr_AreaListStep[x][1] end
	end
	for y=1,table.getn(Arr_AreaList),1 do
		findroomAreaList=findroomAreaList.."|"
		for x=1,table.getn(Arr_AreaListStep),1 do
			if Arr_AreaListStep[x]~=nil and Arr_AreaListStep[x][y]~=nil and (Arr_AreaListStep[x][y-1]~=nil or Arr_AreaListStep[x][y]~=Arr_AreaListStep[x][y-1]) then
				for i=x,table.getn(Arr_AreaListStep),1 do
					if Arr_AreaListStep[i]~=nil and Arr_AreaListStep[i][y]~=nil then findroomAreaList=findroomAreaList..">" end
					if Arr_AreaListStep[i]~=nil and Arr_AreaListStep[i][y]~=nil then findroomAreaList=findroomAreaList..Arr_AreaListStep[i][y] end
				end
				break
			end
		end
	end
	findroomAreaList=string.gsub(string.gsub(findroomAreaList,"zzzzguohe","guohe"),"|>","|")
	--print(findroomAreaList)
	return findroomAreaList
end
function xkxGPS.SortArealist(a)
	if a==nil then a="" end
	local Arr_AreaList=utils.split(string.gsub(a,"guohe","zzzzguohe"),"|")
	table.sort(Arr_AreaList)
	local SortArealist=""
	for i=1,table.getn(Arr_AreaList),1 do
		if i>1 then SortArealist=SortArealist.."|" end
		SortArealist=SortArealist..Arr_AreaList[i]
	end
	Arr_AreaList=string.gsub(SortArealist,"zzzzguohe","guohe")
	return Arr_AreaList
end
function xkxGPS.findroomno(a,b)
	alias.ceilneili()
	xkxGPS.connectDB()
	local str2=""
	local sql="SELECT distinct RoomNO,ZoneNO FROM Room WHERE roomname='"..a.."'"
	for row in conn:nrows(sql) do
		if b=="none" or (b~="none" and findstring(row["ZoneNO"],b)) then
			if str2=="" then str2=row["RoomNO"] else str2=str2.."|"..row["RoomNO"] end			
		end
	end
	return str2
end
function xkxGPS.getnextroomno(a,b)
	alias.ceilneili()
	xkxGPS.connectDB()
	local str2=0
	local sql="SELECT LinkRoomNo FROM Entrance WHERE RoomNo="..tostring(a).." AND Direction='"..tostring(b).."'"
	for row in conn:nrows(sql) do
		str2=tonumber(row["LinkRoomNo"])
	end
	return str2
end
function xkxGPS.findroomnpc(a,b)
	alias.ceilneili()
	xkxGPS.connectDB()
	local str2=""
	local sql="SELECT distinct RoomNO,ZoneNO,famousnpc FROM Room WHERE famousnpc<>''"
	for row in conn:nrows(sql) do
		if b=="none" or (b~="none" and findstring(row["ZoneNO"],b)) then
			if string.find(row["famousnpc"],a) then
				if str2=="" then str2=row["RoomNO"] else str2=str2.."|"..row["RoomNO"] end
			end
		end
	end
	return str2
end
function xkxGPS.EndRoomInfo(EndRoomNo)
	alias.ceilneili()
	xkxGPS.connectDB()
	local links={}
	local sql="SELECT roomname,Entrance FROM Room WHERE RoomNO="..EndRoomNo
	xkxGPS.EndRoomName=""
	xkxGPS.EndRoomEntrance="#"
	for row in conn:nrows(sql) do
		xkxGPS.EndRoomName=row["roomname"]
		xkxGPS.EndRoomEntrance="#"..row["Entrance"].."#"
	end
end
-- 广度优先算法寻路
function xkxGPS.search(startid, endid)
	alias.ceilneili()
	if startid==endid then
		return "isHere"
	end
	local searchedRoom={}			-- 存放已经搜索过的房间ID
	local queue={}						-- 待处理的队列
	local queueT={}
	
	startid=tonumber(startid)
	endid=tonumber(endid)
	xkxGPS.EndRoomInfo(endid)
	
	table.insert(queue, startid)							-- 把初始房间加入到待处理队列中
	queueT[startid]={}
	queueT[startid]["Direction"]="none"
	queueT[startid]["RoomNo"]=0

	while table.getn(queue)>=1 do												-- 循环待处理房间队列
		local nowid=queue[1]
		table.remove(queue, 1)														-- 从队列取出第一个房间ID,并从队列中删除，并放入已经处理过的队列
		searchedRoom[nowid]=1
		local links=xkxGPS.Forward_Search(nowid)								-- 取得当前房间的所有出口信息
		--if nowid==1520 then
		--print("房间"..nowid.."所有出口为：")
		--tprint(links)
		--end
		table.foreachi(links, function(i, link)									-- 循环当前房间的每一个出口
			if searchedRoom[link["LinkRoomNo"]]==nil and queueT[link["LinkRoomNo"]]==nil then	-- 如果目标房间没有被处理过，加到待处理房间队列里
				table.insert(queue, link["LinkRoomNo"])
				queueT[link["LinkRoomNo"]]={}
				queueT[link["LinkRoomNo"]]["Direction"]=link["Direction"]
				queueT[link["LinkRoomNo"]]["RoomNo"]=nowid
			end
		end)
		if queueT[endid]~=nil then
			break
		end
	end
	-- tprint(queueT)
	-- 反向从队列里面找出路径
	nowid=endid
	local path={}
	while nowid~=startid do
		if queueT[nowid]==nil then
			path=nil
			break
		end
		if queueT[nowid]["Direction"]=="none" then
			break
		end
		table.insert(path, 1, queueT[nowid]["Direction"])
		nowid=queueT[nowid]["RoomNo"]
	end
	if path~=nil then path = table.concat(path, ";") end
	return path
end
-- 向前搜索一步
function xkxGPS.Forward_Search(RoomNo)
	xkxGPS.connectDB()
	local links={}
	local sql="SELECT LinkRoomNo,Direction,ID FROM Entrance WHERE RoomNo='"..RoomNo.."' and "..xkxGPS.EntranceCondition
	-- if RoomNo==1520 then print(sql) end
	-- print(sql)
	for row in conn:nrows(sql) do
		table.insert(links, row)
	end
	return links
end

