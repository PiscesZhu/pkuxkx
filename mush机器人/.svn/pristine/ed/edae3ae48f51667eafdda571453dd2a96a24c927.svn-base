chongmai={}
chongmai_pre={}
chongmai_start={}
chongmai_watch={}

cm={
	mai=0,
	chong=0,
	havebuff=0,
	doing=0,
	mengzhu=0,
	setmz=0,
	fightmz=0,
	mzname="",
	mzdeath=0,
}
qugold={
	num=0,
	success=0,
}
------------------------------------------------------------------------------------
-- chongmai_pre
------------------------------------------------------------------------------------
function chongmai_pre.dosomething1(n,l,w)
	if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
		alias.setaoyao_tongmaidan()
		if (cm.mengzhu==0 and cm.havebuff==0 and have.gold<401 and me.gold>401 and daytime) then
			alias.flyto("钱庄") else run("set chongmai=start")
		end
	end
	if findstring(l,"你口念咒语『神马都是浮云,虾米都是尘土』，『钱庄』立马到达！") then
		alias.resetidle()
		qugold.num=aoyao.needgold-100*(aoyao.buyno-1)-have.gold+5
		run("qu "..tostring(qugold.num).." gold;set check=qugold")
	end
	if findstring(l,"掌柜的笑着说道：提取这么多钱，您怕是拿不动了。") then
		qugold.success=0
	end
	if findstring(l,"掌柜的点点头，从内屋里取出.+两黄金交到你手里。") then
		qugold.success=1
		have.gold=5
	end
	if findstring(l,"你目前还没有任何为 check=qugold 的变量设定。") then
		alias.resetidle()
		if qugold.success>0 then alias.startay()
		else
			qugold.num=qugold.num-100
			run("qu "..tostring(qugold.num).." gold;set check=qugold")
		end
	end
	if findstring(l,"你目前还没有任何为 aoyao=false 的变量设定。") then
		alias.resetidle()
		cm.havebuff=0
		alias.checkitems()
	end
	if findstring(l,"你目前还没有任何为 aoyao=true 的变量设定。") then
		alias.resetidle()
		run("fu dan;set chongmai=start")
	end
	if findstring(l,"穷光蛋，一边呆着去！") then
		alias.close_aoyao()
		alias.flyto("钱庄")
	end
	if findstring(l,"你目前还没有任何为 chongmai=start 的变量设定。") then
		closeclass("chongmai_pre")
		openclass("chongmai_start")
		alias.flytoid(me.chongmaiBaseid)
	end
end
------------------------------------------------------------------------------------
-- chongmai_start
------------------------------------------------------------------------------------
function chongmai_start.dosomething1(n,l,w)
	if findstring(l,"数码世界，数字地图，"..tostring(me.chongmaiBaseid).."就是这里！") then
		alias.resetidle()
		alias.dz(set_neili)
	end
	if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
		alias.resetidle()
		if havefj>0 then
			alias.uw()
			alias.startfj()
		elseif workflow.mp>0 and mpJobLimited==0 and me.menpai~="wd" then alias.startmp()
		else
			cm.doing=1
			run("yun chongmai")
		end
	end
	if findstring(l,"你感觉气息在.+运转受阻，急忙加大内力想要冲破这一关，结果受了点内伤。") then
		alias.resetidle()
		run("set cm"..tostring(cm.mai).." "..tostring(cm.chong))
		cm.doing=0
		alias.dz(set_neili)
	end
	if findstring(l,"你当前脉络已通") then
		alias.resetidle()
		cm.mai=cm.mai+1
		run("set cm"..tostring(cm.mai).." "..tostring(cm.chong))
		cm.doing=0
		alias.dz(set_neili)
	end
end
------------------------------------------------------------------------------------
-- chongmai_watch
------------------------------------------------------------------------------------
function chongmai_watch.dosomething1(n,l,w)
	local a,b,c
	if findstring(l,"设定环境变量：cm%d+ = %d+") then
		alias.resetidle()
	end
	a,b,c=string.find(l,"您目前 cm%d+ 的变量设定为： (%d+)")
	if tonumber(c)~=nil then
		alias.resetidle()
		cm.chong=tonumber(c)
	end
	if findstring(l,"你目前还没有任何为 cm%d+ 的变量设定。") then
		alias.resetidle()
		cm.chong=0
	end
	if findstring(l,"你内息运转到.+，顿时感觉无比轻松。","你体内不同内功激荡，内息运转到.*调理不是很畅通，但是也不是很严重。") then
		alias.resetidle()
		cm.chong=cm.chong+1
		alias.setmpLimitedMark()
	end
	a,b,c=string.find(l,"你将丹田之内的气息于游走于已通的(.+)脉中，准备百尺竿头更进一步。")
	if c~=nil then
		alias.resetidle()
		cm.mai=ctonum(c)
		run("set cm"..tostring(cm.mai))
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function chongmai.update()
	local  chongmai_pre_triggerlist={
	       {name="chongmai_pre_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    chongmai_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(chongmai_pre_triggerlist) do
		addtri(v.name,v.regexp,"chongmai_pre",v.script,v.line)
	end
	closeclass("chongmai_pre")
	
	local  chongmai_start_triggerlist={
	       {name="chongmai_start_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    chongmai_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(chongmai_start_triggerlist) do
		addtri(v.name,v.regexp,"chongmai_start",v.script,v.line)
	end
	closeclass("chongmai_start")
	
	local  chongmai_watch_triggerlist={
	       {name="chongmai_watch_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    chongmai_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(chongmai_watch_triggerlist) do
		addtri(v.name,v.regexp,"chongmai_watch",v.script,v.line)
	end
	closeclass("chongmai_watch")
end
chongmai.update()
