print("--一夫当关，万夫莫开！--")
SetVariable("id",utils.inputbox("输入你的id"))
SetVariable("passwd",utils.inputbox("输入你的密码"))
SetTimerOption("pfm_chan","send",utils.inputbox("输入你的busy技能指令"))
SetVariable("weapon1",utils.inputbox("输入你主武器的id"))
SetVariable("weapon2",utils.inputbox("输入你副武器的id"))
EnableTimer("pfm",0)
function login()
	SetVariable("h_rnd",0)
	DoAfterSpecial(10,"w;n;e",10)
	DoAfter(15,"buy jiudai 2")
	DoAfter(20,"buy liang 2")
	DoAfterSpecial(25,"w;s;s;aiai",10)
	--DoAfterSpecial(30,"getout 7;getout 7;getout 7;wield xiao;remove all;wear all;out;e;n;n;e",10)
	--DoAfterSpecial(35,"buystone()",12)
	DoAfterSpecial(30,"enter shudong;say 天堂有路你不走呀;d;4;w;w;w;nw;nu;n;n;nu;nu",10)
	DoAfter(35,"zou tiesuo;hp")
	SetTriggerOption("tiesuo","send",'Execute("h_rest();EnableTrigger("tiesuo",0)")')
end
function buystone()
	AddTimer("ti1",0,0,1.5,"buy 石子",1025,"")
	AddTriggerEx("tr1", "^[> ]*当铺里没有这种货品。$",'SetTimerOption("ti1","send","buy 碧磷针")', 32801, -1, 0, "", "", 12, 99)
	DoAfterSpecial(75,'DeleteTimer("ti1")',12)
	DoAfterSpecial(75,'DeleteTrigger("tr1")',12)
end

function h_go()
	local hplace
	hplace=GetVariable("hplace")
	if hplace=="仙愁门" then
		Execute("exert powerup;huwei")
	elseif hplace=="山路" then
		Execute("nw;exert powerup;huwei")
	elseif hplace=="松林" then
		Execute("nw;ne;nu;exert powerup;huwei")
	elseif hplace=="青石大道" then
		Execute("nw;ne;nu;nu;exert powerup;huwei")
	elseif hplace=="百丈涧" then
		SetTriggerOption("tiesuo","send",'Execute("exert powerup;huwei;EnableTrigger("tiesuo",0)")')
		EnableTrigger("tiesuo",1)
		Execute("zou tiesuo")
	elseif hplace=="断魂崖" then
		SetTriggerOption("tiesuo","send",'Execute("sd;exert powerup;huwei;EnableTrigger("tiesuo",0)")')
		EnableTrigger("tiesuo",1)
		Execute("zou tiesuo")
	elseif hplace=="缥缈峰山脚" then
		SetTriggerOption("tiesuo","send",'Execute("sd;sd;exert powerup;huwei;EnableTrigger("tiesuo",0)")')
		EnableTrigger("tiesuo",1)
		Execute("zou tiesuo")
	elseif hplace=="小路" then
		SetTriggerOption("tiesuo","send",'Execute("sd;sd;s;exert powerup;huwei;EnableTrigger("tiesuo",0)")')
		EnableTrigger("tiesuo",1)
		Execute("zou tiesuo")
	end
end

function h_back()
	local hplace
	hplace=GetVariable("hplace")
	if hplace=="仙愁门" then
		Execute("hp")
		h_rest()
	elseif hplace=="山路" then
		Execute("se;hp")
		h_rest()
	elseif hplace=="松林" then
		Execute("sd;sw;se;hp")
		h_rest()
	elseif hplace=="青石大道" then
		Execute("sd;sd;sw;se;hp")
		h_rest()
	elseif hplace=="百丈涧" then
		SetTriggerOption("tiesuo","send",'Execute("h_rest();EnableTrigger("tiesuo",0)")')
		EnableTrigger("tiesuo",1)
		Execute("zou tiesuo;hp")
	elseif hplace=="断魂崖" then
		SetTriggerOption("tiesuo","send",'Execute("h_rest();EnableTrigger("tiesuo",0)")')
		EnableTrigger("tiesuo",1)
		Execute("nu;zou tiesuo;hp")
	elseif hplace=="缥缈峰山脚" then
		SetTriggerOption("tiesuo","send",'Execute("h_rest();EnableTrigger("tiesuo",0)")')
		EnableTrigger("tiesuo",1)
		Execute("nu;nu;zou tiesuo;hp")
	elseif hplace=="小路" then
		SetTriggerOption("tiesuo","send",'Execute("h_rest();EnableTrigger("tiesuo",0)")')
		EnableTrigger("tiesuo",1)
		Execute("n;nu;nu;zou tiesuo;hp")
	end
end

function h_rest()
	if GetVariable("v_food")*1 < 300 then
		Execute("eat liang")
	end
	if GetVariable("v_water")*1 <300 then
		Execute("drink jiudai")
	end
	if GetVariable("h_rnd")*1>=10 then
	--Execute("zou tiesuo")
	--AddTriggerEx ("", "^[> ]*你终于来到了对面，心里的石头终于落地。$","Execute(\"lj-yz\")", 32801, -1, 0, "", "", 12, 100)
	--DoAfterSpecial(20,"s;s;s;w;enter jhcx;store xiao;store jia;store jia",10)
	DoAfter(30,"quit")
	SetVariable("h_rnd",0)
	elseif GetVariable("health")*1<100 then
		Execute("exert heal;hp")
		DoAfterSpecial(5,"h_rest()",12)
	elseif GetVariable("fp")*1<GetVariable("maxfp")*1.5 then
		Send("dazuo "..GetVariable("maxhp")/2-50)
		DoAfter(25,"hp")
		DoAfterSpecial(27,"h_rest()",12)
	else Execute("ask shi about huwei")
	end
end
	

	