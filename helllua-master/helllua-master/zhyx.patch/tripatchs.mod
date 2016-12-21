	addtri("system_login",'目前共有 \\d* 位巫师、\\d* 位玩家在线上，以及 \\d* 位使用者尝试连线中。',"system","system_login")

-- 修正hp

status_onhpwater=function(name, line, wildcards)
	me.hp["water"]=tonumber(wildcards[1])
	me.hp["watermax"]=tonumber(wildcards[2])
	me.hp["tihui"]=tonumber(wildcards[3])
end

status_onhptihui=function(name, line, wildcards)
	me.hp.nuqi=wildcards[2]
	if me.hp.nuqi=="怒火中烧" or me.hp.nuqi=="竖发冲冠" then
		me.hp.nuqi=10000
	else
		me.hp.nuqi=tonumber(me.hp.nuqi)
	end
	me.hp["exp"]=tonumber(wildcards[3])
end


	addtri("status_onhpwater",'^【 饮 水 】\\s*(\\d+)/\\s*(\\d+)\\s*【 体 会 】(.*)$',"hp","status_onhpwater")
	addtri("status_onhptihui",'^(【 平 和 】|【 愤 怒 】)\\s*([^/ ]*).*【 经 验 】\\s*(\\d+)$',"hp","status_onhptihui")

--- 修正score
	addtri("noteacher",'^  你.*，天性(.*)，还没有拜师。',"charinfo","status_noteacher")
	addtri("score1",'^  (你是一位(.*)岁.*月的(.*)性，.*生。)',"charinfo","status_on_score1")
	addtri("score3",'^  (正|邪)    气：\\s*(\\d+)',"charinfo","status_score3")
	addtri("status_onname",'^ 【\\S*】(\\S*) ((..){1,4})\(\w+\)$',"charinfo","status_onname")
	addtri("status_onyueli",'^  江湖阅历：\\s*(\\d+)\\s*江湖威望：\\s*(\\d+)\\s*$',"charinfo","status_onyueli")
	addtri("status_teacher",'^  你.*，天性(.*)，师父是(.*)。',"charinfo","status_on_teacher")
--- 修正items
deltri("on_itemsstart")
deltri("on_itemsend")

