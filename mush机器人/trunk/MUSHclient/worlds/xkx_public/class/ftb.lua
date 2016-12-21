ftb={}
ftb_ask={}
ftb_pre={}
ftb_start={}
ftb_watch={}

ftbnum=0
ftbareanum=0
ftbroom=""
ftbzone=""
ftbnpcabandon=0

if ftbselectnpc==nil then ftbselectnpc={} end
function ftbselectnpc.select()
	local _t,_tb
	--if workflow.nowjob=="lzjob" then return 1 end
	_t=_G["ftbselectnpc"][ftbselectnpc.menpai]
	_tb=utils.split(_t,"|")
	return tonumber(_tb[ftbselectnpc.weapon+1])
end
------------------------------------------------------------------------------------
-- ftb_ask
------------------------------------------------------------------------------------
function ftb_ask.dosomething1(n,l,w)
	if findstring(l,"区域搜索中心点房间查找失败！") then
		if me.menpai=="xs" then run("ask lingzhi shangren about abandon") end
		if me.menpai=="xx" then xx.needsandu=1 end
		alias.startworkflow()
	end
	if findstring(l,"这里没有 cheng 这个人。") then
		alias.resetidle()
		if me.menpai=="xx" then
			xx.needsandu=1
			alias.startworkflow()
		elseif hp.pot<100 then
			alias.dz("addneili")
			resumejob="ask cheng about job"
			openclass("ftb_pre")
		else alias.startxue() end
	end
end
function ftb_ask.dosomething2(n,l,w)
	if findstring(w[0],"你向程金斧打听有关「job」的消息。\n程金斧交给你几锭黄金","你向程金斧打听有关「job」的消息。\n程金斧说道：好样的, 斧头帮就靠你这样的大才啊!") then
		alias.resetidle()
		closeclass("ftb_ask")
		openclass("ftb_pre")
		alias.checkexp("ftb")
	end
end
function ftb_ask.dosomething3(n,l,w)
	local a,b,c,d,e
	a,b,c,d,e=string.find(w[0],"你向程金斧打听有关「job」的消息。\n程金斧说道：听说有(.+)个家伙想对本帮不利.\n程金斧说道：据说他们已经到了([^(]+).*方圆(.+)里之内%.")
	if c~=nil and d~=nil and e~=nil then
		alias.resetidle()
		ftbnum=ctonum(c)
		ftbarea=d
		ftbareanum=ctonum(e)
		if ftbareanum>4 then ftbareanum=4 end
		alias.ftbarea(ftbarea)
		if ftbroom=="丹凤洞" then ftbroom="羊肠小路" end
		if string.len(ftbweapon)>0 then
			if ftbweapon=="staff" then alias.wi(staffid) else alias.wi(ftbweapon) end
		end
		alias.flytoarea(ftbroom,ftbzone,ftbareanum+1)
		addlog(ftbzone.." "..ftbroom.." 范围="..tostring(ftbareanum+1).." 数量="..tostring(ftbnum))
		-- #if @explist.keephour {#add explist.tempinfo %concat( @ftbzone, " ", @ftbroom, " 范围=", %eval( @ftbareanum+1), " 数量=", @ftbnum)}
	end
	if findstring(w[0],"你向程金斧打听有关「job」的消息。\n程金斧一脚正好踢中你的屁股！\n程金斧说道：去了这么久才回来, 人家早得手啦") then
		alias.resetidle()
		if not isopen("ftb_pre") then alias.startftb() end
	end
end
function ftb_ask.dosomething4(n,l,w)
	local a,b,c,d,e
	a,b,c,d,e=string.find(w[0],"你向程金斧打听有关「job」的消息。\n程金斧说道：我早就告诉过你了:\n程金斧说道：听说有(.+)个家伙想对本帮不利.\n程金斧说道：据说他们已经到了([^(]+).*方圆(.+)里之内")
	if c~=nil and d~=nil and e~=nil then
		alias.resetidle()
		if me.menpai=="xx" then
			xx.needsandu=1
			alias.startworkflow()
		elseif hp.pot<100 then
			alias.dz("addneili")
			resumejob="ask cheng about job"
			openclass("ftb_pre")
		else alias.startxue() end
	end
end
------------------------------------------------------------------------------------
-- ftb_pre
------------------------------------------------------------------------------------
function ftb_pre.dosomething1(n,l,w)
	if findstring(l,"你口念咒语『神马都是浮云,虾米都是尘土』，『大堂』立马到达！") then
		alias.resetidle()
		if ftbnpckilled>0 then run("ask cheng about job") end
		alias.et()
		alias.yjl()
		alias.checkitems()
	end
	if findstring(l,"你目前还没有任何为 checkexpover=ftb 的变量设定。") then
		alias.resetidle()
		ftbnpckilled=0
		ftbnpcabandon=0
		ftbnum=0
		workflow.nowjob="ftb"
		alias.startworkflow()
	end
	if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
		alias.resetidle()
		if not isopen("boat") then
			if havefj>0 then
				alias.startworkflow()
			elseif tonumber(roomno_now)==1705 then
				closeclass("ftb_pre")
				openclass("ftb_ask")
				run("ask cheng about job")
			else alias.startftb() end
		end
	end
	if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
		alias.resetidle()
		if me.menpai=="xx" then
			if havefj>0 then
				alias.startworkflow()
			elseif tonumber(roomno_now)==1705 then
				closeclass("ftb_pre")
				openclass("ftb_ask")
				run("ask cheng about job")
			else alias.startftb() end
		else alias.dz(set_neili) end
	end
end
function ftb_pre.dosomething2(n,l,w)
	if findstring(w[0],"你向程金斧打听有关「job」的消息。\n程金斧交给你几锭黄金","你向程金斧打听有关「job」的消息。\n程金斧说道：好样的, 斧头帮就靠你这样的大才啊!") then
		alias.resetidle()
		alias.checkexp("ftb")
	end
	if findstring(w[0],"你向程金斧打听有关「job」的消息。\n程金斧说道：我早就告诉过你了:") then
		alias.resetidle()
		closeclass("ftb_pre")
		openclass("ftb_ask")
		run("ask cheng about job")
	end
end
function ftb_pre.dosomething3(n,l,w)
	if findstring(w[0],"你向程金斧打听有关「job」的消息。\n程金斧一脚正好踢中你的屁股！\n程金斧说道：去了这么久才回来, 人家早得手啦%.") then
		alias.resetidle()
		alias.startftb()
	end
end
------------------------------------------------------------------------------------
-- ftb_start
------------------------------------------------------------------------------------
function ftb_start.dosomething1(n,l,w)
	local _f,_tb,a,b,c,d,e
	wait.make(function()
		if findstring(l,"这里不准战斗。") then
			rekill=rekill+1
			if workflow.nowjob=="lzjob" then run("ask "..tostring(npcid).." about 酥油罐")
			else run("ask "..tostring(npcid).." about 斧头帮") end
			if rekill>30 then
				closeclass("kill_"..me.menpai)
				closeclass("kill")
				wieldweapon=0
				getweapon=0
				run("set killover=yes")
			end
		end
		if findstring(l,"你忙着呢，你等会儿在问话吧。") then
			if npcid==nil then npcid="" end
			_f=function() run("ask "..npcid.." about 刺客") end
			wait.time(1);_f()
		end
		if findstring(l,"这个方向没有出路。") then
			gpserrnum=gpserrnum+1
		end
		a,b,c=string.find(l,"他看起来是(.+)高手。")
		if c~=nil then
			if findstring(c,"大理段家") then ftbselectnpc.menpai="dl" end
			if findstring(c,"全真教") then ftbselectnpc.menpai="qz" end
			if findstring(c,"武当派") then ftbselectnpc.menpai="wd" end
			if findstring(c,"少林派") then ftbselectnpc.menpai="sl" end
			if findstring(c,"桃花岛") then ftbselectnpc.menpai="th" end
			if findstring(c,"峨嵋派") then ftbselectnpc.menpai="em" end
			if findstring(c,"华山派") then ftbselectnpc.menpai="hs" end
			if findstring(c,"星宿派") then ftbselectnpc.menpai="xx" end
			if findstring(c,"白驼山") then ftbselectnpc.menpai="bt" end
			if findstring(c,"雪山派") then ftbselectnpc.menpai="xs" end
			if findstring(c,"密宗") then ftbselectnpc.menpai="xs" end
			if findstring(c,"丐帮") then ftbselectnpc.menpai="gb" end
			ftbselectnpc.weapon=0
		end
		a,b,c=string.find(l,"□(.+)%(.+%)")
		if c~=nil then
			if not findstring(c,"皮背心") then ftbselectnpc.weapon=1 end
			if findstring(c,"蛇杖") then
				ftbselectnpc.menpai="bt"
				ftbselectnpc.weapon=1
				if me.menpai=="xs" and lzjob.open>0 then print("蛇杖有毒，放弃不杀") end
			end
		end
		if findstring(l,'设定环境变量：walk = "off"') then
			alias.resetidle()
			run("set checknpc=yes")
		end
		a,b,c,d=string.find(l,"%s+「.+」(.+)%((.+)%)")
		if c~=nil and d~=nil then
			if workflow.nowjob=="ftb" then
				alias.resetidle()
				npcfind=1
				ftbnpcname=additem(ftbnpcname,c)
				ftbnpcid=additem(ftbnpcid,string.lower(d))
				ftbnpcindex=1
			end
		end
		a,b,c,d,e=string.find(l,"(.+)%((%w+) (%w+)%)")
		if c~=nil and d~=nil and e~=nil and findstring(c,lzjob.name) then
			if workflow.nowjob=="lzjob" then
				alias.resetidle()
				npcfind=1
				ftbnpcname=lzjob.name
				ftbnpcid=string.lower(d).." "..string.lower(e)
				ftbnpcindex=1
			end
		end
		if findstring(l,"突然从(.+)布袋中掉下一个酥油罐。") then
			run("halt;get suyou guan")
		end
		if findstring(l,"对方正忙着呢，你等会儿在问话吧。") then
			alias.resetidle()
			ftbnpcindex=ftbnpcindex+1
			_tb=utils.split(ftbnpcid,"|")
			if ftbnpcindex<=table.getn(_tb) then
				_tb=utils.split(ftbnpcname,"|")
				npcname=_tb[ftbnpcindex]
				_tb=utils.split(ftbnpcid,"|")
				npcid=_tb[ftbnpcindex]
				run("ask "..npcid.." about 刺客")
			else
				npcfind=0
				ftbnpcindex=1
				_f=function() if flytoarealist_backpath==nil or string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end end
				if cmd.nums<cmd.setnums then
					_f()
				else
					wait.time(0.5);_f()
				end
			end
		end
		a,b,c=string.find(l,"这里没有 (.+) 这个人。")
		if c~=nil and c==npcid then
			alias.resetidle()
			ftbnpcindex=ftbnpcindex+1
			_tb=utils.split(ftbnpcid,"|")
			if ftbnpcindex<=table.getn(_tb) then
				_tb=utils.split(ftbnpcname,"|")
				npcname=_tb[ftbnpcindex]
				_tb=utils.split(ftbnpcid,"|")
				npcid=_tb[ftbnpcindex]
				run("ask "..npcid.." about 刺客")
			else
				npcfind=0
				ftbnpcindex=1
				_f=function() if flytoarealist_backpath==nil or string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end end
				if cmd.nums<cmd.setnums then
					_f()
				else
					wait.time(0.2);_f()
				end
			end
		end
		if findstring(l,"你要对谁做 kick4 这个动作？","你气得伸足乱踢，只踢得地上的白雪飞溅。") then
			alias.resetidle()
			ftbnpcindex=ftbnpcindex+1
			_tb=utils.split(ftbnpcid,"|")
			if ftbnpcindex<=table.getn(_tb) then
				_tb=utils.split(ftbnpcname,"|")
				npcname=_tb[ftbnpcindex]
				_tb=utils.split(ftbnpcid,"|")
				npcid=_tb[ftbnpcindex]
				run("kick4 "..npcid)
			else
				npcfind=0
				ftbnpcindex=1
				_f=function() if flytoarealist_backpath==nil or string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end end
				if cmd.nums<cmd.setnums then
					_f()
				else
					wait.time(0.2);_f()
				end
			end
		end
		if findstring(l,"你目前还没有任何为 killover=yes 的变量设定。") then
			alias.resetidle()
			ftbnpckilled=ftbnpckilled+1
			ftbnpcindex=ftbnpcindex+1
			alias.yjl()
			if me.menpai=="xs" and lzjob.open>0 then
				run("get suyou guan")
				print("所有npc杀完！")
				flytoareastartid=0
				workflow.nowjob="ftb"
				nextJobGodazuobase=1
				openclass("ftb")
				openclass("ftb_pre")
				closeclass("ftb_ask")
				closeclass("ftb_start")
				alias.checkexp("ftb")
			else
				_tb=utils.split(ftbnpcid,"|")
				if ftbnpcindex<=table.getn(_tb) then
					_tb=utils.split(ftbnpcname,"|")
					npcname=_tb[ftbnpcindex]
					_tb=utils.split(ftbnpcid,"|")
					npcid=_tb[ftbnpcindex]
					run("ask "..npcid.." about 刺客")
				else
					npcfind=0
					ftbnpcindex=1
					_f=function() if flytoarealist_backpath==nil or string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end end
					if tonumber(ftbnpckilled)<tonumber(ftbnum) then
						wait.time(0.1);_f()
					else
						print("所有npc杀完！")
						alias.startftb()
					end
				end
			end
		end
		if findstring(l,"你目前还没有任何为 busyover=killstart 的变量设定。") then
			alias.resetidle()
			_tb=utils.split(ftbpfm,"|")
			if findstring(_tb[pfmid],"leidong") and me.menpai=="hs" then
				run("jifa dodge huashan-shenfa;jifa parry pishi-poyu")
			end
			if me.menpai=="hs" then
				if me.master=="风清扬" then run("jifa sword dugu-jiujian")
				elseif ftbweapon=="jian" then run("jifa parry huashan-jianfa")
				elseif ftbweapon=="staff" then run("jifa parry jinhua-zhang") end
			end
			if me.menpai=="bt" then run("conver staff;attack "..npcid) end
			if me.menpai=="mj" then run("order fighter do attack "..npcid..";order fighter 2 do attack "..npcid) end
			if me.menpai=="xs" and lzjob.open then print("lzjob 开始杀人") end
			_tb=utils.split(killyun,"|")
			for k,v in ipairs(_tb) do run(v) end
			run("kill "..npcid)
			_tb=utils.split(killpfm,"|")
			run(_tb[pfmid].." "..npcid)
		end
		if findstring(l,"你目前还没有任何为 checknpc=menpai 的变量设定。") then
			alias.resetidle()
			if ftbselectnpc.select()>0 then
				-- #say 发现@ftbselectnpc.menpai npc @npcname~(@npcid~)，%if( @ftbselectnpc.weapon, 武器, 没武器)
				-- #if @explist.keephour {#add explist.tempinfo %concat( " NPC=", @ftbselectnpc.menpai, " ", %if( @ftbselectnpc.weapon, 武器, 没武器))}
				openclass("kill")
				openclass("kill_"..me.menpai)
				closeclass("kill_run")
				AddTimer("kill_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "kill.timer")
				SetTimerOption("kill_timer", "group", "kill")
				runaway=false
				npcfaint=false
				killRunSuccess=false
				rekill=0
				killid=npcid
				killname=npcname
				killskill=ftbweapon
				killpfm=ftbpfm
				killyun=ftbyun
				killjiali=ftbjiali
				killjiajin=ftbjiajin
				--if me.menpai=="dl" then alias.jfdl() end
				run("jiali "..killjiali..";jiajin "..killjiajin)
				if me.menpai=="hs" then
					if stat.leidong>0 then
						pfmid=2
						if ftbweapon=="staff" then alias.wi(staffid) else alias.wi(ftbweapon) end
					else
						pfmid=1
						alias.uw()
					end
				else
					pfmid=1
					if string.len(ftbweapon)>0 then
						if ftbweapon=="staff" then alias.wi(staffid) else alias.wi(ftbweapon) end
					else alias.uw() end
				end
				if jifa.forcename=="hunyuanyiqi" and ftbselectnpc.menpai=="xx" and ftbselectnpc.weapon>0 then
					run("yun sangong")
				else
					_tb=utils.split(ftbyun,"|")
					for k,v in ipairs(_tb) do run(v) end
				end
				alias.checkbusy("killstart")
			else
				-- #if @debug=1 {#say @ftbselectnpc.menpai npc，%if( @ftbselectnpc.weapon, 武器, 没武器) 不杀}
				run("follow none")
				ftbnpcabandon=ftbnpcabandon+1
				ftbnpcindex=ftbnpcindex+1
				_tb=utils.split(ftbnpcid,"|")
				if ftbnpcindex<=table.getn(_tb) then
					_tb=utils.split(ftbnpcname,"|")
					npcname=_tb[ftbnpcindex]
					_tb=utils.split(ftbnpcid,"|")
					npcid=_tb[ftbnpcindex]
					run("ask "..npcid.." about 刺客")
				else
					npcfind=0
					ftbnpcindex=1
					if tonumber(ftbnpcabandon+ftbnpckilled)==ftbnum then
						-- 放弃和杀掉的NPC数量等于需要找的NPC总数，直接回去了
						if me.menpai=="xs" and lzjob.open>0 then
							openclass("ftb")
							openclass("ftb_pre")
							closeclass("ftb_ask")
							closeclass("ftb_start")
							alias.checkexp("ftb")
						else
							if ftbnpckilled>0 then alias.startftb() else alias.startworkflow() end
						end
					else
						_f=function() if flytoarealist_backpath==nil or string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end end
						wait.time(0.1)
						_f()
					end
				end
			end
		end
		if findstring(l,"你目前还没有任何为 checknpc=yes 的变量设定。") then
			alias.resetidle()
			if npcfind==0 then
				if cmd.nums<=cmd.setnums then
					if getgold==1 then run("get gold") end
					if flytoarealist_backpath==nil or string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end
				else
					_f=function()
								alias.yjl()
								if getgold==1 then run("get gold") end
								if flytoarealist_backpath==nil or string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end
						end
					wait.time(1);_f()
				end
			else
				npcname=ftbnpcname
				npcid=ftbnpcid
				if me.menpai=="xs" and lzjob.open>0 then run("kick4 "..npcid) else run("ask "..npcid.." about 刺客") end
			end
		end
		if findstring(l,"你目前还没有任何为 searcharea=over 的变量设定。") then
			alias.resetidle()
			print("搜索完毕，杀了"..ftbnum.."个中的"..ftbnpckilled.."个NPC")
			if me.menpai=="xs" and lzjob.open>0 then
				openclass("ftb")
				openclass("ftb_pre")
				closeclass("ftb_ask")
				closeclass("ftb_start")
				alias.checkexp("ftb")
			elseif ftbnpckilled>0 then alias.startftb()
			else alias.startworkflow() end
		end
		if findstring(l,"你在(.+)屁股上踢了一脚，将他踢得几个斤斗翻将出去，砰的一声，撞在墙上。") then
			alias.resetidle()
			killaction=""
			ftbselectnpc.menpai="dl"
			ftbselectnpc.weapon=0
			run("follow "..npcid..";look "..npcid..";set checknpc=menpai")
		end
		a,b,c=string.find(l,"[> ]*(.+)说道：老子怎么看都觉得你比我像杀手!")
		if c~=nil then
			alias.resetidle()
			killaction=""
			if c==npcname then run("follow "..npcid..";look "..npcid..";set checknpc=menpai") end
		end
		a,b,c=string.find(l,"但是很显然的，(.+)现在的状况没有办法给你任何答覆。")
		if c~=nil then
			alias.resetidle()
			if c==npcname then
				ftbnpcindex=ftbnpcindex+1
				_tb=utils.split(ftbnpcid,"|")
				if ftbnpcindex<=table.getn(_tb) then
					_tb=utils.split(ftbnpcname,"|")
					npcname=_tb[ftbnpcindex]
					_tb=utils.split(ftbnpcid,"|")
					npcid=_tb[ftbnpcindex]
					run("ask "..npcid.." about 刺客")
				else
					npcfind=0
					ftbnpcindex=1
					_f=function() if flytoarealist_backpath==nil or string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end end
					wait.time(0.2);_f()
				end
			end
		end
		a,b,c=string.find(l,"[> ]*(.+)说道：青天白日的, 哪里有刺客%? 笑话%.")
		if c~=nil then
			alias.resetidle()
			if c==npcname then
				ftbnpcindex=ftbnpcindex+1
				_tb=utils.split(ftbnpcid,"|")
				if ftbnpcindex<=table.getn(_tb) then
					_tb=utils.split(ftbnpcname,"|")
					npcname=_tb[ftbnpcindex]
					_tb=utils.split(ftbnpcid,"|")
					npcid=_tb[ftbnpcindex]
					run("ask "..npcid.." about 刺客")
				else
					npcfind=0
					ftbnpcindex=1
					_f=function() if flytoarealist_backpath==nil or string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end end
					if cmd.nums<cmd.setnums then _f() else wait.time(0.5);_f() end
				end
			end
		end
		a,b,c=string.find(l,"[> ]*(.+)说道：嗯%.%.%.%.这我可不清楚，你最好问问别人吧。")
		if c~=nil then
			alias.resetidle()
			if c==npcname then
				ftbnpcindex=ftbnpcindex+1
				_tb=utils.split(ftbnpcid,"|")
				if ftbnpcindex<=table.getn(_tb) then
					_tb=utils.split(ftbnpcname,"|")
					npcname=_tb[ftbnpcindex]
					_tb=utils.split(ftbnpcid,"|")
					npcid=_tb[ftbnpcindex]
					run("ask "..npcid.." about 刺客")
				else
					npcfind=0
					ftbnpcindex=1
					_f=function() if flytoarealist_backpath==nil or string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end end
					if cmd.nums<cmd.setnums then _f() else wait.time(0.5);_f() end
				end
			end
		end
		a,b,c=string.find(l,"[> ]*(.+)耸了耸肩，很抱歉地说：无可奉告。")
		if c~=nil then
			alias.resetidle()
			if c==npcname then
				ftbnpcindex=ftbnpcindex+1
				_tb=utils.split(ftbnpcid,"|")
				if ftbnpcindex<=table.getn(_tb) then
					_tb=utils.split(ftbnpcname,"|")
					npcname=_tb[ftbnpcindex]
					_tb=utils.split(ftbnpcid,"|")
					npcid=_tb[ftbnpcindex]
					run("ask "..npcid.." about 刺客")
				else
					npcfind=0
					ftbnpcindex=1
					_f=function() if flytoarealist_backpath==nil or string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end end
					if cmd.nums<cmd.setnums then _f() else wait.time(0.5);_f() end
				end
			end
		end
		a,b,c=string.find(l,"[> ]*(.+)想了一会儿，说道：对不起，你问的事我实在没有印象。")
		if c~=nil then
			alias.resetidle()
			if c==npcname then
				ftbnpcindex=ftbnpcindex+1
				_tb=utils.split(ftbnpcid,"|")
				if ftbnpcindex<=table.getn(_tb) then
					_tb=utils.split(ftbnpcname,"|")
					npcname=_tb[ftbnpcindex]
					_tb=utils.split(ftbnpcid,"|")
					npcid=_tb[ftbnpcindex]
					run("ask "..npcid.." about 刺客")
				else
					npcfind=0
					ftbnpcindex=1
					_f=function() if flytoarealist_backpath==nil or string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end end
					if cmd.nums<cmd.setnums then _f() else wait.time(0.5);_f() end
				end
			end
		end
		a,b,c=string.find(l,"[> ]*(.+)摇摇头，说道：没听说过。")
		if c~=nil then
			alias.resetidle()
			if c==npcname then
				ftbnpcindex=ftbnpcindex+1
				_tb=utils.split(ftbnpcid,"|")
				if ftbnpcindex<=table.getn(_tb) then
					_tb=utils.split(ftbnpcname,"|")
					npcname=_tb[ftbnpcindex]
					_tb=utils.split(ftbnpcid,"|")
					npcid=_tb[ftbnpcindex]
					run("ask "..npcid.." about 刺客")
				else
					npcfind=0
					ftbnpcindex=1
					_f=function() if flytoarealist_backpath==nil or string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end end
					if cmd.nums<cmd.setnums then _f() else wait.time(0.5);_f() end
				end
			end
		end
		a,b,c=string.find(l,"[> ]*(.+)睁大眼睛望着你，显然不知道你在说什么。")
		if c~=nil then
			alias.resetidle()
			if c==npcname then
				ftbnpcindex=ftbnpcindex+1
				_tb=utils.split(ftbnpcid,"|")
				if ftbnpcindex<=table.getn(_tb) then
					_tb=utils.split(ftbnpcname,"|")
					npcname=_tb[ftbnpcindex]
					_tb=utils.split(ftbnpcid,"|")
					npcid=_tb[ftbnpcindex]
					run("ask "..npcid.." about 刺客")
				else
					npcfind=0
					ftbnpcindex=1
					_f=function() if flytoarealist_backpath==nil or string.len(flytoarealist_backpath)==0 then alias.searchareastep() else alias.searchareaback() end end
					if cmd.nums<cmd.setnums then _f() else wait.time(0.5);_f() end
				end
			end
		end
		a,b,c=string.find(l,"数码世界，数字地图，(%d+)就是这里！")
		if c~=nil and tonumber(c)==tonumber(flytoareastartid) then
			alias.resetidle()
			run("set checknpc=yes")
		end
		if findstring(l,"你要对谁做 18mo 这个动作？") then
			alias.startworkflow()
		end
	end)
end
------------------------------------------------------------------------------------
-- ftb_watch
------------------------------------------------------------------------------------
function ftb_watch.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"此地不适合施展一苇渡江绝技！") then
			gpserrnum=gpserrnum+1
		end
		if findstring(l,"别那么自私！你不能带走超过一把兵器。") then
			gpserrnum=gpserrnum+1
			dropweapon=dropweapon+1
		end
		if findstring(l,"这个方向没有出路。") then
			print(roomno_now.."出错！")
			if tonumber(roomno_now)==934 then alias.searchareastep3() else gpserrnum=gpserrnum+1 end
		end
		if findstring(l,"老师傅拦着你说：你想把食物拿去哪里？东西放下再走。","明教弟子指了指你拿着的食物，说道：根据教规，明教弟子不得将食物带出大食殿。") then
			run("drop ya;drop jiuping")
			gpserrnum=gpserrnum+1
		end
		if findstring(l,"店小二一下挡在楼梯前，白眼一翻：怎麽着，想白住啊！","看清楚点，那是男弟子休息室！","看清楚点，那是女弟子休息室！","你一个大男人到女人店里去想干什么？","晚上不开，请天亮了再来！","未经许可，不得进入藏经阁三楼！","袁紫衣说道：本姑娘在这里休息，别来打搅！") then
			if flytoarealist_backpath==nil or string.len(flytoarealist_backpath)==0 then alias.searchareastep2() else alias.searchareaback2() end
		end
		a,b,c=string.find(l,"[> ]*(.+)%s+%-%s+")
		if c~=nil then
			if not findstring(c,"%)") then roomname=c end
		end
		if findstring(l,"你的动作还没有完成，不能移动。") then
			if not findstring(roomname,"桃花林") then gpserrnum=gpserrnum+1 end
		end
		if findstring(l,"艄公回到仓里，发现你还在，咦了一声, 说：“你还没有上岸啊, 我送你到岸边。") then
			openclass("boat")
		end
		if findstring(l,"你正要有所动作，突然身旁有人将你一拍：好好看比武，别乱动！") then
			alias.close_gps()
			_f=function() run("s;s;set checknpc=yes") end
			wait.time(5);_f()
		end
		if findstring(l,"^%s+(.+)两黄金%(Gold%)") then
			getgold=1
		end
		if findstring(l,"石级旁边的草丛中忽然跃起一个身影，挡住了你！") then
			run("giveup")
		end
		if findstring(l,"这是丐帮 极其秘密的地下通道，乃用丐帮几辈人之心血掘成。") then
			alias.resetidle()
			run("ne;ne;u;set checknpc=yes")
		end
		if findstring(l,"你目前还没有任何为 checkGbSecretWay=err 的变量设定。") then
			alias.resetidle()
			_f=function() run("look") end
			wait.time(5);_f()
		end
	end)
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function ftb.update()
	local  ftb_ask_triggerlist={
	       {name="ftb_ask_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    ftb_ask.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(ftb_ask_triggerlist) do
		addtri(v.name,v.regexp,"ftb_ask",v.script,v.line)
	end
	local _tb2={
		"你向程金斧打听有关「job」的消息。\\n(.+)\\Z",
	}
	local _tb3={
		"你向程金斧打听有关「job」的消息。\\n(.+)\\n(.+)\\Z",
	}
	local _tb4={
		"你向程金斧打听有关「job」的消息。\\n(.+)\\n(.+)\\n(.+)\\Z",
	}
	local  ftb_ask_m_triggerlist={
	       {name="ftb_ask_m_dosth2",line=2,regexp=linktri2(_tb2),script=function(n,l,w)    ftb_ask.dosomething2(n,l,w)  end,},
	       {name="ftb_ask_m_dosth3",line=3,regexp=linktri2(_tb3),script=function(n,l,w)    ftb_ask.dosomething3(n,l,w)  end,},
	       {name="ftb_ask_m_dosth4",line=4,regexp=linktri2(_tb4),script=function(n,l,w)    ftb_ask.dosomething4(n,l,w)  end,},
	}
	for k,v in pairs(ftb_ask_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"ftb_ask",v.script,v.line)
	end
	closeclass("ftb_ask")
	
	local  ftb_pre_triggerlist={
	       {name="ftb_pre_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    ftb_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(ftb_pre_triggerlist) do
		addtri(v.name,v.regexp,"ftb_pre",v.script,v.line)
	end
	local _tb2={
		"你向程金斧打听有关「job」的消息。\\n(.+)\\Z",
	}
	local _tb3={
		"你向程金斧打听有关「job」的消息。\\n(.+)\\n(.+)\\Z",
	}
	local  ftb_pre_m_triggerlist={
	       {name="ftb_pre_m_dosth2",line=2,regexp=linktri2(_tb2),script=function(n,l,w)    ftb_pre.dosomething2(n,l,w)  end,},
	       {name="ftb_pre_m_dosth3",line=3,regexp=linktri2(_tb3),script=function(n,l,w)    ftb_pre.dosomething3(n,l,w)  end,},
	}
	for k,v in pairs(ftb_pre_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"ftb_pre",v.script,v.line)
	end
	closeclass("ftb_pre")
	
	local  ftb_start_triggerlist={
	       {name="ftb_start_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    ftb_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(ftb_start_triggerlist) do
		addtri(v.name,v.regexp,"ftb_start",v.script,v.line)
	end
	closeclass("ftb_start")
	
	local  ftb_watch_triggerlist={
	       {name="ftb_watch_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    ftb_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(ftb_watch_triggerlist) do
		addtri(v.name,v.regexp,"ftb_watch",v.script,v.line)
	end
	closeclass("ftb_watch")
end
ftb.update()
