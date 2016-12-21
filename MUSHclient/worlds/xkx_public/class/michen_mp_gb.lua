mp_gb={}
mp_gb_watch={}
mp_gb_pre={}
mp_gb_gold={}
mp_gb_gold_fujia={}
mp_gb_gold_owner={}
mp_gb_gold_robber={}
mp_gb_gold_ti={}

fujiaidList="zhang gui|zhang gui|da caizhu|fu jia|gui furen|hao shen|zhubao shang"
fujiaNameList="茶庄掌柜|绸缎庄掌柜|大财主|富贾|贵妇人|豪绅|珠宝商"
goldidList="ma nao|shui jing|yu shi|zhen zhu|zuan shi|fei cui|hetian yu"
goldNameList="玛瑙|水晶|玉石|珍珠|钻石|翡翠|和田玉"
--lianwunum=0

goldqzh={
	roomName="土地庙|后渚港|清净寺|学堂|施琅将军府|济世堂老店|城隍庙|阿拉伯宅区|顺济桥|安海港",
	roomNo="80|78|48|83|84|4|15|47|61|67",
	askName="小流氓|水师士兵|回回|欧阳詹|武将|王通治|庙祝|阿拉伯商人|武将|苦力",
	askid="punk|bing|huihui|ouyang zhan|wu jiang|wang tongzhi|miao zhu|alabo shangren|wu jiang|ku li",
}
golddl={
	roomName="法堂|药铺|薛记成衣铺|太和居二楼|王府大门：|北门|玉虚观|客店|五华楼大门|镇雄|下关城|太和城",
	roomNo="292|282|283|280|177|171|226|324|313|158|168|293",
	askName="段陉|何红药|薛老板|宋老板|褚万里|士兵|刀白凤|店小二|素衣卫士|牧羊女|台夷商贩|士兵",
	askid="duan xing|he hongyao|xue laoban|song laoban|chu wanli|bing|dao baifeng|xiao er|wei shi|muyang nu|shang fan|bing",
}
goldfs={
	roomName="戚家大院|麻溪铺|英雄会馆|英雄楼|烧饼油条铺|英雄典当|林间道",
	roomNo="627|626|103|105|109|111|113",
	askName="戚长发|潇湘子|凤一鸣|凤七|王老汉|老朝奉|张朝唐",
	askid="qi changfa|xiaoxiang|feng yiming|feng qi|wang laohan|lao chaofeng|zhang chaotang",
}
goldhz={
	roomName="玉泉书院|大雄宝殿|法镜寺|山路|铁匠铺|楼外楼|天外天客店|钱塘江畔|牛家村|酒店",
	roomNo="1171|1131|1138|1144|1256|1255|1257|1158|1277|1278",
	askName="顾炎武|枯木禅师|小沙弥|采茶女|欧冶子|店小二|店小二|剑客|郭啸天|曲三",
	askid="gu yanwu|kumu|shami|girl|ou yezi|xiao er|xiao er|jian ke|guo xiaotian|qu san",
}
function alias.gblianwu(a)
	run("enter dong")
	roomno_now=2033
	--lianwunum=1
	--if tonumber(a)~=nil then lianwunum_set=tonumber(a) else lianwunum_set=2 end
	alias.uw()
	skills_num=1
	alias.lianwu()
end
------------------------------------------------------------------------------------
-- mp_gb_watch
------------------------------------------------------------------------------------
function mp_gb_watch.dosomething1(n,l,w)
	if findstring(l,"一边打架一边要饭？你真是活腻了！") then
		if mpweapon~=nil and string.len(mpweapon)>0 then
			alias.wi(mpweapon)
			run("jiajin max")
			alias.yjl()
		else run("jiali max") end
	end
	if findstring(l,"鬼鬼祟祟的对你道：鲁长老让你找的是这个吧，快快收好，别被巫师看到了。") then
		gold["false"]=1
	end
	if findstring(l,"你伸手往怀中一摸，惊觉密函不见了！") then
		sx.name=""
		sx.id=""
	end
end
------------------------------------------------------------------------------------
-- mp_gb_pre
------------------------------------------------------------------------------------
function mp_gb_pre.dosomething1(n,l,w)
	local _f,_tb,a,b,c
	if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
		alias.resetidle()
		if not isopen("skills_lian") then
			if tonumber(roomno_now)==me.menpaiJobStart then run("h;ask lu youjiao about gold") else alias.flytoid(me.menpaiJobStart) end
		end
	end
	a,b,c=string.find(l,"数码世界，数字地图，(%d+)就是这里！")
	if c~=nil and tonumber(c)==me.menpaiJobStart then
		alias.resetidle()
		run("h;ask lu youjiao about gold")
	end
	if findstring(l,"你目前还没有任何为 checkmihan=yes 的变量设定。") then
		if sx.name~=nil and string.len(sx.name)>0 then
			closeclass("mp_gb_pre")
			openclass("mp_gb_sx")
			alias.flytonpc(sx.name)
		else run("set sx=over") end
	end
	a,b,c=string.find(l,"密函上面写着：(.-)[壮士|大师]+亲启。")
	if c~=nil then
		sx.name=c
		alias.dealwithName()
		sx.id=""
	end
	if findstring(l,"你目前还没有任何为 sx=over 的变量设定。") then
		alias.resetidle()
		if havefj>0 then alias.startworkflow() else alias.gblianwu(2) end
	end
	if findstring(w[0],"你向鲁有脚打听有关「job」的消息。\n鲁有脚说道：我现在没要事让你去干，待会儿你再来吧。") then
		alias.resetidle()
		run("set sx=over")
	end
	if findstring(w[0],"你向鲁有脚打听有关「job」的消息。\n鲁有脚说道：你还没完成我交待的工作，怎麽又来问我","你向鲁有脚打听有关「job」的消息。\n鲁有脚点了点头。\n鲁有脚说道：你来得正巧，我有件事要你去办！\n鲁有脚伸手入怀取出一封信笺。\n鲁有脚对你说道：你把这封密函交给.+，务必亲自送到！") then
		alias.resetidle()
		sx.name=""
		sx.id=""
		run("look mihan")
		run("set checkmihan=yes")
	end
	if findstring(l,"你目前还没有任何为 checkhp=addneili 的变量设定。") then
		if havefj>0 and hp.neili>(hp.maxneili*set_neili_job/100) then alias.tdz() end
	end
	if findstring(l,"你目前还没有任何为 checkexpover=mp 的变量设定。") then
		alias.resetidle()
		if add.exp>10 and mpLimited.MarkExp<me.menpaiLimited then mpLimited.MarkExp=tonumber(me.menpaiLimited) end
		if add.exp>=0 and add.exp<10 then
			if gold["false"]~=nil and gold["false"]>0 then
				-- 出现beg到同ip丐帮玩家给你的gold
				gold["false"]=0
			else
				if mpLimited.mpexp>me.menpaiLimited then
					print("设置为上限点。")
					mpJobLimited=1
					print("统计到的GOLD上限为："..mpLimited.mpexp)
					mpLimited.MarkExp=tonumber(mpLimited.mpexp)
					if mpLimited.MarkTime<(os.time()-3600) then
						-- 到GOLD时间却仍然busy，推迟2分钟
						mpLimited.MarkTime=os.time()-3600+120
					end
				end
			end
		end
		gold.num=gold.num+1
		print("上次FJ后完成gold任务"..gold.num.."/"..gold.setnum.."次。")
		--alias.startworkflow()
		alias.flyto("武庙")
	end
	if findstring(l,"你口念咒语『神马都是浮云,虾米都是尘土』，『武庙』立马到达！") then
		run("put 5 silver in xiang")
		alias.startworkflow()
	end
	if findstring(l,"这里没有 lu youjiao 这个人。") then
		alias.resetidle()
		alias.gblianwu(2)
	end
	if findstring(l,"你目前还没有任何为 lian=over 的变量设定。") then
		alias.resetidle()
		if havefj>0 then
			alias.uw()
			alias.startworkflow()
		else
			if roomno_now==me.menpaiJobStart then
				if gold.id~=nil and string.len(gold.id)>0 then run("ask lu youjiao about here") else run("ask lu youjiao about gold") end
			else alias.flytoid(me.menpaiJobStart) end
		end
	end
	if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
		alias.resetidle()
		alias.startworkflow()
	end
	if findstring(l,"对方正忙着呢，你等会儿在问话吧。") then
		alias.resetidle()
		wait.make(function()
			_f=function() run("ask lu youjiao about gold") end
			wait.time(1);_f()
		end)
	end
	if findstring(w[0],"鲁有脚对你说道：这里是土地庙，其它的在下不便多说。") then
		alias.resetidle()
		run("give "..gold.id.." to lu youjiao")
		gold.id=""
	end
	if findstring(w[0],"你向鲁有脚问道：这位.+，.+初到贵宝地，不知这里有些什麽风土人情？\n但是很显然的，鲁有脚现在的状况没有办法给你任何答覆。") then
		alias.resetidle()
		wait.make(function()
			_f=function() run("give "..gold.id.." to lu youjiao");gold.id="" end
			wait.time(1);_f()
		end)
	end
	if findstring(w[0],"值不少两黄金，你此行收获甚大，辛苦了，快下去歇息吧。") then
		alias.resetidle()
		gold.roomNo=0
		run("drop zuan shi;drop zhen zhu;drop ma nao;drop hetian yu;drop shui jing;drop yu shi;drop fei cui")
		alias.checkexp("mp")
	end
	if findstring(w[0],"好像不是你所有吧？想蒙混过关，当我是大傻蛋？","交给一名小叫化，吩咐他放入地底密室。") then
		alias.resetidle()
		alias.startworkflow()
	end
	
	if findstring(w[0],"你向鲁有脚打听有关「gold」的消息。\n鲁有脚说道：我不是已经吩咐你去筹措黄金了吗？") then
		alias.resetidle()
		run("sorry lu youjiao")
		if havefj>0 then alias.startworkflow()
		else
			if sx.open>0 then run("ask lu youjiao about job") else alias.gblianwu(2) end
		end
	end
	if findstring(w[0],"你向鲁有脚打听有关「gold」的消息。\n鲁有脚说道：你先把.+练好了再说吧。") then
		alias.resetidle()
		if havefj>0 then alias.startworkflow()
		else
			--if sx.open>0 then run("ask lu youjiao about job") else alias.dz("addneili") end
			if sx.open>0 then run("ask lu youjiao about job") else alias.gblianwu(2) end
		end
	end
	if findstring(w[0],"你向鲁有脚打听有关「gold」的消息。\n鲁有脚说道：目前没有什么任务，.+请先稍事歇息罢。","你向鲁有脚打听有关「gold」的消息。\n鲁有脚说道：最近好像没什么富贾的消息","你向鲁有脚打听有关「gold」的消息。\n但是很显然的，鲁有脚现在的状况没有办法给你任何答覆。") then
		alias.resetidle()
		if havefj>0 then alias.startworkflow() else alias.gblianwu(2) end
	end
	a,b,c=string.find(w[0],"你向鲁有脚打听有关「gold」的消息。\n鲁有脚在你的耳边悄声说道：.+\n鲁有脚说道：你去(.+)附近打听看看，看看是否有富贾经过，向其讨一些黄金来。")
	if c~=nil then
		alias.resetidle()
		gold.place=c
		gold.index=1
		gold.searchTimes=1
		gold.have=0
		gold.over=0
		if findstring(gold.place,"泉州") then
			gold.roomNameList=goldqzh.roomName
			gold.roomNoList=goldqzh.roomNo
			gold.askNameList=goldqzh.askName
			gold.askidList=goldqzh.askid
		end
		if findstring(gold.place,"大理") then
			gold.roomNameList=golddl.roomName
			gold.roomNoList=golddl.roomNo
			gold.askNameList=golddl.askName
			gold.askidList=golddl.askid
		end
		if findstring(gold.place,"杭州") then
			gold.roomNameList=goldhz.roomName
			gold.roomNoList=goldhz.roomNo
			gold.askNameList=goldhz.askName
			gold.askidList=goldhz.askid
		end
		if findstring(gold.place,"佛山") then
			gold.roomNameList=goldfs.roomName
			gold.roomNoList=goldfs.roomNo
			gold.askNameList=goldfs.askName
			gold.askidList=goldfs.askid
		end
		_tb=utils.split(gold.askNameList,"|")
		gold.askName=_tb[gold.index]
		_tb=utils.split(gold.askidList,"|")
		gold.askid=_tb[gold.index]
		_tb=utils.split(gold.roomNoList,"|")
		gold.roomNo=tonumber(_tb[gold.index])
		closeclass("mp_gb_pre")
		openclass("mp_gb_gold")
		alias.flytoid(gold.roomNo)
	end
end
------------------------------------------------------------------------------------
-- mp_gb_gold
------------------------------------------------------------------------------------
function mp_gb_gold.dosomething1(n,l,w)
	local _f,_tb,a,b,c,d
	wait.make(function()
		a,b,c=string.find(l,"数码世界，数字地图，(%d+)就是这里！")
		if c~=nil and tonumber(c)==gold.roomNo then
			alias.resetidle()
			run("ask "..gold.askid.." about 富贾")
		end
		a,b,c=string.find(l,"这里没有 (.+) 这个人。")
		if c~=nil and c==gold.askid then
			alias.resetidle()
			run("set searchgold=next")
		end
		if findstring(l,"有一天，你踩着七色云彩来迎娶『鲁有脚』") then
			alias.resetidle()
			closeclass("mp_gb_gold")
			openclass("mp_gb_pre")
			if gold.id==nil or string.len(gold.id)==0 then
				run("sorry lu youjiao")
				_f=function() run("ask lu youjiao about gold") end
				if cmd.nums<cmd.setnums then _f() else wait.time(1);_f() end
			else run("ask lu youjiao about here") end
		end
		if findstring(l,"对方正忙着呢，你等会儿在问话吧。","你忙着呢，你等会儿在问话吧。","但是很显然的，"..gold.askName.."现在的状况没有办法给你任何答覆。") then
			alias.resetidle()
			_f=function() run("ask "..gold.askid.." about 富贾") end
			wait.time(1);_f()
		end
		if findstring(l,"你目前还没有任何为 searchgold=next 的变量设定。") then
			alias.resetidle()
			gold.index=gold.index+1
			_tb=utils.split(gold.roomNoList,"|")
			if gold.index<table.getn(_tb) then
				_tb=utils.split(gold.askNameList,"|")
				gold.askName=_tb[gold.index]
				_tb=utils.split(gold.askidList,"|")
				gold.askid=_tb[gold.index]
				_tb=utils.split(gold.roomNoList,"|")
				gold.roomNo=tonumber(_tb[gold.index])
				if havefj>0 then alias.startworkflow()
				else
					_f=function() alias.flytoid(gold.roomNo) end
					if cmd.nums<cmd.setnums then _f() else wait.time(1);_f() end
				end
			else
				gold.searchTimes=gold.searchTimes+1
				if gold.searchTimes<=10 then
					gold.index=1
					_tb=utils.split(gold.askNameList,"|")
					gold.askName=_tb[gold.index]
					_tb=utils.split(gold.askidList,"|")
					gold.askid=_tb[gold.index]
					_tb=utils.split(gold.roomNoList,"|")
					gold.roomNo=tonumber(_tb[gold.index])
					if havefj>0 then alias.startworkflow()
					else
						_f=function() alias.dz(set_neili) end
						if cmd.nums<cmd.setnums then _f() else wait.time(1);_f() end
					end
				else
					-- 搜索富贾失败
					gold.id=""
					_f=function() run("set searchgold=over") end
					if cmd.nums<cmd.setnums then _f() else wait.time(1);_f() end
				end
			end
		end
		a,b,c=string.find(l,"这里没有 (.+)。")
		if c~=nil and c==gold.fujiaid then
			alias.resetidle()
			if havefj>0 then alias.startworkflow()
			else
				_f=function() alias.searchNextGoldRoom() end
				if cmd.nums<cmd.setnums then _f() else wait.time(0.5);_f() end
			end
		end
		a,b,c,d=string.find(l,"这里没有 (.+)%s+(%d+)。")
		if c~=nil and d~=nil and c==gold.fujiaid and d==gold.zhangguiid then
			alias.resetidle()
			if havefj>0 then alias.startworkflow()
			else
				_f=function() alias.searchNextGoldRoom() end
				if cmd.nums<cmd.setnums then _f() else wait.time(0.5);_f() end
			end
		end
		if findstring(l,"你目前还没有任何为 searchgold=over 的变量设定。") then
			alias.resetidle()
			closeclass("mp_gb_gold_ti")
			alias.flytonpc("鲁有脚")
		end
		a,b,c=string.find(l,"你决定开始跟随(.+)一起行动。")
		if c~=nil then
			alias.resetidle()
			if hp.water<(hp.maxwater-40) then run("drink jiudai") end
			if c==gold.fujiaName then
				gold.goldindex=1
				_tb=utils.split(goldNameList,"|")
				gold.Name=_tb[gold.goldindex]
				_tb=utils.split(goldidList,"|")
				gold.id=_tb[gold.goldindex]
				run("set no_accept 0;set brief 1")
				openclass("mp_gb_gold_ti")
			else
				-- Zhang gui有茶庄掌柜和绸缎庄掌柜两个，第一个不对则follow下一个
				gold.zhangguiid=gold.zhangguiid+1
				run("follow "..gold.fujiaid.." "..gold.zhangguiid)
			end
		end
		if findstring(l,"你目前还没有任何为 busyover=begover 的变量设定。") then
			alias.resetidle()
			closeclass("mp_gb_gold_ti")
			if gold.have==0 and gold.over>0 then run("get "..alias.goldid(gold.Name)) end
			run("set searchgold=over")
		end
		a,b,c,d=string.find(l,"[> ]*(.+)低头想了一会，又看了看你，摇摇头，叹了口气，丢给你一[颗|块]+(.+)。")
		if c~=nil and d~=nil and c==gold.fujiaName then
			alias.resetidle()
			gold.Name=d
			gold.id=alias.goldid(gold.Name)
			gold.have=1
			closeclass("mp_gb_gold_ti")
		end
		a,b,c,d=string.find(l,"[> ]*(.+)说道：当年我曾受过(.+)的恩惠，这.+算是我的一番心意，请代[为转告|我交给他吧]+。")
		if c~=nil and d~=nil and c==gold.fujiaName then
			alias.resetidle()
			gold.ownerName=d
			if gold.ownerName==me.charname then
				-- 等待别人给你珠宝
				closeclass("mp_gb_gold_ti")
				gold.robberid=""
				openclass("mp_gb_gold_robber")
				run("id here;set checkgoldrobber=yes")
			else
				if gold.have>0 and findstring("黄帮主|乔帮主|简长老|梁长老|一位不愿留名的丐帮侠士|洪老前辈|鲁长老",gold.ownerName) then
					closeclass("mp_gb_gold_ti")
					alias.checkbusy("begover")
					gold.over=1
				else
					if gold.have>0 and gold.over==0 then
						-- 等待给别人珠宝
						closeclass("mp_gb_gold_ti")
						gold.givegoldid=gold.id
						gold.ownerid=""
						gold.id=""
						openclass("mp_gb_gold_owner")
						run("id here")
						alias.checkbusy("giveowner")
					else
						-- npc给了别人珠宝，不关我事
					end
				end
			end
		end
		if findstring(l,"你目前还没有任何为 checkgoldowner=yes 的变量设定。") then
			alias.resetidle()
			if gold.ownerid~=nil and string.len(gold.ownerid)>0 then run("give "..gold.ownerid.." "..gold.givegoldid) end
			run("drop "..gold.givegoldid)
			gold.givegoldid=""
			gold.have=0
			if gold.begPlayerNum~=nil and gold.begPlayerNum>0 then print("出现我beg到别人的，别人beg到我的，给别人gold后等待别人给我gold")
			else if havefj>0 then alias.startworkflow() else alias.dz(set_neili) end end
		end
		if findstring(l,"你目前还没有任何为 checkgoldrobber=yes 的变量设定。") then
			alias.resetidle()
			gold.begPlayerNum=1
			run("beg1 "..gold.robberid)
		end
		if findstring(l,"你要对谁做 beg1 这个动作？") then
			alias.resetidle()
			if gold.begPlayerNum>0 then
				closeclass("mp_gb_gold_robber")
				-- #say "和~(~@gold.fujiaName~)给你一~{颗|块~}~(%x~)。一起进行双触发，因为有可能对方不给你"
				gold.id=""
				gold.begPlayerNum=-100
				run("set searchgold=over")
			end
		end
		if findstring(l,"你说道：「.+，我求你一件事，你肯答允么？」") then
			alias.resetidle()
			gold.begPlayerNum=gold.begPlayerNum+1
			if gold.begPlayerNum~=nil and gold.begPlayerNum>=30 then
				closeclass("mp_gb_gold_robber")
				gold.id=""
				gold.begPlayerNum=-100
				run("set searchgold=over")
			else
				if gold.begPlayerNum>0 then
					_f=function() run("beg1 "..gold.robberid) end
					wait.time(1);_f()
				end
			end
		end
		a,b,c,d=string.find(l,"[> ]*(.+)给你一[颗|块]+(.+)。")
		if c~=nil and d~=nil and c==gold.robberName then
			alias.resetidle()
			closeclass("mp_gb_gold_robber")
			gold.Name=d
			gold.id=alias.goldid(gold.Name)
			gold.begPlayerNum=-100
			gold.have=1
			gold.over=1
			closeclass("mp_gb_gold_ti")
			if gold.givegoldid~=nil and string.len(gold.givegoldid)>0 then
				-- 出现我beg到别人的，别人beg到我的，别人给我gold后等待给别人gold
			else alias.checkbusy("begover") end
		end
		a,b,c=string.find(l,"你口念咒语『神马都是浮云,虾米都是尘土』，『(.+)』立马到达！")
		if c~=nil and c==gold.roomName then
			alias.resetidle()
			run("follow "..gold.fujiaid)
		end
		a,b,c=string.find(l,"浮云朵朵飘，飘到了 %d+ 个『(.+)』中的第 %d+ 个～～")
		if c~=nil and c==gold.roomName then
			alias.resetidle()
			run("follow "..gold.fujiaid)
		end
		a,b,c=string.find(l,"你装出可怜巴巴的样子，慢慢地向(.+)走过去，伸出双手，想要[些|杯]")
		if c~=nil then
			alias.resetidle()
			gold.goldindex=gold.goldindex+1
			if gold.goldindex>7 then gold.goldindex=1 end
			_tb=utils.split(goldNameList,"|")
			gold.Name=_tb[gold.goldindex]
			_tb=utils.split(goldidList,"|")
			gold.id=_tb[gold.goldindex]
		end
		a,b,c,d=string.find(l,"你装出可怜巴巴的样子，慢慢地向(.+)走过去，伸出双手，想要[颗|块]+(.-)%.%.%.")
		if c~=nil and d~=nil and c==gold.fujiaName then
			gold.Name=d
			gold.id=alias.goldid(gold.Name)
		end
		if findstring(l,"你目前还没有任何为 busyover=giveowner 的变量设定。") then
			alias.resetidle()
			run("set checkgoldowner=yes")
		end
		if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
			alias.resetidle()
			if havefj>0 then alias.startworkflow()
			else
				gold.searchTimes=gold.searchTimes+1
				if gold.searchTimes<=10 then alias.flytoid(gold.roomNo)
				else
					-- 搜索富贾失败
					gold.id=""
					run("set searchgold=over")
				end
			end
		end
		if findstring(l,"你目前还没有任何为 checkfujiaid=yes 的变量设定。") then
			alias.resetidle()
			-- 检查身边的富贾id
			if gold.fujiaid~=nil and string.len(gold.fujiaid)>0 then
				run("follow "..gold.fujiaid)
			else
				_f=function() run("ask "..gold.askid.." about 富贾") end
				wait.time(1);_f()
			end
		end
		a,b,c,d=string.find(l,"[> ]*(.+)丢下一[颗|块]+(.+)。")
		if c~=nil and d~=nil and c==gold.robberName then
			alias.resetidle()
			if gold.begPlayerNum~=nil and gold.begPlayerNum>0 then
				gold.Name=d
				gold.id=""
				gold.begPlayerNum=-100
				gold.have=0
				gold.over=1
				closeclass("mp_gb_gold_ti")
				if gold.givegoldid~=nil and string.len(gold.givegoldid)>0 then
					-- 出现我beg到别人的，别人beg到我的，别人给我gold后等待给别人gold
				else alias.checkbusy("begover") end
			end
		end
		a,b,c,d=string.find(l,"[> ]*(.+)对着(.+)说了声「告辞」，转身渐渐走远了。")
		if c~=nil and d~=nil and c==gold.fujiaName then
			alias.resetidle()
			if d~="你" then gold.robberName=d end
		end
		a,b,c=string.find(l,"你捡起一[颗|块]+(.+)。")
		if c~=nil then
			alias.resetidle()
			gold.Name=c
			gold.id=alias.goldid(gold.Name)
			gold.have=1
		end
		if findstring(w[0],"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\n.+说道：怎么老有.+打探消息，烦不烦啦！") then
			alias.resetidle()
			run("set searchgold=next")
		end
		if findstring(w[0],"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\n.+说道：这附近没见到什么富贾。","你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\n.+说道：你跟我套近乎不会是看上我了吧？") then
			alias.resetidle()
			_f=function() run("ask "..gold.askid.." about 富贾") end
			wait.time(1);_f()
		end
		a,b,c=string.find(w[0],"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\n.+说道：踏遍铁鞋无觅处，得来全部费功夫。你看不是有个(.+)正往这里走来了吗？")
		if c~=nil then
			alias.resetidle()
			gold.fujiaName=c
			gold.fujiaid=alias.fujiaid(gold.fujiaName)
			gold.zhangguiid=1
			run("follow "..gold.fujiaid)
		end
		if findstring(w[0],"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\n.+说道：你怀中的金银财宝都快掉出来了，还瞎打听什么！") then
			alias.resetidle()
			run("drop ma nao;drop zhen zhu;drop yu shi;drop hetian yu;drop zuan shi;drop fei cui;drop shui jing")
			-- 搜索富贾失败
			gold.have=0
			gold.over=0
			gold.id=""
			run("set searchgold=over")
		end
		if findstring(w[0],"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\n.+说道：你身边不是就有一个吗，还问我？") then
			alias.resetidle()
			-- 检查身边的富贾id
			gold.fujiaid=""
			openclass("mp_gb_gold_fujia")
			run("id here;set checkfujiaid=yes")
		end
		if findstring(w[0],"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\n.+说道：你先瞪大眼睛看看这里是什么地界再问我吧。") then
			alias.resetidle()
			gold.roomNo=0
			gold.id=""
			gold.have=0
			gold.over=0
			run("set searchgold=over")
		end
		a,b,c,d=string.find(w[0],"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\n.+说道：刚才倒是有个(.+)从这里经过，好像是往(.+)那边去了。")
		if c~=nil and d~=nil then
			alias.resetidle()
			-- 下次从下一个询问的npc开始
			gold.have=0
			gold.over=0
			gold.index=gold.index+1
			_tb=utils.split(gold.roomNoList,"|")
			if gold.index<=table.getn(_tb) then
				_tb=utils.split(gold.askNameList,"|")
				gold.askName=_tb[gold.index]
				_tb=utils.split(gold.askidList,"|")
				gold.askid=_tb[gold.index]
				_tb=utils.split(gold.roomNoList,"|")
				gold.roomNo=tonumber(_tb[gold.index])
			else
				gold.searchTimes=gold.searchTimes+1
				gold.index=1
				_tb=utils.split(gold.askNameList,"|")
				gold.askName=_tb[gold.index]
				_tb=utils.split(gold.askidList,"|")
				gold.askid=_tb[gold.index]
				_tb=utils.split(gold.roomNoList,"|")
				gold.roomNo=tonumber(_tb[gold.index])
			end
			gold.fujiaName=c
			gold.fujiaid=alias.fujiaid(gold.fujiaName)
			gold.roomName=d
			gold.zhangguiid=1
			if gold.roomName=="青竹林" then alias.flyto("青竹林","大理")
			elseif gold.roomName=="山路" then alias.flyto("山路","泉州")
			elseif gold.roomName=="青石大道" then alias.flyto("青石大道","杭州")
			elseif gold.roomName=="大道" then alias.flyto("大道","杭州")
			elseif gold.roomName=="土地庙" then alias.flyto("土地庙","泉州")
			elseif gold.roomName=="密林" then alias.flyto("密林","大理")
			else alias.flyto(gold.roomName) end
		end
		a,b,c=string.find(w[0],"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\n(.+)。\n.+说道：这附近没见到什么富贾。")
		if c~=nil then
			alias.resetidle()
			if not findstring(c,"那边去了") then
				_f=function() run("ask "..gold.askid.." about 富贾") end
				wait.time(1);_f()
			end
		end
		a,b,c=string.find(w[0],"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\n一个.+朝这边走了过来。\n.+说道：踏遍铁鞋无觅处，得来全部费功夫。你看不是有个(.+)正往这里走来了吗？")
		if c~=nil then
			alias.resetidle()
			gold.fujiaName=c
			gold.fujiaid=alias.fujiaid(gold.fujiaName)
			gold.zhangguiid=1
			run("follow "..gold.fujiaid)
		end
	end)
end
------------------------------------------------------------------------------------
-- mp_gb_gold_fujia
------------------------------------------------------------------------------------
function mp_gb_gold_fujia.dosomething1(n,l,w)
	if findstring(fujiaNameList,w[2]) then
		gold.fujiaName=w[2]
		gold.fujiaid=alias.fujiaid(gold.fujiaName)
		gold.zhangguiid=1
		closeclass("mp_gb_gold_fujia")
	end
end
------------------------------------------------------------------------------------
-- mp_gb_gold_owner
------------------------------------------------------------------------------------
function mp_gb_gold_owner.dosomething1(n,l,w)
	if w[3]==gold.ownerName then
		gold.ownerid=w[4]
		closeclass("mp_gb_gold_owner")
	end
end
------------------------------------------------------------------------------------
-- mp_gb_gold_robber
------------------------------------------------------------------------------------
function mp_gb_gold_robber.dosomething1(n,l,w)
	if w[3]==gold.robberName then
		gold.robberid=w[4]
		closeclass("mp_gb_gold_robber")
	end
end
------------------------------------------------------------------------------------
-- mp_gb_gold_ti
------------------------------------------------------------------------------------
function mp_gb_gold_ti.dosomething1(n,l,w)
	if findstring(l,"看来还是走吧，这家伙身上已经没有多少油水可榨了。","你[想乞讨的对象不在这里|要向谁乞讨]+","太可惜了，你要乞讨的人已经走了") then
		alias.resetidle()
		-- 丢失富贾行踪！
		gold.id=""
		closeclass("mp_gb_gold_ti")
		if havefj>0 then alias.startworkflow() else alias.dz(set_neili) end
	end
	if findstring(l,"你丢下一[颗|块]+.+。") then
		alias.resetidle()
		gold.Name=""
		gold.id=""
		gold.have=0
	end
end
function mp_gb_gold_ti.timer()
	run("beg "..gold.id.." from "..gold.fujiaid)
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function mp_gb.update()
	local _tb={
		"看来还是走吧，这家伙身上已经没有多少油水可榨了。",
		"你(想乞讨的对象不在这里|要向谁乞讨)",
		"你丢下一(颗|块)(.+)。",
		"太可惜了，你要乞讨的人已经走了",
	}
	local  mp_gb_gold_ti_triggerlist={
	       {name="mp_gb_gold_ti_dosth1",regexp=linktri(_tb),script=function(n,l,w)    mp_gb_gold_ti.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gb_gold_ti_triggerlist) do
		addtri(v.name,v.regexp,"mp_gb_gold_ti",v.script,v.line)
	end
	AddTimer("mp_gb_gold_ti_timer", 0, 0, 1, "", timer_flag.Enabled + timer_flag.Replace, "mp_gb_gold_ti.timer")
	SetTimerOption("mp_gb_gold_ti_timer", "group", "mp_gb_gold_ti")
	closeclass("mp_gb_gold_ti")
	
	_tb={
		"(\\S+)\\s+=\\s+(\\w+)",
	}
	local  mp_gb_gold_robber_triggerlist={
	       {name="mp_gb_gold_robber_dosth1",regexp=linktri(_tb),script=function(n,l,w)    mp_gb_gold_robber.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gb_gold_robber_triggerlist) do
		addtri(v.name,v.regexp,"mp_gb_gold_robber",v.script,v.line)
	end
	closeclass("mp_gb_gold_robber")
	
	_tb={
		"(\\S+)\\s+=\\s+(\\w+)",
	}
	local  mp_gb_gold_owner_triggerlist={
	       {name="mp_gb_gold_owner_dosth1",regexp=linktri(_tb),script=function(n,l,w)    mp_gb_gold_owner.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gb_gold_owner_triggerlist) do
		addtri(v.name,v.regexp,"mp_gb_gold_owner",v.script,v.line)
	end
	closeclass("mp_gb_gold_owner")
	
	_tb={
		"(.+)\\s+=\\s+(.+),",
	}
	local  mp_gb_gold_fujia_triggerlist={
	       {name="mp_gb_gold_fujia_dosth1",regexp=linktri(_tb),script=function(n,l,w)    mp_gb_gold_fujia.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gb_gold_fujia_triggerlist) do
		addtri(v.name,v.regexp,"mp_gb_gold_fujia",v.script,v.line)
	end
	closeclass("mp_gb_gold_fujia")
	
	local _tb={
		"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\\n.+说道：怎么老有.+打探消息，烦不烦啦！\\Z",
		"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\\n.+说道：这附近没见到什么富贾。\\Z",
		"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\\n.+说道：踏遍铁鞋无觅处，得来全部费功夫。你看不是有个(.+)正往这里走来了吗？\\Z",
		"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\\n.+说道：你怀中的金银财宝都快掉出来了，还瞎打听什么！\\Z",
		"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\\n.+说道：你跟我套近乎不会是看上我了吧？\\Z",
		"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\\n.+说道：你身边不是就有一个吗，还问我？\\Z",
		"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\\n.+说道：你先瞪大眼睛看看这里是什么地界再问我吧。\\Z",
		"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\\n.+说道：刚才倒是有个(.+)从这里经过，好像是往(.+)那边去了。\\Z",
	}
	local  mp_gb_gold_m_triggerlist={
	       {name="mp_gb_gold_m_dosth1",line=2,regexp=linktri(_tb),script=function(n,l,w)    mp_gb_gold.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gb_gold_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_gb_gold",v.script,v.line)
	end
	
	local _tb={
		"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\\n(.+)。\\n.+说道：这附近没见到什么富贾。\\Z",
		"你凑到.+身边，向.+问道：不知.+可看到有富贾在附近经过？\\n一个.+朝这边走了过来。\\n.+说道：踏遍铁鞋无觅处，得来全部费功夫。你看不是有个(.+)正往这里走来了吗？\\Z",
	}
	local  mp_gb_gold_m2_triggerlist={
	       {name="mp_gb_gold_m2_dosth1",line=3,regexp=linktri(_tb),script=function(n,l,w)    mp_gb_gold.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gb_gold_m2_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_gb_gold",v.script,v.line)
	end
	
	_tb={
		"数码世界，数字地图，(\\d+)就是这里！",
		"这里没有 (.+) 这个人。",
		"有一天，你踩着七色云彩来迎娶『鲁有脚』",
		"对方正忙着呢，你等会儿在问话吧。",
		"你忙着呢，你等会儿在问话吧。",
		"但是很显然的，(.+)现在的状况没有办法给你任何答覆。",
		"你目前还没有任何为 searchgold=next 的变量设定。",
		"这里没有 (.+)。",
		"这里没有 (.+)\\s+(.+)。",
		"你目前还没有任何为 searchgold=over 的变量设定。",
		"你决定开始跟随(.+)一起行动。",
		"你目前还没有任何为 busyover=begover 的变量设定。",
		"(.+)低头想了一会，又看了看你，摇摇头，叹了口气，丢给你一(颗|块)(.+)。",
		"(.+)说道：当年我曾受过(.+)的恩惠，这(.+)算是我的一番心意，请代(为转告|我交给他吧)。",
		"你目前还没有任何为 checkgoldowner=yes 的变量设定。",
		"你目前还没有任何为 checkgoldrobber=yes 的变量设定。",
		"你要对谁做 beg1 这个动作？",
		"你说道：「.+，我求你一件事，你肯答允么？」",
		"(.+)给你一(颗|块)(.+)。",
		"你口念咒语『神马都是浮云,虾米都是尘土』，『(.+)』立马到达！",
		"浮云朵朵飘，飘到了 \\d+ 个『(.+)』中的第 \\d+ 个～～",
		"你装出可怜巴巴的样子，慢慢地向(.+)走过去，伸出双手，想要(些|杯)",
		"你装出可怜巴巴的样子，慢慢地向(.+)走过去，伸出双手，想要(颗|块)(.+)...",
		"你目前还没有任何为 busyover=giveowner 的变量设定。",
		"你目前还没有任何为 dazuo=over 的变量设定。",
		"你目前还没有任何为 checkfujiaid=yes 的变量设定。",
		"(.+)丢下一(颗|块)(.+)。",
		"(.+)对着(.+)说了声「告辞」，转身渐渐走远了。",
		"你捡起一(颗|块)(.+)。",
	}
	local  mp_gb_gold_triggerlist={
	       {name="mp_gb_gold_dosth1",regexp=linktri(_tb),script=function(n,l,w)    mp_gb_gold.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gb_gold_triggerlist) do
		addtri(v.name,v.regexp,"mp_gb_gold",v.script,v.line)
	end
	closeclass("mp_gb_gold")
	
	local _tb={
		"你向鲁有脚问道：这位.+，.+初到贵宝地，不知这里有些什麽风土人情？\\n鲁有脚对你说道：这里是土地庙，其它的在下不便多说。\\Z",
		"你从怀中取出筹措来的.+交给了鲁有脚。\\n鲁有脚说道：这.+值不少两黄金，你此行收获甚大，辛苦了，快下去歇息吧。\\Z",
		"你从怀中取出.+交给了鲁有脚。\\n鲁有脚说道：这.+好像不是你所有吧？想蒙混过关，当我是大傻蛋？\\Z",
		"你从怀中取出.+交给了鲁有脚。\\n鲁有脚冷冷的看了你一眼，转头将.+交给一名小叫化，吩咐他放入地底密室。\\Z",
		"你向鲁有脚问道：这位.+，.+初到贵宝地，不知这里有些什麽风土人情？\\n但是很显然的，鲁有脚现在的状况没有办法给你任何答覆。\\Z",
		"你向鲁有脚打听有关「job」的消息。\\n鲁有脚说道：你还没完成我交待的工作，怎麽又来问我？\\Z",
		"你向鲁有脚打听有关「job」的消息。\\n鲁有脚说道：我现在没要事让你去干，待会儿你再来吧。\\Z",
		"你向鲁有脚打听有关「gold」的消息。\\n鲁有脚说道：我不是已经吩咐你去筹措黄金了吗？\\Z",
		"你向鲁有脚打听有关「gold」的消息。\\n鲁有脚说道：目前没有什么任务，.+请先稍事歇息罢。\\Z",
		"你向鲁有脚打听有关「gold」的消息。\\n鲁有脚说道：你先把.+练好了再说吧。\\Z",
		"你向鲁有脚打听有关「gold」的消息。\\n鲁有脚说道：你还没完成我交待的工作，怎麽又来问我\\Z",
		"你向鲁有脚打听有关「gold」的消息。\\n鲁有脚说道：最近好像没什么富贾的消息。\\Z",
		"你向鲁有脚打听有关「gold」的消息。\\n但是很显然的，鲁有脚现在的状况没有办法给你任何答覆。\\Z",
	}
	local  mp_gb_pre_m_triggerlist={
	       {name="mp_gb_pre_m_dosth1",line=2,regexp=linktri(_tb),script=function(n,l,w)    mp_gb_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gb_pre_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_gb_pre",v.script,v.line)
	end
	
	local _tb={
		"你向鲁有脚打听有关「gold」的消息。\\n鲁有脚在你的耳边悄声说道：.+\\n鲁有脚说道：你去(.+)附近打听看看，看看是否有富贾经过，向其讨一些黄金来。\\Z",
	}
	local  mp_gb_pre_m3_triggerlist={
	       {name="mp_gb_pre_m3_dosth1",line=3,regexp=linktri(_tb),script=function(n,l,w)    mp_gb_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gb_pre_m3_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_gb_pre",v.script,v.line)
	end
	
	local _tb={
		"你向鲁有脚打听有关「job」的消息。\\n鲁有脚点了点头。\\n鲁有脚说道：你来得正巧，我有件事要你去办！\\n鲁有脚伸手入怀取出一封信笺。\\n鲁有脚对你说道：你把这封密函交给(.+)，务必亲自送到！\\Z",
	}
	local  mp_gb_pre_m2_triggerlist={
	       {name="mp_gb_pre_m2_dosth1",line=5,regexp=linktri(_tb),script=function(n,l,w)    mp_gb_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gb_pre_m2_triggerlist) do
		addtri_multiline(v.name,v.regexp,"mp_gb_pre",v.script,v.line)
	end
	
	_tb={
		"你目前还没有任何为 sx=over 的变量设定。",
		"你目前还没有任何为 checkmihan=yes 的变量设定。",
		"你要看什么？",
		"密函上面写着：(.+)亲启。",
		"你目前还没有任何为 dealwithitems=over 的变量设定。",
		"数码世界，数字地图，(\\d+)就是这里！",
		"你目前还没有任何为 checkhp=addneili 的变量设定。",
		"你目前还没有任何为 dazuo=over 的变量设定。",
		"你目前还没有任何为 checkexpover=mp 的变量设定。",
		"你目前还没有任何为 lian=over 的变量设定。",
		"这里没有 lu youjiao 这个人。",
		"你目前还没有任何为 lian=full 的变量设定。",
		"对方正忙着呢，你等会儿在问话吧。",
		"你口念咒语『神马都是浮云,虾米都是尘土』，『武庙』立马到达！",
	}
	local  mp_gb_pre_triggerlist={
	       {name="mp_gb_pre_dosth1",regexp=linktri(_tb),script=function(n,l,w)    mp_gb_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gb_pre_triggerlist) do
		addtri(v.name,v.regexp,"mp_gb_pre",v.script,v.line)
	end
	closeclass("mp_gb_pre")
	
	local noecho_trilist={
			"你正忙着呢",
			"你已经在向人家乞讨了！",
			}
	local _noechotri=linktri(noecho_trilist)

	addtri("mp_gb_watch_gag_dosth1",_noechotri,"mp_gb_watch","")
	SetTriggerOption("mp_gb_watch_gag_dosth1","omit_from_output",1)

	_tb={
		"一边打架一边要饭？你真是活腻了！",
		".+鬼鬼祟祟的对你道：鲁长老让你找的是这个吧，快快收好，别被巫师看到了。",
		"你伸手往怀中一摸，惊觉密函不见了！",
	}
	local  mp_gb_watch_triggerlist={
	       {name="mp_gb_watch_dosth1",regexp=linktri(_tb),script=function(n,l,w)    mp_gb_watch.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_gb_watch_triggerlist) do
		addtri(v.name,v.regexp,"mp_gb_watch",v.script,v.line)
	end
	closeclass("mp_gb_watch")
end

mp_gb.update()