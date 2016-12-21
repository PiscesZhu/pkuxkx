fj={}
fj_watch={}
fj_close={}
fj_escape={}
fj_other={}
fj_pre={}
fj_start={}

------------------------------------------------------------------------------------
-- fj_watch
------------------------------------------------------------------------------------
function fj_watch.dosomething1(n,l,w)
	local a,b,c,d,e
	if findstring(l,"唉！你耽误的时间太久了，这次任务取消了。") then havefj=0 end
	a,b,c=string.find(l,"一个.+弟子走了过来,对你报拳道：“在下奉(.+)之命，请你速回.+处晋见”。")
	if c~=nil and c==me.fjmasternick then
		havefj=1
		set_neili=tonumber(set_neili_job)
	end
	a,b,c,d=string.find(l,"[> ]*(.+)已派你去(.+)附近完成重要任务，赶快去执行吧。")
	if c~=nil and d~=nil and c==me.fjmasternick then
		havefj=1
		fjarea=d
		alias.fjarea(fjarea)
	end
	if findstring(l,"任务已经完成，赶快回去复命吧。") then
		havefj=1
		fjzone=""
		fjroom=""
		fjarea=""
		fjroomid=0
	end
	a,b,c,d=string.find(l,"[> ]*(.+)对你说道：目前我.+的贡献度为(.+)点。")
	if c~=nil and d~=nil and c==me.fjmaster then
		gxd.mp=ctonum(d)
	end
	a,b,c,d=string.find(l,"[> ]*(.+)对你说道：你为.+所做的贡献为(.+)点。你要继续努力，争取在下次.+大会上得到最佳评定。")
	if c~=nil and d~=nil and c==me.fjmaster then
		gxd.me=ctonum(d)
	end
	a,b,c=string.find(l,"[> ]*(.+)已传令要召见你，你还是快点去吧。")
	if c~=nil and c==me.fjmasternick then
		havefj=1
	end
	a,b,c,d=string.find(l,"[> ]*(.+)说道:“辛苦你了，(.+)，你为.+立下了一功。”")
	if c~=nil and d~=nil and c==me.fjmaster and d==me.charname then
		havefj=0
		set_neili=tonumber(set_neili_global)
	end
	a,b,c=string.find(l,"你的经验上升了(%d+)点。")
	if c~=nil then
		fjexp=tonumber(c)
	end
	a,b,c,d=string.find(l,"[> ]*(.+)说道:“干得好，(.+)，老仙我越来越欣赏你了。”")
	if c~=nil and d~=nil and c==me.fjmaster and d==me.charname then
		havefj=0
		set_neili=tonumber(set_neili_global)
	end
	a,b,c,d,e=string.find(w[0],".+说道：“(.-)，.+\n(.+)说道:“近日在(.+)附近.*")
	if c~=nil and d~=nil and e~=nil and c==me.charname and d==me.fjmaster then
		alias.resetidle()
		fjroomid=0
		fjarea=e
		alias.fjarea(fjarea)
	end
end
------------------------------------------------------------------------------------
-- fj_close
------------------------------------------------------------------------------------
function fj_close.dosomething1(n,l,w)
	local a,b,c
	a,b,c=string.find(l,"数码世界，数字地图，(%d+)就是这里！")
	if c~=nil and tonumber(c)==me.fjbaseid then
		if not isopen("dazuo") then run("ask "..me.fjmasterid.." about 要事在身") end
	end
	a,b,c=string.find(l,"你向(.+)打听有关「要事在身」的消息。")
	if c~=nil and c==me.fjmaster then
		havefj=0
		closeclass("fj_close")
		alias.startworkflow()
	end
end
------------------------------------------------------------------------------------
-- fj_escape
------------------------------------------------------------------------------------
function fj_escape.dosomething1(n,l,w)
	local _f,_tb,a,b,c
	wait.make(function()
		a,b,c=string.find(l,"你在(.+)的耳边悄声说道：你不是我的菜！")
		if c~=nil and c==me.fjnpcname then
			alias.resetidle()
			if escape_err>0 then
				run("look;set resetSafe=yes")
				escape_err=0
			else
				_f=function() run("halt;go "..escape..";whisper "..me.fjnpcid.." 你不是我的菜！") end
				wait.time(0.2);_f()
			end
		end
		if findstring(l,"你要对谁做 doufu 这个动作？") then
			if selectRunSuccess==nil or selectRunSuccess==0 then
				-- 逃跑成功！
				alias.resetidle()
				alias.close_kill()
				alias.checkbusy("escape")
			end
		end
		if findstring(l,"你目前还没有任何为 busyover=escape 的变量设定。") then
			alias.resetidle()
			if jifa.forcename=="motianyunqi" then run("yun shougong") end
			alias.dz(set_neili_job)
		end
		if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
			alias.resetidle()
			_f=function()
						fjnpcleave=1
						lookgag=1
						run("look "..tostring(invDirection(escape))..";set checknpcleave=yes")
				end
			wait.time(0.2);_f()
		end
		a,b,c=string.find(l,"%s+(.+)正在运功疗伤。$")
		if c~=nil and c==me.fjnpcname then
			fjnpcleave=0
			alias.resetidle()
		end
		a,b,c=string.find(l,"%s+.+弟子 ([^\(]+)\(.+\) <战斗中>")
		if c~=nil and c==me.fjnpcname then
			fjnpcleave=0
			alias.resetidle()
		end
		a,b,c=string.find(l,"%s+.+弟子 ([^\(]+)\(.+\) <昏迷不醒>")
		if c~=nil and c==me.fjnpcname then
			fjnpcleave=0
			alias.resetidle()
		end
		a,b,c=string.find(l,"%s+.+弟子 ([^\(]+)\(.+\)$")
		if c~=nil and c==me.fjnpcname then
			fjnpcleave=0
			alias.resetidle()
		end
		if findstring(l,"你目前还没有任何为 checknpcleave=yes 的变量设定。") then
			if escape_err~=nil and escape_err>0 then
				-- 出口发生改变，使用flytoid
				closeclass("fj_escape")
				_f=function()
							alias.flytoid(fjroomid)
							fjroomid=0
							escape_err=0
					end
				wait.time(3);_f()
			else
				if fjnpcleave>0 then
					run("halt")
					escapeback_err=0
					run("go "..invDirection(escape)..";set check=escapeback")
				else
					_f=function()
								fjnpcleave=1
								lookgag=1
								run("look "..invDirection(escape)..";set checknpcleave=yes")
						end
					wait.time(0.2);_f()
				end
			end
		end
		if findstring(l,"你要看什么？","你要往哪个方向走？","这个方向没有出路。") then
			escape_err=1
		end
		if findstring(l,"这里空气不好，不能打坐。") then
			alias.tdz()
		end
		if findstring(l,"战斗中不能练内功，会走火入魔。","你吐气纳息，硬生生地将内息压了下去，缓缓站了起来。") then
			alias.resetidle()
			_f=function() alias.dz(set_neili_job) end
			wait.time(1);_f()
		end
		a,b,c=string.find(l,"%s+这里[唯一|明显]+的出口是 (.+)。$")
		if c~=nil then
			entrance=c
			xkxGPS.setEntrance(entrance)
			if lookgag~=nil and lookgag>0 then
				lookgag=0
			end
		end
		if findstring(l,"你目前还没有任何为 resetSafe=yes 的变量设定。") then
			alias.resetidle()
			if selectRunSuccess==nil or selectRunSuccess==0 then
				_tb=utils.split(xkxGPS.entrance,"|")
				escape=_tb[math.random(#_tb)]
				run("halt;go "..escape)
				if tonumber(fjroomid)==609 then
					-- 防止峨嵋per的强盗导致触发紊乱
					_tb=utils.split(me.fjnpcid," ")
					run("doufu ".._tb[1])
				else
					run("doufu "..me.fjnpcid)
				end
			end
		end
		if findstring(l,"糟糕，你逃跑失败了！","你的动作还没有完成，不能移动。") then
			escapeback_err=1
		end
		if findstring(l,"你目前还没有任何为 check=escapeback 的变量设定。") then
			if escapeback_err~=nil and escapeback_err>0 then
				_f=function()
							run("halt")
							escapeback_err=0
							run("go "..invDirection(escape)..";set check=escapeback")
					end
				wait.time(0.5);_f()
			else
				alias.resetidle()
				closeclass("fj_escape")
			end
		end
		if findstring(l,"少林弟子岂可贪生怕死，以坠本派声名！") then
			run("giveup")
			escapeback_err=1
		end
		a,b,c=string.find(l,"你深情地对(.+)唱道：走千山万里路，读千册万卷书，都不如靠近吃你两块豆腐！")
		if c~=nil and c==me.fjnpcname then
			alias.resetidle()
			if escape_err~=nil and escape_err>0 then
				run("look;set resetSafe=yes")
				escape_err=0
			else
				if selectRunSuccess~=nil and selectRunSuccess>0 then
					print("逃离地点有同样的FJ NPC，不再处理逃跑")
				else
					_f=function()
								run("halt;go "..escape)
								if tonumber(fjroomid)==609 then
									-- 防止峨嵋per的强盗导致触发紊乱
									_tb=utils.split(me.fjnpcid," ")
									run("doufu ".._tb[1])
								else
									run("doufu "..me.fjnpcid)
								end
						end
					wait.time(0.2);_f()
				end
			end
		end
		if findstring(l,"忽然一阵腥风袭来，一条巨蟒从身旁大树上悬下，把你卷走了。") then
			closeclass("fj_escape")
			_f=function()
						alias.flytoid(fjroomid)
						fjroomid=0
						escape_err=0
				end
			wait.time(3);_f()
		end
		if string.find(w[0],"你身行向后一跃，跳出战圈不打了。\n.+ \-") then
			print("逃跑成功！")
			alias.yjl()
			selectRunSuccess=1
			checkmove.notgpsmove=1
			alias.resetidle()
			alias.checkbusy("escape")
		end
	end)
end
------------------------------------------------------------------------------------
-- fj_other
------------------------------------------------------------------------------------
function fj_other.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"有一天，你踩着七色云彩来迎娶『道象』") then
			_f=function() run("ask chanshi about 大还丹") end
			wait.time(1);_f()
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『渡难』") then
			_f=function() alias.checkbusy("putizi") end
			wait.time(1);_f()
		end
		if findstring(l,"你目前还没有任何为 busyover=putizi 的变量设定。") then
			alias.resetidle()
			run("ask nan about 菩提子")
		end
		if findstring(l,"渡难惨然一笑，接著长叹一声，从树洞里取出个白玉磁瓶，倒出菩提子递给你。") then
			run("fu zi")
			resetidle=0
		end
		if findstring(l,"渡难说道：菩提子乃天地之灵物，采集艰难无比，我这里现在可没有。") then
			closeclass("fj_other")
			_f=function() alias.startworkflow() end
			wait.time(1);_f()
		end
		if findstring(l,"你吃下一颗菩提子，顿然间只觉一股浩荡无比的真气直冲顶门") then
			_f=function()
						if addneili.putizi==nil then addneili.putizi=0 end
						if mark.neili==nil then mark.neili=0 end
						addneili.putizi=addneili.putizi+(hp.maxneili-mark.neili)
						-- #additem list.putizi {%concat( %time( "yyyy-mm-dd hh:mm:ss"), " 吃到菩提子，增加最大内力 ", %eval( @hp.maxneili-@mark.neili), " 点")}
						local _tmp=tonumber(hp.maxneili)-tonumber(mark.neili)
						addlog("吃到菩提子，增加最大内力 "..tostring(_tmp).."点")
				end
			wait.time(5);_f()
		end
		if findstring(l,"这里没有 nan 这个人。") then
			closeclass("fj_other")
			alias.startworkflow()
		end
		if findstring(w[0],"这里没有 chanshi 这个人。","你向道象禅师打听有关「大还丹」的消息。\n道象禅师说道：对不起，大还丹已经发完了") then
			alias.resetidle()
			run("hp")
			mark.neili=tonumber(hp.maxneili)
			alias.flytonpc("渡难")
		end
		--if findstring(l,"你口念咒语『神马都是浮云,虾米都是尘土』，『武庙』立马到达！") then
		--	run("put 5 silver in xiang")
		--	closeclass("fj_other")
		--	alias.startworkflow()
		--end
		if findstring(l,"你身上有血腥味，目前不允许进入该房间。") then
			closeclass("fj_other")
			alias.close_gps()
			alias.startworkflow()
		end
		if findstring(w[0],"你向道象禅师打听有关「大还丹」的消息。\n你获得一颗大还丹。") then
			alias.resetidle()
			run("fu dan")
			closeclass("fj_other")
			alias.startworkflow()
		end
		if findstring(w[0],"你向道象禅师打听有关「大还丹」的消息。\n道象禅师说道：.+你是不是刚吃过药，怎么又来要了？ 灵药多吃有害无宜，过段时间再来吧。") then
			alias.resetidle()
			closeclass("fj_other")
			alias.startworkflow()
		end
	end)
end
------------------------------------------------------------------------------------
-- fj_pre
------------------------------------------------------------------------------------
function fj_pre.dosomething1(n,l,w)
	local _f,a,b,c
	wait.make(function()
		if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
			alias.resetidle()
			alias.flytoid(me.fjbaseid)
		end
		a,b,c=string.find(l,"数码世界，数字地图，(%d+)就是这里！")
		if c~=nil and tonumber(c)==me.fjbaseid then
			if not isopen("dazuo") then
				if me.menpai=="mj" then run("fighter") end
				_f=function() run("ask "..me.fjmasterid.." about 门派任务") end
				wait.time(1);_f()
			end
		end
		a,b,c=string.find(l,"[> ]*(.+)拍了拍你的肩膀，说道：好，我有任务时自然会派人去通知你。")
		if c~=nil and c==me.fjmaster then
			alias.resetidle()
			if fjroom~=nil and string.len(fjroom)>0 and fjzone~=nil and string.len(fjzone)>0 then
				if fjweapon~=nil and string.len(fjweapon)>0 then
					if fjweapon=="staff" then alias.wi(staffid) else alias.wi(fjweapon) end
				end
				if fjroomid>0 then
					-- 可能出现做FJ死亡，直奔FJ房间ID
					alias.flytoid(fjroomid)
				else
					alias.flytoname(fjroom,fjzone)
					-- #if @explist.keephour {#add explist.tempinfo %concat( @fjzone, " ", @fjroom)}
				end
				closeclass("fj_pre")
				openclass("fj_start")
				fjarrived=0
			else
				if havefj>0 then
					-- 未获取到任务，稍等！
					_f=function() run("ask "..me.fjmasterid.." about 门派任务")	end
					wait.time(1);_f()
				else alias.startworkflow() end
			end
		end
		if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
			if not isopen("boat") then
				alias.resetidle()
				alias.checkitems()
			end
		end
		if findstring(l,"你目前还没有任何为 checkhp=addneili 的变量设定。") then
			if havefj>0 and hp.neili>(hp.maxneili*set_neili_job/100) then alias.tdz() end
		end
		if findstring(l,"对方正忙着呢，你等会儿在问话吧。") then
			alias.resetidle()
			if fjroom~=nil and string.len(fjroom)>0 and fjzone~=nil and string.len(fjzone)>0 then
				if fjweapon~=nil and string.len(fjweapon)>0 then
					if fjweapon=="staff" then alias.wi(staffid) else alias.wi(fjweapon) end
				end
				alias.flytoname(fjroom,fjzone)
				closeclass("fj_pre")
				openclass("fj_start")
				fjarrived=0
			else
				if havefj>0 then
					-- 未获取到任务，稍等！
					_f=function() run("ask "..me.fjmasterid.." about 门派任务")	end
					wait.time(1);_f()
				else alias.startworkflow() end
			end
		end
		a,b,c=string.find(l,"这里没有 (.+) 这个人。")			
		if c~=nil and c==me.fjmasterid then
			if fjroom~=nil and string.len(fjroom)>0 and fjzone~=nil and string.len(fjzone)>0 then
				if fjweapon~=nil and string.len(fjweapon)>0 then
					if fjweapon=="staff" then alias.wi(staffid) else alias.wi(fjweapon) end
				end
				if fjroomid>0 then
					-- 可能出现做FJ死亡，直奔FJ房间ID
					alias.flytoid(fjroomid)
				else
					alias.flytoname(fjroom,fjzone)
				end
				closeclass("fj_pre")
				openclass("fj_start")
				fjarrived=0
			else
				if havefj>0 then
					-- FJMaster被杀，等刷新！
					_f=function() run("ask "..me.fjmasterid.." about 门派任务")	end
					wait.time(5);_f()
				else alias.startworkflow() end
			end
		end
		if findstring(l,"你忙着呢，你等会儿在问话吧。") then
			alias.resetidle()
			if fjroom~=nil and string.len(fjroom)>0 and fjzone~=nil and string.len(fjzone)>0 then
				if fjweapon~=nil and string.len(fjweapon)>0 then
					if fjweapon=="staff" then alias.wi(staffid) else alias.wi(fjweapon) end
				end
				if fjroomid>0 then
					-- 可能出现做FJ死亡，直奔FJ房间ID
					alias.flytoid(fjroomid)
				else
					alias.flytoname(fjroom,fjzone)
					-- #if @explist.keephour {#add explist.tempinfo %concat( @fjzone, " ", @fjroom)}
				end
				closeclass("fj_pre")
				openclass("fj_start")
				fjarrived=0
			else
				if havefj>0 then
					-- 未获取到任务，稍等！
					_f=function() run("ask "..me.fjmasterid.." about 门派任务")	end
					wait.time(2);_f()
				else alias.startworkflow() end
			end
		end
	end)
end
------------------------------------------------------------------------------------
-- fj_start
------------------------------------------------------------------------------------
function fj_start.dosomething1(n,l,w)
	local _f,_t,_tb,a,b,c,d
	wait.make(function()
		if findstring(l,"你察觉四周好像有些不对劲") then
			alias.resetidle()
			if jifa.forcename=="xuanyinzhenqi" then run("yun yin") end
			if jifa.forcename=="huntianqigong" then run("yun powerup") end
			if me.menpai=="mj" then run("shoutfighter fighter") end
			if me.menpai=="bt" then alias.yunbt() end
			if me.menpai=="em" then alias.yunem() end
			if me.menpai=="xs" then run("yun longxiang") end
			if me.menpai=="xx" then
				xx.suck=0
				run("yun hua;blow di")
			end
			if fjarrived>0 then
				fjroomid=tonumber(roomno_now)
				fj.roomno=tonumber(roomno_now)
				escape=alias.SafeEntrance(roomno_now)
				_f=function()
							looknpc=1
							run("set checklooknpc=yes")
					end
				wait.time(1);_f()
				if tonumber(roomno_now)==1529 or tonumber(roomno_now)==1530 then
					-- 少林寺的两个山路出口一定会变化，返回需要特殊处理
					escape_err=1
				else escape_err=0 end
				-- 找到目标，设定当前为fj地点，死后回来捡东西，同时停止搜索
			else
				-- 出现未到达FJ搜索起始区域，但路过的地点是FJ地点情况，不设置fjroomid，等flytonext搜索到
				if fjweapon~=nil and string.len(fjweapon)>0 then
					if me.menpai=="hs" then
						_tb=utils.split(fjpfm,"|")
						if findstring(_tb[pfmid],"leidong") then
							alias.uw()
							if me.master=="风清扬" and fjweapon=="jian" then run("jifa dodge dugu-jiujian") else run("jifa parry pishi-poyu") end
						else
							if fjweapon=="staff" then alias.wi(staffid) else alias.wi(fjweapon) end
							wieldweapon=1
							if me.master=="风清扬" and fjweapon=="jian" then run("jifa dodge dugu-jiujian")
							else
								if fjweapon=="jian" then run("jifa parry huashan-jianfa")
								else
									if fjweapon=="staff" or fjweapon=="qin" then run("jifa parry jinhua-zhang") end
								end
							end
						end
					else
						if fjweapon=="staff" then alias.wi(staffid) else alias.wi(fjweapon) end
					end
				else alias.uw() end
			end
		end
		a,b,c,d=string.find(l,"“受死吧，(.+)！”(.+)大声吼道。")
		if c~=nil and d~=nil and c==me.charname and d==me.fjnpcname then
			alias.resetidle()
			if fjroomid==0 and fjarrived>0 then
				-- 你察觉四周好像有些不对劲.....这句话没有出现，比如九十九道拐找蟒蛇跑很多的情况下，设置当前房间为fj房间
				fjroomid=tonumber(roomno_now)
				fj.roomno=tonumber(roomno_now)
				escape=alias.SafeEntrance(roomno_now)
			end
			fjselectnpc.weapon=1
			if fjroomid==609 then
				-- 防止峨嵋per的强盗导致触发紊乱
				_tb=utils.split(me.fjnpcid,"|")
				run("look ".._tb[1])
			else run("look "..me.fjnpcid) end
			alias.close_gps()
			if fjarrived==0 then
				print("路过的地方出现fjnpc，杀完后需要重新look地点定位")
				checkmove.NotGPSMove=1
			end
			run("set checkmenpai=yes")
		end
		if findstring(l,"你目前还没有任何为 checkmenpai=yes 的变量设定。") then
			alias.resetidle()
			if hp.healthqi<90 or hp.neili<(hp.maxneili*set_neili_job/100) then
				-- 健康状态不好，不杀
				openclass("fj_escape")
				run("halt")
				if me.menpai=="em" then run("persuade "..me.fjnpcid) end
				run("go "..escape)
				checkmove.notgpsmove=1
				selectRunSuccess=0
				if fjroomid==609 then
					-- 防止峨嵋per的强盗导致触发紊乱
					_tb=utils.split(me.fjnpcid," ")
					run("doufu ".._tb[1])
				else
					run("doufu "..me.fjnpcid)
				end
			else
				fjnpc=fjselectnpc.menpai.." "..case_weapon(fjselectnpc.weapon)
				--#if @debug {#say NPC=@fj.npc，%if( selectfjnpc(), 杀, 不杀)}
				if selectfjnpc()>0 then
					addlog("FJ Place="..fj.room.."|"..fj.zone..",NPC="..fjnpc)
					--  #if @explist.keephour {#add explist.tempinfo %concat( " NPC=", @fj.npc)}
					if jifa.forcename=="hunyuanyiqi" and fjselectnpc.menpai=="xx" and fjselectnpc.weapon==7 then
						run("yun sangong")
						reyun=0
					else
						_tb=utils.split(fjyun,"|")
						for k,v in ipairs(_tb) do run(v) end
						reyun=0
					end
					if fjselectnpc.weapon==1 or kmq() or (me.menpai=="gb" and jifa.forcename=="huntianqigong") then
						run("unset no_parry")
					else
						if me.master=="风清扬"and fjweapon=="jian" then run("unset no_parry") else run("set no_parry 1") end
					end
					openclass("kill")
					openclass("kill_"..me.menpai)
					closeclass("kill_run")
					AddTimer("kill_timer", 0, 0, 2, "", timer_flag.Enabled + timer_flag.Replace, "kill.timer")
					SetTimerOption("kill_timer", "group", "kill")
					runaway=false
					npcfaint=false
					killRunSuccess=false
					if me.menpai=="hs" then
						if stat.leidong>0 then
							pfmid=2
							if fjweapon=="staff" then alias.wi(staffid) else alias.wi(fjweapon) end
							wieldweapon=1
						else
							pfmid=1
							alias.uw()
						end
					else
						pfmid=1
						if string.len(fjweapon)>0 then
							if fjweapon=="staff" then alias.wi(staffid) else alias.wi(fjweapon) end
						else alias.uw() end
					end
					if fjroomid==609 then
						-- 防止峨嵋per的强盗导致触发紊乱
						_tb=utils.split(me.fjnpcid," ")
						killid=_tb[1]
					else
						killid=me.fjnpcid
					end
					killname=me.fjnpcname
					killskill=fjweapon
					killpfm=fjpfm
					killyun=fjyun
					killjiali=fjjiali
					killjiajin=fjjiajin
					--if me.menpai=="dl" then alias.jfdl() end
					run("jiali "..fjjiali..";jiajin "..fjjiajin)
					if me.menpai=="bt" then run("convert staff;attack "..me.fjnpcid) end
					if me.menpai=="mj" then run("order fighter do attack "..me.fjnpcid..";order fighter 2 do attack "..me.fjnpcid) end
					if fjroomid==609 then
						-- 防止峨嵋per的强盗导致触发紊乱
						_tb=utils.split(me.fjnpcid," ")
						run("kill ".._tb[1])
					else
						run("kill "..me.fjnpcid)
					end
					--_tb=utils.split(fjpfm,"|")
					--_tb=utils.split(killpfm,"|")
					alias.pfm()
					--if pfmid<=table.getn(_tb) then
						--if kmq() then alias.kmq()
						--else
						--	_tb=utils.split(killpfm,"|")
						--	run(_tb[pfmid].." "..killid)
						--end
					--end
					run("set checkkillstart=yes")
				else
					openclass("fj_escape")
					run("halt")
					if me.menpai=="em" then run("persuade "..me.fjnpcid) end
					run("go "..escape)
					checkmove.notgpsmove=1
					selectRunSuccess=0
					if fjroomid==609 then
						-- 防止峨嵋per的强盗导致触发紊乱
						_tb=utils.split(me.fjnpcid," ")
						run("doufu ".._tb[1])
					else
						run("doufu "..me.fjnpcid)
					end
				end
			end
		end
		a,b,c,d=string.find(l,"(.+)弟子 (.+)%(.+%)$")
		if c~=nil and d~=nil and d==me.fjnpcname then
			if findstring(c,"大理段家") then fjselectnpc.menpai="dl" end
			if findstring(c,"全真教") then fjselectnpc.menpai="qz" end
			if findstring(c,"武当派") then fjselectnpc.menpai="wd" end
			if findstring(c,"少林派") then fjselectnpc.menpai="sl" end
			if findstring(c,"桃花岛") then fjselectnpc.menpai="th" end
			if findstring(c,"峨嵋派") then fjselectnpc.menpai="em" end
			if findstring(c,"华山派") then fjselectnpc.menpai="hs" end
			if findstring(c,"星宿派") then fjselectnpc.menpai="xx" end
			if findstring(c,"白驼山") then fjselectnpc.menpai="bt" end
			if findstring(c,"雪山派") then fjselectnpc.menpai="xs" end
			if findstring(c,"密宗") then fjselectnpc.menpai="xs" end
			if findstring(c,"丐帮") then fjselectnpc.menpai="gb" end
		end
		a,b,c,d=string.find(l,"浮云朵朵飘，飘到了 (%d+) 个『.+』中的第 (%d+) 个～～")
		if c~=nil and d~=nil and tonumber(c)==tonumber(flytosum) and tonumber(d)==tonumber(flytoidx) then
			alias.resetidle()
			fjarrived=1
			killstart=0
			if fjroomid>0 then
				fjroomid=tonumber(roomno_now)
				fj.roomno=tonumber(roomno_now)
				escape=alias.SafeEntrance(roomno_now)
			end
			_f=function()
						if fjroomid==0 then
							if flytoidx==flytosum then
								-- 最后一个房间也没找到fjnpc时从第一个开始走过
								alias.checkbusy("refly")
							else alias.checkbusy("flytonext") end
						end
				end
			wait.time(4);_f()
		end
		if findstring(l,"你口念咒语『神马都是浮云,虾米都是尘土』，『.+』立马到达！") then
			alias.resetidle()
			fjarrived=1
			killstart=0
			fjroomid=tonumber(roomno_now)
			fj.roomno=tonumber(roomno_now)
			escape=alias.SafeEntrance(roomno_now)
		end
		a,b,c=string.find(l,"□(.+)%(.+%)")
		if c~=nil then
			if not findstring(c,"皮背心") then
				if findstring(c,"剑") then fjselectnpc.weapon=2 end
				if findstring(c,"箫") then fjselectnpc.weapon=3 end
				if findstring(c,"刀") then fjselectnpc.weapon=4 end
				if findstring(c,"棒") then fjselectnpc.weapon=5 end
				if findstring(c,"轮") then fjselectnpc.weapon=6 end
				if findstring(c,"杖") then fjselectnpc.weapon=7 end
				if findstring(c,"鞭") then fjselectnpc.weapon=8 end
			end
		end
		if findstring(l,"你目前还没有任何为 killover=yes 的变量设定。") then
			run("get gold from corpse;get beixin from corpse;drop beixin;drop beixin;get beixin;wear all")
			fjzone=""
			fjroom=""
			fjarea=""
			fjroomid=0
			alias.yjl()
			alias.flytoid(me.fjbaseid)
		end
		a,b,c=string.find(l,"数码世界，数字地图，(%d+)就是这里！")
		if c~=nil and tonumber(c)==me.fjbaseid then
			alias.resetidle()
			run("set checkfj=over")
		end
		if c~=nil and tonumber(c)==fjroomid then
			alias.resetidle()
			fjarrived=1
			fjroomid=tonumber(roomno_now)
			fj.roomno=tonumber(roomno_now)
			escape=alias.SafeEntrance(roomno_now)
		end
		if findstring(l,"你目前还没有任何为 checkgxd=yes 的变量设定。") then
			if gxd.type==1 then
				if me.menpai=="hs" and me.master~="风清扬" then run("nick $HIM$非风$HIW$不放弃MUSH：$HIR$"..gxd.me) end
			end
			if gxd.type==2 then
				if gxd.me==nil then gxd.me=0 end
				if gxd.me>gxd.value then
					if me.menpai=="hs" and me.master~="风清扬" then run("nick $HIM$非风$HIW$固定MUSH：$HIR$"..gxd.me) end
					_t=fangqivalue()
					if _t>0 then
						for i=1,_t,1 do
							run("ask "..me.fjmasterid.." about 要事在身;ask "..me.fjmasterid.." about 门派任务")
						end
						gxd.me=gxd.me-10*_t
					end
				end
			end
			if gxd.type==3 then
				if gxd.me==nil then gxd.me=0 end
				if gxd.mp==nil then gxd.mp=100000 end
				if gxd.me>(gxd.mp*gxd.percent/100) then
					if me.menpai=="hs" and me.master~="风清扬" then run("nick $HIM$非风$HIW$保持MUSH：$HIR$"..gxd.percent.."%$HIW$值为$HIR$"..gxd.me) end
					_t=fangqipercent()
					if _t>0 then
						for i=1,_t,1 do
							run("ask "..me.fjmasterid.." about 要事在身;ask "..me.fjmasterid.." about 门派任务")
						end
						gxd.me=gxd.me-10*_t
					end					
				end
			end
			alias.checkexp("fj")
		end
		if findstring(l,"你目前还没有任何为 checkexpover=fj 的变量设定。") then
			alias.resetidle()
			if me.menpai=="sl" then
				openclass("fj_other")
				alias.flytonpc("道象")
			else
				if me.menpai=="bt" and mpJobLimited>0 and ((add.exp-fjexp)>10 or mpLimited.mpexp<me.menpaiLimited) then
					-- 说明bite or xy未满
					mpJobLimited=0
					xy.xyLimited=0
					xy.biteLimited=0
					if xy.limitedResume>=5 then xy.limitedResume=xy.limitedResume-1 end
				end
			if me.menpai=="mj" and hp.pot<hp.maxpot then run("ask yang xiao about 奖励") end
			alias.startworkflow()
			end									
		end
		if findstring(l,"你目前还没有任何为 busyover=flytonext 的变量设定。") then
			alias.flytonext()
		end
		if findstring(l,"你目前还没有任何为 checkfj=over 的变量设定。") then
			-- 等待获取任务完成经验
			_f=function() if havefj>0 then run("set checkfj=over") else run("ask "..me.fjmasterid.." about 贡献度;set checkgxd=yes") end end
			wait.time(1);_f()
		end
		if findstring(l,"你目前还没有任何为 checkkillstart=yes 的变量设定。") then
			if killstart==0 then
				_f=function() run("set checkmenpai=yes") end
				wait.time(2);_f()
			end
			killaction=""
		end
		if findstring(l,"你目前还没有任何为 busyover=refly 的变量设定。") then
			if havefj>0 then alias.flytoname(fjroom,fjzone) else alias.startworkflow() end
		end
		if findstring(l,"你目前还没有任何为 checklooknpc=yes 的变量设定。") then
			if looknpc==nil or looknpc==0 then
				-- 错过fj地点，从第一个开始走过
				alias.checkbusy("refly")
			end
		end
		if findstring(l,"你要看什么？") then
			if not isopen("fj_escape") then
				looknpc=0
				print("网络卡，出npc的房间已经飞过了")
			end
		end
		a,b,c=string.find(l,"你对著(.+)喝道：「.+」")
		if c~=nil and c==me.fjnpcname then
			killstart=1
		end
	end)
end
function selectfjnpc()
	local _tb
	_tb=utils.split(fjselectnpc[fjselectnpc.menpai],"|")
	return tonumber(_tb[fjselectnpc.weapon])
end
function fangqivalue()
	local a,b,c
	a=math.fmod(gxd.me-gxd.value,10)
	if a>0 then b=1 else b=0 end
	c=(gxd.me-gxd.value)/10+b
	if c>5 then c=5 end
	return math.floor(c)
end
function fangqipercent()
	local a,b,c
	a=math.fmod(gxd.me-gxd.mp*gxd.percent/100,10)
	if a>0 then b=1 else b=0 end
	c=(gxd.me-gxd.mp*gxd.percent/100)/10+b
	if c>5 then c=5 end
	return math.floor(c)
	
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function fj.update()
	_tb={
		"你察觉四周好像有些不对劲\\.\\.\\.\\.\\.\\.",
		"“受死吧，(.+)！”(.+)大声吼道。",
		"你目前还没有任何为 checkmenpai=yes 的变量设定。",
		"(.+)弟子 (.+)\\(.+\\)",
		"浮云朵朵飘，飘到了 \\d+ 个『.+』中的第 \\d+ 个～～",
		"你口念咒语『神马都是浮云,虾米都是尘土』，『.+』立马到达！",
		"\\s+□(.+)\\(.+\\)",
		"你目前还没有任何为 killover=yes 的变量设定。",
		"数码世界，数字地图，(\\d+)就是这里！",
		"你目前还没有任何为 checkgxd=yes 的变量设定。",
		"你目前还没有任何为 checkexpover=fj 的变量设定。",
		"你目前还没有任何为 busyover=flytonext 的变量设定。",
		"你目前还没有任何为 checkfj=over 的变量设定。",
		"你目前还没有任何为 checkkillstart=yes 的变量设定。",
		"你目前还没有任何为 busyover=refly 的变量设定。",
		"你目前还没有任何为 checklooknpc=yes 的变量设定。",
		"你要看什么？",
		"你对著(.+)喝道：「.+」",
	}
	local  fj_start_triggerlist={
	       {name="fj_start_dosth1",regexp=linktri(_tb),script=function(n,l,w)    fj_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(fj_start_triggerlist) do
		addtri(v.name,v.regexp,"fj_start",v.script,v.line)
	end
	closeclass("fj_start")
	
	_tb={
		"你目前还没有任何为 dealwithitems=over 的变量设定。",
		"数码世界，数字地图，(\\d+)就是这里！",
		"(.+)拍了拍你的肩膀，说道：好，我有任务时自然会派人去通知你。",
		"你目前还没有任何为 dazuo=over 的变量设定。",
		"你目前还没有任何为 checkhp=addneili 的变量设定。",
		"对方正忙着呢，你等会儿在问话吧。",
		"这里没有 (.+) 这个人。",
		"你忙着呢，你等会儿在问话吧。",
	}
	local  fj_pre_triggerlist={
	       {name="fj_pre_dosth1",regexp=linktri(_tb),script=function(n,l,w)    fj_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(fj_pre_triggerlist) do
		addtri(v.name,v.regexp,"fj_pre",v.script,v.line)
	end
	closeclass("fj_pre")
	
	local _tb={
		"你向道象禅师打听有关「大还丹」的消息。\\n道象禅师说道：对不起，大还丹已经发完了\\Z",
		"你向道象禅师打听有关「大还丹」的消息。\\n你获得一颗大还丹。\\Z",
		"你向道象禅师打听有关「大还丹」的消息。\\n道象禅师说道：.+你是不是刚吃过药，怎么又来要了？ 灵药多吃有害无宜，过段时间再来吧。\\Z",
	}
	local  fj_other_m_triggerlist={
	       {name="fj_other_m_dosth1",line=2,regexp=linktri(_tb),script=function(n,l,w)    fj_other.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(fj_other_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"fj_other",v.script,v.line)
	end
	
	_tb={
		"有一天，你踩着七色云彩来迎娶『道象』",
		"有一天，你踩着七色云彩来迎娶『渡难』",
		"你目前还没有任何为 busyover=putizi 的变量设定。",
		"渡难惨然一笑，接著长叹一声，从树洞里取出个白玉磁瓶，倒出菩提子递给你。",
		"渡难说道：菩提子乃天地之灵物，采集艰难无比，我这里现在可没有。",
		"你吃下一颗菩提子，顿然间只觉一股浩荡无比的真气直冲顶门",
		"这里没有 nan 这个人。",
		"这里没有 chanshi 这个人。",
		"你口念咒语『神马都是浮云,虾米都是尘土』，『武庙』立马到达！",
		"你身上有血腥味，目前不允许进入该房间。",
	}
	local  fj_other_triggerlist={
	       {name="fj_other_dosth1",regexp=linktri(_tb),script=function(n,l,w)    fj_other.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(fj_other_triggerlist) do
		addtri(v.name,v.regexp,"fj_other",v.script,v.line)
	end
	closeclass("fj_other")
	
	local _tb={
		"你身行向后一跃，跳出战圈不打了。\\n.+ \\-.*\\Z",
	}
	local  fj_escape_m_triggerlist={
	       {name="fj_escape_m_dosth1",line=2,regexp=linktri(_tb),script=function(n,l,w)    fj_escape.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(fj_escape_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"fj_escape",v.script,v.line)
	end
	
	_tb={
		"你在(.+)的耳边悄声说道：你不是我的菜！",
		"你要对谁做 doufu 这个动作？",
		"你目前还没有任何为 busyover=escape 的变量设定。",
		"你目前还没有任何为 dazuo=over 的变量设定。",
		"\\s+(.+)正在运功疗伤。",
		"\\s+.+弟子 (.+)\\(*\\) <战斗中>",
		"\\s+.+弟子 (.+)\\(*\\) <昏迷不醒>",
		"\\s+.+弟子 (.+)\\(*\\)$",
		"你目前还没有任何为 checknpcleave=yes 的变量设定。",
		"你要看什么？",
		"你要往哪个方向走？",
		"这个方向没有出路。",
		"这里空气不好，不能打坐。",
		"战斗中不能练内功，会走火入魔。",
		"你吐气纳息，硬生生地将内息压了下去，缓缓站了起来。",
		"\\s+这里.{4}的出口是 (.+)。$",
		"你目前还没有任何为 resetSafe=yes 的变量设定。",
		"糟糕，你逃跑失败了！",
		"你的动作还没有完成，不能移动。",
		"你目前还没有任何为 check=escapeback 的变量设定。",
		"少林弟子岂可贪生怕死，以坠本派声名！",
		"你深情地对(.+)唱道：走千山万里路，读千册万卷书，都不如靠近吃你两块豆腐！",
		"忽然一阵腥风袭来，一条巨蟒从身旁大树上悬下，把你卷走了。",
	}
	local  fj_escape_triggerlist={
	       {name="fj_escape_dosth1",regexp=linktri(_tb),script=function(n,l,w)    fj_escape.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(fj_escape_triggerlist) do
		addtri(v.name,v.regexp,"fj_escape",v.script,v.line)
	end
	closeclass("fj_escape")
	
	_tb={
		"数码世界，数字地图，(\\d+)就是这里！",
		"你向(.+)打听有关「要事在身」的消息。",
	}
	local  fj_close_triggerlist={
	       {name="fj_close_dosth1",regexp=linktri(_tb),script=function(n,l,w)    fj_close.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(fj_close_triggerlist) do
		addtri(v.name,v.regexp,"fj_close",v.script,v.line)
	end
	closeclass("fj_close")
	
	local _tb={
		"(.+)(对你点了点头|拍了拍你的头|回过头看了你一眼|拍拍你的肩|对你「嘿嘿嘿」奸笑了几声).+说道：“(.+)，.+\\n(.+)说道:“近日在(.+)附近.*\\Z",
	}

	local  fj_watch_m_triggerlist={
	       {name="fj_watch_m_dosth1",line=2,regexp=linktri(_tb),script=function(n,l,w)    fj_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(fj_watch_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"fj_watch",v.script,v.line)
	end
	
	_tb={
		"唉！你耽误的时间太久了，这次任务取消了。",
		"一个.+弟子走了过来,对你报拳道：“在下奉(.+)之命，请你速回.+处晋见”。",
		"(.+)已派你去(.+)附近完成重要任务，赶快去执行吧。",
		"任务已经完成，赶快回去复命吧。",
		"(.+)对你说道：目前我.+的贡献度为(.+)点。",
		"(.+)对你说道：你为.+所做的贡献为(.+)点。你要继续努力，争取在下次.+大会上得到最佳评定。",
		"(.+)已传令要召见你，你还是快点去吧。",
		"(.+)说道:“辛苦你了，(.+)，你为.+立下了一功。”",
		"你的经验上升了(\\d+)点。",
		"(.+)说道:“干得好，(.+)，老仙我越来越欣赏你了。”",
	}
	local  fj_watch_triggerlist={
	       {name="fj_watch_dosth1",regexp=linktri(_tb),script=function(n,l,w)    fj_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(fj_watch_triggerlist) do
		addtri(v.name,v.regexp,"fj_watch",v.script,v.line)
	end
	openclass("fj_watch")
end

fj.update()
