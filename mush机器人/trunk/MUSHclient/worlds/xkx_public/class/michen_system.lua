require "tprint"
require "wait"
cmd={
	nums=0,
	setnums=30,
}
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
flag_base=1064-------KeepEvaluating = 8,RegularExpression = 32,Replace = 1024
flag_base_enable=1065-------KeepEvaluating = 8,RegularExpression = 32,Replace = 1024,Enabled = 1
flag_base_temp=1065+trigger_flag.Temporary-------Temporary = 16384

function ltrim (r, s)
  if s == nil then
    s, r = r, "%s+"
  end
  return (r.gsub (s, "^" .. r, ""))
end

function rtrim (r, s)
  if s == nil then
    s, r = r, "%s+"
  end
  return (r.gsub (s, r .. "$", ""))
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
addtri=function(triname,trimatch,trigroup,triscript,triflag,trisequence)
		local 	flag_base=1064-------KeepEvaluating = 8,RegularExpression = 32,Replace = 1024
		local 	flag_base_enable=1065-------KeepEvaluating = 8,RegularExpression = 32,Replace = 1024,Enabled = 1
		local 	flag_base_temp=1065+trigger_flag.Temporary-------Temporary = 16384

			if triflag==nil or triflag=="" then triflag=flag_base_enable end
			if trisequence==nil then trisequence=10 end
			if type(triscript)=="string"	then
						tri_returnvalue=check(AddTriggerEx(triname, trimatch, "", triflag, -1, 0, "",  triscript, 0, trisequence))
			end
			if type(triscript)=="function"	then
		
				local Addtri_fun = "addtri_" .. GetUniqueNumber ()
				_G [Addtri_fun] = triscript
				tri_returnvalue=check(AddTriggerEx(triname, trimatch, "", triflag, -1, 0, "",  Addtri_fun, 0, trisequence))
			end	
			SetTriggerOption(triname,"group",trigroup)
			return tri_returnvalue
end

addtri_multiline=function(triname,trimatch,trigroup,triscript,multiline)

			if triflag==nil or triflag=="" then triflag=flag_base_enable end
			if trisequence==nil then trisequence=10 end
			if type(triscript)=="string"	then
						tri_returnvalue=check(AddTriggerEx(triname, trimatch, "", triflag, -1, 0, "",  triscript, 0, trisequence))
			end
			if type(triscript)=="function"	then
		
				local Addtri_fun = "addtri_" .. GetUniqueNumber ()
				_G [Addtri_fun] = triscript
				tri_returnvalue=check(AddTriggerEx(triname, trimatch, "", triflag, -1, 0, "",  Addtri_fun, 0, trisequence))
			end	
			SetTriggerOption(triname,"group",trigroup)
			SetTriggerOption(triname,"multi_line", true)
			SetTriggerOption(triname,"lines_to_match", multiline)
			return tri_returnvalue
end

addtri_noecho=function(triname,trimatch,trigroup,triscript)

			local triflag=flag_base_enable
			local trisequence=10
			if type(triscript)=="string"	then
						tri_returnvalue=check(AddTriggerEx(triname, trimatch, "", triflag, -1, 0, "",  triscript, 0, trisequence))
			end
			if type(triscript)=="function"	then
		
				local Addtri_fun = "addtri_" .. GetUniqueNumber ()
				_G [Addtri_fun] = triscript
				tri_returnvalue=check(AddTriggerEx(triname, trimatch, "", triflag, -1, 0, "",  Addtri_fun, 0, trisequence))
			end	
			SetTriggerOption(triname,"group",trigroup)
			SetTriggerOption(triname,"omit_from_output",1)
			return tri_returnvalue
end
isopen=function(trigroup)
	if GetTriggerList() ~= nil then
		for k,v in pairs(GetTriggerList()) do
			if GetTriggerInfo(v,26)==trigroup then
				return GetTriggerInfo(v,8)
			end
		end
	end
	return false
end
function openclass(a)
	-- print("Open class：'"..a.."'")
	EnableTriggerGroup(a,true)
	EnableTimerGroup(a,true)
end
function closeclass(a)
	-- print("Close class：'"..a.."'")
	EnableTriggerGroup(a,false)
	EnableTimerGroup(a,false)
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
linktri=function(triggerlist)
----说明：连接数字项表格个各个值成为trigger。
----此函数默认占用w[1]="",w[2]=全部表达式，列表中的参数从w[3]开始。
----括号开始的变量为w[2]=("..rtrim("|",_str)..")"，里面有()则为w[3]，第一个w[1]=""
	local _str=""
	if triggerlist~=nil then
		for k,v in pairs(triggerlist) do
			_str=_str..v.."\\w*|"
		end

		_str="^(> > > |> > |> |)("..rtrim("|",_str)..")"----括号开始的变量为w[2]=("..rtrim("|",_str)..")"，里面有()则为w[3]，第一个w[1]=""
		----_str="^(> |)"..rtrim("|",_str)
		----_str="^(.+|)("..rtrim("|",_str)..")"
	else
		print("[::System::]>>Error: function-->linktri arg 'triggerlist' is nil!!<<")
		return nil
	end
	return _str
end
linktri2=function(triggerlist)
----说明：连接数字项表格个各个值成为trigger。
----此函数默认占用w[1]="",w[2]=全部表达式，列表中的参数从w[3]开始。
----括号开始的变量为w[2]=("..rtrim("|",_str)..")"，里面有()则为w[3]，第一个w[1]=""
	local _str=""
	if triggerlist~=nil then
		for k,v in pairs(triggerlist) do
			_str=_str..v.."|"
		end

		_str="^(> > > |> > |> |)("..rtrim("|",_str)..")"----括号开始的变量为w[2]=("..rtrim("|",_str)..")"，里面有()则为w[3]，第一个w[1]=""
		----_str="^(> |)"..rtrim("|",_str)
		----_str="^(.+|)("..rtrim("|",_str)..")"
	else
		print("[::System::]>>Error: function-->linktri arg 'triggerlist' is nil!!<<")
		return nil
	end
	return _str
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function GetStyle(styleRuns,wantedColumn)
local currentColumn=1
   -- check arguments
   assert (type (styleRuns) == "table", "First argument to GetStyle must be table of style runs")

   assert (type (wantedColumn) == "number" and wantedColumn >= 1, "Second argument to GetStyle must be column number to find")

   -- go through each style
   for item, style in ipairs (styleRuns) do
     local position = wantedColumn - currentColumn + 1  -- where letter is in style
     currentColumn = currentColumn + style.length       -- next style starts here
     if currentColumn > wantedColumn then  -- if we are within this style
        return style, string.sub(style.text, position, position), item  -- done
     end -- if found column
   end -- for each style

   -- if not found: result is nil

end -- function GetStyle
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function findstring(str,...)
	----useage:
	----stings="abcde"
	-----findstring(strings,"a","b")===>return true
	if str==nil then return false end

	local compare_str=false
	for _, v in ipairs{...} do
		compare_str=compare_str or string.find(str,v)
	end --for
	return compare_str
end

function findstrlist(str,list)
-----print("::system::Debughere::")
	----useage:
	----stings="abcde"
	----list={"abcde","abadf"}
	-----findstring(strings,"abcde","abadf")===>return true
	if str==nil then return false end
	if list==nil then return false end
	
	local compare_str=false
	for _, v in pairs(list) do
		
		compare_str=compare_str or string.find(str,v)
		if compare_str==nil then compare_str=false end
		------print("compare_str in for ::",compare_str,v)
	end --for
	------print("compare_str",compare_str)
	return compare_str
end

function findstrlist2(str,list)
	if str==nil then return false end
	if list==nil then return false end
	local compare_str=false
	for _, v in pairs(list) do
		
		compare_str=compare_str or tostring(str)==tostring(v)
		if compare_str==nil then compare_str=false end
	end --for
	return compare_str
end
--str为需要分割字符串， p 为分割符
function strexplit(str, delim, maxNb)   
    -- Eliminate bad cases...   
    if string.find(str, delim) == nil then  
        return { str }  
    end  
    if maxNb == nil or maxNb < 1 then  
        maxNb = 0    -- No limit   
    end  
    local result = {}  
    local pat = "(.-)" .. delim .. "()"   
    local nb = 0  
    local lastPos   
    for part, pos in string.gmatch(str, pat) do  
        nb = nb + 1  
        result[nb] = part   
        lastPos = pos   
        if nb == maxNb then break end  
    end  
    -- Handle the last field   
    if nb ~= maxNb then  
        result[nb + 1] = string.sub(str, lastPos)   
    end  
    return result   
end

invDirection=function(dir)
	result=nil
	if dir=="east" then
		result="west"
	elseif dir=="south" then
		result="north"
	elseif dir=="west" then
		result="east"
	elseif dir=="north" then
		result="south"
	elseif dir=="southeast" then
		result="northwest"
	elseif dir=="southwest" then
		result="northeast"
	elseif dir=="northwest" then
		result="southeast"
	elseif dir=="northeast" then
		result="southwest"
	elseif dir=="northup" then
		result="southdown"
	elseif dir=="southdown" then
		result="northup"
	elseif dir=="southup" then
		result="northdown"
	elseif dir=="northdown" then
		result="southup"
	elseif dir=="eastup" then
		result="westdown"
	elseif dir=="eastdown" then
		result="westup"
	elseif dir=="westup" then
		result="eastdown"
	elseif dir=="westdown" then
		result="eastup"
	elseif dir=="up" then
		result="down"
	elseif dir=="down" then
		result="up"
	elseif dir=="enter" then
		result="out"
	elseif dir=="out" then
		result="enter"
	end
	return result
end

function ybfx(a)
	if a==nil then return ""
	elseif a=="eu" then return "eastup"
	elseif a=="e" then return "east"
	elseif a=="ed" then return "eastdown"
	elseif a=="se" then return "southeast"
	elseif a=="su" then return "southup"
	elseif a=="s" then return "south"
	elseif a=="sd" then return "southdown"
	elseif a=="sw" then return "southwest"
	elseif a=="wu" then return "westup"
	elseif a=="w" then return "west"
	elseif a=="wd" then return "westdown"
	elseif a=="nw" then return "northwest"
	elseif a=="nu" then return "northup"
	elseif a=="n" then return "north"
	elseif a=="nd" then return "northdown"
	elseif a=="ne" then return "northeast"
	elseif a=="d" then return "down"
	else return a end
end

_nums={}
_nums["一"]=1
_nums["二"]=2
_nums["三"]=3
_nums["四"]=4
_nums["五"]=5
_nums["六"]=6
_nums["七"]=7
_nums["八"]=8
_nums["九"]=9
ctonum=function(str)
	if (#str % 2) ==1 then
		return 0
	end
	result=0
	wan=1
	unit=1
	for i=#str-2 ,0,-2 do
		char=string.sub(str,i+1,i+2)
		if (char=="十") then
			unit=10*wan
			if (i==0) then
				result=result+unit
			elseif _nums[string.sub(str,i-1,i)]==nil then
				result=result+unit
			end
		elseif (char=="百") then
			unit=100*wan
		elseif (char=="千") then
			unit=1000*wan
		elseif (char=="万") then
			unit=10000*wan
			wan=10000
		else
			if _nums[char]~=nil then
				result=result+_nums[char]*unit
			end
		end
	end
	return tonumber(result)
end

runre=rex.new("([^;*\\\\]+)")
walkecho=true
allcmd={}
cmd_time=os.time()
cmd_flag=true
run=function(str)
	--if ((str=="")or(str==nil)) then return end
	local i=0
	local _cmd,_tb
	if str==nil then str="" end
	
	n=runre:gmatch(str,function (m, t)
		i=i+1
		table.insert(allcmd,1,m)
	end)
	
	--if cmd.nums==0 then cmd_time=os.time() end
	-----------------------------
	if (allcmd==nil) then return end
	for i=0,100000,1 do
		if cmd.nums<=20 then
			--print("开始执行命令。。。"..cmd.nums)--.."==="..tonumber(os.time()-cmd_time))
			_cmd=table.remove(allcmd)
			if _cmd==nil then break end
			local _t=string.gsub(_cmd,"-","")
			if findstring(_cmd,"xxpfm") then
				_tb=utils.split(_cmd," ")
				pcall(alias.xxpfm,_tb[2])
			else
				if aliasStepNum[_t]~=nil then Execute("/alias.".._t.."()") else Execute(_cmd);cmd.nums=cmd.nums+1 end
			end
		else
			-- 命令执行的太多了！！！
			--if cmd.nums>=1 and (os.time()-cmd_time)<=2 then
			-- if cmd.nums>=15 then
			if cmd_flag then
				--print("命令太多了，休息一会再继续。。。"..cmd.nums)--.."==="..tonumber(os.time()-cmd_time))
				cmd_flag=false
				DoAfterSpecial(1, 'cmd_flag=true;cmd.nums=0;run("")', 12)
			end
			--wait.make(function()
			--	local _f=function() cmd.nums=0;run("") end
			--	wait.time(1);_f()
			--end)
		end
	end
end
--[[
run=function(str)
	if ((str=="")or(str==nil)) then return end
	
	SetSpeedWalkDelay(math.floor(1000/20))
	--SetSpeedWalkDelay(0)
	
	_cmds={}
	local i=0
	
	n=runre:gmatch(str,function (m, t)
		i=i+1
		_cmds[i]=m
	end)
	-----------------------------
	if (_cmds==nil) then return end
	for i, _cmd in pairs (_cmds) do
		if _cmd=="#gift" then
			if chatroom~=nil then
				_cmd="enter "..chatroom
			end
		end
		local _t=string.gsub(_cmd,"-","")
		if aliasStepNum[_t]~=nil then Execute("/alias.".._t.."()") else Queue(_cmd,0);cmd.nums=cmd.nums+1 end
		if walkecho==true then Note(_cmd) end
	end
	cmd.nums=0
end]]
function additem(a,b)
	if b==nil or a==nil then return end
	if a==nil or a=="" then return b end
	if findstring(a,b) then return a end
	return a.."|"..b
end
function in_array(b,list)
	if not list then
		return false   
	end 
	if list then
		for k, v in pairs(list) do
			if v.tableName ==b then
				return true
			end
		end
	end
end
   
function addlog(a)
	local path,msg,f
	--path=GetInfo(56).."\\"..GetInfo(58)
	path=GetInfo(58)
	f=io.open(path.."account_"..me.charid.."_log.txt","a+")									--先打开文件a.lua（文件不存在会创建），
	if f~=nil then
		msg="["..os.date("%Y-%m-%d %H:%M:%S", os.time()).."]"..a
		f:write(tostring(msg).."\n")				--写到文件中
		f:close()
	end
	--AppendToNotepad("watching", tostring(me.charname)..tostring(msg).."\r\n")
	-- Info(tostring(me.charname)..tostring(msg))
end
--[[
function save_config()
	local path=string.gsub(GetInfo(35),"michen_xkx.lua","conf_"..me.charid..".lua")
	local f=io.open(path,"w+")
	local _tb={
		"setting",
		me={
			"falun",
			"drugbusy",
			"expadd",
		},
	}
	for k,v in pairs(_tb) do
		print(k,v)
		f:write(write_config_type(k,v).."\n")
	end
	f:close()
end
function write_config_type(k,v)
	if tonumber(_G[v])~=nil or type(_G[v])=="boolean" then
		return k.."="..tostring(_G[v])
	end
	if type(_G[v])=="string" then
		return k.."=\"".._G[v].."\""
	end
	if type(_G[v])=="table" then
		local msg=""
		msg=k.."={\n"
		for i,j in v do
			msg=msg.."\t"..write_config_type(i,j)..","
		end
		msg=msg.."}"
	end
end
save_config()
]]




