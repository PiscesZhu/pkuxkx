makeyao={}
makeyao["ok"]=nil
makeyao["fail"]=nil
makeyao.buyitem=""
makeyao.failtomake=false
makeyao.yaoname=""
makeyao.count=0
do_makeyao=function(yaoname,yao_max,makeyao_ok,makeyao_fail)
	makeyao["ok"]=makeyao_ok
	makeyao["fail"]=makeyao_fail
	if yaoname==nil then
		makeyao_end_fail()
		return
	end
	print(yaoname)
	makeyao.failtomake=false
	makeyao.yaoname=yaoname
	makeyao.count=0
	makeyao.max=yao_max
	if makeyao.max==nil then makeyao.max=1 end
	busytest(makeyao.main)
	SetTriggerOption ("makeyao_ok", "match", "^(> )*你把「"..makeyao.yaoname.."」成功的制好了！")

end
makeyao_ok=function()
	makeyao.count=makeyao.count+1
end

makeyao["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(makeyao[s])
	end
	EnableTriggerGroup("makeyao",false)
	makeyao["ok"]=nil
	makeyao["fail"]=nil
end

makeyao_end_ok=function()
	makeyao["end"]("ok")
end

makeyao_end_fail=function()
	makeyao["end"]("fail")
end

makeyao.main=function()
	if quest.stop then
		makeyao["end"]()
		return
	end
	if makeyao.failtomake==true then
		makeyao_end_fail()
		return
	end
	EnableTriggerGroup("makeyao",true)
	run("get all from bo;get all from mo")
	getstatus(makeyao["check"])
end
makeyao.chechdanbo=function(check_ok,check_fail)
	if itemsnum("yanbo")==0 and itemsnum("danyu mo")==0 then
		item["go"]("yanbo",1,check_ok,check_fail)
		return true
	end
	return false
end
makeyao.check=function()
	if do_check(makeyao["main"]) then
	elseif makeyao.chechdanbo(makeyao["main"],makeyao["main"]) then
	elseif makeyao.chechbuy() then
	elseif makeyao.count>=makeyao.max then
		makeyao_end_ok()
		return
	else
		go(-2,makeyao.makearrive,makeyao_end_fail)
	end
end
makeyao.makearrive=function()
	busytest(makeyao.cmd)
end
makeyao.cmd=function()
	makeyao.buyitem=nil
	run("hand yanbo;make "..makeyao.yaoname)
	busytest(makeyao.main)
end

makeyao_buy=function(n,l,w)
	makeyao.buyitem=w[2]
end
makeyao.buy=function()
	if makeyao.buyitem~=nil then
		run("buy "..tostring(math.max(math.min(makeyao.max-makeyao.count,10)),1).." "..makeyao.buyitem .." from ping yizhi")
	end
	go(-2,makeyao.makearrive,makeyao_end_fail)
end
makeyao.chechbuy=function()
	if makeyao.buyitem~=nil then
		go(yaopuloc,makeyao.buy,makeyao_end_fail)
		return true
	end
	return false
end
makeyao_fail=function(n,l,w)
	makeyao.failtomake=true
end
