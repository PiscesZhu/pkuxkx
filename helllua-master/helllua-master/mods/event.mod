accept={}
accept["ok"]=nil
accept["fail"]=nil
accept.name=""
accept.id=""
accept.gift=""
accept.accepttype=0
do_accept=function(accept_ok,accept_fail)
	accept["ok"]=accept_ok
	accept["fail"]=accept_fail
	EnableTriggerGroup("accept",true)
	accept.gift=""
	setaccepttri()
	accept.cmd()
end

setaccepttri=function(str)
	SetTriggerOption("event_acceptname","match","^(> )*【东拉西扯】"..me.name.."\\["..string.upper(string.sub(me.id,1,1))..string.sub(me.id,2,#me.id).."\\]：(.*)少要猖狂，我来了！$")
end
setaccepttriii=function(str)
	SetTriggerOption("event_acceptwin","match","^(> )*"..str.."身子一退，掉下(.*)！$")
end

accept["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(accept[s])
	end
	EnableTriggerGroup("accept",false)
	accept["ok"]=nil
	accept["fail"]=nil
end

accept.cmd=function()
	accept.accepttype=0
	run("accept")
	infoend(accept.cmdend)
end

accept.resume=function()
	EnableTriggerGroup("accept",true)
	accept.cmd()
end

accept.fighting=function()
	hook(hooks.logok,accept.fightingrecon)
	recon()
end

accept.fightingrecon=function()
	accept.cmd()
end

accept.kill=function()
	if accept.name=="" then
		accept_end_ok()
		return
	end
	accept.getstatus()
end

accept.killcmd=function()
	if room_obj[accept.name]==nil then
		accept_end_ok()
		return
	elseif room_obj[accept.name].id==nil then
		accept_end_ok()
		return
	end
	fightpreper()
	accept.id=room_obj[accept.name].id
	run("fight "..room_obj[accept.name].id)
	do_kill(room_obj[accept.name].id,accept.killend,accept_end_ok)
end

accept.getstatus=function()
	getstatus(accept.check)
end

accept.check=function()
	if 	testneili() then
		dazuo(accept.getstatus)
	elseif checkheal(accept.getstatus,accept.getstatus,true)then
	else
		run("l")
		infoend(accept.killcmd)
	end
end


accept.cmdend=function()
	if accept.accepttype==2 then
		accept.cmd()
	elseif accept.accepttype==3 then
		accept.kill()
	elseif accept.accepttype==1 then
		accept.fighting()
	elseif accept.accepttype==4 then
	else
		accept_end_ok()
	end
end

accept_end_ok=function()
	accept["end"]("ok")
end

accept_end_fail=function()
	accept["end"]("fail")
end

event_acceptrecon=function(n,l,w)
	accept.accepttype=1
end

event_acceptretry=function(n,l,w)
	accept.accepttype=2
end
event_accepting=function(n,l,w)
	accept.accepttype=3
end

event_acceptname=function(n,l,w)
	accept.accepttype=4
	accept.name=w[2]
	setaccepttriii(w[2])
	_roomid=yzgcloc
	hook(hooks.logok,accept.resume)
	recon()
end
event_acceptwin=function(n,l,w)
	w[2]=getitemnum(w[2])
	print(w[2])
	accept.gift=w[2]
	if accept.gift=="" then
		return
	end
	run("l")
	infoend(accept.getgift)
end

accept.killend=function()
	busytest(accept_end_ok)
end

accept.getgift=function()
	local giftid=room_obj[accept.gift]
	if giftid==nil then
		accept_end_ok()
		return
	end
	if giftid.id==nil then
		accept_end_ok()
		return
	end
	run("get "..giftid.id)
	infoend(accept_end_ok)
end

------------

dragons={}
dragons["king of dragon"]="king of dragon"
dragons["prince of dragon"]="prince of dragon"
dragons["monster dragon"]="monster dragon"
dragons["niutou guai"]="niutou guai"
dragon={}
dragon["ok"]=nil
dragon["fail"]=nil
dragon.name=""
initdragon=function()
	dragon.city=""
	dragon.count=0
	dragon.loc=-1
	dragon.flee=false
end
initdragon()

do_dragon=function(name,dragon_ok,dragon_fail)
	dragon["ok"]=dragon_ok
	dragon["fail"]=dragon_fail
	if dragons[name]==nil then
		dragon_end_ok()
		return
	end
	initdragon()
	dragon.settris()
	dragon.name=name
	print("寻找"..dragon.name.."。")
	Send("chat* 123")
	busytest(dragon.main)
end
dragon["main"]=function()
	getstatus(dragon.check)
end

dragon.check=function()
	if do_check(dragon["main"],dragon["main"]) then
	elseif dragon.flee==true then
		dragon_end_ok()
		return
	elseif dragon.loc>-1 and mudvar.dragon=="kill" then
		go(dragon.loc,dragon.find,dragon.searchfail)
		return
	elseif dragon.count>4 then
		dragon.askyou()
		return
	else
		dragon.search()
	end
end
dragon.askyou=function()
	dragon.count=0
	do_askyou(dragon.name,dragon.main,dragon_end_ok)
end



dragon.search=function()
	local count=#farlist
	if getnum(me.hp.exp)<400000 then count=count-3 end
	dragon.count=dragon.count+1
	npc.name=dragon.name
	do_npcinpath(city[farlist[math.random(1,count)]].path,dragon.find,dragon.main,(mudvar.dragon=="kill"))
end

dragon.find=function()
	if mudvar.dragon~="kill" then
		dragon_end_ok()
		return
	end
	fightpreper()
	do_kill(dragon.name,dragon_end_ok,dragon.search2)
end
dragon.search2=function()
		npc.name=dragon.name
		do_searchnpc(dragon.find,dragon.searchfail)
end

dragon.searchfail=function()
	dragon.loc=-1
	busytest(dragon.main)
end

dragon.settris=function()
	EnableTriggerGroup("dragon",true)
end

dragon.resume=function()
	dragon.settris()
	busytest(dragon.main)
end

dragon["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(dragon[s])
	end
	EnableTriggerGroup("dragon",false)
	dragon["ok"]=nil
	dragon["fail"]=nil
end

dragon_end_ok=function()
	dragon["end"]("ok")
end

dragon_end_fail=function()
	dragon["end"]("fail")
end

dragonfound=function(name,loc)
	print(loc)
--	dragon.loc=loc
	if loc<0 then return end
	loc=tostring(loc)
	local id=""
	if helpfindid==nil then helpfindid="" end
	if helpfindid~="" and dragonpassword~="" then
		name=encrypt(name,dragonpassword)
		loc=encrypt(loc,dragonpassword)
	end
	run("party helllua.dragon-"..helpfindid.."-"..name.."-"..loc)
end
dragongiftcmd={}
dragongiftcmd["牛头怪"]="get chipped agate"
dragongiftcmd["北海谪龙"]="get chipped jade"
dragongiftcmd["东海三太子"]="get chipped diamond"
dragongiftcmd["南海恶蛟"]="get chipped crystal"
dragongiftcmd["niutou guai"]="get chipped agate"
dragongiftcmd["king of dragon"]="get chipped jade"
dragongiftcmd["prince of dragon"]="get chipped diamond"
dragongiftcmd["monster dragon"]="get chipped crystal"


dragonflee=function(n,l,w)
	w[3]=string.lower(w[3])
	if dragongiftcmd[w[3]]~=nil then
		SendImmediate(dragongiftcmd[w[3]])
	end
	dragon.flee=true
end

dragoncomeinfo={}
dragoncomeinfo["不及多想"]="monster dragon"
dragoncomeinfo["玉帝大怒"]="king of dragon"
dragoncomeinfo["噢呦"]="prince of dragon"
dragoncomeinfo["牛魔王道"]="niutou guai"
dragoncome=function(n,l,w)
	if dragoncomeinfo[w[2]]==nil then return end
	thook=_hooklist[hooks.dragon]
	call(thook,dragoncomeinfo[w[2]])
end


event_dragonfind=function(n,l,w)
	if w[4]~="" then
		if w[4]~=helpfindid then return end
		w[5]=decrypt(w[5],dragonpassword)
		w[6]=decrypt(w[6],dragonpassword)
	end
	if (w[5]~=dragon.name and n=="event_dragonfind") or dragon.loc>-1 then return end
	local loc=tonumber(w[6])
	if loc==nil then return end
	if loc<0 then return end
	print("接到线报。")
	dragon.loc=loc
	if mudvar.dragon~="kill" then return end
	go(loc,dragon.find,dragon.main)
end

---------------------
storygift={}
storygift["一枚假仙丹"]="get fei dan"
storygift["一颗闪闪发光的仙丹"]="get jiuzhuan jindan"
storygift["一枚神力丸"]="get shenli wan"
storygift["一本书"]="get mengzi"
storygift["一枚仙丹"]="get xian dan\nget huohong xiandan"
storygift["一枚黑不溜秋的丹药"]="get xisui dan"


event_storygift=function(n,l,w)
	if storygift[w[2]]~=nil then
		SendImmediate(storygift[w[2]])
	end
end
