healyao1="jinchuang yao"
healyao2="yangjing dan"
heal={}
heal["ok"]=nil
heal["loc"]=0
heal["hp"]=0
getvbquemin=function()
	vbqixuemin=GetVariable("qixuemin")
	if vbqixuemin=="" or vbqixuemin ==nil then
		return 75
	else
		return tonumber(vbqixuemin)
	end
end
checkheal=function(cheal_ok,cheal_fail,forceheal)
	if me.hp["qixue%"]<getvbquemin() then
		do_heal(cheal_ok,cheal_fail,forceheal)
		return true
	elseif me.hp["jinqi%"]<getvbquemin() then
		do_heal(cheal_ok,cheal_fail,"inspire")
		return true
	else
		return false
	end
end

do_heal=function(heal_ok,heal_fail,forceheal)
	heal["ok"]=heal_ok
	heal.fail=heal_fail
	heal.loc=-2
	heal.cmd="yun heal"
	heal.hp=0
	if familys[me.fam]~=nil and forceheal~=true then
		if familys[me.fam].healcmd~=nil then
			heal.loc=familys[me.fam].dazuoloc
			heal.cmd=familys[me.fam].healcmd
		end
	end
	if forceheal=="inspire" then
		heal.loc=-2
		heal.cmd="yun inspire"
		healyao=healyao2
		go(heal.loc,heal.arrive2,heal_end_fail)
	else
		healyao=healyao1
		go(heal.loc,heal.arrive,heal_end_fail)
	end
end
heal["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(heal[s])
	end
	heal["ok"]=nil
	heal.fail=nil
	heal.hp=0
end
heal_end_fail=function()
	heal["end"]("fail")
end
heal_end_ok=function()
	heal["end"]("ok")
end

heal["arrive"]=function()
	if me.hp["qixue%"]==100 then
		heal["end"]("ok")
		return
	end
	if me.hp["qixue%"]==heal["hp"] then
		if getnum(itemlist[healyao])>0 then
			heal["yao"]()
		else
			item["go"](healyao,1,heal["yao"],heal_end_fail)
		end
	else
		heal.hp=me.hp["qixue%"]
		busytest(heal.go)
	end
end

heal["arrive2"]=function()
	if me.hp["jinqi%"]>=getvbquemin() then
		heal["end"]("ok")
		return
	end
	if me.hp["jinqi%"]==heal["hp"] then
		if getnum(itemlist[healyao])>0 then
			heal["yao"]()
		else
			item["go"](healyao,1,heal["yao"],heal_end_fail)
		end
	else
		heal.hp=me.hp["jinqi%"]
		busytest(heal.go)
	end
end

heal["go"]=function()
	run(heal.cmd)
	busytest(heal.test)
end

heal["test"]=function()
	hp()
	if heal.cmd=="yun inspire" then
		print(healcmd)
		infoend(heal.arrive2)
	else
		infoend(heal.arrive)
	end
end

heal["yao"]=function()
	busytest(heal["eatyao"])
end

heal["eatyao"]=function()
	run("eat "..healyao)
	busytest(heal_end_ok)
end







posioned=false

-------------------------------------------------------

dispel={}
dispel["ok"]=nil
dispel["fail"]=nil
dispel.neilifail=false
do_dispel=function(dispel_ok,dispel_fail)
	dispel["ok"]=dispel_ok
	dispel["fail"]=dispel_fail
	go(-2,dispel.arrive,dispel_end_fail)
end
dispel.arrive=function()
	busytest(dispel.cmd)
end
dispel.cmd=function()
	catch("dispel","yun recover;yun dispel")
	dispel.neilifail=false
	busytest(dispel.test)
end

dispel.test=function()
	if dispel.neilifail==true then
		if cantouch()==true then
			do_touchneili(dispel.arrive,dispel.eatdan)
		else
			dispel.eatdan()
		end
		return
	end
	if posioned then
		busytest(dispel.cmd)
	else
		dispel_end_ok()
	end
end
dispel.eatdan=function()
	do_eatdan(dispel.arrive,dispel.eatdanfail)
end
dispel.eatdanfail=function()
	discon()
end
dispel["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(dispel[s])
	end
	dispel["ok"]=nil
	dispel["fail"]=nil
end

dispel_end_ok=function()
	dispel["end"]("ok")
end

dispel_end_fail=function()
	dispel["end"]("fail")
end

dispel_posioned=function()
	posioned=true
end
on_dispelneilifail=function()
	dispel.neilifail=true
end
dispel_ok=function()
	posioned=false
	drunk=0
end

checkdispel=function(dispel_ok,dispel_fail)
	if posioned then
		do_dispel(dispel_ok,dispel_fail)
		return true
	else
		return false
	end
end

-------------------------------------------------------

eatdan={}
eatdan["ok"]=nil
eatdan["fail"]=nil
eatdan.index=0
eatdan.list={"luosha dan","baola dan","xiongshe wan","jiuhua wan","baoming dan","shengsheng dan"}
eatdan.nlist={"Luosha dan","Baola dan","Xiongshe wan","jiuhua wan","baoming dan","Shengsheng dan"}
eatdan.budaiindex=0
eatdan.budailist={"xuanyuan dan"}
eatdan.budainlist={"Xuanyuan dan"}
do_eatdan=function(eatdan_ok,eatdan_fail)
	eatdan.index=0
	eatdan.budaiindex=0
	eatdan["ok"]=eatdan_ok
	eatdan["fail"]=eatdan_fail
	if chatroom==nil then
		getmudvar()
		infoend(eatdan.main)
	else
		busytest(eatdan.main)
	end
end

eatdan["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(eatdan[s])
	end
	EnableTriggerGroup("enterchatfail",false)
	EnableTriggerGroup("eatdan",false)
	eatdan["ok"]=nil
	eatdan["fail"]=nil
end

eatdan_end_ok=function()
	eatdan["end"]("ok")
end

eatdan_end_fail=function()
	eatdan["end"]("fail")
end

eatdan["main"]=function()
	if canenterchat()==true then
		EnableTriggerGroup("enterchatfail",true)
		go(chatroomloc,eatdan.arrive,eatdan_end_fail)
	else
		eatdan_end_fail()
	end
end

eatdan.arrive=function()
		EnableTriggerGroup("enterchatfail",false)
		getbagitems("budai of here")
		busytest(eatdan.eatdan)
end

eatdan.eatdan=function()
	eatdan.index=eatdan.index+1
	if eatdan.index>#eatdan.list then
		busytest(eatdan.eatbudai)
		return
	end
	if room_obj[eatdan.nlist[eatdan.index]]~=nil then
		busytest(eatdan.eatdancmd)
	else
		busytest(eatdan.eatdan)
	end
end
eatdan.danbusy=false
eatdan.eatdancmd=function()
	eatdan.danbusy=false
	catch("eatdan","get 1 "..eatdan.list[eatdan.index]..";eat "..eatdan.list[eatdan.index]..";drop "..eatdan.list[eatdan.index])
	busytest(eatdan.eatok)
end
eatdan.eatbudai=function()
	eatdan.budaiindex=eatdan.budaiindex+1
	if eatdan.budaiindex>#eatdan.budailist then
		busytest(eatdan.eatjz)
		return
	end
	if bags["budai of here"]==nil then
		busytest(eatdan.eatjz)
		return
	end
	if bags["budai of here"][eatdan.budainlist[eatdan.budaiindex]]~=nil then
		busytest(eatdan.eatbudaicmd)
	else
		busytest(eatdan.eatbudai)
	end
end
eatdan.eatbudaicmd=function()
	eatdan.danbusy=false
	catch("eatdan","get 1 "..eatdan.budailist[eatdan.budaiindex].." from budai of here;eat "..eatdan.budailist[eatdan.budaiindex]..";put "..eatdan.budailist[eatdan.budaiindex].." in budai of here")
	busytest(eatdan.eatbudaiok)
end
eatdan.eatbudaiok=function()
	if eatdan.danbusy==true then
		busytest(eatdan.eatbudai)
	else
		eatdan_end_ok()
	end
end
on_danbusy=function()
	eatdan.danbusy=true
end
eatdan.eatok=function()
	if eatdan.danbusy==true then
		busytest(eatdan.eatdan)
	else
		eatdan_end_ok()
	end
end


eatdan.eatjz=function()
	if jiuzhuanfull~=true then eatdan_end_fail()
		return
	end
	getbagitems("budai of here")
	infoend(eatdan.eatjzcmd)
end


eatdan.eatjzcmd=function()
	if bags["budai of here"]==nil or mudvar.eatjz~=true then
		eatdan_end_fail()
		return
	end
	if getnum(bags["budai of here"]["jiuzhuan jindan"]) ~=0 then
		run("get jiuzhuan jindan from budai;eat jiuzhuan jindan")
		eatdan_end_ok()
	else
		eatdan_end_fail()
	end
end
