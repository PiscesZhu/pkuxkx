qzwd={}
qzwd_pre={}
qzwd_start={}
qzwd_watch={}

pobi=0
zhizhulist=""
zhizhunum=1
------------------------------------------------------------------------------------
-- qzwd_pre
------------------------------------------------------------------------------------
function qzwd_pre.dosomething1(n,l,w)
	local _f,_tb
	if findstring(l,"目标地点路径未通！flytoid=1519","目标地点路径未通！flytoid=705") then
		run("u;u;break men;n;n")
	end
	if findstring(l,"很明显, 毒蜘蛛现在没法干这") then
		run("xiulian")
	end
	if findstring(l,"你目前还没有任何为 busyover=qzwd 的变量设定。","你目前还没有任何为 checkbusy=qzwd 的变量设定。","数码世界，数字地图，705就是这里！") then
		openclass("dazuo")
		run("dazuo 10")
	end
	if findstring(l,"你目前还没有任何为 checkpobi 的变量设定。") then
		if pobi>0 then
			run("wield jian;strike wall;enter;zhua zhizhu;strike wall;out")
			pobi=0
		else
			for i=1,10,1 do run("mianbi") end
			run("set checkpobi")
		end
	end
	if findstring(l,"请输入正确的房间") then
		print("没蜘蛛了")
		run("shout")
		alias.close_gps()
		alias.startxue()
	end
	if findstring(l,"你目前还没有任何为 qzwd=start 的变量设定。") then
		openclass("qzwd_start")
		run("xiulian")
	end
	if findstring(l,"你得找些毒蜘蛛来才能练千蛛万毒手。") then
		alias.ch()
		wait.make(function()
			_f=function()
						if skillslist["qianzhu-wandu"]==nil then skillslist["qianzhu-wandu"]={} end
						if skillslist["qianzhu-wandu"]["lvl"]==nil then skillslist["qianzhu-wandu"]["lvl"]=0 end
						if skillslist["zhaixinggong"]==nil then skillslist["zhaixinggong"]={} end
						if skillslist["zhaixinggong"]["lvl"]==nil then skillslist["zhaixinggong"]["lvl"]=0 end
						if skillslist["qianzhu-wandu"]["lvl"]<80 then
							zhizhulist="1349|1440|1324|1325|1367|2051|45|1519"
						elseif skillslist["qianzhu-wandu"]["lvl"]<150 then
							if skillslist["zhaixinggong"]["lvl"]>100 then
								zhizhulist="896|1153|1431|1349|1440|1324|1325|1367|2051|45|1519"
							else
								zhizhulist="896|1153|1349|1440|1324|1325|1367|2051|45|1519"
							end
						else
							if skillslist["zhaixinggong"]["lvl"]>100 then
								zhizhulist="1787|896|1153|1431|1349|1440|1324|1325|1367|2051|45|1519"
							else
								zhizhulist="1787|896|1153|1349|1440|1324|1325|1367|2051|45|1519"
							end
						end
						zhizhunum=1
						_tb=utils.split(zhizhulist,"|")
						alias.flytoid(tonumber(_tb[zhizhunum]))
				end
			wait.time(3);_f()
		end)
	end
	if findstring(l,"数码世界，数字地图，45就是这里！") then
		run("bei none;enable finger qianzhu-wandu;bei qianzhu-wandu;break men;s;d;zhua zhizhu;u;break men;n;n")
	end
	if findstring(l,"数码世界，数字地图，1787就是这里！") then
		run("bei none;enable finger qianzhu-wandu;bei qianzhu-wandu;move qi;zhua zhizhu")
	end
	if findstring(l,"数码世界，数字地图，1519就是这里！") then
		run("bei none;enable finger qianzhu-wandu;bei qianzhu-wandu;move stone;zhua zhizhu")
	end
	if findstring(l,"数码世界，数字地图，896就是这里！") then
		run("bei none;enable finger qianzhu-wandu;bei qianzhu-wandu;wield jian")
		for i=1,10,1 do run("mianbi") end
		run("wield jian;strike wall;set checkpobi")
	end
	if findstring(l,"数码世界，数字地图，1153就是这里！","数码世界，数字地图，1324就是这里！","数码世界，数字地图，1325就是这里！","数码世界，数字地图，1349就是这里！","数码世界，数字地图，1367就是这里！","数码世界，数字地图，1440就是这里！","数码世界，数字地图，2051就是这里！") then
		run("bei none;enable finger qianzhu-wandu;bei qianzhu-wandu;zhua zhizhu")
	end
	if findstring(l,"良久，你突然有一股破","你随即抽出剑来，但听得砰砰之声不绝，石头不住滚落，露出一个窄窄的孔道。") then
		pobi=1
	end
	if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
		alias.resetidle()
		if not isopen("boat") then if havefj>0 then alias.startfj() else alias.startqzwd() end end
	end
	if findstring(l,"你用锦盒盖子轻轻地把.*蛛拨进盒子。") then
		alias.resetidle()
		alias.flytoid(705)
	end
	if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
		run("set qzwd=start")
	end
	if findstring(l,"你要抓什么？") then
		run("unwield jian;kill wu gong;kill scorpion")
		wait.make(function()
			_f=function()
						zhizhunum=zhizhunum+1
						_tb=utils.split(zhizhulist)
						if zhizhunum>table.getn(zhizhulist) then zhizhunum=1 end
						alias.flytoid(_tb[zhizhunum])
				end
			wait.time(1);_f()
		end)
	end
end

------------------------------------------------------------------------------------
-- qzwd_start
------------------------------------------------------------------------------------
function qzwd_start.dosomething1(n,l,w)
	if findstring(l,"你运功完毕， 长长的吐了口气。") then
		alias.resetidle()
		alias.checkbusy("qzwd")
	end
end
------------------------------------------------------------------------------------
-- qzwd_watch
------------------------------------------------------------------------------------
function qzwd_watch.dosomething1(n,l,w)
	if findstring(l,"毒蛛丝无法用来练千蛛万毒手。") then
		alias.resetidle()
		run("get all from jin he;drop zhusi;xiulian")
	end
	if findstring(l,"蛛吸取你手指上的血液为食，但你手指上血脉运转，也带了.*蛛体内毒液，回入自己血中。","盒中的.*蛛慢慢爬近，分别咬住了你两根指头。","你从怀里取出锦盒，打开盒盖，将双手两根食指伸进盒中。","你满脸庄严肃穆之容，眉心和太阳穴上淡淡的罩上了一层黑气，咬紧牙关，竭力忍受痛楚。","你深深吸一口气，双臂轻微颤抖，潜运内功和蛛毒相抗。","你又运功良久，脸上黑气渐退，重现血色。","你这功夫练了几有半个时辰，毒蜘蛛直到吸饱了血，肚子胀得和圆球相似，这才跌在盒中，沉沉睡去。","再过一会，又见你鼻尖上渗出细细的一粒粒汗珠。") then
		alias.resetidle()
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function qzwd.update()
	local  qzwd_pre_triggerlist={
	       {name="qzwd_pre_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    qzwd_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(qzwd_pre_triggerlist) do
		addtri(v.name,v.regexp,"qzwd_pre",v.script,v.line)
	end
	closeclass("qzwd_pre")
	
	local  qzwd_start_triggerlist={
	       {name="qzwd_start_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    qzwd_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(qzwd_start_triggerlist) do
		addtri(v.name,v.regexp,"qzwd_start",v.script,v.line)
	end
	closeclass("qzwd_start")
	
	local  qzwd_watch_triggerlist={
	       {name="qzwd_watch_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    qzwd_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(qzwd_watch_triggerlist) do
		addtri(v.name,v.regexp,"qzwd_watch",v.script,v.line)
	end
	closeclass("qzwd_watch")
end
qzwd.update()
