skilllistre=rex.new("^(?<skill>[^<]+?)(<(?<levelmax>.*)){0,1}(\\((?<study>[[:alpha:]]+){0,1}?(-{0,1}(?<npc>[[:alpha:]]+\\s+[[:alpha:]]+)){0,1}(-{0,1}(?<npcname>[^a-zA-Z1-9 ]+)){0,1}(-{0,1}(?<loc>\\d+)){0,1}\\)){0,1}$")
study={}
study["skill"]=nil
study["ok"]=nil
study["fail"]=nil
checkstudy=function(checkok,checkfail,levelmax)
	if needstudy() then
		do_study(checkok,checkfail,levelmax)
		return true
	else
		return false
	end
end
needstudy=function()
	potmax=GetVariable("potmax")
	if potmax==nil then
		potmax=0
	else
		potmax=tonumber(potmax)
	end
	if (potmax>0) and getnum(me.hp.pot)>potmax then
		return true
	else
		return false
	end
end
study.levelmax=0
do_study=function(study_ok,study_fail,levelmax)
	study["ok"]=study_ok
	study["fail"]=study_fail
	study.levelmax=getnum(tonumber(levelmax))
	if study.skill==nil then
		study_end_fail()
		return
	end
	lastpot=0
	lastpotcount=0
	local levelmax=getnum(study.skill.levelmax)
	print(study.skill.skill)
	if study[study.skill.study]~=nil and ((levelmax==0)or(queryskilllv(study.skill.skill)<levelmax))then
		study[study.skill.study]()
	else
		study["end"]("fail")
	end
end

study_end_fail=function()
	study["end"]("fail")
end
study_end_ok=function()
	study["end"]("ok")
end

study["arrive"]=function()

end

study["end2"]=function(s)
	setupskill(study.levelmax)
	study.levelmax=0
	cha()
	if ((s~="")and(s~=nil)) then
		infoend(study[s])
	end
	study["ok"]=nil
	study["fail"]=nil
end

study["end"]=function(s)
	infoend(study["end2"],s)
end

study["xue"]=function()
	go(study.skill.loc,study["xuecmd"],study_end_fail)
end

study["xuecmd"]=function()
	if (me.hp.pot==0)or((me.hp.neili==0)and(me.hp.neilimax~=0))or(lastpotcount>7) then
		study["end"]("ok")
	else
		if me.hp.pot==lastpot then
			lastpotcount=lastpotcount+1
		else
			lastpot=me.hp.pot
			lastpotcount=1
		end
		if getnum(me.hp.pot)<100 then
			pots=me.hp.pot
		else
			pots=100
		end
		catch("study","xue "..study.skill.npc.." about "..study.skill.skill.." "..tostring(pots))
		eatdrink()
		hp()
		delay(1,study["xuecmd"])
	end
end

study["ask"]=function()
	go(study.skill.loc,study["askcmd"],study_end_fail)
end

study["askcmd"]=function()
	if (me.hp.pot<100)or((me.hp.neili==0)and(me.hp.neilimax~=0))or(lastpotcount>7) then
		study["end"]("ok")
	else
		if me.hp.pot==lastpot then
			lastpotcount=lastpotcount+1
		else
			lastpot=me.hp.pot
			lastpotcount=1
		end
		catch("study","ask "..study.skill.npc.." about "..study.skill.skill)
		eatdrink()
		hp()
		delay(1,study_end_ok)
	end
end


study["jingxiu"]=function()
	if me.fam=="武当派" or me.fam=="全真教" then
		go(familys[me.fam].dazuoloc,study["jingxiucmd"],study_end_fail)
	else
		busytest(study_end_fail)
	end
end

study["jingxiucmd"]=function()
	if (me.hp.pot<10)or((me.hp.neili==0)and(me.hp.neilimax~=0))or(lastpotcount>3) then
		study["end"]("ok")
	else
		if me.hp.pot==lastpot then
			lastpotcount=lastpotcount+1
		else
			lastpot=me.hp.pot
			lastpotcount=1
		end
		if getnum(me.hp.pot)<100 then
			pots=me.hp.pot
		else
			pots=100
		end
		eatdrink()
		run("i")
	catch("study","jingxiu "..tostring(pots))
		busytest(study["jingxiutest"],4)
	end
end

study["jingxiutest"]=function()
		hp()
		if checkitems(inv,study["jingxiu"],study_end_fail) then
			return
		else
			busytest(study["jingxiucmd"])
		end
end

study["closed"]=function()
	go(2489,study["closedcmd"],study_end_fail)
end

study["closedcmd"]=function()
	if (me.hp.pot==0)or((me.hp.neili==0)and(me.hp.neilimax~=0))or(lastpotcount>3) then
		study["end"]("ok")
	else
		if me.hp.pot==lastpot then
			lastpotcount=lastpotcount+1
		else
			lastpot=me.hp.pot
			lastpotcount=1
		end
		catch("study","closed")
		eatdrink()
		hp()
		busytest(study_end_ok,30)
	end
end



study["yanjiu"]=function()
	settags()
	go(2501,study.yanjiucmd,study.yanjiufail)
end

study["yanjiucmd"]=function()
	if (me.hp.pot==0)or((me.hp.neili==0)and(me.hp.neilimax~=0))or(lastpotcount>7) then
		study["end"]("ok")
	else
		if me.hp.pot==lastpot then
			lastpotcount=lastpotcount+1
		else
			lastpot=me.hp.pot
			lastpotcount=1
		end
		if getnum(me.hp.pot)<100 then
			pots=me.hp.pot
		else
			pots=100
		end
		catch("study","yanjiu "..study.skill.skill.." "..tostring(pots))
		eatdrink()
		hp()
		delay(1,study["yanjiucmd"])
	end

end
study["yanjiufail"]=function()
	go(-2,study.yanjiucmd,study_end_fail)
end

study["lian"]=function()
	go(-2,study.liancmd,study_end_fail)
end

study["liancmd"]=function()
	if (me.hp.pot<11)or((me.hp.neili==0)and(me.hp.neilimax~=0))or(lastpotcount>7) then
		study["end"]("ok")
	else
		if me.hp.pot==lastpot then
			lastpotcount=lastpotcount+1
		else
			lastpot=me.hp.pot
			lastpotcount=1
		end
		if getnum(me.hp.pot)<50 then
			pots=me.hp.pot
		else
			pots=50
		end
		eatdrink()
		catch("study","lian "..study.skill.skill.." "..tostring(pots))
		run("yun recover;yun regenerate; i")
		delay(1,study["liantest"])
	end

end
study["liantest"]=function()
		hp()
		if checkitems(inv,study["lian"],study_end_fail) then
		elseif checkrest(study["lian"],study_end_fail) then
		else
			busytest(study["liancmd"])
		end
end

getdefalutstudy=function()
	if study.skill.npc~=false or study.skill.npcname~=false then
		return "xue"
	else
		if getnum(tonumber(GetVariable("expmax")))<800000 then
			return "xue"
		else
			return "yanjiu"
		end
	end
end

getskillloc=function()
	if study.skill.study=="xue" then
		return study.skill.loc
	end
end
getskill=function(str)
	s,e,t=skilllistre:match(str)
	return t
end
splitre=rex.new("([^;,|]+)")
setupskill=function(levelmax)
	if levelmax==nil then
		levelmax=study.levelmax
	end
	skilllist=GetVariable("skilllist")
	if skilllist==nil then skilllist="" end
	study["skill"]={}
	_skilllist={}
	local i=0
	n=splitre:gmatch(skilllist,function (m, t)
	study["skill"]=getskill(m)
		if study["skill"]~=nil then
			if study.skill.levelmax==false then
				study.skill.levelmax=levelmax
			else
				study.skill.levelmax=getnum(tonumber(study.skill.levelmax))
			end
			if study.skill.skill=="jingxiu" then
				study.skill.loc=0
				study.skill.npc=""
				study.skill.study="jingxiu"
				study.skill.skill="taoism"
			elseif study.skill.skill=="closed" then
				study.skill.loc=0
				study.skill.npc=""
				study.skill.study="closed"
			else
				if study.skill.study==false then study.skill.study=getdefalutstudy() end
				if study.skill.npc~=false then
					if npcs[study.skill.npc]==nil then
						study.skill.npc=false
					end
				end
				if study.skill.loc==false then study.skill.loc=0 end
				if study.skill.npc==false then
					if npcs[study.skill.npcname]~=nil then
						study.skill.npc=npcs[study.skill.npcname].id
					end
				end
				if study.skill.npc==false then
					if me.fam~=nil then
						if me.score.teacher~="none" and me.score.teacher~=nil then
							if npcs[me.score.teacher]~=nil then
								study.skill.npc=npcs[me.score.teacher].id
							end
						end
					end
				end
				if study.skill.npc==false then
					study.skill.npc=""
				else
					study.skill.loc=npcs[study.skill.npc]["loc"]
				end
			end
		end
		if (study.skill.levelmax==0)or(queryskilllv(study.skill.skill)<study.skill.levelmax) then
			i=i+1
			_skilllist[i]=study.skill
		end
	end)
	if i==0 then
		study.skill=nil
		_skilllist=nil
	else
		study.skill=_skilllist[math.random(1,i)]
	end
end

study_fail=function(n,l,w)
	lastpotcount=8
end

study_needweapon=function(n,l,w)
	weapon(3)
end

study_gold=function(n,l,w)
	if studygodnpc[w[2]]~=nil then
		run("give 1 gold to "..studygodnpc[w[2]])
	end
end

studygodnpc={}
studygodnpc["朱熹"]="zhu xi"
studygodnpc["厨娘"]="chu niang"
studygodnpc["戚长发"]="qi changfa"
