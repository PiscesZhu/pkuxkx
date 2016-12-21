---------------------------------------------------------------------------
-- File name   : system.lua
-- Description : 系统函数部份，有很多有用的函数在里面
--
-- Author: Michen (xmichen@gmail.com)
-- Version:	2014.05
---------------------------------------------------------------------------

require "wait"

logable=true
cmd_limit=18
logdelaysec=1
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
flag_base=1064
flag_base_enable=1065
flag_base_temp=1065+trigger_flag.Temporary
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
addtri=function(triname,trimatch,trigroup,triscript,triflag,trisequence)
	if triflag==nil or triflag=="" then triflag=flag_base end
	if trisequence==nil then trisequence=10 end
	trireturnvalue=AddTriggerEx(triname, trimatch, "", triflag, -1, 0, "",  triscript, 0, trisequence)
	SetTriggerOption(triname,"group",trigroup)

	return trireturnvalue
end

addtri_sts=function(triname,trimatch,trisendtext,trigroup,triflag)
	if triflag==nil then triflag=flag_base end
	trireturnvalue=AddTriggerEx(triname, trimatch, trisendtext, triflag, -1, 0, "",  "", 12, 10)

	SetTriggerOption(triname,"group",trigroup)

	return trireturnvalue
end

addtemptri=function(triname,trimatch,trigroup,triscript)
	addtri(triname,trimatch,trigroup,triscript,flag_base_temp)
end

addali=function(aliname,alimatch,aligroup,aliscript)
	alireturnvalue=AddAlias(aliname,alimatch,"",alias_flag.Enabled + alias_flag.Replace,aliscript)
	SetAliasOption(aliname,"group",aligroup)
	return alireturnvalue
end
addali_reg=function(aliname,alimatch,aligroup,aliscript)
	alireturnvalue=AddAlias(aliname,alimatch,"",alias_flag.Enabled + alias_flag.Replace+ alias_flag.RegularExpression,aliscript)
	SetAliasOption(aliname,"group",aligroup)
	return alireturnvalue
end


---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
deltri=function(triname)
	DeleteTrigger(triname)
end
deltrigp=function(groupname)
DeleteTriggerGroup (groupname)
end

linktri=function(triggerlist)
	local _str=""
	if triggerlist~=nil then
		for k,v in pairs(triggerlist) do
			_str=_str..v.."\\w*|"
		end

		_str="^(> > |> |)("..rtrim("|",_str)..")"
		----_str="^(> |)"..rtrim("|",_str)
	else
	print("system::>>Triggerlist is error")
	end
	return _str
end

delali=function(triname)
	DeleteAlias(triname)
end
delaligp=function(groupname)
	DeleteAliasGroup(groupname)
end
addvar=function(varname,def_value)
	if GetVariable(varname)==nil then
		SetVariable(varname,def_value)
	end
end
---------------------------------------------------------------------------------
---------------------------------------------------------------------------------
catch=function(trigrp,command)
	trigrpon(trigrp)
	run(command)
	trigrpoff(trigrp)
end

function busytest(busyfinish,t,...)
	if t==nil then t=0.3 end
		busytestdelay=t
	_b={}
	_b=busy.new()
	_b.interval=t

	_b.args={}
	for _, v in ipairs{...} do
		table.insert(_b.args, v)
	end --for

	_b.finish=function()
		busyfinish(unpack(_b.args))
	end

	_b:check()
end

delay=function(t,delayfinish,...)

	if t==nil then t=1 end

	_d={}
	_d.args={}
	for _, v in ipairs{...} do
		table.insert(_d.args, v)
	end --for

	_d.fun=function()
		busytest(delayfinish,0.2,unpack(_d.args))
	end
	DeleteTemporaryTimers()
		Note("Delay "..t.." seconds to be continue.")
		DoAfterSpecial(t,"_d.fun()",12)
end

waitendcmd="set no_more waitend"
waitend=function(t,waithook,...)

if t==nil then t=1 end

	_waitd={}
	_waitd.args={}
	for _, v in ipairs{...} do
		table.insert(_waitd.args, v)
	end --for

	wait.make(function()
	run(waitendcmd)
		local l,w=wait.regexp('^.*设定环境变量：no_more = "waitend"$',t+2)
		if l==nil then
		print("Error::waitend...>>catch nil")
			waitend(t,waithook,unpack(_waitd.args))
		return
		end
		if string.find(l,"waitend") then
		print("::>>Waiting....["..t.."s] to be continue..::<<")
		wait.time(t)
		waithook(unpack(_waitd.args))
		return
		end
		print("Error::000000")
		waitend(t,waithook,unpack(_waitd.args))
		wait.time(t+2)
	end)

end

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
	----useage:
	----stings="abcde"
	----list={"abcde","abadf"}
	-----findstring(strings,"abcde","abadf")===>return true
	if str==nil then return false end

	local compare_str=false
	for _, v in pairs(list) do
		compare_str=compare_str or string.find(str,v)
	end --for
	return compare_str
end

function findinlist(str,list)
	----useage:
	----stings="abcde"
	----list={"abcde","abadf"}
	-----findstring(strings,"abcde","abadf")===>return true
	if str==nil then return false end

	local compare_str=false
	for _, v in pairs(list) do
		compare_str=compare_str or str==v
	end --for
	return compare_str
end
------------------------------------------------------

----------******************************************************
----------******************************************************

busy={
  interval=0.1,
  timeout=10,
  new=function()
     local b={}
	 setmetatable(b,{__index=busy})
	 return b
 end,
}

function busy:finish()
end
checkcmd="suicide -1;set no_more busy"

function busy:check()
	 wait.make(function()
	  run(checkcmd)
      local l,w=wait.regexp('^.*(如果真的想永远自杀，请输入\\w*|设定环境变量：no_more = "busy"$)',self.timeout) --超时
      if l==nil then
		print "网络太慢或是发生了一个非预期的错误"
		self:check()
		return
	  end
	  if string.find(l,"如果真的想永远自杀，请输入") then
		 self:finish()
	     return
	  end
	  if string.find(l,'设定环境变量：no_more = "busy"') then
		if hooks.isbusy~=nil then
	    ---- local f=function() self:check() end
		 ----f_wait(f,self.interval)
		  wait.time(self.interval)
			----print("::You're Busy now::")----2012.01.04 debug is okey!!
		  self:check()
		end
	    return
	  end
      wait.time(self.timeout) --timeout
   end)
end

local wait_table = {}
--setmetatable(wait_table, {__mode = "v"}) --weak table
-- 被定时器调用以恢复一个暂停的线程
function wait_timer_resume(name)
  --print(table.getn(wait_table))
  --print("wait_id: ",name)
  thread = wait_table[name]
  if thread~=nil then
    assert(coroutine.resume (thread))
  else
    print(name," 不存在")
  end -- if
  wait_table[name]={}  --垃圾回收
end -- function wait_timer_resume
-- 在脚本中调用这个函数来暂停当前的线程
function f_wait(address, seconds)
  id = "wait_timer_" .. GetUniqueNumber ()
  hours = math.floor(seconds / 3600)
  seconds = seconds - (hours * 3600)
  minutes = math.floor(seconds / 60)
  seconds = seconds - (minutes * 60)
  --print("等待",seconds,"s"," ",id)
  wait_table[id] =coroutine.create(function()
    -- print("执行")
     address()
  end)
  status = AddTimer (id, hours, minutes, seconds, "",
            timer_flag.Enabled + timer_flag.OneShot +
            timer_flag.Temporary + timer_flag.Replace,
            "wait_timer_resume")
  assert(status == error_code.eOK, error_desc[status])
end -- function wait

function waitf(seconds,waithook,...)
  id = "wait_timer_" .. GetUniqueNumber ()
  hours = math.floor(seconds / 3600)
  seconds = seconds - (hours * 3600)
  minutes = math.floor(seconds / 60)
  seconds = seconds - (minutes * 60)
  --print("等待",seconds,"s"," ",id)
	--[[
  	_waitf={}
	_waitf.args={}
	for _, v in ipairs{...} do
		table.insert(_waitf.args, v)
	end --for
	--]]
Note("::>>Waiting....["..seconds.."s] to be continue..::<<")
hook(hooks.waitend,waithook,...)
    --- fname(unpack(_waitf.args))
  wait_table[id] =coroutine.create(function()
    -- print("执行")
	callhook(hooks.waitend,true)
  end)
  status = AddTimer (id, hours, minutes, seconds, "",
            timer_flag.Enabled + timer_flag.OneShot +
            timer_flag.Temporary + timer_flag.Replace,
            "wait_timer_resume")
  assert(status == error_code.eOK, error_desc[status])
end -- function wait

----------************************************************************************************************************
----------************************************************************************************************************
------------------------------------------------------
------------------------------------------------------
system={}
------------------------------------------------------
system.ishere=function(n,l,w)
	_roomname=w[1]
	--print(w[1])
	if _roomname~=nil then
	SetVariable("roomname",_roomname)
	end
end
------------------------------------------------------

trigrpoff=function(str)
	run("set no_more trigrpoff "..str)
end
system.trigrpoff=function(name, line, wildcards)
		EnableTriggerGroup(wildcards[3],false)
end

trigrpon=function(str)
	run("set no_more trigrpon "..str)
end
system.trigrpon=function(name, line, wildcards)
		EnableTriggerGroup(wildcards[3],true)
end


system.infoend=function(name, line, wildcards)
	callhook(hooks.infoend,true)
end
system.waitend=function(name, line, wildcards)
	callhook(hooks.waitend,true)
end
system.nobody=function()
	npc.ishere=0
	Note("::NPC is Not here::")
end
---------------------------------------------------
infoend=function(func,...)
	hook(hooks.infoend,func,...)
	run("set no_more infoend")
end

_stop=false
runre=rex.new("([^;*\\\\]+)")
run=function(str)
	ResetTimer("on_steptimeout")
	if ((str=="")or(str==nil)) then return end
	SetSpeedWalkDelay(math.floor(1000/cmd_limit))
	_cmds={}
	local i=0
	n=runre:gmatch(str,function (m, t)
		i=i+1
		_cmds[i]=m
	end)
	if (_cmds==nil) then return end
	for i, cmd in pairs (_cmds) do
		if cmd=="#gift" then
			if chatroom~=nil then
				cmd="enter "..chatroom
			end
		end
		Queue(cmd,0)
		if walkecho==true then Note(cmd) end
	end
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
	for i=#str -2 ,0,-2 do
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
	return result
end

	itemnumre=rex.new("(((零|一|二|三|四|五|六|七|八|九|十|百|千|万)*)(支|顶|块|朵|面|匹|位|支|颗|个|把|只|粒|张|枚|件|柄|根|块|文|两|碗|滴)){0,1}(.*)")

getitemnum=function(str)
	num=1
	a,b,matchs=itemnumre:match(str)
	if matchs~=nil then
		if matchs[2]~=false then
			num=ctonum(matchs[2])
			str=matchs[5]
		end
	end
	return str,num
end


getnum=function(num)
	if (num==nil) then num=0 end
	return num
end
system.allstop=function()
	--if walking~=nil then walking["end"]() end
	inittri()
	--initweapon()
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
end
system.look2=function()
	if onbianli==1 then
	EnableTrigger("bianli_searchexits",1)
	end
	DoAfterSpecial(0.3,'Execute("look")',12)
end
system.look2cmd=function()
	Execute("look")
end
system.haltcmd=function()
	Execute("halt")
end

-----------------------------------------
system.update=function()

	addtri("system_isbusy","^(> |)(你上一个动作还没完成\\w*|你现在正忙\\w*|你正忙\\w*|战斗中不能自杀\\w*|你正忙着呢\\w*)","system","")
	addtri("system_infoend",'^(> |)\\s*设定环境变量：no_more = "infoend"$',"system","system.infoend")
	----addtri("system_waitend",'^(> |)\\s*设定环境变量：no_more = "waitend"$',"system","")
	addtri("system_busy","^(> |)\\s*设定环境变量：no_more\\w*","system","")
	addtri("system_isbusy2","^(> |)\\(\\s*你上一个动作还没有完成\\w*","system","")

	addtri("system_trigrpoff",'^(>)*( )*设定环境变量：no_more = "trigrpoff (.*)"$',"system","system.trigrpoff")
	addtri("system_trigrpon",'^(>)*( )*设定环境变量：no_more = "trigrpon (.*)"$',"system","system.trigrpon")

	addtri("system_haltcmd","^(>)*( )*你无法在战斗中专心下来\\w*","system","system.haltcmd")

	addtri("system_nobusy","^.*(如果真的想永远自杀，请输入\\w*|你现在不忙\\w*|你不忙\\w*|你不忙$)","system","")


	----addtri("system_look2","^(>)*( )*风景要慢慢的看\\w*","system","system.look2")
	addtri("system_nobody2","^(>)*( )*你想[要]*收.+为弟子\\w*","system","")
	addtri("system_nobody",'^(>)*( )*设定环境变量：no_more = "nobody"$',"system","")


	----addtri("system_locate","^(> |)\\s+(.*)\\s+$","system","system.locate")

	SetTriggerOption("system_waitend","omit_from_output",1)
	SetTriggerOption("system_busy","omit_from_output",1)
	SetTriggerOption("system_isbusy","omit_from_output",1)
	SetTriggerOption("system_isbusy2","omit_from_output",1)
	SetTriggerOption("system_infoend","omit_from_output",1)
	SetTriggerOption("system_trigrpoff","omit_from_output",1)
	SetTriggerOption("system_trigrpon","omit_from_output",1)
	SetTriggerOption("system_nobusy","omit_from_output",1)

	SetTriggerOption("system_look2","omit_from_output",1)
	SetTriggerOption("system_nobody","omit_from_output",1)
	SetTriggerOption("system_nobody2","omit_from_output",1)
InfoClear()
end

print("Loading System mod ok!")
AddAlias("alias_allstop","#allstop","",alias_flag.Enabled + alias_flag.Replace + alias_flag.RegularExpression,"system.allstop")
------SetAliasOption(BSTR AliasName, BSTR OptionName, BSTR Value);

SetAliasOption("alias_allstop","group","system")

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

opposite_dir=function(dir)
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

function do_quit()
	local msg_tri={
		"欢迎下次再来！",
		"开始退出游戏，进行中……",
		"游戏退出进程已经启动，正在进行中！",
		"你现在正忙着做其他事，不能退出游戏！",
		"杀人后想逃离现场？没门儿！",
	}

	local _ftri=linktri(msg_tri)
	run("halt;quit;yun recover;yun refresh;hp")
	wait.make(function()
		local l,w=wait.regexp(_ftri,2)
		if l==nil then
			do_quit()
			return
		end
		if findstring(l,msg_tri[1]) then
			return
		end
		if findstring(l,msg_tri[2],msg_tri[3],msg_tri[4],msg_tri[5]) then
			do_quit()
			return
		end
	end)
end
