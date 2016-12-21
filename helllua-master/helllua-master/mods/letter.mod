letter={}
letter["ok"]=nil
letter["fail"]=nil
letter["npc"]=""
letter["city"]=""
letter["searchcount"]=0
letter.yuelimax=0
do_letter=function(letter_ok,letter_fail,yuelimax)
	letter["ok"]=letter_ok
	letter["fail"]=letter_fail
	letter.yuelimax=getnum(tonumber(yuelimax))
	setlettertri()
	letter.main()
end



letter["check"]=function()
	if do_check(letter["main"],letter["main"]) then
	elseif checkstudy(letter["main"],letter["main"]) then
	elseif checkfangqi(letter["main"],letter["main"]) then
	else
		go(familys[me.fam].masterloc,letter["questarrive"],letter_end_fail)
	end
end
letter["questarrive"]=function()
	npchere	(familys[me.fam].masterid,"give receipt to "..familys[me.fam].masterid..";quest cancel")
	busytest(letter["quest"])
end

letter.quest=function()
	if npc.nobody==1 then
		letter_end_fail()
		return
	end
	letter["npc"]=""
	run("drop receipt")
	run("quest "..familys[me.fam].masterid)
	run("quest")
	busytest(letter.questok)
end

letter.questok=function()
	if letter["npc"]=="" or (letter.city=="华山" and huashanletter~=true)then
		letter_end_fail()
		return
	end
	npc.name=letter["npc"]
	letter["searchcount"]=0
	do_npcinpath(city[letter.city].path,letter.npcfind,letter_end_fail)
end
letter.npcfind=function()
	if npc.id==nil or npc.id=="" then
		npc.id=getcnname(npc.name)
	end
	if npc.id==nil then npc.id ="" end
	npchere(npc.id,"give letter to "..npc.id)
	busytest(letter.npcgiven)
end

letter.npcgiven=function()
	if npc.nobody==1 then
		do_searchnpc(letter.npcfind,letter_end_fail)
	else
		go(familys[me.fam].masterloc,letter.receipt,letter_end_fail)
	end
end

letter.receipt=function()
	run("give receipt to "..familys[me.fam].masterid..";drop receipt")
	if letter.yuelimax~=0 then score() end
	busytest(letter_end_ok)
end
letter.loop=function()
	if letter.yuelimax==0 or letter.yuelimax>getnum(me.score.yueli) then
		busytest(letter.loopcmd)
		return
	end
	run("drop letter;drop receipt")
	letter["end"]()
	busytest(aliasaftercmd)
end
letter.loopcmd=function()
	do_letter(letter.loop,letter.loop,letter.yuelimax)
end
letter["main"]=function()
	EnableTriggerGroup("letter",true)
	if quest.stop then
		letter["end"]()
		return
	end
	run("drop letter")
	getstatus(letter["check"])
end

letter["searchend"]=function()
	letter["searchcount"]=letter["searchcount"]+1
	if letter["searchcount"]<4 then
		do_npcinpath(city[letter.city].path,letter.npcfind,letter_end_fail)
	else
		letter_end_fail()
	end
end

letter["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(letter[s])
	end
	letter["ok"]=nil
	letter["fail"]=nil
	EnableTriggerGroup("letter",false)
end

letter_end_ok=function()
	letter["end"]("ok")
end

letter_end_fail=function()
	letter["end"]("fail")
end

setlettertri=function()
	SetTriggerOption ("letter_quest", "match", "^(> )*"..familys[me.fam].mastername.."吩咐你在.*之前把信件送到(.*)手中，取回执交差。\\n据闻不久前此人曾经在(.*)。$")
end

letter_quest=function(n,l,w)
	letter.npc=w[2]
	letter.city=string.sub(w[3],1,4)
end

