fangqi={}
fangqi["ok"]=nil
fangqi["fail"]=nil

do_fangqi=function(fangqi_ok,fangqi_fail)
	fangqi["ok"]=fangqi_ok
	fangqi["fail"]=fangqi_fail
	busytest(fangqi.checkcmd)
end

fangqi.checkcmd=function()
	hp()
	cha()
	busytest(fangqi.check)
end

fangqi.check=function()
	expmax=getexpmax()
	if getnum(me.hp.exp)<(expmax-getfangqinum()) or expmax==0 then
		busytest(fangqi_end_ok)
	elseif (expmax-getfangqinum())<getexpmin() then
		print("你的expmax设置不足以支持你的skill,请手动放弃exp")
		fangqi["end"]()
		return
	else
		busytest(fangqi.go)
	end
end

fangqi.go=function()
	go(-2,fangqi.fangqi,fangi_end_fail)
end

fangqi.fangqi=function()
	busytest(fangqi.fangqicmd)
end

fangqi.fangqicmd=function()
	run("fangqi exp")
	busytest(fangqi.checkcmd)
end
fangqi["end"]=function(s)
	cha()
	if ((s~="")and(s~=nil)) then
		infoend(fangqi[s])
	end
	fangqi["ok"]=nil
	fangqi["fail"]=nil
end

fangqi_end_ok=function()
	fangqi["end"]("ok")
end

fangqi_end_fail=function()
	fangqi["end"]("fail")
end

getfangqinum=function()
	return 0
end
getexpmax=function()
	expmax=GetVariable("expmax")
	if expmax=="" or expmax==nil then
		return 0
	else
		return tonumber(expmax)
	end
end

max=function(value1,value2)
	value1=getnum(value1)
	value2=getnum(value2)
	if value1>value2 then
		return value1
	else
		return value2
	end
end
getskilllv=function(tskill)
	if tskill==nil then
		return 0
	else
		return tskill.lv
	end
end

getexpmin=function()
	skillmax=max(getskilllv(me.skills.dodge),max(getskilllv(me.skills.force),max(getskilllv(me.skills.parry),max(getskilllv(me.skills.sword),max(getskilllv(me.skills.blade),max(getskilllv(me.skills.staff),max(getskilllv(me.skills.whip),max(getskilllv(me.skills.hammer),max(getskilllv(me.skills.finger),max(getskilllv(me.skills.unarmed),max(getskilllv(me.skills.strike),max(getskilllv(me.skills.hand),getskilllv(me.skills.cuff)))))))))))))-2
	return skillmax*skillmax*skillmax/10
end

checkfangqi=function(check_ok,check_fail)
	if getnum(me.hp.exp)>(getexpmax()) and getexpmax()~=0 then
		do_fangqi(check_ok,check_fail)
		return true
	else
		return false
	end
end
