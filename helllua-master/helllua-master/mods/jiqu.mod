jiqu={}
jiqu["ok"]=nil
jiqu["fail"]=nil
jiqu.timeout=0
do_jiqu=function(jiqu_ok,jiqu_fail)
	jiqu["ok"]=jiqu_ok
	jiqu["fail"]=jiqu_fail
	go(-2,jiqu.arrive,jiqu_end_fail)
end

jiqu.arrive=function()
	if me.fam=="»ªÉ½½£×Ú" then
		busytest(jiqu.sword)
	else
		busytest(jiqu.cmd)
	end
end

jiqu.sword=function()
	weapon(3)
	run("jiqu sword-cognize")
	busytest(jiqu.cmd)
end

jiqu.cmd=function()
	catch("jiqu","jiqu")
	busytest(jiqu.ok)
end

jiqu.ok=function()
	jiqu_end_ok()
end
jiqu["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(jiqu[s])
	end
	jiqu["ok"]=nil
	jiqu["fail"]=nil
end
jiqu_fail=function()
	jiqu.timeout=os.time()+1800
end
jiqu_end_ok=function()
	jiqu["end"]("ok")
end

jiqu_end_fail=function()
	jiqu["end"]("fail")
end

checkjiqu=function(jiqu_ok,jiqu_fail)
	if me.hp.exp<100000 then return false end
	vbtihuimax=GetVariable("tihuimax")
	if os.time()<jiqu.timeout then return false end
	if vbtihuimax=="0" or vbtihuimax=="" or vbtihuimax ==nil then return false end
	vbtihuimax=tonumber(vbtihuimax)
	if me.hp.tihui>vbtihuimax then
		do_jiqu(jiqu_ok,jiqu_fail)
		return true
	else
		return false
	end
end


