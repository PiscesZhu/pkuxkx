house={}
house["ok"]=nil
house["fail"]=nil

do_house=function(house_ok,house_fail)
	house["ok"]=house_ok
	house["fail"]=house_fail
end

house["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(house[s])
	end
	house["ok"]=nil
	house["fail"]=nil
end

house_end_ok=function()
	house["end"]("ok")
end

house_end_fail=function()
	house["end"]("fail")
end
house.add=function(housename)
	if housename==nil then return end
	if houses[housename]==nil then return end
	houses[housename].type(housename)
end

panlong=function(housename)
	baseloc=mapper.newarea(20)
	mapper.readroom(baseloc,tostring(baseloc).."="..housename.."大院|n:"..tostring(baseloc+1)..",out:"..tostring(houses[housename].loc)..",")
	mapper.readroom(baseloc+1,tostring(baseloc+1).."="..housename.."前庭|e:-1,push gate\\n:"..tostring(baseloc+2)..",s:"..tostring(baseloc)..",w:-1,")
	mapper.readroom(baseloc+2,tostring(baseloc+2).."=走道|n:"..tostring(baseloc+3)..",push gate\\s:"..tostring(baseloc+1)..",")
	mapper.readroom(baseloc+3,tostring(baseloc+3).."="..housename.."迎客厅|e:-1,n:"..tostring(baseloc+5)..",s:"..tostring(baseloc+2)..",")
	mapper.readroom(baseloc+4,tostring(baseloc+4).."=茶室|w:"..tostring(baseloc+3)..",")
	mapper.readroom(baseloc+5,tostring(baseloc+5).."=议事厅|e:"..tostring(baseloc+6)..",n:"..tostring(baseloc+8)..",s:"..tostring(baseloc+3)..",w:"..tostring(baseloc+7)..",")
	mapper.readroom(baseloc+6,tostring(baseloc+6).."=演武厅|w:"..tostring(baseloc+5)..",")
	mapper.readroom(baseloc+7,tostring(baseloc+7).."=演武厅|e:"..tostring(baseloc+5)..",")
	mapper.readroom(baseloc+8,tostring(baseloc+8).."="..housename.."中庭|n:"..tostring(baseloc+11)..",open east\\e:"..tostring(baseloc+10)..",open west\\w:"..tostring(baseloc+9)..",s:"..tostring(baseloc+5)..",")
	mapper.readroom(baseloc+9,tostring(baseloc+9).."=右厢房|w:"..tostring(baseloc+8)..",")
	mapper.readroom(baseloc+10,tostring(baseloc+10).."=左厢房|e:"..tostring(baseloc+8)..",")
	mapper.readroom(baseloc+11,tostring(baseloc+11).."=后院|e:"..tostring(baseloc+13)..",n:"..tostring(baseloc+14)..",s:"..tostring(baseloc+8)..",w:"..tostring(baseloc+12)..",")
	mapper.readroom(baseloc+12,tostring(baseloc+12).."=厨房|e:"..tostring(baseloc+11)..",")
	mapper.readroom(baseloc+13,tostring(baseloc+13).."=练武场|w:"..tostring(baseloc+11)..",")
	mapper.readroom(baseloc+14,tostring(baseloc+14).."=后花园|e:"..tostring(baseloc+15)..",open door\\w:"..tostring(baseloc+16)..",s:"..tostring(baseloc+11)..",")
	mapper.readroom(baseloc+15,tostring(baseloc+15).."=竹林|e:"..tostring(baseloc+19)..",w:"..tostring(baseloc+14)..",")
	mapper.readroom(baseloc+16,tostring(baseloc+16).."=居所|open door\\e:"..tostring(baseloc+14)..",u:"..tostring(baseloc+17)..",w:"..tostring(baseloc+18)..",")
	mapper.readroom(baseloc+17,tostring(baseloc+17).."=卧室|d:"..tostring(baseloc+16)..",")
	mapper.readroom(baseloc+18,tostring(baseloc+18).."=书房|e:"..tostring(baseloc+16)..",")
	mapper.readroom(baseloc+19,tostring(baseloc+19).."=听涛阁|w:"..tostring(baseloc+15)..",".."pass-"..housename..">#loc:2501,pass-"..housename..">#loc:2500,")
	mapper.addpath(houses[housename].loc,"pass-"..housename..">"..houses[housename].id..":"..tostring(baseloc)..",")
end
