lastsleep=0
sleepdelay=100


rest={}
testneili=function()
	neilimin=GetVariable("neilimin")
	if neilimin=="" or neilimin ==nil then
		neilimin=0
	else
		neilimin=tonumber(neilimin)
	end
	if me.hp==nil then return true end
	if me.hp.neili==nil then return true end
	return (me.hp.neili< neilimin)
end

checkrest=function(crest_ok,crest_fail,l)
	if testneili() then
		do_rest(crest_ok,crest_fail,l)
		return true
	elseif me.hp.jinli<getnum(tonumber(GetVariable("jinlimin"))) then
		do_tuna(crest_ok,crest_fail)
		return true
	else
		return false
	end
end
do_rest=function(rest_ok,rest_fail,l)
	rest["ok"]=rest_ok
	rest["fail"]=rest_fail
	meforce=me.skills.force
	if cantouch()==true then
		do_touchneili(rest_end_ok,rest_end_fail)
		return
	end
	if meforce==nil then
		meforce=0
	else
		meforce=meforce.lv
	end
	if ((lastsleep+sleepdelay)<os.time())or(meforce<75)and me.hp.neilimax>getnum(tonumber(GetVariable("neilimin")))  then
		rest.sleep(l)
	else
		rest.dazuo()
	end
end

rest["end"]=function(s)
	EnableTriggerGroup("rest",false)
	if ((s~="")and(s~=nil)) then
		call(rest[s])
	end
	rest["ok"]=nil
	rest.fail=nil

end
rest_end_fail=function()
	rest["end"]("fail")
end
rest_end_ok=function()
	rest["end"]("ok")
end

rest["sleep"]=function(l)
	if l==nil then l=sleeploc end
	go(l,rest["sleeparrive"],rest_end_fail)
end
rest["sleeparrive"]=function()
	busytest(rest.sleepcmd)
end

rest["sleepcmd"]=function()
	EnableTrigger("rest_sleepok",true)
	run("sleep;set no_more sleepok")
end
rest_sleepok=function()
	lastsleep=os.time()
	busytest(rest_end_ok)
end


rest["dazuo"]=function()
	go(-2,rest["dazuoarrive"],rest_end_fail)
end



dazuo=function(func)
	dazuonum=math.floor(getnum(me.hp.qixue)*0.8)
	if dazuonum<70 then dazuonum=70 end
	if dazuonum>500 then dazuonum=500 end
	run("dazuo "..tostring(dazuonum))
	busytest(func)
end

rest["dazuoarrive"]=function()
	busytest(rest["dazuocmd"])
end
rest["dazuocmd"]=function()
	dazuo(rest_end_ok)
end


tuna={}
tuna["ok"]=nil
tuna["fail"]=nil

do_tuna=function(tuna_ok,tuna_fail)
	tuna["ok"]=tuna_ok
	tuna["fail"]=tuna_fail
	go(-2,tuna.arrive,tuna_end_fail)
end

tuna.arrive=function()
	tuna.cmd()
	busytest(tuna_end_ok)
end
tuna.cmd=function(func)
	tunanum=math.floor(getnum(me.hp.jinqi)*0.8)
	if tunanum<70 then tunanum=70 end
	if tunanum>500 then tunanum=500 end
	run("tuna "..tostring(tunanum))
end
tuna["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(tuna[s])
	end
	tuna["ok"]=nil
	tuna["fail"]=nil
end

tuna_end_ok=function()
	tuna["end"]("ok")
end

tuna_end_fail=function()
	tuna["end"]("fail")
end

---------------------------
dazuoneili={}
dazuoneili.loc=getnum(safeloc)
dazuoneili["ok"]=nil
dazuoneili["fail"]=nil
dazuoneili.neilimax=0
dazuoneili.full=false

do_dazuoneili=function(dazuoneili_ok,dazuoneili_fail,neilimax)
	dazuoneili["ok"]=dazuoneili_ok
	dazuoneili["fail"]=dazuoneili_fail
	dazuoneili.loc=getnum(safeloc)
	dazuoneili.neilimax=getnum(neilimax)
	dazuoneili.full=false
	EnableTriggerGroup("dazuoneili",true)
	busytest(dazuoneili["main"])

end

dazuoneili.resume=function()
	EnableTriggerGroup("dazuoneili",true)
	busytest(dazuoneili["main"])
end

checkdazuook=function()
	if dazuoneili.full~=true and (dazuoneili.neilimax==0 or getnum(me.hp.neilimax)<dazuoneili.neilimax) then return false end
	busytest(dazuoneili_end_ok)
	quest.stop=true
	return true
end

dazuofull=function()
	dazuoneili.full=true
	print("ÄÚÁ¦ÒÑÂú")
end

dazuoneili["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(dazuoneili[s])
	end
	dazuoneili["ok"]=nil
	dazuoneili["fail"]=nil
	EnableTriggerGroup("dazuoneili",false)
end

dazuoneili_end_ok=function()
	dazuoneili["end"]("ok")
end

dazuoneili_end_fail=function()
	dazuoneili["end"]("fail")
end


dazuoneili["main"]=function()
	if quest.stop then
		dazuoneili["end"]()
		return
	end
	getstatus(dazuoneili.case)
end

dazuoneili.case=function()
	if checkdazuook() then
	elseif do_check(dazuoneili["main"]) then
	else
		go(dazuoneili.loc,dazuoneili.arrive,dazuoneili_end_fail)
	end
end

dazuoneili.arrive=function()
	dazuoneilinum=max(math.min(me.hp.qixue,me.hp.neilimax*2-me.hp.neili),10)
	run("dazuo "..tostring(dazuoneilinum))
	busytest(dazuoneili.main)
end


----------------------------------------

touchneili={}
touchneili["ok"]=nil
touchneili["fail"]=nil

do_touchneili=function(touchneili_ok,touchneili_fail)
	touchneili["ok"]=touchneili_ok
	touchneili["fail"]=touchneili_fail
	if cantouch==false then
		touchneili_end_fail()
		return
	end
	if ultraweapon==true then
		go(-2,touchneili.touch,touchneili_end_fail)
	else
		go(miss10lvloc,touchneili.miss,touchneili_end_fail)
	end
end

touchneili.touch=function()
	run("touch "..GetVariable("weapon"))
	touchneili_end_ok()
end

touchneili.miss=function()
	run("touch "..miss10lv)
	touchneili_end_ok()
end


touchneili["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(touchneili[s])
	end
	touchneili["ok"]=nil
	touchneili["fail"]=nil
end

touchneili_end_ok=function()
	touchneili["end"]("ok")
end

touchneili_end_fail=function()
	touchneili["end"]("fail")
end

cantouch=function()
	return (miss10lv~=nil and miss10lv~="" and miss10lvloc>-1)or ultraweapon==true
end
