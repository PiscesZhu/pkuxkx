print("Loading Status mod ok!")
me={}
me.skills={}
me.jifa={}
me.special={}
me.hp={}
me.score={}
me.items={}
me.expcheck=1
me.oldexp=0
me.oldpot=0
me.addexp=0
me.addpot=0
me.canjob=false

roominfo={}

SetVariable ("autologin","")
----************************************************************************
--------------Status 查询start----------------------------
----************************************************************************
gethpvar=function()
	cur_jing = GetVariable("jing")*1
	cur_jingli = GetVariable("jingli")*1
	cur_jingper=GetVariable("jing_percent")*1
	cur_maxjing = GetVariable("jing_max")*1
	cur_maxjingli = GetVariable("jingli_max")*1

	cur_qi = GetVariable("qixue")*1
	cur_maxqi = GetVariable("qixue_max")*1
	cur_qiper=GetVariable("qixue_percent")*1

	cur_neili = GetVariable("neili")*1
	cur_maxneili = GetVariable("neili_max")*1

	cur_food = GetVariable("food")*1
	cur_maxfood = GetVariable("food_max")*1
	cur_foodstat=GetVariable("food_stat")
	cur_pot = GetVariable("pot")*1

	cur_water = GetVariable("water")*1
	cur_maxwater = GetVariable("water_max")*1
	cur_waterstat=GetVariable("water_stat")
	cur_exp = GetVariable("exp")*1

	cur_status = GetVariable("status")
end

hp_stat_jing=function(n,l,w)
	SetVariable ("jing",w[2])
	SetVariable ("jing_max",w[3])
	SetVariable ("jing_percent",w[4])
	SetVariable ("jingli",w[5])
	SetVariable ("jingli_max",w[6])
	SetVariable ("jingli_jiali",w[7])

	me.hp["jing"]=tonumber(w[2])
	me.hp["jingmax"]=tonumber(w[3])
	me.hp["jing_percent"]=tonumber(w[4])
	me.hp["jingli"]=tonumber(w[5])
	me.hp["jinglimax"]=tonumber(w[6])
	me.hp["jiajl"]=tonumber(w[7])
end
-------------------------------------------

hp_stat_qixue=function(n,l,w)
	SetVariable ("qixue",w[1])
	SetVariable ("qixue_max",w[2])
	SetVariable ("qixue_percent",w[3])
	SetVariable ("neili",w[4])
	SetVariable ("neili_max",w[5])
	SetVariable ("neili_jiali",w[6])

	me.hp["qi"]=tonumber(w[1])
	me.hp["qimax"]=tonumber(w[2])
	me.hp["qi_percent"]=tonumber(w[3])
	me.hp["neili"]=tonumber(w[4])
	me.hp["neilimax"]=tonumber(w[5])
	me.hp["jiali"]=tonumber(w[6])
end

hp_stat_food=function(n,l,w)
	SetVariable ("food",w[1])
	SetVariable ("food_max",w[2])
	SetVariable ("pot_max",w[4])

	---print(w[4])
	if string.find (w[3],"K")~=nil then
		_num=Trim(w[3])
		_num=tonumber(Trim(string.gsub(_num,"K"," ")))*1000
	elseif string.find (w[3],"M")~=nil then
		_num=Trim(w[3])
		_num=tonumber(Trim(string.gsub(_num,"M"," ")))*1000000
	else
		--print("noK noM")
		_num=tonumber(Trim(w[3]))
	end
	--print(w[4])

	SetVariable ("pot",_num)
	--[[
	if string.find(_num,"-")~=nil then
		potplus=-1
	else
		potplus=1
	end
	--]]
	--mepot=string.match(_num,"[0-9]+",1)

	me.hp["food"]=tonumber(w[1])
	me.hp["foodmax"]=tonumber(w[2])
	me.hp["potmax"]=tonumber(w[4])
	--me.hp["pot"]=tonumber(mepot)*potplus
	me.hp["pot"]=tonumber(_num)
	
	if me.expcheck==1 then
		me.addpot=me.hp["pot"]-me.oldpot
		me.oldpot=me.hp["pot"]
	end
end


hp_stat_water=function(n,l,w)
	SetVariable ("water",w[1])
	SetVariable ("water_max",w[2])

	if string.find (w[3],"K")~=nil then
		_num=Trim(w[3])
		_num=tonumber(Trim(string.gsub(_num,"K"," ")))*1000
	elseif string.find (w[3],"M")~=nil then
		_num=Trim(w[3])
		_num=tonumber(Trim(string.gsub(_num,"M"," ")))*1000000
	else
		--print("noK noM")
		_num=tonumber(Trim(w[3]))
	end

	SetVariable ("exp",_num)

	me.hp["water"]=tonumber(w[1])
	me.hp["watermax"]=tonumber(w[2])
	me.hp["exp"]=tonumber(_num)

	if me.expcheck == 1 then
		me.expcheck=0
		me.addexp=me.hp["exp"]-me.oldexp
		me.oldexp=me.hp["exp"]
	end
	if me.expcheck==2 then
		me.expcheck=0
		SetVariable("exp_count_value",me.hp["exp"])
		Save()
	end
	local msg=""
	if GetVariable("exp_count_start")~=nil and GetVariable("exp_count_value")~=nil then
		local rbttime=os.time()-GetVariable("exp_count_start")
		local addexp=me.hp["exp"]-GetVariable("exp_count_value")
		local avgexp=math.floor(addexp/(rbttime/(60*60)))
		local tab=os.date("*t",rbttime)
		local timemsg=tab.year.."年"..tab.month.."月"..tab.day.."天"..tab.hour.."小时"..tab.min.."分钟"
		msg="挂机("..timemsg..")，共获得经验("..addexp..")，平均每小时("..avgexp..")"
	end

	--return to_int( pow(to_float(query("combat_exp")), 1.0/3.0)*2.15443469 );
	--max_level=math.ceil(math.pow(me.hp.exp*10,0.333333))+1
	max_level=math.floor(math.pow(me.hp.exp, 1.0/3.0)*2.15443469)
	if me.hp["full_neili"]==nil then me.hp["full_neili"]=0 end
	status_string=msg.."  精神："..me.hp.jing.."/"..me.hp.jingmax.."("..me.hp["jing_percent"].."%) ".." 精力："..me.hp.jingli.."/"..me.hp.jinglimax.."(+"..me.hp["jiajl"]..") ".." 气血："..me.hp.qi.."/"..me.hp.qimax.."("..me.hp["qi_percent"].."%)".."内力："..me.hp.neili.."/"..me.hp.neilimax.."(+"..me.hp["jiali"]..") ".." 食物："..me.hp.food.."/"..me.hp.foodmax.."  潜能："..me.hp.pot.."  饮水："..me.hp.water.."/"..me.hp["watermax"].."  经验："..me.hp.exp.." maxlv:"..max_level.." fullnl:"..me.hp["full_neili"]
	InfoClear()
	Info(status_string)
end
hp_stat_status=function(n,l,w)
	SetVariable ("status",w[1])
	me.hp["status"]=Trim(w[1])
end
-----------------------------------------------------------------

status_oncha=function(name, line, wildcards)

	me.skills[wildcards[3]]={name=wildcards[2],name_en=wildcards[3],lv=tonumber(wildcards[4])}
	skills_special = Replace(wildcards[3], "-", "_", true)
--Note(wildcards[2]..wildcards[4]) 
SetVariable ("skills_name_"..skills_special,wildcards[2])
SetVariable ("skills_level_"..skills_special,wildcards[4])

end

--	if( mapp(force_data[arg = query_skill_mapped("force")]) )
--		factor = force_data[arg]["factor"];
--	return to_int( pow(query_skill("force") / 1.618, 1.0 + factor / 100.0) * 20 
--        + chongmai_gift) + 1;

status_onjifa=function(name, line, wildcards)
	_special_skill = Replace(wildcards[3], "[互备]", "", true)
	--Note(wildcards[1]..wildcards[2]..wildcards[4])
	me.jifa[wildcards[2]]={name=wildcards[1],name_en=wildcards[2],skillname=_special_skill,lv=tonumber(wildcards[4])}
	SetVariable ("jifa_name_"..wildcards[2],wildcards[1])
	SetVariable ("jifa_skname_"..wildcards[2],_special_skill)
	SetVariable ("jifa_sklevel_"..wildcards[2],wildcards[4])
	local factor = 0
	--me.hp["full_neili"] = 0
	if wildcards[2]=="force" then
		for i,v in pairs(me.skills) do
			if v["name"] == wildcards[3] then
				factor = _force_data[i]["factor"]
				me.hp["full_neili"] = math.floor(math.pow(tonumber(wildcards[4]) / 1.618, 1.0 + factor / 100.0) * 20) + 1
				break
			end
			--Note("hi")
			--Note(i,v["name"])
		end
		--Note(me.skills[wildcards[2]]["name"])
		--Note(_force_data[wildcards[2]]["factor"])
	end
	--Note(me.hp["full_neili"])
end

status_onbrief=function(name, line, wildcards)
	sklevel=wildcards[1]
	skdot=wildcards[2]
end
----************************************************************************
--------------Status 查询 End-------------------------
----************************************************************************
-----**********************************************************
-----物品检查--Start--
-----**********************************************************
--[[
你身上带着十一件物品(负重 9%)：
  四十文铜钱(Coin)
  二百零六两白银(Silver)
  五盆汽锅鸡(Qiguo ji)
  一个食盒(Shi he)
  一支火折(Fire)
  一个酒瓶(Jiuping)
  一只锦盒(Jin he)
> 你满脸庄严肃穆之容，眉心和太阳穴上淡淡的罩上了一层黑气，咬紧牙关，竭力忍受痛楚。
--]]

itemnumre=rex.new("(((零|一|二|三|四|五|六|七|八|九|十|百|千|万)*)(支|顶|块|朵|面|匹|位|颗|个|把|只|粒|张|条|枚|件|柄|根|块|文|两|碗|滴|叠|些|包|点|钱|册|本|瓶|盆)){0,1}(.*)")
GetItemInfo=function(str)
	num=1
	a,b,matchs=itemnumre:match(str)
	if matchs~=nil then
		if matchs[2]~=false then
			num=ctonum(matchs[2])
			str=matchs[5]
		end
	end
	return str,num
end

---身上东西列表
--reg:^(> |)(\S*)\((.+)\)$
itemlist={}
on_items=function(name, line, wildcards)
	item,num=GetItemInfo(wildcards[2])----核心算法--返回名称和个数。
	local itemid=string.lower(wildcards[3])
	itemlist[item]=itemid
	itemlist[itemid.."num"]=num
	itemlist[itemid.."name"]=item
	--Note("itemlist[item]      itemlist[itemid..'num']    itemlist[itemid..'name']")
	Note(itemlist[item]..","..itemlist[itemid.."num"]..", "..itemlist[itemid.."name"])
	--Note(item.."::>>"..itemid..", "..num)
end


----***********************************************************************************
----***********************************************************************************
checkitem=function(itemname)
	local _chkItem=Item.new()

		_chkItem.CatchEnd=function(sItem)
				local ItemNums=0
				for i=1,#sItem do
					if sItem[i].name==itemname then
					ItemNums=sItem[i].nums
					break
					end
					end
				print(itemname,ItemNums)
			end
	_chkItem:CatchStart()
end

local _Item={ --数据结构
    name="",
    id="",
    nums=0,
}
local Itt={} --实例对象

Item={
    new=function()
     local _Itt={}
	 me.items={}
	 setmetatable(_Itt,{__index=Item})
	 _Itt.item_table={}
	 return _Itt
    end,
	item_table={},--------------------2012.01.05

	weight=function(name,line,wildcards)
		local itemweight=tonumber(wildcards[3])
		local itemnums=ctonum(wildcards[2])
		local _tb={}
		--print("::w[3]::",wildcards[3].."::")
		--print("::w[2]::",itemnums.."::")
		Itt.name="负重"
		Itt.nums=itemweight
		Itt.count=itemnums
		Itt.id="weight"

		_tb.name="负重"
		_tb.nums=itemweight
		_tb.count=itemnums
		_tb.id="weight"
		table.insert(Item.item_table,_tb)


	end,

  String=function(name,line,wildcards)
		local itemname,itemnums=getitemnum(Trim(wildcards[2]))
		local itemid=string.lower(wildcards[3])
		local _tb={}
		--print("::w[2]"..wildcards[2]..","..wildcards[3].."::")
		--print("::w[2]"..itemname..","..itemnums..","..itemid.."::")
		Itt.name=itemname
		Itt.nums=itemnums
		Itt.id=itemid
		
		if me.items[itemid]== nil then
			me.items[itemid]=itemnums
		else
			me.items[itemid]=me.items[itemid]+itemnums
		end

		_tb.name=itemname
		_tb.nums=itemnums
		_tb.id=itemid
		table.insert(Item.item_table,_tb)

  end,
  Infoover=function()
  	world.EnableTriggerGroup("q_iteminfo",false)
	world.DeleteTriggerGroup("q_iteminfo")
	infoend(Item.Catch)
  end,

  Catch=function()
	coroutine.resume(Item.catch_co)
  end,
  catch_co=nil,
}
-------你身上带著下列这些东西(负重 56%)：
-------你身上带著下列这些东西(负重 25%)：
-------你身上带着二十二件物品(负重 25%)：
function Item:CreatTrigger()
addtri("chkitem_string1","^(> |)你身上带着(\\S*)件物品\\(负重\\s*(\\d*)%\\)\\w*","q_iteminfo","Item.weight")
addtri("chkitem_string","^(> |)(.*)\\((.+)\\)$","q_iteminfo","Item.String")
addtri("chkitem_infoover", "^(> |)你目前还没有任何为 checkitemover 的变量设定。\\w*","q_iteminfo","Item.Infoover","",150)

SetTriggerOption("delay","omit_from_output",1)
end

function Item:Setlook() --方向
	wait.make(function()
      run("set no_more itemcheck;i;look shi he;set checkitemover")

	  local l,w=wait.regexp('(> |)设定环境变量：no_more = "itemcheck"$',2)
	  if l==nil then  --异常
	     self:CatchStart()
         return
	  end
	  if string.find(l,"itemcheck") then
	     EnableTriggerGroup("q_iteminfo",1)
		 ------Item.InfoStart()
		 return
	  end
	  wait.time(2)
	end)
end
function Item:CatchEnd(Item_Table) --回调函数
	--print("::默认Item项目回调函数::")
	----2011.01.07::debug，Item_Table无法直接print，因为是local 变量，但是可以传递参数。
end
function Item:CatchFail() --回调函数

end


function Item:CatchStart() --回调函数

  Item.catch_co=coroutine.create(function()
      Itt={}
	  setmetatable(Itt,{__index=_Item})
      self:CreatTrigger()
	  EnableTriggerGroup("q_iteminfo",false)
	  self:Setlook()
	  coroutine.yield() --挂起
		local Item_Table
		Item_Table=Item.item_table
		Item.item_table={}
      self.CatchEnd(Item_Table)-----------------??

  end)
  coroutine.resume(Item.catch_co)
end
--[
function testItemInfo()
--usage:
	local Ic=Item.new()
	Ic:CatchStart()
	Ic.CatchEnd=function(pp)
		tprint(pp)
		print("-----------")
		tprint(me.items)
	end
end
--]
----***********************************************************************************
----***********************************************************************************
-----**********************************************************
npclist={}
npcname_table={}
----"十二个壮汉"
on_npcs=function(name, line, wildcards)
	local npcname_table=utils.split(wildcards[2]," ")
	local fullnpcname=npcname_table[table.maxn(npcname_table)]
	local npcid=string.lower(wildcards[3])

	npcname,num=GetItemInfo(wildcards[2])

	npclist[npcname]={["id"]=npcid,["num"]=num,}
	npclist[fullnpcname]={["id"]=npcid,["num"]=num,}
	npclist[npcid]={["name"]=npcname,["num"]=num,}
	--Note("itemlist[item]      itemlist[itemid..'num']    itemlist[itemid..'name']")
	Note("ID：>>"..npclist[npcname]["id"].."<<名字::>>"..npclist[npcid]["name"].."<<数量::>>"..npclist[npcname]["num"])
	----fight={}
	local fightnpc={}

	if fightnpc.name~=nil then
		print(fightnpc.name)
		fightnpc.ishere,ishere=string.find (fullnpcname,fightnpc.name)
		if fightnpc.ishere~=nil then
			fightnpc.id=npclist[fullnpcname]["id"]
			Note("===Fight NPC Name>>::"..fightnpc.name.."::<< Fight NPC ID：>>::"..fightnpc.id.."::<<")
		end
	end
end
-----**********************************************************
-----物品检查--End--
-----**********************************************************
function hp_check(f)
	if me.hp["jing"]<(me.hp["jingmax"]*2/3) then run("yun regenerate") end
	if me.hp["jingli"]<(me.hp["jinglimax"]*2/3) then run("yun refresh") end
	
	if me.hp["qi_percent"]<100 and me.jifa["force"]["lv"]>=50 and me.hp["neilimax"]>200 and me.hp["neili"]>50 then
		run("yun heal")
	elseif me.hp["neili"]<(me.hp["neilimax"]*2*4/5) then
		jifa_sklevel_force=tonumber(me.jifa["force"]["lv"])-1
		MaxNum_dazuo=2*tonumber(jifa_sklevel_force)*10
		dazuonum=need_dznum(me.hp.qi,me.hp.qimax,me.hp.neili,me.hp.neilimax)
		dazuonum=math.ceil(math.min((tonumber(jifa_sklevel_force)*10/100+1)*2,dazuonum))
		if dazuonum < 10 then
			dazuonum = 10
		end
		run("dazuo "..dazuonum)
	else				-- 练技能
		--local noweapon={"force","hand","dodge","strike","finger","cuff","kick","claw"}
		--local useweapon={"blade","sword","club","stick","pike","staff","axe","whip","hammer","hook","stroke"}
		for k,v in pairs(me.jifa) do
			--if findstrlist(k, noweapon)
			run("lian "..k.." 10")
		end
	end
	busytest(f)
end
cha=function()
	me.skills={}
	trigrpon("skills")
	if chacmd==nil then
		run("skills")
	else
		run(chacmd)
	end
	trigrpoff("skills")
end
hp=function()
	trigrpon("status")
	run("hp")
	--trigrpoff("status")
end
--------------------------
getinfo=function(func,...)
	run("cha;score;jifa;hp")
	infoend(func,...)
end
gethp=function(func,...)
	run("hp")
	infoend(func,...)
end
getcha=function(func,...)
	cha()
	infoend(func,...)
end
getskill=function(skillid,func,...)
	run("skbrief "..skillid)
	infoend(func,...)
end
getjifa=function(func,...)
	jifa()
	infoend(func,...)
end
getroom=function(func,...)
	run("look")
	infoend(func,...)
end

--------------------------
npcid=nil
jifa=function()
	trigrpon("skills")
	run("jifa")
	trigrpoff("skills")
end
checkidhere=function(name)
	cnpcid=nil
	local idhere_tri={
		"^("..name..")\\s+=\\s+(.+)",
	}
	local l_tri=linktri(idhere_tri)
	run("id here")
	wait.make(function()
		local l,w=wait.regexp(l_tri,10)
		if string.find(l,"=") then
			npcid=utils.split(w[4], ",")
			npcid=npcid[1]
		end
	end)
end
--[[
idhere=function()
	trigrpon("here_npcs")
	run("id here")
	trigrpoff("here_npcs")
end
--]]
-----**********************************************************
-----**********************************************************
npc={name="",id="",loc=-1,nobody=0}
npc_nobody=function(n,l,w)
	npc.ishere=0
end

--/npchere("sheng", gethp, getcha)
npchere=function(npcid,npchereend_ok,npchereend_fail)

	npc.ishere=1

	npchere_b={}
	npchere_b=npctest.new()
	npchere_b.npcid=npcid


	npchere_b.finish=function()
		-- Note("::NPC is here Now::")
		npc.ishere=1
		call(npchereend_ok)
	end

	npchere_b.fail=function()
		npc.ishere=0
		-- Note("::NPC is Not here::")
		call(npchereend_fail)
		end
		npchere_b:check()
end

----npcherecmd="shou "..npcid
npctest={
	interval=1,
	timeout=10,
	npcid="",
  new=function()
     local nn={}
	 setmetatable(nn,{__index=npctest})
	 return nn
 end,
}

function npctest:finish()
end
function npctest:fail()
end


--npcherecmd="shou "..npctest["npcid"]..";set no_more nobody"
function npctest:check()
	 wait.make(function()
		run("claw "..self["npcid"]..";set no_more nobody")
		local l,w=wait.regexp('^(> |)(你飞起一爪，挠了(.+)个满脸开花！|设定环境变量：no_more = "nobody"$)',self.timeout) --超时
		if l==nil then
			print "网络太慢或是发生了一个非预期的错误"
			self:check()
			return
		end
		if string.find(l,"你飞起一爪") then
			self:finish()
			return
		elseif string.find(l,'设定环境变量：no_more = "nobody"') then
			self:fail()
			return
		end
		wait.time(self.timeout)
	end)

end


-----**********************************************************

herenpc={}
here_npcid={}
here_npcname={}
here_npcidtable={}

herenpc.idhere=function(n,l,w)
	here_npcidtable=utils.split (w[4],",")
	if w[3]~= nil then
		here_npcid[w[3]]=here_npcidtable[1]
		here_npcname[here_npcidtable[1]]=w[3]
	end
	---print(here_npcname[here_npcidtable[1]],here_npcidtable[1])
end

-----**********************************************************
-----**********************************************************
-----**********************************************************
checkitok=function(item,condition,goal,checkitok_endok,checkitok_endfail,actTxt)

	_chk=checkit.new()
	_chk.item=item
	_chk.condition=condition
	_chk.goal=goal
	_chk.actTxt=actTxt
	_chk.over=checkitok_endok
	_chk.fail=checkitok_endfail
	gethpvar()
	_chk:check()
end
-----------------------------------------------------------------------
checkit={
interval=0.3,
item="hp",
condition="neili",
goal=1000,
actTxt=" 未达到！",
	new=function()
     local ck={}
	 setmetatable(ck,{__index=checkit})
	 return ck
 end,
}
function checkit:over()
end

function checkit:fail()
end

function checkit:check()
wait.make(function()

	if self.item=="hp" then
		run("hp")
	elseif self.item=="skills" or self.item=="cha" then
		run("hp;cha;jifa")
	elseif self.item=="score" or self.item=="sc" then
		run("hp;score")
	end
    wait.time(self.interval)

      if checkstatus(self.item,self.condition,self.goal) then
		self:over()
	  else
		self:fail()
	  end
   end)
end
-----------------------------------------------------------------------

checkstatus=function(item,condition,goal)
----need run("hp;cha;jifa") before.
----need item,goal,condition is not Nil
----getinfo(hp_stat)
----if predata==nil then predata=100 end
----print(condition,goal)
----gethpvar()-->>Error

conditionlist=
{
["jing"]="精神达到：",["maxjing"]="最大精神达到：",
["jingli"]="精力达到：",["maxjingli"] ="最大精力达到：",
["qi"]="气血达到：",["jing_percent"]="精神比达到：",["qi_percent"]="气血比达到：",

["maxqi"]="最大气血达到：",["neili"]="内力达到：",["maxneili"]="最大内力达到：",

["maxneiliadd"]="最大内力达到：",["maxjingliadd"]="最大精力达到：",


["curmaxqi"]="气血达到（最大气血"..goal.."倍）：",
["curmaxjing"]="精神达到（最大精神"..goal.."倍）：",
["curmaxneili"]="内力达到（最大内力"..goal.."倍）：",
["curmaxjingli"]="精力达到（最大精力"..goal.."倍）：",

["curneili"]="内力达到（初始内力的"..goal.."倍）：",
["curjingli"]="精力达到（初始精力的"..goal.."倍）：",


["food"]="食物值达到：",["foodmax"]="食物最大值达到：",
["foodstat"]="用餐状态：",["water"]="饮水值达到：",["watermax"]="饮水最大值达到：",["waterstat"]="饮水状态：",
["status"]="状态：",["exp"] ="经验达到：",["pot"]="潜能达到：",

}

CheckisOK=false

	if item=="hp" then

		if conditionlist[condition]==nil then
			print(itemlist[item],conditionlist[condition])
			print("::没有相关的比较项目或条件缺失::")
			return false
		end

		if condition=="jing" then
		condition_txt="精神达到："
		CheckisOK=(tonumber(me.hp.jing)>=tonumber(goal))
		elseif condition=="maxjing" then
		condition_txt="最大精神达到："
		CheckisOK=(tonumber(me.hp.maxjing)>=tonumber(goal))
		elseif condition=="jingli" then
		condition_txt="精力达到："
		CheckisOK=(tonumber(me.hp.jingli)>=tonumber(goal))
		elseif condition=="maxjingli" then
		condition_txt="最大精力达到："
		CheckisOK=(tonumber(me.hp.jinglimax)>=tonumber(goal))
		elseif condition=="qi" then
		condition_txt="气血达到："
		CheckisOK=(tonumber(me.hp.qi)>=tonumber(goal))
		elseif condition=="jing_percent" then
		condition_txt="精神比达到："
		CheckisOK=(tonumber(me.hp["jing_percent"])>=tonumber(goal))
		elseif condition=="qi_percent" then
		condition_txt="气血比达到："
		CheckisOK=(tonumber(me.hp["qi_percent"])>=tonumber(goal))

		elseif condition=="maxqi" then
		condition_txt="最大气血达到："
		CheckisOK=(tonumber(me.hp.qimax)>=tonumber(goal))
		elseif condition=="neili" then
		condition_txt="内力达到："
		CheckisOK=(tonumber(me.hp.neili)>=tonumber(goal))
		elseif	condition=="maxneili" then
		condition_txt="最大内力达到："
		CheckisOK=(tonumber(me.hp.neilimax)>=tonumber(goal))
-------------------------------------------------------------------------------
		------underline :::need gethpvar()
		elseif	condition=="maxneiliadd" then-------------------------????????????
		condition_txt="最大内力达到："
		CheckisOK=(tonumber(me.hp.neilimax)>=tonumber(goal)+cur_maxneili)

		goal=tonumber(goal)+cur_maxneili
		elseif	condition=="maxjingliadd" then
		condition_txt="最大精力达到："
		CheckisOK=(tonumber(me.hp.jinglimax)>=tonumber(goal)+cur_maxjingli)
		goal=tonumber(goal)+cur_maxjingli
-------------------------------------------------------------------------------
		elseif	condition=="curmaxjing" then
		condition_txt="精神达到（最大精神"..goal.."倍）："
		CheckisOK=(tonumber(me.hp.jingli)>=tonumber(goal)*cur_maxjing)
		goal=tonumber(goal)*cur_maxjing

		elseif	condition=="curmaxqi" then
		condition_txt="气血达到（最大气血"..goal.."倍）："
		CheckisOK=(tonumber(me.hp.qi)>=tonumber(goal)*cur_maxqi)
		goal=tonumber(goal)*cur_maxqi

		elseif	condition=="curmaxneili" then
		condition_txt="内力达到（最大内力"..goal.."倍）："
		CheckisOK=(tonumber(me.hp.neili)>=tonumber(goal)*cur_maxneili)
		goal=tonumber(goal)*cur_maxneili
		elseif	condition=="curmaxjingli" then
		condition_txt="精力达到（最大精力"..goal.."倍）："
		CheckisOK=(tonumber(me.hp.jingli)>=tonumber(goal)*cur_maxjingli)
		goal=tonumber(goal)*cur_maxjingli
		elseif condition=="curneili" then
		condition_txt="内力达到（初始内力的"..goal.."倍）："
		CheckisOK=(tonumber(me.hp.neili)>=tonumber(goal)*cur_neili)
		goal=tonumber(goal)*cur_maxjingli
		elseif condition=="curjingli" then
		condition_txt="精力达到（初始精力的"..goal.."倍）："
		CheckisOK=(tonumber(me.hp.jingli)>=tonumber(goal)*cur_jingli)
		goal=tonumber(goal)*cur_jingli
-------------------------------------------------------------------------------

		elseif	condition=="food" then
		condition_txt="食物值达到："
		CheckisOK=(tonumber(me.hp.food)>=tonumber(goal))
		elseif	condition=="foodmax" then
		condition_txt="食物最大值达到："
		CheckisOK=(tonumber(me.hp.foodmax)>=tonumber(goal))

		elseif	condition=="foodstat" then
		condition_txt="用餐状态："
		CheckisOK=(Trim(me.hp.foodstat)==Trim(goal))

		elseif	condition=="water" then
		condition_txt="饮水值达到："
		CheckisOK=(tonumber(me.hp.water)>=tonumber(goal))
		elseif	condition=="watermax" then
		condition_txt="饮水最大值达到："
		CheckisOK=(tonumber(me.hp.watermax)>=tonumber(goal))
		elseif	condition=="waterstat" then
		condition_txt="饮水状态："
		CheckisOK=(Trim(me.hp.waterstat)==Trim(goal))
-------------------------------------------------------------------------------
		elseif	condition=="status" then
		condition_txt="状态："
		CheckisOK=(Trim(me.hp.status)==Trim(goal))
-------------------------------------------------------------------------------
		elseif	condition=="exp" then
		condition_txt="经验达到："
		CheckisOK=(tonumber(me.hp.exp)>=tonumber(goal))
		elseif	condition=="pot" then
		condition_txt="潜能达到："
		CheckisOK=(tonumber(me.hp.pot)>=tonumber(goal))
		end
-------------------------------------------------------------------------------
	elseif item=="skills" or item=="cha" then
		----condition为skills的英文代码如：huagong-dafa
		----goal就是目标level
		---getskill(condition,checkstatus,item,condition,goal)
			for key,value in pairs(me.skills) do
					if key==condition then
					_curlevel=value.lv
					_curname=value.name
					break
				end
			end
			if _curname~=nil then
			condition_txt="技能：【".._curname.."】达到："
			end
			if _curlevel==nil then
			Note(":::>>>没有找到您技能所对应的级别<<<:::")
			_curlevel=100000
			----return false
			end
		CheckisOK=(tonumber(_curlevel)>=tonumber(goal))
	end
-------------------------------------------------------------------------------
	if CheckisOK==true then
	Note("目标：【"..condition_txt.." "..goal.."】已经达到！")
	else
	Note("目标：【"..condition_txt.." "..goal.."】未达到！")
	end
	item=""
	condition=""
	goal=""
	actTxt=""
	return CheckisOK
end
---**************************************************
onlogin=function(n,l,w)
	--tprint(w)
	--Note(l)
	run("no;"..GetAlphaOption("player"))
	DoAfter(5, GetAlphaOption("password"))
	DoAfter(5.1, "yes")
	DoAfter(5.2, GetVariable ("autologin"))
	DoAfterSpecial(5.3, GetVariable ("autologin"), 12)
end

room={}
get_exits1=function(n,l,w)
	local exits=nil
	exits = (string.gsub(w[1], " 和 ", "、"))
	exits = strexplit(exits, "、")
	roominfo["exits"]=exits
	table.sort(roominfo["exits"]) 
	room["exits"]=table.concat(roominfo["exits"], "|")
	--walk:setentrance(roominfo["exits"])
end
get_exits2=function(n,l,w)
	local exits=nil
	roominfo["name"]=w[2]
	room["name"]=string.gsub(roominfo["name"], "^%s*(.-)%s*$", "%1")
	--walk:setroomname(roominfo["name"])
	exits = (string.gsub(w[3], " 和 ", "、"))
	exits = strexplit(exits, "、")
	roominfo["exits"]=exits
	table.sort(roominfo["exits"]) 
	room["exits"]=table.concat(roominfo["exits"], "|")
	--walk:setentrance(roominfo["exits"])
end
get_exits3=function(n,l,w)
	roominfo["name"]=w[2]
	room["name"]=string.gsub(roominfo["name"], "^%s*(.-)%s*$", "%1")
	--walk:setroomname(roominfo["name"])
	roominfo["desc"]=w[3]
	room["desc"]=string.gsub(roominfo["desc"], "^%s*(.-)%s*$", "%1")
	--walk:setdesc(roominfo["desc"])
end

score_onsex=function(n,l,w)
	if w[1]=="男性" then
		me.score["sex"]=1
	elseif w[1]=="女性" then
		me.score["sex"]=2
	elseif w[1]=="无性" then
		me.score["sex"]=3
	end
end
score_onshen=function(n,l,w)
	me.score["shen"]=w[2]
end
score_onname=function(n,l,w)
	me.charname=w[1]
end
score_onid=function(n,l,w)
	me.charid=string.lower(w[1])
end
score_onbank=function(n,l,w)
	if string.find(w[1], "亏空无余")  or string.find(w[1], "很少") then
		me.score["gold"]=0
	end
	local i,j,v=string.find(w[1],"(.+)两黄金%S")
	if v~=nil then
		me.score["gold"]=ctonum(v)
	end
end
score_onfamily=function(n,l,w)
	--#call %comset(xkxGPS,"EntranceCondition","condition is null");
	if w[1]=="古墓派" then
		me.menpai="gm"
	elseif w[1]=="大理段家" then
		me.menpai="dl"
	elseif w[1]=="桃花岛" then
		me.menpai="th"
	elseif w[1]=="星宿派" then
		me.menpai="xx"
	elseif w[1]=="明教" then
		me.menpai="mj"
	elseif w[1]=="雪山派" then
		me.menpai="xs"
	elseif w[1]=="血刀门" then
		me.menpai="xs"
	elseif w[1]=="全真教" then
		me.menpai="qz"
		me.fjmaster="马钰"
		me.fjmasternick="掌教马钰"
		me.fjmasterid="ma"
		me.fjbaseid=792
		me.fjnpcname="魔教弟子"
		me.fjnpcid="mojiao"
		me.menpailingwuid=808
		me.menpaiJobStart=782
		me.menpaiLimited=6000
		me.dazuobaseid=785
		me.chongmaiBaseid=785
		--#if @set_GbSecretWay {#call %comset(xkxGPS,"EntranceCondition","(condition is null or condition='dong' or condition='qz') and id<>3247")} {#call %comset( xkxGPS, "EntranceCondition", "(condition is null or condition='qz')")}};
	elseif w[1]=="武当派" then
		me.menpai="wd"
		me.fjmaster="张三丰"
		me.fjmasternick="掌门人张真人"
		me.fjmasterid="zhang sanfeng"
		me.fjbaseid=677
		me.fjnpcname="蒙古哒子"
		me.fjnpcid="dazi"
		me.menpailingwuid=687
		me.menpaiJobStart=705
		me.menpaiLimited=5000
		me.dazuobaseid=0
		me.chongmaiBaseid=1422
		--#if @set_GbSecretWay {#call %comset(xkxGPS,"EntranceCondition","(condition is null or condition='dong') and id<>3247")}};
	elseif w[1]=="少林派" then
		me.menpai="sl"
		me.fjmaster="玄慈大师"
		me.fjmasternick="玄慈方丈"
		me.fjmasterid="dashi"
		me.fjbaseid=1651
		me.fjnpcname="强盗"
		me.fjnpcid="qiang dao"
		me.menpailingwuid=1653
		me.menpaiJobStart=1553
		me.menpaiLimited=4000
		me.dazuobaseid=0
		me.chongmaiBaseid=1422
		--#if @set_GbSecretWay {#call %comset(xkxGPS,"EntranceCondition","(condition is null or condition='dong') and id<>3247")}};
	elseif w[1]=="峨嵋派" then
		me.menpai="em"
		me.fjmaster="灭绝师太"
		me.fjmasternick="掌门灭绝师太"
		me.fjmasterid="miejue"
		me.fjbaseid=372
		me.fjnpcname="魔教弟子"
		me.fjnpcid="mojiao"
		me.menpailingwuid=378
		--me.menpaiJobStart=%if( @rbt.cst, @per.roomno, %if( @per.roomno=1328 or @per.roomno=936, 609, @per.roomno));per.roomno=@me.menpaiJobStart;#if @per.roomno=609 {per.npcid=robber;per.way="w;e"};
		me.menpaiLimited=5000
		me.dazuobaseid=2052
		me.chongmaiBaseid=2052
		--#if @set_GbSecretWay {#call %comset(xkxGPS,"EntranceCondition","(condition is null or condition='dong') and id<>3247")}};
	elseif w[1]=="华山派" then
		me.menpai="hs"
		me.fjmaster="岳不群"
		me.fjmasternick="岳掌门"
		me.fjmasterid="buqun"
		me.fjbaseid=874
		me.fjnpcname="强盗"
		me.fjnpcid="qiang dao"
		me.menpailingwuid=2019
		me.menpaiJobStart=841
		me.menpaiLimited=5000
		me.dazuobaseid=0
		me.chongmaiBaseid=1422
	elseif w[1]=="白驼山" then
		me.menpai="bt"
		me.fjmaster="欧阳锋"
		me.fjmasternick="欧阳主人"
		me.fjmasterid="feng"
		me.fjbaseid=1801
		me.fjnpcname="江湖侠士"
		me.fjnpcid="xiashi"
		me.menpailingwuid=2026
		me.menpaiJobStart=1801
		me.menpaiLimited=8000
		me.dazuobaseid=1801
		me.chongmaiBaseid=1801
		--#if @set_GbSecretWay {#call %comset(xkxGPS,"EntranceCondition","(condition is null or condition='dong') and id<>3247")}};
	elseif w[1]=="丐帮" then
		me.menpai="gb"
		me.fjmaster="洪七公"
		me.fjmasternick="洪帮主"
		me.fjmasterid="hong"
		me.fjbaseid=1121
		me.fjnpcname="强盗"
		me.fjnpcid="qiang dao"
		me.menpailingwuid=1653
		me.menpaiJobStart=1116
		me.menpaiLimited=8000
		me.dazuobaseid=0
		me.chongmaiBaseid=1422
		EntranceCondition="(condition is null or condition='gb' or condition='dong') and id<>3247 and id<>3248"
		--#call %comset(xkxGPS,"EntranceCondition","(condition is null or condition='gb' or condition='dong') and id<>3247 and id<>3248")}}
	end
end
score_onmaster=function(n,l,w)
	me.master=w[1]
	me.masterid=nil
	me.masterroom=nil
	if conf.master[me.master]~=nil then
		me.masterid=conf.master[me.master][1]
		me.masterroom=conf.master[me.master][2]
	end
		--[[
		#if @set_GbSecretWay {
			#call %comset(xkxGPS,"EntranceCondition","(condition is null or condition='dong' or condition='feng')")
		} {
			#call %comset(xkxGPS,"EntranceCondition","(condition is null or condition='feng')")
		}
		--]]
end

allways_force_added=function(n,l,w)
	run("jifa")
end


---**************************************************
me.update=function()
	---addtri("hp_stat_idhere","^(\\s+)([^a-z!@#$%\^&*()\\\/.,<> ]+)\\((\\w*\\s{0,1}\\w+)\\)$|^(\\s+)([^a-z!@#$%\\^&*()\\\/.,<> ]+)\\((\\w*)\\)$","status","hp_stat_idhere")
	--addtri("hp_stat_findnpc","^(>)*( )*(\\S*)\\s+=\\s+(.+)","status","herenpc.idhere")
	addtri("hp_stat_jing","^(> |) 精神：\\s*(\\d+)\\s*/\\s*(\\d+)\\s*\\(\\s*(\\d+)%\\)\\s*精力：\\s*(\\d+)\\s*/\\s*(\\d+)\\s*\\(\\s*\\+\\s*(\\d+)\\)","status","hp_stat_jing")

	addtri("hp_stat_qixue","^ 气血：\\s*(\\d+)\\s*/\\s*(\\d+)\\s*\\(\\s*(\\d+)%\\)\\s*内力：\\s*(\\S+)\\s*/\\s*(\\d+)\\s*\\(\\s*\\+\\s*(\\d+)\\)","status","hp_stat_qixue")
	addtri("hp_stat_food","^ 食物：\\s*(\\d+)\\s*/\\s*(\\d+)\\s*潜能：\\s*(\\S+)\\s*/\\s*(\\d+)\\s*","status","hp_stat_food")
	addtri("hp_stat_water","^ 饮水：\\s*(\\d+)\\s*/\\s*(\\d+)\\s*经验：\\s*(\\S+)\\s*","status","hp_stat_water")
	--addtri("hp_stat_status","^【 状态 】\\s*(\\S+)\\w*","status","hp_stat_status")
	addtri("status_oncha","^│(　|□)(\\S+)\\s*\\((\\S+)\\)\\s+-\\s*\\S+\\s*(\\d+)\\/.+│$","status","status_oncha")
	addtri("status_onjifa","^\\s*(\\S+)\\s*\\(([a-zA-Z-]+)\\)\\s*：\\s*(\\S+)\\s*有效等级：\\s*(\\d+)$","status","status_onjifa")

	addtri("score_onsex","^│性  别：(.+)人类","status","score_onsex")
	addtri("score_onshen","^│(心静如始|轩辕正气|妖魔孽气)：(\\d+) ","status","score_onshen")
	addtri("score_onbank","\\s+钱庄盈余：(.+)\\s+","status","score_onbank")
	addtri("score_onname","^│姓  名：(\\S+)\\s+","status","score_onname")
	addtri("score_onid","^│英文ID：(\\w+)\\s+","status","score_onid")
	addtri("score_onmaster","^│授业师父：(\\S+)\\s+","status","score_onmaster")
	addtri("score_onfamily","^│江湖门派：(\\S+)\\s+","status","score_onfamily")

	addtri("get_exits1","^\\s*这里.{4}的出口是 (.*)。$","allways_on","get_exits1")
	addtri("get_exits2","^(> |)(.+) - (\\S*)$","allways_on","get_exits2")
	addtri("get_exits3","^(> |)(.+) - \\n(.*)\\Z","allways_on","get_exits3")
	SetTriggerOption("get_exits3","multi_line","1")
	SetTriggerOption("get_exits3","lines_to_match","2")
	
	addtri("login","^Are you using BIG5 code\\?\\(Yes\\|No\\)$","allways_on","onlogin")
	
	addtri("allways_force_added","^(> |)你的「(基本内功|碧涛玄功|颠倒功|毒龙大法|光明圣火功|蛤蟆功|化功大法|混天气功|混元功|混元一气功|九阳神功|枯荣禅功|临济十二庄|龙象般若功|弥勒功|摩天云气|太极神功|太玄功|先天功|修龄要旨|玄门导引功|玄阴真气|玉女心经|紫霞功)」进步了！$","allways_on","allways_force_added")
end
me.update()
-----**********************************************************
-----**********************************************************
infoNote=function(title,...)
	local args={}
	for _, v in ipairs{...} do
		table.insert(args, v)
	end --for
	local rows = #args
	local t = os.date ("%c")
	AppendToNotepad(title,"\r\n**记录时间："..t.."**\r\n")

	if rows == 0 then
		print("Please input your Content!")
		return
	end --if

	for i = 1, rows do
		AppendToNotepad(title,args[i].."\r\n")
	end --for

end

function simTableIndex(str,list)
  for i,value in pairs(list)  do
    if (value==str) then
      return i
    end
  end
  return -1
end


function GetStyle (styleRuns, wantedColumn)
local currentColumn = 1

   -- check arguments
   assert (type (styleRuns) == "table",
           "First argument to GetStyle must be table of style runs")

   assert (type (wantedColumn) == "number" and wantedColumn >= 1,
           "Second argument to GetStyle must be column number to find")

   -- go through each style
   for item, style in ipairs (styleRuns) do
     local position = wantedColumn - currentColumn + 1  -- where letter is in style
     currentColumn = currentColumn + style.length       -- next style starts here
     if currentColumn > wantedColumn then  -- if we are within this style
        return style, string.sub (style.text, position, position), item  -- done
     end -- if found column
   end -- for each style

   -- if not found: result is nil

end -- function GetStyle
-----**********************************************************
-----**********************************************************

