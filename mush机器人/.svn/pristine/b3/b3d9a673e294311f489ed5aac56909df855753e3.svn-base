alias={}

sum={
	fj=0,
	mp=0,
	ftb=0,
	death=0,
	lifesave=0,
}
avg={}

function alias.atconnect()
	print("Connecting...")
	alias.initialize_variable()
	alias.initialize_trigger()
	openclass("login")
	--cmd.nums=0
	--run("n;"..me.charid)
	Execute("n")
	Execute(me.charid)
end
function alias.atdisconnect()
	--cmd.nums=0
	wait.make(function()
		local _f=function() Connect() end
		wait.time(8);_f()
	end)
end
function sum.all()
	return tonumber(sum.fj+sum.mp+sum.ftb+sum.death)
end
function avg.all()
	local a
	if os.time()-mark.sTime==0 then a=1 else a=os.time()-mark.sTime end
	return math.floor(sum.all()*3600/a)
end
function avg.fj()
	local a
	if os.time()-mark.sTime==0 then a=1 else a=os.time()-mark.sTime end
	return math.floor(sum.fj*3600/a)
end
function avg.mp()
	local a
	if os.time()-mark.sTime==0 then a=1 else a=os.time()-mark.sTime end
	return math.floor(sum.mp*3600/a)
end
function avg.ftb()
	local a
	if os.time()-mark.sTime==0 then a=1 else a=os.time()-mark.sTime end
	return math.floor(sum.ftb*3600/a)
end
function avg.death()
	local a
	if os.time()-mark.sTime==0 then a=1 else a=os.time()-mark.sTime end
	return math.floor(sum.death+sum.lifesave*3600/a)
end
function countTime()
	local a,b,c,d,e
	a=math.floor(((os.time()-mark.sTime)/60)/60)
	b=math.floor(a/24)
	e=math.floor(math.fmod((os.time()-mark.sTime)/60,60))
	c=""
	if a>0 then
		if b>0 then
			d=math.fmod(a,24)
			c=b.."天"..d.."小时"..e.."分钟"
		else
			c=a.."小时"..e.."分钟"
		end
	else
		c=e.."分钟"
	end
	return c
end
function alias.setstatus()
	local a,b,c
	a=""
	b=""
	if havefj>0 then c="有FJ" else c="无FJ" end
	if workflow.nowjob=="fj" then a=fjzone..fjroom
	else
		if workflow.nowjob=="ftb" or workflow.nowjob=="lzjob" then
			if ftbnpckilled<ftbnum then b=ftbnpckilled.."/"..ftbnum else b="完成" end
			a=ftbzone..ftbroom.."("..tostring(ftbareanum)..") "..b
		end
	end
	if me.charname==nil then me.charname="" end
	SetStatus("姓名 "..tostring(me.charname).." 统计:"..tostring(countTime()).." 增加:"..tostring(stat.addexp).." 平均:"..tostring(stat.avgall).." 其中FJ:"..tostring(stat.avgfj).." MP:"..tostring(stat.avgmp).." FTB:"..tostring(stat.avgftb).." 死亡:"..tostring(stat.avgdeath).." "..tostring(stat.countdeath).."次 | 任务 "..tostring(workflow.nowjob).." "..tostring(a).." "..tostring(c).." Ver."..tostring(version))
end
function kmq()
	if findstring(killpfm,"perform kong","perform ming") then return true else return false end
end
function dz()
	return math.floor(math.abs(jifa.force/5*me.xtgg/20))
end
function case_weapon(a)
	a=tonumber(a)
	if a==1 then return "没武器" end
	if a==2 then return "剑" end
	if a==3 then return "箫" end
	if a==4 then return "刀" end
	if a==5 then return "棒" end
	if a==6 then return "轮" end
	if a==7 then return "杖" end
	if a==8 then return "鞭" end
end
function alias.tt()
	if isopen("dazuo") then alias.tdz() end
	if isopen("skills_lian") then alias.tlw() end
end
function startjob()
	mark.gold=0
	mark.setexp=1
	mark.setpot=1
	ftbnpckilled=0
	weapon_id=1
	havefj=0
	fjzone=""
	fjroom=""
	fjarea=""
	fjroomid=0
	buzhen=false
	checkmove.NotGPSMove=1
	gpszeikou=""
	haveshizhe=0
	stat.reverse=0
	stat.powerup=0
	stat.daxiao=0
	stat.fengyun=0
	stat.tiandi=0
	stat.quiting=0
	stat.zhixin=0
	stat.huntianup=0
	stat.shengang=0
	stat.heji=0
	have.nousejy=0
	set_neili=set_neili_global
	set_GbSecretWay_err=0
	gold.roomNo=0
	burnnpc.have=0
	--me.drugbusy=0
	killaction=""
	gold.id=""
	alias.resetidle()
	run("score;jifa")
	alias.ch()
	run("hp;set rbt=start")
end
function alias.checklitmaster()
	--if skillslist["literate"]==nil or (skillslist["literate"]~=nil and skillslist["literate"]["lvl"]<30) then
	--	me.litmaster="老秀才"
	--	me.litmasterid="xiucai"
	--elseif skillslist["literate"]~=nil and skillslist["literate"]["lvl"]<100 then
	--	me.litmaster="欧阳詹"
	--	me.litmasterid="ouyang"
	--else
	--	me.litmaster="朱熹"
	--	me.litmasterid="zhu"
	--end
	if skillslist["literate"]["lvl"]>=100 then
		me.litmaster="朱熹"
		me.litmasterid="zhu"
	elseif skillslist["literate"]["lvl"]>=30 then
		me.litmaster="欧阳詹"
		me.litmasterid="ouyang"
	else
		me.litmaster="老秀才"
		me.litmasterid="xiucai"
	end
end
function alias.initialize_variable()
	DiscardQueue()
	DeleteTemporaryTimers()
	flytoname=""
	flytonamelistindex=0
	flytonamelistsum=0
	flytonpc=""
	flytonpclistindex=0
	flytonpclistsum=0
	killnpcnum=0
	gpserrnum=0
	buzhen=false
	checkmove.NotGPSMove=1
	gpszeikou=""
	flytoareastartid=0
	mark.setexp=1
	mark.setpot=1
	mark.setgold=1
	me.expadd=0
	ftbnpckilled=0
	havefj=0
	haveshizhe=0
	addforce=0
	weapon_id=1
	stat.havedu=0
	stat.haveyyz=0
	stat.leidong=0
	stat.zixia=0
	stat.quiting=0
	mpJobLimited=0
	xy.xyLimited=0
	xy.limitedResume=0
	xy.biteLimited=0
	xy.checkfirstbite=1
	stat.reverse=0
	stat.powerup=0
	stat.daxiao=0
	stat.fengyun=0
	stat.tiandi=0
	stat.zhixin=0
	stat.huntianup=0
	stat.shengang=0
	stat.heji=0
	stat.longxiang=0
	fjzone=""
	fjroom=""
	fjarea=""
	fjroomid=0
	gold.roomNo=0
	list.pk=""
	pk.name=""
	pk.id=""
	killaction=""
	have.nousejy=0
	set_neili=set_neili_global
	set_GbSecretWay_err=0
	gold.id=""
	mpLimited.mpexp=0
end
function alias.max()
	run("jiali max;jiajin max")
end
function alias.yjl()
	if me.menpai=="em" then run("yun longhe") end
	run("yun refresh")
end
function alias.ch()
	skillslist={
		literate={lvl=0,},
		cuff={lvl=0,},
		["kongming-quan"]={lvl=0,},
	}
	run("skills -c")
end
function alias.resetidle()
	alias.setstatus()
	idle=0
	ResetTimer("always_watch_timer60")
end
function alias.tc(a)
	if have.coin~=nil and have.coin>0 then run("throw coin at "..a) else
		if have.silver~=nil and have.silver>0 then run("throw silver at "..a) else
			if have.gold~=nil and have.gold>0 then run("throw gold at "..a) else
				run("kill "..a)
			end
		end
	end
end
function alias.uw(a,b,c)
	if a~=nil then
		if b==nil then
			run("unwield "..a)
		else
			if c==nil then
				run("unwield "..a.." "..b)
			else
				run("unwield "..a.." "..b.." "..c)
			end
		end
	else
		if weapon_id==1 then run("unwield "..weapon_now) else run("unwield "..weapon_now.." "..weapon_id) end
	end
	if me.menpai=="xs" then run("unwield lubo;unwield fa ling") end
	if me.menpai=="xx" then run("unwield bi") end
	if me.menpai=="dl" then run("unwield huachu;unwield chain") end
end
function alias.wi(a,b,c)
	if a~=nil then
		if b==nil then
			weapon_now=a
		else
			if c==nil then
				weapon_now=a.." "..b
			else
				weapon_now=a.." "..b.." "..c
			end
		end
	end
	if weapon_now=="hammer" then weapon_now="lun" end
	run("wield "..weapon_now)
end
function alias.checkexp(a)
	openclass("check_exp")
	run("i;score;hp")
	if a==nil or string.len(a)==0 then run("set checkexp=yes") else run("set checkexp="..a) end
end
function alias.checkdrugbusy(a)
	--if a~=nil and string.len(a)>0 and (stat.drugbusy<os.time() or stat.drugbusy==0) then
	if stat.drugbusy<os.time() or stat.drugbusy==0 then
		run("buy "..a..";fu "..a)
	else
		print("药性还未消除")
	end
end
function alias.checkbusy(a)
	if string.len(a)==0 then setbusy="busy" else setbusy=a end
	wait.make(function()
		run("eat "..setbusy)
		local l,w=wait.regexp("^(> > > |> > |> |)(你身上没有 "..setbusy.." 这样食物。|你正忙着呢，先忍忍吧。)")
		if l==nil then
			wait.time(0.5)
			alias.checkbusy(setbusy)
			return
		end
		if findstring(l,"你正忙着呢，先忍忍吧。") then
			alias.resetidle()
			wait.time(0.5)
			alias.checkbusy(setbusy)
			return
		end
		if findstring(l,"你身上没有") then
			alias.resetidle()
			run("set busyover="..setbusy)
			return
		end
	end)
end
function alias.checkitems()
	have.gold=0
	have.silver=0
	have.coin=0
	have.jian=0
	have.dao=0
	have.dan=0
	have.jcy=0
	have.fire=0
	have.jiudai=0
	have.he=0
	have.chain=0
	have.armor=1
	have.bagua=0
	have.ji=0
	have.xinfa=0
	have.staff=0
	have.ling=0
	have.shengzi=0
	have.guaishe=0
	have.whip=0
	have.club=0
	have.yaodai=0
	have.fuling=0
	have.zhongjian=0
	have.jingyao=0
	have.stick=0
	have.stick_zhu=0
	have.stick_tong=0
	have.stick_huangzhu=0
	have.heshouwu=0
	have.yufengjiang=0
	have.chuanbei=0
	have.shengdi=0
	have.jinyinhua=0
	have.jugeng=0
	have.huanglian=0
	have.gouzhizi=0
	have.faling=0
	have.lubo=0
	have.kulouguan=0
	have.rentoulian=0
	have.falun=0
	have.syguan=0
	have.bi=0
	have.xueteng=0
	have.danggui=0
	have.swjing=0
	have.tyl=0
	--have.water=1
	if dropya then
		run("drop ya;drop jiuping")
		dropya=false
	end
	alias.uw()
	openclass("check_items")
	run("i;look he;look yaodai")
	if me.menpai=="bt" then run("stop she;convert she;look staff") end
	run("set checkitems=yes")
end
function alias.dealwithitems()
	openclass("dealwith_item")
	--if have.gold<1 or have.silver<50 then
	if have.gold<1 then
		openclass("dealwith_gold")
		if daytime and me.gold>5 then alias.flytonpc("黄真") else alias.flytonpc("王五") end
		return
	end
	if have.he<1 or have.fire<1 then
	--if have.fire<1 then
		openclass("dealwith_he")
		--alias.flytoid(837)
		alias.flytonpc("杨永福")
		return
	end
	if have.jiudai<1 then
		openclass("dealwith_jiudai")
		alias.flytoid(948)
		return
	end
	if have.water==nil or have.water<1 then
		openclass("dealwith_jiudai")
		if me.menpai=="bt" then alias.flytoid(1805)
		elseif me.menpai=="xs" then alias.flytoid(437)
		elseif me.menpai=="xx" then alias.flytoid(1447)
		elseif me.menpai=="mj" then alias.flytoid(537)
		else alias.flytonpc("小姗") end
		return
	end
	if have.he>0 and have.ji<1 then
	--if (hp.food<hp.maxfood and hp.water<hp.maxwater) then
		openclass("dealwith_ji")
		alias.flytonpc("宋老板")
		return
	end
	if have.gold>5 and daytime and not isopen("chongmai_pre") then
		openclass("dealwith_gold")
		alias.flytonpc("黄真")
		return
	end
	if have.silver>100 and daytime then
		openclass("dealwith_gold")
		alias.flytonpc("黄真")
		return
	end
	if have.coin<10 and daytime then
		openclass("dealwith_gold")
		alias.flytonpc("黄真")
		return
	end
	if have.shengzi<1 and me.menpai=="hs" and usepot=="lingwu" and lingwuat=="menpai" then
		openclass("dealwith_shengzi")
		alias.flytoid(837)
		return
	end
	if have.yaodai<1 and me.menpai=="em" then
		openclass("dealwith_yaodai")
		alias.flytonpc("静风")
		return
	end
	if have.yaodai>0 and have.fuling==0 and me.menpai=="em" then
		openclass("dealwith_fuling")
		alias.flytonpc("王通治")
		return
	end
	if have.tyl<1 and me.menpai=="mj" then
		openclass("dealwith_tyl")
		alias.flytonpc("冷谦")
		return
	end
	if have.xueteng>0 or have.danggui>0 or have.swjing>0 or have.jcy<1 then
		openclass("dealwith_sellyao")
		alias.flytonpc("何红药")
		return
	end
	if (have.faling<1 or have.lubo<1 or have.kulouguan<1 or have.rentoulian<1) and me.menpai=="xs" then
		openclass("dealwith_xs")
		run("set check=burn")
		return
	end
	if have.he>1 then for i=2,have.he,1 do run("drop shi he") end end
	if have.fire>1 then for i=2,have.fire,1 do run("drop fire") end end
	if have.shengzi>1 then for i=2,have.shengzi,1 do run("drop sheng zi") end end
	if have.yaodai>1 then for i=2,have.yaodai,1 do run("drop yaodai") end end
	if have.jian>1 then for i=2,have.jian,1 do run("drop jian") end end
	if have.dao>1 then for i=2,have.dao,1 do run("drop dao") end end
	if have.staff>1 then for i=2,have.staff,1 do run("drop staff") end end
	if have.whip>1 then for i=2,have.whip,1 do run("drop whip") end end
	if have.club>1 then for i=2,have.club,1 do run("drop club") end end
	if have.stick>1 then for i=2,have.stick,1 do run("drop stick") end end
	if have.bi>1 then for i=2,have.bi,1 do run("drop bi") end end
	if have.chain>1 then for i=2,have.chain,1 do run("drop chain") end end
	if have.armor>1 then for i=2,have.armor,1 do run("drop armor") end end
	closeclass("dealwith_item")
	alias.dealwithitems_weapon()
end
function alias.dealwithitems_weapon()
	openclass("dealwith_item")
	--if (have.jian<2 and me.menpai~="sl" and me.menpai~="bt" and me.menpai~="mj" and me.menpai~="xs" and me.menpai~="gb" and me.menpai~="xx" and me.menpai~="dl") or have.armor<1 then
	if have.jian<1 and (fjweapon=="jian" or mpweapon=="jian" or ftbweapon=="jian" or findstring(skills_lingwu,"sword")) then	
		openclass("dealwith_jian")
		jiannpc="白衣武士"
		alias.flytonpc(jiannpc)
		return
	end
	--if have.dao<2 and me.menpai=="sl" then
	if have.dao<1 and (fjweapon=="dao" or mpweapon=="dao" or ftbweapon=="dao" or findstring(skills_lingwu,"blade")) then
		openclass("dealwith_dao")
		if me.menpai=="sl" then alias.flytonpc("道尘") else alias.flytoid(964) end 
		return
	end
	if have.staff<1 and (fjweapon=="staff" or mpweapon=="staff" or ftbweapon=="staff" or findstring(skills_lingwu,"staff")) then
		openclass("dealwith_staff")
		if me.menpai=="bt" then alias.flytoid(926) else alias.flytoid(280) end
		return
	end
	if me.menpai=="bt" and have.guaishe==0 then
		openclass("dealwith_staff")
		run("drop staff")
		alias.flytoid(926)
		return
	end
	--if have.jian<1 and findstring(skills_lingwu,"sword") then
	--	openclass("dealwith_jian")
	--	alias.flytonpc("白衣武士")
	--	return
	--end
	if have.whip<1 and (fjweapon=="bian" or mpweapon=="bian" or ftbweapon=="bian" or findstring(skills_lingwu,"whip")) then
		openclass("dealwith_bian")
		alias.flytoid(312)
		return
	end
	if have.club<1 and findstring(skills_lingwu,"club") then
		openclass("dealwith_gun")
		alias.flytonpc("道尘")
		return
	end
	if have.stick<1 and (fjweapon=="stick" or mpweapon=="stick" or ftbweapon=="stick" or findstring(skills_lingwu,"stick"))  then
		openclass("dealwith_stick")
		alias.flytoid(1118)
		return
	end
	if have.bi<1 and (fjweapon=="bi" or mpweapon=="bi" or ftbweapon=="bi" or findstring(skills_lingwu,"stroke"))then
		openclass("dealwith_bi")
		alias.flytoid(1101)
		return
	end
	if have.falun<me.falun and (fjweapon=="lun" or mpweapon=="lun" or ftbweapon=="lun" or findstring(skills_lingwu,"hammer"))then
		openclass("dealwith_xs")
		run("set check=falun")
		return
	end
	if (have.chain<1 and me.menpai=="dl") or (have.chain<1 and do_dl_job==1) then
		openclass("dealwith_chain")
		alias.flytonpc("高升泰")
		return
	end
	closeclass("dealwith_item")
	run("set dealwithitems=over")
end
function alias.killover()
	local _t
	if workflow.nowjob=="fj" or workflow.nowjob=="ftb" or workflow.nowjob=="mp" then _t=workflow.nowjob else _t="fj" end
	if string.len(_G[_t.."weapon"])>0 then alias.uw() end
	if getweapon>0 then
		for i=1,2,1 do run("get ".._G[_t.."weapon"]) end
	end
	wieldweapon=0
	getweapon=0
	yunbusy=0
	runaway=false
	npcfaint=false
	pfmid=1
	rejiajin=false
	run("jiajin basic;jiali 0")
	if findstring(killpfm,"perform kong","perform ming") then run("bei none;bei kongming-quan") end
	if string.len(killaction)==0 then killaction="yes" end
	if me.menpai=="bt" then run("convert she") end
	closeclass("kill_"..me.menpai)
	closeclass("kill")
	run("set killover="..killaction)
	killaction=""
	if stat.zixia>0 then run("yun sangong") end
	if me.master=="风清扬" and fjweapon=="jian" then run("jifa dodge dugu-jiujian") end
end
function alias.KillNextNPC()
	print(":::KillNextNPC:::")
	killnpcnum=tonumber(killnpcnum+1)
	if string.len(killnpcover)>0 then
		run(killnpcover)
		if killnpcnum>=killnpcsum then
			killnpcover=""
			killnpcnum=0
		end
	end
end
function alias.fjskillskill(var)
	local _tb
	-- 第一个参数是killaction，二是vchar处理过的中文名，三是英文id，四是英文id后半截可省
	_tb=utils.split(var," ")
	killaction=_tb[1]
	killname=_tb[2]
	if _tb[4]==nil then killid=_tb[3] else killid=_tb[3].." ".._tb[4] end
	_tb=utils.split(fjyun,"|")
	for k,v in pairs(_tb) do run(v) end
	reyun=0
	killRunSuccess=false
	openclass("kill")
	openclass("kill_"..me.menpai)
	AddTimer("kill_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "kill.timer")
	SetTimerOption("kill_timer", "group", "kill")
	closeclass("kill_run")
	runaway=false
	npcfaint=false
	if me.menpai=="hs" then
		if stat.leidong>0 then
			pfmid=2
			if fjweapon=="staff" then alias.wi(staffid) else alias.wi(fjweapon) end
		else
			pfmid=1
			alias.uw()
		end
	else
		pfmid=1
		if string.len(fjweapon)==0 then
			if fjweapon=="staff" then alias.wi(staffid) else alias.wi(fjweapon) end
		else alias.uw() end
	end
	killskill=fjweapon
	killpfm=fjpfm
	killyun=fjyun
	killjiali=fjjiali
	killjiajin=fjjiajin
	run("jiali "..fjjiali..";jiajin "..fjjiajin..";kill "..killid)
	if me.menpai=="bt" then run("convert staff;attack "..killid) end
	if me.menpai=="mj" then run("order fighter do attack "..killid..";order fighter 2 do attack "..killid) end
	--_tb=utils.split(fjpfm,"|")
	--if pfmid<=table.getn(_tb) then if kmq() then alias.kmq() else run(_tb[pfmid].." "..killid) end end
	--_tb=utils.split(killpfm,"|")
	alias.pfm()
end
------------------------------------------------------------------------------------
-- class 相关
------------------------------------------------------------------------------------
function alias.initialize_trigger()
	alias.open_always()
	alias.close_common()
	alias.close_pk()
	alias.close_check()
	alias.close_boat()
	alias.close_gps()
	alias.close_ftb()
	alias.close_fj()
	alias.close_xinfa()
	alias.close_mp()
	alias.close_xue()
	alias.close_kill()
	alias.close_dz()
	alias.close_login()
	alias.close_shizhe()
	alias.close_liaoshang()
	alias.close_quit()
	alias.close_cm()
	alias.close_aoyao()
	allcmd={}
	cmd_flag=true
	cmd={
		nums=0,
		setnums=30,
	}
end
function alias.open_fj()
	openclass("fj")
	openclass("fj_watch")
end
function alias.open_gps()
	openclass("gps_watch")
	openclass("gps_start")
end
function alias.close_gps()
	closeclass("gps_watch")
	closeclass("gps_start")
	alias.close_gps_dealwith()
end
function alias.close_boat()
	openclass("common")
	closeclass("boat")
	closeclass("boat_yell")
end
function alias.open_ftb_search()
	openclass("ftb")
	openclass("ftb_start")
	openclass("gps")
	openclass("ftb_watch")
	npcfind=0
	flytoarealist_backpath=""
end
function alias.close_kill()
	closeclass("kill")
	closeclass("kill_run")
	closeclass("kill_qz")
	closeclass("kill_gm")
	closeclass("kill_sl")
	closeclass("kill_hs")
	closeclass("kill_bt")
	closeclass("kill_em")
	closeclass("kill_th")
	closeclass("kill_gb")
	closeclass("kill_xs")
	closeclass("kill_xx")
end
function alias.close_ftb()
	closeclass("gps_dealwith")
	closeclass("ftb_start")
	closeclass("ftb_watch")
	closeclass("ftb_ask")
	closeclass("ftb_pre")
	flytoareastartid=0
end
function alias.open_always()
	openclass("always_daytime")
	openclass("always_gag")
	closeclass("gag_set")
	openclass("always_gpsalias")
	openclass("always_hp")
	openclass("always_skills")
	openclass("always_watch")
	closeclass("watch_death")
end
function alias.open_boat()
	openclass("boat")
end
function alias.close_check()
	closeclass("check_busy")
	closeclass("check_items")
	closeclass("check_exp")
	closeclass("dealwith_item")
	closeclass("dealwith_gold")
	closeclass("dealwith_he")
	closeclass("dealwith_ji")
	closeclass("dealwith_jian")
	closeclass("dealwith_jiudai")
	closeclass("dealwith_dao")
	closeclass("dealwith_shengzi")
	closeclass("dealwith_staff")
	closeclass("dealwith_bian")
	closeclass("dealwith_bi")
	closeclass("dealwith_gun")
	closeclass("dealwith_fuling")
	closeclass("dealwith_yaodai")
end
function alias.close_xue()
	openclass("skills")
	closeclass("skills_lian")
	closeclass("skills_lingwu")
	closeclass("skills_xue")
	closeclass("skills_jingyao")
	closeclass("dazuo")
end
function alias.open_fj()
	openclass("fj")
	openclass("fj_watch")
end
function alias.close_fj()
	closeclass("fj_pre")
	closeclass("fj_start")
	closeclass("fj_escape")
	closeclass("fj_close")
	closeclass("fj_other")
end
function alias.close_yb()
	closeclass("michen_yb_pre")
	closeclass("michen_yb_start")
	closeclass("michen_yb_start_t")
	closeclass("michen_yb_watch")
end
function alias.open_yb()
	openclass("michen_yb_pre")
	closeclass("michen_yb_start")
	openclass("michen_yb_watch")
end
function alias.close_qzwd()
	closeclass("qzwd")
	closeclass("qzwd_start")
	closeclass("qzwd_pre")
	closeclass("qzwd_watch")
end
function alias.close_mp()
	closeclass("mp_sl")
	closeclass("mp_sl_pre")
	closeclass("mp_sl_start")
	closeclass("mp_sl_watch")
	closeclass("mp_dl")
	closeclass("mp_dl_pre")
	closeclass("mp_dl_start")
	closeclass("mp_dl_watch")
	closeclass("mp_dl_work")
	closeclass("mp_dl_dowork")
	closeclass("mp_wd")
	closeclass("mp_wd_pre")
	closeclass("mp_wd_start")
	closeclass("mp_wd_watch")
	closeclass("mp_hs")
	closeclass("mp_hs_pre")
	closeclass("mp_hs_start")
	closeclass("mp_hs_watch")
	closeclass("mp_bt")
	closeclass("mp_bt_pre")
	closeclass("mp_bt_start")
	closeclass("mp_bt_watch")
	closeclass("mp_th")
	closeclass("mp_th_pre")
	closeclass("mp_th_start")
	closeclass("mp_th_watch")
	closeclass("mp_qz")
	closeclass("mp_qz_pre")
	closeclass("mp_qz_boyao_ti")
	closeclass("mp_qz_boyao")
	closeclass("mp_qz_start")
	closeclass("mp_qz_watch")
	closeclass("mp_em")
	closeclass("mp_em_pre")
	closeclass("mp_em_start")
	closeclass("mp_em_watch")
	closeclass("mp_xs")
	closeclass("mp_xs_lzjob")
	closeclass("mp_xs_pre")
	closeclass("mp_xs_npc1")
	closeclass("mp_xs_npc2")
	closeclass("mp_xs_start")
	closeclass("mp_xs_watch")
	closeclass("mp_gb_pre")
	closeclass("mp_gb_sx")
	closeclass("mp_gb_gold")
	closeclass("mp_gb_gold_ti")
	closeclass("mp_gb_gold_fujia")
	closeclass("mp_gb_gold_owner")
	closeclass("mp_gb_gold_robber")
	closeclass("mp_gb_watch")
	closeclass("mp_xx")
	closeclass("mp_xx_pre")
	closeclass("mp_xx_start")
	closeclass("mp_xx_watch")
	closeclass("mp_xx_pre_sandu")
	closeclass("mp_xx_pre_suck")
	closeclass("mp_xx_start_catch")
	closeclass("mp_xx_start_sandu")
	closeclass("mp_xx_start_search")
	closeclass("mp_xx_xiulian")
	closeclass("mp_xx_kmmr")
	closeclass("mp_gm")
	closeclass("mp_gm_caimi")
	closeclass("mp_gm_caimi_t")
	closeclass("mp_gm_pre")
	closeclass("mp_gm_watch")
	closeclass("mp_gm_job3")
	closeclass("mp_mj")
	closeclass("mp_mj_pre")
	closeclass("mp_mj_yudi")
	closeclass("mp_mj_wxq")
	closeclass("mp_mj_wxqjob")
	closeclass("mp_mj_tyjob")
	closeclass("mp_mj_watch")
end
function alias.close_dz()
	openclass("common")
	closeclass("dazuo")
end
function alias.close_shizhe()
	openclass("common")
	closeclass("shizhe")
end
function alias.close_liaoshang()
	openclass("common")
	closeclass("liaoshang")
end
function alias.close_login()
	openclass("common")
	closeclass("login")
end
function alias.close_xinfa()
	openclass("xinfa")
	closeclass("xf_sl")
	closeclass("sl_sj")
	closeclass("sl_zc")
	closeclass("xf_wd")
	closeclass("wd_xtjf")
	closeclass("wd_xtjf_fight")
	closeclass("xf_em")
	closeclass("xf_em_resetidle")
	closeclass("xf_hs")
	closeclass("xf_mj")
end
function alias.close_pk()
	openclass("pk")
	closeclass("blockpk_pre")
	closeclass("blockpk_start")
end
function alias.close_quit()
	stat.quiting=0
	closeclass("quitdis")
	closeclass("quit")
end
function alias.close_aoyao()
	openclass("common")
	closeclass("aoyao")
end
function alias.close_cm()
	openclass("chongmai")
	closeclass("chongmai_pre")
	closeclass("chongmai_start")
	closeclass("chongmai_watch")
end
function alias.close_common()
	openclass("common")
	closeclass("aoyao")
	closeclass("bidu")
	closeclass("boat")
	closeclass("boat_yell")
	closeclass("dazuo")
	closeclass("dazuo_resetidle")
	closeclass("fang")
	closeclass("liaoshang")
	closeclass("login")
	closeclass("quit")
	closeclass("quitdis")
	closeclass("shizhe")
	closeclass("tongmai")
	closeclass("yinyun")
end
function alias.close_gps_dealwith()
	closeclass("gps_dealwith")
	closeclass("gps_zeikou")
	closeclass("gps_99guai")
	closeclass("gps_climbxy")
	closeclass("gps_dl_fsg")
	closeclass("gps_em_killjm")
	closeclass("gps_lsd_back")
	closeclass("gps_lsd_go")
	closeclass("gps_nanyang")
	closeclass("gps_qzh_mcx")
	closeclass("gps_qzh_sl")
	closeclass("gps_qzh_xmdq")
	closeclass("gps_sgy_sd")
	closeclass("gps_sl_gate")
	closeclass("gps_sl_sl")
	closeclass("gps_slh")
	closeclass("gps_thd_back")
	closeclass("gps_thd_go")
	closeclass("gps_thd_ms")
	closeclass("gps_thd_sg")
	closeclass("gps_thd_thl")
	closeclass("gps_thrownpc")
	closeclass("gps_waitrelease")
	closeclass("gps_xxmap")
	closeclass("gps_xydcy")
	closeclass("gps_xydcy_sl")
	closeclass("gps_yz_lts")
	closeclass("gps_yz_ym")
	closeclass("gps_yztd_1_2")
	closeclass("gps_yztd_2_1")
	closeclass("gps_yztd_2_3")
	closeclass("gps_yztd_3_2")
	closeclass("gps_zhou")
end
------------------------------------------------------------------------------------
-- gps 相关
------------------------------------------------------------------------------------
function alias.SafeEntrance(id)
	local _t=xkxGPS.findSafeExit(id)
	if _t=="" then return "east" end
	--if tonumber(id)==1271 then return "west" end
	local _tb=utils.split(_t,"|")
	return _tb[1]
	--return _tb[math.random(1,table.getn(_tb))]
end
function alias.searcharea()
	alias.close_gps()
	alias.open_ftb_search()
	alias.searchareastep()
end
function alias.searchareanextpath()
	local _tb,_t
	-- #if @debug {#say 做ftb时如果遇到不能等待过过不去的路，则进行下一路径搜索}
	flytoarealistindex=flytoarealistindex+1
	flytoarealist_searchindex=1
	if flytoarealistindex>flytoarealistsum then
		print("搜索结束！")
		run("set searcharea=over")
	else
		_tb=utils.split(flytoarealist,"|")
		_t=_tb[flytoarealistindex]
		_tb=utils.split(_t,"#")
		flytoareastartid=tonumber(_tb[1])
		alias.flytoid(flytoareastartid)
	end
end
function alias.searchareastep()
	local _tb={}
	local _t
	ftbnpcname=""
	ftbnpcid=""
	getgold=0
	if gpserrnum>0 then
		-- 如果走路出现错误，飞到该段路径的起始点
		flytoarealist_searchindex=1
		alias.flytoid(flytoareastartid)
		return
	end
	if flytoarealistindex<=flytoarealistsum then
		_tb=utils.split(flytoarealist,"|")
		flytoarealist_searchlist=_tb[flytoarealistindex]
		_tb=utils.split(flytoarealist_searchlist,">")
		flytoarealist_searchlistsum=tonumber(table.getn(_tb))
		flytoarealist_searchroom=_tb[flytoarealist_searchindex]
		_tb=utils.split(flytoarealist_searchroom,"#")
		flytoarealist_searchdict=_tb[2]
		flytoarealist_searchid=tonumber(_tb[1])
		roomno_now=flytoarealist_searchid
		safego=alias.SafeEntrance(roomno_now)
		SafeBack=invDirection(safego)
		if flytoarealist_searchdict=="over" then
			flytoarealistindex=tonumber(flytoarealistindex+1)
			flytoarealist_searchindex=1
			if flytoarealistindex>flytoarealistsum then
				print("搜索结束！")
				run("set searcharea=over")
			else
				_tb=utils.split(flytoarealist,"|")
				_t=_tb[flytoarealistindex]
				_tb=utils.split(_t,"#")
				flytoareastartid=_tb[1]
				_t=xkxGPS.search(flytoarealist_searchid,flytoareastartid)
				flytoarealist_backpath=string.gsub(_t,";","|")
				flytoarealist_searchlistindex=1
				_tb=utils.split(flytoarealist_backpath,"|")
				flytoarealist_searchlistsum=table.getn(_tb)
				alias.searchareaback()
			end
		else
			Simulate("\n路漫漫其修远兮，在『"..flytoarealistsum.."』中的第『"..flytoarealistindex.."』条 第『"..flytoarealist_searchindex.."』步\n")
			flytoarealist_searchindex=tonumber(flytoarealist_searchindex+1)
			alias.yjl()
			run("halt;"..flytoarealist_searchdict)
			if string.find("|e|w|n|s|ne|se|sw|nw|eu|wu|su|nu|ed|wd|nd|sd|u|d|enter|out|","|"..flytoarealist_searchdict.."|") then run("set checknpc=yes") end
		end
	else
		run("set searcharea=over")
	end
end
function alias.searchareastep2()
	local _tb,_t
	ftbnpcname=""
	ftbnpcid=""
	getgold=0
	if flytoarealistindex<=flytoarealistsum then
		_tb=utils.split(flytoarealist,"|")
		flytoarealist_searchlist=_tb[flytoarealistindex]
		_tb=utils.split(flytoarealist_searchlist,">")
		flytoarealist_searchlistsum=tonumber(table.getn(_tb))
		flytoarealist_searchroom=_tb[flytoarealist_searchindex]
		_tb=utils.split(flytoarealist_searchroom,"#")
		flytoarealist_searchdict=_tb[2]
		flytoarealist_searchid=tonumber(_tb[1])
		roomno_now=flytoarealist_searchid
		safego=alias.SafeEntrance(roomno_now)
		SafeBack=invDirection(safego)
		if flytoarealist_searchdict=="over" then
			flytoarealistindex=tonumber(flytoarealistindex+1)
			flytoarealist_searchindex=1
			if flytoarealistindex>flytoarealistsum then
				print("搜索结束！")
				run("set searcharea=over")
			else
				_tb=utils.split(flytoarealist,"|")
				_t=_tb[flytoarealistindex]
				_tb=utils.split(_t,"#")
				flytoareastartid=_tb[1]
				_t=xkxGPS.search(flytoarealist_searchid,flytoareastartid)
				flytoarealist_backpath=string.gsub(_t,";","|")
				flytoarealist_searchlistindex=1
				_tb=utils.split(flytoarealist_backpath,"|")
				flytoarealist_searchlistsum=table.getn(_tb)
				alias.searchareaback2()
			end
		else
			Simulate("\n路漫漫其修远兮，在『"..flytoarealistsum.."』中的第『"..flytoarealistindex.."』条 第『"..flytoarealist_searchindex.."』步\n")
			if flytoarealist_searchindex==1 then
				-- 起始点不能到达，重设起始点，否则走出出错需要飞到起始点时会反复出错。
				_tb=utils.split(flytoarealist,"|")
				_t=_tb[flytoarealistindex]
				_tb=utils.split(_t,">")
				_t=_tb[flytoarealist_searchindex+1]
				_tb=utils.split(_t,"#")
				flytoareastartid=_tb[1]
			end
			flytoarealist_searchindex=tonumber(flytoarealist_searchindex+1)
		end
	else
		run("set searcharea=over")
	end
end
function alias.searchareastep3()
	local _tb,_t
	ftbnpcname=""
	ftbnpcid=""
	getgold=0
	if tonumber(flytoarealistindex)<=tonumber(flytoarealistsum) then
		_tb=utils.split(flytoarealist,"|")
		flytoarealist_searchlist=_tb[flytoarealistindex]
		_tb=utils.split(flytoarealist_searchlist,">")
		flytoarealist_searchlistsum=table.getn(_tb)
		_tb=utils.split(flytoarealist_searchlist,">")
		flytoarealist_searchroom=_tb[flytoarealist_searchindex]
		_tb=utils.split(flytoarealist_searchroom,"#")
		flytoarealist_searchdict=_tb[2]
		_tb=utils.split(flytoarealist_searchroom,"#")
		flytoarealist_searchid=_tb[1]
		roomno_now=tonumber(flytoarealist_searchid)
		safego=alias.SafeEntrance(roomno_now)
		SafeBack=invDirection(safego)
		if flytoarealist_searchdict=="over" then
			flytoarealistindex=tonumber(flytoarealistindex)+1
			flytoarealist_searchindex=1
			if tonumber(flytoarealistindex)>tonumber(flytoarealistsum) then
				print("搜索结束！")
				run("set searcharea=over")
			else
				_tb=utils.split(flytoarealist,"|")
				_t=_tb[flytoarealistindex]
				_tb=utils.split(_t,"#")
				flytoareastartid=tonumber(_tb[1])
				_t=xkxGPS.search(flytoarealist_searchid,flytoareastartid)
				flytoarealist_backpath=string.gsub(_t,";","|")
				flytoarealist_searchlistindex=1
				_tb=utils.split(flytoarealist_backpath,"|")
				flytoarealist_searchlistsum=table.getn(_tb)
				alias.searchareaback2()
			end
		else
			Simulate("路漫漫其修远兮，在『"..tostring(flytoarealistsum).."』中的第『"..tostring(flytoarealistindex).."』条 第『"..tostring(flytoarealist_searchindex).."』步\n")
			if tonumber(flytoarealist_searchindex)==1 then
				-- #if @debug {#say 起始点不能到达，重设起始点，否则走出出错需要飞到起始点时会反复出错。}
				_tb=utils.split(flytoarealist,"|")
				_t=_tb[flytoarealistindex]
				_tb=utils.split(_t,">")
				_t=_tb[tonumber(flytoarealist_searchindex)+1]
				_tb=utils.split(_t,"#")
				flytoareastartid=_tb[1]
			end
			flytoarealist_searchindex=tonumber(flytoarealist_searchindex)+2
		end
	else run("set searcharea=over") end
end
function alias.searchareaback()
	local _tb={}
	ftbnpcname=""
	ftbnpcid=""
	getgold=0
	if flytoarealist_searchlistindex<=flytoarealist_searchlistsum then
		_tb=utils.split(flytoarealist_backpath,"|")
		flytoarealist_searchdict=_tb[flytoarealist_searchlistindex]
		flytoarealist_searchlistindex=tonumber(flytoarealist_searchlistindex+1)
		run("halt")
		if flytoarealist_searchdict=="isHere" then
			-- 搜索的下一个路径起始点是原地
			flytoarealist_searchlistindex=1
			flytoarealist_backpath=""
			alias.searchareastep()
		else
			run(flytoarealist_searchdict)
			if string.find("|e|w|n|s|ne|se|sw|nw|eu|wu|su|nu|ed|wd|nd|sd|u|d|enter|out|","|"..flytoarealist_searchdict.."|") then run("set checknpc=yes") end
		end
	else
		flytoarealist_searchlistindex=1
		flytoarealist_backpath=""
		alias.searchareastep()
	end
end
function alias.searchareaback2()
	local _tb
	ftbnpcname=""
	ftbnpcid=""
	getgold=0
	if flytoarealist_searchlistindex<=flytoarealist_searchlistsum then
		_tb=utils.split(flytoarealist_backpath,"|")
		flytoarealist_searchdict=_tb[flytoarealist_searchlistindex]
		flytoarealist_searchlistindex=flytoarealist_searchlistindex+1
	else
		flytoarealist_searchlistindex=1
		flytoarealist_backpath=""
		alias.searchareastep2()
	end
end
function alias.searcharea_research()
	-- 杀npc时follow，npc移动后需要flyto中心点，重新当前路径搜索，这里初始化参数
	flytoarealist_searchindex=1
	alias.searcharea()
end
function alias.goto(n,l,w)
	if w[1]==nil or w[1]=="" then print("你耍我玩呢？？？") end
	local a=utils.split(w[1]," ")
	if tonumber(a[1])~=nil and tonumber(a[1])>0 then
		alias.flytoid(tonumber(a[1]))
	else
		alias.flyto(a[1],a[2])
	end
end
function alias.flyto(a,b)
	if string.len(gpszeikou)==0 and gpserrnum==0 and isopen("gps_start") then print("急什么急，GPS模块正在运行中，不能重复启动")
	else
		if type(a)=="number" or tonumber(a)~=nil then alias.flytoid(tonumber(a));return end
		if b~=nil then flytozone=b else flytozone="none" end
		if a~=nil then
			flytoname=a
			alias.flytoname(flytoname,flytozone)
		end
	end
end
function alias.flytoarea(a,b,c)
	local _tb,_t
	if string.len(gpszeikou)==0 and gpserrnum==0 and isopen("gps_start") then print("急什么急，GPS模块正在运行中，不能重复启动")
	else
		alias.initialize_gps()
		alias.open_gps()
		if b~=nil then flytozone=b else flytozone="none" end 
		if a~=nil and c~=nil then
			flytoname=a
			flytoareanum=tonumber(c)
			gps_cmd=alias.flytoarea
			gps_cmd_dest=flytoname
			gps_cmd_zone=flytozone
			gps_cmd_num=flytoareanum
			--gps_cmd="/alias.flytoarea("..flytoname..","..flytozone..","..flytoareanum..")"
			flytoarealist=xkxGPS.findroomarea(flytoname,flytozone,flytoareanum)
			--print("搜索路径为："..tostring(flytoarealist))
			if string.len(flytoarealist)==0 then
				Simulate("区域搜索中心点房间查找失败！\n")
				flytoname=""
				run("set gps=false")
			else
				if string.len(flytoarealist)==0 then
					print("搜索 "..flytozone.." 区域 "..flytoname.." 附近 "..flytoareanum.." 个房间失败")
					run("set gps=false")
				else
					-- 范围路径为：@flytoarealist
					flytoarealistindex=1
					_tb=utils.split(flytoarealist,"|")
					flytoarealistsum=table.getn(_tb)
					_t=_tb[flytoarealistindex]
					_tb=utils.split(_t,"#")
					flytoareastartid=tonumber(_tb[1])
					flytoarealist_searchindex=1
					-- 起始房间为%word( %item( @flytoarealist, 1), 1, "#")，共有@flytoarealistsum 条路径
					alias.close_gps()
					alias.flytoid(flytoareastartid)
				end
			end
		else
			print("请正确输入房间中文名或搜索范围！")
		end	
	end
end
function alias.flytoname(a,b)
	local _tb
	if string.len(gpszeikou)==0 and gpserrnum==0 and isopen("gps_start") then print("急什么急，GPS模块正在运行中，不能重复启动")
	else
		alias.initialize_gps()
		alias.open_gps()
		flytonpc=""
		flytoid=0
		if b~=nil then flytozone=b else flytozone="none" end
		if a~=nil then
			flytoname=a
			gps_cmd=alias.flytoname
			gps_cmd_dest=flytoname
			gps_cmd_num=nil
			if flytozone=="none" then
				gps_cmd_zone=nil
				-- gps_cmd="/alias.flytoname("..flytoname..")"
			else
				gps_cmd_zone=flytozone
				--gps_cmd="/alias.flytoname("..flytoname..","..flytozone..")"
			end
			flytonamelist=xkxGPS.findroomno(flytoname,flytozone)
			if string.len(flytonamelist)==0 then
				print("查找房间失败！")
				run("set gps=false")
			else
				flytonamelistindex=1
				_tb=utils.split(flytonamelist,"|")
				flytonamelistsum=table.getn(_tb)
				-- 到@flytoname共有重名房间@flytonamelistsum个
				print("到"..flytoname.."共有重名房间"..flytonamelistsum.."个")
				if flytonamelistsum>1 then alias.flytoid_name(_tb[flytonamelistindex]) else alias.flytoid_name(flytonamelist) end
			end
		else
			print("请正确输入房间中文名！")
		end
	end
end
function alias.flytonpc(a,b)
	if string.len(gpszeikou)==0 and gpserrnum==0 and isopen("gps_start") then print("急什么急，GPS模块正在运行中，不能重复启动")
	else
		alias.initialize_gps()
		alias.open_gps()
		flytoname=""
		flytoid=0
		if b~=nil then flytozone=b else flytozone="none" end
		if a~=nil then
			flytonpc=a
			gps_cmd=alias.flytonpc
			gps_cmd_dest=flytonpc
			gps_cmd_num=nil
			if flytozone=="none" then
				gps_cmd_zone=nil
				--gps_cmd="/alias.flytonpc("..flytonpc..")"
			else
				gps_cmd_zone=flytozone
				--gps_cmd="/alias.flytonpc("..flytonpc..","..flytozone..")"
			end
			flytonpclist=xkxGPS.findroomnpc(flytonpc,flytozone)
			if string.len(flytonpclist)==0 then
				print("查找NPC失败！")
				run("set gps=false")
			else
				flytonpclistindex=1
				_tb=utils.split(flytonpclist,"|")
				flytonpclistsum=table.getn(_tb)
				-- 到@flytonpc共有重名房间@flytonpclistsum个
				if flytonpclistsum>1 then alias.flytoid_npc(_tb[flytonpclistindex]) else alias.flytoid_npc(flytonpclist) end
			end
		else
			print("请正确输入NPC中文名！")
		end
	end
end
function alias.flytoid_npc(a)
	flytoid=tonumber(a)
	killnpcover=""
	killnpcnum=0
	if flytoid>0 then alias.gps() else Simulate("请输入正确的房间ID\n") end
end
function alias.flytoid_name(a)
	alias.initialize_gps()
	killnpcover=""
	killnpcnum=0
	flytoid=tonumber(a)
	if flytoid>0 then alias.gps() else Simulate("请输入正确的房间ID\n") end
end
function alias.walkover_flytoid()
	local _tb,_f
	if string.len(gpszeikou)==0 then
		alias.close_gps()
		if gpserrnum==0 then
			if flytoareastartid==0 then
				roomno_now=flytoid
				safego=alias.SafeEntrance(roomno_now)
				SafeBack=invDirection(safego)
				flyto=tonumber(flytoid)
				flytoid=0
				Simulate("\n数码世界，数字地图，"..flyto.."就是这里！\n")
			else alias.searcharea() end
		else
			wait.make(function()
				_f=function()
							gpserrnum=0
							checkmove.NotGPSMove=1
							alias.close_gps()
							pcall(gps_cmd,gps_cmd_dest,gps_cmd_zone,gps_cmd_num)
							-- Execute(gps_cmd)
					end
				wait.time(2)
				_f()
			end)
		end	
	else
		if me.menpai=="em" then
			_tb=utils.split(gpszeikou," ")
			run("kill ".._tb[3]..";halt;persuade ".._tb[3])
		else alias.fjskillskill(gpszeikou) end
	end
end
function alias.walkover_flytoname()
	local _f,_tb
	wait.make(function()
		if flytonamelistsum==1 then
			if string.len(gpszeikou)==0 then
				-- 没有贼寇拦路
				alias.close_gps()
				if gpserrnum==0 then
					roomno_now=flytoid
					safego=alias.SafeEntrance(roomno_now)
					SafeBack=invDirection(safego)
					flyto=flytoname
					flytoname=""
					flytonamelistsum=0
					flytoid=0
					Simulate("\n你口念咒语『神马都是浮云,虾米都是尘土』，『"..flyto.."』立马到达！\n")
				else
					_f=function()
								gpserrnum=0
								dropweapon=0
								checkmove.NotGPSMove=1
								alias.close_gps()
								pcall(gps_cmd,gps_cmd_dest,gps_cmd_zone,gps_cmd_num)
								-- Execute(gps_cmd)
						end
					wait.time(2);_f()
				end
			else
				-- 有贼寇拦路
				if me.menpai=="em" then
					_tb=utils.split(gpszeikou," ")
					run("kill ".._tb[3]..";halt;persuade ".._tb[3])
				else alias.fjskillskill(gpszeikou) end
			end
		else
			if string.len(gpszeikou)==0 then
				-- 没有贼寇拦路
				alias.close_gps()
				if gpserrnum==0 then
					_tb=utils.split(flytonamelist,"|")
					roomno_now=tonumber(_tb[flytonamelistindex])
					safego=alias.SafeEntrance(roomno_now)
					SafeBack=invDirection(safego)
					flyto=flytoname
					flytosum=flytonamelistsum
					flytoidx=flytonamelistindex
					if flytonamelistindex==flytonamelistsum then
						flytoname=""
						flytonamelistindex=0
						flytonamelistsum=0
						print("全部地点搜索完毕！")
					end
					flytoid=0
					Simulate("\n浮云朵朵飘，飘到了 "..flytosum.." 个『"..flyto.."』中的第 "..flytoidx.." 个～～\n")
				else
					if fjroomid==0 then
						-- print("防止flytonext的时候出现fj且走路出现错误，如石阶出现seng，gpserr=1的时候")
						_f=function()
									gpserrnum=0
									checkmove.NotGPSMove=1
									alias.close_gps()
									pcall(gps_cmd,gps_cmd_dest,gps_cmd_zone,gps_cmd_num)
									-- Execute(gps_cmd)
							end
						wait.time(2);_f()
					end
				end
			else
				-- 有贼寇拦路
				if me.menpai=="em" then
					_tb=utils.split(gpszeikou," ")
					run("kill ".._tb[3]..";halt;persuade ".._tb[3])
				else alias.fjskillskill(gpszeikou) end
			end
		end
	end)
end
function alias.walkover_flytonpc()
	local _f,_tb
	wait.make(function()
		if flytonpclistsum==1 then
			if string.len(gpszeikou)==0 then
				-- 没有贼寇拦路
				alias.close_gps()
				if gpserrnum==0 then
					roomno_now=flytoid
					safego=alias.SafeEntrance(roomno_now)
					SafeBack=invDirection(safego)
					flyto=flytonpc
					flytonpc=""
					flytonpclistsum=0
					flytoid=0
					Simulate("\n有一天，你踩着七色云彩来迎娶『"..flyto.."』\n")
				else
					_f=function()
								gpserrnum=0
								checkmove.NotGPSMove=1
								alias.close_gps()
								pcall(gps_cmd,gps_cmd_dest,gps_cmd_zone,gps_cmd_num)
								-- Execute(gps_cmd)
						end
					wait.time(2);_f()
				end
			else
				-- 有贼寇拦路
				if me.menpai=="em" then
					_tb=utils.split(gpszeikou," ")
					run("kill ".._tb[3]..";halt;persuade ".._tb[3])
				else alias.fjskillskill(gpszeikou) end
			end
		else
			if string.len(gpszeikou)==0 then
				-- 没有贼寇拦路
				alias.close_gps()
				if gpserrnum==0 then
					_tb=utils.split(flytonpclist,"|")
					roomno_now=tonumber(_tb[flytonpclistindex])
					safego=alias.SafeEntrance(roomno_now)
					SafeBack=invDirection(safego)
					flyto=flytonpc
					flytosum=flytonpclistsum
					flytoidx=flytonpclistindex
					if flytonpclistindex==flytonpclistsum then
						flytonpc=""
						flytonpclistindex=0
						flytonpclistsum=0
						print("全部NPC搜索完毕！")
					end
					flytoid=0
					Simulate("\n双飞，三飞，大家一起飞，先×"..flytosum.." 个『 "..flyto.." 』中的第 "..flytoidx.." 个～～\n")
				else
					if fjroomid==0 then
						-- print("防止flytonext的时候出现fj且走路出现错误，如石阶出现seng，gpserr=1的时候")
						_f=function()
									gpserrnum=0
									checkmove.NotGPSMove=1
									alias.close_gps()
									pcall(gps_cmd,gps_cmd_dest,gps_cmd_zone,gps_cmd_num)
									-- Execute(gps_cmd)
							end
						wait.time(2);_f()
					end
				end
			else
				-- 有贼寇拦路
				if me.menpai=="em" then
					_tb=utils.split(gpszeikou," ")
					run("kill ".._tb[3]..";halt;persuade ".._tb[3])
				else alias.fjskillskill(gpszeikou) end
			end
		end
	end)
end
function alias.initialize_gps()
	entrance="none"
	xkxGPS.setEntrance(entrance)
end
function alias.gps()
	alias.initialize_gps()
	alias.open_gps()
	if checkmove.NotGPSMove>0 then run("look;set gps=start") else run("look;set gps=end") end
end
function alias.flytoid(id)
	if string.len(gpszeikou)==0 and gpserrnum==0 and isopen("gps_start") then
		print("急什么急，GPS模块正在运行中，不能重复启动")
	else
		alias.initialize_gps()
		alias.open_gps()
		flytoname=""
		flytonamelistindex=0
		flytonamelistsum=0
		flytonpc=""
		flytonpclistindex=0
		flytonpclistsum=0
		killnpcover=""
		killnpcnum=0
		flytoid=tonumber(id)
		if flytoid>0 then
			gps_cmd=alias.flytoid
			gps_cmd_dest=flytoid
			gps_cmd_num=nil
			gps_cmd_zone=nil
			--gps_cmd="/alias.flytoid("..tostring(flytoid)..")"
			alias.gps()
		else Simulate("请输入正确的房间ID\n") end
	end
end
function alias.fn()
	alias.flytonext()
end
function alias.flytonext()
	local _tb
	if string.len(gpszeikou)==0 and gpserrnum==0 and isopen("gps_start") then
		print("急什么急，GPS模块正在运行中，不能重复启动")
	else
		alias.open_gps()
		if flytonamelistsum>0 then
			flytonamelistindex=flytonamelistindex+1
			if flytonamelistsum>=flytonamelistindex then
				_tb=utils.split(flytonamelist,"|")
				path=xkxGPS.search(roomno_now,_tb[flytonamelistindex])
				-- print("搜索路径为："..path)
				xkxGPS.pathlist(path)
				pathindex=0
				run("halt")
				run(xkxGPS.pathArray2(pathindex))
			else print("所有地点搜索结束！") end
		end
		if flytonpclistsum>0 then
			flytonpclistindex=flytonpclistindex+1
			if flytonpclistsum>=flytonpclistindex then
				_tb=utils.split(flytonpclist,"|")
				path=xkxGPS.search(roomno_now,_tb[flytonpclistindex])
				-- print("搜索路径为："..path)
				xkxGPS.pathlist(path)
				pathindex=0
				run("halt")
				run(xkxGPS.pathArray2(pathindex))
			else print("所有地点搜索结束！") end
		end
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
-- always_gpsalias
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function alias.trymove(a)
	if string.len(a)>0 then
		trymovesuccess=true
		run(a..";set checkmove=yes")
	end
end
function alias.movefinish()
	if pathindex==(xkxGPS.pathListNum2-1) and xkxGPS.pathArray2(xkxGPS.pathListNum2)=="set walk over" then
		pathindex=tonumber(pathindex+1)
		run(xkxGPS.pathArray2(pathindex))
	else run("set walk off") end
end
function alias.guohe()
	alias.open_boat()
	gps_gyz_go_e_boat=0
	tunanum=0
	tuna=1
	checkyell=0
	if skillslist["shaolin-shenfa"]==nil then skillslist["shaolin-shenfa"]={} end
	if skillslist["shaolin-shenfa"]["lvl"]==nil then skillslist["shaolin-shenfa"]["lvl"]=1 end
	if skillslist["hunyuan-yiqi"]==nil then skillslist["hunyuan-yiqi"]={} end
	if skillslist["hunyuan-yiqi"]["lvl"]==nil then skillslist["hunyuan-yiqi"]["lvl"]=1 end
	if (me.menpai=="sl" and me.master=="觉心" and skillslist["shaolin-shenfa"]["lvl"]>=200 and skillslist["hunyuan-yiqi"]["lvl"]>=160 and hp.maxneili>=2000) then
		yunbusy=0
		run("yun du;set checkyunbusy=yes")
	else run("yell boat;set checkyell=yes") end
end
function alias.xxgg1xxgg2()
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_xxmap")
	gps_xxgg_dict=1432
	run("look")
end
function alias.xxgg2xxgg1()
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_xxmap")
	gps_xxgg_dict=1433
	run("look")
end
function alias.wdxymwdsj()
	-- 武当玄岳门到武当石阶，处理「知客道长」灵虚道长
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if findstring(me.menpai,"wd","em","qz","dl","sl") then alias.trymove("su") else
		if killnpcnum<killnpcsum then
			killnpcover="wdxym-wdsj"
			if pfmkill() then alias.fjskillskill("GPS 灵虚道长 lingxu daozhang") else run("kill lingxu daozhang") end
		else alias.trymove("su") end
	end
end
function alias.dmkzcc()
	openclass("boat")
	gps_dmkz_cc=1
	run("w")
end
function alias.ccdmkz()
	openclass("boat")
	gps_dmkz_cc=0
	run("e")
end
function alias.wdyzgwdbl()
	-- 武当遇真宫到武当柏林，处理「制香道长」凌虚道长
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="wd" then alias.trymove("su") else
		if killnpcnum<killnpcsum then
			killnpcover="wdyzg-wdbl"
			if pfmkill() then alias.fjskillskill("GPS 凌虚道长 lingxu daozhang") else run("kill lingxu daozhang") end
		else alias.trymove("su") end
	end
end
function alias.wdhdzlwdhy()
	-- 武当后殿走廊到武当后院，处理「武当四侠」张松溪
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="wd" then alias.trymove("s") else
		if killnpcnum<killnpcsum then
			killnpcover="wdhdzl-wdhy"
			if pfmkill() then alias.fjskillskill("GPS 张松溪 zhang songxi") else run("kill zhang songxi") end
		else alias.trymove("s") end
	end
end
function alias.opendoorsouth()
	run("open door;s")
	alias.movefinish()
end
function alias.opendoornorth()
	run("open door;n")
	alias.movefinish()
end
function alias.opendoorwest()
	run("open door;w")
	alias.movefinish()
end
function alias.opendooreast()
	run("open door;e")
	alias.movefinish()
end
function alias.opendoorse()
	run("open door;se")
	alias.movefinish()
end
function alias.opendoorsw()
	run("open door;sw")
	alias.movefinish()
end
function alias.opendoorne()
	run("open door;ne")
	alias.movefinish()
end
function alias.opendoornw()
	run("open door;nw")
	alias.movefinish()
end
function alias.wdhdzlwdxxzl()
	-- 武当后殿走廊到西厢走廊，处理「武当四侠」张松溪
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="wd" then alias.trymove("w") else
		if killnpcnum<killnpcsum then
			killnpcover="wdhdzl-wdxxzl"
			if pfmkill() then alias.fjskillskill("GPS 张松溪 zhang songxi") else run("kill zhang songxi") end
		else alias.trymove("w") end
	end
end
function alias.wdhdzlwddxzl()
	-- 武当后殿走廊到东厢走廊，处理「武当四侠」张松溪
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="wd" then alias.trymove("e") else
		if killnpcnum<killnpcsum then
			killnpcover="wdhdzl-wddxzl"
			if pfmkill() then alias.fjskillskill("GPS 张松溪 zhang songxi") else run("kill zhang songxi") end
		else alias.trymove("e") end
	end
end
function alias.xydsmhyl()
	-- 西域大沙漠到胡杨林
	for i=1,10,1 do run("w") end
	alias.yjl()
	run("drink jiudai")
	alias.movefinish()
end
function alias.hylxydsm()
	-- 胡杨林到西域大沙漠
	for i=1,10,1 do run("e") end
	alias.yjl()
	run("drink jiudai")
	alias.movefinish()
end
function alias.btssmqy()
	-- 白驼山山门到前院，处理白驼山第四代弟子
	killnpcsum=2
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="bt" then alias.trymove("wu") else
		if killnpcnum<killnpcsum then
			killnpcover="btssm-qy"
			if pfmkill() then alias.fjskillskill("GPS 家丁 jiading") else run("kill jiading") end
		else alias.trymove("wu") end
	end
end
function alias.xydsmsczl()
	-- 西域大沙漠到丝绸之路
	for i=1,10,1 do run("e") end
	alias.yjl()
	run("drink jiudai")
	alias.movefinish()
end
function alias.byjybykt()
	-- 西域巴依家院到巴依家客厅，处理巴依 胡老爷
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="" then alias.trymove("e") else
		if killnpcnum<killnpcsum then
			killnpcover="byjy-bykt"
			if pfmkill() then alias.fjskillskill("GPS 胡老爷 hu laoye") else run("kill hu laoye") end
		else alias.trymove("e") end
	end
end
function alias.clbdmclbdt()
	-- 长乐帮大门到长乐帮大厅，处理虎猛堂香主 邱山风
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="" then alias.trymove("enter") else
		if killnpcnum<killnpcsum then
			killnpcover="clbdm-clbdt"
			if pfmkill() then alias.fjskillskill("GPS 邱山风 qiu shanfeng") else run("kill qiu shanfeng") end
		else alias.trymove("enter") end
	end
end
function alias.clbxtclbws()
	-- 长乐帮小厅到长乐帮卧室，处理「八爪金龙」司徒横
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="" then alias.trymove("n") else
		if killnpcnum<killnpcsum then
			killnpcover="clbxt-clbws"
			if pfmkill() then alias.fjskillskill("GPS 司徒横 situ heng") else run("kill situ heng") end
		else alias.trymove("n") end
	end
end
function alias.clbydclbss()
	-- 长乐帮甬道到长乐帮石室，处理虎猛堂 帮众
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="" then alias.trymove("e") else
		if killnpcnum<killnpcsum then
			killnpcover="clbyd-clbss"
			if pfmkill() then alias.fjskillskill("GPS 帮众 changle bangzhong") else run("kill changle bangzhong") end
		else alias.trymove("e") end
	end
end
function alias.dladfxy()
	-- 大理定安府到小院，处理大理国武将 傅思归
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_dl_fsg")
	openclass("gps_thrownpc")
	thrownpcfaint=false
	alias.trymove("s")
end
function alias.enterdong()
	run("enter dong")
	alias.movefinish()
end
function alias.enterpicture()
	run("enter picture")
	alias.movefinish()
end
function alias.xxgg1tsysd()
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_xxmap")
	gps_xxgg_dict=1434
	run("look")
end
function alias.tsysdxxgg1()
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_xxmap")
	gps_xxgg_dict=1433
	run("look")
end
function alias.emhcazdemhcagc()
	-- 峨嵋华藏庵正殿到华藏庵广场，处理静心师太
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="em" then alias.trymove("s") else
		if killnpcnum<killnpcsum then
			killnpcover="emhcazd-emhcagc"
			if pfmkill() then alias.fjskillskill("GPS 静心 jing xin") else run("kill jing xin") end
		else alias.trymove("s") end
	end
end
function alias.emjld99guai()
	-- 峨嵋九老洞口到九十九道拐
	cmdonsuccess="northeast"
	yinshecmd="halt;ne;sw;ne;sw;ne;sw;ne;sw;ne;sw;ne;sw;ne;sw;ne;sw"
	cmdonsheexist="down;wu"
	openclass("gps_dealwith")
	openclass("gps_99guai")
	run("set 检查蟒蛇在不在")
end
function alias.emqfa99guai()
	-- 峨嵋千佛庵到九十九道拐
	cmdonsuccess="southwest"
	yinshecmd="halt;sw;ne;sw;ne;sw;ne;sw;ne;sw;ne;sw;ne;sw;ne;sw;ne"
	cmdonsheexist="down;wu"
	openclass("gps_dealwith")
	openclass("gps_99guai")
	run("set 检查蟒蛇在不在")
end
function alias.gbqzlgbtdm()
	run("e;n;w;n;e;w;n")
	alias.movefinish()
end
function alias.gbkilljian()
	-- 丐帮竹林小道到竹林小道，处理「执法长老」简长老
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="gb" then alias.trymove("e") else
		if killnpcnum<killnpcsum then
			killnpcover="gb-killjian"
			if pfmkill() then alias.fjskillskill("GPS 简长老 jian zhanglao") else run("kill jian zhanglao") end
		else alias.trymove("e") end
	end
end
function alias.gyzguohe()
	run("ask lu about 归云庄;decide")
	alias.guohe()
end
function alias.gyzdmqy()
	-- 归云庄大门到归云庄前院，给家丁书信
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="th" then alias.trymove("enter") else
		run("give ding xin")
		alias.trymove("enter")
	end
end
function alias.hslwchskt()
	-- 华山练武场到华山客厅，处理劳德诺
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="hs" then alias.trymove("s") else
		if killnpcnum<killnpcsum then
			killnpcover="hslwc-hskt"
			if pfmkill() then alias.fjskillskill("GPS 劳德诺 lao denuo") else run("kill lao denuo") end
		else alias.trymove("s") end
	end
end
function alias.hslwchsbqf()
	-- 华山练武场到华山兵器房，处理劳德诺
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="hs" then alias.trymove("w") else
		if killnpcnum<killnpcsum then
			killnpcover="hslwc-hsbqf"
			if pfmkill() then alias.fjskillskill("GPS 劳德诺 lao denuo") else run("kill lao denuo") end
		else alias.trymove("w") end
	end
end
function alias.hsdlhssy()
	-- 华山东廊到华山书院，处理梁发
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="hs" then alias.trymove("e") else
		if killnpcnum<killnpcsum then
			killnpcover="hsdl-hssy"
			if pfmkill() then alias.fjskillskill("GPS 梁发 liang fa") else run("kill liang fa") end
		else alias.trymove("e") end
	end
end
function alias.hshyhszl()
	-- 华山后院到华山走廊，处理陆大有
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="hs" then alias.trymove("s") else
		if killnpcnum<killnpcsum then
			killnpcover="hshy-hszl"
			if pfmkill() then alias.fjskillskill("GPS 陆大有 lu dayou") else run("kill lu dayou") end
		else alias.trymove("s") end
	end
end
function alias.hslwjggk()
	run("enter 第四株")
	alias.movefinish()
end
function alias.hspthsdlgf()
	-- 华山偏厅到华山东练功房，处理宁中则
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="hs" then alias.trymove("e") else
		if killnpcnum<killnpcsum then
			killnpcover="hspt-hsdlgf"
			if pfmkill() then alias.fjskillskill("GPS 宁中则 ning zhongze") else run("kill ning zhongze") end
		else alias.trymove("e") end
	end
end
function alias.hspthsqs()
	-- 华山偏厅到华山寝室，处理宁中则
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="hs" then alias.trymove("s") else
		if killnpcnum<killnpcsum then
			killnpcover="hspt-hsqs"
			if pfmkill() then alias.fjskillskill("GPS 宁中则 ning zhongze") else run("kill ning zhongze") end
		else alias.trymove("s") end
	end
end
function alias.hspthsxlgf()
	-- 华山偏厅到华山西练功房，处理宁中则
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="hs" then alias.trymove("w") else
		if killnpcnum<killnpcsum then
			killnpcover="hspt-hsxlgf"
			if pfmkill() then alias.fjskillskill("GPS 宁中则 ning zhongze") else run("kill ning zhongze") end
		else alias.trymove("w") end
	end
end
function alias.openzhumenwest()
	run("open 竹门;w")
	alias.movefinish()
end
function alias.openzhumeneast()
	run("open 竹门;e")
	alias.movefinish()
end
function alias.hsxlhscf()
	-- 华山西廊到华山厨房，处理岳灵姗
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="hs" then alias.trymove("w") else
		if killnpcnum<killnpcsum then
			killnpcover="hsxl-hscf"
			if pfmkill() then alias.fjskillskill("GPS 岳灵姗 yue lingshan") else run("kill yue lingshan") end
		else alias.trymove("w") end
	end
end
function alias.hsxslhsxz()
	-- 华山小山路到华山华山小筑，处理施戴子
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="hs" then alias.trymove("w") else
		if killnpcnum<killnpcsum then
			killnpcover="hsxsl-hsxz"
			if pfmkill() then alias.fjskillskill("GPS 施戴子 shi daizi") else run("kill shi daizi") end
		else alias.trymove("w") end
	end
end
function alias.hztyjdmqsl()
	-- 杭州天鹰教大门到青石路，处理天鹰教守卫
	killnpcsum=2
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="mj" then alias.trymove("n") else
		if killnpcnum<killnpcsum then
			killnpcover="hztyjdm-qsl"
			if pfmkill() then alias.fjskillskill("GPS 天鹰教守卫 shou wei") else run("kill shou wei") end
		else alias.trymove("n") end
	end
end
function alias.klmlmsj()
	-- 昆仑山摩罗门到石阶，处理说不得
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="mj" then alias.trymove("up") else
		if killnpcnum<killnpcsum then
			killnpcover="klmlm-sj"
			if pfmkill() then alias.fjskillskill("GPS 说不得 shuo bude") else run("kill shuo bude") end
		else alias.trymove("up") end
	end
end
function alias.kljssk()
	run("push dashi;enter")
	alias.movefinish()
end
function alias.lmbjxy()
	-- 杭州龙门镖局到小院，处理都大锦
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="" then alias.trymove("enter") else
		if killnpcnum<killnpcsum then
			killnpcover="lmbj-xy"
			if pfmkill() then alias.fjskillskill("GPS 都大锦 du dajin") else run("kill du dajin") end
		else alias.trymove("enter") end
	end
end
function alias.lsddytgk()
	-- 灵蛇岛到塘沽口
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_lsd_back")
	run("yell chuan;enter;start;w")
end
function alias.tgklsddy()
	-- 塘沽口到灵蛇岛
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_lsd_go")
	run("yell chuan;enter;start;s;locate")
end
function alias.qzqcjy()
	-- 全真青城到靖远
	run("n;e;s;w;n;n")
	alias.movefinish()
end
function alias.qzqcxy()
	-- 全真青城到悬崖
	run("n;e;e;e;e;e")
	alias.movefinish()
end
function alias.qzxyqc()
	-- 全真悬崖到青城
	run("w;w;w;w;w;s")
	alias.movefinish()
end
function alias.qzjyqc()
	-- 全真靖远到青城
	run("s;s;e;n;w;s")
	alias.movefinish()
end
function alias.lzbmcf()
	-- 西夏灵州边门到柴房，处理国皇宫卫士
	killnpcsum=2
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="" then
		run("open door")
		alias.trymove("w")
	else
		if killnpcnum<killnpcsum then
			killnpcover="lzbm-cf"
			if pfmkill() then alias.fjskillskill("GPS 皇宫卫士 wei shi") else run("kill wei shi") end
		else
			run("open door")
			alias.trymove("w")
		end
	end
end
function alias.lzdjjfjjfdy()
	-- 西夏灵州大将军府到将军府大院，处理校尉
	killnpcsum=2
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="" then alias.trymove("s") else
		if killnpcnum<killnpcsum then
			killnpcover="lzdjjf-jjfdy"
			if pfmkill() then alias.fjskillskill("GPS 校尉 xiao wei") else run("kill xiao wei") end
		else alias.trymove("s") end
	end
end
function alias.movegang()
	run("move gang")
	alias.movefinish()
end
function alias.nantianyuhuang()
	--run("ask jiang about 上山;nu")
	--alias.movefinish()
	openclass("gps")
	openclass("gps_dealwith")
	killnpcsum=1
	killnpcover="kill jiang baisheng"
	run("ask jiang about 上山")
	alias.trymove("nu")
end
function alias.nycjnynm()
	-- 南阳城郊到南阳南门，处理守城官兵
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_nanyang")
	openclass("gps_thrownpc")
	thrownpcfaint=false
	alias.trymove("enter")
end
function alias.opengatesouth()
	run("open gate;s")
	alias.movefinish()
end
function alias.qcsdw()
	-- 青城到梅超风石洞外
	run("n;e;s")
	alias.movefinish()
end
function alias.sdwqc()
	-- 梅超风石洞外到青城
	run("n;w;s")
	alias.movefinish()
end
function alias.qcqzsm()
	-- 青城到全真沙漠
	run("n")
	alias.movefinish()
end
function alias.qzsmqc()
	-- 全真沙漠到青城
	run("n;w;w;w;w;w;s")
	alias.movefinish()
end
function alias.qzsmxy()
	-- 全真沙漠到悬崖
	run("n;e;e;e;e;e")
	alias.movefinish()
end
function alias.xyqzsm()
	-- 悬崖到全真沙漠
	run("w;w;w;w;w")
	alias.movefinish()
end
function alias.qzxyclimbup()
	-- 全真悬崖到崖顶
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_climbxy")
	run("climb up")
end
function alias.qzxyclimbdown()
	-- 崖顶到全真悬崖
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_climbxy")
	run("climb down")
end
function alias.qlqtfsd()
	-- 祁连山齐天峰到日月神教山洞
	run("move stone;enter")
	alias.movefinish()
end
function alias.qldtht()
	-- 日月神教大堂到后厅，处理日月神教卫士
	killnpcsum=2
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="" then alias.trymove("n") else
		if killnpcnum<killnpcsum then
			killnpcover="qldt-ht"
			if pfmkill() then alias.fjskillskill("GPS 日月神教卫士 rysj weishi") else run("kill rysj weishi") end
		else alias.trymove("n") end
	end
end
function alias.qlxtdl()
	-- 日月神教大堂到大牢，处理日月神教卫士
	killnpcsum=2
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="" then
		run("open door")
		alias.trymove("d") else
		if killnpcnum<killnpcsum then
			killnpcover="qlxt-dl"
			if pfmkill() then alias.fjskillskill("GPS 日月神教卫士 rysj weishi") else run("kill rysj weishi") end
		else
			run("open door")
			alias.trymove("d")
		end
	end
end
function alias.qldlxt()
	-- 日月神教大牢到日月神教刑堂
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_waitrelease")
end
function alias.qztjqzyxd()
	-- 全真台阶到养心殿，处理张志光
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="qz" then alias.trymove("wu") else
		if killnpcnum<killnpcsum then
			killnpcover="qztj-qzyxd"
			if pfmkill() then alias.fjskillskill("GPS 张志光 zhang zhiguang") else run("kill zhang zhiguang") end
		else alias.trymove("wu") end
	end
end
function alias.qlycmgdcy()
	-- 永昌到蒙古大草原
	run("n;n;n;n;n;n;n;n;e;e;n;n;n;e;n;n;n")
	alias.yjl()
	alias.movefinish()
end
function alias.qlmgdcyyc()
	-- 蒙古大草原到永昌
	run("s;s;s;s;s;s;s;s;s;s;s;s;s;s;s")
	alias.yjl()
	alias.movefinish()
end
function alias.qzlcmcx()
	-- 泉州粮仓到米仓巷，处理官兵和武将
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_qzh_mcx")
	openclass("gps_thrownpc")
	thrownpcfaint=false
	alias.trymove("ne")
end
function alias.slgatesl()
	-- 泉州施琅将军府到将军府，处理官兵和武将
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_qzh_sl")
	openclass("gps_thrownpc")
	thrownpcfaint=false
	alias.trymove("n")
end
function alias.yzhyyzwf()
	-- 扬州后院到丫鬟卧房，处理凌退思
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_yz_lts")
	openclass("gps_thrownpc")
	thrownpcfaint=false
	alias.trymove("w")
end
function alias.gumuenter()
	run("wd")
	alias.movefinish()
end
function alias.turnleft()
	run("turn left")
	alias.movefinish()
end
function alias.enterguan()
	run("enter guan")
	alias.movefinish()
end
function alias.yzymymzt()
	-- 扬州衙门到衙门正厅，处理衙役
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_yz_ym")
	openclass("gps_thrownpc")
	thrownpcfaint=false
	alias.trymove("s")
end
function alias.ynfslynfxj()
	-- 华山玉女峰山路到华山玉女峰小径，处理高根明
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="hs" then alias.trymove("nu") else
		if killnpcnum<killnpcsum then
			killnpcover="ynfsl-ynfxj"
			if pfmkill() then alias.fjskillskill("GPS 高根明 gao genming") else run("kill gao genming") end
		else alias.trymove("nu") end
	end
end
function alias.slssj()
	-- 少林寺2虚到石阶，处理虚通虚明
	killnpcsum=2
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="sl" then alias.trymove("eu") else
		if killnpcnum<killnpcsum then
			killnpcover="sls-sj"
			run("kill xu")
		else alias.trymove("eu") end
	end
end
function alias.slqfdslzl()
	-- 少林千佛殿到竹林，处理清观比丘
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="sl" then
		run("open door")
		alias.trymove("n") else
		if killnpcnum<killnpcsum then
			killnpcover="slqfd-slzl"
			if pfmkill() then alias.fjskillskill("GPS 清观比丘 biqiu") else run("kill biqiu") end
		else
			run("open door")
			alias.trymove("n")
		end
	end
end
function alias.xssmxsdgc()
	-- 雪山山门到雪山大广场，处理葛伦布
	killnpcsum=2
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="xs" then alias.trymove("n") else
		if killnpcnum<killnpcsum then
			killnpcover="xssm-xsdgc"
			if pfmkill() then alias.fjskillskill("GPS 葛伦布 ge lunbu") else run("kill ge lunbu") end
		else alias.trymove("n") end
	end
end
function alias.xsjgyxshy()
	-- 雪山金刚院到雪山后院，处理萨木活佛
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="xs" then alias.trymove("n") else
		if killnpcnum<killnpcsum then
			killnpcover="xsjgy-xshy"
			if pfmkill() then alias.fjskillskill("GPS 萨木活佛 samu huofo") else run("kill samu huofo") end
		else alias.trymove("n") end
	end
end
function alias.xsclxsdd()
	-- 雪山长廊到雪山大殿，处理戒律僧
	killnpcsum=2
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="xs" then alias.trymove("n") else
		if killnpcnum<killnpcsum then
			killnpcover="xscl-xsdd"
			if pfmkill() then alias.fjskillskill("GPS 戒律僧 jielv seng") else run("kill jielv seng") end
		else alias.trymove("n") end
	end
end
function alias.xxysdxxh()
	-- 星宿银山道到星宿海，处理狮吼子
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="xx" then alias.trymove("nd") else
		if killnpcnum<killnpcsum then
			killnpcover="xxysd-xxh"
			if pfmkill() then alias.fjskillskill("GPS 狮吼子 shihou zi") else run("kill shihou zi") end
		else alias.trymove("nd") end
	end
end
function alias.xxysdxxxw()
	-- 星宿银山道到小木屋，处理狮吼子
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="xx" then alias.trymove("w") else
		if killnpcnum<killnpcsum then
			killnpcover="xxysd-xxxw"
			if pfmkill() then alias.fjskillskill("GPS 狮吼子 shihou zi") else run("kill shihou zi") end
		else alias.trymove("w") end
	end
end
function alias.xxsdxxxyd()
	-- 星宿石道到逍遥洞，处理采花子
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="xx" then alias.trymove("enter") else
		if killnpcnum<killnpcsum then
			killnpcover="xxsd-xxxyd"
			if pfmkill() then alias.fjskillskill("GPS 采花子 caihua zi") else run("kill caihua zi") end
		else alias.trymove("enter") end
	end
end
function alias.xxyptdmyptdy()
	-- 西夏一品堂大门到一品堂大院，处理一品堂武士
	killnpcsum=4
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="" then alias.trymove("n") else
		if killnpcnum<killnpcsum then
			killnpcover="xxyptdm-yptdy"
			if pfmkill() then alias.fjskillskill("GPS 一品堂武士 wu shi") else run("kill wu shi") end
		else alias.trymove("n") end
	end
end
function alias.yzxlyzxsq()
	-- 扬州小路到欧阳克的小山丘，处理婢女
	killnpcsum=2
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="bt" then alias.trymove("wu") else
		if killnpcnum<killnpcsum then
			killnpcover="yzxl-yzxsq"
			if pfmkill() then alias.fjskillskill("GPS 婢女 binu") else run("kill binu") end
		else alias.trymove("wu") end
	end
end
function alias.gyzdmqy2()
	-- 归云庄大门到归云庄前院，处理家丁
	killnpcsum=2
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="th" then alias.trymove("enter") else
		if killnpcnum<killnpcsum then
			killnpcover="gyzdm-qy2"
			if pfmkill() then alias.fjskillskill("GPS 家丁 jia ding") else run("kill jia ding") end
		else alias.trymove("enter") end
	end
end
function alias.yzsclknshp()
	-- 扬州郊外三岔路口到女山湖畔，处理蒙古军官
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="" then alias.trymove("se") else
		if killnpcnum<killnpcsum then
			killnpcover="yzsclk-nshp"
			if pfmkill() then alias.fjskillskill("GPS 蒙古军官 menggu junguan") else run("kill menggu junguan") end
		else alias.trymove("se") end
	end
end
function alias.qzcjgcjg3l()
	-- 全真藏经阁二楼到三楼，处理谭处端
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="qz" then
		run("ask tan about 进修")
		alias.trymove("u")
	else
		if killnpcnum<killnpcsum then
			killnpcover="qzcjg-cjg3l"
			if pfmkill() then alias.fjskillskill("GPS 谭处端 tan chuduan") else run("kill tan chuduan") end
		else
			run("ask tan about 进修")
			alias.trymove("u")
		end
	end
end
function alias.slcsfzl()
	-- 少林茶室到方丈楼，处理清乐比丘
	killnpcsum=1
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="sl" then alias.trymove("n") else
		if killnpcnum<killnpcsum then
			killnpcover="slcs-fzl"
			if pfmkill() then alias.fjskillskill("GPS 清乐比丘 qingle biqiu") else run("kill qingle biqiu") end
		else alias.trymove("n") end
	end
end
function alias.xxyptdtyptms()
	-- 西夏一品堂大厅到一品堂密室，处理一品堂武士
	killnpcsum=2
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="" then
		run("open door")
		alias.trymove("w")
	else
		if killnpcnum<killnpcsum then
			killnpcover="xxyptdt-yptms"
			if pfmkill() then alias.fjskillskill("GPS 一品堂武士 wu shi") else run("kill wu shi") end
		else
			run("open door")
			alias.trymove("w")
		end
	end
end
function alias.xydcy1xydcy2()
	-- 西域大草原
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_xydcy")
	gps_xydcy_reachdest=0
	run("east;set checkxydcy=yes")
end
function alias.sgyydsgymd()
	run("use fire;left")
	alias.movefinish()
end
function alias.sgyydsgysd()
	alias.wi("jian")
	run("strike wall;out")
	alias.uw()
	alias.movefinish()
end
function alias.sgysdsgyyd()
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_sgy_sd")
	gps_checkmianbi=false
	for i=1,10,1 do run("mianbi") end
	run("set checkmianbi=yes")
end
function alias.qzxmlsg()
	openclass("gps_dealwith")
	openclass("gps_qzh_xmdq")
	run("look;set checklook=yes")
end
function alias.qzlsgxm()
	openclass("gps_dealwith")
	openclass("gps_qzh_xmdq")
	run("look;set checklook=yes")
end
function alias.slgcslsmd()
	-- 少林广场到山门殿，处理敲门
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_sl_gate")
	run("knock gate")
end
function alias.slzlsldmd()
	-- 少林竹林到达摩洞
	run("sw;se;n;s;w;e;w;e;e;s;w;n;nw;n")
	alias.movefinish()
end
function alias.slslslsl()
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_sl_sl")
	run("look")
end
function alias.slqypslsj()
	-- 少林青云坪到少林石阶
	run("sd;w;e;n;e;s;n;e;w;s")
	alias.movefinish()
end
function alias.slsslslqyp()
	-- 少林松树林到少林青云坪
	run("w;e;s;e;n;n;e;w;s")
	alias.movefinish()
end
function alias.slhdaslhxa()
	-- 疏勒河东岸到西岸
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_slh")
	alias.wi("jian")
	run("chop shuzhi")
end
function alias.xydcysl()
	-- 西域大草原到疏勒
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_xydcy_sl")
	gps_xydcy_reachdest=0
	run("north;set checkxydcy=yes")
end
function alias.kldsmhks()
	-- 昆仑大沙漠到汉哭山
	run("se;s")
	alias.movefinish()
end
function alias.yzjwslyzjwxf()
	-- 扬州郊外树林到萧府大门
	run("pa shang;pa zuo;pa shang;pa zuo;pa shang;pa zuo;pa shang;pa zuo;pa xia;pa xia;pa xia;pa xia;w")
	wait.make(function()
		local _f=function() alias.movefinish() end
		wait.time(2)
		_f()
	end)
end
function alias.yzjwxfyzjwsl()
	-- 扬州郊外萧府大门到树林
	run("halt;e;pa shang;pa shang;pa shang;pa shang;pa you;pa xia;pa you;pa xia;pa you;pa xia;pa you;pa xia")
	wait.make(function()
		local _f=function() alias.movefinish() end
		wait.time(2)
		_f()
	end)
end
function alias.yztd1yztd2()
	-- 扬州田地处理
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_yztd_1_2")
	run("look")
end
function alias.yztd2yztd1()
	-- 扬州田地处理
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_yztd_2_1")
	run("look")
end
function alias.yztd2yztd3()
	-- 扬州田地处理
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_yztd_2_3")
	run("look")
end
function alias.yztd3yztd2()
	-- 扬州田地处理
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_yztd_3_2")
	run("look")
end
function alias.zsthdht()
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_thd_go")
	run("yell chuan")
end
function alias.thdthlxj()
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_thd_thl")
	trymovesuccess=false
	run("time")
end
function alias.thjsslx()
	openclass("gps")
	openclass("gps_dealwith")
	if me.menpai=="th" and (me.master=="程英" or me.master=="黄药师") then
		alias.trymove("enter")
	else
		run("ask gu about 玩;agree")
		wait.make(function()
			local _f=function() alias.trymove("enter") end
			wait.time(2)
			_f()
		end)
	end
end
function alias.thxzdd()
	run("push left;push left;push left;push right;push right;push right;push front")
	wait.make(function()
		local _f=function()
			run("enter")
			alias.movefinish()
		end
		wait.time(1)
		_f()
	end)
end
function alias.thddms()
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_thd_ms")
	run("press 谦")
end
function alias.thdhtzs()
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_thd_back")
	run("yell chuan")
end
function alias.emkilljumang()
	openclass("gps")
	openclass("gps_dealwith")
	openclass("gps_99guai")
	mangsheexist=1
	alias.checkbusy("jm")
end
function alias.findway()
	run("find way")
	alias.movefinish()
end
function alias.qzsmqzqc()
	-- 全真沙漠到青城
	run("s")
	alias.movefinish()
end
function alias.hsxypt()
	-- 华山悬崖到领悟的平台
	if have.shengzi then
		run("zha stone;climb down;guanmo jianhen")
		alias.movefinish()
	else alias.checkitems() end
end
function alias.hsptxy()
	-- 华山领悟的平台到悬崖
	run("climb up")
	alias.movefinish()
end
function alias.pressstone()
	run("press stone;down")
	alias.movefinish()
end
function alias.tangcoffin()
	run("tang coffin")
	alias.movefinish()
end
function alias.fengqy()
	run("feng")
	alias.movefinish()
end
function alias.opendoordown()
	run("open door;d")
	alias.movefinish()
end
function alias.opendoorup()
	run("open door")
	if roomno_now==2026 then run("release yuanshi") end
	run("u")
	alias.movefinish()
end
function alias.knockqz()
	run("knock door;n")
	alias.movefinish()
end
function alias.askwangsd()
	run("ask wang about miji;sd")
	alias.movefinish()
end
function alias.askwangn()
	run("ask wang about miji;n")
	alias.movefinish()
end
function alias.gbmdcenter()
	run("say 天堂有路你不走呀;down")
	alias.movefinish()
	run("set checkGbSecretWay=err")
end
function alias.gbmddgc()
	-- 打谷场到丐帮秘道
	run("enter gudui")
	alias.movefinish()
end
function alias.gbmdtdm()
	-- 土地庙到秘道
	run("enter dong")
	alias.movefinish()
end
function alias.gbmdslcf()
	-- 少林山脚厨房到秘道
	run("enter dong")
	alias.movefinish()
end
function alias.gbmdsc()
	-- 丝绸之路到秘道
	run("push shibei")
	alias.movefinish()
end
function alias.gbmdtfw()
	-- 武当土匪窝到秘道
	run("halt;enter dong")
	alias.movefinish()
end
function alias.gbmdqzhtdm()
	-- 泉州土地庙
	run("enter dong")
	alias.movefinish()
end
function alias.gbmdemcp()
	-- 峨嵋草棚到秘道
	run("move lid")
	alias.movefinish()
end
function alias.gbmdxssl()
	-- 雪山山路到秘道
	run("jump 雪坑")
	alias.movefinish()
end
function alias.nxsjump()
	-- 清音阁到牛心石
	run("jump 牛心石")
	alias.movefinish()
end
function alias.nxsback()
	-- 牛心石到清音阁
	run("jump back")
	alias.movefinish()
end
function alias.leave9ld()
	-- 离开峨嵋九老洞
	run("leave")
	alias.movefinish()
end
function alias.yellzhou()
	-- 九老洞口到周芷若
	openclass("gps_dealwith")
	openclass("gps_zhou")
	run("yell 有侣乎？")
end
function alias.qzhntms()
	-- 泉州药铺内堂到密室
	run("turn ball;down")
	alias.movefinish()
end
function alias.qzhmsnt()
	-- 泉州药铺密室到内堂
	run("turn ball;up")
	alias.movefinish()
end
function alias.tsthsup()
	-- 泰山探海石上去
	run("jump up")
	alias.movefinish()
end
function alias.tsthsdown()
	-- 泰山探海石下来
	run("jump down")
	alias.movefinish()
end
------------------------------------------------------------------------------------
-- startworkflow 工作流程
------------------------------------------------------------------------------------
function alias.startay()
	-- 开始熬药
	openclass("common")
	openclass("aoyao")
	alias.flytonpc("王通治")
end
function alias.startxue()
	if havefj>0 then alias.startfj()
	else
		-- 开始xue
		alias.close_fj()
		alias.close_xinfa()
		alias.close_ftb()
		alias.close_xue()
		alias.close_mp()
		workflow.nowjob="xue"
		nextJobGodazuobase=1
		wx.taiji=0
		wx.zhixin=0
		skillsfull=0
		if hp.pot<50 or (me.menpai=="th" and hp.thpot<50) then
			-- 没有潜能，继续选择流程
			alias.startworkflow()
		else
			if xuelit>0 and daytime then
				-- 优先学习且天亮着，去学读书写字
				openclass("skills_xue")
				alias.checklitmaster()
				alias.flytonpc(me.litmaster)
			else
				-- 不学习或天黑着，去学师傅或者领悟
				if usepot=="xue" then
					openclass("skills_xue")
					if dummy.laopo~=nil and dummy.laopo~="" then run("tell "..dummy.laopo.." go");alias.flyto("武馆休息室")
					elseif me.masterroom~=nil and me.masterroom~="" then alias.flytoid(me.masterroom)
					elseif me.menpai=="mj" then me.master=mj.master;alias.flytonpc(mj.master)
					else alias.flytonpc(me.master) end
				else
					if do_gm_job3==nil then do_gm_job3=0 end
					if usepot=="lingwu" then
						-- 去领悟
						if lingwuat=="shaolin" then alias.flyto("达摩院二楼") else alias.flyto(me.menpailingwuid) end
						openclass("skills_lingwu")
					else
						if usepot=="jingyao" then
							if have.jingyao>0 then
								-- 读精要
								openclass("skills_jingyao")
								alias.dujingyao()
							else
								-- 没有精要
								alias.close_xue()
								--usepot="lingwu"
								usepot="xue"
								alias.startworkflow()
							end
						else
							-- 不学习不领悟，练习技能等任务
							alias.close_xue()
							alias.startworkflow()
						end
					end
				end
			end
		end
	end
end
function alias.startxinfa()
	alias.close_fj()
	alias.close_xinfa()
	alias.close_ftb()
	alias.close_xue()
	alias.close_mp()
	workflow.nowjob="xinfa"
	nextJobGodazuobase=0
	if workflow.xf>0 then
		if me.menpai=="sl" and skillslist["buddhism"]~=nil and skillslist["buddhism"]["lvl"]>=400 then
			if zuochan>0 then
				print("阿弥陀佛，尼姑豆腐")
				openclass("xinfa")
				openclass("xf_sl")
				openclass("sl_zc")
				zuochan_checkchui=1
				alias.flytoid(1703)
			elseif songjingtime~=nil and songjingtime>0 then
				print("阿弥陀佛，尼姑豆腐")
				openclass("xinfa")
				openclass("xf_sl")
				openclass("sl_sj")
				alias.flytoid(1131)
			else
				print("不满足开始条件")
				alias.close_xinfa()
				alias.startworkflow()
			end
		elseif me.menpai=="wd" and have.zhongjian>0 and skillslist["xuantie-jianfa"]~=nil and skillslist["xuantie-jianfa"]["lvl"]>=0 then
			openclass("xf_wd")
			openclass("wd_xtjf")
			alias.flytonpc("铜人")
		elseif me.menpai=="em" then
			openclass("xf_em")
			alias.flyto(370)
		elseif me.menpai=="hs" then
			openclass("xf_hs")
			alias.flyto("紫气台")
		elseif me.menpai=="mj" then
			openclass("xf_mj")
			alias.flytoid(56)
		else
			print("不满足开始条件")
			alias.close_xinfa()
			alias.startworkflow()
		end
	else
		alias.close_xinfa()
		alias.startworkflow()
	end
end
function alias.startcm()
	-- 开始cm
	alias.close_fj()
	alias.close_xinfa()
	alias.close_ftb()
	alias.close_xue()
	alias.close_mp()
	workflow.nowjob="cm"
	nextJobGodazuobase=0
	openclass("chongmai")
	openclass("chongmai_pre")
	openclass("chongmai_watch")
	closeclass("chongmai_start")
	alias.checkitems()
end
function alias.startfjclose()
	alias.close_fj()
	alias.close_xinfa()
	alias.close_ftb()
	alias.close_xue()
	alias.close_mp()
	openclass("fj")
	openclass("fj_close")
	alias.flytoid(me.fjbaseid)
end
function alias.startgbresume()
	-- 开始mp
	alias.close_fj()
	alias.close_xinfa()
	alias.close_ftb()
	alias.close_xue()
	alias.close_mp()
	alias.close_cm()
	workflow.nowjob="mp"
	nextJobGodazuobase=0
	openclass("menpai")
	-- 还有未做完的gold任务
	openclass("mp_gb")
	openclass("mp_gb_gold")
	closeclass("mp_gb_pre")
	closeclass("mp_gb_sx")
	openclass("mp_gb_watch")
	alias.flytoid(gold.roomNo)
end
function alias.startftb()
	--#if @debug {#say 开始ftb}
	alias.close_fj()
	alias.close_xinfa()
	alias.close_ftb()
	alias.close_xue()
	alias.close_mp()
	alias.close_cm()
	openclass("ftb")
	openclass("ftb_pre")
	closeclass("ftb_ask")
	closeclass("ftb_start")
	flytoareastartid=0
	workflow.nowjob="ftb"
	nextJobGodazuobase=1
	if tonumber(roomno_now)==1705 then alias.checkitems() else alias.flyto("大堂","扬州") end
end
function alias.startqzwd()
	qzwdnow=os.time()
	--#say qzwd已经修炼了%eval( @stime(@qzwdnow)-@stime(@qzwdstarttime))
	--#say fj间隔为@fjwaittime
	--#say 还有(@fjwaittime -%eval( @stime(@qzwdnow)-@stime(@qzwdstarttime)))的休闲时间
	if (qzwdnow-qzwdstarttime+qzwdxiuliantime)<fjwaittime then
		if not isopen("boat") then
			alias.close_fj()
			alias.close_ftb()
			alias.close_mp()
			workflow.nowjob="qzwd"
			nextJobGodazuobase=0
			openclass("qzwd")
			openclass("qzwd_pre")
			openclass("qzwd_watch")
			openclass("qzwd_start")
			alias.checkitems()
		else
			print("过河不骚情")
		end
	else alias.startxue() end
end
function alias.startmp()
	-- print("开始MP")
	alias.close_fj()
	alias.close_xinfa()
	alias.close_ftb()
	alias.close_xue()
	alias.close_mp()
	alias.close_cm()
	workflow.nowjob="mp"
	nextJobGodazuobase=0
	openclass("menpai")
	if do_dl_job==1 then
		openclass("mp_dl")
		openclass("mp_dl_pre")
		openclass("mp_dl_watch")
	else
		openclass("mp_"..me.menpai)
		openclass("mp_"..me.menpai.."_pre")
		openclass("mp_"..me.menpai.."_watch")
	end
	alias.checkitems()
end
function alias.startfj()
	-- print("开始fj")
	alias.close_xinfa()
	alias.close_ftb()
	alias.close_xue()
	alias.close_mp()
	alias.close_cm()
	openclass("fj")
	openclass("fj_pre")
	openclass("fj_watch")
	closeclass("fj_start")
	workflow.nowjob="fj"
	nextJobGodazuobase=1
	if me.menpai=="mj" and fjjf~=nil and fjjf~="" then alias.jf(fjjf) end
	if hp.neili<(hp.maxneili*set_neili_job/100) then alias.dz(set_neili_job) else alias.checkitems() end
end
function alias.starttongmai()
	alias.initialize_trigger()
	openclass("common")
	openclass("tongmai")
	alias.flytoid(950)
end
function alias.startliaoshang()
	alias.initialize_trigger()
	openclass("common")
	nextJobGodazuobase=1
	run("stand")
	if jifa.forcename=="taijishengong" then
		openclass("yinyun")
		alias.checkbusy("yinyun")
	elseif jifa.forcename=="xiantiangong" then
		openclass("bidu")
		alias.checkbusy("bidu")
	elseif jifa.forcename=="hamagong" then
		openclass("qudu")
		alias.checkbusy("qudu")
	elseif jifa.forcename=="kurongchangong" then
		openclass("cure")
		alias.checkbusy("cure")
	elseif jifa.forcename=="huagongdafa" then
		alias.startmp()
	else
		openclass("liaoshang")
		alias.flyto("武馆休息室")
		--alias.flyto("武庙")
	end
	--if me.menpai=="sl" or me.menpai=="hs" or me.menpai=="em" or me.menpai=="gb" or me.menpai=="gm" or me.menpai=="th" or me.menpai=="xs" then
	--	openclass("liaoshang")
	--	run("stand")
	--	alias.flyto("武庙")
	--end
	--if me.menpai=="wd" then
	--	openclass("yinyun")
	--	alias.checkbusy("yinyun")
	--end
	--if me.menpai=="qz" then
	--	openclass("bidu")
	--	alias.checkbusy("bidu")
	--end
	--if me.menpai=="bt" then
	--	openclass("qudu")
	--	alias.checkbusy("qudu")
	--end
	--if me.menpai=="dl" then
	--if me.menpai=="dl" or jifa.forcename=="kurongchangong" then
	--	openclass("cure")
	--	alias.checkbusy("cure")
	--end
	--if me.menpai=="xx" then
	--	alias.startmp()
	--end
end
------------------------------------------------------------------------------------
-- setmpLimitedMark
------------------------------------------------------------------------------------
function alias.setmpLimitedMark()
	if mpJobLimited>0 then
		mpJobLimited=mpLimited.stat()
		if mpJobLimited==0 then mpLimited.mpexp=0 end
		if me.menpai=="bt" and mpJobLimited==0 then
			xy.xyLimited=0
			xy.limitedResume=0
			xy.biteLimited=0
			xy.checkfirstbite=1
		end
	end
end
------------------------------------------------------------------------------------
-- setaoyao
------------------------------------------------------------------------------------
function alias.setaoyao_badan()
	-- 设置熬续命八丹
	aoyao.yaoName="续命八丹"
	aoyao.yaoid="badan"
	aoyao.buyNameList="茯苓|菊梗|雄黄|田七|何首乌"
	aoyao.buyidList="fuling|jugeng|xionghuang|tianqi|heshouwu"
	aoyao.buyno=1
	aoyao.needgold=3
end
function alias.setaoyao_tongmaidan()
	-- 设置熬紫金通脉丹
	aoyao.yaoName="紫金通脉丹"
	aoyao.yaoid="dan"
	aoyao.buyNameList="老山参|鹿茸|麝香|雪莲|茯苓"
	aoyao.buyidList="lao shanshen|lurong|shexiang|xuelian|fuling"
	aoyao.buyno=1
	aoyao.needgold=401
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function alias.tdz()
	closeclass("dazuo_resetidle")
	closeclass("dazuo")
	run("halt;set dazuo=over")
end
function alias.tlw()
	closeclass("skills_lian")
	run("halt;set lian=over")
	alias.uw()
end
function alias.lianwu()
	openclass("skills")
	openclass("skills_lian")
	run("hp;set lian")
end
function alias.dz(a)
	openclass("dazuo")
	resumejob=""
	if roomno_now~=me.dazuobaseid and me.dazuobaseid~=0 and not isopen("fj_start") and not isopen("boat") and not isopen("skills_lingwu") and not isopen("skills_xue") and not isopen("mp_qz_start") and nextJobGodazuobase>0 then
		if tonumber(a)~=nil then type_dz=tonumber(set_neili) else type_dz=a end
		if a==nil or tonumber(a)==nil then alias.flytoid(me.dazuobaseid)
		else
			if hp.neili>(hp.maxneili*type_dz/100) then alias.tdz()
			else
				if hp.neili>(hp.maxneili*(type_dz-15)/100) then
					run("hp;set checkhp="..a)
				else alias.flytoid(me.dazuobaseid) end
			end
		end
	else
		if a==nil or tonumber(a)==nil then run("set checkhp=addneili") else run("hp;set checkhp="..a) end
	end
	nextJobGodazuobase=0
end
function alias.et()
	run("get ji from he;drink ji;put ji in he")
end
function alias.xuemaster()
	local _tb
	alias.resetidle()
	alias.setmpLimitedMark()
	if stat.havedu>0 then alias.startliaoshang()
	else
		if hp.neili<(hp.maxneili*set_neili_job/100) then alias.dz(set_neili)
		else
			if havefj>0 then run("set startworkflow=yes")
			else
				if (((mpJobLimited==0 and me.menpai~="wd" and me.menpai~="gb" and workflow.mp>0) or (me.menpai=="gb" and ((mpJobLimited>0 and 3600-(os.time()-mpLimited.MarkTime)<=30) or (mpJobLimited==0 and gold.num<gold.setnum)))) and xuefirst==0) then
					run("set startworkflow=yes")
				else
					if me.menpai=="wd" and wx.taiji==0 and jifa.forcename~="xuanyinzhenqi" then
						if fjweapon=="sword" or fjweapon=="jian" then
							run("jifa parry taiji-jian")
							alias.wi("jian")
						else
							run("jifa parry taiji-quan")
							alias.uw()
						end
						run("yun taiji")
						alias.checkbusy("taijistart")
					else
						if me.menpai=="em" and stat.zhixin==0 and jifa.forcename~="xuanyinzhenqi" then run("yun zhixin") end
						_tb=utils.split(skills_xue,"|")
						if skills_num==nil then skills_num=1 end
						if dummy.laopo~=nil and dummy.laopo~="" and roomname=="武馆休息室" then
							run("xue "..dummy.laopo.." ".._tb[skills_num].." 30")
						elseif xuelit>0 and daytime then
							run("xue "..me.litmasterid.." literate 20")
						else
							if me.menpai=="mj" then
								if mj.ask>0 then openclass("skills_ask")
								else run("qingjiao "..me.masterid.." ".._tb[skills_num].." 10") end
							else
								run("xue "..me.masterid.." ".._tb[skills_num].." 30")
							end
						end
						--if xuelit==0 then
						--	run("xue "..me.masterid.." ".._tb[skills_num].." 30")
						--else
						--	if daytime then
						--		run("xue "..me.litmasterid.." literate 20")
						--	else
						--		run("xue "..me.masterid.." ".._tb[skills_num].." 30")
						--	end
						--end
					end
				end
			end
		end
	end
end
--function alias.gblianwu(a)
--	alias.uw()
--	run("enter dong")
--	roomno_now=2033
--	lianwunum=1
--	if tonumber(a)~=nil then lianwunum_set=tonumber(a) else lianwunum_set=2 end
--	alias.lianwu()
--end
function alias.dealwithName()
	sx.name=string.gsub(sx.name,"【大理段家】","")
	sx.name=string.gsub(sx.name,"【全真教】","")
	sx.name=string.gsub(sx.name,"【武当派】","")
	sx.name=string.gsub(sx.name,"【少林派】","")
	sx.name=string.gsub(sx.name,"【桃花岛】","")
	sx.name=string.gsub(sx.name,"【峨嵋派】","")
	sx.name=string.gsub(sx.name,"【华山派】","")
	sx.name=string.gsub(sx.name,"【星宿派】","")
	sx.name=string.gsub(sx.name,"【白驼山】","")
	sx.name=string.gsub(sx.name,"【雪山派】","")
	sx.name=string.gsub(sx.name,"【密宗】","")
	sx.name=string.gsub(sx.name,"【丐帮】","")
	sx.name=string.gsub(sx.name,"【明教】","")
	sx.name=string.gsub(sx.name,"【青城派】","")
end
function alias.searchNextGoldRoom()
	if flytoidx<flytosum then
		-- 搜索下一个地点
		alias.fn()
	else
		if findstring(flytoname,"山路") then
			if findstring(flytozone,"泉州") then alias.flyto("山路","杭州") end
			if findstring(flytozone,"泉州") then alias.flyto("山路","大理") end
			if findstring(flytozone,"大理") then
				if havefj>0 then alias.startworkflow() else alias.dz(set_neili) end
			end
		else
			if havefj>0 then alias.startworkflow() else alias.dz(set_neili) end
		end
	end
end
function alias.goldid(a)
	local _tb,_tb2
	_tb=utils.split(goldidList,"|")
	_tb2=utils.split(goldNameList,"|")
	for i=0,table.getn(_tb2),1 do
		if a==_tb2[i] then
			return _tb[i]
		end
	end
	return ""
end
function alias.fujiaid(a)
	local _tb,_tb2
	_tb=utils.split(fujiaidList,"|")
	_tb2=utils.split(fujiaNameList,"|")
	for i=0,table.getn(_tb2),1 do
		if a==_tb2[i] then
			return _tb[i]
		end
	end
	return ""
end
function alias.setmpReCountTime()
	if add.exp>10 and mpJobLimited==0 and (os.time()-mpLimited.MarkTime)>=3600 then
		mpLimited.mpexp=0
		mpLimited.MarkTime=os.time()
	end
end
function alias.lianskills()
	local _tb
	alias.setmpLimitedMark()
	if stat.havedu>0 and not isopen("mp_xs_npc1") then alias.startliaoshang()
	else
		_tb=utils.split(skills_lingwu,"|")
		if skills_num==nil then skills_num=1 end
		if skills_num>table.getn(_tb) then
			if isopen("mp_gb_pre") then
				closeclass("skills_lian")
				alias.uw()
				run("u")
				--lianwunum=0
				roomno_now=1116
				run("set lian=full")
			else run("set lian=over") end
		else
			run("lian ".._tb[skills_num].." 30")
		end
	end
end
function alias.lingwuskills()
	local _tb
	if roomno_now==1653 or roomno_now==213 or roomno_now==192 or tonumber(roomno_now)==tonumber(me.menpailingwuid) then
		alias.resetidle()
		alias.setmpLimitedMark()
		if stat.havedu>0 then alias.startliaoshang()
		else
			if hp.neili<(hp.maxneili*set_neili_job/100) then alias.dz(set_neili)
			else
				if havefj>0 then
					alias.uw()
					if me.menpai=="bt" then run("release yuanshi") end
					if me.menpai=="qz" then run("return book") end
					if me.menpai=="em" or me.menpai=="xx" or me.menpai=="xs" then run("stand") end
					if me.menpai=="dl" then run("dismiss") end
					run("set startworkflow=yes")
				else
					if (((mpJobLimited==0 and me.menpai~="wd" and me.menpai~="gb" and me.menpai~="xs" and me.menpai~="dl" and workflow.mp>0) or (me.menpai=="gb" and ((mpJobLimited>0 and 3600-(os.time()-mpLimited.MarkTime)<=30) or (mpJobLimited==0 and gold.num<gold.setnum)))) and xuefirst==0) then
						alias.uw()
						if me.menpai=="bt" then run("release yuanshi") end
						if me.menpai=="qz" then run("return book") end
						if me.menpai=="em" or me.menpai=="xx" or me.menpai=="xs" then run("stand") end
						if me.menpai=="dl" then run("dismiss") end
						run("set startworkflow=yes")
					else
						if me.menpai=="em" and stat.zhixin==0 then run("yun zhixin") end
						if me.menpai=="dl" then run("gather") end
						_tb=utils.split(skills_lingwu,"|")
						if skills_num>table.getn(_tb) then
							skills_num=1
							run("set lingwu=over")
						else
							run("lingwu ".._tb[skills_num].." 20")
						end
					end
				end
			end
		end
	end
end
function alias.fjarea(a)
	fjzone=""
	fjroom=""
	if string.find(a,"藏边大雪山") then
		fjzone="藏边大雪山"
		fjroom=string.gsub(a,"藏边大雪山","",1)
	end
	if string.find(a,"云南大理") then
		fjzone="云南大理城"
		fjroom=string.gsub(a,"云南大理","",1)
	end
	if string.find(a,"广东佛山") then
		fjzone="广东佛山"
		fjroom=string.gsub(a,"广东佛山","",1)
	end
	if string.find(a,"关外长白山") then
		fjzone="关外长白山"
		fjroom=string.gsub(a,"关外长白山","",1)
	end
	if string.find(a,"杭州") then
		fjzone="杭州"
		fjroom=string.gsub(a,"杭州","",1)
	end
	if string.find(a,"黄河边") then
		fjzone="黄河边"
		fjroom=string.gsub(a,"黄河边","",1)
	end
	if string.find(a,"昆仑山") then
		fjzone="昆仑山"
		fjroom=string.gsub(a,"昆仑山","",1)
	end
	if string.find(a,"祈连山") then
		fjzone="祈连山"
		fjroom=string.gsub(a,"祈连山","",1)
	end
	if string.find(a,"福建泉州") then
		fjzone="福建泉州"
		fjroom=string.gsub(a,"福建泉州","",1)
	end
	if string.find(a,"嵩山少林") then
		fjzone="嵩山少林"
		fjroom=string.gsub(a,"嵩山少林","",1)
	end
	if string.find(a,"山东泰山") then
		fjzone="山东泰山"
		fjroom=string.gsub(a,"山东泰山","",1)
	end
	if string.find(a,"太湖边") then
		fjzone="太湖边"
		fjroom=string.gsub(a,"太湖边","",1)
	end
	if string.find(a,"湖北武当山") then
		fjzone="湖北武当山"
		fjroom=string.gsub(a,"湖北武当山","",1)
	end
	if string.find(a,"西夏") then
		fjzone="西夏灵州"
		fjroom=string.gsub(a,"西夏","",1)
	end
	if string.find(a,"扬州") then
		fjzone="扬州"
		fjroom=string.gsub(a,"扬州","",1)
	end
	if string.find(a,"扬州郊外") then
		fjzone="扬州郊外"
		fjroom=string.gsub(a,"扬州郊外","",1)
	end
	if string.find(a,"终南山") then
		fjzone="终南山"
		fjroom=string.gsub(a,"终南山","",1)
	end
	if string.find(a,"西域") then
		fjzone="西域"
		fjroom=string.gsub(a,"西域","",1)
	end
	if string.find(a,"嘉兴") then
		fjzone="嘉兴"
		fjroom=string.gsub(a,"嘉兴","",1)
	end
	if string.find(a,"华山") then
		fjzone="华山"
		fjroom=string.gsub(a,"华山","",1)
	end
	if string.find(a,"华山村") then
		fjzone="华山村"
		fjroom=string.gsub(a,"华山村","",1)
	end
	if string.find(a,"华山村外土路") or string.find(a,"华山村村外土路") then
		fjzone="华山"
		fjroom="村外土路"
	end
	if string.find(a,"四川峨嵋") then
		fjzone="四川峨嵋"
		fjroom=string.gsub(a,"四川峨嵋","",1)
	end
	fj.room=fjroom
	fj.zone=fjzone
end
region_names={
	["藏边大雪山"]="藏边大雪山",
	["关外长白山"]="关外长白山",
	["湖北武当山"]="湖北武当山",
	["云南大理"]="云南大理城",
	["广东佛山"]="广东佛山",
	["福建泉州"]="福建泉州",
	["嵩山少林"]="嵩山少林",
	["山东泰山"]="山东泰山",
	["扬州郊外"]="扬州郊外",
	["四川峨嵋"]="四川峨嵋",
	["黄河流域"]="黄河边",
	["大理城"]="云南大理城",
	["少林寺"]="嵩山少林",
	["华山村"]="华山村",
	["终南山"]="终南山",
	["黄河边"]="黄河边",
	["昆仑山"]="昆仑山",
	["祈连山"]="祈连山",
	["太湖边"]="太湖边",
	["武当山"]="湖北武当山",
	["祁连山"]="祈连山",
	["祈连山"]="祈连山",
	["扬州"]="扬州",
	["西域"]="西域",
	["嘉兴"]="嘉兴",
	["西夏"]="西夏灵州",
	["杭州"]="杭州",
	["华山"]="华山",
	["佛山"]="广东佛山",
	["泉州"]="福建泉州",
	["泰山"]="山东泰山",
	["太湖"]="太湖边",
	["嘉兴"]="嘉兴",
}

function alias.ftbarea(a)
	ftbzone=""
	ftbroom=""
	if a=="华山村村外土路" or a=="华山村外土路" then
		ftbzone="华山"
		ftbroom="村外土路"
		return
	end
	for k,v in pairs(region_names) do
		local t=string.sub(a, 1, string.len(k))
		if t==k then
			ftbzone=v
			ftbroom=string.sub(a,string.len(k)+1)
			return
		end
	end
end
function alias.lzarea(a)
	ftbzone=""
	ftbroom=""
	for k,v in pairs(regions_d) do
		if string.sub(a,1,string.len(v.old))==v.old then
			ftbzone=v.new
			ftbroom=string.gsub(a,v.old,"",1)
			return
		end
	end
end
regions_d={
	{old="西域白驼山",new="西域",},
	{old="关外长白山",new="关外长白山",},
	{old="湖北武当山",new="湖北武当山",},
	{old="藏边大雪山",new="藏边大雪山不做",},
	{old="丐帮所在地",new="扬州",},
	{old="东海灵蛇岛",new="灵蛇岛",},
	{old="辽东神龙岛",new="none",},
	{old="东海桃花岛",new="none",},
	{old="云南大理",new="云南大理城",},
	{old="扬州郊外",new="扬州",},
	{old="四川峨嵋",new="四川峨嵋",},
	{old="广东佛山",new="广东佛山",},
	{old="福建泉州",new="福建泉州",},
	{old="嵩山少林",new="嵩山少林",},
	{old="山东泰山",new="山东泰山",},
	{old="云南苗疆",new="none",},
	{old="安徽黄山",new="none",},
	{old="黄河边",new="黄河边",},
	{old="昆仑山",new="昆仑山",},
	--{old="祈连山",new="祁连山",},
	{old="祁连山",new="祈连山",},
	{old="祈连山",new="祈连山",},
	{old="太湖边",new="太湖边",},
	{old="华山村",new="华山村",},
	{old="终南山",new="终南山",},
	{old="昆仑山",new="昆仑山",},
	{old="扬州",new="扬州",},
	{old="西域",new="西域",},
	{old="西夏",new="西夏灵州",},
	{old="杭州",new="杭州",},
	{old="华山",new="华山",},
	{old="嘉兴",new="嘉兴",},
	{old="南阳",new="南阳",},
	{old="仙界",new="none",},
	{old="侠客岛",new="none",},
	{old="海外",new="none",},
	{old="北京",new="none",},
	{old="地狱",new="none",},
}

function alias.setTargetNum()
	if mpLimited.mpexp<=4750 then
		mmr.targetNum=math.floor((4750-mpLimited.mpexp)/200)
		if mmr.targetNum==0 then mmr.targetNum=1 end
	end
	if mpLimited.mpexp>4750 and mpLimited.mpexp<=5000 then
		if (4750/mmr.oneexp)>27 then mmr.targetNum=math.floor(4750/mmr.oneexp-1) else mmr.targetNum=math.floor(4750-mmr.oneexp) end
		if hp.exp<20000000 then
			if mmr.targetNum>=30 then mmr.targetNum=30 end
		else
			if mmr.targetNum>=35 then mmr.targetNum=35 end
		end
	end
	if mpLimited.mpexp>5000 or mpJobLimited>0 then
		if hp.exp<20000000 then mmr.targetNum=24 else mmr.targetNum=30 end
	end
	--if xuefirst==1 then mmr.targetNum=5 end
end
function alias.dujingyao()
	alias.setmpLimitedMark()
	if stat.havedu>0 then alias.startliaoshang()
	elseif hp.neili<(hp.maxneili*set_neili_job/100) then alias.dz(set_neili)
	elseif havefj>0 then
		alias.uw()
		run("set startworkflow=yes")
	else
		if ((mpJobLimited==0 and me.menpai~="wd" and me.menpai~="gb" and workflow.mp>0 and not isopen("mp_qz_start")) or (me.menpai=="gb" and ((mpJobLimited>0 and (3600-os.time()-mpLimited.MarkTime)<=30) or (mpJobLimited==0 and gold.num<gold.setnum)))) and xuefirst==0 then
			alias.uw()
			run("set startworkflow=yes")
		elseif me.menpai=="wd" and wx.taiji==0 then
			alias.wi("jian")
			run("yun taiji")
			alias.checkbusy("taijistart")
		else
			if me.menpai=="em" and stat.zhixin==0 then run("yun zhixin") end
			run("du book 10")
		end
	end
end
function workflow.xinfa()
	if me.menpai=="sl" and workflow.xf>0 and ((songjingtime~=nil and songjingtime>0) or (zuochan~=nil and zuochan>0)) then
		return 1
	elseif me.menpai=="wd" and workflow.xf>0 and have.zhongjian~=nil and have.zhongjian>0 and skillslist["xuantie-jianfa"]~=nil and skillslist["xuantie-jianfa"]["lvl"]~=nil and skillslist["xuantie-jianfa"]["lvl"]>0 then
		return 1
	elseif me.menpai=="hs" and workflow.xf>0 and guanyuntime and me.shen>hp.exp and skillslist["zhengqi-jue"]~=nil and skillslist["zhengqi-jue"]["lvl"]~=nil and skillslist["zhengqi-jue"]["lvl"]>200 and skillslist["ziyin-yin"]~=nil and skillslist["ziyin-yin"]["lvl"]~=nil and skillslist["ziyin-yin"]["lvl"]>200 and skillslist["zixia-gong"]~=nil and skillslist["zixia-gong"]["lvl"]~=nil and skillslist["zixia-gong"]["lvl"]>350 then
		return 1
	elseif me.menpai=="mj" and workflow.xf>0 and chaobaitime~=nil and chaobaitime>0  then
		return 1
	else
		return 0
	end
end
------------------------------------------------------------------------------------
-- yun or pfm
------------------------------------------------------------------------------------
function alias.yunheal()
	if hp.healthqi>50 and hp.healthqi<100 then run("yun heal")
	else
		if jifa.forcename=="linjizhuang" then run("yun daxiao;yun tiandi")
		elseif jifa.forcename=="hamagong" then run("yun powerup")
		elseif jifa.forcename=="kurongchangong" then run("yun kurong")
		elseif jifa.forcename=="huagongdafa" then alias.startmp()
		else
			alias.checkdrugbusy("jinchuang")
			alias.startworkflow()
		end
	end
end
function alias.yunem()
	if me.menpai=="em" and (stat.daxiao==nil or stat.daxiao==0) then
		run("yun daxiao;yun recover")
	end
	if me.menpai=="em" and (stat.fengyun==nil or stat.fengyun==0) then
		run("yun fengyun")
	end
	if me.menpai=="em" and (stat.tiandi==nil or stat.tiandi==0) then
		run("yun tiandi")
	end
end
function alias.yunbt()
	if me.menpai=="bt" and (stat.reverse==nil or stat.reverse==0) then
		run("yun reverse")
	end
	if skillslist["hamagong"]==nil then skillslist["hamagong"]={} end
	if skillslist["hamagong"]["lvl"]==nil then skillslist["hamagong"]["lvl"]=0 end
	if me.menpai=="bt" and (stat.powerup==nil or stat.powerup==0) and skillslist["hamagong"]["lvl"]>200 then
		run("yun powerup")
	end
end
function alias.dl_with_ailao()
	if have.jian~=nil and have.jian>0 and dl.useailao>0 then
		--wieldweapon=0
		alias.wi("jian")
		killskill="jian"
		killpfm="perform ailao"
		killjiali=0
		killjiajin="max"
		run("jiajin max;jiali 0")
	end
end
function alias.kmq()
	run("bei none;bei kongming-quan")
	local _tb=utils.split(killpfm,"|")
	run(_tb[pfmid].." "..killid)
	run("bei none;bei sanhua-juding")
end
function alias.xxpfm(a)
	alias.resetidle()
	-- #if @debug {#say xx化功大法pfm}
	if a==nil then a=tostring(killid) end
	--if xx.suck==0 or hp.jing<(hp.maxjing*4/5) or hp.healthjing<90 or hp.qi<(hp.maxqi*4/5) or hp.healthqi<90 then
	if hp.qi<(hp.maxqi/4) then run("yun recover") end
	if xx.suck==0 or hp.healthjing<90 or hp.healthqi<90 then
		run("yun jiexin "..tostring(a))
	elseif xx.suck==1 or hp.neili<hp.maxneili then
		run("yun jiemai "..tostring(a))
	else
		run("yun huagong "..tostring(a))
	end
end
function alias.pfm()
	--if a==nil then a=tostring(killid) end
	_tb=utils.split(killpfm,"|")
	if not npcfaint and pfmid<=table.getn(_tb) and xy.pfm()>0 then
		if kmq() then alias.kmq()
		elseif killpfm=="pfmqncg" then run("jiajin max;perform qinna "..killid..";perform cuogu "..killid..";jiajin 1")
		elseif killpfm=="pfmst" then run("wield jian;perform sanqing "..killid..";yun shentong "..killid)
		elseif killpfm=="pfmsqlh" then run("wield jian;perform sanqing "..killid..";perform lianhuan "..killid)
		elseif killpfm=="pfmkmq" then run("perform kong "..killid..";perform ming "..killid)
		elseif killpfm=="pfmxy" then run("jifa parry xiaoyaoyou;perform xiaoyao "..killid..";jifa parry xianglong-zhang")
		else
			run(_tb[pfmid].." "..killid)
		end
	end
end
------------------------------------------------------------------------------------
-- jifa
------------------------------------------------------------------------------------
function alias.jfxx()
	run("jifa dodge zhaixinggong;jifa stroke duoming-bi;jifa parry duoming-bi;jifa claw sanyin-zhua;jifa strike chousui-zhang;bei none;bei chousui-zhang sanyin-zhua")
end
function alias.jfwd()
	run("jifa dodge tiyunzong;jifa parry taiji-jian;jifa sword taiji-jian;jifa cuff taiji-quan;jifa strike mian-zhang;bei none;bei taiji-quan;bei mian-zhang")
end
function alias.jfth()
	run("jifa dodge luoying-shenfa;jifa parry luoying-shenjian;jifa sword yuxiao-jian;jifa strike luoying-shenjian;jifa kick xuanfeng-saoye;jifa hand lanhua-fuxue;jifa finger tanzhi-shentong;bei none;bei xuanfeng-saoye luoying-shenjian")
end
function alias.jfsl()
	run("jifa dodge shaolin-shenfa;jifa blade ranmu-dao;jifa cuff jingang-quan;jifa finger yizhi-chan;jifa parry ranmu-dao;jifa strike banruo-zhang;jifa sword damo-jian;jifa whip heilong-bianfa;jifa claw longzhua-gong;jifa club weituo-gun;jifa hand fengyun-shou;jifa staff wuchang-zhang;bei none;bei banruo-zhang yizhi-chan")
end
function alias.jfqz()
	run("jifa dodge jinyangong;jifa parry quanzhen-jian;jifa sword quanzhen-jian;jifa strike sanhua-juding;jifa staff jinhua-zhang;jifa hand nilin-shou")
	if skillslist["kongming-quan"]~=nil and skillslist["kongming-quan"]["lvl"]>0 and findstring(fjpfm,"perform kong","perform ming") then
		run("jifa cuff kongming-quan;jifa parry sanhua-juding;bei none;bei kongming-quan")
	else
		run("jifa cuff chunyang-quan;bei none;bei chunyang-quan;bei sanhua-juding")
	end
end
function alias.jfhs()
	run("jifa cuff pishi-poyu;jifa blade liangyi-dao")
	if me.master=="风清扬" then
		run("jifa dodge dugu-jiujian;jifa parry dugu-jiujian;jifa sword dugu-jiujian;jifa strike dugu-jiujian;jifa staff dugu-jiujian")
	else
		run("jifa dodge huashan-shenfa;jifa parry huashan-jianfa;jifa blade liangyi-dao;jifa sword huashan-jianfa;jifa strike hunyuan-zhang;jifa staff jinhua-zhang")
	end
	run("bei none;bei hunyuan-zhang;bei pishi-poyu")
end
function alias.jfhbmz()
	run("jifa strike hanbing-mianzhang;jifa parry hanbing-mianzhang;jifa dodge guifu-fei;bei none;bei hanbing-mianzhang")
end
function alias.jfgb()
	run("jifa strike xianglong-zhang;jifa dodge xiaoyaoyou")
	if fjweapon=="stick" then run("jifa parry dagou-bang") else run("jifa parry pikong-zhang") end
	run("jifa dodge huashan-shenfa;jifa strike pikong-zhang;jifa kick xuanfeng-saoye;jifa parry pikong-zhang;bei none;bei pikong-zhang")
end
function alias.jfdl()
	if jifa.forcename~="xuanyinzhenqi" then
		run("jifa dodge duanshi-shenfa;jifa parry yiyang-zhi;jifa finger yiyang-zhi;jifa strike qingyan-zhang;jifa cuff jinyu-quan;jifa staff duanjia-jian;jifa sword duanjia-jian")
		if findstring(killpfm,"perform piaomiao") then run("bei none;bei qingyan-zhang;bei jinyu-quan") else run("bei none;bei yiyang-zhi") end
	end
end
function alias.jfbt()
	run("jifa dodge chanchubu;jifa staff lingshe-zhang;jifa parry lingshe-zhang;jifa strike shentuo-zhang;jifa sword pixie-jian;bei none;bei shentuo-zhang;bei lingshe-quan")
end
function alias.jfgm()
	run("jifa dodge gumu-shenfa;jifa cuff meinu-quan;jifa whip yinsuo-jinling;jifa sword yunu-jianfa;jifa parry meinu-quan;bei none;bei meinu-quan")
end
function alias.jfxs()
	run("jifa parry huoyan-dao;jifa hammer riyue-lun;jifa dodge shenkongxing;jifa staff jingang-chu;jifa strike huoyan-dao;jifa hand dashou-yin;bei none;bei huoyan-dao")
end
function alias.jfem()
	run("jifa sword emei-jian;jifa parry emei-jian;jifa blade yanxing-dao;jifa strike jinding-zhang;jifa claw jiuyin-zhao;jifa finger qianzhu-wandu;jifa finger tiangang-zhi;jifa dodge zhutian-bu;bei none;bei jinding-zhang;bei tiangang-zhi")
end
function alias.jfxx()
	run("jifa dodge zhaixinggong;jifa stroke duoming-bi;jifa parry duoming-bi;jifa claw sanyin-zhua;jifa strike chousui-zhang;bei none;bei chousui-zhang sanyin-zhua")
end
function alias.jf(a)
	_tb=utils.split(a,";")
	for k,v in ipairs(_tb) do run(v) end
end
------------------------------------------------------------------------------------
-- startworkflow 工作流程
------------------------------------------------------------------------------------
function alias.startworkflow()
	local _f
	-- 选择流程开始
	alias.setmpLimitedMark()
	--if reEnableSkills>0 then
	--	reEnableSkills=0
	--	if jifa.forcename=="xuanyinzhenqi" then alias.jfhbmz() else Execute("/alias.jf"..me.menpai.."()") end
	--end
	if jifa.forcename=="motianyunqi" then run("yun shougong") end
	run("jiajin basic;jiali 0;yield no;set no_accept 1;set brief 2")
	if stat.quiting==2 then stat.quiting=0;openclass("quit")
	elseif stat.haveyyz>0 then alias.starttongmai()
	elseif stat.havedu>0 then alias.startliaoshang()
	else
		if workflow.nowjob=="death" then workflow.nowjob="mp" end
		if workflow.nowjob=="lzjob" then workflow.nowjob="mp" end
		if cmd.nums<cmd.setnums then Execute("/alias.startworkflow_"..me.menpai.."()")
		else
			wait.make(function()
				_f=function() Execute("/alias.startworkflow_"..me.menpai.."()") end
				wait.time(1);_f()
			end)
		end
	end
end
function alias.startworkflow_th()
	-- #if @debug {#say 桃花流程开始，历史任务@workflow.nowjob}
	havedo=1
	if havefj>0 then alias.startfj()
	elseif havedo==1 and hp.thpot>math.abs(hp.maxpot*10-10) then
		run("halt")
		havefj=0
		run("ask lu about 要事在身")
		alias.startxue()
		havedo="xue"
	elseif havedo==1 then
		if workflow.mp>0 and mpjoblimited==0 then
			alias.startmp()
			havedo="mp"
		end
	end
end
function alias.startworkflow_gb()
	-- 丐帮流程开始，历史任务@workflow.nowjob
	if workflow.nowjob=="fj" then alias.startworkflow_gb_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_gb_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_gb_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_gb_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_gb_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_gb_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_gb_xue() end
end
function alias.startworkflow_gb_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_gb_fj()
	-- print("startworkflow_gb_fj")
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm() else alias.startxue() end
	else
		if xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
		else
			if workflow.mp>0 then
				gold.num=0
				if gold.roomNo>0 then alias.startgbresume() else alias.startmp() end
			else
				if workflow.cm>0 then alias.startcm() else alias.startxue() end
			end
		end
	end
end
function alias.startworkflow_gb_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else startfjclose() end
	else
		if mpJobLimited>0 then
			if workflow.cm>0 then alias.startcm()
			else
				if workflow.ftb>0 then alias.startftb()
				else
					if skillsfull>0 then
						alias.dz("addneili")
						resumejob=""
					else
						if workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
						else
							alias.dz("addneili")
							resumejob=""
						end
					end
				end
			end
		else
			if workflow.mp>0 then
				gold.num=0
				if gold.roomNo>0 then alias.startgbresume() else alias.startmp() end
			else
				if workflow.cm>0 then alias.startcm()
				else
					if workflow.ftb>0 then alias.startftb()
					else
						alias.dz("addneili")
						resumejob=""
					end
				end
			end
		end
	end
end
function alias.startworkflow_gb_mp()
	-- print("startworkflow_gb_mp")
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	else
		if xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
		else
			if mpJobLimited>0 then
				if workflow.cm>0 then alias.startcm()
				else
					if workflow.ftb>0 then alias.startftb() else alias.startxue() end
				end
			else
				if gold.num==nil then gold.num=0 end
				if gold.num<gold.setnum then
					if gold.roomNo>0 then alias.startgbresume() else alias.startmp() end
				else
					if workflow.cm>0 then alias.startcm() else alias.startxue() end
				end
			end
		end
	end
end
function alias.startworkflow_gb_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb() else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_gb_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then
		gold.num=0
		if gold.roomNo>0 then alias.startgbresume() else alias.startmp() end
	else alias.startftb() end
end
function alias.startworkflow_gb_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then
			gold.num=0
			if gold.roomNo>0 then alias.startgbresume() else alias.startmp() end
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_dl()
	-- 大理流程开始，历史任务@workflow.nowjob
	if workflow.nowjob=="fj" then alias.startworkflow_dl_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_dl_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_dl_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_dl_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_dl_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_dl_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_dl_xue() end
end
function alias.startworkflow_dl_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_dl_fj()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then alias.startxinfa()
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startxinfa() end
end
function alias.startworkflow_dl_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_dl_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	--elseif tonumber(roomno_now)==tonumber(me.menpaiJobStart) then alias.flytonpc(dl.jobnpc)
	else alias.startmp() end
end
function alias.startworkflow_dl_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_dl_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_dl_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_hs()
	-- 华山流程开始，历史任务@workflow.nowjob
	if workflow.nowjob=="fj" then
		if workflow.qzwd>0 then alias.startqzwd()
		else alias.startxinfa() end
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_hs_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_hs_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_hs_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_hs_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_hs_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_hs_xue() end
end
function alias.startworkflow_hs_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_hs_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 then alias.startxue()
	elseif mpJobLimited>0 then
		if have.ling<mmr.targetNum then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_hs_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xinfa()>0 then alias.startxinfa()
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif mpJobLimited>0 then
		if tonumber(have.ling)<tonumber(mmr.targetNum) then
			if findstrlist2(roomno_now,utils.split(mmr.searchroomno,"|")) and isopen("mp_hs_pre") then
				run("set searchmmr=yes")
			else alias.startmp() end
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if findstrlist2(roomno_now,utils.split(mmr.searchroomno,"|")) and isopen("mp_hs_pre") then
			run("set searchmmr=yes")
		else alias.startmp() end
	end
end
function alias.startworkflow_hs_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xinfa()>0 then alias.startxinfa()
	elseif xuefirst>0 then alias.startxue()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_hs_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_hs_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if have.ling<mmr.targetNum then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob="startmp"
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob="startmp"
		end
	end
end
function alias.startworkflow_qz()
	-- #if @debug {#say 全真流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="fj" then alias.startworkflow_qz_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_qz_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_qz_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_qz_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_qz_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_qz_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_qz_xue() end
end
function alias.startworkflow_qz_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_qz_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_qz_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
		elseif bdz.askqiu==0 then alias.startmp()
		elseif isopen("mp_qz_pre") then
			closeclass("mp_qz_pre")
			openclass("mp_qz_start")
			alias.flytoid(723)
		else alias.startmp() end
	end
end
function alias.startworkflow_qz_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_qz_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_qz_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_qz_fj()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then alias.startxinfa()
	elseif xuefirst>0 then alias.startxue()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startxinfa() end
end
function alias.startworkflow_wd()
	-- #if @debug {#say 武当流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="fj" then alias.startworkflow_wd_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_wd_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_wd_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_wd_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_wd_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_wd_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_wd_xue() end
end
function alias.startworkflow_wd_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_wd_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	else
		if workflow.mp>0 then
			alias.dz("addneili")
			resumejob=""
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_wd_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if me.shen>hp.exp then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_wd_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	else alias.startftb() end
end
function alias.startworkflow_wd_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_wd_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 and me.shen>hp.exp then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_wd_fj()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then
		if xuefirst>0 then alias.startxue()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp() 
		elseif xuefirst>0 then alias.startxue()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_sl()
	-- #if @debug {#say 少林流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="fj" then alias.startworkflow_sl_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_sl_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_sl_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_sl_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_sl_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_sl_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_sl_xue() end
end
function alias.startworkflow_sl_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_sl_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_sl_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then
		-- sl和em不一样，诵经有时间，所以需要在mp未满的情况下去启动xf模块诵经
		alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if isopen("mp_sl_pre") then run("set searchseng=yes")
		else alias.startmp() end
	end
end
function alias.startworkflow_sl_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_sl_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_sl_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_sl_fj()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then alias.startxinfa()
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startxinfa() end
end
function alias.startworkflow_xs()
	-- #if @debug {#say 雪山流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="fj" then alias.startworkflow_xs_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_xs_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_xs_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_xs_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_xs_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_xs_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_xs_xue() end
end
function alias.startworkflow_xs_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_xs_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_xs_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		alias.startmp()
		--if tonumber(roomno_now)==tonumber(me.menpaiJobStart) and isopen("mp_xs_pre") then
		--	if me.suyou~=nil and me.suyou>=49 then alias.flytoid(428) else alias.flytoid(417) end
		--else alias.startmp() end
	end
end
function alias.startworkflow_xs_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_xs_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_xs_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_xs_fj()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then alias.startxinfa()
	elseif xuefirst>0 then alias.startxue()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startxinfa() end
end
function alias.startworkflow_em()
	-- #if @debug {#say 峨嵋流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="fj" then alias.startworkflow_em_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_em_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_em_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_em_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_em_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_em_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_em_xue() end
end
function alias.startworkflow_em_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_em_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			if skillsfull>0 then
				alias.dz("addneili")
				resumejob=""
			elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
			else
				alias.dz("addneili")
				resumejob=""
			end
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_em_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if tonumber(roomno_now)==tonumber(me.menpaiJobStart) and isopen("mp_em_pre") then
			run("get fuling from yaodai")
			run("set searchnpc=yes")
		else alias.startmp() end
	end
end
function alias.startworkflow_em_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_em_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		else alias.startxue() end
	end
end
function alias.startworkflow_em_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_em_fj()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then
		if xuefirst and hp.pot>=hp.maxpot then alias.startxue()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if xuefirst>0 then alias.startxue()
		elseif workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_gm()
	-- #if @debug {#say 古墓流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="mp" then alias.startworkflow_gm_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_gm_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_gm_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_gm_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_gm_xue() end
end
function alias.startworkflow_gm_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_gm_xue()
	if mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_gm_mp()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif do_gm_job3>0 and hp.exp>500000 and (os.time()-gmjob3time)>500 then
		alias.flytoid(607)
		openclass("mp_gm_job3")
	elseif xuefirst>0 then alias.startxue()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else alias.startmp() end
end
function alias.startworkflow_gm_ftb()
	if xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_gm_cm()
	if mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_bt()
	-- #if @debug {#say 白驼流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="fj" then
		if workflow.qzwd>0 then alias.startqzwd()
		else alias.startxinfa() end
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_bt_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_bt_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_bt_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_bt_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_bt_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_bt_xue() end
end
function alias.startworkflow_bt_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_bt_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_bt_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if isopen("mp_bt_pre") then alias.dz(set_neili)
		else alias.startmp() end
	end
end
function alias.startworkflow_bt_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_bt_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if xuefirst>0 then alias.startxue()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if xuefirst>0 then alias.startxue()
		elseif workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_bt_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_xx()
	-- #if @debug {#say 星宿流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="fj" then alias.startworkflow_xx_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_xx_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_xx_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_xx_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_xx_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_xx_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_xx_xue() end
end
function alias.startworkflow_xx_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_xx_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			--alias.dz("addneili")
			--resumejob=""
			alias.startmp()
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			--alias.dz("addneili")
			--resumejob=""
			alias.startmp()
		end
	end
end
function alias.startworkflow_xx_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else alias.startmp() end
end
function alias.startworkflow_xx_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_xx_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_xx_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_xx_fj()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then alias.startxinfa()
	elseif xuefirst>0 then alias.startxue()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startxinfa() end
end
function alias.startworkflow_mj()
	-- #if @debug {#say 明教流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="fj" then alias.startworkflow_mj_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_mj_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_mj_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_mj_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_mj_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_mj_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_mj_xue() end
end
function alias.startworkflow_mj_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_mj_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
			alias.startmp()
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
			alias.startmp()
		end
	end
end
function alias.startworkflow_mj_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else alias.startmp() end
end
function alias.startworkflow_mj_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_mj_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_mj_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_mj_fj()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then alias.startxinfa()
	elseif xuefirst>0 then alias.startxue()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startxinfa() end
end
