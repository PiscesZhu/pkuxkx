bank={}
do_bank=function(action,num,type,bank_ok,bank_fail)
	bank["action"]=action
	bank["type"]=type
	bank["num"]=num
	bank["ok"]=bank_ok
	bank["fail"]=bank_fail
	go(bankloc,bank["arrive"],bankendfail)
end
bankendfail=function()
	bank["end"]("fail")
end
bank_ok=function()
	bank["end"]("ok")
end
bank["end"]=function(s)
	if ((s~="")and(s~=nil)) then
		call(bank[s])
	end
	bank["ok"]=nil
	bank["fail"]=nil
end

bank["arrive"]=function()
	busytest(bank[bank["action"]])
end
bank["cun"]=function()
	run("cun "..tostring(bank["num"]).." "..bank["type"])
	busytest(bank_ok)
end
bank["qu"]=function()
	run("qu "..tostring(bank["num"]).." "..bank["type"])
	busytest(bank_ok)
end
bank["duihuan"]=function()
	if (bank["type"]=="coin")or(bank["type"]=="ͭǮ") then
		run("duihuan "..tostring(bank["num"]).." "..bank["type"].." to silver")
	else
		run("duihuan "..tostring(bank["num"]).." "..bank["type"].." to gold")
	end
	busytest(bank_ok)
end
