masterquest={}
mqfar={}
mqkill={}
masterquest["ok"]=nil
masterquest["fail"]=nil
mqcount="0"
mqquests=0
mqstarttime=0
mqquestperh=0
mqletter={}
mqletterflee=false
initmqletter=function()
	mqletter.city=""
	mqletter.npc=""
	mqletter.arrive=0
end
masterquest.normal=0
masterquest.assistor=1
masterquest.assister=2
masterquest.levelmax=0
assist={}
assist["er"]=""
assist["erid"]=""
assist["or"]=""
assist["orid"]=""
assist["loc"]=0
masterquest.type=masterquest.normal

initmq=function()
	DeleteTimer("lettertimeout")
	masterquest["npc"]=""
	masterquest["npcid"]=nil
	masterquest["city"]=""
	masterquest.far=false
	masterquest.flee=false
	masterquest.die=false
	masterquest.assistwait=false
	masterquest.assistneedreport=false
	mqfar.index=1
	masterquest.waitletter=false
	mqfar.max=0
	npc.id=nil
	mqkill["searchcount"]=0
	mqkill["city"]=""
	mqkill["searchmax"]=1
	initmqletter()
	if masterquest.type~=masterquest.assister then
		masterquest.firstsearch=true
	else
		masterquest.firstsearch=false
	end
	masterquest.fleesearch=false
end
initmq()
masterquest.setuptri=function()
	EnableTriggerGroup("masterquest",true)
	if masterquest.type==masterquest.assister then
		EnableTrigger("mqassistnpc",true)
		EnableTriggerGroup("mqassist",true)
	elseif masterquest.type==masterquest.assistor then
		EnableTrigger("mqassistok",true)
		EnableTriggerGroup("mqassist",true)
	end
	if masterquest.type==masterquest.normal then
		hook(hooks.accept,masterquest.acceptcheck)
	end
	if mudvar.dragon=="kill" or mudvar.dragon=="find" then
		hook(hooks.dragon,masterquest.dragoncheck)
	end
end
do_masterquest=function(masterquest_ok,masterquest_fail,levelmax)
	masterquest["ok"]=masterquest_ok
	masterquest["fail"]=masterquest_fail
	masterquest.levelmax=getnum(levelmax)
	setmqmastertri()
	masterquest.setuptri()
	hook(hooks.faint,mqfaintrecon)
	initmq()
	masterquest.main()
end
masterquest.loop=function()
	if _skilllist~=nil then
		busytest(masterquest.loopcmd)
	else
		quest.stop=true
		masterquest["end"]()
		busytest(aliasaftercmd)
	end
end
masterquest.resume=function()
	hook(hooks.faint,mqfaintrecon)
	masterquest.setuptri()
	busytest(masterquest.main)
end
masterquest.loopcmd=function()
	do_masterquest(masterquest.loop,masterquest.loop,masterquest.levelmax)
end

masterquest.main=function()
	getstatus(masterquest["check"])
end

masterquest.check=function()
	if do_check(masterquest["main"],masterquest.loop) then
	elseif checkfangqi(masterquest["main"],masterquest["main"]) then
	elseif checkjiqu(masterquest["main"],masterquest["main"]) then
	elseif checknuqi(masterquest["main"],masterquest["main"]) then
	elseif quest.stop and masterquest.die==true then
		masterquest["end"]()
		return
	else
		busytest(masterquest.case)
	end
end

masterquest.go=function(mqnpc,mqcity,mqflee)
	initmq()
	masterquest["npc"]=mqnpc
	masterquest["city"]=mqcity
	if mqflee==true then
		masterquest["flee"]=true
	end
	busytest(masterquest.main)
end
mq=masterquest.go

masterquest.askquest=function()
	if	masterquest.type~=masterquest.assister then
		go(familys[me.fam].masterloc,masterquest.arrive,masterquest_end_fail)
	else
		go(kdloc,mqassistgivecmd,mqassistgivecmd)
	end
end
masterquest.arrive=function()
	busytest(masterquest.questgive)
end
masterquest.questgive=function()
	initmq()
	run("give head to "..familys[me.fam].masterid..";quest cancel;mastercmd")
	busytest(masterquest.testask)
end
masterquest.testask=function()
	if checkmasterweapon(masterquest.questgo,masterquest.questgo) then
	else
		masterquest.questcmd()
	end
end
masterquest.questgo=function()
	go(familys[me.fam].masterloc,masterquest.questcmd,masterquest_end_fail)
end
masterquest.questcmd=function()
	trigrpon("mqinfo")
	npchere(familys[me.fam].masterid,"quest "..familys[me.fam].masterid)
	trigrpoff("mqinfo")
	trigrpoff("mqinfo2")
	infoend(masterquest.questok)
end
masterquest.questok=function()
	mqletterflee=false
	if masterquest.npc~="" and  masterquest.npc~=nil then
		run("drop head")
		busytest(masterquest.main)
	else
		masterquest_end_fail()
	end
end
masterquest.case=function()
	if masterquest.die==false and masterquest.npc~="" and masterquest.assistwait==false then
		if masterquest.far==true then
			busytest(mqfar.main)
		elseif masterquest.flee==true then
			do_mqask(masterquest.maincmd,masterquest.findfar)
		else
			do_mqkill(masterquest["city"],3,masterquest_end_ok,masterquest.asknpc)
		end
	elseif checkstudy(masterquest["main"],masterquest.loop,masterquest.levelmax) then
	elseif masterquest.assistneedreport==true then
		if masterquest.type==masterquest.assistor then
			mqassistorreport()
		else
			mqassisterreport()
		end
		delay(1,masterquest["main"])
	elseif masterquest.assistwait==true then
		go(kdloc,mqassistwait,mqassistwait)
	elseif masterquest.type==masterquest.assister and masterquest.die==false then
			masterquest.assistwait=true
			busytest(masterquest.main)
	else
		masterquest.askquest()
	end
end
masterquest.maincmd=function()
	busytest(masterquest.main)
end

masterquest.asknpc=function()
	do_mqask(masterquest.maincmd,masterquest.askyou)
end
masterquest.askyou=function()
	if masterquest["npcid"]==nil or masterquest["npcid"]=="" then
		masterquest["npcid"]=getcnname(npc.name)
	end
	if masterquest["npcid"]==nil then
		masterquest.findfar()
		return
	end
	do_askyou(masterquest["npcid"],masterquest.findfar,masterquest.givehead)
end
masterquest.killnpc=function()
	do_mqkill(masterquest["city"],3,masterquest_end_ok,masterquest.asknpc)
end

masterquest.findfar=function()
	partyhelp(masterquest.npc)
	print("未得到npc信息，开始全地图通缉")
	mqfar.new()
	do_mqfar(masterquest.main,masterquest.main)
end
masterquest["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(masterquest[s])
	end
	hook(hooks.faint,nil)
	EnableTriggerGroup("masterquestkill",false)
	EnableTriggerGroup("masterquest",false)
	EnableTriggerGroup("mqassist",false)
	EnableTrigger("mqassistnpc",false)
	EnableTrigger("mqassistok",false)
	DeleteTimer("lettertimeout")
	masterquest["ok"]=nil
	masterquest["fail"]=nil
	EnableTimer("keepidle",false)
end



masterquest_end_ok=function()
	if quest.stop and masterquest.die==true then
		masterquest["end"]()
	else
		masterquest["end"]("ok")
	end
end

masterquest_end_fail=function()
	masterquest["end"]("fail")
end

mqinfo=function(n,l,w)
	masterquest["npc"]=w[2]
	masterquest["city"]=string.sub(w[4],1,4)
	EnableTriggerGroup("mqinfo2",true)
end


masterflee=function()
	masterquest.flee=true
end
setmqmastertri=function()
	SetTriggerOption ("mqinfo", "match", "^(> )*"..familys[me.fam].mastername.."对你道：“我早就看(.*)不顺眼，听说(他|她)最近在(.*)，你去做了他，带他的人头来交差！”")
	SetTriggerOption ("mqinfo1", "match", "^(> )*"..familys[me.fam].mastername.."对你道：“(.*)(这个败类打家劫舍，无恶不作，听说他最近在|这个所谓大侠屡次和我派作对，听说他最近在)(.*)")
	SetTriggerOption ("masterflee", "match", "^(> )*"..familys[me.fam].mastername.."话音刚落，突然一人急急忙忙的赶了过来")
	SetTriggerOption ("mqletterquest", "match", "^(> )*"..familys[me.fam].mastername.."吩咐你在(.*)之前割下(.*)的人头，回(.*)交差。\\n据说此人前不久曾经在(.*)出没。")
	if helpfindid==nil then helpfindid="" end
	SetTriggerOption ("mqinfo", "on_partyfind", "^(> )*【(明教|天地会)】.{2,8}\\[.*\\]：helllua.find-(|"..helpfindid..")-(.*)-(.*)-(.*)")
end
masterquest.givehead=function()
	masterquest.waitletter=false
	masterquest.die=true
	if	masterquest.type~=masterquest.assister then
		go(familys[me.fam].masterloc,masterquest.giveheadcmd,masterquest_end_fail)
	else
		go(kdloc,mqassistgivecmd,mqassistgivecmd)
	end
end
masterquest.giveheadcmd=function()
	run("give head to "..familys[me.fam].masterid..";drop head;quest cancel;mastercmd")
	busytest(masterquest.main)
end
--------------------------------


mqfar["ok"]=nil
mqfar["fail"]=nil
mqfar.max=0
mqfar.index=1
do_mqfar=function(mqfar_ok,mqfar_fail)
	mqfar["ok"]=mqfar_ok
	mqfar["fail"]=mqfar_fail
	mqfar.main()
end
mqfar.new=function()
	masterquest.far=true
	mqfar.max=#farlist
	if getnum(me.hp.exp)<400000 then
		mqfar.max=mqfar.max-3
	elseif getnum(me.hp.exp)<700000 then
		mqfar.max=mqfar.max-2
	end
	mqfar.index=1
end
mqfar.askyoucity={}
mqfar.askyoucity["西域"]=true
mqfar.main=function()
	if mqfar.index>mqfar.max then
		initmq()
		busytest(mqfar_end_fail)
	else
		print("全图通缉----"..farlist[mqfar.index])
		masterquest.city=farlist[mqfar.index]
		if mqfar.askyoucity[masterquest.city]==true then
			if masterquest["npcid"]==nil or masterquest["npcid"]=="" then
				masterquest["npcid"]=getcnname(npc.name)
			end
			if masterquest["npcid"]==nil then
				mqfar.searchcmd()
				return
			end
			do_askyou(masterquest["npcid"],mqfar.searchcmd,masterquest.givehead)
		else
			mqfar.searchcmd()
		end
	end
end

mqfar.searchcmd=function()
		do_mqkill(farlist[mqfar.index],3,mqfar.ok,mqfar.searchend)
end

mqfar.searchend=function()
	print(farlist[mqfar.index].."搜索完毕，去下一个城市")
	mqfar.index=mqfar.index+1
	busytest(masterquest.main)
end
mqfar["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(mqfar[s])
	end
	mqfar["ok"]=nil
	mqfar["fail"]=nil
end

mqfar_end_ok=function()
	mqfar["end"]("ok")
end

mqfar_end_fail=function()
	mqfar["end"]("fail")
end


------------------------------------

mqask={}
mqask["ok"]=nil
mqask["fail"]=nil

do_mqask=function(mqask_ok,mqask_fail)
	mqask["ok"]=mqask_ok
	mqask["fail"]=mqask_fail
	mqask.info=""
	do_askinfolist(masterquest["npc"],city[masterquest["city"]].info,mqask.settri,mq_asktest,mqask_end_ok,mqask_end_fail)
end
mqask.settri=function(str)
	SetTriggerOption ("mq_asknpc", "match", "^(> )*"..str.."说道：.*(好像听人说过是在|他不是在|据说是躲到|好像去了|已经躲到|好像是去了|但是也有人说他在|有人说在|不过听人说在|听说是在|不过听说他好像在|现在应该是去了)(.*)")
end
mq_asknpc=function(n,l,w)
	mqask.info=string.sub(w[3],1,4)
end
mq_asktest=function(n,l,w)
	if mqask.info~="" then
		masterquest.flee=false
		masterquest["city"]=mqask.info
		masterquest.flee=false
		if masterquest["city"]~="很远" then
			masterquest.fleesearch=true
			askinfolist_end_ok()
		else
			askinfolist["end"]()
			mqask["end"]()
			busytest(masterquest.findfar)
		end
	else
		askinfolist.askcmd()
	end

end
mqask["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(mqask[s])
	end
	mqask["ok"]=nil
	mqask["fail"]=nil
end

mqask_end_ok=function()
	mqask["end"]("ok")
end

mqask_end_fail=function()
	partyhelp(masterquest.npc)
	mqask["end"]("fail")
end


----------------------------------


mqkill["ok"]=nil
mqkill["fail"]=nil

do_mqkill=function(mqkcity,mqkmax,mqkill_ok,mqkill_fail)
	mqkill["ok"]=mqkill_ok
	mqkill["fail"]=mqkill_fail
	mqkill["city"]=mqkcity
	mqkill["searchmax"]=mqkmax
	mqkill["searchcount"]=1
	hook(hooks.killme,mqkill.onkillme)
	npc.name=masterquest.npc
	setmqkilltri()
	mqkill.main()
end

mqkill["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(mqkill[s])
	end
	hook(hooks.killme,nil)
	EnableTriggerGroup("masterquestkill",false)
	EnableTriggerGroup("mqassistor",false)
	mqkill["ok"]=nil
	mqkill["fail"]=nil
end

mqkill_end_ok=function()
	mqkill["end"]("ok")
end

mqkill_end_fail=function()
	print("敌人狡猾狡猾滴，没找到")
	mqkill["end"]("fail")
end
mqkill.main=function()
	if masterquest.die==true then
		busytest(mqkill.questend)
	elseif mqkill["searchmax"]<mqkill["searchcount"] then
		mqkill_end_fail()
	else
		mqkill["searchcount"]=mqkill["searchcount"]+1
		fightpreper()
		eatdrink()
		busytest(mqkill.search)
	end
end
mqkill.search=function()
		if masterquest.fleesearch==true then
			masterquest.fleesearch=false
			masterquest.firstsearch=false
			if city[mqkill["city"]].path2~=nil then
				do_npcinpath(city[mqkill["city"]].path2,mqkill.npcfind,mqkill.main)
				return
			end
		elseif masterquest.firstsearch==true then
			masterquest.firstsearch=false
			if city[mqkill["city"]].path1~=nil then
				do_npcinpath(city[mqkill["city"]].path1,mqkill.npcfind,mqkill.main)
				return
			end
		end
		do_npcinpath(city[mqkill["city"]].path,mqkill.npcfind,mqkill.main)
end
mqkill.search2=function()
		do_searchnpc(mqkill.npcfind,mqkill.search2fail)
end
mqkill.search2fail=function()
	busytest(mqkill.search)
end

mqkill.npcfind=function()
	mqkill["searchcount"]=1
	masterquest.city=mqkill["city"]
	masterquest.far=false
	EnableTriggerGroup("masterquestkill",true)
	if npc.id~=nil then
		masterquest["npcid"]=npc.id
	end
	if masterquest["npcid"]==nil or masterquest["npcid"]=="" then
		masterquest["npcid"]=getcnname(npc.name)
	end
	if masterquest["npcid"]==nil then masterquest["npcid"]="" end
	do_kill(masterquest["npcid"],mqkill.heal,mqkill.search2)
	assist["loc"]=_roomid
	if masterquest.type==masterquest.assistor then
		SetTriggerOption ("mqassistkill", "match", "^(> )*你对著"..masterquest.npc.."喝道：")
		EnableTriggerGroup("mqassistkill",true)
	end
end


mqassistkill=function()
	masterquest.assistwait=true
	EnableTriggerGroup("mqassistkill",false)
	masterquest.assistneedreport=true
	hook(hooks.logok,mqassistlogok)
	recon()
end

mqassistlogok=function()
	unhookall()
	mqassistorreport()
	go(safeloc,masterquest.resume,masterquest.resume)
end

mqkill.heal=function()
	EnableTriggerGroup("mqhelper",false)
	hp()
	busytest(mqkill.healcmd)
end
mqkill.healcmd=function()
	if checkdispel(mqkill.heal,mqkill.heal) then
	elseif masterquest.flee==true and (me.hp["qixue%"]<getvbquemin()) then
		do_heal(mqkill.heal,mqkill.heal,true)
	else
		busytest(mqkill.killend)
	end
end
mqkill.killend=function()
	if masterquest.die==true then
		mqkill.questend()
	else
		jianuzero()
		masterquest.flee=true
		mqkill["end"]()
		masterquest.main()
	end
end

mqkill.questend=function()
	masterquest.waitletter=true
	if letteraccept()==true then
		if mqletter.arrive==1 then
			mqlookletter()
		else
			killcmd()
		end
	else
		masterquest.givehead()
	end

end

mqkill.testyou=function()

end

mqkill.npckillme=function()
	if _roomid~=killmeloc then
		go(npc.loc,mqkill.npcfind,mqkill.main)
	else
		mq.npcfind()
	end
	steppath["end"]()
	npcinpath["end"]()
end

jianuzero=function()
	if tonumber(GetVariable("nuqimin")) >0 then
		run("jianu 0")
	end
end

masterquest_npcfaint=function()
	masterquest.die=true
	run("get silver from "..masterquest["npcid"])
	run("faintcmd "..masterquest.npcid)
	jianuzero()
	weapon(2)
end
masterquest_npcdie=function()
	masterquest.die=true
	meforce=me.skills.force
	if meforce==nil then
		meforce=0
	else
		meforce=meforce.lv
	end
	if meforce>100 then
		weapon(0)
	end
	AddTimer("lettertimeout",0,0,30,"",17445,"mqlettertimeout")
	run("cutheadcmd "..masterquest.npcid)
	run("cut head from corpse;get head")
	mqquests=mqquests+1
	mqlasttime=os.time()-mqstarttime
	if mqlasttime>0 and mqstarttime~=0 then
		mqquestperh=math.floor(mqquests*3600/mqlasttime)
		print("平均每小时Quest数："..tostring(mqquestperh))
	end
	mqcount="0"
	catch("mqquestnum","quest")
end
setmqkilltri=function()
	SetTriggerOption ("masterquest_npcfaint", "match", "^(> )*"..masterquest["npc"].."脚下一个不稳，跌在地上一动也不动了。")
	SetTriggerOption ("masterquest_npcdie", "match", "^(> )*"..masterquest["npc"].."扑在地上挣扎了几下，腿一伸，口中喷出几口鲜血，死了！")
	SetTriggerOption ("mqhelper1", "match", "^(> )*"..masterquest["npc"].."(大声喝道：“好一个|忽然撮舌吹哨，你听了不禁微微一愣。|一声长啸，声音绵泊不绝，远远的传了开去。)")
end

-------------------------------------

letteraccept=function()
	tpath,tdelay=mapper.getpath(_roomid,familys[me.fam].masterloc,1)
	local potmax=getnum(tonumber(GetVariable("potmax")))
	if masterquest.type~=masterquest.normal then
	elseif mqletter.arrive ==2 then
	elseif giftquest[mqcount] ==true then
	elseif quest.stop==true then
	elseif tdelay>-1 and tdelay<=acceptmaxstep then
	elseif potmax>0 and me.hp.pot>potmax then
	elseif needaskmasterweapon() then
	elseif _skilllist==nil then
	else
		return true
	end
	return false
end
mqletterattive=function(n,l,w)
	DeleteTimer("lettertimeout")
	mqletter.arrive=1
	if masterquest.waitletter and letteraccept()==true then
		run("halt")
		mqlookletter()
	end
end

mqlookletter=function()
	masterquest.waitletter=false
	initmqletter()
	catch("mqletter","l letter")
	infoend(mqletterlooked)
end

mqlettercontent=function(n,l,w)
	mqletter.city=w[6]..w[7]
end

mqletterlooked=function()
	if string.find(mqletter.city,"西域",1,true)==nil and string.find(mqletter.city,"大理",1,true)==nil then
		catch("mqletterquest","accept quest;quest")
	else
		busytest(masterquest.givehead)
	end
end

mqletterquest=function(n,l,w)
	if masterquest.npc==w[3] then
		busytest(masterquest.givehead)
	else
		initmq()
		initmqletter()
		masterquest.npc=w[3]
		masterquest.city=string.sub(w[5],1,4)
		masterquest.flee=mqletterflee
		mqletterflee=false
		masterquest.questok()
	end
end

mqquestnum=function(n,l,w)
	mqcount=w[1]
end

mqlettertimeout=function(n,l,w)
	DeleteTimer("lettertimeout")
	mqletter.arrive=2
	if masterquest.waitletter==true then
		print("等信超时")
		run("halt")
		busytest(masterquest.givehead)
	end
end

letterflee=function(n,l,w)
	mqletterflee=true
end

----------------------------
mqhelploc=0
mqhelperrecon=function()
	mqhelploc=_roomid
	hook(hooks.logok,mqhelperlogok)
	recon()
end

mqfaintrecon=function()
	hook(hooks.logok,mqfaintlogok)
	recon()
end
mqfaintlogok=function()
	unhookall()
	print("前往安全场所")
	go(safeloc,resume,resume)
end

mqhelper1=function(n,l,w)
	EnableTriggerGroup("mqhelper",true)
end
mqhelper=function(n,l,w)
	EnableTriggerGroup("mqhelper",false)
	mqhelperrecon()
end


mqkill.onkillme=function(npcname)
    if npcname~=masterquest.npc then
        if hashook(hooks.fight)==true then
            mqhelperrecon()
        else
            run("halt")
        end
    end
end

mqhelperlogok=function()
	unhookall()
	_roomid=mqhelploc
	busytest(mqkill.reconkill)
end

mqkill.reconkill=function()
	mqkill["searchcount"]=1
	masterquest.city=mqkill["city"]
	masterquest.setuptri()
	if npc.id~=nil then
		masterquest["npcid"]=npc.id
	end
	if masterquest["npcid"]==nil or masterquest["npcid"]=="" then
		masterquest["npcid"]=getcnname(npc.name)
	end
	if masterquest["npcid"]==nil then masterquest["npcid"]="" end
	do_kill(masterquest["npcid"],mqkill.heal,masterquest.main)
end

---------------------

helpfindnpc={}

partyhelp=function(name)
	if helpfindid==nil then helpfindid="" end
	if helpfindid~="" and helpfindpassword~="" then
		name=encrypt(name,helpfindpassword)
		run("party helllua-help-"..helpfindid.."-"..name)
	else
		run("party helllua-help--"..name)
	end
end

on_partyhelp=function(n,l,w)
	if w[4]~="" and w[4]~=helpfindid then
		return
	end
	if blacklist[w3]==true then
		return
	end
	if w[4]==helpfiindid then
		w[5]=decrypt(w[5],helpfindpassword)
	end
	helpfindnpc[w[3]]={}
	helpfindnpc[w[3]].name=w[5]
	if w[4]=="" then
		helpfindnpc[w[3]].encrypt=false
	else
		helpfindnpc[w[3]].encrypt=true
	end
end

helpfindnpcfound=function(finder,loc,city)
	if loc<0 then return end
	if helpfindnpc[finder]==nil then return end
	loc=tostring(loc)
	local id=""
	if helpfindnpc[finder].encrypt==true then
		helpfindnpc[finder].name=encrypt(helpfindnpc[finder].name,helpfindpassword)
		loc=encrypt(loc,helpfindpassword)
		city=encrypt(city,helpfindpassword)
		id=helpfindid
	end
	run("party helllua.find-"..id.."-"..helpfindnpc[finder].name.."-"..loc.."-"..city)
	helpfindnpc[finder]=nil
end

on_partyfind=function(n,l,w)
	if w[4]~="" then
		if w[4]~=helpfindid then return end
		w[5]=decrypt(w[5],helpfindpassword)
		w[6]=decrypt(w[6],helpfindpassword)
		w[7]=decrypt(w[7],helpfindpassword)
	end
	if w[5]~=masterquest.npc or masterquest.far==false then return end
	if masterquest.assistwait==true then return end
	if city[w[7]]==nil then return end
--	if city[w[7]]==masterquest.city then return end
	local loc=tonumber(w[6])
	if loc==nil then return end
	if loc<0 then return end
	masterquest.fleesearch=false
	masterquest.firstsearch=false
	masterquest.city=w[7]
	masterquest.far=false
	masterquest.flee=false
	mqkill.city=w[7]
	mqkill["searchcount"]=1
	print("接到线报。")
	go(loc,mqkill.npcfind,masterquest.main)
end


-----------------------

killcmd=function()
	kill_cmd=GetVariable("killcmd")
	if kill_cmd~=nil then
		run(kill_cmd)
	end
end

------------------
mqassistorcmd=function()
	EnableTrigger("mqassister",true)
	masterquest.type=masterquest.assistor
end

mqassistercmd=function(str)
	masterquest.type=masterquest.assister
	EnableTrigger("mqassistor",true)
	assist["orid"]=str
	run("assist none;assist "..str)
	initmq()
end

mqassister=function(n,l,w)
	if mudvar.canaccept~=nil then
		if mudvar.canaccept[w[4]]~=nil then
			assist["er"]=w[2]
			assist["erid"]=w[4]
			run("right "..w[4]..";team dismiss")
			EnableTrigger("mqassister",false)
			EnableTrigger("mqassistok",true)
			SetTriggerOption("mqassistok","match","^(> )*"..assist["er"].."\\("..string.upper(string.sub(assist["erid"],1,1))..string.sub(assist["erid"],2,#assist["erid"]).."\\)告诉你：npckillok")
			SetTriggerOption("mqassistreport","match","^(> )*你告诉"..assist["er"].."\\("..string.upper(string.sub(assist["erid"],1,1))..string.sub(assist["erid"],2,#assist["erid"]).."\\)")
			initmq()
			do_masterquest(masterquest.loop,masterquest.loop)
		return
		end
	end
	print("不支持的协助者，请把协助者设置在can_accpet里，比如set can_accept bao")
end
mqassistor=function(n,l,w)
	assist["or"]=w[2]
	SetTriggerOption("mqassistnpc","match","^(> )*"..assist["or"].."\\("..string.upper(string.sub(assist["orid"],1,1))..string.sub(assist["orid"],2,#assist["orid"]).."\\)告诉你：npckill\\.(.*)\\.(.*)\\.(.*)\\.(.*)")
	SetTriggerOption("mqassistreport","match","^(> )*你告诉"..assist["or"].."\\("..string.upper(string.sub(assist["orid"],1,1))..string.sub(assist["orid"],2,#assist["orid"]).."\\)")
	do_masterquest(masterquest.loop,masterquest.loop)
end

mqassistnpc=function(n,l,w)
	print(w[2])
	print(w[3])
	print(w[4])
	print(w[5])
	masterquest.assistneedreport=false
	npc.name=w[2]
	masterquest.npc=w[2]
	masterquest.npcid=w[3]
	npc.id=w[3]
	mqkill["city"]=w[5]
	masterquest.city=w[5]
	local _loc=tonumber(w[4])
	if _loc==nil then _loc=-1 end
	mqkill["searchmax"]=3
	mqkill["searchcount"]=1
	hook(hooks.killme,mqkill.onkillme)
	setmqkilltri()
	EnableTimer("keepidle",false)
	if masterquest.assistwait==true then
		print("123")
		masterquest.assistwait=false
		if _loc<0 then
			masterquest.main()
		else
			go(_loc,mqkill.npcfind,masterquest.main)
		end
	end
end

mqassistok=function(n,l,w)
	masterquest.assistneedreport=false
	masterquest.assistwait=false
	EnableTimer("keepidle",false)
	masterquest.die=true
	masterquest.flee=false
	masterquest.far=false
	busytest(masterquest.main)
end

mqassistreport=function(n,l,w)
	masterquest.assistneedreport=false
end

mqassistorreport=function()
	run("tell "..assist["erid"].." npckill."..masterquest.npc.."."..masterquest.npcid.."."..tostring(assist.loc).."."..masterquest["city"])
end

mqassisterreport=function()
	run("tell "..assist["orid"].." npckillok")
end

keepidle=function()
	run("keepidle")
end

mqassistwait=function()
		AddTimer("keepidle",0,2,0,"",17441,"keepidle")
end

mqassistgivecmd=function()
	npchere(assist["orid"],"give head to "..assist["orid"])
	busytest(mqassisttestgive)
end

mqassisttestgive=function()
	if npc.nobody>0 then
		delay(1,masterquest.main)
	else
		masterquest.assistneedreport=true
		initmq()
		mqassisterreport()
		masterquest.main()
	end
end
--------------------------
masterquest.stopable=function()
	if study.skill~=nil then
		if study.skill.study=="closed" then
			return false
		end
	end
	return true
end

masterquest.acceptcheck=function()
	if masterquest.stopable()==true and posioned==false then
		quest.resume=accept.resume
		stopall()
		run("halt")
		do_accept(masterquest.restore,masterquest.restore)
	end
end
masterquest.dragoncheck=function(name)
	if masterquest.stopable()==true then
		quest.resume=dragon.resume
		stopall()
		run("halt")
		do_dragon(name,masterquest.restore,masterquest.restore)
	end
end

masterquest.restore=function()
	quest.resume=masterquest.resume
	stopall()
	masterquest.resume()
end
