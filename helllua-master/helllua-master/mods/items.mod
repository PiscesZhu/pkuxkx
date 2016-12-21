itemlist={}
on_itemsstart=function(name, line, wildcards)
	mypass={}
	titemlist={}
	EnableTrigger("on_items",true)
end
on_itemsend=function(name, line, wildcards)
	itemlist=titemlist
	EnableTrigger("on_items",false)
end
mypass={}
on_items=function(name, line, wildcards)
	_item,num=getitemnum(wildcards[2])
	titemlist[_item]=num
	titemlist[wildcards[3]]=num
	if wildcards[3]=="pass" then
		if housepass[_item]~=nil then
			mypass[housepass[_item].name]=true
			print("找到:"..housepass[_item].name.."的pass")
		else
			print("没有找到--".._item.."对应的pass,请检查house.ini")
		end
	end
end
on_itemsground=function(name, line, wildcards)
end

item={}
item["item"]=""
item["go"]=function(itemname,itemnum,item_ok,item_fail)
	item["ok"]=item_ok
	item["fail"]=item_fail
	item["item"]=itemname
	item["num"]=itemnum
	if items[item["item"]]==nil then
		item["end"]("fail")
		return
	end
	go(items[item["item"]]["loc"],item["arrive"],itemendfail)
end

do_item=item["go"]

itemendfail=function()
	item["end"]("fail")
end
itemendok=function()
	item["end"]("ok")
end
item["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(item[s])
	end
	item["ok"]=nil
	item["fail"]=nil
end

item["arrive"]=function()
	if itemlist[item["item"]]==nil then
		num=0
	else
		num=itemlist[item["item"]]
	end
	if item["num"]>num then
		busytest(item[items[item["item"]]["type"]])
	else
		busytest(itemendok)
	end
end

item["buy"]=function()
	num=getnum(items[item["item"]]["buymax"])
	if (num <2) then
		run("buy "..items[item["item"]]["id"].." from "..items[item["item"]]["npc"])
	else
		num2=item["num"]-itemsnum(item["item"])
		if num>num2 then num=num2 end
		run("buy "..tostring(num).." "..items[item["item"]]["id"].." from "..items[item["item"]]["npc"])
	end
	getinv()
	delay(1,item["arrive"])
end
item["cmd"]=function()
	run(items[item["item"]]["cmd"])
	run("i")
	busytest(item["arrive"])
end

itemsnum=function(name,pack)
	if pack=="" or pack==nil or pack=="me" then
		return(getnum(itemlist[name]))
	else
		if bags[pack]==nil then
			return 0
		else
			return(getnum(bags[pack][name]))
		end
	end
end

checkitems=function(_items,check_ok,check_fail)
	for i,v in pairs(_items) do
		if itemsnum(i)<v["min"] then
			print(items[i]["id"])
			item["go"](items[i]["name"],v["max"],check_ok,check_fail)
			return true
		end
	end
	return false
end


loadmod("drop.mod")

----------------------

tbaglist={}
_bagname=""
bags={}
bagscount={}
on_bagsstart=function(name, line, wildcards)
	_bagname=wildcards[2]
	tbaglist={}
	EnableTrigger("on_bagitems",true)
end
on_bagsend=function(name, line, wildcards)
	bags[_bagname]=tbaglist
	EnableTrigger("on_bagitems",false)
end
on_bagitems=function(name, line, wildcards)
	_item,num=getitemnum(wildcards[1])
	bagscount[_bagname]=bagscount[_bagname]+1
	tbaglist[_item]=num
	tbaglist[wildcards[2]]=num
end

getbagitems=function(bagname)
	bagscount[bagname]=0
	catch("bagitem","set no_more getbag-"..bagname..";l "..bagname..";set no_more getbagend")
end
checkbagsitem=function(_bags,check_ok,check_fail)
		for bi,bv in pairs(_bags) do
		for i,v in pairs(bv) do
			if getnum(bags[bi][i])<v["min"] then
				do_buyinpack(items[i]["name"],bi,v["max"],check_ok,check_fail)
				return true
			end
		end
	end
	return false
end
----------------------

buyinpack={}
buyinpack["ok"]=nil
buyinpack["fail"]=nil
buyinpack["item"]=""
buyinpack["pack"]=""
buyinpack["num"]=0

do_buyinpack=function(_item,_bag,num,buyinpack_ok,buyinpack_fail)
	buyinpack["ok"]=buyinpack_ok
	buyinpack["fail"]=buyinpack_fail
	buyinpack["item"]=_item
	buyinpack["pack"]=_bag
	buyinpack["num"]=getnum(num)
	if items[buyinpack["item"]]==nil then
		buyinpack["end"]("fail")
		return
	end
	go(items[buyinpack["item"]]["loc"],buyinpack["arrive"],buyinpack_end_fail)
end

buyinpack["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(buyinpack[s])
	end
	buyinpack["ok"]=nil
	buyinpack["fail"]=nil
end

buyinpack_end_ok=function()
	buyinpack["end"]("ok")
end

buyinpack_end_fail=function()
	buyinpack["end"]("fail")
end

buyinpack["main"]=function()

end
buyinpack["arrive"]=function()
	if bags[buyinpack["pack"]][buyinpack["item"]]==nil then
		num=0
	else
		num=bags[buyinpack["pack"]][buyinpack["item"]]
	end
	if buyinpack["num"]>num then
		busytest(buyinpack[items[buyinpack["item"]]["type"]])
	else
		busytest(buyinpack_end_ok)
	end
end

buyinpack["buy"]=function()
	num=getnum(items[buyinpack["item"]]["buymax"])
	if (num <2) then
		run("buy "..items[buyinpack["item"]]["id"].." from "..items[buyinpack["item"]]["npc"])
	else
		num2=item["num"]-itemsnum(buyinpack["item"])
		if num>num2 then num=num2 end
		run("buy "..tostring(num).." "..items[buyinpack["item"]]["id"].." from "..items[buyinpack["item"]]["npc"])
	end
	run("put "..items[buyinpack["item"]]["id"].." in "..buyinpack["pack"])
	getinv()
	delay(1,buyinpack["arrive"])
end
buyinpack["cmd"]=function()
	run(items[buyinpack["item"]]["cmd"])
	run("i")
	busytest(buyinpack["arrive"])
end


----- 吃喝模块-----------
tofill=0
if foodpack==nil or foodpack=="" then
	_food=items[food].id
else
	_food=items[food].id .. " in "..foodpack
	if #foodpack>6 then
		if string.sub(foodpack,#foodpack-5,#foodpack)==" of me" then
			_food=string.sub(_food,1,#_food-6,#_food)
		end
	end
end

	_drink=items[drink].id.." "
if drinkpack==nil or drinkpack=="" then
	_drinkpack=""
else
	_drinkpack=" in "..drinkpack
	if #_drinkpack>6 then
		if string.sub(_drinkpack,#_drinkpack-5,#_drinkpack)==" of me" then
			_drinkpack=string.sub(_drinkpack,1,#_drinkpack-6,#_drinkpack)
		end
	end
end
if drinkpack==nil then drinkpack="" end

if items[drink]~=nil then
	drinkcname=items[drink].name
else
	drinkcname=""
end

if  drinkcname==nil then drinkcname="" end

SetTriggerOption("item_needfill","match","^(> )*你从.*那里买下了(一|二|三|四|五|六|七|八|九|十|百)+.."..drinkcname)

item_needfill=function(n,l,w)
	tofill=tofill+1
end


if foodpack~="" and foodpack~=nil then
	invbags[foodpack]={}
	if invpack[foodpack]==nil then
		invpack[foodpack]={}
	end
	invpack[foodpack][food]=food
	invbags[foodpack][food]={min=foodmin,max=foodmax}
else
	inv[food]={max=foodmax,min=foodmin}
end
if drinkpack~="" and drinkpack~=nil then
	if invbags[drinkpack]==nil then
		invbags[drinkpack]={}
	end
	if invpack[drinkpack]==nil then
		invpack[drinkpack]={}
	invpack[drinkpack][drink]=drink
	end
	invbags[drinkpack][drink]={min=drinkmin,max=drinkmax}
else
	inv[drink]={max=drinkmax,min=drinkmin}
end

lastdrink=os.time()
eatdrink=function()
	run("eat ".._food)
	local time=os.time()
	if time-lastdrunk>30 then drunk=0 end
	if drunk==0 and mudvar.powerup==nopowerup.drunk and time-lastdrink>3 then
		lastdrink=time
		if itemsnum("tihu xiang")==0 then
			run("drink jiudai")
		else
			run("smell tihu xiang")
		end
	end
	run("drink ".._drink..tostring(tofill+1).._drinkpack)
	run("drink ".._drink..tostring(tofill+2).._drinkpack)
end



checkfood=function(check_ok,check_fail)
	if getnum(bagscount[foodpack])>1 then
		do_drop(foodpack,check_ok,check_fail)
		return true
	elseif getnum(bagscount[drinkpack])>1 then
		do_drop(drinkpack,check_ok,check_fail)
		return true
	end
	return false
end

-----------------------

fill={}
fill["ok"]=nil
fill["fail"]=nil

do_fill=function(fill_ok,fill_fail)
	fill["ok"]=fill_ok
	fill["fail"]=fill_fail
	fill["max"]=tostring(math.min(tofill+1,itemsnum(drink,drinkpack)))
	go(fillloc,fill.cmd,fill_fail)
end

fill["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(fill[s])
	end
	fill["ok"]=nil
	fill["fail"]=nil
end

fill_end_ok=function()
	fill["end"]("ok")
end

fill_end_fail=function()
	fill["end"]("fail")
end

fill.cmd=function()
	if tofill<0 then
		tofill=0
		fill_end_ok()
		return
	end
	if drinkpack=="" then
		run("fill ".._drink..tostring(tofill+1))
	else
		run("get ".._drink..fill.max.." from "..drinkpack..";fill ".._drink..";put ".._drink.."in "..drinkpack)
	end
	tofill=tofill-1
	busytest(fill.cmd)
end

checkfill=function(check_ok,check_fail)
	if tofill+drinkmin>=itemsnum(drink,drinkpack) and tofill>0 then
		do_fill(check_ok,check_fail)
		return true
	end
	return false
end
