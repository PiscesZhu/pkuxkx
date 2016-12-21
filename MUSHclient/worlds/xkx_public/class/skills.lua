skills={}
skills_xue_cls={}
skills_ask={}
skills_lian={}
skills_lingwu_cls={}
skills_jingyao={}

if me==nil then me={} end
if me.master==nil then me.master="" end
if me.masterid==nil then me.masterid="" end
if me.litmaster==nil then me.litmaster="" end
if me.litmasterid==nil then me.litmasterid="" end
------------------------------------------------------------------------------------
-- skills_xue_cls
------------------------------------------------------------------------------------
function skills_xue_cls.dosomething1(n,l,w)
	local _f,_tb,a,b,c,d
	wait.make(function()
		if findstring(l,"你向"..me.master.."打听有关「好好学习，天天向上！」的消息。","你向"..me.litmaster.."打听有关「好好学习，天天向上！」的消息。") then
			alias.xuemaster()
		end
		if findstring(l,"你把正在运行的真气强行压回丹田，站了起来。") then
			if havefj>0 then
				alias.close_dz()
				alias.uw()
				run("set startworkflow=yes")
			else
				if me.menpai=="wd" and wx.taiji==0 then
					alias.close_dz()
					alias.wi("jian")
					run("yun taiji")
					alias.checkbusy("taijistart")
				else run("yun regenerate;hp;set check=neili") end
			end
		end
		if findstring(l,"你吐气纳息，硬生生地将内息压了下去，缓缓站了起来。","你现在精神不佳，无法定下心来思考！","你的精太低了") then
			if havefj>0 then
				alias.uw()
				run("yun regenerate;set startworkflow=yes")
			else
				run("yun regenerate;hp;set check=neili")
			end
		end
		if findstring(l,"你的潜能不够，没有办法再成长了。","学习知识需要在书院方能静心学习。","你的潜能不足") then
			alias.ch()
			closeclass("skills_ask")
			run("set xue=over")
		end
		if findstring(l,"你听了.+的讲解，似乎有所理解，却又不能完全体会其中的深意。","你听了老半天，绞尽了脑汁也无法体会.+所讲关于.+的精要。","你仔细听着.+的讲解，细心领悟着其中的奥妙所在。","你开始向.+请教有关「.+」的疑问。") then
			alias.resetidle()
		end
		if findstring(l,"{你向杨逍打听有关","你与杨逍共同参悟","你潜心苦思","你心浮气躁","你只觉得灵台一片清明","你左思右想") then
			alias.resetidle()
		end
		if findstring(l,"你的实战经验还不足，不能继续学习这项技能！","这项技能你的程度已经不输你师父了。","这项技能你恐怕必须找别人学了。","你体内不同内力互相冲撞，难以领会更高深的内功。","你的内功水平已无法借由学习提升。","你对毒术缺乏实际应用，难以继续提高。","你体内聚毒过多，难以继续提高。","学化功大法，要心狠手辣，奸恶歹毒，你可做得不够呀！","不能传授你这项武功","也许是缺乏实战经验") then
			alias.resetidle()
			if skills_num==nil then skills_num=1 end
			skills_num=skills_num+1
			_tb=utils.split(skills_xue,"|")
			if skills_num>table.getn(_tb) or (xuelit>0 and daytime) then
				skillsfull=1
				if xuelit>0 then havegoldxuelit=0;xuelit=0 end
				run("set xue=over")
			else alias.xuemaster() end
		end
		if findstring(l,"你目前还没有任何为 busyover=taijiover 的变量设定。") then
			run("yun regenerate;hp;set check=neili")
		end
		if findstring(l,"你目前还没有任何为 busyover=taijistart 的变量设定。") then
			alias.xuemaster()
		end
		if findstring(l,"你目前还没有任何为 check=masterid 的变量设定。") then
			if me.masterid==nil or string.len(me.masterid)==0 then
				print("未获取到师傅的id，设置为领悟模式")
				usepot="lingwu"
				alias.startxue()
			else
				skills_num=1
				alias.xuemaster()
			end
		end
		if findstring(l,".+教导完毕，见你若有所悟，会心地点了点头。","你听了.+的指导，似乎有些心得。") then
			if me.menpai=="th" then run("huan all") end
			if havefj>0 then
				alias.uw()
				run("set startworkflow=yes")
			else
				if me.menpai=="wd" and wx.taiji==0 then
					alias.wi("jian")
					run("yun taiji")
					alias.checkbusy("taijistart")
				else
					if me.menpai=="em" then alias.yunem() end
					if hp.jing<(hp.maxjing/2) then run("yun regenerate") end
					run("hp;set check=neili")
					--run("yun regenerate;hp;set check=neili")
				end
			end
		end
		if findstring(l,".+说：钱财乃身外之物也～～～") then
			xuelit=0
			alias.ch()
			run("set xue=over")
		end
		if findstring(l,"你要向谁求教？") then
			if dummy.laopo~=nil and dummy.laopo~="" then dummy.laopo="" end
			alias.startworkflow()
		end
		--a,b,c,d=string.find(l,mj.master.."%s+=%s+(%w+)%s+(%w+),%s+")
		--if c~=nil and d~=nil then me.masterid=string.lower(c).." "..string.lower(d)	end
		a,b,c=string.find(l,me.master.."%s+=%s+%w+%s+%w+,%s+(%w+)")
		if c~=nil then me.masterid=string.lower(c) end
		if findstring(l,me.master.."摇了摇头，不想继续教了。",tostring(me.litmaster).."摇了摇头，不想继续教了。") then
			_f=function() alias.xuemaster() end
			wait.time(0.5);_f()
		end
		if findstring(l,me.master.."现在正忙着呢。",tostring(me.litmaster).."现在正忙着呢。") then
			_f=function() alias.xuemaster() end
			wait.time(0.5);_f()
		end
		if findstring(l,"你目前还没有任何为 checkhp=addneili 的变量设定。") then
			if havefj>0 and hp.neili>(hp.maxneili*set_neili_job/100) then alias.tdz() end
		end
		if findstring(l,"这里没有 "..tostring(me.masterid).." 这个人。","这里没有 "..tostring(me.litmasterid).." 这个人。") then
			if xuelit>0 and not daytime then
				-- 走到书院天黑
				alias.startworkflow()
			else
				-- 师傅没了，打坐吧
				alias.resetidle()
				alias.dz("addneili")
			end
		end
		if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
			if dummy.laopo~=nil and dummy.laopo~="" and roomname=="武馆休息室" then
				run("w");alias.xuemaster()
			elseif xuelit>0 and daytime then
				run("ask "..me.litmasterid.." about 好好学习，天天向上！")
			else
				run("ask "..me.masterid.." about 好好学习，天天向上！")
			end
			--if xuelit>0 then
			--	if daytime then
			--		run("ask "..me.litmasterid.." about 好好学习，天天向上！")
			--	else
			--		run("ask "..me.masterid.." about 好好学习，天天向上！")
			--	end
			--else run("ask "..me.masterid.." about 好好学习，天天向上！") end
		end
		if findstring(l,"你目前还没有任何为 xue=over 的变量设定。") then
			alias.close_xue()
			if dummy.laopo~=nil and dummy.laopo~="" then run("tell "..dummy.laopo.." over") end
			--if have.jingyao>0 then
			--	openclass("skills_jingyao")
			--	alias.dujingyao()
			--else
			--	mark.setpot=1
			--	alias.uw()
			--	alias.startworkflow()
			--end
			_tb=utils.split(skills_xue,"|")
			if skills_num>table.getn(_tb) then
				usepot="lingwu"
				alias.startxue()
			else
				alias.startworkflow()
			end
		end
		if findstring(l,"书院晚上不开，请天亮了再来！") then
			daytime=false
		end
		if findstring(l,"一个.+弟子走了过来,对你报拳道：“在下奉"..me.fjmasternick.."之命，请你速回.+处晋见”。") then
			run("halt")
		end
		if findstring(l,"你摇了摇头，看起来脑子里一团浆糊，需要休息一下。") then
			alias.resetidle()
			if me.menpai=="wd" then alias.checkbusy("taijiover")
			else run("yun regenerate;hp;set check=neili") end
		end
		if findstring(l,"你目前还没有任何为 check=neili 的变量设定。") then
			alias.resetidle()
			if havefj>0 then
				alias.uw()
				run("set startworkflow=yes")
			else
				if mpJobLimited==0 then
					if me.menpai=="wd" or xuefirst>0 or workflow.mp==0 or (me.menpai=="gb" and gold.num>= gold.setnum and 3600-(os.time()-mpLimited.MarkTime)>30) then
						alias.xuemaster()
					else
						alias.uw()
						run("set startworkflow=yes")
					end
				else alias.xuemaster() end
			end
		end
		if findstring(l,"你目前还没有任何为 startworkflow=yes 的变量设定。") then
			alias.resetidle()
			mark.setpot=1
			alias.close_dz()
			alias.startworkflow()
		end
		if findstring(l,"练.+必须空手。") then
			alias.resetidle()
			alias.uw()
			alias.xuemaster()
		end
		if findstring(l,"双飞，三飞，大家一起飞，先×%d+ 个『 "..me.master.." 』中的第 %d+ 个～～") then
			skills_num=1
			if me.masterid==nil or string.len(me.masterid)==0 then
				run("id here;set check=masterid")
			else run("ask "..me.masterid.." about 好好学习，天天向上！") end
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『"..tostring(me.master).."』","有一天，你踩着七色云彩来迎娶『"..tostring(me.master).."』") then
			skills_num=1
			wx.taiji=0
			wx.zhixin=0
			if me.masterid==nil or string.len(me.masterid)==0 then
				run("id here;set check=masterid")
			else
				run("ask "..me.masterid.." about 好好学习，天天向上！")
			end
		end
		if findstring(l,"数码世界，数字地图，"..tostring(me.masterroom).."就是这里！") then
			skills_num=1
			wx.taiji=0
			wx.zhixin=0
			if me.masterid==nil or string.len(me.masterid)==0 then
				run("id here;set check=masterid")
			else
				run("ask "..me.masterid.." about 好好学习，天天向上！")
			end
		end
		if findstring(l,"你口念咒语『神马都是浮云,虾米都是尘土』，『武馆休息室』立马到达！") then
			alias.xuemaster()
		end
		if findstring(l,"你尚未领会到太极拳旨。") then
			wx.taiji=-1
		end
		if findstring(l,"你大周天搬运完毕，将内力合于丹田，入窍归元。") then
			wx.taiji=0
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『"..me.litmaster.."』") then
			wx.taiji=0
			wx.zhixin=0
			if me.litmasterid=="zhu" then daytime=true end
			run("ask "..me.litmasterid.." about 好好学习，天天向上！")
		end
		if findstring(l,"你微微一笑，身子缓缓右转，左手持剑向上提起，剑身横於胸前，左右双掌掌心相对，如抱圆球。","你已经将太极心法融会入武功之中。") then
			wx.taiji=1
		end
	end)
end
------------------------------------------------------------------------------------
-- skills_ask
------------------------------------------------------------------------------------
function skills_ask.timer()
	run("ask "..me.masterid.." about ".._tb[skills_num])
end
------------------------------------------------------------------------------------
-- skills_lian
------------------------------------------------------------------------------------
function skills_lian.dosomething1(n,l,w)
	local _f,_tb
	wait.make(function()
		if findstring(l,"练.+必.+空手") then
			alias.resetidle()
			alias.uw()
			--weapon_id=weapon_id+1
			if me.master=="风清扬" then run("jifa dodge dugu-jiujian") end
			_f=function() alias.lianskills() end
			wait.time(1);_f()
		end
		if findstring(l,"你不能通过练习招架来提高这项技能","寒冰绵掌必须通过特殊的法门才能修炼。","你手中没有龙象般若经做参照，再怎么练也没用！","化功大法只能用学(learn)的来增加熟练度。") then
			alias.resetidle()
			skills_num=skills_num+1
			alias.lianskills()
		end
		if findstring(l,"已经练习到顶峰了，必须先打好基础才能继续提高") then
			alias.resetidle()
			if isopen("skills_lingwu") then
				_tb=utils.split(skills_lingwu,"|")
				if _tb[skills_num]=="force" then
					addforce=1
					skills_num=skills_num+1
				end
				alias.ch()
				run("set check=skills")
				if me.menpai=="bt" and roomno_now==me.menpailingwuid then run("hold yuanshi")
				elseif me.menpai=="xx" and roomno_now==me.menpailingwuid then run("kneel hassock")
				elseif me.menpai=="xs" and roomno_now==me.menpailingwuid then run("sit lianzuo")
				else alias.lingwuskills() end
			else
				skills_num=skills_num+1
				alias.lianskills()
			end
		end
		if findstring(l,"你的内力不够练","你的内力太低了。") then
			alias.resetidle()
			alias.tlw()
		end
		if findstring(l,"你使用的武器不对。") then
			_f=function()
						alias.uw()
						--weapon_id=weapon_id+1
						if me.master=="风清扬" and skillsfull==0 then run("jifa dodge dugu-jiujian") end
						_tb=utils.split(skills_lingwu,"|")
						if _tb[skills_num]=="sword" then
							if me.menpai=="th" then
								if have.xiao>0 then alias.wi("xiao") else skills_num=skills_num+1 end
							else
								if have.jian>0 then alias.wi("jian") else skills_num=skills_num+1 end
							end
						end
						if _tb[skills_num]=="blade" then
							if have.dao>0 then alias.wi("dao") else skills_num=skills_num+1 end
						end
						if _tb[skills_num]=="staff" then
							if have.staff>0 then alias.wi(staffid) else skills_num=skills_num+1 end
						end
						if _tb[skills_num]=="whip" then
							if have.whip>0 then alias.wi("bian") else skills_num=skills_num+1 end
						end
						if _tb[skills_num]=="stroke" then
							if have.bi>0 then alias.wi("bi") else skills_num=skills_num+1 end
						end
						if _tb[skills_num]=="hammer" then
							if have.falun~=nil and have.falun>0 then alias.wi("lun") else skills_num=skills_num+1 end
						end
						if _tb[skills_num]=="stick" then
							if have.stick>0 then alias.wi("bang") else skills_num=skills_num+1 end
						end
						alias.lianskills()
				end
			wait.time(0.5);_f()
		end
		if findstring(l,"你体内的真气不够。") then
			alias.tlw()
		end
		if findstring(l,"你修习完毕，深深吸了一口气，闭目而") then
			alias.resetidle()
			if me.menpai=="em" then alias.yunem() end
			alias.yjl()
			_tb=utils.split(skills_lingwu,"|")
			if _tb[skills_num]=="force" then run("yun recover") end
			if isopen("mp_xs_lzjob") or isopen("mp_gb_pre") then run("set lian=over") else run("hp;set lian") end
		end
		if findstring(l,"你只能练习用 enable 指定的特殊技能") then
			alias.resetidle()
			if isopen("mp_gb_pre") then
				closeclass("skills_lian")
				alias.uw()
				run("u")
				--lianwunum=0
				roomno_now=1116
				run("set lian=full")
			else run("set lian=over") end
		end
		if findstring(l,"你目前还没有任何为 lian 的变量设定。") then
			alias.resetidle()
			--if isopen("mp_xs_npc1") then run("sd;nu") end
			if hp.neili<(hp.maxneili*set_neili/100) then
				closeclass("skills_lian")
				alias.dz(set_neili)
			else
				if havefj>0 and isopen("skills_lingwu") and not isopen("boat") then
					alias.uw()
					run("set startworkflow=yes")
				else
					if mpJobLimited==0 then
						if me.menpai=="wd" or xuefirst>0 or workflow.mp==0 or isopen("mp_qz_start") or isopen("mp_xs_npc1") or isopen("mp_xs_lzjob") or (me.menpai=="gb" and gold.num>=gold.setnum and 3600-(os.time()-mpLimited.MarkTime)>30) or (me.menpai=="gm") then
							alias.lianskills()
						else
							--if isopen("mp_gb_pre") then
							--	if havefj>0 then
							--		alias.uw()
							--		alias.startworkflow()
							--	else
							--		lianwunum=lianwunum+1
							--		if lianwunum>lianwunum_set then
							--			run("u")
							--			lianwunum=0
							--			roomno_now=1116
							--			alias.tlw()
							--			else alias.lianskills() end
							--	end
							--else
								if not isopen("boat") then
									alias.uw()
									alias.startworkflow()
								else alias.lianskills() end
							--end
						end
					else
						-- mp上限
						alias.lianskills()
					end
				end
			end
		end
		if findstring(l,"金花杖法只能在实战中提高") then
			if skillslist["tianshan-zhang"]["lvl"]~=nil and skillslist["tianshan-zhang"]["lvl"]>0 then
				run("jifa staff tianshan-zhang")
				reEnableSkills=1
			else
				skills_num=skills_num+1
				alias.lianskills()
			end
		end
		if findstring(l,"你的基本功火候未到，必须先打好基础才能继续提高。") then
			alias.resetidle()
			if isopen("skills_lingwu") then alias.lingwuskills()
			else
				skills_num=skills_num+1
				alias.lianskills()
			end
		end
		if findstring(l,"你一挥手中的.+，开始练习.+。","你手中.+，几招后接着一招「.+」使出，如同行云流水。","你反复练习着.+中的「.+」，但却总是不得要领。","你舞着手中的.+, 如行云流水般地演练著.+中几个招式，完全不见滞怠。","你将.+一招一式的演练下来，虽然不见新意，但对招数的基本应用上又有所悟。","你顺著.+气息运行路线，将体内真气缓缓搬运了一个大周天。","你暗自气运丹田，聚精会神地修练着.+。") then
			alias.resetidle()
		end
		if findstring(l,"你必须先找一条鞭子才能练.+鞭法。") then
			alias.resetidle()
			alias.uw()
			alias.wi("bian")
			_f=function() alias.lianskills() end
			wait.time(1);_f()
		end
		if findstring(l,"蛤蟆从不手持兵刃，所以练.+也必须空手。") then
			alias.resetidle()
			alias.uw()
			--weapon_id=weapon_id+1
			_f=function() alias.lianskills() end
			wait.time(1);_f()
		end
	end)
end
------------------------------------------------------------------------------------
-- skills_lingwu_cls
------------------------------------------------------------------------------------
function skills_lingwu_cls.dosomething1(n,l,w)
	local _f,_tb,a,b,c,d,_t
	wait.make(function()
		if findstring(l,"你没有这么多潜能") then
			run("set lingwu=over")
		end
		if findstring(l,"你把正在运行的真气强行压回丹田，站了起来。") then
			if havefj>0 then
				alias.close_dz()
				alias.uw()
				if me.menpai=="bt" then run("release yuanshi") end
				if me.menpai=="qz" then run("return book") end
				if me.menpai=="em" or me.menpai=="xx" or me.menpai=="xs" then run("stand") end
				if me.menpai=="dl" then run("dismiss") end
				run("set startworkflow=yes")
			else run("yun regenerate;hp;set check=neili") end
		end
		if findstring(l,"你眉头紧锁，看来是领悟不得要领，拍拍衣袖站了起来。","你硬生生收回招式，不继续练习了。","你吐气纳息，硬生生地将内息压了下去，缓缓站了起来。","你硬生生将内息压回丹田，不继续修习了。") then
			if havefj>0 then
				alias.uw()
				if me.menpai=="bt" then run("release yuanshi") end
				if me.menpai=="qz" then run("return book") end
				if me.menpai=="em" or me.menpai=="xx" or me.menpai=="xs" then run("stand") end
				if me.menpai=="dl" then run("dismiss") end
				run("set startworkflow=yes")
			else run("yun regenerate;hp;set check=neili") end
		end
		if findstring(l,"你只能参悟本派的武功。") then
			_tb=utils.split(skills_lingwu,"|")
			if _tb[skills_num]=="force" then
				if me.menpai=="bt" then run("release yuanshi") end
				if me.menpai=="qz" then run("return book") end
				if me.menpai=="em" or me.menpai=="xx" or me.menpai=="xs" then run("stand") end
				if me.menpai=="dl" then run("dismiss") end
				alias.lianwu()
			else
				skillsfull=1
				if me.menpai=="hs" and me.master=="风清扬" then
					run("jifa dodge huashan-shenfa;jifa sword huashan-jianfa")
					skills_num=1
					reEnableSkills=1
					alias.lianwu()
				else run("set lingwu=over") end
			end
		end
		a,b,c,d=string.find(l,"%((%S+)%)%s+%-%s+%S+%s+(%d+)/")
		if c~=nil and d~=nil then
			if findstring(skills_lingwu,c) and skillsfull==1 then
				-- 检查是否还有低于最大等级的技能
				if tonumber(d)<tonumber(me.maxlvl) then skillsfull=0 end
			end
		end
		if findstring(l,"你目前还没有任何为 lingwu=over 的变量设定。") then
			if have.jingyao>0 then
				alias.uw()
				alias.close_xue()
				openclass("skills_jingyao")
				alias.dujingyao()
			else
				if me.menpai=="bt" then run("release yuanshi") end
				if me.menpai=="qz" then run("return book") end
				if me.menpai=="em" or me.menpai=="xx" or me.menpai=="xs" then run("stand") end
				if me.menpai=="dl" then run("dismiss") end
				run("set startworkflow=yes")
			end
		end
		if findstring(l,"文颖倒在地上，挣扎了几下就死了。") then
			if killwenying>0 then
				run("get jingyao from corpse;sit hassock;drop wuxue jingyao")
				killwenying=0
			end
		end
		if findstring(l,"此地无什特别之处，有什么好领悟的？") then
			checkmove.NotGPSMove=1
			if me.menpai=="wd" and lingwuat=="menpai" then
				run("look feng;look feng;look feng")
				alias.lingwuskills()
			--elseif me.menpai=="xs" and lingwuat=="menpai" then
			--	run("sit lianzuo")
			--	alias.lingwuskills()
			else
				_f=function() if havefj>0 then alias.startfj() else alias.startxue() end end
				wait.time(2);_f()
			end
		end
		if findstring(l,"先解散%(dismiss%)广场上的兵将再离开吧。") then
			run("dismiss")
		end
		if findstring(l,"站起来再走吧。","坐着走？") then
			run("stand")
		end
		if findstring(l,"一个.+弟子走了过来,对你报拳道：“在下奉"..me.fjmasternick.."之命，请你速回.+处晋见”。") then
			run("halt")
		end
		if findstring(l,"数码世界，数字地图，192就是这里") then
			alias.lianwu()
		end
		if findstring(l,"你要先坐下才能参悟。") then
			run("ask wenying about 武学精要;sit hassock;give wenying wuxue jingyao")
		end
		if findstring(l,"你拿了一本《武学大全》，放在桌上准备领悟","你拿著武学精要，在一旁的蒲团上坐了下来，准备开始领悟","你已经坐在一个蒲团上了。") then
			alias.lingwuskills()
		end
		if findstring(l,"你深思着所学的.+，潜心领悟有关.+的武学问题。","你坐立不安，潜心苦思.+上的难解之处。","你只觉得体内真气乱窜，.+中的招式象走马灯一般在面前显现！","你的大脑中一片空白。对.+是越想越糊涂。","你心中说不出的烦燥，对.+始终不得一解。","你拿手比划着，似乎对.+中的几个招数有所体会。","你你冥思苦想，对.+渐渐加深一层体会！") then
			alias.resetidle()
		end
		if findstring(l,"你的实战经验还不足，不能继续领悟这项技能","你这项基本技能已经炉火纯青，在这里领悟不到什么了。") then
			alias.resetidle()
			skills_num=skills_num+1
			alias.lingwuskills()
		end
		if findstring(l,"你不能自行修炼基本内功！") then
			alias.resetidle()
			skills_num=skills_num+1
			alias.ch()
			run("set check=skills")
			alias.lingwuskills()
		end
		if findstring(l,"地上已经没有剩余的圆石可供你倒立练功了。","已经坐在上面了！") then
			alias.resetidle()
			_t=tonumber(math.random(3))
			if _t==1 then run("emote 叫骂道：你他妈的能不能快点。mush～～") end
			if _t==2 then run("emote 喋喋不休：你怎么比猪还慢。mush～～") end
			if _t==3 then run("emote 嚷嚷道：忍不住了，该我上了吧。mush～～") end
			_f=function() alias.lianwu() end
			wait.time(2);_f()
		end
		if findstring(l,"已经跪在上面了！") then
			if roomno_now==2112 then alias.flytoid(2113)
			elseif roomno_now==2113 then alias.flytoid(2114)
			elseif roomno_now==2114 then alias.flytoid(2115)
			elseif roomno_now==2115 then alias.flytoid(2112)
			end
		end
		if findstring(l,"上乘功夫要颠倒过来练。你站得直直地怎么领悟功夫？") then
			alias.resetidle()
			run("use fire;hold yuanshi")
		end
		if findstring(l,"你已经跪在蒲团上面了。","你跪在大蒲团上，望著老仙的画像，若有所思。") then
			alias.resetidle()
			run("ketou hassock")
			alias.lingwuskills()
		end
		if findstring(l,"你的.+造诣不够，无法领悟更深一层的.+") then
			alias.resetidle()
			if me.menpai=="bt" then run("release yuanshi") end
			if me.menpai=="qz" then run("return book") end
			if me.menpai=="em" or me.menpai=="xx" or me.menpai=="xs" then run("stand") end
			if me.menpai=="dl" then run("dismiss") end
			alias.lianwu()
		end
		if findstring(l,"你左、右手各抓了块圆石，以手代脚，整个人倒立了起来。","香木不点自燃，你作明空想念，具正念正知，度化园满，入四禅定而般涅磐。") then
			alias.resetidle()
			alias.lingwuskills()
		end
		if findstring(l,"你必须有特殊武功方能与基本武技参照领悟") then
			alias.resetidle()
			skillsfull=1
			alias.ch()
			run("set check=lingwufull")
		end
		if findstring(l,"你目前还没有任何为 check=skills 的变量设定。") then
			alias.resetidle()
			if skillslist["hunyuan-yiqi"]==nil then skillslist["hunyuan-yiqi"]={} end
			if skillslist["hunyuan-yiqi"]["lvl"]==nil then skillslist["hunyuan-yiqi"]["lvl"]=0 end
			if skillslist["hunyuan-yiqi"]["sld"]==nil then skillslist["hunyuan-yiqi"]["sld"]=0 end
			if (skillslist["hunyuan-yiqi"]["lvl"]~=nil and skillslist["hunyuan-yiqi"]["lvl"]<me.maxlvl) and (skillslist["hunyuan-yiqi"]["sld"]~=nil and skillslist["hunyuan-yiqi"]["sld"]>=((skillslist["hunyuan-yiqi"]["lvl"]+1)*(skillslist["hunyuan-yiqi"]["lvl"]+1))) then
				zuochan=1
			end
		end
		if findstring(l,"你目前还没有任何为 check=neili 的变量设定。") then
			alias.resetidle()
			if havefj>0 then
				alias.uw()
				if me.menpai=="bt" then run("release yuanshi") end
				if me.menpai=="qz" then run("return book") end
				if me.menpai=="em" or me.menpai=="xx" or me.menpai=="xs" then run("stand") end
				if me.menpai=="dl" then run("dismiss") end
				run("set startworkflow=yes")
			else
				if mpJobLimited==0 then
					if me.menpai=="wd" or xuefirst>0 or workflow.mp==0 or (me.menpai=="gb" and gold.num>=gold.setnum and 3600-(os.time()-mpLimited.MarkTime)>30) then
						alias.lingwuskills()
					else
						alias.uw()
						if me.menpai=="bt" then run("release yuanshi") end
						if me.menpai=="qz" then run("return book") end
						if me.menpai=="em" or me.menpai=="xx" or me.menpai=="xs" then run("stand") end
						if me.menpai=="dl" then run("dismiss") end
						run("set startworkflow=yes")
					end
				else alias.lingwuskills() end
			end
		end
		if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
			alias.resetidle()
			if havefj>0 then
				alias.uw()
				if me.menpai=="bt" then run("release yuanshi") end
				if me.menpai=="qz" then run("return book") end
				if me.menpai=="em" or me.menpai=="xx" or me.menpai=="xs" then run("stand") end
				if me.menpai=="dl" then run("dismiss") end
				run("set startworkflow=yes")
			else
				if mpJobLimited==0 then
					if me.menpai=="wd" or xuefirst>0 or workflow.mp==0 or (me.menpai=="gb" and gold.num>=gold.setnum and 3600-(os.time()-mpLimited.MarkTime)>30) then
						alias.lingwuskills()
					else
						alias.uw()
						if me.menpai=="bt" then run("release yuanshi") end
						if me.menpai=="qz" then run("return book") end
						if me.menpai=="em" or me.menpai=="xx" or me.menpai=="xs" then run("stand") end
						if me.menpai=="dl" then run("dismiss") end
						run("set startworkflow=yes")
					end
				else alias.lingwuskills() end
			end
		end
		if findstring(l,"数码世界，数字地图，"..tostring(me.menpailingwuid).."就是这里！","数码世界，数字地图，2113就是这里！","数码世界，数字地图，2114就是这里！","数码世界，数字地图，2115就是这里！") then
			alias.resetidle()
			if havefj>0 then alias.close_xue()
			else
				skills_num=1
				_f=function()
							alias.ch()
							if me.menpai=="dl" then run("ask duan about 调阅")
							elseif me.menpai=="xx" then run("kneel hassock")
							else
								if me.master=="风清扬" then run("jifa dodge dugu-jiujian") end
								if me.menpai=="qz" then
									run("take book")
								elseif me.menpai=="xs" then
									run("sit lianzuo")
								else
									if me.menpai=="em" then
										killwenying=0
										run("ask wenying about 武学精要;sit hassock;give wenying wuxue jingyao")
									else alias.lingwuskills() end
								end
							end
					end
				wait.time(3);_f()
			end
		end
		if findstring(l,"你目前还没有任何为 check=lingwufull 的变量设定。") then
			alias.resetidle()
			if skillsfull==0 then
				skills_num=1
				alias.lingwuskills()
			else
				if me.menpai=="hs" and me.master=="风清扬" then
					run("jifa dodge huashan-shenfa;jifa sword huashan-jianfa")
					skills_num=1
					reEnableSkills=1
					alias.lianwu()
				else run("set lingwu=over") end
			end
		end
		if findstring(l,"你领悟完毕，拍拍衣袖站起身来。") then
			alias.resetidle()
			if me.menpai=="em" then alias.yunem() end
			run("yun regenerate;hp;set check=neili")
		end
		if findstring(l,"你目前还没有任何为 startworkflow=yes 的变量设定。") then
			alias.resetidle()
			mark.setpot=1
			alias.close_dz()
			usepot="xue"
			alias.startworkflow()
		end
		if findstring(l,"你目前还没有任何为 lian=over 的变量设定。") then
			alias.resetidle()
			skillsfull=1
			alias.ch()
			run("set check=lingwufull")
		end
		if findstring(l,"你口念咒语『神马都是浮云,虾米都是尘土』，『达摩院二楼』立马到达！") then
			alias.resetidle()
			skills_num=1
			if cmd.nums<cmd.setnums then
				alias.ch()
				alias.lingwuskills()
			else
				_f=function() alias.ch();alias.lingwuskills() end
				wait.time(1);_f()
			end
		end
		if findstring(l,"你还没将《武学大全》归还%(return%)，就想溜？") then
			run("return book;set lingwu=over")
		end
		if findstring(l,"数码世界，数字地图，213就是这里！") then
			run("set check=neili")
		end
		if findstring(l,"你还没拿书呢！") then
			run("take book")
		end
		if findstring(w[0],"对方正忙着呢，你等会儿在问话吧。\n[> ]*你又没有武学精要，坐下来占位置啊！？") then
			alias.resetidle()
			killwenying=1
			run("kill wenying")
		end
		if findstring(w[0],"这里没有 wenying 这个人。\n[> ]*你又没有武学精要，坐下来占位置啊！？") then
			alias.resetidle()
			run("get wuxue jingyao;sit hassock;drop wuxue jingyao")
		end
		if findstring(w[0],"你向文颖打听有关「武学精要」的消息。\n文颖说道：啊！你来晚了，四本《武学精要》都被借走了。","对方正忙着呢，你等会儿在问话吧。") then
			alias.resetidle()
			killwenying=1
			run("kill wenying")
		end
		if findstring(w[0],"你附近没有这样东西。\n[> ]*你又没有武学精要，坐下来占位置啊！？") then
			alias.resetidle()
			run("set lingwu=over")
		end
		if findstring(w[0],"此书乃吾留予后代峨嵋聪慧弟子，\n还忘.+能把书留在此处以便他人阅读参悟。") then
			run("give wenying wuxue jingyao;drop wuxue jingyao;set lingwu=over")
		end
		if findstring(w[0],"段正淳对着你点了点头。\n段正淳说道：好吧，你就拿此金牌替朕调阅兵将吧。") then
			alias.flytoid(213)
		end
		if findstring(w[0],"段正淳对着你摇了摇头。\n段正淳说道：不劳.+费心，朕已派人去调阅了。") then
			alias.flytoid(192)
		end
	end)
end
------------------------------------------------------------------------------------
-- skills_jingyao
------------------------------------------------------------------------------------
function skills_jingyao.dosomething1(n,l,w)
	if findstring(l,"你研读完毕，把.+精要收了起来。") then
		alias.resetidle()
		if me.menpai=="wd" and wx.taiji==0 then alias.checkbusy("taijiover")
		else
			if me.menpai=="em" then alias.yunem()
			else run("yun regenerate;hp;set check=neili") end
		end
	end
	if findstring(l,"你目前还没有任何为 check=neili 的变量设定。") then
		alias.resetidle()
		if havefj>0 then
			alias.uw()
			run("set startworkflow=yes")
		else
			if mpJobLimited==0 then
				if me.menpai=="wd" or xuefirst>0 or workflow.mp==0 or (me.menpai=="gb" and gold.num>=gold.setnum and 3600-(os.time()-mpLimited.MarkTime)>30) then
					alias.dujingyao()
				else
					alias.uw()
					run("set startworkflow=yes")
				end
			else alias.dujingyao() end
		end
	end
	if findstring(l,"你正翻看着这.+精要，却一不小心扯破了。","你正要翻看这.+精要，却一不小心扯破了。") then
		alias.resetidle()
		have.jingyao=have.jingyao-1
		if have.jingyao>0 then alias.dujingyao() else run("set dujingyao=over") end
	end
	if findstring(l,"你的潜能不够，没有办法再成长了。") then
		alias.resetidle()
		run("set dujingyao=over")
	end
	if findstring(l,"你研读着.+精要中所记载的内容，一下子想通了好几个难点。","你仔细研读着.+精要，但却百思不得其解。","你思考着.+精要中所写的内容，忽然对.+大有领悟。","你开始专心研读.+精要。","你昂起头默默背诵着.+精要所记录的内容，似乎对.+有些心得。") then
		alias.resetidle()
	end
	if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。","有一天，你踩着七色云彩来迎娶『朱熹』") then
		alias.dujingyao()
	end
	if findstring(l,"你目前还没有任何为 checkhp=addneili 的变量设定。") then
		if havefj>0 and hp.neili>(hp.maxneili*set_neili_job/100) then alias.tdz() end
	end
	if findstring(l,"你目前还没有任何为 dujingyao=over 的变量设定。") then
		mark.setpot=1
		alias.uw()
		alias.checkbusy("jyover")
	end
	if findstring(l,"你微微一笑，身子缓缓右转，左手持剑向上提起，剑身横於胸前，左右双掌掌心相对，如抱圆球。.+未出，已然蓄势无穷。") then
		wx.taiji=1
	end
	if findstring(l,"你大周天搬运完毕，将内力合于丹田，入窍归元。") then
		wx.taiji=0
	end
	if findstring(l,"你目前还没有任何为 busyover=taijistart 的变量设定。") then
		run("du book 10")
	end
	if findstring(l,"你目前还没有任何为 busyover=taijiover 的变量设定。") then
		run("yun regenerate;hp;set check=neili")
	end
	if findstring(l,"你收起手上的.+精要，不继续看了。") then
		alias.resetidle()
		if me.menpai=="wd" and wx.taiji==0 then alias.checkbusy("taijiover")
		else run("yun regenerate;hp;set check=neili") end
	end
	if findstring(l,"也许是缺乏实战经验，你对.+精要上面所说的东西总是无法领会。","你研读了一会儿，但是发现上面所说的对你而言都太") then
		alias.resetidle()
		have.nousejy=1
		run("set dujingyao=over")
	end
	if findstring(l,"学习知识需要在书院方能静心学习。") then
		alias.resetidle()
		if daytime then alias.flytonpc("朱熹") else run("set dujingyao=over") end
	end
	if findstring(l,"你目前还没有任何为 busyover=jyover 的变量设定。") then
		run("set startworkflow=yes")
	end
	if findstring(l,"你目前还没有任何为 startworkflow=yes 的变量设定。") then
		alias.resetidle()
		mark.setpot=1
		alias.close_dz()
		alias.startworkflow()
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function skills.update()
	_tb={
		"你研读完毕，把.+精要收了起来。",
		"你目前还没有任何为 check=neili 的变量设定。",
		"你正翻看着这.+精要，却一不小心扯破了。",
		"你正要翻看这.+精要，却一不小心扯破了。",
		"你的潜能不够，没有办法再成长了。",
		"你研读着.+精要中所记载的内容，一下子想通了好几个难点。",
		"你仔细研读着.+精要，但却百思不得其解。",
		"你思考着.+精要中所写的内容，忽然对.+大有领悟。",
		"你开始专心研读.+精要。",
		"你昂起头默默背诵着.+精要所记录的内容，似乎对.+有些心得。",
		"你目前还没有任何为 dazuo=over 的变量设定。",
		"有一天，你踩着七色云彩来迎娶『朱熹』",
		"你目前还没有任何为 checkhp=addneili 的变量设定。",
		"你目前还没有任何为 dujingyao=over 的变量设定。",
		"你微微一笑，身子缓缓右转，左手持剑向上提起，剑身横於胸前，左右双掌掌心相对，如抱圆球。.+未出，已然蓄势无穷。",
		"你大周天搬运完毕，将内力合于丹田，入窍归元。",
		"你目前还没有任何为 busyover=taijistart 的变量设定。",
		"你目前还没有任何为 busyover=taijiover 的变量设定。",
		"你收起手上的.+精要，不继续看了。",
		"也许是缺乏实战经验，你对.+精要上面所说的东西总是无法领会。",
		"你研读了一会儿，但是发现上面所说的对你而言都太(浅|深)了，没有学到任何东西。",
		"学习知识需要在书院方能静心学习。",
		"你目前还没有任何为 busyover=jyover 的变量设定。",
		"你目前还没有任何为 startworkflow=yes 的变量设定。",
	}
	local skills_jingyao_triggerlist={
	       {name="skills_jingyao_dosth1",regexp=linktri(_tb),script=function(n,l,w)    skills_jingyao.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(skills_jingyao_triggerlist) do
		addtri(v.name,v.regexp,"skills_jingyao",v.script,v.line)
	end
	closeclass("skills_jingyao")

	local _tb={
		"对方正忙着呢，你等会儿在问话吧。\\n(> > > |> > |> |)你又没有武学精要，坐下来占位置啊！？\\Z",
		"这里没有 wenying 这个人。\\n(> > > |> > |> |)你又没有武学精要，坐下来占位置啊！？\\Z",
		"你向文颖打听有关「武学精要」的消息。\\n文颖说道：啊！你来晚了，四本《武学精要》都被借走了。\\Z",
		"你附近没有这样东西。\\n(> > > |> > |> |)你又没有武学精要，坐下来占位置啊！？\\Z",
		"此书乃吾留予后代峨嵋聪慧弟子，\\n还忘.+能把书留在此处以便他人阅读参悟。\\Z",
		"段正淳对着你点了点头。\\n段正淳说道：好吧，你就拿此金牌替朕调阅兵将吧。\\Z",
		"段正淳对着你摇了摇头。\\n段正淳说道：不劳.+费心，朕已派人去调阅了。\\Z",
	}
	local  skills_lingwu_m_triggerlist={
	       {name="skills_lingwu_m_triggerlist",line=2,regexp=linktri(_tb),script=function(n,l,w)    skills_lingwu_cls.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(skills_lingwu_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"skills_lingwu",v.script,v.line)
	end

	local skills_lingwu_triggerlist={
	       {name="skills_lingwu_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    skills_lingwu_cls.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(skills_lingwu_triggerlist) do
		addtri(v.name,v.regexp,"skills_lingwu",v.script,v.line)
	end
	closeclass("skills_lingwu")
	
	_tb={
		"练.+必.+空手",
		"你不能通过练习招架来提高这项技能",
		"你的.+已经练习到顶峰了，必须先打好基础才能继续提高",
		"你的内力不够练",
		"你的内力太低了。",
		"你使用的武器不对。",
		"你体内的真气不够。",
		"你修习完毕，深深吸了一口气，闭目而(立|坐)。",
		"你只能练习用 enable 指定的特殊技能",
		"你目前还没有任何为 lian 的变量设定。",
		"金花杖法只能在实战中提高",
		"你的基本功火候未到，必须先打好基础才能继续提高。",
		"你一挥手中的.+，开始练习.+。",
		"你手中.+，几招后接着一招「.+」使出，如同行云流水。",
		"你反复练习着.+中的「.+」，但却总是不得要领。",
		"你舞着手中的.+, 如行云流水般地演练著.+中几个招式，完全不见滞怠。",
		"你将.+一招一式的演练下来，虽然不见新意，但对招数的基本应用上又有所悟。",
		"你顺著.+气息运行路线，将体内真气缓缓搬运了一个大周天。",
		"你暗自气运丹田，聚精会神地修练着.+。",
		"你必须先找一条鞭子才能练.+鞭法。",
		"蛤蟆从不手持兵刃，所以练.+也必须空手。",
		"寒冰绵掌必须通过特殊的法门才能修炼。",
	}
	local skills_lian_triggerlist={
	       {name="skills_lian_dosth1",regexp=linktri(_tb),script=function(n,l,w)    skills_lian.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(skills_lian_triggerlist) do
		addtri(v.name,v.regexp,"skills_lian",v.script,v.line)
	end
	closeclass("skills_lian")

	local skills_xue_triggerlist={
	       {name="skills_xue_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    skills_xue_cls.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(skills_xue_triggerlist) do
		addtri(v.name,v.regexp,"skills_xue",v.script,v.line)
	end
	closeclass("skills_xue")
	
	AddTimer("skills_ask_timer", 0, 0, 0.5, "", timer_flag.Enabled + timer_flag.Replace, "skills_ask.timer")
	SetTimerOption("skills_ask_timer", "group", "skills_ask")
	closeclass("skills_ask")
end

skills.update()
