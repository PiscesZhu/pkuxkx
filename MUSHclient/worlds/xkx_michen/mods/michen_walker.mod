---------------------------------------------------------------------------
-- File name   : michen_walker.lua
-- Description : 自动行走部份，直接用的kiss的数据库，修改了数据库的编码、
--						增加了GUMU地图，感谢kiss
--						
--
-- Author: Michen (xmichen@gmail.com)
-- Version:	2014.05
---------------------------------------------------------------------------

--[[
--GPS模块思路：
	1.使用寻路算法找出两点间最短路径
	2.取出前X个路径(或者第一个特殊路径之前的部份)，行走
	3.处理特殊路径，循环2-3，一直到走完
	4.走完之后判断是不是走到了(白天才能进的房间要不要等？)
--]]

print("Loading Michen Walker mod OK!")

------------------------------------------------------------------------------
----**************************************************************************
walk={
	endroomno=0,
	path="",
}

walkgo={}
--Setkeyboardon=0
wait_step=17					----每走多少步系统自动插入#wa wait_step_time。
									----若为0，默认20步插入一条此命令。
									----若为-1则不插入，关闭快速行走，开启慢速行走。
wait_step_time=500		----系统自动插入的暂停时间间隔的毫秒。
walktime=0.3				----采用慢速行走后wait_step=-1，自定义每一步行走的间隔时间：默认为0.1秒。
									----注意：这里直接设定的是秒。

function walk:finish() end
function walk:fail() end

do_walkgo=function(roomno,walk_ok,walk_fail)
	if walk_ok~=nil then
		walk.finish=function()
			walk_ok()
		end
	else walk.finish=nil end
	if walk_fail~=nil then
		walk.fail=function()
			walk_fail()
		end
	else walk.fail=nil end
	
	walk.endroomno=roomno

	getroom(walk_get_path)
end

function walk_get_path()
	print(getpath(walk.endroomno))
end

function getpath()
	roomno_now=0
	roomno_now=location()		-- 从地图数据库取得当前房间位置
	if roomno_now<=0 then
		print("没有找到当前房间所在位置："..roomno_now)
		run(roominfo["exits"][1]..";look")
		delay(2,getpath)
		--if walkgo_end_fail~=nil then call(walkgo_end_fail) end
		return
	else
		print("找到当前位置的房间号为："..roomno_now)
	end
	if roomno_now==walk.endroomno then
		print("你已经在这里啦，还飞什么飞？")
		if walkgo_end_ok~=nil then call(walkgo_end_ok) end
		return
	end
	walk.path=search(roomno_now,walk.endroomno)
	local f=function() go_walk(walk.path) end
	busytest(f)
end

walkgo_end_ok=function()
	call(walk.finish)
end
walkgo_end_fail=function()
	call(walk.fail)
end
walkgo.blocker=function()
	walk.meetblocker=1
	---print("::meetblocker::")---debug
end

-----****************************************************----
-----****************************************************----
go_path_table={}
go_walk=function(path_strings,steptime)
	walk_step_count=0
	need_wait_time=0.1
	walk.needstop=0
	walk.meetblocker=0
	walk.needwait=0
	step_maxn=1
	if steptime==nil or steptime<=0.1 then step_wait_time=0.1 else step_wait_time=steptime end
	----------------------------------------
	fullpath_str,fullpath_steps,final_tb=convert_path(path_strings)
	if fullpath_str==nil or fullpath_str==" " then
		walk_time=0.1
		print("你没有这个搜索路线。")
		return
	end
	go_path_table=pathstr_t(final_tb)
	--tprint(go_path_table)			-- debug
	----------------------------------------
	step_maxn = table.getn(go_path_table)
	----------------------------------------
	if fullpath_str~=nil then
		print("当前行走步数："..fullpath_steps)
		print("路线为::>>"..fullpath_str.."<<::")
		run("set no_more walkgo")
		run("set brief 2")
	end
end
walk_slow=0
do_walk=function()
	if walk.needstop==1 then
		if walk_step_count==0 or walk_step_count==nil then walk_step_count=1 end
			print("=::>Mannual Stop Walk!::<==")
			walk.needstop=0
		return
	end
	----------------------------------------------
	walk_step_count = walk_step_count +1
	if walk.meetblocker==1 then
		--print("=::>Meet Blocker Pause Walk!::<==")
		walk_step_count = walk_step_count -1
		if walk_step_count==0 or walk_step_count==nil then walk_step_count=1 end
		walk.meetblocker=0
		--return
	end
	if walk_step_count<=step_maxn then
	----print("当前将走第【",walk_step_count,"】步。")---debug
	--------------------------------------------------------
		command_str=go_path_table[walk_step_count]
		if isSpecialcmd(command_str) then												-- 特殊命令处理
			alias.exec(command_str)
		elseif string.find (command_str,"walk_wait")~=nil then					-- wait命令处理
			loadstring(command_str)();
			DoAfterSpecial(need_wait_time,'run("set no_more walkgo")',12)
		else
			Execute("halt;"..command_str)													-- 正常命令处理
			DoAfterSpecial(step_wait_time,'run("set no_more walkgo")',12)
		end
	else
		fullpath_str=" "
		walk_step_count=0
		--run("unset brief")
		print("完成行走！！")
		roomno_now=walk.endroomno
		if walkgo_end_ok~=nil then call(walkgo_end_ok) end
	end
end
----------------------------------------
function walk_pause()
	walk.needstop=1
	print("======= Walk Pause!!======")
	--DeleteTemporaryTimers()
	if  walk_step_count == nil then walk_step_count=2 end
end
function checkbusy()
	EnableTriggerGroup("walkbusy",0)
    DoAfterSpecial(1,'EnableTriggerGroup("walkbusy",1)\nrun("checkbusy")',12)
end
function walk_busy(str)
	EnableTriggerGroup("walkbusy",1)
	walk_pause()
	Execute(str)
	DoAfterSpecial(1,'run("checkbusy")',12)
end
function walk_busyover()
	EnableTriggerGroup("walkbusy",0)
	walk_resume()
end
function path_pause(str)
	EnableTriggerGroup("path_pause",1)
	walk_pause()
	Execute(str)
end
function walk_wait(s)
	walk.needwait=1
	if fullpath_str ==nil then
			print("=====没有搜索路径!!=====")
			return
	end
	if s==nil or s*1<=0.1 then
	need_wait_time=0.1
	print("===Wait...".. 0.1 .." seconds continue===")
	else
	need_wait_time=s
	print("===Wait..."..s.." seconds continue===")
	end
end
function walk_resume()
DeleteTemporaryTimers()
print("======= Walk resume!!======")
	walk.needstop=0
	if fullpath_str ~=nil and walk_step_count <= step_maxn and walk_step_count~=0 then
	walk_auto_next();
	else
	print("=====已经到达终点或没有搜索路径!!=====")
	end
end
function walk_auto_next()
	run("set no_more walkgo")
end
do_walkstop=function()
	call(walk_pause)
end
do_walkresume=function()
	call(walk_resume)
end
-----**************************************************************--------
-----******行走控制模块 ***********结束****************************--------
-----**************************************************************--------

-----------------------------------------------------------------------------------------------------------------------------------------
-- ZMUD相关转化函数开始
-----------------------------------------------------------------------------------------------------------------------------------------
function convert_path(path_name)
	----全解析zmud字符串函数，形成路径字串、完整路线表及完整路线字符串。
	----解析路线中#wa 1000,yellboat等特殊指令。返回如下变量：
	--temp_path_string:全分解，单步zmud串
	--1、fullpath_str:  zmud缩略alias
	--2、fullpath_steps:全路线步数。
	--3、final_path_table:全分解，单步zmud串对应table
	if s_distance==0 then
	fullpath_str,temp_slow_path_table=decomp_string(path_name)
	else
	fullpath_str=path_name
	temp_slow_path_table=utils.split(path_name, ";")
	end
	if fullpath_str==nil then return nil end
	local i,v,maxstepsadd =1, table.maxn(temp_slow_path_table)*1, 0  --new add
    while i<=v do
        if string.sub (temp_slow_path_table[i], 1, 8)=="yellboat" then
            maxstepsadd=maxstepsadd+300
        end
        if string.find (temp_slow_path_table[i], "#[wW][aA]")~=nil then
            maxstepsadd=maxstepsadd+(string.match(temp_slow_path_table[i], "[0-9]+", 1)%100)*20
        end
        if string.sub (temp_slow_path_table[i], 1, 20)=="ask zhang about 扬州" and qiangold==0 then
            maxstepsadd=maxstepsadd+3000
        end
        if string.sub (temp_slow_path_table[i], 1, 26)=="ask qian laoben about 进宫" and hgtongxing==1 then
            maxstepsadd=maxstepsadd+3000
		elseif string.sub (temp_slow_path_table[i], 1, 26)=="ask qian laoben about 进宫" and hgtongxing==0 then
			maxstepsadd=-20
        end
        i=i+1
    end --new add
	local i,v =1, table.maxn(temp_slow_path_table)*1
	while i<=v do
		if string.sub (temp_slow_path_table[i], 1, 8)=="yellboat" then
--			temp_slow_path_table[i]="walk_wait(0.5);yellboat;walk_wait(0.5)"
			temp_slow_path_table[i]="walk_wait(0.1);yellboat;walk_wait(0.1)"
			i=i+1
		else
			if string.find (temp_slow_path_table[i], "#[wW][aA]")~=nil then
				s_time=string.match (temp_slow_path_table[i], "[0-9]+", 1)
				--s_time=math.ceil(s_time/1000)
                                s_time=s_time/1000
				if s_time<=0.1 or s_time==nil then
				s_time=0.1
				end
				temp_slow_path_table[i]="walk_wait("..s_time..")"
				i=i+1
			else
				if string.sub (temp_slow_path_table[i], 0, 1)~="#" then
					i=i+1
				else
					n = string.match (temp_slow_path_table[i], "[1-9][0-9]?", 1)
					str = Trim(string.gsub(temp_slow_path_table[i],"[()#%d]?",""))
					str = Trim(string.gsub(str,"do",""))
					str_path=""
				for j=1,n do
					str_path=str_path..str..";"
				end
					temp_slow_path_table[i]=rtrim(";",str_path)
					i=i+1
				end
			end
		end
	end
	temp_path_string=table.concat(temp_slow_path_table,";")
	final_path_table=utils.split (temp_path_string, ";")
	maxsteps=table.maxn(final_path_table)+maxstepsadd
	return fullpath_str,maxsteps,final_path_table
end

pathstr_t=function(str_table)
----输入路线表格，返回按要求插入#wa 1000后的表。
----系统自动加入#wa 1000功能函数，可根据设置自行添加。
	if wait_step ==0 then wait_step =20 end
	if wait_step==-1 then return str_table end
	if wait_step_time~=nil and wait_step_time~=0 then
		--w_time=math.ceil(wait_step_time/1000)
		w_time=wait_step_time/1000
	else
		w_time=1
	end
	str_ins="walk_wait("..w_time..")"
	str_line=""
	str_count=0
	temp_str_table={}
	for k,v in pairs(str_table) do
		if string.sub (v, 1, 2)~="wa"and isSpecialcmd(v)== false then						-- 正常命令处理
			str_line=str_line..v..";"
			str_count=str_count+1
			if str_count>=wait_step and string.find(v,"room_skip")==nil then		-- 超过一次命令上限，或者是特殊命令
				str_line=rtrim(";",str_line)
				table.insert(temp_str_table,str_line)
				table.insert(temp_str_table,str_ins)
				str_count=0
				str_line=""
			end
		else																	-- #wa命令处理
			if #str_line ~= 0 then
				str_line=rtrim(";",str_line)
				table.insert(temp_str_table,str_line)
				str_count=0
				str_line=""
			end
				table.insert(temp_str_table,v)
		end
	end
	if #str_line~= 0 then
		str_line=rtrim(";",str_line)
		table.insert(temp_str_table,str_line)
	end
	return temp_str_table
end
-----------------------------------------------------------------------------------------------------------------------------------------
-- ZMUD相关转化函数结束
-----------------------------------------------------------------------------------------------------------------------------------------
walk.update=function()
	addtri("do_walk",'^(> |)设定环境变量：no_more = "walkgo"$',"system","do_walk")
	SetTriggerOption("do_walk","omit_from_output",1)
	EnableTrigger("do_walk",1)
end
walk.update()
-----------------------------------------------------------------------------------------------------------------------------------------
-- 地图相关通用函数
-----------------------------------------------------------------------------------------------------------------------------------------

function isSpecialcmd(cmd_name)
	for _,a in ipairs(alias.alias_table) do
	  if a.name==cmd_name then
		return true
	  end
   end
   return false
end

conn=nil
dbfile="xkxMAP.db"
room={
	name=nil,
	desc=nil,
	exits=nil,
}
EntranceCondition="condition is null"

function connectDB()
	if conn==nil then
		conn=assert(sqlite3.open(dbfile))
	end
end

function location()
	connectDB()
	local roomno=0
	local sql="SELECT distinct RoomNO FROM room WHERE Roomname='"..room["name"].."' and desciption='"..room["desc"].."' and entrance='"..room["exits"].."'"
	for row in conn:nrows(sql) do
		roomno=row["RoomNO"]
		break
	end
	if roomno==0 then
		sql="SELECT distinct RoomNO FROM room WHERE Roomname='"..room["name"].."' and entrance='"..room["exits"].."'"
		for row in conn:nrows(sql) do
			roomno=row["RoomNO"]
			break
		end
	end
	if roomno==0 then
		sql="SELECT distinct RoomNO FROM room WHERE Roomname='"..room["name"].."' and desciption='"..room["desc"].."'"
		for row in conn:nrows(sql) do
			roomno=row["RoomNO"]
			break
		end
	end
	if roomno==0 then
		sql="SELECT distinct RoomNO FROM room WHERE Roomname='"..room["name"].."'"
		for row in conn:nrows(sql) do
			roomno=row["RoomNO"]
			break
		end
	end
	return tonumber(roomno)
end

-- 广度优先算法寻路
function search(startid, endid)	
	if startid==endid then
		return "isHere"
	end
	local searchedRoom={}			-- 存放已经搜索过的房间ID
	local queue={}						-- 待处理的队列
	local queueT={}
	
	--EndRoomInfo(endid)
	
	table.insert(queue, startid)							-- 把初始房间加入到待处理队列中
	queueT[startid]={}
	queueT[startid]["Direction"]="none"
	queueT[startid]["RoomNo"]=0

	while table.getn(queue)>=1 do												-- 循环待处理房间队列
		local nowid=queue[1]
		table.remove(queue, 1)														-- 从队列取出第一个房间ID,并从队列中删除，并放入已经处理过的队列
		searchedRoom[nowid]=1
		local links=Forward_Search(nowid)								-- 取得当前房间的所有出口信息
		--print("房间"..nowid.."所有出口为：")
		--tprint(links)
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
	--tprint(queueT)
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
function Forward_Search(RoomNo)
	connectDB()
	local links={}
	local sql="SELECT LinkRoomNo,Direction,ID FROM Entrance WHERE RoomNo='"..RoomNo.."' and "..EntranceCondition
	for row in conn:nrows(sql) do
		table.insert(links, row)
	end
	return links
end

function findroomno(roomname, zone)
	connectDB()
	local roomno={}
	if zone==nil or zone=="" then zone="none" end
	local sql="SELECT distinct RoomNO, ZoneNO FROM Room WHERE Roomname='"..roomname.."'"
	for row in conn:nrows(sql) do
		if zone=="none" or zone==row["ZoneNO"]  then
			table.insert(roomno, row["RoomNO"])
		end
	end
	--tprint(roomno)
	return table.concat(roomno, "|")
end

function findsafeexit(roomno)
	connectDB()
	local exits=nil
	local sql="SELECT Entrance, EntranceSafe FROM Room WHERE RoomNO='"..roomno.."'"
	for row in conn:nrows(sql) do
		if row["EntranceSafe"]~=nil and row["EntranceSafe"]~="" then
			exits=row["EntranceSafe"]
		else
			exits=row["Entrance"]
		end
	end
	return exits
end

function SafeEntrance(roomno)
	local exits=findsafeexit(roomno)
	if exits==nil then
		return nil
	else
		return exits[1]
	end
end

function findnpcinroom(npcname)
	connectDB()
	local roomno={}
	local sql="SELECT distinct RoomNO,famousnpc FROM Room WHERE famousnpc != ''"
	for row in conn:nrows(sql) do
		local npcs=utils.split(row["famousnpc"],"|")
		table.foreachi(npcs, function(i,v)
			if v==npcname then
				table.insert(roomno, row["RoomNO"])
			end
		end)
	end
	--tprint(roomno)
	return table.concat(roomno, "|")
end

function fjarea(place)
	local r={name=place,zone="none",}
	table.foreachi(region_names, function(i, v)
		local t=string.sub(place, 1, string.len(v))
			if t==v then
				r={
					name=string.sub(place,string.len(v)+1),
					zone=v,
				}
			end
	end)
	return r
end

gps_goto=function(n,l,w)
	--[[
	if w[1]==nil then
		print("命令格式： goto [房间名|房间ID] [区域名]")
		print("例： ")
		print("goto 985")
		print("goto 武庙 ")
		print("goto 中央广场 扬州")
	end
	--]]
	if tonumber(w[1])~=nil then
		do_walkgo(tonumber(w[1]))
	else
		local roomno=nil
		if w[2]~=nil then
			roomno=findroomno(w[1], w[2])
		else
			roomno=findroomno(w[1])
		end
		print(roomno)
		if roomno==nil or roomno=="" then
			print("房间没找到！")
			return
		end
		if string.find(roomno,"|") then
			print("找到多于一条记录，请直接goto id："..roomno)
			return
		else
			do_walkgo(tonumber(roomno))
		end
	end
end
AddAlias("alias_walk","goto (\\S+)\\s*(\\S*)$","",alias_flag.Enabled + alias_flag.Replace + alias_flag.RegularExpression,"gps_goto")
SetAliasOption("alias_walk","group","walk")

--[[
古墓地图更新
UPDATE Room SET Entrance='out|westdown', EntranceSafe='out' WHERE RoomNO=641;
INSERT INTO Entrance VALUES('gumuenter',4408,2060,641,'');
INSERT INTO Room VALUES('在地下潜流中,你只觉得水声轰轰,身子不由自主的被强大的水流向前','eastup|west','','','地下水道',2060,'古墓派',0);
INSERT INTO Entrance VALUES('eu',4409,641,2060,'');
INSERT INTO Entrance VALUES('w',4410,2061,2060,'');
INSERT INTO Room VALUES('在地下潜流中,你只觉得水声轰轰,身子不由自主的被强大的水流向前','east|westup','','','地下水道',2061,'古墓派',0);
INSERT INTO Entrance VALUES('e',4411,2060,2061,'');
INSERT INTO Entrance VALUES('wu',4412,2062,2061,'');
INSERT INTO Room VALUES('密道中乌漆妈黑，伸手不见五指，水面已升到了膝盖，并且不断上升','eastdown|westup','','','密道',2062,'古墓派',0);
INSERT INTO Entrance VALUES('ed',4413,2061,2062,'');
INSERT INTO Entrance VALUES('wu',4414,2063,2062,'');
INSERT INTO Room VALUES('密道中乌漆妈黑，伸手不见五指，但只觉越走越低，湿气也越来越重','eastdown|westup','','','密道',2063,'古墓派',0);
INSERT INTO Entrance VALUES('ed',4415,2062,2063,'');
INSERT INTO Entrance VALUES('wu',4416,2064,2063,'');
INSERT INTO Room VALUES('密道中乌漆妈黑，伸手不见五指，但只觉越走越低，湿气也越来越重','eastdown|up','','','密道',2064,'古墓派',0);
INSERT INTO Entrance VALUES('ed',4417,2063,2064,'');
INSERT INTO Entrance VALUES('u',4418,2065,2064,'');
INSERT INTO Room VALUES('室中也无特异之处，抬头仰望，但见室顶密密麻麻的写满了字迹符号，','down|up','','','石室',2065,'古墓派',0);
INSERT INTO Entrance VALUES('d',4419,2064,2065,'');
INSERT INTO Entrance VALUES('u',4420,2066,2065,'');
INSERT INTO Room VALUES('石室中放着五具石棺(guan)，其中两具石棺棺盖以密密盖着。据说放','east','','','石室',2066,'古墓派',0);
INSERT INTO Entrance VALUES('enterguan',4421,2067,2066,'');
INSERT INTO Entrance VALUES('e',4422,2068,2066,'');
INSERT INTO Room VALUES('你可以看到石棺底部有个可容一手的凹处，','out','','','棺',2067,'古墓派',0);
INSERT INTO Entrance VALUES('out',4423,2066,2067,'');
INSERT INTO Entrance VALUES('turnleft',4424,2065,2067,'');
INSERT INTO Room VALUES('这阴森森的走道，也不知道是通到哪ㄦ的。墙上的一枝小蜡烛，正哔','east|south|west','','','走道',2068,'古墓派',0);
INSERT INTO Entrance VALUES('w',4425,2066,2068,'');
INSERT INTO Entrance VALUES('s',4426,2069,2068,'');
INSERT INTO Entrance VALUES('e',4427,2070,2068,'');
INSERT INTO Room VALUES('由於古墓派只收女弟子，墓中也只有此一间休息室。室中几张石床上','north','','','弟子休息室',2069,'古墓派',0);
INSERT INTO Entrance VALUES('n',4428,2068,2069,'');
INSERT INTO Room VALUES('这大厅布置的极为简单，几张木椅和椅张桌子放在正当中，靠墙的椅','east|north|south|west','','','大厅',2070,'古墓派',0);
INSERT INTO Entrance VALUES('w',4429,2068,2070,'');
INSERT INTO Entrance VALUES('s',4430,2071,2070,'');
INSERT INTO Entrance VALUES('n',4431,2072,2070,'');
INSERT INTO Entrance VALUES('e',4432,2074,2070,'');
INSERT INTO Room VALUES('这里就是後堂了。只见堂上空空荡荡的没什麽陈设。几张椅子靠着墙','north','','','後堂',2071,'古墓派',0);
INSERT INTO Entrance VALUES('n',4433,2070,2071,'');
INSERT INTO Room VALUES('这阴森森的走道，也不知道是通到哪ㄦ的。墙上的一枝小蜡烛，正哔','east|north|south|west','north|south','','走道',2072,'古墓派',0);
INSERT INTO Entrance VALUES('s',4434,2070,2072,'');
INSERT INTO Entrance VALUES('n',4435,2073,2072,'');
INSERT INTO Room VALUES('这阴森森的走道，也不知道是通到哪ㄦ的。墙上的一枝小蜡烛，正哔','east|south|west','south','','走道',2073,'古墓派',0);
INSERT INTO Entrance VALUES('s',4436,2072,2073,'');
INSERT INTO Room VALUES('这阴森森的走道，也不知道是通到哪ㄦ的。墙上的一枝小蜡烛，正哔','north|south|west','','','走道',2074,'古墓派',0);
INSERT INTO Entrance VALUES('w',4437,2070,2074,'');
INSERT INTO Entrance VALUES('n',4438,2075,2074,'');
INSERT INTO Entrance VALUES('s',4439,2077,2074,'');
INSERT INTO Room VALUES('这里好像是个厨房。只见石室中的桌上放了些碗和碟子。墙角边堆满了','north|south','','','厨房',2075,'古墓派',0);
INSERT INTO Entrance VALUES('s',4440,2074,2075,'');
INSERT INTO Entrance VALUES('n',4441,2076,2075,'');
INSERT INTO Room VALUES('这里是个蜂房。许多蜜蜂来来往往的飞来飞去，还有不少玉峰，看起来品','south','','','蜂房',2076,'古墓派',0);
INSERT INTO Entrance VALUES('s',4442,2075,2076,'');
INSERT INTO Room VALUES('这石室形状甚是奇特，北窄南宽，成为梯形，东边半圆，西边却作','east|north','','','练功室',2077,'古墓派',0);
INSERT INTO Entrance VALUES('n',4443,2074,2077,'');
INSERT INTO Entrance VALUES('e',4444,2078,2077,'');
INSERT INTO Room VALUES('这石室和西边那石室是处处对称，ㄦ又处处相反，乃是北宽南窄，西圆东角,','west','','','练功室',2078,'古墓派',0);
INSERT INTO Entrance VALUES('w',4445,2077,2078,'');
UPDATE Entrance set Condition=null WHERE ID>=4408 and ID<=4445;
--]]
