drop={}
drop["ok"]=nil
drop["fail"]=nil
drop.item=""
do_drop=function(dropitem,drop_ok,drop_fail)
	drop["ok"]=drop_ok
	drop["fail"]=drop_fail
	drop.item=dropitem
	go(droploc,drop.arrive,drop_end_fail)
end

drop["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(drop[s])
	end
	drop["ok"]=nil
	drop["fail"]=nil
end

drop_end_ok=function()
	drop["end"]("ok")
end

drop_end_fail=function()
	drop["end"]("fail")
end

drop["arrive"]=function()
	busytest(drop.dropcmd)
end

drop["dropcmd"]=function()
	run("drop "..drop.item)
	busytest(drop_end_ok)
end

checkdrop=function(_droplist,drop_ok,drop_fail)
	for i,v in pairs(_droplist) do
		if itemsnum(i)>0 then
			do_drop(v,drop_ok,drop_fail)
			return true
		end
	end
end

sell={}
sell["ok"]=nil
sell["fail"]=nil
sell.item=""
sell.loc=sellloc
do_sell=function(sellitem,sell_ok,sell_fail,sell_loc)
	sell["ok"]=sell_ok
	sell["fail"]=sell_fail
	sell.item=sellitem
	if sell_loc~=nil then
		sell.loc=sell_loc
	else
		sell.loc=sellloc
	end
	go(sell.loc,sell.arrive,sell_end_fail)
end

sell["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(sell[s])
	end
	sell["ok"]=nil
	sell["fail"]=nil
end

sell_end_ok=function()
	sell["end"]("ok")
end

sell_end_fail=function()
	sell["end"]("fail")
end

sell["arrive"]=function()
	busytest(sell.sellcmd)
end

sell["sellcmd"]=function()
	sellnum=getnum(sell.item.sellmax)
	if itemsnum(sell.item.name)<sellnum then
		sellnum=itemsnum(sell.item.name)
	end
	if sellnum<2 then
		run("sell "..sell.item.id)
	else
		run("sell "..tostring(sellnum).." "..sell.item.id)
	end
	busytest(sell_end_ok)
end

checksell=function(_selllist,sell_ok,sell_fail,sell_loc)
	if sell_loc==nil then
		sell_loc=sellloc
	end
	for i,v in pairs(_selllist) do
		if itemsnum(i)>0 then
			do_sell(v,sell_ok,sell_fail,sell_loc)
			return true
		end
	end
end

sell_broken=function(n,l,w)
	if brokenweapon[w[2]]~=nil then
		run("drop "..brokenweapon[w[2]])
	end
end

brokenweapon={}
brokenweapon["ËéµôµÄ¸ÖÕÈ"]="gangzhang"
brokenweapon["ËéµôµÄ³¤½£"]="long sword"
brokenweapon["ËéµôµÄ¸Öµ¶"]="blade"
brokenweapon["ËéµôµÄÒøÂÖ"]="yin lun"
brokenweapon["ËéÁÑµÄ¸ÖÕÈ"]="gangzhang"
brokenweapon["ËéÁÑµÄ³¤½£"]="long sword"
brokenweapon["ËéÁÑµÄ¸Öµ¶"]="blade"
brokenweapon["ËéÁÑµÄÒøÂÖ"]="yin lun"
