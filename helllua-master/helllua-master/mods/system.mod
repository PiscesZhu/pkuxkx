logable=true

logdelaysec=1
on_disconnect=function()
	if walking~=nil then
		--call(walking["end"])
	end
	EnableTimer("keepidle",false)
	hook(hooks.isbusy,nil)
	if ((logable==true)and(not(quest.stop and (quest.name~="mq" or masterquest.die~=false)))) then
		AddTimer("login",0,0,logdelaysec,"",17441,"onconnect")
	end
	logdelaysec=1
end

onconnect=function()
	if IsConnected() then
		EnableTimer("login",false)
	else
		Connect()
	end
end

idre=rex.new("^.*\\\\(?<id>[^-.]+)(-(?<passwd>[^-.]+)){0,1}")
getidpass=function()
	if me.id==nil or me.id=="" then
		s,e,t=idre:match(GetInfo(54))
		if t==nil then return end
		me.id=t.id
		if t.passwd then me.passwd=t.passwd end
	end
end
login=function()
	_passwd=GetVariable("passwd")
	if GetVariable("id")~=nil and GetVariable("id")~=""then
		me.id=GetVariable("id")
	end
	if (_passwd==nil)or(_passwd=="") then
		if me.passwd ~=nil then
			_passwd=me.passwd
		else
			print("无法找到密码设置.\n注意,请修改mcl文件为 你的帐号名.mcl 或者 你的帐号-你的密码.mcl\n比如bao.mcl或者 bao-123456.mcl.\n如果文件名中没有密码信息,请在变量passwd中设置.")
			return
		end
	end
	Send(me.id)
	Send(_passwd)
	Send("y")
end

system_login=function(name, line, wildcards)
	getidpass()
	EnableTriggerGroup("log",true)
	if (not logable) then return end
		login()
end

logdelay=function(n,l,w)
	print("十秒后登陆,请稍等")
	logdelaysec=10
end
system_logok=function(name,line,wildcards)

	logable=true
	EnableTriggerGroup("log",false)
	print("检测自动运行状态")
	if _hooklist[hooks.logok]~=nil then
		callhook(hooks.logok,true)
	else
		resume()
	end

end

on_steptimeout=function()
	callhook(hooks.steptimeout)
end

on_hurt=function(name,line,wildcards)
	callhook(hooks.hurt)
end

recon=function()
	DiscardQueue()
	Disconnect()
	DeleteTemporaryTimers()
	on_disconnect()
end

on_faint=function(name,line,wildcards)
	if hashook(hooks.faint) then
		callhook(hooks.faint)
	else
		recon()
	end
end

on_faint1=function(name,line,wildcards)
	if hashook(hooks.faint1) then
		callhook(hooks.faint1)
	else
		discon()
	end
end

discon=function()
	logable=false
	if posioned then
		logable=false
	end
	Disconnect()
end

catch=function(trigrp,command)
	trigrpon(trigrp)
	run(command)
	trigrpoff(trigrp)
end
busytestdelay=1
busytestcmd="enchase bao"
busytest=function(busyhook,t,...)
	if t==nil then t=1 end
	busytestdelay=t
	if hashook(hooks.isbusy) then
		hook(hooks.isbusy,busyhook,...)
	else
		hook(hooks.isbusy,busyhook,...)
		run("enchase bao")
	end
end

delay=function(t,busyhook,...)
	if hashook(hooks.isbusy) then
		hook(hooks.isbusy,busyhook,...)
	else
		hook(hooks.isbusy,busyhook,...)
		DoAfterSpecial(t,'run(\"enchase bao\")',12)
	end
end

system_trigrpoff=function(name, line, wildcards)
		EnableTriggerGroup(wildcards[2],false)
end

trigrpoff=function(str)
	run("set no_more trigrpoff "..str)
end
system_trigrpon=function(name, line, wildcards)
		EnableTriggerGroup(wildcards[2],true)
end
trigrpon=function(str)
	run("set no_more trigrpon "..str)
end

system_isbusy=function(name, line, wildcards)
	if hooks.isbusy~=nil then
		DoAfterSpecial(busytestdelay,'run(\"enchase bao\")',12)
	end
end

system_onfight=function(name, line, wildcards)
	if hashook(hooks.isbusy) then
		DoAfterSpecial(1,'run(\"enchase bao\")',12)
	end
	if hashook(hooks.fight) then
		callhook(hooks.fight)
	else
		recon()
	end
end

system_nobusy=function(name, line, wildcards)
	callhook(hooks.isbusy,true)
end

system_infoend=function(name, line, wildcards)
	callhook(hooks.infoend,true)
end

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
		Queue(cmd,false)
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


systemtri={system=true,user=true}
inittri=function()
print("初始化触发器...")
	tri=GetTriggerList()
	for k,v in ipairs(tri) do
		if systemtri[GetTriggerInfo(v,26)]==true then
			EnableTrigger(v,true)
		else
			EnableTrigger(v,false)
		end
	end
end
inittri()


getnum=function(num)
	if (num==nil) then num=0 end
	return num
end

on_unwield=function(n,l,w)
	weapon(0)
end

kanbush=function(n,l,w)
	weapon(3)
	if walking==nil then return end
	if ((walking["step"]~=nil)and(hooks.step~=nil)) then
		busytest(kanbushcmd)
	end
end

kanbushcmd=function()
	weapon(1)
end

on_getweapon=function()
	_getweaponcmd=""
	weaponid=GetVariable("weapon")
	weapon2id=GetVariable("weapon2")
	weapon1wielded=nil
	weapon2wielded=nil
	if weaponid~=nil then _getweaponcmd="get "..weaponid end
	if masterweapon[weaponid]~=nil then
		if weapon2id ~=nil then
			_getweaponcmd=_getweaponcmd..";get "..weapon2id
		end
	end
	run (_getweaponcmd)
	weapon(1)
end

miss10lv=""
miss10lvloc=-1

missok=function()
	if walking~=walk or (_roomid==-1) then return end
	if walk["step"]==nil then return end
	if #walk["step"]<5 then return end
	local missto=getexitroom(_roomid,walk["step"])
	if missto==-1 then return end
	if string.sub(walk["step"],1,5)=="miss " then
		miss10lvloc=missto
		miss10lv=string.sub(walk["step"],6,#walk["step"])
	end
end
drunk=0
lastdrunk=os.time()
on_drunk=function(n,l,w)
	drunk=1
	lastdrunk=os.time()
end
on_drunk2=function(n,l,w)
	drunk=2
	lastdrunk=os.time()
end
--------------
stopall=function()
	if walking~=nil then walking["end"]() end
	inittri()
	initweapon()
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
end
---------

on_accept=function()
	callhook(hooks.accept)
end
