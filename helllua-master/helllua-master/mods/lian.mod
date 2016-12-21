lian={}
lian["ok"]=nil
lian["fail"]=nil
lian["list"]={}
lian.levelmax={}
lian.index=0
lian.count=0
lian.max=6

lian.needrest=false
baseskill={}
baseskill["force"]=true
baseskill["dodge"]=true
baseskill["parry"]=true
baseskill["whip"]=true
baseskill["staff"]=true
baseskill["throwing"]=true
baseskill["sword"]=true
baseskill["blade"]=true
baseskill["dagger"]=true
baseskill["hammer"]=true
baseskill["unarmed"]=true
baseskill["hand"]=true
baseskill["cuff"]=true
baseskill["cooking"]=true
baseskill["chuixiao-jiyi"]=true
baseskill["finger"]=true
baseskill["claw"]=true
baseskill["strike"]=true
baseskill["club"]=true

lianskillre=rex.new("([^;,]+)")
lianjifare=rex.new("^(?<base>.*?)(\\.(?<jifa>[^<]+)){0,1}(<(?<levelmax>.*)){0,1}$")
do_lian=function(lianlist,lian_ok,lian_fail)
	lian["ok"]=lian_ok
	lian["fail"]=lian_fail
	lian.count=0
	lian.index=1
	lian.list={}
	lian.levelmax={}
	lian.subskill={}
	lian.needrest=false
	lian.getskill(lianlist)
	cha()
	getstatus(lian.status)
end

lian.resume=function()
	getstatus(lian.status)
end


lianwield=function()
	weapon(3)
end

lianrest=function()
	lian.needrest=true
end
lian.getskill=function(str)
	n=lianskillre:gmatch(str,function (m, t)
		lian.count=lian.count+1
		s,e,t=lianjifare:match(m)
		m=""
		if baseskill[t.base] then
			if t.jifa~=false then
				m="jifa "..t.base.." "..t.jifa..";"
				lian.subskill[lian.count]=t.jifa
			end
			m=m.."lian "..t.base.." 50"
		else
			m="du "..t.base.." 100"
		end
		if m~=nil and m~="" then
			print("加入练功列表 "..tostring(lian.count)..":"..m)
			lian.list[lian.count]=m
			if t.levelmax==false then
				lian.levelmax[lian.count]=0
			else
				lian.levelmax[lian.count]=getnum(tonumber(t.levelmax))
			end
		end
	end)
end
lian.neilibeforce=0
lian.times=0

lian.getstatus=function()
	getstatus(lian.status)
end
lian.status=function()
	lian.neilibeforce=getnum(me.hp.neili)
	lian.times=0
	busytest(lian.main)
end


lian["main"]=function()
	if quest.stop==true then
		lian["end"]()
		return
	end
	getstatus(lian["check"])
end

lian["check"]=function()
	if miss10lv=="" or miss10lvloc<0 then
		lian.loc=getnum(safeloc)
	else
		lian.loc=miss10lvloc
	end
	if do_check(lian.getstatus) then
	elseif 	lian.needrest==true then
		lian.needrest=false
		do_rest(lian.getstatus,lian.getstatus)
	else
		go(lian.loc,lian.arrive,lian_end_fail)
	end
end


lian.arrive=function()
	if lian.neilibeforce>getnum(me.hp.neili) then
		lian.times=0
	else
		lian.times=lian.times+1
	end
	lian.qixuebeforce=getnum(me.hp.qixue)
	lian.neilibeforce=getnum(me.hp.neili)
	lian.jingbeforce=getnum(me.hp.jing)
	if lian.times<lian.max and(queryskilllv(lian.subskill[lian.index])==-1 or (queryskilllv(lian.subskill[lian.index])<getnum(lian.levelmax[lian.index])or(getnum(lian.levelmax[lian.index])==0)))then
		print("练习指令："..lian.list[lian.index])
		lian.needrest=false
		catch("lian",lian.list[lian.index])
		if lian.levelmax[lian.index]~=0 and lian.subskill[lian.index]~=nil then cha() end
		delay(1,lian.main)
		return
	end
		lian.index=lian.index+1
		if lian.index>lian.count then
			busytest(lian_end_ok)
			return
		else
			getstatus(lian.status)
			return
		end
end

lian["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(lian[s])
	end
	lian["ok"]=nil
	lian["fail"]=nil
end

lian_end_ok=function()
	lian["end"]("ok")
end

lian_end_fail=function()
	lian["end"]("fail")
end

