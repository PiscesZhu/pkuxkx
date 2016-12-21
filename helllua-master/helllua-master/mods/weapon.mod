weapon=function(wn)
	weaponid=GetVariable("weapon2")
	weapon1id=GetVariable("weapon")
	if weaponid==nil then weaponid="" end
	if wn==0 then
		weapon1(false)
		weapon2(false)
		if mudvar.powerup==nopowerup.drunk then
			run("unwield mu gun")
		end
	elseif wn==2 then
		if weaponid=="" then return end
		weapon1(false)
		weapon2(true)
	elseif wn==3 then
		weapon1(true)
		weapon2(true)
	else
		weapon2(false)
		weapon1(true)
		if weapon1id~=nil then
			if masterweapon[weapon1id]~=nil then
				weapon2(true)
			end
		end
	end
end
initweapon=function()
	weapon1wielded=nil
	weapon2wielded=nil
end
initweapon()
weapon1wieldcmd=""
weapon1unwieldcmd=""
weapon2wieldcmd=""
weapon2unwieldcmd=""
weapon1=function(wield)
	weaponid=GetVariable("weapon")
	if weaponid=="" or weaponid==nil then return end
	if wield==false then
		if weapon1wielded~=true then return end
		if weapon1unwieldcmd=="" then
			run ("unwield "..weaponid..";remove "..weaponid)
		else
			run(weapon1unwieldcmd.." "..weaponid)
		end
		weapon1wielded=false
	else
		if weapon1wielded~=false then return end
		if weapon1wieldcmd=="" then
			run ("wield "..weaponid..";wear "..weaponid)
		else
			run(weapon1wieldcmd.." "..weaponid)
		end
		weapon1wielded=true
	end
end

weapon2=function(wield)
	weaponid=GetVariable("weapon2")
	if weaponid=="" or weaponid==nil then return end
	if wield==false then
		if weapon2wielded~=true then return end
		if weapon2unwieldcmd=="" then
			run ("unwield "..weaponid..";remove "..weaponid)
		else
			run(weapon2unwieldcmd.." "..weaponid)
		end
		weapon2wielded=false
	else
		if weapon2wielded~=false then return end
		if weapon2wieldcmd=="" then
			run ("wield "..weaponid..";wear "..weaponid)
		else
			run(weapon2wieldcmd.." "..weaponid)
		end
		weapon2wielded=true
	end
end

weapon1dru=100
weapon2dru=100
weapondru=function()
	weapon1dru=100
	weapon2dru=100
	weaponid=GetVariable("weapon")
	weaponid2=GetVariable("weapon2")
	if weaponid~="" and weaponid~=nil then
		catch("weapon1dru","look "..weaponid.." of me")
	end
	if weaponid2~="" and weaponid2~=nil then
		catch("weapon2dru","look "..weaponid2.." of me")
	end
end

weapon1_dru=function(n,l,w)
	weapon1dru=tonumber(w[1])
end
weapon2_dru=function(n,l,w)
	weapon2dru=tonumber(w[1])
end

repair={}
repair["ok"]=nil
repair["fail"]=nil
repair["weapon"]=""
do_repair=function(w,repair_ok,repair_fail)
	repair["weapon"]=w
	repair["ok"]=repair_ok
	repair["fail"]=repair_fail
	go(repairloc,repair.arrive,repair_end_fail)
end

repair["arrive"]=function()
	busytest(repair.arrivecmd)
end

repair.arrivecmd=function()
	run("repair "..repair["weapon"]..";repair "..repair["weapon"])
	busytest(repair_end_ok)
end

repair["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(repair[s])
	end
	repair["ok"]=nil
	repair["fail"]=nil
end

repair_end_ok=function()
	repair["end"]("ok")
end

repair_end_fail=function()
	repair["end"]("fail")
end

checkrepair=function(check_ok,check_fail)
	if weapon1dru<30 then
		do_repair(GetVariable("weapon"),check_ok,check_fail)
	elseif weapon2dru<30 then
		do_repair(GetVariable("weapon2"),check_ok,check_fail)
	else
		return false
	end
	return true
end

-------------------

askmasterweapon={}
askmasterweapon["ok"]=nil
askmasterweapon["fail"]=nil
askmasterweapon["weapon"]=""
askmasterweapon["time"]=0
askmasterweapon["givenpc"]=""
askmasterweapon["giveloc"]=0
do_askmasterweapon=function(_weapon,askmasterweapon_ok,askmasterweapon_fail)
	askmasterweapon["ok"]=askmasterweapon_ok
	askmasterweapon["fail"]=askmasterweapon_fail
	if masterweapon[_weapon]==nil then
		askmasterweapon["end"]()
		return
	else
		askmasterweapon["weapon"]=_weapon
		if masterweapon[_weapon].giveqi==true then
			askmasterweapon["givenpc"]="qi changfa"
			askmasterweapon["giveloc"]=kdloc
		else
			askmasterweapon["givenpc"]=masterweapon[askmasterweapon["weapon"]]["npc"]
			askmasterweapon["giveloc"]=npcs[masterweapon[askmasterweapon["weapon"]]["npc"]]["loc"]
		end
		busytest(askmasterweapon["main"])
	end
end

askmasterweapon["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(askmasterweapon[s])
	end
	askmasterweapon["ok"]=nil
	askmasterweapon["fail"]=nil
end

askmasterweapon_end_ok=function()
	askmasterweapon["end"]("ok")
end

askmasterweapon_end_fail=function()
	askmasterweapon["end"]("fail")
end

askmasterweapon["main"]=function()
	go(askmasterweapon["giveloc"],askmasterweapon.askcmd,askmasterweapon_end_fail)
end

askmasterweapon.askcmd=function()
	weapon(0)
	run("give "..askmasterweapon["weapon"].." to "..askmasterweapon["givenpc"])
	askmasterweapon["time"]=os.time()
	busytest(askmasterweapon.goask)
end

askmasterweapon.goask=function()
	go(npcs[masterweapon[askmasterweapon["weapon"]]["npc"]]["loc"],askmasterweapon.askcmd2,askmasterweapon_end_fail)
end
askmasterweapon.askcmd2=function()
	print("123")
	run("ask "..masterweapon[askmasterweapon["weapon"]]["npc"].." about "..masterweapon[askmasterweapon["weapon"]]["name"])
	busytest(askmasterweapon_end_ok)
end


checkmasterweapon=function(checkok,checkfail)
	if needaskmasterweapon() then
			do_askmasterweapon(GetVariable("weapon"),checkok,checkfail)
			return true
	end
	return false
end

needaskmasterweapon=function()
	weapon1id=GetVariable("weapon")
	if masterweapon[weapon1id]~=nil then
		mwroom=npcs[masterweapon[weapon1id]["npc"]]["loc"]
	else
		mwroom=nil
	end
	if weapon1id~=nil then
		if (masterweapon[weapon1id]~=nil and os.time()>(masterweapondelay+askmasterweapon.time)) or _roomid==mwroom then
			return true
		end
	end
	return false
end



----------------------




weapon_wieldtest=function(n,l,w)
	if weapontested=="1" then
		weapon1wieldcmd="wear"
		weapon1unwieldcmd="remove"
	else
		weapon2wieldcmd="wear"
		weapon2unwieldcmd="remove"
	end
end

weapon1test=function()
	weapontested="1"
	weaponid=GetVariable("weapon")
	if weaponid==nil or weaponid== "" then return end
	run("wield "..weaponid..";wear "..weaponid)
	catch("wieldtest","unwield "..weaponid..";remove "..weaponid)
	weapon1wielded=false
	weapon1wieldcmd="wield"
	weapon1unwieldcmd="unwield"
end






weapon2test=function()
	weapontested="2"
		weaponid=GetVariable("weapon2")
	if weaponid==nil or weaponid== "" then return end
	run("wield "..weaponid..";wear "..weaponid)
	catch("wieldtest","unwield "..weaponid..";remove "..weaponid)
	weapon2wielded=false
	weapon2wieldcmd="wield"
	weapon2unwieldcmd="unwield"
end
