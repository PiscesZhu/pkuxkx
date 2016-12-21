checki={}
dealwith_bi={}
dealwith_bian={}
dealwith_chain={}
dealwith_dao={}
dealwith_xs={}
dealwith_fuling={}
dealwith_gold={}
dealwith_gun={}
dealwith_he={}
dealwith_ji={}
dealwith_jian={}
dealwith_jiudai={}
dealwith_sellyao={}
dealwith_shengzi={}
dealwith_staff={}
dealwith_stick={}
dealwith_yaodai={}
dealwith_tyl={}
check_exp={}
check_items={}
------------------------------------------------------------------------------------
-- dealwith_bi
------------------------------------------------------------------------------------
function dealwith_bi.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"邱山风倒在地上，挣扎了几下就死了。","范一飞倒在地上，挣扎了几下就死了。") then run("get bi from corpse;get bi") end
		if findstring(l,"你从范一飞的尸体身上搜出一支判官笔。","你从邱山风的尸体身上搜出一支判官笔。","你捡起一支判官笔。") then
			have.bi=have.bi+1
			closeclass("dealwith_bi")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"你向范一飞打听有关「来首十八摸吧！」的消息。") then run("kill fan;yun jiemai fan") end
		if findstring(l,"你向邱山风打听有关「来首十八摸吧！」的消息。") then run("kill qiu;yun jiemai qiu") end
		if findstring(l,"数码世界，数字地图，1094就是这里！") then run("ask fan about 来首十八摸吧！") end
		if findstring(l,"数码世界，数字地图，1101就是这里！") then run("ask qiu about 来首十八摸吧！") end
		if findstring(l,"这里没有 fan 这个人。") then alias.flytoid(1101) end
		if findstring(l,"这里没有 qiu 这个人。") then alias.flytoid(1094) end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_bian
------------------------------------------------------------------------------------
function dealwith_bian.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"牧羊女倒在地上，挣扎了几下就死了。","牧羊人倒在地上，挣扎了几下就死了。") then run("get bian from corpse;get bian") end
		if findstring(l,"你从牧羊女的尸体身上搜出一柄羊鞭。","你从牧羊人的尸体身上搜出一柄羊鞭。","你捡起一柄羊鞭。") then
			have.whip=have.whip+1
			closeclass("dealwith_bian")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"你向牧羊女打听有关「来首十八摸吧！」的消息。") then run("kill nu") end
		if findstring(l,"你对着牧羊人「嘿嘿嘿」奸笑了几声。") then run("kill ren") end
		if findstring(l,"数码世界，数字地图，312就是这里！") then run("ask nu about 来首十八摸吧！") end
		if findstring(l,"你要对谁做 hehe 这个动作？") then
			closeclass("dealwith_bian")
			_f=function() alias.startworkflow() end
			wait.time(1);_f()
		end
		if findstring(l,"这里没有 nu 这个人。") then run("hehe ren") end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_chain
------------------------------------------------------------------------------------
function dealwith_chain.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"你从唐楠那里买下了一条铁链。","高升泰说道：你拿去护身，见到有打架斗殴的把他们送给段陉处置。") then
			closeclass("dealwith_chain")
			have.chain=have.chain+1
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"你想买的东西我这里没有。") then
			alias.resetidle()
			_f=function() alias.flytonpc("高升泰") end
			wait.time(10);_f()
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『高升泰』") then run("give mu xiang to gao shengtai;give chain to gao shengtai;ask gao shengtai about 铁链") end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『唐楠』") then run("buy chain") end
		if findstring(l,"高升泰说道：铁链已经发完了，我已经派","高升泰说道：你刚才不是来领过铁链了吗","这里没有 gao 这个人。") then alias.flytonpc("唐楠") end
		if findstring(l,"高升泰说道：.*你去扬州打铁铺的铁匠","高升泰说道：.*不如你过去帮我看看吧") then alias.flytonpc("王铁匠") end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『王铁匠』") then run("ask wang tiejiang about 铁链");alias.flytonpc("高升泰") end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_dao
------------------------------------------------------------------------------------
function dealwith_dao.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"你把正在运行的真气强行压回丹田，站了起来。") then
			if havefj>0 then alias.startworkflow() else run("yun regenerate;hp;set check=neili") end
		end
		if findstring(l,"你从澄行的尸体身上搜出一把戒刀。") then
			have.dao=have.dao+1
			if have.dao<1 then alias.flytonpc("道品")
			else
				closeclass("dealwith_dao")
				_f=function() alias.checkitems() end
				wait.time(1);_f()
			end
		end
		if findstring(l,"你从道品禅师的尸体身上搜出一把戒刀。","你捡起一把戒刀。","你从镖头的尸体身上搜出一柄钢刀。","你捡起一柄钢刀。") then
			have.dao=have.dao+1
			closeclass("dealwith_dao")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"你从慧如尊者的尸体身上搜出一把戒刀。") then
			have.dao=have.dao+1
			if have.dao<1 then alias.flytonpc("澄行")
			else
				closeclass("dealwith_dao")
				_f=function() alias.checkitems() end
				wait.time(1);_f()
			end
		end
		if findstring(l,"你对着道品禅师「嘿嘿嘿」奸笑了几声。") then run("kill chanshi") end
		if findstring(l,"你说：“澄行美眉好呀！”") then run("kill luohan") end
		if findstring(l,"这里没有这个人。") then alias.flytonpc("澄行") end
		if findstring(l,"澄行倒在地上，挣扎了几下就死了。","道品禅师倒在地上，挣扎了几下就死了。","慧如尊者倒在地上，挣扎了几下就死了。","镖头倒在地上，挣扎了几下就死了。") then
			run("get dao from corpse;get dao")
		end
		if findstring(l,"道尘给你一件戒刀。") then
			have.dao=have.dao+1
			if have.dao<1 then run("drop dao;ask chanshi about 戒刀;get dao")
			else
				closeclass("dealwith_dao")
				_f=function() alias.checkitems() end
				wait.time(1);_f()
			end
		end
		if findstring(l,"道尘禅师说道：抱歉，你来得不是时候，武器已经发完了。","这里没有 chanshi 这个人。") then alias.flytonpc("慧如") end
		if findstring(l,"你要对谁做 hehe 这个动作？") then
			closeclass("dealwith_dao")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"你要对谁做 ysis 这个动作？") then
			if have.dao>0 then
				_f=function() alias.startworkflow() end
				wait.time(1);_f()
			else
				_f=function() run("ysis luohan") end
				wait.time(5);_f()
			end
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『澄行』") then run("ysis luohan") end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『道尘』") then run("ask chanshi about 戒刀") end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『道品』") then run("hehe chanshi") end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『慧如』") then run("kill zunzhe") end
		if findstring(l,"数码世界，数字地图，964就是这里！") then run("kill biao tou") end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_gun
------------------------------------------------------------------------------------
function dealwith_gun.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"你从澄灵的尸体身上搜出一根齐眉棍。","你从澄寂的尸体身上搜出一根齐眉棍。","你捡起一根齐眉棍。","道尘给你一件齐眉棍。") then
			have.club=have.club+1
			closeclass("dealwith_gun")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"你对着澄灵「嘿嘿嘿」奸笑了几声。","你说：“澄寂美眉好呀！”") then run("kill luohan") end
		if findstring(l,"澄寂倒在地上，挣扎了几下就死了。","澄灵倒在地上，挣扎了几下就死了。") then run("get gun from corpse;get gun") end		
		if findstring(l,"道尘禅师说道：抱歉，你来得不是时候，武器已经发完了。","这里没有 chanshi 这个人。") then alias.flytonpc("澄寂") end
		if findstring(l,"你要对谁做 hehe 这个动作？") then
			closeclass("dealwith_gun")
			_f=function() alias.startworkflow() end
			wait.time(1);_f()
		end
		if findstring(l,"你要对谁做 ysis 这个动作？") then alias.flytonpc("澄灵") end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『澄寂』") then run("ysis luohan") end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『澄灵』") then run("hehe luohan") end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『道尘』") then run("ask chanshi about 齐眉棍") end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_xs
------------------------------------------------------------------------------------
function dealwith_xs.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"你目前还没有任何为 check=falun 的变量设定。") then
			alias.resetidle()
			if roomno_now==423 then alias.flytoid(428)
			elseif roomno_now==428 then alias.flytoid(437)
			else alias.flytoid(423) end
		end
		if findstring(l,"你目前还没有任何为 check=burn 的变量设定。") then
			alias.resetidle()
			if have.faling==nil or have.faling<1 then alias.flytoid(428) else alias.flytoid(431) end
		end
		if findstring(l,"数码世界，数字地图，431就是这里！") then
			alias.resetidle()
			run("jump zuo")
			if have.lubo==nil or have.lubo<1 then run("get lubo") end
			if have.kulouguan==nil or have.kulouguan<1 then run("get kulou guan") end
			if have.rentoulian==nil or have.rentoulian<1 then run("get rentou lian") end
			run("go down")
			closeclass("dealwith_xs")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"数码世界，数字地图，423就是这里！","数码世界，数字地图，428就是这里！","数码世界，数字地图，437就是这里！") then
			alias.resetidle()
			if have.faling==nil or have.faling<1 then run("get fa ling") end
			if have.falun==nil or have.falun<me.falun then run("get fa lun") end
			closeclass("dealwith_xs")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_fuling
------------------------------------------------------------------------------------
function dealwith_fuling.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"你从王通治那里买下了一钱茯苓。") then
			run("put fuling in yaodai")
			have.fuling=have.fuling+1
			closeclass("dealwith_fuling")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"哟，抱歉啊，我这儿正忙着呢……您请稍候。") then
			_f=function() run("buy fuling") end
			wait.time(1);_f()
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『王通治』") then run("buy fuling") end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_gold
------------------------------------------------------------------------------------
function dealwith_gold.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"王五说道：我…不知道。") then
			alias.resetidle()
			_f=function() run("ask wang about 鬼刀") end
			wait.time(1);_f()
		end
		if findstring(l,"对方还没有完全昏迷，先等等吧。") then
			_f=function() run("get wu") end
			wait.time(0.5);_f()
		end
		if findstring(l,"你将吴老板扶了起来背在背上。") then alias.resetidle();alias.flytonpc("大狼狗") end
		if findstring(l,"你目前还没有任何为 busyover=killwang 的变量设定。") then
			alias.resetidle()
			closeclass("dealwith_gold")
			run("get gold from corpse")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"你目前还没有任何为 busyover=stealwu 的变量设定。") then
			alias.resetidle()
			run("get gold from wu;get wu")
		end
		if findstring(l,"你想行窃的对象不在这里。") then
			_f=function() run("steal gold from wu") end
			wait.time(10);_f()
		end
		if findstring(l,"钱庄晚上不开，请天亮了再来！") then daytime=false end
		if findstring(l,"王五倒在地上，挣扎了几下就死了。") then alias.resetidle();alias.checkbusy("killwang") end
		if findstring(l,"王五脚下一个不稳，跌在地上昏了过去。","王五说道：老子就是鬼刀王五，鬼刀王五就是你老子！纳命来吧！") then alias.resetidle();run("kill wang") end
		if findstring(l,"吴老板脚下一个不稳，跌在地上昏了过去。") then alias.resetidle();alias.checkbusy("stealwu") end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『大狼狗』") then
			alias.resetidle()
			run("feed wu to dog;drop corpse")
			closeclass("dealwith_gold")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『黄真』") then
			alias.resetidle()
			if daytime then
				--if have.gold>5 then run("cun "..tonumber(have.gold-5).." gold;drop "..tonumber(have.gold-5).." gold") end
				--if have.gold<5 then run("qu "..tonumber(5-have.gold).." gold") end
				if have.gold>=2 then run("cun "..tonumber(have.gold-2).." gold;drop "..tonumber(have.gold-5).." gold") else run("qu 2 gold") end
				if have.silver>50 then run("cun "..tonumber(have.silver-50).." silver") end
				if have.coin<50 then run("cun 1 silver;qu "..tonumber(50-have.coin).." coin") end
				closeclass("dealwith_gold")
				mark.setgold=1
				_f=function() alias.checkitems() end
				wait.time(1);_f()
			else
				if have.gold<1 and have.silver<50 then
					_f=function() alias.flytonpc("王五") end
					wait.time(1);_f()
				else
					closeclass("dealwith_gold")
					mark.setgold=1
					_f=function() alias.checkitems() end
					wait.time(1);_f()
				end
			end
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『王五』") then
			alias.resetidle()
			if have.gold>1 then
				run("buy ya;drop ya")
				closeclass("dealwith_gold")
				_f=function() alias.checkitems() end
				wait.time(1);_f()
			else run("ask wang about 鬼刀") end
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『吴老板』") then alias.resetidle();run("steal gold from wu") end
		if findstring(l,"这里没有 wang 这个人。") then alias.flytonpc("吴老板") end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_he
------------------------------------------------------------------------------------
function dealwith_he.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"你从唐楠那里买下了一个食盒。","你从杨永福那里买下了一个食盒。") then
			alias.resetidle()
			have.he=have.he+1
			if have.fire<1 then
				_f=function() run("buy fire") end
				wait.time(0.5);_f()
			else
				closeclass("dealwith_he")
				_f=function() alias.checkitems() end
				wait.time(1);_f()
			end
		end
		if findstring(l,"你从杨永福那里买下了一支火折。","你从唐楠那里买下了一支火折。","你从小贩那里买下了一支火折。") then
			alias.resetidle()
			closeclass("dealwith_he")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"你想买的东西我这里没有。") then
			alias.resetidle()
			_f=function() alias.flytonpc("杨永福") end
			wait.time(10);_f()
		end
		if findstring(l,"你向杨永福打听有关「起床没啊？」的消息。") then
			daytime=true
			if have.he<1 then run("buy he") else run("buy fire") end
		end
		if findstring(l,"哟，抱歉啊，我这儿正忙着呢……您请稍候。") then
			alias.resetidle()
			_f=function() if have.he<1 then run("buy he") else run("buy fire") end end
			wait.time(0.5);_f()
		end
		if findstring(l,"数码世界，数字地图，837就是这里！") then
			alias.resetidle()
			run("buy fire")
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『唐楠』") then
			alias.resetidle()
			if have.he<1 then run("buy he") else run("buy fire") end
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『杨永福』") then
			alias.resetidle()
			run("ask Yang yongfu about 起床没啊？")
		end
		if findstring(l,"这里没有 Yang yongfu 这个人。") then alias.flytonpc("唐楠") end
		if findstring(l,"杂货铺晚上不开，请天亮了再来！") then daytime=false end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_ji
------------------------------------------------------------------------------------
function dealwith_ji.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"你从宋老板那里买下了.+盆汽锅鸡。") then
			alias.resetidle()
			for i=1,10,1 do run("put ji in he") end
			closeclass("dealwith_ji")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"你向宋老板打听有关「鸡鸡还在不」的消息。") then
			run("buy "..tonumber(10-have.ji).." ji")
		end
		if findstring(l,"哟，抱歉啊，我这儿正忙着呢……您请稍候。") then
			_f=function() run("buy "..tonumber(10-have.ji).." ji") end
			wait.time(1);_f()
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『宋老板』") then
			alias.resetidle()
			run("ask song laoban about 鸡鸡还在不")
		end
		if findstring(l,"这里没有 song laoban 这个人。") then
			alias.resetidle()
			_f=function() run("ask song laoban about 鸡鸡还在不") end
			wait.time(3);_f()
		end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_jian
------------------------------------------------------------------------------------
function dealwith_jian.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"[青|白|红]+衣武士倒在地上，挣扎了几下就死了。") then
			alias.resetidle()
			--if (have.jian<2 and me.menpai~="sl" and me.menpai~="bt" and me.menpai~="gb") or (have.jian<1 and findstring(skills_lingwu,"sword")) then
			if have.jian<1 then
				_f=function() run("halt;get jian from corpse;get jian") end
				wait.time(2.5);_f()
			end
			--if have.armor<1 then run("get armor from corpse") end
			run("set check=jian")
		end
		--if findstring(l,"你从[青|白|红]+衣武士的尸体身上除下一件铁甲。") then
		--	have.armor=have.armor+1
		--	run("drop cloth;wear armor")
		--end
		if findstring(l,"你从[青|白|红]+衣武士的尸体身上搜出一柄.+剑。","你捡起一柄.+剑。") then
			have.jian=have.jian+1
		end
		if findstring(l,"你目前还没有任何为 check=jian 的变量设定。") then
			alias.resetidle()
			--if (have.jian<2 and (fjweapon=="jian" or mpweapon=="jian" or ftbweapon=="jian")) or have.armor<1 or (have.jian<1 and findstring(skills_lingwu,"sword")) then
			_f=function() if have.jian<1 then run("ask wei shi about 先奸后杀")	else alias.checkitems() end end
			wait.time(1);_f()
		end
		if findstring(l,"你向[青|白|红]+衣武士打听有关「先奸后杀」的消息。") then
			alias.resetidle()
			run("kill wei shi")
		end
		if findstring(l,"双飞，三飞，大家一起飞，先×.+ 个『 [青|白|红]+衣武士 』中的第 .+个～～","有一天，你踩着七色云彩来迎娶『青衣武士』") then
			alias.resetidle()
			run("ask wei shi about 先奸后杀")
		end
		if findstring(l,"这里没有 wei shi 这个人。","对方正忙着呢，你等会儿在问话吧。") then
			if jiannpc==nil then jiannpc="白衣武士" end
			if jiannpc=="白衣武士" then
				if flytoidx<flytosum then alias.flytonext()
				else
					jiannpc="红衣武士"
					_f=function() alias.flytonpc(jiannpc) end
					wait.time(1);_f()
				end
			elseif jiannpc=="红衣武士" then
				if flytoidx<flytosum then
					_f=function() alias.flytonext() end
					wait.time(1);_f()
				else
					jiannpc="青衣武士"
					_f=function() alias.flytonpc(jiannpc) end
					wait.time(1);_f()
				end
			end
		end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_jiudai
------------------------------------------------------------------------------------
function dealwith_jiudai.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"你从店小二那里买下了一个牛皮酒袋。") then alias.flytonpc("小姗") end
		if findstring(l,"酒袋放入了大木桶中盛了满了水。") then have.water=1 end
		if findstring(l,"你目前还没有任何为 busyover=fill 的变量设定。") then
			closeclass("dealwith_jiudai")
			for i=1,3,1 do run("drink") end
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"你向店小二打听有关「醉仙楼」的消息。","你向冼老板打听有关「醉仙楼二楼」的消息。") then run("buy jiudai") end
		if findstring(l,"数码世界，数字地图，1805就是这里！","数码世界，数字地图，437就是这里！","数码世界，数字地图，537就是这里！","数码世界，数字地图，1447就是这里！","有一天，你踩着七色云彩来迎娶『小姗』") then
			run("fill jiudai")
			have.water=1
			alias.checkbusy("fill")
		end
		if findstring(l,"数码世界，数字地图，948就是这里！") then
			alias.resetidle()
			run("ask xiao er about 醉仙楼")
		end
		if findstring(l,"这里没有 xiao er 这个人。") then
			run("u;ask xian laoban about 醉仙楼二楼")
		end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_sellyao
------------------------------------------------------------------------------------
function dealwith_sellyao.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"你目前还没有任何为 sellyao=over 的变量设定。") then
			closeclass("dealwith_sellyao")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『何红药』") then
			if hp.neili<(hp.maxneili*160/100) then alias.checkdrugbusy("da xueteng") end
			_f=function()
				for i=1,have.xueteng,1 do run("sell da xueteng") end
				for i=1,have.xueteng,1 do run("drop da xueteng") end
				for i=1,have.danggui,1 do run("sell dang gui") end
				for i=1,have.danggui,1 do run("drop dang gui") end
				for i=1,have.swjing,1 do run("sell shouwu jing") end
				for i=1,have.swjing,1 do run("drop shouwu jing") end
				if have.jcy<1 then run("buy jinchuang yao") end
				run("set sellyao=over")
			end
			wait.time(2);_f()
		end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_shengzi
------------------------------------------------------------------------------------
function dealwith_shengzi.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"你从小贩那里买下了一捆绳子。") then
			closeclass("dealwith_shengzi")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"你向小贩打听有关「上吊的绳子有哇～」的消息。") then
			run("buy sheng zi")
		end
		if findstring(l,"数码世界，数字地图，615就是这里！") then
			run("ask xiao fan about 上吊的绳子有哇～")
		end
		if findstring(l,"数码世界，数字地图，837就是这里！") then
			run("ask seller about 上吊的绳子有哇～")
		end
		if findstring(l,"这里没有 seller 这个人。") then
			alias.flytoid(615)
		end
		if findstring(l,"这里没有 xiao fan 这个人。") then
			_f=function() alias.flytoid(837) end
			wait.time(5);_f()
		end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_tyl
------------------------------------------------------------------------------------
function dealwith_tyl.dosomething1(n,l,w)
	--local _f
	--wait.make(function()
		if findstring(l,"有一天，你踩着七色云彩来迎娶『冷谦』") then
			run("h;ask leng qian about 铁焰令")
			if have.tyl==0 then alias.flytonpc("李天恒") else alias.checkitems() end
		end
		if findstring(l,"你向冷谦打听有关「铁焰令」的消息。") then
			have.tyl=1
		end
		if findstring(l,"你并非明教弟子，根本就不需要铁焰令，你将铁焰令扔到一边。") then
			have.tyl=0
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『李天恒』") then
			run("h;ask li tianheng about 天鹰令")
			alias.checkitems()
		end
	--end)
end
------------------------------------------------------------------------------------
-- dealwith_staff
------------------------------------------------------------------------------------
function dealwith_staff.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"歌女倒在地上，挣扎了几下就死了。") then run("get qin from corpse") end
		if findstring(l,"你从歌女的尸体身上搜出一张.+琴。","你从小贩那里买下了一根扁担。") then
			closeclass("dealwith_staff")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"你低下头来，见欧阳克娇羞之态，娇美不可方物，心中一荡，便凑过去在他脸颊上吻了一下。") then
			run("unset no_accept;ask ke about 怪蛇")
		end
		if findstring(l,"你附近没有这样东西。","你找不到 corpse 这样东西。","这里没有 nu 这个人。") then
			alias.flytoid(1383)
		end
		if findstring(l,"你向歌女打听有关「来首十八摸吧！」的消息。") then
			run("kill nu")
		end
		if findstring(l,"你要对谁做 kiss4 这个动作？") then
			_f=function() run("kiss4 ke") end
			wait.time(10);_f()
		end
		if findstring(l,"数码世界，数字地图，1383就是这里！") then
			run("buy biandan")
		end
		if findstring(l,"数码世界，数字地图，280就是这里！") then
			run("ask nu about 来首十八摸吧！")
		end
		if findstring(l,"数码世界，数字地图，926就是这里！") then
			if have.staff>0 and have.guaishe==0 then run("ed;drop staff;drop staff;wu") end
			run("kiss4 ke")
		end
	end)
end
function dealwith_staff.dosomething2(n,l,w)
	local _f
	wait.make(function()
		if findstring(w[0],"但是很显然的，欧阳克现在的状况没有办法给你任何答覆。") then
			_f=function() run("kiss4 ke") end
			wait.time(10);_f()
		end
		if findstring(w[0],"对方正忙着呢，你等会儿在问话吧。") then
			_f=function() run("ask ke about 怪蛇") end
			wait.time(1);_f()
		end
		if findstring(w[0],"欧阳克说道：以你的驯兽术操控一条怪蛇已经十分吃力，不能控制更多的怪蛇了。") then
			resetidle=0
			openclass("quit")
			stat.quiting=0
		end
		if findstring(w[0],"欧阳克给你一根怪蛇杖。") then
			if setting_resetidle then resetidle=1 end
			run("convert she")
			closeclass("dealwith_staff")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_stick
------------------------------------------------------------------------------------
function dealwith_stick.dosomething1(n,l,w)
	local _f
	wait.make(function()
		if findstring(l,"你从莫不收的尸体身上搜出一根铜棒。") then
			have.stick=have.stick+1
			have.stick_tong=have.stick_tong+1
		end
		if findstring(l,"你说：“莫不收美眉好呀！”") then
			run("kill mo bushou")
		end
		if findstring(l,"你折下一杆竹子，做了一只竹棒。") then
			have.stick=have.stick+1
			have.stick_zhu=have.stick_zhu+1
		end
		if findstring(l,"莫不收倒在地上，挣扎了几下就死了。") then
			run("get stick from corpse")
			closeclass("dealwith_stick")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"能做竹棒的竹子都截光了。") then
			alias.flytoid(2048)
		end
		if findstring(l,"你目前还没有任何为 checkbang=yes 的变量设定。") then
			closeclass("dealwith_stick")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(l,"你要对谁做 ysis 这个动作？") then
			alias.resetidle()
			closeclass("dealwith_stick")
			_f=function() alias.checkitems() end
			wait.time(5);_f()
		end
		if findstring(l,"数码世界，数字地图，1118就是这里！") then
			run("drop bang;get zhu bang;get zhu bang;set checkbang=yes")
		end
		if findstring(l,"数码世界，数字地图，2048就是这里！") then
			run("ysis mo bushou")
		end
	end)
end
function dealwith_stick.dosomething2(n,l,w)
	local _f
	wait.make(function()
		if findstring(w[0],"你附近没有这样东西。\n你附近没有这样东西。") then
			alias.resetidle()
			run("zuo zhu bang")
		end
		if findstring(w[0],"你捡起一根黄竹棒。\n你附近没有这样东西。") then
			have.stick=have.stick+1
			have.stick_huangzhu=have.stick_huangzhu+1
		end
		if findstring(w[0],"你捡起一根黄竹棒。\n你捡起一根黄竹棒。") then
			run("drop bang 2;get bang")
			have.stick=have.stick+2
			have.stick_huangzhu=have.stick_huangzhu+2
		end
		if findstring(w[0],"你捡起一根黄竹棒。\n你捡起一根铜棒。") then
			run("drop bang 2;get bang")
			have.stick=have.stick+2
			have.stick_tong=have.stick_tong+1
			have.stick_huangzhu=have.stick_huangzhu+1
		end
		if findstring(w[0],"你捡起一根黄竹棒。\n你捡起一根竹棒。") then
			run("drop bang 2;get bang")
			have.stick=have.stick+2
			have.stick_zhu=have.stick_zhu+1
			have.stick_huangzhu=have.stick_huangzhu+1
		end
		if findstring(w[0],"你捡起一根铜棒。\n你附近没有这样东西。") then
			have.stick=have.stick+1
			have.stick_tong=have.stick_tong+1
		end
		if findstring(w[0],"你捡起一根铜棒。\n你捡起一根黄竹棒。") then
			have.stick=have.stick+2
			have.stick_tong=have.stick_tong+1
			have.stick_huangzhu=have.stick_huangzhu+1
		end
		if findstring(w[0],"你捡起一根铜棒。\n你捡起一根铜棒。") then
			have.stick=have.stick+2
			have.stick_tong=have.stick_tong+2
		end
		if findstring(w[0],"你捡起一根铜棒。\n你捡起一根竹棒。") then
			run("drop bang 2;get bang")
			have.stick=have.stick+2
			have.stick_tong=have.stick_tong+1
			have.stick_zhu=have.stick_zhu+1
		end
		if findstring(w[0],"你捡起一根竹棒。\n你附近没有这样东西。") then
			have.stick=have.stick+1
			have.stick_zhu=have.stick_zhu+1
		end
		if findstring(w[0],"你捡起一根竹棒。\n你捡起一根黄竹棒。") then
			have.stick=have.stick+2
			have.stick_zhu=have.stick_zhu+1
			have.stick_huangzhu=have.stick_huangzhu+1
		end
		if findstring(w[0],"你捡起一根竹棒。\n你捡起一根铜棒。") then
			have.stick=have.stick+2
			have.stick_tong=have.stick_tong+1
			have.stick_zhu=have.stick_zhu+1
		end
		if findstring(w[0],"你捡起一根竹棒。\n你捡起一根竹棒。") then
			have.stick=have.stick+2
			have.stick_zhu=have.stick_zhu+2
		end
	end)
end
------------------------------------------------------------------------------------
-- dealwith_yaodai
------------------------------------------------------------------------------------
function dealwith_yaodai.dosomething1(n,l,w)
	if findstring(l,"有一天，你踩着七色云彩来迎娶『静风』") then
		if have.yaodai==0 then
			run("ask jing feng about 皮腰带")
		elseif have.dao==0 then
			run("ask jing feng about 柳叶刀")
		elseif have.jian<=2 then
			run("ask jing feng about 软剑")
		end
	end
end
function dealwith_yaodai.dosomething2(n,l,w)
	local _f
	wait.make(function()
		if findstring(w[0],"你向静风打听有关「柳叶刀」的消息。\n静风师太给你一把柳叶刀。") then
			have.dao=have.dao+1
			if have.jian<=2 then run("ask jing feng about 软剑")
			else
				closeclass("dealwith_yaodai")
				_f=function() alias.checkitems() end
				wait.time(1);_f()
			end
		end
		if findstring(w[0],"真是贪得无餍！") then
			closeclass("dealwith_yaodai")
			_f=function() alias.checkitems() end
			wait.time(1);_f()
		end
		if findstring(w[0],"你向静风打听有关「皮腰带」的消息。\n静风师太给你一条皮腰带。") then
			have.yaodai=1
			if have.dao==0 then run("ask jing feng about 柳叶刀")
			elseif have.jian<=2 then run("ask jing feng about 软剑")
			else
				closeclass("dealwith_yaodai")
				_f=function() alias.checkitems() end
				wait.time(1);_f()
			end
		end
		if findstring(w[0],"你向静风打听有关「软剑」的消息。\n静风师太给你一把软剑。") then
			have.jian=have.jian+1
			if have.jian<=2 then run("ask jing feng about 软剑")
			else
				closeclass("dealwith_yaodai")
				_f=function() alias.checkitems() end
				wait.time(1);_f()
			end
		end
	end)
end
------------------------------------------------------------------------------------
-- check_exp
------------------------------------------------------------------------------------
function check_exp.dosomething1(n,l,w)
	alias.resetidle()
	if have.gold==nil then have.gold=0 end
	if mark.gold==nil then mark.gold=0 end
	if mark.exp==nil then mark.exp=tonumber(hp.exp) end
	if mark.pot==nil then mark.pot=tonumber(hp.pot) end
	add.gold=tonumber(have.gold)-tonumber(mark.gold)
	add.exp=tonumber(hp.exp-mark.exp)
	add.pot=tonumber(hp.pot-mark.pot)
	mark.gold=tonumber(have.gold)
	mark.setexp=1
	mark.setpot=1
	-- if not in_array("cuff",skillslist) or not in_array("lvl",skillslist["cuff"]) then skillslist["cuff"]["lvl"]=1 end
	if skillslist["cuff"]==nil then skillslist["cuff"]={} end
	if skillslist["cuff"]["lvl"]==nil then skillslist["cuff"]["lvl"]=1 end
	if me.menpai=="hs" and (me.xtbl+math.floor(skillslist["cuff"]["lvl"]/10))==me.bl then stat.leidong=0 end
	if workflow.nowjob=="fj" and add.exp>(fjexp+10) then
		sum.fj=sum.fj+fjexp
		sum.mp=sum.mp+tonumber(add.exp-fjexp)
		mpLimited.mpexp=mpLimited.mpexp+tonumber(add.exp-fjexp)
		if count[workflow.nowjob]==nil then count[workflow.nowjob]=0 end
		count[workflow.nowjob]=count[workflow.nowjob]+1
		print("增加exp："..add.exp.."，其中fj增加"..fjexp.."，mp增加"..tonumber(add.exp-fjexp)..",增加gold："..add.gold)
		--###-- #if @explist.keephour {setExplist "fj+mp"}
	else
		if sum[workflow.nowjob]==nil then sum[workflow.nowjob]=0 end
		sum[workflow.nowjob]=sum[workflow.nowjob]+add.exp
		if workflow.nowjob=="mp" then
			alias.setmpReCountTime()
			mpLimited.mpexp=mpLimited.mpexp+add.exp
		end
		if count[workflow.nowjob]==nil then count[workflow.nowjob]=0 end
		count[workflow.nowjob]=count[workflow.nowjob]+1
		print("增加exp："..add.exp..",增加gold："..add.gold)
		--###-- #if @explist.keephour {setExplist}
	end
	addlog(w[3].."增加exp："..add.exp)
	closeclass("check_exp")
	run("hp;set checkexpover="..w[3])
end
------------------------------------------------------------------------------------
-- check_items
------------------------------------------------------------------------------------
function check_items.dosomething1(n,l,w)
	local a,b,c
	if findstring(l,"你目前还没有任何为 checkitems=yes 的变量设定。") then
		alias.resetidle()
		if have.nousejy==1 then alias.flyto("武庙")
		else
			closeclass("check_items")
			alias.dealwithitems()
		end
	end
	if findstring(l,"你口念咒语『神马都是浮云,虾米都是尘土』，『武庙』立马到达！") then
		alias.resetidle()
		if have.nousejy==1 then run("give "..dummy.id.." jing yao") end
	end
	a,b,c=string.find(l, "你给(.-)一[本|册|页]+.+精要。")
	if c~=nil then
		have.nousejy=0
		have.jingyao=have.jingyao-1
		run("e")
		closeclass("check_items")
		alias.dealwithitems()
	end
	if findstring(l,"杖上盘着一条银鳞闪闪的小蛇，不住的蜿蜒上下。") then
		have.guaishe=1
	end
end
function check_items.dosomething2(n,l,w)
	local _t,a,b,c,d,e
	a,b,c,_t=string.find(l, "%s*(.-)[把|柄]+(.+)刀%(.*dao%)")
	if c~=nil and _t~=nil then
		if findstring(_t,"断掉的") then run("drop dao") else have.dao=have.dao+ctonum(c) end
	end
	a,b,c,_t=string.find(l, "%s*(.-)[把|柄]+(.+)刀%(Blade%)")
	if c~=nil and _t~=nil then
		if findstring(_t,"断掉的") then run("drop dao") else have.dao=have.dao+ctonum(c) end
	end
	a,b,c,_t=string.find(l, "%s*(.+)柄(.+)鞭%(Bian%)")
	if c~=nil and _t~=nil then
		if findstring(_t,"断掉的") then run("drop bian") else have.whip=have.whip+ctonum(c) end
	end
	a,b,c,_t=string.find(l, "%s*(.-)[把|柄]+(.+)剑%(.*jian%)")
	if c~=nil and _t~=nil then
		if findstring(_t,"断掉的") then run("drop jian")
		elseif findstring(_t,"重") then have.zhongjian=have.zhongjian+ctonum(c)
		else have.jian=have.jian+ctonum(c) end
	end
	a,b,_t=string.find(l, "%s*(.+)包枸枳子%(Gouzhi zi%)")
	if _t~=nil then have.gouzhizi=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)杯西湖龙井%(Longjing%)")
	if _t~=nil then for i=1,ctonum(_t),1 do run("drop longjing") end end
	a,b,_t=string.find(l, "%s*(.+)本《玄门内功心法》%(Xuanmen xinfa%)")
	if _t~=nil then have.xinfa=ctonum(_t) end
	a,b,c,d=string.find(l, "%s*(.-)[本|册|页]+(.+)精要%(.+yao%)")
	if c~=nil and d~=nil then
		have.jingyao=have.jingyao+ctonum(c)
		have.nousejy=1
		for k,v in skillslist do
			if v["name"]==d then have.nousejy=0;break end
		end
	end
	a,b,_t=string.find(l, "%s*(.+)串人头链%(Rentou lian%)")
	if _t~=nil then have.rentoulian=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)块天鹰令%(Tianying ling%)")
	if _t~=nil then have.tyl=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)块铁焰令%(Tieyan ling%)")
	if _t~=nil then have.tyl=ctonum(_t) end
	if findstring(l,"□人头链%(Rentou lian%)") then have.rentoulian=have.rentoulian+1 end
	a,b,_t=string.find(l, "%s*(.+)顶骷髅冠%(Kulou guan%)")
	if _t~=nil then have.kulouguan=ctonum(_t) end
	if findstring(l,"□骷髅冠%(Kulou guan%)") then have.kulouguan=have.kulouguan+1 end
	a,b,_t=string.find(l, "%s*(.+)副法铃%(Fa ling%)")
	if _t~=nil then have.faling=ctonum(_t) end
	if findstring(l,"□法铃%(Fa ling%)") then have.faling=have.faling+1 end
	a,b,c,_t=string.find(l, "%s*(.+)个(.+)酒袋%(Jiudai%)")
	if c~=nil then have.jiudai=ctonum(c) end
	a,b,_t=string.find(l, "%s*(.+)个颅钵%(Lubo%)")
	if _t~=nil then have.lubo=ctonum(_t) end
	if findstring(l,"□颅钵%(Lubo%)") then have.lubo=have.lubo+1 end
	a,b,_t=string.find(l, "%s*(.+)个食盒%(Shi he%)")
	if _t~=nil then have.he=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)根扁担%(Biandan%)")
	if _t~=nil then have.staff=have.staff+ctonum(_t);staffid="biandan" end
	a,b,_t=string.find(l, "%s*(.+)根怪蛇杖%(Guai shezhang%)")
	if _t~=nil then have.staff=ctonum(_t);staffid="staff" end
	a,b,_t=string.find(l, "%s*(.+)根黄竹棒%(.*bang%)")
	if _t~=nil then have.stick=have.stick+ctonum(_t);have.stick_huangzhu=have.stick_huangzhu+ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)根齐眉棍%(Qimei gun%)")
	if _t~=nil then have.club=have.club+ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)根铁扫把%(Sao ba%)")
	if _t~=nil then
		have.staff=have.staff+ctonum(_t)
		if staffid=="biandan" or staffid=="staff" or staffid=="qin" or staffid=="" then staffid="ba" end
	end
	a,b,_t=string.find(l, "%s*(.+)根铜棒%(.*bang%)")
	if _t~=nil then have.stick=have.stick+ctonum(_t);have.stick_tong=have.stick_tong+ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)根竹棒%(.*bang%)")
	if _t~=nil then have.stick=have.stick+ctonum(_t);have.stick_zhu=have.stick_zhu+ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)件破碎的铁甲%(Armor%)")
	if _t~=nil then run("drop armor") end
	a,b,_t=string.find(l, "%s*(.+)件破碎的铁甲%(Tie jia%)")
	if _t~=nil then run("drop armor") end
	a,b,_t=string.find(l, "%s*(.+)件铁甲%(Armor%)")
	if _t~=nil then have.armor=have.armor+ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)件铁甲%(Tie jia%)")
	if _t~=nil then have.armor=have.armor+ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)棵大血藤%(Da xueteng%)")
	if _t~=nil then have.xueteng=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)棵当归%(Dang gui%)")
	if _t~=nil then have.danggui=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)棵首乌精%(Shouwu jing%)")
	if _t~=nil then have.swjing=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)捆绳子%(Sheng zi%)")
	if _t~=nil then have.shengzi=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)粒续命八丹%(Xuming badan%)")
	if _t~=nil then have.dan=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)包金创药%(Jinchuang yao%)")
	if _t~=nil then have.jcy=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)两白银%(Silver%)")
	if _t~=nil then have.silver=ctonum(_t) end
	a,b,c=string.find(l, "%s*(.+)两黄金%(Gold%)")
	if c~=nil then
		have.gold=ctonum(c)
		if mark.setgold>0 then
			mark.gold=have.gold
			mark.setgold=0
		end
	end
	a,b,_t=string.find(l, "%s*(.+)枚铁八卦%(Tie bagua%)")
	if _t~=nil then have.bagua=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)个酥油罐%(Suyou guan%)")
	if _t~=nil then have.syguan=have.syguan+ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)面青铜令牌%(Ling pai%)")
	if _t~=nil then have.ling=have.ling+ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)钱川贝%(Chuanbei%)")
	if _t~=nil then have.chuanbei=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)钱黄连%(Huanglian%)")
	if _t~=nil then have.huanglian=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)钱金银花%(Jinyin hua%)")
	if _t~=nil then have.jinyinhua=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)钱菊梗%(Jugeng%)")
	if _t~=nil then have.jugeng=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)钱生地%(Shengdi%)")
	if _t~=nil then have.shengdi=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)钱茯苓%(Fuling%)")
	if _t~=nil then have.fuling=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)条皮腰带%(Yao dai%)")
	if _t~=nil then have.yaodai=have.yaodai+ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)条铁链%(Tie lian%)")
	if _t~=nil then have.chain=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)文铜钱%(Coin%)")
	if _t~=nil then have.coin=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)张瑶琴%(Yao qin%)")
	if _t~=nil then
		have.staff=have.staff+ctonum(_t)
		if staffid=="biandan" or staffid=="staff" or staffid==""or staffid==nil then staffid="qin" end
	end
	a,b,_t=string.find(l, "%s*(.+)瓶玉蜂浆%(Yufeng jiang%)")
	if _t~=nil then have.yufengjiang=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)支何首乌%(Heshouwu%)")
	if _t~=nil then have.heshouwu=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)支火折%([Fire|Huo zhe]+%)")
	if _t~=nil then have.fire=ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)支判官笔%(Panguan bi%)")
	if _t~=nil then have.bi=have.bi+ctonum(_t) end
	a,b,_t=string.find(l, "%s*(.+)只法轮%(Fa lun%)")
	if _t~=nil then have.falun=ctonum(_t)
		if have.falun>5 then run("drop 1 fa lun") end 
	end
	if findstring(l,"%s+汽锅鸡%(Qiguo ji%)") then have.ji=have.ji+1 end
	if findstring(l,"%s+茯苓%(Fuling%)") then have.fuling=have.fuling+1 end
	a,b,_t=string.find(l, "□(.+)%(Cloth%)")
	if _t~=nil then run("drop cloth") end
	a,b,_t=string.find(l, "□(.+)鞭%(Bian%)")
	if _t~=nil then have.whip=have.whip+1;weapon_now="bian" end
	a,b,_t=string.find(l, "□(.+)刀%(.*dao%)")
	if _t~=nil then have.dao=have.dao+1;weapon_now="dao" end
	a,b,_t=string.find(l, "□(.+)刀%(Blade%)")
	if _t~=nil then have.dao=have.dao+1;weapon_now="dao" end
	a,b,_t=string.find(l, "□(.+)剑%(.*jian%)")
	if _t~=nil then
		if string.find(_t,"重") then
			have.zhongjian=have.zhongjian+1
			weapon_now="zhongjian"
		else
			have.jian=have.jian+1
			weapon_now="jian"
		end
	end
	if findstring(l,"□扁担%(Biandan%)") then have.staff=have.staff+1;weapon_now="biandan" end
	if findstring(l,"□铁链%(Tie lian%)") then have.chain=have.chain+1;weapon_now="chain" end
	if findstring(l,"□怪蛇杖%(Guai shezhang%)") then have.staff=have.staff+1;weapon_now="staff" end
	if findstring(l,"□黄竹棒%(.+bang%)") then have.stick=have.stick+1;have.stick_huangzhu=have.stick_huangzhu+1;weapon_now="bang" end
	if findstring(l,"□皮腰带%(Yao dai%)") then have.yaodai=have.yaodai+1 end
	if findstring(l,"□破铁甲%(Armor%)","□破铁甲%(Tie jia%)") then run("drop armor") end
	if findstring(l,"□齐眉棍%(Qimei gun%)") then have.club=have.club+1;weapon_now="gun" end
	if findstring(l,"□铁甲%(Armor%)","□铁甲%(Tie jia%)") then have.armor=have.armor+1 end
	if findstring(l,"□铜棒%(.+bang%)") then have.stick=have.stick+1;have.stick_tong=have.stick_tong+1;weapon_now="bang" end
	if findstring(l,"□瑶琴%(Yao qin%)") then have.staff=have.staff+1;weapon_now="qin" end
	if findstring(l,"□竹棒%(.+bang%)") then have.stick=have.stick+1;have.stick_zhu=have.stick_zhu+1;weapon_now="bang" end
	a,b,_t=string.find(l, "□(.+)只法轮%(Fa lun%)")
	if _t~=nil then have.falun=ctonum(_t);weapon_now="lun" end
end
function check_items.dosomething3(n,l,w)
	have.luboneedfill=0
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function checki.update()
	_tb={
		"你目前还没有任何为 checkitems=yes 的变量设定。",
		"你口念咒语『神马都是浮云,虾米都是尘土』，『武庙』立马到达！",
		"你给(.+)一(本|册|页).+精要。",
		"杖上盘着一条银鳞闪闪的小蛇，不住的蜿蜒上下。",
	}
	local  check_items_triggerlist={
	       {name="check_items_dosth1",regexp=linktri(_tb),script=function(n,l,w)    check_items.dosomething1(n,l,w)  end,},
	       {name="check_items_dosth2",regexp="(.+)\\((.+)\\)",script=function(n,l,w)    check_items.dosomething2(n,l,w)  end,},
	}
	for k,v in pairs(check_items_triggerlist) do
		addtri(v.name,v.regexp,"check_items",v.script,v.line)
	end
	local  check_items_m_triggerlist={
	       {name="check_items_dosth3",line=2,regexp="^(> > > |> > |> |)一个用颅骨制成的钵。\\n里面装(满了|了七、八分满|了五、六分满)\\Z",script=function(n,l,w)    check_items.dosomething3(n,l,w)  end,},
	}
	for k,v in pairs(check_items_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"check_items",v.script,v.line)
	end
	closeclass("check_items")
	
	_tb={
		"你目前还没有任何为 checkexp=(.+) 的变量设定。",
	}
	local  check_exp_triggerlist={
	       {name="check_exp_dosth1",regexp=linktri(_tb),script=function(n,l,w)    check_exp.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(check_exp_triggerlist) do
		addtri(v.name,v.regexp,"check_exp",v.script,v.line)
	end
	closeclass("check_exp")
	
	_tb={
		"(邱山风|范一飞)倒在地上，挣扎了几下就死了。",
		"你从(邱山风|范一飞)的尸体身上搜出一支判官笔。",
		"你捡起一支判官笔。",
		"你向范一飞打听有关「来首十八摸吧！」的消息。",
		"你向邱山风打听有关「来首十八摸吧！」的消息。",
		"数码世界，数字地图，1094就是这里！",
		"数码世界，数字地图，1101就是这里！",
		"这里没有 fan 这个人。",
		"这里没有 qiu 这个人。",
	}
	local  dealwith_bi_triggerlist={
	       {name="dealwith_bi_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_bi.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_bi_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_bi",v.script,v.line)
	end
	closeclass("dealwith_bi")
	
	_tb={
		"(牧羊女|牧羊人)倒在地上，挣扎了几下就死了。",
		"你从(牧羊女|牧羊人)的尸体身上搜出一柄羊鞭。",
		"你捡起一柄羊鞭。",
		"你向牧羊女打听有关「来首十八摸吧！」的消息。",
		"你对着牧羊人「嘿嘿嘿」奸笑了几声。",
		"数码世界，数字地图，312就是这里！",
		"你要对谁做 hehe 这个动作？",
		"这里没有 nu 这个人。",
	}
	local  dealwith_bian_triggerlist={
	       {name="dealwith_bian_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_bian.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_bian_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_bian",v.script,v.line)
	end
	closeclass("dealwith_bian")
	
	_tb={
		"你从唐楠那里买下了一条铁链。",
		"你想买的东西我这里没有。",
		"有一天，你踩着七色云彩来迎娶『唐楠』",
		"这里没有 gao 这个人。",
		"有一天，你踩着七色云彩来迎娶『高升泰』",
		"高升泰说道：.*(你去扬州打铁铺的铁匠|不如你过去帮我看看吧)",
		"高升泰说道：(你刚才不是来领过铁链了吗|铁链已经发完了，我已经派)",
		"高升泰说道：你拿去护身，见到有打架斗殴的把他们送给段陉处置。",
		"有一天，你踩着七色云彩来迎娶『王铁匠』",
	}
	local  dealwith_chain_triggerlist={
	       {name="dealwith_chain_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_chain.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_chain_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_chain",v.script,v.line)
	end
	closeclass("dealwith_chain")
	
	_tb={
		"你把正在运行的真气强行压回丹田，站了起来。",
		"你从澄行的尸体身上搜出一把戒刀。",
		"你从道品禅师的尸体身上搜出一把戒刀。",
		"你从慧如尊者的尸体身上搜出一把戒刀。",
		"你对着道品禅师「嘿嘿嘿」奸笑了几声。",
		"你捡起一把戒刀。",
		"你说：“澄行美眉好呀！”",
		"这里没有这个人。",
		"(澄行|道品禅师|慧如尊者)倒在地上，挣扎了几下就死了。",
		"道尘给你一件戒刀。",
		"道尘禅师说道：抱歉，你来得不是时候，武器已经发完了。",
		"你要对谁做 hehe 这个动作？",
		"你要对谁做 ysis 这个动作？",
		"有一天，你踩着七色云彩来迎娶『澄行』",
		"有一天，你踩着七色云彩来迎娶『道尘』",
		"有一天，你踩着七色云彩来迎娶『道品』",
		"有一天，你踩着七色云彩来迎娶『慧如』",
		"这里没有 chanshi 这个人。",
		"数码世界，数字地图，964就是这里！",
		"你从镖头的尸体身上搜出一柄钢刀。",
		"你捡起一柄钢刀。",
		"镖头倒在地上，挣扎了几下就死了。",
	}
	local  dealwith_dao_triggerlist={
	       {name="dealwith_dao_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_dao.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_dao_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_dao",v.script,v.line)
	end
	closeclass("dealwith_dao")
	
	_tb={
		"你目前还没有任何为 check=falun 的变量设定。",
		"你目前还没有任何为 check=burn 的变量设定。",
		"数码世界，数字地图，(431|423|428|437)就是这里！",
	}
	local  dealwith_xs_triggerlist={
	       {name="dealwith_xs_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_xs.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_xs_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_xs",v.script,v.line)
	end
	closeclass("dealwith_xs")
	
	_tb={
		"你从王通治那里买下了一钱茯苓。",
		"哟，抱歉啊，我这儿正忙着呢……您请稍候。",
		"有一天，你踩着七色云彩来迎娶『王通治』",
	}
	local  dealwith_fuling_triggerlist={
	       {name="dealwith_fuling_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_fuling.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_fuling_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_fuling",v.script,v.line)
	end
	closeclass("dealwith_fuling")
	
	_tb={
		"王五说道：我…不知道。",
		"对方还没有完全昏迷，先等等吧。",
		"你将吴老板扶了起来背在背上。",
		"你目前还没有任何为 busyover=killwang 的变量设定。",
		"你目前还没有任何为 busyover=stealwu 的变量设定。",
		"你想行窃的对象不在这里。",
		"钱庄晚上不开，请天亮了再来！",
		"王五倒在地上，挣扎了几下就死了。",
		"王五脚下一个不稳，跌在地上昏了过去。",
		"王五说道：老子就是鬼刀王五，鬼刀王五就是你老子！纳命来吧！",
		"吴老板脚下一个不稳，跌在地上昏了过去。",
		"有一天，你踩着七色云彩来迎娶『大狼狗』",
		"有一天，你踩着七色云彩来迎娶『黄真』",
		"有一天，你踩着七色云彩来迎娶『王五』",
		"有一天，你踩着七色云彩来迎娶『吴老板』",
		"这里没有 wang 这个人。",
	}
	local  dealwith_gold_triggerlist={
	       {name="dealwith_gold_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_gold.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_gold_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_gold",v.script,v.line)
	end
	closeclass("dealwith_gold")
	
	_tb={
		"(澄寂|澄灵)倒在地上，挣扎了几下就死了。",
		"道尘给你一件齐眉棍。",
		"你从(澄寂|澄灵)的尸体身上搜出一根齐眉棍。",
		"你对着澄灵「嘿嘿嘿」奸笑了几声。",
		"你捡起一根齐眉棍。",
		"你说：“澄寂美眉好呀！”",
		"道尘禅师说道：抱歉，你来得不是时候，武器已经发完了。",
		"你要对谁做 hehe 这个动作？",
		"你要对谁做 ysis 这个动作？",
		"有一天，你踩着七色云彩来迎娶『澄寂』",
		"有一天，你踩着七色云彩来迎娶『澄灵』",
		"有一天，你踩着七色云彩来迎娶『道尘』",
		"这里没有 chanshi 这个人。",
	}
	local  dealwith_gun_triggerlist={
	       {name="dealwith_gun_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_gun.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_gun_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_gun",v.script,v.line)
	end
	closeclass("dealwith_gun")
	
	_tb={
		"你从(杨永福|唐楠)那里买下了一个食盒。",
		"你从(杨永福|唐楠)那里买下了一支火折。",
		"你想买的东西我这里没有。",
		"你向杨永福打听有关「起床没啊？」的消息。",
		"哟，抱歉啊，我这儿正忙着呢……您请稍候。",
		"有一天，你踩着七色云彩来迎娶『唐楠』",
		"有一天，你踩着七色云彩来迎娶『杨永福』",
		"这里没有 Yang yongfu 这个人。",
		"杂货铺晚上不开，请天亮了再来！",
	}
	local  dealwith_he_triggerlist={
	       {name="dealwith_he_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_he.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_he_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_he",v.script,v.line)
	end
	closeclass("dealwith_he")
	
	_tb={
		"你从宋老板那里买下了.+盆汽锅鸡。",
		"你向宋老板打听有关「鸡鸡还在不」的消息。",
		"哟，抱歉啊，我这儿正忙着呢……您请稍候。",
		"有一天，你踩着七色云彩来迎娶『宋老板』",
		"这里没有 song laoban 这个人。",
	}
	local  dealwith_ji_triggerlist={
	       {name="dealwith_ji_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_ji.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_ji_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_ji",v.script,v.line)
	end
	closeclass("dealwith_ji")
	
	_tb={
		"(青|白|红)衣武士倒在地上，挣扎了几下就死了。",
		"你从(青|白|红)衣武士的尸体身上除下一件铁甲。",
		"你从(青|白|红)衣武士的尸体身上搜出一柄.+剑。",
		"你捡起一柄.+剑。",
		"你目前还没有任何为 check=jian 的变量设定。",
		"你向(青|白|红)衣武士打听有关「先奸后杀」的消息。",
		"双飞，三飞，大家一起飞，先×.+ 个『 (青|白|红)衣武士 』中的第 .+个～～",
		"有一天，你踩着七色云彩来迎娶『青衣武士』",
		"这里没有 wei shi 这个人。",
	}
	local  dealwith_jian_triggerlist={
	       {name="dealwith_jian_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_jian.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_jian_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_jian",v.script,v.line)
	end
	closeclass("dealwith_jian")
	
	_tb={
		"你从店小二那里买下了一个牛皮酒袋。",
		"你将.+酒袋放入了大木桶中盛了满了水。",
		"你目前还没有任何为 busyover=fill 的变量设定。",
		"你向店小二打听有关「醉仙楼」的消息。",
		"你向冼老板打听有关「醉仙楼二楼」的消息。",
		"数码世界，数字地图，1805就是这里！",
		"数码世界，数字地图，437就是这里！",
		"数码世界，数字地图，948就是这里！",
		"数码世界，数字地图，1447就是这里！",
		"数码世界，数字地图，537就是这里！",
		"有一天，你踩着七色云彩来迎娶『小姗』",
		"这里没有 xian laoban 这个人。",
		"这里没有 xiao er 这个人。",
	}
	local  dealwith_jiudai_triggerlist={
	       {name="dealwith_jiudai_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_jiudai.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_jiudai_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_jiudai",v.script,v.line)
	end
	closeclass("dealwith_jiudai")
	
	_tb={
		"你目前还没有任何为 sellyao=over 的变量设定。",
		"有一天，你踩着七色云彩来迎娶『何红药』",
	}
	local  dealwith_sellyao_triggerlist={
	       {name="dealwith_sellyao_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_sellyao.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_sellyao_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_sellyao",v.script,v.line)
	end
	closeclass("dealwith_sellyao")
	
	_tb={
		"你从小贩那里买下了一捆绳子。",
		"你向小贩打听有关「上吊的绳子有哇～」的消息。",
		"数码世界，数字地图，615就是这里！",
		"数码世界，数字地图，837就是这里！",
		"这里没有 seller 这个人。",
		"这里没有 xiao fan 这个人。",
	}
	local  dealwith_shengzi_triggerlist={
	       {name="dealwith_shengzi_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_shengzi.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_shengzi_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_shengzi",v.script,v.line)
	end
	closeclass("dealwith_shengzi")
	
	_tb={
		"有一天，你踩着七色云彩来迎娶『李天恒』",
		"有一天，你踩着七色云彩来迎娶『冷谦』",
	}
	local  dealwith_tyl_triggerlist={
	       {name="dealwith_tyl_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_tyl.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_tyl_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_tyl",v.script,v.line)
	end
	closeclass("dealwith_tyl")
	
	_tb={
		"歌女倒在地上，挣扎了几下就死了。",
		"你从歌女的尸体身上搜出一张.+琴。",
		"你从小贩那里买下了一根扁担。",
		"你低下头来，见欧阳克娇羞之态，娇美不可方物，心中一荡，便凑过去在他脸颊上吻了一下。",
		"你附近没有这样东西。",
		"你向歌女打听有关「来首十八摸吧！」的消息。",
		"你要对谁做 kiss4 这个动作？",
		"你找不到 corpse 这样东西。",
		"数码世界，数字地图，1383就是这里！",
		"数码世界，数字地图，280就是这里！",
		"数码世界，数字地图，926就是这里！",
		"这里没有 nu 这个人。",
	}
	local  dealwith_staff_triggerlist={
	       {name="dealwith_staff_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_staff.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_staff_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_staff",v.script,v.line)
	end
	
	_tb={
		"你向欧阳克打听有关「怪蛇」的消息。\\n但是很显然的，欧阳克现在的状况没有办法给你任何答覆。\\Z",
		"你向欧阳克打听有关「怪蛇」的消息。\\n对方正忙着呢，你等会儿在问话吧。\\Z",
		"你向欧阳克打听有关「怪蛇」的消息。\\n欧阳克说道：以你的驯兽术操控一条怪蛇已经十分吃力，不能控制更多的怪蛇了。\\Z",
		"欧阳克给你一只怪蛇。\\n欧阳克给你一根怪蛇杖。\\Z",
	}
	local  dealwith_staff_m_triggerlist={
	       {name="dealwith_staff_dosth2",line=2,regexp=linktri(_tb),script=function(n,l,w)    dealwith_staff.dosomething2(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_staff_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"dealwith_staff",v.script,v.line)
	end
	closeclass("dealwith_staff")
	
	_tb={
		"你从莫不收的尸体身上搜出一根铜棒。",
		"你说：“莫不收美眉好呀！”",
		"你折下一杆竹子，做了一只竹棒。",
		"莫不收倒在地上，挣扎了几下就死了。",
		"能做竹棒的竹子都截光了。",
		"你目前还没有任何为 checkbang=yes 的变量设定。",
		"你要对谁做 ysis 这个动作？",
		"数码世界，数字地图，1118就是这里！",
		"数码世界，数字地图，2048就是这里！",
	}
	local  dealwith_stick_triggerlist={
	       {name="dealwith_stick_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_stick.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_stick_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_stick",v.script,v.line)
	end
	
	_tb={
		"你附近没有这样东西。\\n你附近没有这样东西。\\Z",
		"你捡起一根黄竹棒。\\n你附近没有这样东西。\\Z",
		"你捡起一根黄竹棒。\\n你捡起一根黄竹棒。\\Z",
		"你捡起一根黄竹棒。\\n你捡起一根铜棒。\\Z",
		"你捡起一根黄竹棒。\\n你捡起一根竹棒。\\Z",
		"你捡起一根铜棒。\\n你附近没有这样东西。\\Z",
		"你捡起一根铜棒。\\n你捡起一根黄竹棒。\\Z",
		"你捡起一根铜棒。\\n你捡起一根铜棒。\\Z",
		"你捡起一根铜棒。\\n你捡起一根竹棒。\\Z",
		"你捡起一根竹棒。\\n你附近没有这样东西。\\Z",
		"你捡起一根竹棒。\\n你捡起一根黄竹棒。\\Z",
		"你捡起一根竹棒。\\n你捡起一根铜棒。\\Z",
		"你捡起一根竹棒。\\n你捡起一根竹棒。\\Z",
	}
	local  dealwith_stick_m_triggerlist={
	       {name="dealwith_stick_dosth2",line=2,regexp=linktri(_tb),script=function(n,l,w)    dealwith_stick.dosomething2(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_stick_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"dealwith_stick",v.script,v.line)
	end
	closeclass("dealwith_stick")
	
	_tb={
		"有一天，你踩着七色云彩来迎娶『静风』",
	}
	local  dealwith_yaodai_triggerlist={
	       {name="dealwith_yaodai_dosth1",regexp=linktri(_tb),script=function(n,l,w)    dealwith_yaodai.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_yaodai_triggerlist) do
		addtri(v.name,v.regexp,"dealwith_yaodai",v.script,v.line)
	end

	_tb={
		"你向静风打听有关「柳叶刀」的消息。\\n静风师太给你一把柳叶刀。\\Z",
		"你向静风打听有关「柳叶刀」的消息。\\n静风说道：.+你现在身上不是有柳叶刀吗，怎麽又来要了？ 真是贪得无餍！\\Z",
		"你向静风打听有关「柳叶刀」的消息。\\n静风说道：我不是刚给过你吗，怎麽又来要了？真是贪得无餍！\\Z",
		"你向静风打听有关「皮腰带」的消息。\\n静风师太给你一条皮腰带。\\Z",
		"你向静风打听有关「皮腰带」的消息。\\n静风说道：.+你现在身上不是有皮腰带吗，怎麽又来要了？ 真是贪得无餍！\\Z",
		"你向静风打听有关「皮腰带」的消息。\\n静风说道：我不是刚给过你吗，怎麽又来要了？真是贪得无餍！\\Z",
		"你向静风打听有关「软剑」的消息。\\n静风师太给你一把软剑。\\Z",
		"你向静风打听有关「软剑」的消息。\\n静风说道：.+你现在身上不是有软剑吗，怎麽又来要了？ 真是贪得无餍！\\Z",
		"你向静风打听有关「软剑」的消息。\\n静风说道：我不是刚给过你吗，怎麽又来要了？真是贪得无餍！\\Z",
		"你向静风打听有关「天香断续膏」的消息。\\n静风说道：我不是刚给过你一盒天香断续膏吗，怎麽又来要了？ 真是贪得无餍！\\Z",
		"你向静风打听有关「天香断续膏」的消息。\\n你获得一盒天香断续膏。\\Z",
	}
	local  dealwith_yaodai_m_triggerlist={
	       {name="dealwith_yaodai_dosth2",line=2,regexp=linktri(_tb),script=function(n,l,w)    dealwith_yaodai.dosomething2(n,l,w)  end,},
	}
	for k,v in pairs(dealwith_yaodai_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"dealwith_yaodai",v.script,v.line)
	end
	closeclass("dealwith_yaodai")
end
checki.update()