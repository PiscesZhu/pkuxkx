require "tprint"
print("---------侠客岛读石壁-------------------")

luapath=string.match(GetInfo(35),"^.*\\")

include=function(str)
	dofile(luapath..str)
end
loadmod=function(str)
	include(str)
end

print("数据载入中")
loadmod("system.lua")
loadmod("hook.lua")
loadmod("alias.lua")

----------------以上为系统层-----------------
--path = "6s 3w n"						--去读基本内功
--path = "e;s;s;s;s;s;s;w;w;w;n;drink;yao liang;do 5 eat liang;drop liang;s;e;e;e;n;n;n;n;n;n;w;look 石壁;"	--基本硬功
path = "s;s;s;s;s;s;w;w;w;n;drink;yao liang;do 5 eat liang;drop liang;s;e;e;e;n;n;n;n;n;n;look 石壁;"	--基本内功
--path ="w;n;drink;yao liang;do 5 eat liang;drop liang;s;e;look 石壁;"		--医术
--path ="s;s;s;s;e;e;e;n;drink;yao liang;do 5 eat liang;drop liang;s;w;w;w;n;n;n;n;look 石壁;"	--读书写字
dz = 3010
--path = "n 3w n w"
quest={}
--quest.stop=false


do_watch = function()					--程序运行入口
	if quest.stop == false then return end
	Send("hp")
	DoAfterSpecial(1,'list_hp()',12)
end

list_hp = function()					--检查自身状态,按照不同的状态处理不同情况
	--tprint(me.hp)
	ResetTimer("slook")
	if me.hp["shiwu"] < 200 then
		busytest(go_food)
		return
	elseif me.hp["yinshui"] < 200 then
		busytest(go_food)
		return
	elseif me.hp["neili"] < 3000 then
		busytest(go_dazuo)
		return
	else
		busytest(go_watch)
	end
end

go_watch = function()
	Send("watch 石壁 35")
	Send("exert regenerate")
	busytest(do_watch)
end

go_food = function()					--去吃东西
	local walk_path
	Note("去吃东西")
	go()
end

go_dazuo = function()
	Note("现在开始打坐")
	Send("exert recover")
	Send("dazuo " .. dz)
end




