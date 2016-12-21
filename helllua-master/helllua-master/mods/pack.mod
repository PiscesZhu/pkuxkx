pack={}
pack["ok"]=nil
pack["fail"]=nil
pack.item=""
pack.container=""
do_pack=function(packitem,packcontainer,pack_ok,pack_fail)
	pack["ok"]=pack_ok
	pack["fail"]=pack_fail
	pack.item=packitem
	pack.container=packcontainer
	run("put "..pack.item.." in "..pack.container)
	infoend(pack_end_ok)
end

pack["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(pack[s])
	end
	pack["ok"]=nil
	pack["fail"]=nil
end

pack_end_ok=function()
	pack["end"]("ok")
end

pack_end_fail=function()
	pack["end"]("fail")
end

checkpack=function(_packlist,_container,pack_ok,pack_fail)
	if _packlist==nil then return false end
	for i,v in pairs(_packlist) do
		if itemsnum(i)>0 then
			do_pack(v,_container,pack_ok,pack_fail)
			return true
		end
	end
	return false
end

checkpacklist=function(_packslist,pack_ok,pack_fail)
	if _packslist==nil then return false end
	for pi,_packlist in pairs(_packslist) do
		for i,v in pairs(_packlist) do
			if itemsnum(i)>0 then
				do_pack(v,pi,pack_ok,pack_fail)
				return true
			end
		end
	end
	return false
end
