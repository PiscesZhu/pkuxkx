always={}
always_daytime={}
always_hp={}
always_skills={}
always_watch={}
watch_death={}

mpjoblimited=0
tunanum=0
sheid=1
st=0
rekill=0
killname=""
pfmid=1
wieldweapon=0
getweapon=0
dropweapon=0
gpszeikou=""
gpserrnum=0
flytoareastartid=0
daytime=true
songjingtime=0
guanyuntime=false
chaobaitime=false
reEnableSkills=0
idle=0
yunbusy=0
killaction=""
mpJobLimited=0
--lianwunum_set=0
nextJobGodazuobase=0
deathroomno=0
deathjob=""

burnnpc={}
wx={
	taiji=0,
	zhixin=0,
}
xy={
	findxy=0,
	roomno=0,
	name="",
	id="",
	xyLimited=0,
	limitedResume=0,
	biteLimited=0,
	xyexp=0,
	checkfirstbite=0,
	
}
stat={
	havedu=0,
	drugbusy=0,
	addexp=0,
	avgall=0,
	avgfj=0,
	avgmp=0,
	avgftb=0,
	avgdeath=0,
	countdeath=0,
	leidong=0,
	havedu=0,
	haveyyz=0,
	reverse=0,
	powerup=0,
	quiting=0,
	zixia=0,
	daxiao=0,
	fengyun=0,
	tiandi=0,
	zhixin=0,
	huntianup=0,
	shengang=0,
	xuanyin=0,
	heji=0,
	longxiang=0,
}
count={
	death=0,
}
hp={
	thpot=0,
}
mark={
	sTime=os.time(),
}
jifa={}
list={}
pk={}
add={
	exp=0,
}
have={}
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
addneili={
	dahuandan=0,
	putizi=0,
	dazuo=0,
	fj=0,
}
mpLimited={
	MarkTime=0,
	MarkExp=0,
	mpexp=0,
	-- stat=0,
}
skillslist={
	literate={lvl=0,},
	cuff={lvl=0,},
	["kongming-quan"]={lvl=0,},
}

if me==nil then me={} end
me.xtbl=0
me.bl=0

function xy.pfm()
	if me.menpai=="bt" and isopen("mp_bt_start") then
		if xy.xyLimited>0 and xy.biteLimited==0 or xy.checkfirstbite>0 then return 0 else return 1 end
	else
		return 1
	end
end
function mpLimited.stat()
	if os.time()>tonumber(mpLimited.MarkTime)+3600 or tonumber(mpLimited.mpexp)<tonumber(mpLimited.MarkExp) then
		return 0
	else
		return 1
	end
end
------------------------------------------------------------------------------------
-- always_daytime
------------------------------------------------------------------------------------
function always_daytime.dosomething1(n,l,w,s)
	local col=string.find(l,w[1])
	if not col then
		print("[::always_daytime.dosomething1::]::颜色抓取失败::")
		return
	end
	style=GetStyle(s,col)
	local color=RGBColourToName(style.textcolour)
	if color=="silver" and style["backcolor"]==0 then return end
	if findstring(l,"太阳从东方的地平线升起了。","太阳刚从东方的地平线升起") then
		daytime=true;songjingtime=0;guanyuntime=true;chaobaitime=true
	end
	if findstring(l,"已经是午夜了。","夜晚降临了。","夜幕低垂，满天繁星","夜幕笼罩著大地","一轮火红的夕阳正徘徊在西方的地平线上","已经是午夜了。") then
		daytime=false;songjingtime=0;guanyuntime=false;chaobaitime=false
	end
	if findstring(l,"傍晚了，太阳的馀晖将西方的天空映成一片火红。","东方的天空中开始出现一丝微曦。","已经是正午了，太阳从你正上方照耀著大地。","太阳开始从西方的天空中慢慢西沉。","太阳正高挂在东方的天空中","太阳正高挂在西方的天空中","现在是正午时分，太阳高挂在你的头顶正上方") then
		daytime=true;songjingtime=0;guanyuntime=false;chaobaitime=true
	end
	if findstring(l,"东方的天空已逐渐发白","东方的天空中开始出现一丝微曦。") then
		daytime=true;songjingtime=1;guanyuntime=false;chaobaitime=false
	end
end
------------------------------------------------------------------------------------
-- always_hp
------------------------------------------------------------------------------------
function always_hp.dosomething1(n,l,w)
	me["expadd"]=tonumber(w[1])
end
function always_hp.dosomething2(n,l,w)
	me["gold"]=ctonum(w[1])
	if skillslist["literate"]==nil then skillslist["literate"]={} end
	if skillslist["literate"]["lvl"]==nil then skillslist["literate"]["lvl"]=1 end
	if me["gold"]>100 and skillslist["literate"]["lvl"]<500 and havegoldxuelit>0 then xuelit=1 else xuelit=0 end
end
function always_hp.dosomething3(n,l,w)
	me["gold"]=0
	xuelit=0
end
function always_hp.dosomething4(n,l,w)
	hp["jing"]=tonumber(w[2])
	hp["maxjing"]=tonumber(w[3])
	hp["healthjing"]=tonumber(w[4])
	hp["jingli"]=tonumber(w[5])
	hp["maxjingli"]=tonumber(w[6])
	hp["jiajin"]=tonumber(w[7])
end
function always_hp.dosomething5(n,l,w)
	hp["qi"]=tonumber(w[1])
	hp["maxqi"]=tonumber(w[2])
	hp["healthqi"]=tonumber(w[3])
	hp["neili"]=tonumber(w[4])
	hp["maxneili"]=tonumber(w[5])
end
function always_hp.dosomething6(n,l,w)
	hp["food"]=tonumber(w[1])
	hp["maxfood"]=tonumber(w[2])
	hp["pot"]=tonumber(w[3])
	hp["maxpot"]=tonumber(w[4])
	if mark["setpot"] then
		mark["pot"]=hp["pot"]
		mark["setpot"]=0
	end
end
function always_hp.dosomething7(n,l,w)
	hp["water"]=tonumber(w[1])
	hp["maxwater"]=tonumber(w[2])
	hp["exp"]=tonumber(w[3])
	me["maxlvl"]=math.floor(math.floor((hp["exp"]*10)^(1/3) * 10)/10)
	if mark["setexp"]>0 then
		mark["exp"]=hp["exp"]
		mark["setexp"]=0
	end  
	if (do_dl_job==1 and hp.exp<30000) or (do_dl_job==1 and hp.exp>3000000) then do_dl_job=0 end
end
function always_hp.dosomething8(n,l,w)
	me["shen"]=tonumber(w[2])
	if me["shen"]<=-1 then setybjob=1 end
	if me["shen"]>=0 then setybjob=0 end
end
function always_hp.dosomething9(n,l,w)
	me["menpai"]="none"
	xkxGPS.setEntranceCondition("condition is null")
	if string.find(w[1],"古墓派") then
		me["menpai"]="gm"
		me["fjmaster"]=""
		me["fjmasternick"]="你大爷"
		me["fjmasterid"]=""
		me["fjbaseid"]=0
		me["fjnpcname"]=""
		me["fjnpcid"]=""
		me["menpailingwuid"]=2065
		me["menpaiJobStart"]=2076
		me["menpaiLimited"]=5000
		me["dazuobaseid"]=2077
		me["chongmaiBaseid"]=2077
		if set_GbSecretWay>0 then xkxGPS.setEntranceCondition("(condition is null or condition='dong') and id<>3247") end
	end
	if string.find(w[1],"大理段家") then
		me["menpai"]="dl"
		me["fjmaster"]="段正淳"
		me["fjmasternick"]="段王爷"
		me["fjmasterid"]="zhengchun"
		me["fjbaseid"]=191
		me["fjnpcname"]="强盗"
		me["fjnpcid"]="qiang dao"
		me["menpailingwuid"]=191
		me["menpaiJobStart"]=286
		me["menpaiLimited"]=8000
		me["dazuobaseid"]=0
		me["chongmaiBaseid"]=1422
		if set_GbSecretWay>0 then xkxGPS.setEntranceCondition("(condition is null or condition='dong') and id<>3247") end
	end
	if string.find(w[1],"全真教") then
		me["menpai"]="qz"
		me["fjmaster"]="马钰"
		me["fjmasternick"]="掌教马钰"
		me["fjmasterid"]="ma"
		me["fjbaseid"]=792
		me["fjnpcname"]="魔教弟子"
		me["fjnpcid"]="mojiao"
		me["menpailingwuid"]=808
		me["menpaiJobStart"]=782
		me["menpaiLimited"]=6000
		me["dazuobaseid"]=785
		me["chongmaiBaseid"]=785
		if set_GbSecretWay>0 then xkxGPS.setEntranceCondition("(condition is null or condition='dong' or condition='qz') and id<>3247") else xkxGPS.setEntranceCondition("(condition is null or condition='qz')") end
	end
	if string.find(w[1],"武当派") then
		me["menpai"]="wd"
		me["fjmaster"]="张三丰"
		me["fjmasternick"]="掌门人张真人"
		me["fjmasterid"]="zhang sanfeng"
		me["fjbaseid"]=677
		me["fjnpcname"]="蒙古哒子"
		me["fjnpcid"]="dazi"
		me["menpailingwuid"]=687
		me["menpaiJobStart"]=705
		me["menpaiLimited"]=5000
		me["dazuobaseid"]=0
		me["chongmaiBaseid"]=1422
		if set_GbSecretWay>0 then xkxGPS.setEntranceCondition("(condition is null or condition='dong') and id<>3247") end
	end
	if string.find(w[1],"少林派") then
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
		if set_GbSecretWay>0 then xkxGPS.setEntranceCondition("(condition is null or condition='dong') and id<>3247") end
	end
	if string.find(w[1],"桃花岛") then
		me.menpai="th"
		me.fjmaster="陆乘风"
		me.fjmasternick="庄主"
		me.fjmasterid="lu chengfeng"
		me.fjbaseid=1470
		me.fjnpcname="强盗"
		me.fjnpcid="qiang dao"
		me.menpailingwuid=0
		me.menpaiJobStart=1470
		me.menpaiLimited=7000
		me.dazuobaseid=0
		if set_GbSecretWay>0 then xkxGPS.setEntranceCondition("(condition is null or condition='dong') and id<>3247") end
	end
	if string.find(w[1],"峨嵋派") then
		me.menpai="em"
		me.fjmaster="灭绝师太"
		me.fjmasternick="掌门灭绝师太"
		me.fjmasterid="miejue"
		me.fjbaseid=372
		me.fjnpcname="魔教弟子"
		me.fjnpcid="mojiao"
		me.menpailingwuid=378
		me.menpaiJobStart=per.roomno
		me.menpaiLimited=5000
		me.dazuobaseid=2052
		me.chongmaiBaseid=2052
		if set_GbSecretWay>0 then xkxGPS.setEntranceCondition("(condition is null or condition='dong') and id<>3247") end
	end
	if string.find(w[1],"华山派") then
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
		if set_GbSecretWay>0 then xkxGPS.setEntranceCondition("(condition is null or condition='dong') and id<>3247") end
	end
	if string.find(w[1],"星宿派") then
		me.menpai="xx"
		me.fjmaster="丁春秋"
		me.fjmasternick="星宿老仙"
		me.fjmasterid="ding"
		me.fjbaseid=1442
		me.fjnpcname="江湖侠士"
		me.fjnpcid="xiashi"
		me.menpailingwuid=2112
		me.menpaiJobStart=1442
		me.menpaiLimited=6000
		me.dazuobaseid=1442
		me.chongmaiBaseid=1442
		if set_GbSecretWay>0 then xkxGPS.setEntranceCondition("(condition is null or condition='dong') and id<>3247") end
	end
	if string.find(w[1],"白驼山") then
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
		if set_GbSecretWay>0 then xkxGPS.setEntranceCondition("(condition is null or condition='dong') and id<>3247") end
	end
	if string.find(w[1],"明教") then
		me.menpai="mj"
		me.fjmaster="杨逍"
		me.fjmasternick="光明左使杨逍"
		me.fjmasterid="yang"
		me.fjbaseid=573
		me.fjnpcname="江湖侠士"
		me.fjnpcid="xiashi"
		me.menpailingwuid=1970
		me.menpaiJobStart=573
		me.menpaiLimited=5000
		me.dazuobaseid=0
		me.chongmaiBaseid=1422
		if set_GbSecretWay>0 then xkxGPS.setEntranceCondition("(condition is null or condition='dong') and id<>3247") end
	end
	if string.find(w[1],"雪山派") then
		me.menpai="xs"
		me.fjmaster="鸠摩智"
		me.fjmasternick="大轮明王鸠摩智"
		me.fjmasterid="jiumozhi"
		me.fjbaseid=436
		me.fjnpcname="强盗"
		me.fjnpcid="qiang dao"
		me.menpailingwuid=1853
		me.menpaiJobStart=428
		me.menpaiLimited=7000
		me.dazuobaseid=0
		me.chongmaiBaseid=1422
		if set_GbSecretWay>0 then xkxGPS.setEntranceCondition("(condition is null or condition='xs' or condition='dong') and id<>3247") end
	end
	if string.find(w[1],"密宗") then me.menpai="xs" end
	if string.find(w[1],"丐帮") then
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
		xkxGPS.setEntranceCondition("(condition is null or condition='gb' or condition='dong') and id<>3247 and id<>3248")
	end
end
function always_hp.dosomething10(n,l,w)
	me.master=w[1]
	me.masterid=""
	me.masterroom=""
	if string.find(me["master"],"自学贯通") then me["masterid"]="" end
	if string.find(me["master"],"觉心") then me["masterid"]="juexin" end
	if string.find(me["master"],"鸠摩智") then me["masterid"]="jiumozhi" end
	if string.find(me["master"],"金轮法王") then me["masterid"]="fawang" end
	if string.find(me["master"],"一灯大师") then me["masterid"]="yideng" end
	if string.find(me["master"],"黄药师") then me["masterid"]="huang" end
	if string.find(me["master"],"张三丰") then me["masterid"]="zhang" end
	if string.find(me["master"],"马钰") then me["masterid"]="ma" end
	if string.find(me["master"],"丁春秋") then me["masterid"]="ding" end
	if string.find(me["master"],"欧阳锋") then me["masterid"]="ouyang" end
	if string.find(me["master"],"矮老者") then me["masterid"]="ai" end
	if string.find(me["master"],"高老者") then me["masterid"]="gao" end
	if string.find(me["master"],"洪七公") then me["masterid"]="hong" end
	if string.find(me["master"],"梁长老") then me["masterroom"]=2027 end
	if string.find(me["master"],"风清扬") then
		me["masterid"]="feng"
		if set_GbSecretWay>0 then
			xkxGPS.setEntranceCondition("(condition is null or condition='dong' or condition='feng')")
		else
			xkxGPS.setEntranceCondition("(condition is null or condition='feng')")
		end
	end
end
function always_hp.dosomething11(n,l,w)
	if string.find(w[1],"无") then me["quit"]=true else me["quit"]=false end
end
function always_hp.dosomething12(n,l,w)
	if string.find(w[1],"男性") then me["sex"]=true end
	if string.find(w[1],"女性") then me["sex"]=false end
	if string.find(w[1],"无性") then me["sex"]=true end
end
function always_hp.dosomething13(n,l,w)
	me["charname"]=w[1]
end
function always_hp.dosomething14(n,l,w)
	me["shen"]=0-tonumber(w[1])
end
function always_hp.dosomething15(n,l,w)
	me["charid"]=string.lower(w[1])
end
function always_hp.dosomething16(n,l,w)
	local a,b,c
	a,b,c=string.find(l,"你目前有桃花潜能(.+)点。")
	if c~=nil then
		hp.thpot=ctonum(c)
	end
	if findstring(l,"你没有那么多桃花潜能。","你现在没有桃花潜能。") then
		hp.thpot=0
	end
end
function always_hp.dosomething17(n,l,w)
	me["shijian"]=ctonum(w[1])
	if me["shijian"]>=1 then stat.quiting=2 end
end
------------------------------------------------------------------------------------
-- always_skills
------------------------------------------------------------------------------------
function always_skills.dosomething1(n,l,w)
	me["bl"]=tonumber(w[1])
	me["xtbl"]=tonumber(w[2])
	me["wx"]=tonumber(w[3])
	me["xtwx"]=tonumber(w[4])
end
function always_skills.dosomething2(n,l,w)
	me["gg"]=tonumber(w[1])
	me["xtgg"]=tonumber(w[2])
	me["sf"]=tonumber(w[3])
	me["xtsf"]=tonumber(w[4])
end
function always_skills.dosomething3(n,l,w)
	if string.find(w[1],"混天气功") then jifa["forcename"]="huntianqigong" end
	if string.find(w[1],"碧涛玄功") then jifa["forcename"]="bitaoxuangong" end
	if string.find(w[1],"颠倒功") then jifa["forcename"]="diandaogong" end
	if string.find(w[1],"毒龙大法") then jifa["forcename"]="dulongdafa" end
	if string.find(w[1],"光明圣火功") then jifa["forcename"]="guangmingshenghuo" end
	if string.find(w[1],"蛤蟆功") then jifa["forcename"]="hamagong" end
	if string.find(w[1],"化功大法") then jifa["forcename"]="huagongdafa" end
	if string.find(w[1],"混元功") then jifa["forcename"]="hunyuangong" end
	if string.find(w[1],"混元一气功") then jifa["forcename"]="hunyuanyiqi" end
	if string.find(w[1],"九阳神功") then jifa["forcename"]="jiuyangshengong" end
	if string.find(w[1],"枯荣禅功") then jifa["forcename"]="kurongchangong" end
	if string.find(w[1],"临济十二庄") then jifa["forcename"]="linjizhuang" end
	if string.find(w[1],"龙象般若功") then jifa["forcename"]="longxiangbanruo" end
	if string.find(w[1],"弥勒功") then jifa["forcename"]="milegong" end
	if string.find(w[1],"摩天云气") then jifa["forcename"]="motianyunqi" end
	if string.find(w[1],"太极神功") then jifa["forcename"]="taijishengong" end
	if string.find(w[1],"太玄功") then jifa["forcename"]="taixuangong" end
	if string.find(w[1],"先天功") then jifa["forcename"]="xiantiangong" end
	if string.find(w[1],"修龄要旨") then jifa["forcename"]="xiulingyaozhi" end
	if string.find(w[1],"玄门导引功") then jifa["forcename"]="xuanmendaoyin" end
	if string.find(w[1],"玄阴真气") then jifa["forcename"]="xuanyinzhenqi" end
	if string.find(w[1],"玉女心经") then jifa["forcename"]="yunuxinjing" end
	if string.find(w[1],"紫霞功") then jifa["forcename"]="zixiagong" end
	jifa["force"]=tonumber(w[2])
end
function always_skills.dosomething4(n,l,w)
	run("jifa")
end
function always_skills.dosomething5(n,l,w)
	skillslist[w[3]]={}
	skillslist[w[3]]["name"]=w[2]
	skillslist[w[3]]["lvl"]=tonumber(w[4])
	skillslist[w[3]]["sld"]=tonumber(w[5])
end
function always_skills.dosomething6(n,l,w)
	skillslist={}
end
------------------------------------------------------------------------------------
-- always_watch
------------------------------------------------------------------------------------
function always_watch.timer()
	me.drugbusy=0
end
function always_watch.timer1()
	cm.havebuff=0
end
function always_watch.timer10()
	stat.addexp=sum.all()
	stat.avgall=avg.all()
	stat.avgfj=avg.fj()
	stat.avgmp=avg.mp()
	stat.avgftb=avg.ftb()
	stat.avgdeath=avg.death()
	stat.countdeath=count.death
end
function always_watch.timer_log()
	if IsLogOpen() then CloseLog() end
	OpenLog("",false)
end
packets=0
function always_watch.timer30()
	if idle>0 and resetidle>0 then
		print("貌似发呆了")
		addlog("发呆了")
		if packets~=0 and packets==GetInfo(204) then
			Disconnect()
			Connect()
		end
		packets=GetInfo(204)
		--cmd.nums=0
		if not IsConnected() and (_G["notconnect"]==nil or _G["notconnect"]==0) then Connect()
		elseif IsConnected() then
			checkmove.NotGPSMove=1
			alias.initialize_trigger()
			if me.menpai=="em" then run("put fuling in yaodai") end
			if me.menpai=="bt" then run("convert she") end
			ftbnpckilled=0
			havefj=0
			fjzone=""
			fjroom=""
			fjarea=""
			fjroomid=0
			haveshizhe=0
			gpszeikou=""
			gold.id=""
			gold.begPlayerNum=-100
			alias.resetidle()
			alias.yjl()
			run("yun recover;yun regenerate")
			alias.startworkflow()
		end
	end
end
function always_watch.timer60()
	idle=1
end
function always_watch.timer1d()
	if cm.setmz~=nil and cm.setmz>0 then cm.fightmz=1 else cm.fightmz=0 end
end
function always_watch.dosomething1(n,l,w)
	local _f,_tb,_t,a,b,c,d,e
	if findstring(l,"你吃下一颗大还丹，只觉得体内真力源源滋生，过紫宫，入泥丸") then addneili.dahuandan=addneili.dahuandan+1 end
	if findstring(l,"你的内力增加了！！") then addneili.dazuo=addneili.dazuo+1 end
	a,b,c=string.find(l,"你的最大内力上升了(%d+)点。")
	if c~=nil then addneili.fj=addneili.fj+tonumber(c) end
	if findstring(l,"一个蒙面人向你走了过来，满身的杀气，看来似乎不是易与之辈。") then
		haveshizhe=1
		kill.dokill("shizhe","日月神教使者","shizhe")
	end
	if findstring(l,"你目前还没有任何为 rbt=start 的变量设定。") then
		if jifa.forcename=="xuanyinzhenqi" then _t="hbmz" else _t="" end
		if setting~=me.menpai.._t then
			--Execute("/alias.set"..me.menpai.._t.."()")
		end
		alias.startworkflow()
	end
	a,b,c,d=string.find(l,"[> ]*(.+) - (%w+)")
	if c~=nil and d~=nil then
		if isopen("gps_start") then
			checkmove.roomName=c
			checkmove.roomFirstEntrance=d
			checkmove.NotGPSMove=0
		else
			if d==checkmove.roomName and findstring(checkmove.roomFirstEntrance,e) then checkmove.NotGPSMove=0 else checkmove.NotGPSMove=1 end
		end
	end
	if findstring(l,"阿二正盯著你看，不知道打些什么主意。") then
		kill.dokill("er","阿二","fang")
	end
	if findstring(l,"方东白正盯著你看，不知道打些什么主意。") then
		kill.dokill("fang","方东白","fang")
	end
	if findstring(l,"阿三正盯著你看，不知道打些什么主意。") then
		kill.dokill("san","阿三","fang")
	end
	if findstring(l,"慢慢地一阵眩晕感传来，你终于又有了知觉....") then
		wait.make(function()
			if setting_resetidle>0 then resetidle=1 end
			if workflow.nowjob=="death" then
				workflow.nowjob=deathjob
				_f=function()
							openclass("watch_death")
							if me.menpai=="wd" and set_lifesave>0 then run("set check=lifesavehp") else alias.flytoid(deathroomno) end
					end
				wait.time(1);_f()
			else
				if workflow.nowjob=="lifesave" then
					workflow.nowjob=deathjob
					_f=function()
								openclass("watch_death")
								run("set check=lifesavehp")
						end
					wait.time(1);_f()
				else
					if not isopen("liaoshang") then
						alias.initialize_trigger()
						ftbnpckilled=0
						havefj=0
						haveshizhe=0
						alias.resetidle()
						alias.yjl()
						run("yun recover;yun regenerate")
						alias.startworkflow()
					end
				end
			end
		end)
	end
	if findstring(l,"一道闪电从天降下，直朝你劈去……结果没打中！") then openclass("quit") end
	if findstring(l,"一阵微风吹过，四面景致似乎起了些变化。") then buzhen=false end
	if findstring(l,"风云突变，时代变迁，你已经不是武林盟主了。") then cm.mengzhu=0 end
	if findstring(l,"向你躬身为礼，说道：盟主您老人家好！","向你齐声大喊：盟主万岁，万岁，万万岁！") then cm.mengzhu=1 end
	if findstring(l,"上的兵将再离开吧。") then run("dismiss") end
	if findstring(l,"你使不了那么多法轮。") then run("drop 1 lun") end
	if findstring(l,"你得到一只烤鸭。") then dropya=true end
	a,b,c=string.find(l,"一个.+弟子走了过来,对你报拳道：“在下奉(.+)之命，请你速回.+处晋见”。")
	if c~=nil and c==me.fjmasternick then
		fjcome=os.time()
		if fjend==nil then fjend=0 end
		fjwaittime=fjcome-fjend
		print("本次fj间隔时间"..fjwaittime)
	end
	a,b,c,d=string.find(l,"[> ]*(.+)说道:“辛苦你了，(.+)，你为本门立下了一功。”")
	if c~=nil and c==me.fjmaster and d~=nil and d==me.charname then
		fjend=os.time()
		arrstarttime=os.time()
	end
	if findstring(l,"酒袋已经被喝得一滴也不剩了。","酒袋里的清水喝得底朝天了。") then have.water=0 end
	if findstring(l,"随着一阵钻心的疼痛，你开始感到四肢发麻，蛇毒发作了！","你感到呼吸困难，麻木的感觉顺着四肢逐渐上行，蛇毒发作了！") then
		run("hp")
		if hp.healthjing<85 or me.menpai=="xx" then stat.havedu=1 end
	end
	if findstring(l,"你开始感到身体变得冰凉。","你的伤口发麻，全身僵直，不听使唤，这不是普通的蛇毒！","忽然一阵刺骨的奇寒袭来，你中的星宿掌毒发作了！") then
		run("hp")
		if hp.healthjing<85 or me.menpai=="xx" then stat.havedu=1 end
		--if me.menpai=="sl" then
		--	if hp.healthjing<85 then stat.havedu=1 end
		--else stat.havedu=1 end
	end
	if findstring(l,"没干完活儿就想溜，没门儿！") then
		alias.initialize_trigger()
		openclass("mp_dl")
		openclass("mp_dl_work")
		openclass("mp_dl_dowork")
		alias.uw()
		alias.wi("huachu")
	end
	if findstring(l,"你吃下一丸紫金通脉丹，只觉得头重脚轻，摇摇欲倒，原来服食太急太多，药效适得其反！","你将一丸紫金通脉丹放入口中，闭目凝神，待丹药完全融化，全身骨骼竟然发出啪啪的声响。") then
		alias.resetidle()
		cm.havebuff=1
		me.drugbusy=1
		AddTimer("drug_timer", 0, 0, 3600, "", timer_flag.Enabled + timer_flag.Replace, "always_watch.timer")
		AddTimer("drug_timer1", 0, 0, 3600, "", timer_flag.Enabled + timer_flag.Replace, "always_watch.timer1")
	end
	if findstring(l,"你吃下一颗大血藤，只觉得肝肠寸断，五脏欲裂，原来服食太多药物，药效适得其反！","你吃下一棵大血藤，顿时血气翻涌血脉膨胀，气力大长。") then
		stat.drugbusy=os.time()+720
		print("现在时间："..os.time().."  下次吃药时间："..stat.drugbusy)
		--me.drugbusy=1
		--AddTimer("drug_timer2", 0, 0, 720, "", timer_flag.Enabled + timer_flag.Replace, "always_watch.timer")
	end
	if findstring(l,"你小心翼翼地把一包金创药敷在伤口上") then
		stat.drugbusy=os.time()+30
		print("现在时间："..os.time().."  下次吃药时间："..stat.drugbusy)
		--me.drugbusy=1
		--AddTimer("drug_timer3", 0, 0, 30, "", timer_flag.Enabled + timer_flag.Replace, "always_watch.timer")
	end
	if findstring(l,"一个守关鬼卒手执剑戟来到你面前，伸手抓住你项上的「阴司路引」仔细检查着。") then alias.resetidle() end
	if findstring(l,"鬼卒对着你一瞪眼吼道：“你怎么还赖在这里？进去进去！”","地藏王菩萨念道：阿弥陀佛！","突然你感觉到好像有东西在背后对着你的脖子吹气！","但见阴天子把手一招，飘来了牛头马面，架起你就往内殿而去。") then
		alias.resetidle()
		if me.menpai=="wd" and set_lifesave>0 then run("yun lifesave") end
	end
	if findstring(l,"鬼卒将你的「阴司路引」收了起来，伸手指了指关门，好象是叫你进去。") then
		alias.resetidle()
		if me.menpai=="wd" and set_lifesave>0 then run("yun lifesave") end
		run("n;n")
	end
	if findstring(l,"鬼门关 - ") then
		alias.resetidle()
		stat.havedu=0
		if fjroomid==0 then deathroomno=roomno_now else deathroomno=fjroomid end
		-- #if %class( blockpk_start) {#add list.pk %concat( " 被杀死")}
		-- #additem DeathList {%concat( %time( yyyy-mm-dd hh:nn:ss), " Job=", @deathjob, %if( @deathjob=fj, %concat( " Room=", @fj.room, " Zone=", @fj.zone, " Roomno=", @fj.roomno, " NPC=", @fj.npc), %concat( " Room=", @deathroomno)))}
		local msg="死亡！！！ Job="..tostring(deathjob)
		if deathjob=="fj" then
			msg=msg.." Room="..tostring(fj.room).." Zone="..tostring(fj.zone).." Roomno="..tostring(fj.roomno).." NPC="..tostring(fj.npc)
		else
			msg=msg.." Room="..tostring(deathroomno)
		end
		addlog(msg)
		
		alias.initialize_trigger()
		--if jifa.forcename=="xuanyinzhenqi" then alias.jfhbmz() else Execute("/alias.jf"..me.menpai.."()") end
		run("jiajin basic;jiali 0")
		deathjob=workflow.nowjob
		workflow.nowjob="death"
		alias.checkexp("death")
		if me.menpai=="wd" and set_lifesave>0 then run("yun lifesave") end
	end
	if findstring(l,"江湖各大门派妄想进攻光明顶","一批正派弟子已经攻向了") then mj.haveyd=1 end
	if findstring(l,"我明教上下一心，终于成功打退那帮所谓名门正派的进攻") then mj.haveyd=0 end
	if findstring(l,"你觉得精气极为不足","你觉得气血严重淤塞","你觉得精神非常不振") then run("yun shougong") end
	if findstring(l,"坐着走？") then run("stand") end
	if findstring(l,"你只觉得“神门穴”上一阵酸麻") then stat.quiting=2 end
	if findstring(l,"只听得你一声大喝，拳风突然变得猛劲之极，身法却更加飘忽难测！") then alias.resetidle();stat.leidong=1 end
	if findstring(l,"你的眼前一黑，接著什么也不知道了....") then resetidle=0 end
	if findstring(l,"突然一股强大的力量将你推出秘洞。") then roomno_now=2058;alias.startcm() end
	if findstring(l,"你行大小二庄已久，又恢复了原有精气。") then stat.daxiao=0 end
	if findstring(l,"你屏息静气，交错运行大小二庄，只觉一股暖流出天门，穿地户，沿着全身经脉运行一周，汇入丹田气海。") then stat.daxiao=1 end
	if findstring(l,"你风云行功已久，略觉步履沉重了一些。") then stat.fengyun=0 end
	if findstring(l,"你暗运风云两庄，心思浮云飘空之悠闲缓慢，默想狂风荡地之迅速紧急，") then stat.fengyun=1 end
	if findstring(l,"你只觉得一阵头晕, 眼前只看见五彩斑斓的一片模糊, 原来你中的千蛛万毒手发作了!","你一阵摇晃, 猛提丹田之气却提不上来，结果险些摔倒.","只听你闷哼了一声, 后心已被") then stat.havedu=1 end
	if findstring(l,"一阵酸麻，血气不畅，顿时动弹不得！") then stat.haveyyz=1 end
	if findstring(l,"你见身边怪蛇的鳞片也逐渐恢复为银白色，不得不放慢『蟾蜍步法』。") then stat.heji=0 end
	if findstring(l,"你脚下施展『蟾蜍步法』口中唏嘘之声不断，只见你身边怪蛇身上鳞片发红，游走异常。") then stat.heji=1 end
	if findstring(l,"你的混天气功运行完毕，将内力收回丹田。") then stat.huntianup=0 end
	if findstring(l,"你微一凝神，运起混天气功，全身骨节发出一阵爆豆般的声响") then stat.huntianup=1 end
	if findstring(l,"你缓缓吸了一口气，将内劲收回丹田。") then stat.leidong=0 end
	if findstring(l,"你的龙象之力运行完毕，将内力收回丹田。") then stat.longxiang=0 end
	if findstring(l,"你口中默念大明六字真言，手结摩利支天愤怒印，运起") then stat.longxiang=1 end
	if findstring(l,"只见你的蛤蟆功运行完毕，将内力收回丹田。") then stat.powerup=0 end
	if findstring(l,"只见你蹲在地下，双手弯与肩齐，宛似一只大青蛙般作势相扑，口中发出老牛嘶鸣般的咕咕之声，时歇时作。") then stat.powerup=1 end
	if findstring(l,"你口中默念大明六字真言，手结摩利支天愤怒印，运起") then stat.longxiang=1 end
	if findstring(l,"你的经脉倒转运行完毕，经脉回复一如往常。") then stat.reverse=0 end
	if findstring(l,"只见你口中叫道「差尔刺呼，哈虎」，忽做头下脚上之形，双手撑地，蹦来蹦去。") then stat.reverse=1 end
	if findstring(l,"缓然收起混天气功将内力纳回丹田。") then stat.shengang=0 end
	if findstring(l,"你凝神默然运功，不一会手上的") then stat.shengang=1 end
	if findstring(l,"你所聚天地之精气已散回天地之间，你又恢复了原有精气。") then stat.tiandi=0 end
	if findstring(l,"你席地而坐，五心向天，运行天地二庄，益气升阳，益阴潜阳，升降反正，天地二气交泰于身，顿觉自己精气上限增加了。") then stat.tiandi=1 end
	if findstring(l,"你脸色转白，身上那股逼人的阴寒之气渐渐消失！") then stat.xuanyin=0 end
	if findstring(l,"只听你嘿嘿嘿几声奸笑，身法变得更加奇诡难测，接着双掌一划，丝丝白气自掌心冒出，") then stat.xuanyin=1 end
	if findstring(l,"你体内已积过多浊气，似乎领悟力又归于寻常。") then stat.zhixin=0 end
	if findstring(l,"你微一凝神，运动之心两庄，去浊气出体外，收清气入心中，只觉灵台清明，领悟力似乎有所增加。") then stat.zhixin=1 end
	if findstring(l,"你吐息呐气，将遍布全身的紫霞真气缓缓散去。") then stat.zixia=0 end
	if findstring(l,"你气凝丹田，运起紫霞神功，脸上紫气大盛。") then stat.zixia=1 end
	if findstring(l,"握在手中","取出白龙剑") then weapon_id=1 end
	if findstring(l,"你觉得自己的意识越来越弱，渐渐不省人事了。。。") then
		workflow.nowjob=deathjob
		resetidle=1
		wait.make(function()
			_f=function()
						openclass("watch_death")
						if me.menpai=="wd" and set_lifesave>0 then run("set check=lifesavehp") else alias.flytoid(deathroomno) end
				end
			wait.time(1);_f()
		end)
	end
	if findstring(l,"一股阴冷的浓雾突然出现，很快地包围了你。") then
		workflow.nowjob=deathjob
		resetidle=1
		if me.menpai=="dl" then run("drop pao")
		elseif me.menpai=="th" then run("drop robe")
		else run("drop cloth") end
		wait.make(function()
			_f=function()
				openclass("watch_death")
				if tonumber(deathroomno)>0 then alias.flytoid(deathroomno) else alias.startworkflow() end
			end
			wait.time(1);_f()
		end)
	end
	if findstring(l,"一股罡气自丹田涌出，直冲天灵，你痛得几乎晕死过去！") then
		workflow.nowjob="lifesave"
		openclass("watch_death")
	end
	if findstring(l,"你体内聚毒过多，难以继续提高。") then xx.needsandu=1 end
	if findstring(l,"看来该找机会逃跑了...") then
		alias.yjl()
		run("yun recover")
		wait.make(function()
			_f=function()
						run("halt;"..safego)
				end
			if not isopen("kill") then wait.time(1);_f() end
		end)
	end
end
------------------------------------------------------------------------------------
-- watch_death
------------------------------------------------------------------------------------
function watch_death.dosomething1(n,l,w)
	local a,b,c
	if findstring(l,"你目前还没有任何为 check=lifesavehp 的变量设定。") then
		if hp.healthjing<100 or hp.healthqi<100 then alias.flytonpc("俞岱岩") else run("set check=lifesaveover") end
	end
	if findstring(l,"有一天，你踩着七色云彩来迎娶『俞岱岩』") then
		if hp.healthjing<70 or hp.healthqi>49 then
			run("ask yu about 天王护心丹;fu dan")
		else
			run("ask yu about 白虎夺命丸;fu wan")
		end
		run("hp")
		alias.checkexp("death")
	end
	if findstring(l,"数码世界，数字地图，950就是这里！") then
		closeclass("watch_death")
		run("e;look")
		alias.startworkflow()
	end
	a,b,c=string.find(l,"数码世界，数字地图，(%d+)就是这里！")
	if c~=nil and tonumber(c)==deathroomno then
		run("halt;get all from corpse;get all from corpse 2;get all from corpse 3")
		if me.menpai=="dl" then run("drop pao")
		elseif me.menpai=="th" then run("drop robe")
		else run("drop cloth") end
		run("wear armor;wear all")
		if me.menpai=="em" or me.menpai=="bt" then run("put fuling in yaodai") end
		alias.flytoid(950)
	end
	if findstring(l,"你目前还没有任何为 checkexpover=death 的变量设定。") then
		alias.resetidle()
		run("set check=lifesaveover")
	end
	if findstring(l,"你目前还没有任何为 check=lifesaveover 的变量设定。") then
		workflow.nowjob=deathjob
		alias.flytoid(deathroomno)
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function always.update()
	local  always_daytime_triggerlist={
	       {name="always_daytime_dosth1",regexp="(太阳从东方的地平线升起了。|已经是午夜了。|傍晚了，太阳的馀晖将西方的天空映成一片火红。|东方的天空中开始出现一丝微曦。|已经是正午了，太阳从你正上方照耀著大地。|太阳开始从西方的天空中慢慢西沉。|夜晚降临了。|东方的天空已逐渐发白|东方的天空中开始出现一丝微曦。|太阳刚从东方的地平线升起|太阳正高挂在东方的天空中|太阳正高挂在西方的天空中|现在是正午时分，太阳高挂在你的头顶正上方|夜幕低垂，满天繁星|夜幕笼罩著大地|一轮火红的夕阳正徘徊在西方的地平线上|已经是午夜了。)",script=function(n,l,w,s)    always_daytime.dosomething1(n,l,w,s)  end,},
	}
	for k,v in pairs(always_daytime_triggerlist) do
		addtri(v.name,v.regexp,"always_daytime",v.script)
	end
	openclass("always_daytime")

	local  always_hp_triggerlist={
	       {name="always_hp_dosth1",regexp="\\s+经验增加：(\\d+)\\s+",script=function(n,l,w)    always_hp.dosomething1(n,l,w)  end,},
	       {name="always_hp_dosth2",regexp="\\s+钱庄盈余：(\\S+)两黄金",script=function(n,l,w)    always_hp.dosomething2(n,l,w)  end,},
	       {name="always_hp_dosth3",regexp="\\s+钱庄盈余：(亏空无余|很少)\\s+",script=function(n,l,w)    always_hp.dosomething3(n,l,w)  end,},
	       {name="always_hp_dosth4",regexp="^(> > > |> > |> |) 精神：\\s*(\\d+)\\s*/\\s*(\\d+)\\s*\\(\\s*(\\d+)%\\)\\s*精力：\\s*(\\d+)\\s*/\\s*(\\d+)\\s*\\(\\s*\\+\\s*(\\d+)\\)",script=function(n,l,w)    always_hp.dosomething4(n,l,w)  end,},
	       {name="always_hp_dosth5",regexp="^ 气血：\\s*(\\d+)\\s*/\\s*(\\d+)\\s*\\(\\s*(\\d+)%\\)\\s*内力：\\s*(\\S+)\\s*/\\s*(\\d+)\\s*\\(\\s*\\+\\s*(\\d+)\\)",script=function(n,l,w)    always_hp.dosomething5(n,l,w)  end,},
	       {name="always_hp_dosth6",regexp="^ 食物：\\s*(\\d+)\\s*/\\s*(\\d+)\\s*潜能：\\s*(\\S+)\\s*/\\s*(\\d+)\\s*",script=function(n,l,w)    always_hp.dosomething6(n,l,w)  end,},
	       {name="always_hp_dosth7",regexp="^ 饮水：\\s*(\\d+)\\s*/\\s*(\\d+)\\s*经验：\\s*(\\S+)\\s*",script=function(n,l,w)    always_hp.dosomething7(n,l,w)  end,},
	       {name="always_hp_dosth8",regexp="^│(心静如始|轩辕正气)：(\\d+)",script=function(n,l,w)    always_hp.dosomething8(n,l,w)  end,},
	       {name="always_hp_dosth14",regexp="^│妖魔孽气：(\\d+)",script=function(n,l,w)    always_hp.dosomething14(n,l,w)  end,},
		   {name="always_hp_dosth9",regexp="^│江湖门派：(\\S+)\\s+",script=function(n,l,w)    always_hp.dosomething9(n,l,w)  end,},
	       {name="always_hp_dosth10",regexp="^│授业师父：(\\S+)\\s+",script=function(n,l,w)    always_hp.dosomething10(n,l,w)  end,},
	       {name="always_hp_dosth11",regexp="^│退出限制：(\\S+)",script=function(n,l,w)    always_hp.dosomething11(n,l,w)  end,},
	       {name="always_hp_dosth12",regexp="^│性  别：(\\S+)人类",script=function(n,l,w)    always_hp.dosomething12(n,l,w)  end,},
	       {name="always_hp_dosth13",regexp="^│姓  名：(\\S+)\\s+",script=function(n,l,w)    always_hp.dosomething13(n,l,w)  end,},
	       {name="always_hp_dosth15",regexp="^│英文ID：(\\w+)\\s+",script=function(n,l,w)    always_hp.dosomething15(n,l,w)  end,},
	       {name="always_hp_dosth16",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    always_hp.dosomething16(n,l,w)  end,},
		   {name="always_hp_dosth17",regexp="\\s+在线时间：(\\S+)天",script=function(n,l,w)    always_hp.dosomething17(n,l,w)  end,},
	}
	for k,v in pairs(always_hp_triggerlist) do
		addtri(v.name,v.regexp,"always_hp",v.script)
	end
	openclass("always_hp")
	
	local  always_skills_triggerlist={
	       {name="always_skills_dosth1",regexp="\\s*臂力：\\s*(\\d+)/\\s*(\\d+)\\s*悟性：\\s*(\\d+)/\\s*(\\d+)",script=function(n,l,w)    always_skills.dosomething1(n,l,w)  end,},
	       {name="always_skills_dosth2",regexp="\\s*根骨：\\s*(\\d+)/\\s*(\\d+)\\s*身法：\\s*(\\d+)/\\s*(\\d+)",script=function(n,l,w)    always_skills.dosomething2(n,l,w)  end,},
	       {name="always_skills_dosth3",regexp="\\s*内功 \\(force\\)\\s*：\\s*(\\S+)\\s*有效等级：(\\d+)",script=function(n,l,w)    always_skills.dosomething3(n,l,w)  end,},
	       {name="always_skills_dosth4",regexp="^(> > > |> > |> |)你的「(基本内功|碧涛玄功|颠倒功|毒龙大法|光明圣火功|蛤蟆功|化功大法|混天气功|混元功|混元一气功|九阳神功|枯荣禅功|临济十二庄|龙象般若功|弥勒功|摩天云气|太极神功|太玄功|先天功|修龄要旨|玄门导引功|玄阴真气|玉女心经|紫霞功)」进步了！",script=function(n,l,w)    always_skills.dosomething4(n,l,w)  end,},
	       {name="always_skills_dosth5",regexp="^│(　|□)(\\S+)\\s*\\((\\S+)\\)\\s+-\\s*\\S+\\s*(\\d+)\\/\\s*(\\d+)",script=function(n,l,w)    always_skills.dosomething5(n,l,w)  end,},
	       {name="always_skills_dosth6",regexp="^(> > > |> > |> |)你目前所学过的技能：（共(\\S+)项技能）",script=function(n,l,w)    always_skills.dosomething6(n,l,w)  end,},
	}

	for k,v in pairs(always_skills_triggerlist) do
		addtri(v.name,v.regexp,"always_skills",v.script)
	end
	openclass("always_skills")
	
	_tb={
		"你开始感到身体变得冰凉。",
		"随着一阵钻心的疼痛，你开始感到四肢发麻，蛇毒发作了！",
		"风云突变，时代变迁，你已经不是武林盟主了。",
		"鬼门关 - ",
		"坐着走？",
		"你只觉得“神门穴”上一阵酸麻",
		"鬼卒对着你一瞪眼吼道：“你怎么还赖在这里？进去进去！”",
		"你吃下一颗大血藤，只觉得肝肠寸断，五脏欲裂，原来服食太多药物，药效适得其反！",
		"你吃下一棵大血藤，顿时血气翻涌血脉膨胀，气力大长。",
		"你小心翼翼地把一包金创药敷在伤口上",
		"你吃下一丸紫金通脉丹，只觉得头重脚轻，摇摇欲倒，原来服食太急太多，药效适得其反！",
		"你将一丸紫金通脉丹放入口中，闭目凝神，待丹药完全融化，全身骨骼竟然发出啪啪的声响。",
		"你的伤口发麻，全身僵直，不听使唤，这不是普通的蛇毒！",
		"你的眼前一黑，接著什么也不知道了....",
		"你放弃手中的.+，缓然收起混天气功将内力纳回丹田。",
		"你感到.+一阵酸麻，血气不畅，顿时动弹不得！",
		"你见身边怪蛇的鳞片也逐渐恢复为银白色，不得不放慢『蟾蜍步法』。",
		"你凝神默然运功，不一会手上的.+似乎发出淡淡光辉！",
		"你微一凝神，运起混天气功，全身骨节发出一阵爆豆般的声响",
		"一道闪电从天降下，直朝你劈去……结果没打中！",
		"只见你的蛤蟆功运行完毕，将内力收回丹田。",
		"你风云行功已久，略觉步履沉重了一些。",
		"你脚下施展『蟾蜍步法』口中唏嘘之声不断，只见你身边怪蛇身上鳞片发红，游走异常。",
		"你所聚天地之精气已散回天地之间，你又恢复了原有精气。",
		"你体内已积过多浊气，似乎领悟力又归于寻常。",
		"你行大小二庄已久，又恢复了原有精气。",
		".+向你躬身为礼，说道：盟主您老人家好！",
		".+向你齐声大喊：盟主万岁，万岁，万万岁！",
		"地藏王菩萨念道：阿弥陀佛！",
		"慢慢地一阵眩晕感传来，你终于又有了知觉....",
		"你暗运风云两庄，心思浮云飘空之悠闲缓慢，默想狂风荡地之迅速紧急，",
		"你的混天气功运行完毕，将内力收回丹田。",
		"你屏息静气，交错运行大小二庄，只觉一股暖流出天门，穿地户，沿着全身经脉运行一周，汇入丹田气海。",
		"你微一凝神，运动之心两庄，去浊气出体外，收清气入心中，只觉灵台清明，领悟力似乎有所增加。",
		"你席地而坐，五心向天，运行天地二庄，益气升阳，益阴潜阳，升降反正，天地二气交泰于身，顿觉自己精气上限增加了。",
		"突然一股强大的力量将你推出秘洞。",
		"忽然一阵刺骨的奇寒袭来，你中的星宿掌毒发作了！",
		"你蛇杖里的暗器准备好了。",
		"一股阴冷的浓雾突然出现，很快地包围了你。",
		"只听你嘿嘿嘿几声奸笑，身法变得更加奇诡难测，接着双掌一划，丝丝白气自掌心冒出，",
		"你得到一只烤鸭。",
		"鬼卒将你的「阴司路引」收了起来，伸手指了指关门，好象是叫你进去。",
		"你觉得自己的意识越来越弱，渐渐不省人事了。。。",
		"一个守关鬼卒手执剑戟来到你面前，伸手抓住你项上的「阴司路引」仔细检查着。",
		"只见你口中叫道「差尔刺呼，哈虎」，忽做头下脚上之形，双手撑地，蹦来蹦去。",
		"突然你感觉到好像有东西在背后对着你的脖子吹气！",
		"你只觉得一阵头晕, 眼前只看见五彩斑斓的一片模糊, 原来你中的千蛛万毒手发作了!",
		"你气凝丹田，运起紫霞神功，脸上紫气大盛。",
		"你吐息呐气，将遍布全身的紫霞真气缓缓散去。",
		"只听得你一声大喝，拳风突然变得猛劲之极，身法却更加飘忽难测！",
		".+江湖各大门派妄想进攻光明顶",".+一批正派弟子已经攻向了",
		".+我明教上下一心，终于成功打退那帮所谓名门正派的进攻",
		"你觉得精气极为不足","你觉得气血严重淤塞","你觉得精神非常不振",
		"但见阴天子把手一招，飘来了牛头马面，架起你就往内殿而去。",
		"你一阵摇晃, 猛提丹田之气却提不上来，结果险些摔倒.",
		"一阵微风吹过，四面景致似乎起了些变化。",
		"你脸色转白，身上那股逼人的阴寒之气渐渐消失！",
		"只见你蹲在地下，双手弯与肩齐，宛似一只大青蛙般作势相扑，口中发出老牛嘶鸣般的咕咕之声，时歇时作。",
		"(.+)说道:“辛苦你了，(.+)，你为本门立下了一功。”",
		".+酒袋已经被喝得一滴也不剩了。",
		"(.+) - (\\w+)",
		"看来该找机会逃跑了...",
		"你目前还没有任何为 rbt=start 的变量设定。",
		"一个蒙面人向你走了过来，满身的杀气，看来似乎不是易与之辈。",
		"一股罡气自丹田涌出，直冲天灵，你痛得几乎晕死过去！",
		"只听你闷哼了一声, 后心已被.+指力戳中.",
		"一个.+弟子走了过来,对你报拳道：“在下奉(.+)之命，请你速回.+处晋见”。",
		"你.+(握在手中|取出白龙剑)",
		"你吃下一颗大还丹，只觉得体内真力源源滋生，过紫宫，入泥丸",
		"你的经脉倒转运行完毕，经脉回复一如往常。",
		"你的龙象之力运行完毕，将内力收回丹田。",
		"你的内力增加了！！",
		"你的最大内力上升了(\\d+)点。",
		"你缓缓吸了一口气，将内劲收回丹田。",
		"你口中默念大明六字真言，手结摩利支天愤怒印，运起.+之力！",
		"你已经将.+酒袋里的清水喝得底朝天了。",
		"阿二正盯著你看，不知道打些什么主意。",
		"阿三正盯著你看，不知道打些什么主意。",
		"方东白正盯著你看，不知道打些什么主意。",
		"没干完活儿就想溜，没门儿！",
		"你使不了那么多法轮。",
		"你体内聚毒过多，难以继续提高。",
		"先解.+上的兵将再离开吧。",
	}
	local  always_watch_triggerlist={
	       {name="always_watch_dosth1",regexp=linktri(_tb),script=function(n,l,w)    always_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(always_watch_triggerlist) do
		addtri(v.name,v.regexp,"always_watch",v.script,v.line)
	end

	local noecho_trilist={
			"你目前还没有任何为 (.+) 的变量设定。",
			"你并未运用摩云心法。",
			"你现在很忙，停不下来。",
			}
	local _noechotri=linktri(noecho_trilist)

	addtri("always_watch_gag_dosth1",_noechotri,"always_watch","")
	SetTriggerOption("always_watch_gag_dosth1","omit_from_output",1)
	
	AddTimer("always_watch_timer10", 0, 0, 10, "", timer_flag.Enabled + timer_flag.Replace, "always_watch.timer10")
	SetTimerOption("always_watch_timer10", "group", "always_watch")
	AddTimer("always_watch_timer30", 0, 0, 30, "", timer_flag.Enabled + timer_flag.Replace, "always_watch.timer30")
	SetTimerOption("always_watch_timer30", "group", "always_watch")
	AddTimer("always_watch_timer60", 0, 1, 0, "", timer_flag.Enabled + timer_flag.Replace, "always_watch.timer60")
	SetTimerOption("always_watch_timer60", "group", "always_watch")
	AddTimer("always_watch_timer1", 1, 0, 0, "", timer_flag.Enabled + timer_flag.Replace, "always_watch.timer1d")
	SetTimerOption("always_watch_timer1", "group", "always_watch")
	for i=0,23,1 do
		AddTimer("always_watch_log_timer"..tostring(i), i, 0, 1, "", timer_flag.Enabled + timer_flag.Replace + timer_flag.AtTime, "always_watch.timer_log")
		SetTimerOption("always_watch_log_timer"..tostring(i), "group", "always_watch")
	end
	openclass("always_watch")
	
	_tb={
		"你目前还没有任何为 check=lifesavehp 的变量设定。",
		"有一天，你踩着七色云彩来迎娶『俞岱岩』",
		"数码世界，数字地图，950就是这里！",
		"数码世界，数字地图，(\\d+)就是这里！",
		"你目前还没有任何为 checkexpover=death 的变量设定。",
		"你目前还没有任何为 check=lifesaveover 的变量设定。",
	}
	local  watch_death_triggerlist={
	       {name="watch_death_dosth1",regexp=linktri(_tb),script=function(n,l,w)    watch_death.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(watch_death_triggerlist) do
		addtri(v.name,v.regexp,"watch_death",v.script,v.line)
	end
	AddTimer("watch_death_timer", 0, 0, 10, "", timer_flag.Enabled + timer_flag.Replace, "alias.resetidle")
	SetTimerOption("watch_death_timer", "group", "watch_death")
	closeclass("watch_death")
	
	AddAlias("alias_goto","goto (.*)","",alias_flag.Enabled + alias_flag.Replace+ alias_flag.RegularExpression ,"alias.goto")
	AddAlias("alias_fn","fn","",alias_flag.Enabled + alias_flag.Replace+ alias_flag.RegularExpression ,"alias.flytonext")

end
always.update()