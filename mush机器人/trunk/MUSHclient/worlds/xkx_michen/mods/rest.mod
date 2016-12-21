---------------------------------------------------------------------------
-- File name   : rest.mod
-- Description : 此文件为《一个脚本框架》文件的恢复模块。
--				主要包含：打坐，吐纳，读书，修炼，拜祭模块。
-- Author: 胡小子littleknife (applehoo@126.com)
-- Version:	2011.11.27.0711
---------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
----***********************************************************************************----
----***********************************************************************************----
-------------------------------------------------------------------------------------------

_USE_help=[[
----condition::>> neili,curneili,curmaxneili
----		:>>;jingli,curjingli
-----use:
----do_dazuo("1250","neili","Execute('look')")
----do_dazuo("1250","neili","do_tuna('1150')")
----do_dazuo("1250","neili","tuna('main')()")

]]
OverFlow_dazuo=0
dazuo={
	--[[
	new=function()
		local _dazuo={}
		setmetatable(_dazuo,{__index=dazuo})
		return _dazuo
	end,--]]
	neili_limit=0,
	goal=1000,
	condition="neili",
}

do_dazuo=function(goal,condition,dazuo_ok,dazuo_fail)
	if dazuo_ok~=nil then
		dazuo.finish=function()
			dazuo_ok()
		end
	else dazuo.finish=nil end
	if dazuo_fail~=nil then
		dazuo.finish=function()
			dazuo_fail()
		end
	else dazuo.fail=nil end
	dazuo.goal=goal
	dazuo.condition=condition

	gethpvar()
	dazuo.start(goal,condition)
end
function dazuo:finish()
end

function dazuo:fail()
end

function dazuo.start()
	dazuo.update()
	local f=function() dazuo.check() end
	getjifa(f)
end

function dazuo.check()
	local f=function()
		OverFlow_dazuo=0
		DeleteTriggerGroup("q_dazuo")
		dazuo.finish()
	end
	local dzcmd=function() dazuo.cmd() end
	if OverFlow_dazuo==0 then
		checkitok("hp",dazuo.condition,dazuo.goal,f,dzcmd)
	else
		call(f)
	end
end

function dazuo.cmd()
--[[
	if me.hp["food"]<=0.5*me.hp["foodmax"] then
		run("eat liang")
	end
	if me.hp["water"]<=0.5*me.hp["watermax"] then
		run("drink jiudai")
	end
--]]
	if me.hp["qi"]<=0.85*me.hp["qimax"] and me.jifa["force"]["lv"]~=nil and me.jifa["force"]["lv"]>150 then
		run("yun recover")-------------DiscardQueue()会影响它
		----Execute("yun recover")
	end
	if me.hp["jing"]<=0.85*me.hp["jingmax"] then
		run("yun regenerate")
	end

	jifa_sklevel_force=tonumber(me.jifa["force"]["lv"])-1
	MaxNum_dazuo=2*tonumber(jifa_sklevel_force)*10
	SetVariable("dazuo_maxnum",MaxNum_dazuo)

	dazuonum=need_dznum(me.hp.qi,me.hp.qimax,me.hp.neili,me.hp.neilimax)
	dazuonum=math.ceil(math.min((tonumber(jifa_sklevel_force)*10/100+1)*2,dazuonum))
	if dazuonum < 10 then
		dazuonum = 10
	end
	run("dazuo "..tostring(dazuonum))
	local dzck=function() dazuo.check() end
	busytest(dzck)
end

dazuo.overflow=function()
	OverFlow_dazuo=1
end
function dazuo.update()
-----你的精力修为已经达到了瓶颈
	OverFlow_dazuo=0
	addtri("dz_overflow",".*你的内力修为似乎已经达到了瓶颈\\w*","q_dazuo","dazuo.overflow")
	EnableTriggerGroup("q_dazuo",1)
end
------------------------------------------------------------------------------------------------------------------------------
--AddAlias("alias_dazuo","#dazuo (.+)","",alias_flag.Enabled + alias_flag.Replace + alias_flag.RegularExpression,"dazuo.alias")
--AddAlias("alias_dazuostop","#dazuostop","",alias_flag.Enabled + alias_flag.Replace + alias_flag.RegularExpression,"dazuo.stop")
--AddAlias("alias_dazuocontinue","#dazuogo","",alias_flag.Enabled + alias_flag.Replace + alias_flag.RegularExpression,"dazuo.resume")
------------------------------------------------------------------------------------------------------------------------------
--SetAliasOption("alias_dazuo","group","dazuo")
--SetAliasOption("alias_dazuostop","group","dazuo")
--SetAliasOption("alias_dazuocontinue","group","dazuo")

--------------------Dazuo End-----------------------------------------
--------------------Tuna Start----------------------------------------
-----使用:
_USE_help=[[
----condition::>> neili,curneili,curmaxneili
----		:>>;jingli,curjingli
-----use:
----do_tuna("1250","neili","Execute('look')")
----do_tuna("1250","neili","do_tuna('1150')")
----do_tuna("1250","neili","tuna('main')()")

]]

OverFlow_tuna=0
tuna={
	new=function()
		local _tuna={}
		setmetatable(_tuna,{__index=tuna})
		return _tuna
	end,
	neili_limit=0,
	goal=1000,
	condition="jingli",
	isover=0,
}
tuna.alias=function(n,l,w)
	dz_str_tb=utils.split (w[1], ",")
	goal=dz_str_tb[1]
	condition=dz_str_tb[2]
	tuna_ok=dz_str_tb[3]
	tuna_fail=dz_str_tb[4]
	do_tuna(goal,condition,tuna_ok,tuna_fail)
end

do_tuna=function(goal,condition,tuna_ok,tuna_fail)
	local tmp_tuna=tuna.new()
	tmp_tuna.finish=tuna_ok
	tmp_tuna.fail=tuna_fail
	tmp_tuna.goal=goal
	tmp_tuna.condition=condition

	gethpvar()
	tmp_tuna:start(goal,condition)
end
function tuna:finish()
print("默认吐纳回调函数finish")
end

function tuna:fail()
print("默认吐纳回调函数fail")
end

function tuna:start()
	OverFlow_tuna=0
	self:update()
	local f=function() self:check() end
	getcha(f)
end

function tuna:check()
	local f=function()
	DeleteTriggerGroup("q_tuna")
	OverFlow_tuna=0
	self:finish()
	end
	local tncmd=function() self:cmd() end
	if OverFlow_tuna==0 then
	checkitok("hp",self.condition,self.goal,f,tncmd)
	else
	call(f)
	end
end

function tuna:cmd()

	skills_level_force=tonumber(me.skills["force"]["lv"])-1
	MaxNum_tuna=tonumber(skills_level_force)*15
	SetVariable("tuna_maxnum",MaxNum_tuna)

	--[[
	if me.hp["food"]<=0.5*me.hp["foodmax"] then
		run("eat liang")
	end
	if me.hp["water"]<=0.5*me.hp["watermax"] then
		run("drink jiudai")
	end
	--]]
	if me.hp["water"]<=0.5*me.hp["watermax"] and me.hp["food"]<=0.5*me.hp["foodmax"]  then
		run("get ji from he;drink ji;drink ji;drink ji;put ji in he")
	end
	if me.hp["qi"]<=0.85*me.hp["qimax"] then
		run("yun recover")
	end
	if me.hp["jing"]<=0.85*me.hp["jingmax"] then
		run("yun regenerate")
	end
	if me.hp["neili"]<=0.4*me.hp["neilimax"] then
		self:yunneili()
		return false
	end

	tunanum=need_dznum(me.hp.qi,me.hp.qimax,me.hp.neili,me.hp.neilimax)
	tunanum=math.min((tonumber(skills_level_force)*15/100+1)*2,tunanum)
	run("tuna "..tostring(tunanum))
	local dzck=function() self:check() end
	busytest(dzck)
end

function tuna:yunneili()
	EnableTriggerGroup("tuna",false)
	EnableTriggerGroup("dazuo",true)
	local dz=function() self:check() end
	do_dazuo("0.4","curmaxneili",dz,dz)
end
tuna.stop=function()
	Note("===已经手动停止吐纳！===")
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
end
tuna.resume=function()
	Note("===已经手动继续吐纳！===")
	EnableTriggerGroup("tuna",true)
	busytest(tuna["main"])
end
-----你的精力修为已经达到了瓶颈

tuna.overflow=function()
		OverFlow_tuna=1
end
function tuna:update()
-----你的精力修为已经达到了瓶颈
	OverFlow_tuna=0
	addtri("tn_overflow",".*你的.*修为已经达到了瓶颈\\w*","q_tuna","tuna.overflow")
	EnableTriggerGroup("q_tuna",1)
end
------------------------------------------------------------------------------------------------------------------------------
AddAlias("alias_tuna","#tuna (.+)","",alias_flag.Enabled + alias_flag.Replace + alias_flag.RegularExpression,"tuna.alias")
AddAlias("alias_tunastop","#tunastop","",alias_flag.Enabled + alias_flag.Replace,"tuna.stop")
AddAlias("alias_tunacontinue","#tunago","",alias_flag.Enabled + alias_flag.Replace ,"tuna.resume")

SetAliasOption("alias_tuna","group","tuna")
SetAliasOption("alias_tunastop","group","tuna")
SetAliasOption("alias_tunacontinue","group","tuna")

-----------------Tuna End--------------------------------------
function need_dznum(a,b,c,d)
--还有一种思路：有效内力的1/10打坐，认为效率最高。
--a-->qi,b-->maxqi,c-neili，d-maxneil，if neili
need =d*2+1-c
	if d<1000 then
		need=(need+1)/2
	end
qi_dz=a-(b+9)/10
need=(need*100+129)/100         --sudu=100
need=math.min(qi_dz,need)
need=math.ceil(math.max(need,10))
	if qi_dz<10 then
		--print("计算dz_qi:",qi_dz)
		--Send("l")
		return 10
	else
		return need
	end

end
-------------------------------------------------------------------------------------------
----***********************************************************************************----
----***********************************************************************************----
-------------------------------------------------------------------------------------------
xiulian={
	new=function()
		local _xiulian={}
		setmetatable(_xiulian,{__index=xiulian})
		return _xiulian
	end,
	interval=5,
	timeout=20,
	goal=1,
	skill="",
	sklevel=1,
	need_interrupt=0,
}

function xiulian:finish()
end

function xiulian:fail()
end

xiulian_alias=function(name, line, wildcards)
	do_xiulian(xiulian_ok,xiulian_fail)
end

do_xiulian=function(xiulian_ok,xiulian_fail)
	local tmp_xiulian=xiulian.new()
	tmp_xiulian.finish=xiulian_ok
	tmp_xiulian.fail=xiulian_fail
	tmp_xiulian:start()

end

function xiulian:start()
	local f=function() self:check() end
	getinfo(f)

end
function xiulian:check()
	force_cn=GetVariable("jifa_skname_force")
	max_level=math.ceil(math.pow(me.hp.exp*10,0.333333))+1
	for k,v in pairs(me.skills) do

		if v.name==force_cn then
			xlskill=k
			xllevel=v.lv
			print ("修炼的技能：",v.name,xlskill)
		end
	end
	self.skill=xlskill
	self.sklevel=xllevel

	local f=function() self:finish() end
	local e=function() self:run() end


	if self.skill==nil or self.sklevel>=max_level or Xiulian_Over==1 then
		print("修炼已经到达您经验所支持的最大值！")
		busytest(f)
		else
		if self.goal==1 then self.goal=max_level end
		checkitok("skills",self.skill,self.goal,f,e)
	end
end
function xiulian:run()
	run("xiulian "..self.skill)
	wait.make(function()
	local l,w=wait.regexp("^(> |)(你盘膝坐下，运起丹田之气，开始"..self.skill.."\\w*|你从玄幻之境回过神来，顿觉内功修为增进不小\\w*|你的潜能必须大于\\w*|由于缺乏实战经验，你无法领会更高深的武功\\w*)",5)
		if l==nil then
			self:run()
		return
		end
		if string.find(l,"你从玄幻之境回过神来") then
			if self.need_interrupt==1 then
			self:finish()
			return
			else
			self:check()
			end
		return
		end

		if string.find(l,"你的潜能必须大于") or string.find(l,"由于缺乏实战经验，你无法领会更高深的武功") then
		print("修炼结束，潜能或经验不足！")
		self:finish()
		return
		end
	end)

end

function xiulian:stop()
	Note("===已经手动停止修炼！===")
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
	self:finish()
end

------
AddAlias("alias_xiulian","#xiulian","",alias_flag.Enabled + alias_flag.Replace,"xiulian_alias")

SetAliasOption("alias_xiulian","group","job_xiulian")
---------------------------------------------------------------------
------------*******************************************************
---------------------------------------------------------------------
qxuexi={}

function qxuexi:finish()
end
function qxuexi:fail()
end

qxuexi.alias=function(n,l,w)
	xx_str_tb=utils.split (w[1], ",")

	npcid=xx_str_tb[1]
	xxskill=xx_str_tb[2]
	goal=xx_str_tb[3]
	xxtimes=xx_str_tb[4]

	qxuexi_ok=xx_str_tb[5]
	qxuexi_fail=xx_str_tb[6]

	do_qxuexi(npcid,xxskill,goal,xxtimes,qxuexi_ok,qxuexi_fail)
end


qxuexi.stop=function()
	Note("===已经手动停止学习！===")
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
end
qxuexi.resume=function()
	Note("===已经手动继续学习！===")
	EnableTriggerGroup("q_xuexi",true)
	busytest(qxuexi.main)
end

learn_num=1
case_learn=function()
	local skills=GetVariable("learnskill")
	skills=utils.split(skills,"|")
	--tprint(skills)
	if skills[learn_num]==nil then
		return nil
	end
	--print(skills[learn_num])
	return skills[learn_num]
end

do_qxuexi=function(npcid,xxskill,goal,xxtimes,qxuexi_ok,qxuexi_fail)
----npcid：学习目标id
----goal：条件目标：数字。
----xxskill：学习技能id
----xxtimes：学习次数

	if qxuexi_ok~=nil then
		qxuexi.finish=function()
			qxuexi_ok()
		end
	else qxuexi.finish=nil end
	if qxuexi_fail~=nil then
		qxuexi.finish=function()
			qxuexi_fail()
		end
	else qxuexi.fail=nil end
	
	qxuexi.finish=qxuexi_ok
	qxuexi.fail=qxuexi_fail
	learn_num=1
	qxuexi.update()
	if xxtimes==nil then xxtimes=50 end
	if xxskill==nil then xxskill=case_learn()  end
	qxuexi.times=xxtimes
	qxuexi.goal=goal
	qxuexi.npcid=npcid
	qxuexi.skill=xxskill

	EnableTriggerGroup("q_xuexi",true)
	call(qxuexi.main)
end
---------------------------------------------------
qxuexi.main=function()
	getinfo(qxuexi.check)
end
qxuexi.check=function()
	--[[
	if checkstatus("hp","foodstat","正常") then
		run("eat liang")
	end
	if checkstatus("hp","waterstat","正常") then
		run("drink jiudai")
	end
	--]]
	--[[
	if checkstatus("skills",qxuexi.skill,qxuexi.goal) then
		call(qxuexi.over)
	elseif checkstatus("hp","curmaxjing",0.6)==false then
		do_dazuo(0.6,"curmaxjing",qxuexi.cmd,qxuexi.cmd)
	else
		call(qxuexi.cmd)
	end
	--]]
	call(qxuexi.cmd)
end

qxuexi.cmd=function()
	run("xue "..qxuexi["npcid"].." "..qxuexi["skill"].." "..qxuexi["times"])
	--infoend(qxuexi.recover)
end
qxuexi.recover=function()
	run("yun regenerate")
end
qxuexi.cooltime=function()
	--call(qxuexi.main)
	busytest(qxuexi_end_fail)
end
----------------------------

qxuexi_end_ok=function()
	qxuexi.finish()
end
qxuexi_end_fail=function()
	qxuexi.fail()
end

qxuexi.update=function()
	addtri("qxuexi_cmd","^(> |)你深深吸了几口气，精神看起来好多了。","q_xuexi","qxuexi.cmd")
	addtri("qxuexi_main","^(> |)你的内力不够","q_xuexi","qxuexi.cooltime")
	addtri("qxuexi_recover","^(> |)你现在精神不佳，无法定下心来思考！","q_xuexi","qxuexi.recover")
	addtri("qxuexi_cmd2","^(> |)你现在精神饱满。$","q_xuexi","qxuexi.cmd")

	addtri("qxuexi_over","^(> |)(你没有这么多潜能。|不用潜能能学到东西吗？|你的潜能不够，没有办法再成长了。)","q_xuexi","qxuexi.over")
	addtri("qxuexi_over2","^(> > |> |)你的实战经验还不足，不能继续学习这项技能！|你的内功水平已无法借由学习提升。|你的技能水平已无法借由学习提升。|这项技能你恐怕必须找别人学了。|这项技能你的程度已经不输你师父了。|学化功大法，要心狠手辣，奸恶歹毒，你可做得不够呀！|嗯....(.+)支支吾吾地，看来不是做老师的料。","q_xuexi","qxuexi.chskill")

	addtri("qxuexi_omit3","^(> |)(你的请教不得不中止了。|(.+)教导完毕，见你若有所悟，会心地点了点头。)","q_xuexi","qxuexi.recover")
	--addtri("qxuexi_omit1","^[> ]*你向(.+)请教\\w*","q_xuexi","")
	--addtri("qxuexi_omit2","^[> ]*你共请教了.+次\\w*","q_xuexi","")
	----addtri("qxuexi_omit3","^[> ]*你听了.+的指导，似乎有些心得\\w*","q_xuexi","")

		--SetTriggerOption("qxuexi_omit1","omit_from_output",1)
		--SetTriggerOption("qxuexi_omit2","omit_from_output",1)
		--SetTriggerOption("qxuexi_omit3","omit_from_output",1)
		SetTriggerOption("qxuexi_cmd","omit_from_output",1)
		SetTriggerOption("qxuexi_cmd2","omit_from_output",1)

	trigrpon("q_xuexi")

	AddAlias("alias_qxuexistop","#xxstop","",alias_flag.Enabled + alias_flag.Replace ,"qxuexi.stop")
	SetAliasOption("alias_qxuexistop","group","q_xuexi")
end
---------------------------------------------------
qxuexi.chskill=function()
	learn_num=learn_num+1
	qxuexi["skill"]=case_learn()
	if qxuexi["skill"]==nil then
		qxuexi.over()
	else
		qxuexi.cmd()
	end
end
qxuexi.over=function()
	print("学习结束，潜能或经验不足！")
	busytest(qxuexi_end_ok)
end
----------------------------------------------------------------
qxuexi.loop=function()
	busytest(qxuexi.loopcmd)
end

qxuexi.loopcmd=function()
	do_qxuexi(qxuexi.npcid,qxuexi.skill,qxuexi.goal,qxuexi.times,qxuexi.loop,qxuexi.loop)
end
----------------------------------------------

qxuexi_end_ok=function()
	EnableTriggerGroup("q_xuexi",0)
	DiscardQueue()
	DeleteTemporaryTimers()
	qxuexi.finish()
	--qxuexi["end"]("ok")
end

qxuexi_end_fail=function()
	EnableTriggerGroup("q_xuexi",0)
	DiscardQueue()
	DeleteTemporaryTimers()
	qxuexi.fail()
	--qxuexi["end"]("fail")
end

AddAlias("alias_qxuexi","#xuexi (.+)","",alias_flag.Enabled + alias_flag.Replace + alias_flag.RegularExpression,"qxuexi.alias")

SetAliasOption("alias_qxuexi","group","job_xuexi")
-------------------------------------------------------
-------------------------------------------------------


dubook={}
dubook["ok"]=nil
dubook["fail"]=nil

do_dubook=function(bookid,skillid,goal,bktimes,dubook_ok,dubook_fail)
	dubook["ok"]=dubook_ok
	dubook["fail"]=dubook_fail
	---if skname==nil then skname=100000 end
	if goal==nil then goal=10000 end
	if bktimes==nil then bktimes=100 end
	dubook.bookid=bookid
	dubook.skillid=skillid
	dubook.goal=goal
	dubook.times=bktimes
	dubook.update()
	EnableTriggerGroup("q_dubook",1)
	if dubook_ok==nil then dubook["ok"]=dubook.loop end
	if dubook_fail==nil then dubook["fail"]=dubook.loop end

	getinfo(dubook.main)
end

dubook.main=function()
	if checkstatus("skills",dubook.skillid,dubook.goal) then
		call(dubook.over)
	else
		call(dubook.cmd)
	end --if
end

dubook.cmd=function()
	run("study "..dubook.bookid.." "..dubook.times)
end

dubook.cooltime=function()
	DeleteTemporaryTimers()
	run("skills")
	call(dubook.sleep)
end

dubook.recover=function()
	run("yun regenerate")
end
dubook.sleep=function()
	run("sleep")
end
dubook.sleepback=function()
	run("l;cha")
	call(dubook.main)
end

dubook.over=function()
	call(dubook_end_ok)
end
----------------------------------------------------------------
dubook.loop=function()
	busytest(dubook.loopcmd)
end

dubook.loopcmd=function()
	do_dubook(dubook.bookid,dubook.skill,dubook.goal,dubook.times,dubook.loop,dubook.loop)
end
----------------------------------------------

dubook.update=function()
triglist=[[

你的「读书写字」进步了！
你从身上拿出一本说文解字准备好好研读。
你现在过于疲倦，无法专心下来研读新知。
你研读了六次有关读书写字的技巧，似乎有点心得。

]]
addtri("qdubook_recover","^(> >|> |)你研读完毕，把(.+)收了起来。$", "q_dubook","dubook.recover")

addtri("qdubook_cmd","^(> >|> |)(你深深吸了几口气，精神看起来好多了。|你现在精神饱满。)$","q_dubook","dubook.cmd")
addtri("qdubook_slback","^(> >|> |)你一觉醒来，只觉精力充沛。该活动一下了。$","q_dubook","dubook.sleepback")

addtri("qdubook_cooltime","^(> >|> |)你的内力不够。$","q_dubook","dubook.cooltime")

end



dubook["end"]=function(s)
EnableTriggerGroup("q_dubook",0)
	if ((s~="")and(s~=nil)) then
		call(dubook[s])
	end
	dubook["ok"]=nil
	dubook["fail"]=nil
end

dubook_end_ok=function()
	dubook["end"]("ok")
end

dubook_end_fail=function()
	dubook["end"]("fail")
end
----------------------------------------------------------------------
----------------------------------------------------------------------
baiji={

	new=function()
	local _baiji={}
		setmetatable(_baiji,{__index=baiji})
		return _baiji
	end,
	timeout=10,
}
function baiji:finish()
print("::拜祭回调函数::")
end
function baiji:fail()
end


alias_baiji=function(n,l,w)
	do_baiji(baiji_ok,baiji_fail)
end


do_baiji=function(baiji_ok,baiji_fail)
	local tmp_baiji=baiji.new()
	tmp_baiji.finish=baiji_ok
	tmp_baiji.fail=baiji_fail
	tmp_baiji:start()
end

function baiji:start()
	self:update()
run("baiji xiang 50;set no_more baiji")
	wait.make(function()
	local l,w=wait.regexp('^(> |)(你的精不够，无法继续拜祭|你的内力不够|设定环境变量：no_more = "baiji"$)',self.timeout) --超时
		----print("l=",l)
		wait.time(0.2)
		if l==nil then
		self:start()
		return
		end
		if string.find(l,"你的精不够") then
		run("yun regenerate")
		self:start()
		return
		end
		if string.find(l,"你的内力不够") then
		print("::内力不够::")
		run("hp;cha")
		run("eat liang;drink jiudai")
		wait.time(0.4)
			if checkstatus("skills","literate",501) then
				print("拜祭结束，达到读写目标500lv！！")
				self:finish()-------------????
				return
				elseif checkstatus("hp","curmaxjingli",0.9)==false then
					local f=function()		self:start()	end
						run("yun regenerate")
				do_dazuo(0.9,"curmaxjingli",f,f)
				return
			end
			self:start()
			return
		end

		if string.find(l,'设定环境变量：no_more = "baiji"') then
		----print("::开始拜祭！！::")
		wait.time(0.1)
		self:start()
		return
		end
		print(":::EndHere::::")
	wait.time(self.timeout)
	end)
end

AddAlias("alias_baiji","#baiji","",alias_flag.Enabled + alias_flag.Replace ,"alias_baiji")

SetAliasOption("alias_baiji","group","job_baiji")

function baiji:update()
	baiji_tri={

	"你对着孔子像拜了下去。",
	"你对着孔子像拜祭之后，突然福至心灵，对论语中的道理有所领悟。",
	"你的精不够，无法继续拜祭",
	"你的内力不够",
	"你现在精力充沛",
	}

	baiji_regexp=linktri(baiji_tri)


	addtri("qbaiji_set",'^(> |)\\s*设定环境变量：no_more = "baiji"$',"q_baiji","")
	addtri("qbaiji_noecho",baiji_regexp,"q_baiji","")

	SetTriggerOption("qbaiji_set","omit_from_output",1)
	SetTriggerOption("qbaiji_noecho","omit_from_output",1)
	SetTriggerOption("qbaiji_noecho","sequence","20")
	SetTriggerOption("qbaiji_set","sequence","20")

	EnableTriggerGroup("q_baiji",1)

end

dushibi={
	new=function()
		local _dushibi={}
		setmetatable(_dushibi,{__index=dushibi})
		return _dushibi
	end,
	interval=5,
	timeout=20,
}

function dushibi:finish()
end

function dushibi:fail()
end

dushibi_alias=function(name, line, wildcards)
	do_dushibi(dushibi_ok,dushibi_fail)
end

do_dushibi=function(dushibi_ok,dushibi_fail)
	local tmp_dushibi=dushibi.new()
	tmp_dushibi.finish=dushibi_ok
	tmp_dushibi.fail=dushibi_fail
	tmp_dushibi:start()

end

function dushibi:start()
	self:update()
	local f=function() self:check() end
	getinfo(f)
end

function dushibi:check()
	local f=function() self:main() end
	local e=function()
		do_dazuo(0.3,"curmaxneili",f,f)
	end

	checkitok("hp","curmaxneili",0.4,f,e)
end

function dushibi:cooltime()
end

function dushibi:main()
	run("watch 石壁 50;yun regenerate")
	wait.make(function()

	local l,w=wait.regexp(".*壁上绘的是个白须老者，手中拿着一本医书。|.*你已经累了，还是休息一会吧|.*你略一凝神，精神看起来好多了|.*你内力不足，无法依照石壁内容行功参悟。\\w*|.*你的内力不够\\w*",5)
		if l==nil then
		self:main()
		return
		end
	 if string.find(l,"手中拿着一本医书。") then
	 print("::read shibi::")
	 run("watch 石壁 500")
		self:main()
		return
	 end
	 if string.find(l,"你已经累了，还是休息一会吧。") then
		run("yun regenerate")
		self:main()
		return
	 end
	if string.find(l,"你略一凝神，精神看起来好多了。") then
	 	self:main()
		return
		end
	if string.find(l,"你内力不足") or  string.find(l,"你的内力不够") then
		self:check()
		return
	end
	self:main()
	wait.time(5)
	end)
end

function dushibi:update()

	local noecho_trilist={
	"你已经累了，还是休息一会吧。",
	"你现在精力充沛。",
	"你现在精力充沛。",
	"你正专心观看石壁。",
			}
	local _noechotri=linktri(noecho_trilist)

	addtri("dushibi_noecho",_noechotri,"q_dushibi","")
	SetTriggerOption("dushibi_noecho","omit_from_output",1)
	EnableTriggerGroup("q_dushibi",1)

end

AddAlias("alias_dushibi","#dusb","",alias_flag.Enabled + alias_flag.Replace,"dushibi_alias")
SetAliasOption("alias_dushibi","group","job_dushibi")

----------------------------------------------------------------------
----------------------------------------------------------------------

ldpsay={}
ldpsay["ok"]=nil
ldpsay["fail"]=nil
ldpsay.failsay=false

go_cs_ldp=function()
	local cs2ldp="w;w;w;w;w;w;nw;w;w;w;nw;w;sw;w;sw;w;s;sw;su;w;sw;w;wu;wu;w;wu;wu;wu;wu;nw;nw;nu;wu;wu;sw;sw;wu;su;wu;wu;wu;su;su"
	run(cs2ldp)
end
go_ldp_cs=function()
	local ldp2cs="nd;nd;ed;ed;ed;nd;ed;ne;ne;ed;ed;sd;se;se;ed;ed;ed;ed;e;ed;ed;e;ne;e;nd;ne;n;e;ne;e;ne;e;se;e;e;e;se;e;e;e;e;e;e"
	run(ldp2cs)
end
do_ldpsay=function(goal,ldpsay_ok,ldpsay_fail)
	ldpsay["ok"]=ldpsay_ok
	ldpsay["fail"]=ldpsay_fail
	if goal==nil then goal=47 end
	ldpsay.skillid="force"
	ldpsay.goal=goal
	ldpsay.failsay=false
	ldpsay.update()
	EnableTriggerGroup("q_ldpsay",1)
	if ldpsay_ok==nil then ldpsay["ok"]=ldpsay.loop end
	if ldpsay_fail==nil then ldpsay["fail"]=ldpsay.loop end

	getinfo(ldpsay.main)
end

ldpsay.main=function()
	if checkstatus("skills",ldpsay.skillid,ldpsay.goal) then
		call(ldpsay.over)
	else
		gethp(ldpsay.cmd)
	end --if
end

ldpsay.cmd=function()
	if ldpsay.failsay then
		ldpsay.failsay=false
		run("yun refresh;e;w")
		gethp(ldpsay.cmd)
		return
	end
	if me.hp["jing"]<=(me.hp["jingmax"]*2/5) then
		if me.hp["neili"] >=10 then
			run("yun regenerate")
		else
			busytest(ldpsay.gosleep)
			return
		end
	end
	if me.hp["qi"]>(me.hp["qimax"]*2/5) then
		run("say")
	else
		if me.hp["neili"] >=10 then
			run("yun recover")
		else
			busytest(ldpsay.gosleep)
			return
		end
	end
	gethp(ldpsay.cmd)
end
--#TRIGGER {精神：%s(%d)/%s(%d) } {jinga=%1;jingb=%2;#math jingc @jingb*2/5;#if (@jinga>@jingc) {#t- jing;#t+ qi} {yun regenerate;hp}}
--#TRIGGER {气血：%s(%d)/%s(%d)} {qia=%1;qib=%2;#math qic @qib*2/5;#if (@qia>@qic) {say} {yun recover}}

ldpsay.gosleep=function()
	--local ldp2xxs="nd;nd;ed;ed;ed;nd;ed;ne;ne;ed;ed;sd;se;se;ed;ed;ed;ed;e;ed;ed;e;ne;e;nd;ne;n;e;ne;se;se;s;s;s;su;sd;s;e;e;e;e;e;e;ne;ne;ne;e;e;e;e;s;sw;w;w;w;w;w;w"
	local ldp2xxs="nd;nd;ed;ed;ed;nd;ed;ne;ne;ed;ed;sd;se;se;ed;ed;ed;ed;e;ed;ed;e;ne;enter;w"
	run(ldp2xxs)
	run("sleep")
end
ldpsay.over=function()
	call(ldpsay_end_ok)
end
----------------------------------------------------------------
ldpsay.loop=function()
	busytest(ldpsay.loopcmd)
end

ldpsay.loopcmd=function()
	do_ldpsay(dubook.goal,ldpsay.loop,ldpsay.loop)
end
----------------------------------------------
ldpsay.failsay=function(n,l,w)
	ldpsay.failsay=true
end
ldpsay.wakeup=function(n,l,w)
	--local xxs2ldp="e;e;e;e;e;e;n;e;n;w;w;w;w;sw;sw;sw;w;w;w;w;w;w;n;nu;nd;n;n;n;nw;nw;sw;w;s;sw;su;w;sw;w;wu;wu;w;wu;wu;wu;wu;nw;nw;nu;wu;wu;sw;sw;wu;su;wu;wu;wu;su;su"
	local xxs2ldp="e;out;sw;w;wu;wu;w;wu;wu;wu;wu;nw;nw;nu;wu;wu;sw;sw;wu;su;wu;wu;wu;su;su"
	run(xxs2ldp)
	getinfo(ldpsay.main)
end

ldpsay.update=function()
	
	addtri("ldpsay_failsay","^(> |)你自言自语不知道在说些什么","q_ldpsay","ldpsay.failsay")
	addtri("ldpsay_wakeup","^(> |)你一觉醒来，只觉精力充沛。该活动一下了","q_ldpsay","ldpsay.wakeup")
end



ldpsay["end"]=function(s)
	EnableTriggerGroup("q_ldpsay",0)
	if ((s~="")and(s~=nil)) then
		call(ldpsay[s])
	end
	ldpsay["ok"]=nil
	ldpsay["fail"]=nil
end

ldpsay_end_ok=function()
	ldpsay["end"]("ok")
end

ldpsay_end_fail=function()
	ldpsay["end"]("fail")
end
----------------------------------------------------------------------
----------------------------------------------------------------------

----------------------------------------------------------------------
-- 领悟模块开始
----------------------------------------------------------------------
qlw={}

function qlw:finish()
end
function qlw:fail()
end

qlw.end_ok=function()
	trigrpoff("q_lw")
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
	qlw.finish()
end
qlw.end_fail=function()
	trigrpoff("q_lw")
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
	qlw.fail()
end

function do_lw(job_ok,job_fail)
	if job_ok~=nil then
		qlw.finish=function()
			job_ok()
		end
	else qlw.finish=nil end
	if job_fail~=nil then
		qlw.fail=function()
			job_fail()
		end
	else qlw.fail=nil end
	lingwu_num=1
	qlw.skill=case_lingwu() 
	qlw.update()
	trigrpon("q_lw")
	me.canjob=false
	qlw.start()
end

function qlw.start()
	gethp(qlw.check)
end

function qlw.check()
	if me.canjob==true then
		me.canjob=false
		qlw.end_ok()
		return
	end
	if me.hp["qi_percent"]<100 then
		run("yun heal")
		busytest(qlw.start)
		return
	end
	if me.hp["neili"]<(me.hp["neilimax"]*1.2) then
		do_dazuo(me.hp["neilimax"]*1.75, "neili", qlw.start, qlw.start)
		return		
	end
	if me.hp["jing"]<=(me.hp["jingmax"]*2/3) then
		run("yun regenerate")
	end
	if me.hp["jingli"]<=(me.hp["jinglimax"]*2/3) then
		run("yun refresh")
	end
	busytest(qlw.cmd)
end

function qlw.cmd()
	local msg_tri={
		"此地无什特别之处，有什么好领悟的？",
		
		"你现在正忙着呢。",
		"你已经在战斗中了，学一点实战经验吧。",
		
		"你只能参悟本派的武功。",
		"你不能自行修炼基本内功！",
		"你必须有特殊武功方能与基本武技参照领悟！",
		"你对这方面的技能还是一窍不通，最好从先从基本学起。",
		"你好像还没有学过这项基本技能吧？ 最好先去请教别人。",
		".+还没到可以自己领悟的境界！",
		"你的实战经验还不足，不能继续领悟这项技能！",
		".+造诣不够，无法领悟更深一层的",
		
		"你现在精神不佳，无法定下心来思考！",
		
		"你没有这么多潜能。",
		"你深思着所学的",
	}

	local _ftri=linktri(msg_tri)
	if qlw.skill==nil then
		qlw.end_ok()
		return
	end
	run("lingwu "..qlw.skill.." 20")
	wait.make(function()
		local l,w=wait.regexp(_ftri,2)
		if l==nil then
			qlw.cmd()
			return
		end
		if findstring(l,msg_tri[1]) then
			qlw.end_fail()
			return
		end
		if findstring(l,msg_tri[12]) then
			run("yun regenerate")
			qlw.start()
			return
		end
		if findstring(l,msg_tri[13]) then
			qlw.end_ok()
			return
		end
		if findstring(l,msg_tri[2],msg_tri[3]) then
			busytest(qlw.cmd)
			return
		end
		if findstring(l,msg_tri[4],msg_tri[5],msg_tri[6],msg_tri[7],msg_tri[8],msg_tri[9],msg_tri[10]) then
			lingwu_num=lingwu_num+1
			qlw.skill=case_lingwu() 
			busytest(qlw.cmd)
			return
		end
		if findstring(l,msg_tri[11]) then
			do_lian(qlw.start,qlw.start)
			return
		end
		if findstring(l,msg_tri[14]) then
			-- OK
			return
		end
	end)
end

function qlw.over()
	run("yun regenerate")
	busytest(qlw.start)
end

lingwu_num=1
case_lingwu=function()
	local skills=GetVariable("lingwuskill")
	skills=utils.split(skills,"|")
	if skills[lingwu_num]==nil then
		return nil
	end
	return skills[lingwu_num]
end

function qlw.update()
	addtri("qlw_lian","^(> |)你领悟完毕，拍拍衣袖站起身来。","q_lw","qlw.over")
end
----------------------------------------------------------------------
-- 领悟模块结束
----------------------------------------------------------------------

----------------------------------------------------------------------
-- 练技能模块开始
----------------------------------------------------------------------
qlian={}

function qlian:finish()
end
function qlian:fail()
end

qlian.end_ok=function()
	trigrpoff("q_lian")
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
	qlian.finish()
end
qlian.end_fail=function()
	trigrpoff("q_lian")
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
	qlian.fail()
end

function do_lian(job_ok,job_fail)
	if job_ok~=nil then
		qlian.finish=function()
			job_ok()
		end
	else qlian.finish=nil end
	if job_fail~=nil then
		qlian.fail=function()
			job_fail()
		end
	else qlian.fail=nil end
	qlian.skill=case_lingwu() 
	if qlian.skill=="whip" then
		qlian.weapon="bian"
	else
		qlian.weapon=qlian.skill
	end
	qlian.update()
	trigrpon("q_lian")
	me.canjob=false
	qlian.start()
end

function qlian.start()
	gethp(qlian.check)
end

function qlian.check()
	if me.canjob==true then
		me.canjob=false
		qlian.end_ok()
		return
	end
	if me.hp["qi_percent"]<100 then
		run("yun heal")
		busytest(qlian.start)
		return
	end
	if me.hp["neili"]<(me.hp["neilimax"]*1.2) then
		do_dazuo(me.hp["neilimax"]*1.75, "neili",qlian.start,qlian.start)
		return		
	end
	if me.hp["jing"]<=(me.hp["jingmax"]*2/3) then
		run("yun regenerate")
	end
	if me.hp["jingli"]<=(me.hp["jinglimax"]*2/3) then
		run("yun refresh")
	end
	busytest(qlian.cmd)
end

function qlian.cmd()
	local msg_tri={
		"这里不是练功的地方。",
		"你还是专心拱猪吧！",
		
		"你现在正忙着呢。",
		
		"你不能通过练习招架来提高这项技能。",
		"你只能练习用 enable 指定的特殊技能。",
		"你好像还没有学过这项技能吧？最好先去请教别人。",
		"你对这方面的技能还是一窍不通，最好从先从基本学起。",
		"你的基本功火候未到，必须先打好基础才能继续提高。",
		".+已经练习到顶峰了，必须先打好基础才能继续提高。",
		"你现在不能练习这项技能。",
		
		"你盘膝坐下，开始修习",
		".+，开始练习",
		
		"你使用的武器不对。",
		
	}

	local _ftri=linktri(msg_tri)
	if qlian.skill==nil then
		qlian.end_ok()
		return
	end
	run("wield "..qlian.weapon)
	run("lian "..qlian.skill.." 20")
	wait.make(function()
		local l,w=wait.regexp(_ftri,2)
		if l==nil then
			qlian.cmd()
			return
		end
		if findstring(l,msg_tri[1],msg_tri[2]) then
			qlian.end_fail()
			return
		end
		if findstring(l,msg_tri[3]) then
			busytest(qlian.cmd)
			return
		end
		if findstring(l,msg_tri[4],msg_tri[5],msg_tri[6],msg_tri[7],msg_tri[8],msg_tri[9],msg_tri[10],msg_tri[13]) then
			lingwu_num=lingwu_num+1
			qlian.end_ok()
			return
		end
		if findstring(l,msg_tri[11],msg_tri[12]) then
			-- OK
			return
		end
	end)
end

function qlian.over()
	run("unwield "..qlian.weapon)
	run("yun refresh")
	busytest(qlian.start)
end

function qlian.update()
	addtri("qlian_over","^(> |)你修习完毕，深深吸了一口气，闭目而(坐|立)。","q_lian","qlian.over")
end
----------------------------------------------------------------------
-- 练技能模块结束
----------------------------------------------------------------------
