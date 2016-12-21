----------------------------------------------------------------------------------
-- 基础配置部份 开始
----------------------------------------------------------------------------------
setting="mj"							-- 使用哪个门派的配置文件，请参照下面的相关函数，需要调整，直接改下面对应的门派即可
										-- 如果使用寒冰绵掌，要使用类似 gbhbmz 或者 dlhbmz 这样的配置
dummy={
	name="米虫",						-- 疗伤大米中文名
	id="michen",						-- 疗伤大米英文ID
	laopo="",							-- 要学习老婆英文ID设置这里,老婆放泉州武馆睡房
	--[[				大米使用说明：
	武庙放DL疗伤大米，id来ask about liaoshang后去泉州武馆睡房等待id来疗伤
	在id到达睡房后，请在大米rbt设置快步走过来就进行疗伤的触发
	如果你的大米不会疗伤，请在你id来ask liaoshang是触发whisper 你的id 小样！我不是这么随便的人～～
	这时rbt会处理到当铺买首乌精吃
	多余精要会自动到武庙给大米，只保留本id需要的精要
	]]
}
workflow={
	fj=1,								-- 是否做FJ任务(1=是,0=否)
	mp=1,								-- 是否做MP工作(1=是,0=否)
	ftb=0,								-- 是否做FTB任务(1=是,0=否)
	xf=0,								-- 是否开启XF模块(1=是,0=否)
	yb=0,								-- 是否开启YB模块(1=是,0=否)
	cm=0,								-- 是否开启冲脉模块(1=是,0=否)
	qzwd=0,								-- 是否修炼QZWD(1=是,0=否)
	nowjob="mp",						-- 这个不用改
}
gxd={
	type=2,								-- 贡献度模式(1=不放弃,2=保持固定值,3=保持总门派贡献度的百分比)
	value=100,							-- 保持固定多少点贡献度，当type=2时生效
	percent=10,							-- 保持总门派贡献度的百分之多少，当type=3时生效
}

set_GbSecretWay=1						-- 是否钻狗洞(1=是,0=否)
setting_resetidle=1						-- 是否开启防发呆(1=是,0=否)
set_neili_job=180						-- 内力达到最大内力的160%时开始工作
set_neili_global=180					-- 内力达到最大内力的190%时开始工作
set_lifesave=1							-- 是否使用lifesave(1=是,0=否)

usepot="xue"							-- 潜能的用途：none=不消耗,xue=学习,lingwu=领悟,jingyao=精要
wantxuelit=1							-- 是否学习读书写字(1=优先学习,2=学习,3=不学)
xuefirst=1								-- 学习是否优先经验(1=是,0=否)
lingwuat="menpai"						-- 在哪里领悟，有两个选择：menpai=在门派地点领悟，shaolin=去少林领悟

do_gm_job3=1							-- 古墓派特有，是否做JOB3(要500K以上)(1=是,0=否)
xx_xiulian=0							-- 星宿派特有，是否要抓虫子XIULIAN(会AUTOKILL，强烈建议不要！)
gold={									-- 丐帮特有
	setnum=5,							-- 两次FJ之间做几次BEG任务
}
sx={									-- 丐帮特有
	open=0,								-- 是否做送信任务
}
me.falun=5								-- 雪山派特有，拿几个法轮？
lzjob={									-- 雪山派特有
	open=1,								-- 是否要做灵智任务(1=是,0=否)
}
per={									-- 峨眉派特有
	roomno=609,						-- 劝架地点选择：1061=白鹤泉,609=小路,1392=六盘山,936=黄土路,1369=土门子,1328=天山脚下
}

do_dl_job=0								-- 峨嵋少林武当全真华山古墓去大理打工(1=是,0=否) 30k<exp<3m才有效,会优先自己的mp任务
dl={									-- 大理段家特有
	jobnpc="范骅",						-- 做谁的任务？华赫艮|巴天石|范骅 三选一
	useailao=0,							-- QK命中之后，是否要使用ailao(1=是,0=否)
	dohuajiangwork=1,					-- 是否做花匠任务(1=是,0=否)
}
arrestdrutime=150						-- 离fj还有多少秒停止arrest

mj={									-- 明教特有,任务选择(1=是,0=否)
	master="韦一笑",					-- 请教的师傅 殷天正|杨逍
	ask=0,								-- ask杨逍(1=是,0=否)
	yudi=2,								-- 御敌(0=否,1=只杀山下,2=全杀)
	yuditp=20,							-- 大于这个人数就跑路
	wxq=0,								-- 五行旗
	tyjob=0,							-- 天鹰教任务 杀人|送信
}
-- setting="mj" 相关设置
function set_mj()
	fjweapon=""								-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="basic"						-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali="max"							-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform kuangfeng"					-- FJ时使用的pfm，多个pfm用|分隔
	fjyun="yun yixing"						-- FJ时运用的心法
	fjjf=""									-- FJ jifa 技能
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		th="0|0|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="0|0|0|0|0|0|0|0",
		hs="1|1|0|1|0|0|0|0",
		qz="0|0|0|0|0|0|0|0",
		sl="0|0|0|0|0|0|0|0",
		wd="0|0|0|0|0|0|0|0",
		dl="0|1|0|0|0|0|0|0",
		em="0|0|0|0|0|0|0|0",
	}

	ftbweapon=""							-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="basic"						-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali="max"							-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform kuangfeng"					-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yun yixing"					-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|0|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon=""								-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="basic"						-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali=0								-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="perform kuangfeng"								-- MP时使用的pfm，多个pfm用|分隔
	mpyun="yun yixing"							-- MP时运用的心法
	mpjf=""										-- yudi jifa 技能
	skills_lingwu="strike|dodge|parry|cuff"			-- 领悟清单，用|分隔
	skills_xue="force|strike|dodge|parry"		-- 学习清单，用|分隔
end
-- setting="gb" 纯丐帮相关设置
function set_gb()
	fjweapon=""								-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="basic"						-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali="max"							-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform sanhui"					-- FJ时使用的pfm，多个pfm用|分隔
	fjyun="yun powerup"						-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|0|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="0|0|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|0|0|0|0|0|0|0",
		wd="0|0|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="1|0|0|0|0|0|0|0",
		em="1|0|0|0|0|0|0|0",
	}

	ftbweapon=""							-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="basic"						-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali="max"							-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform sanhui"					-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yun powerup"					-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|0|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon=""								-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="basic"						-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali="max"							-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="perform sanhui"					-- MP时使用的pfm，多个pfm用|分隔
	mpyun="yun powerup"						-- MP时运用的心法
	skills_lingwu="strike|dodge|parry|cuff|stick|hand"								-- 领悟清单，用|分隔
	skills_xue="force|huntian-qigong|stick|strike|dodge|parry|begging|checking"		-- 学习清单，用|分隔
end
-- setting="gbhbmz" 丐帮HBMZ相关设置
function set_gbhbmz()
	fjweapon=""								-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="basic"						-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali="max"							-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform mian"					-- FJ时使用的pfm，多个pfm用|分隔
	fjyun="yun yin"							-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|0|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="0|0|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|0|0|0|0|0|0|0",
		wd="0|0|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="1|0|0|0|0|0|0|0",
		em="1|0|0|0|0|0|0|0",
	}

	ftbweapon=""							-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="basic"						-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali="max"							-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform mian"					-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yun yin"						-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|0|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon=""								-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="basic"						-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali="max"							-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="perform mian"					-- MP时使用的pfm，多个pfm用|分隔
	mpyun="yun yin"							-- MP时运用的心法
	skills_lingwu="strike|parry|dodge"								-- 领悟清单，用|分隔
	skills_xue="force|strike|dodge"		-- 学习清单，用|分隔
end
-- setting="dl" 纯大理相关设置
function set_dl()
	fjweapon=""								-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="basic"						-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali="max"							-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform qiankun"				-- FJ时使用的pfm，多个pfm用|分隔
	fjyun="yun kurong"						-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="0|0|0|0|0|0|0|0",
		sl="0|1|0|0|0|0|0|0",
		th="0|0|0|0|0|0|0|0",
		wd="0|0|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="0|0|0|0|0|0|0|0",
		em="1|0|0|0|0|0|0|0",
	}

	ftbweapon=""							-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="basic"						-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali="max"							-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform qiankun"				-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yun kurong"						-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|0|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon=""								-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="basic"						-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali="max"							-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="perform qiankun"					-- MP时使用的pfm，多个pfm用|分隔
	mpyun="yun kurong"						-- MP时运用的心法
	skills_lingwu="finger|dodge|parry|sword|strike|cuff|staff|force"								-- 领悟清单，用|分隔
	skills_xue="force|kurong-changong|finger|parry|dodge|yiyang-zhi|duanshi-shenfa|sword|duanjia-jian|cuff|strike|staff|buddhism"		-- 学习清单，用|分隔
end
-- setting="dlhbmz" 大理HBMZ相关设置
function set_dlhbmz()
	fjweapon=""								-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="basic"						-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali="max"							-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform piaomiao"				-- FJ时使用的pfm，多个pfm用|分隔
	fjyun="yun kurong"						-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="0|0|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|0|1|0|0|0|0|0",
		wd="0|0|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="1|0|0|0|1|0|0|0",
		em="1|0|0|0|0|0|0|0",
	}

	ftbweapon=""							-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="basic"						-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali="max"							-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform piaomiao"				-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yun kurong"						-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|0|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon=""								-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="basic"						-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali="max"							-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="perform qiankun"					-- MP时使用的pfm，多个pfm用|分隔
	mpyun="yun kurong"						-- MP时运用的心法
	skills_lingwu="finger|dodge|parry|sword|strike|cuff|staff|force"								-- 领悟清单，用|分隔
	skills_xue="force|kurong-changong|finger|parry|dodge|yiyang-zhi|duanshi-shenfa|sword|duanjia-jian|cuff|strike|staff|buddhism"		-- 学习清单，用|分隔
end

-- setting="hs" 纯华山相关设置
function set_hs()
	fjweapon="jian"								-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="max"						-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali="0"							-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform leidong|perform sanxian"				-- FJ时使用的pfm，多个pfm用|分隔
	fjyun=""						-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="0|1|0|0|0|0|0|1",
		sl="1|1|0|0|0|0|0|0",
		th="0|0|0|0|0|0|0|0",
		wd="1|0|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="1|0|0|0|0|0|0|0",
		em="0|1|0|0|0|0|0|0",
	}

	ftbweapon="jian"							-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="200"						-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali="0"							-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform leidong|perform sanxian"				-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun=""						-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon="jian"								-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="max"						-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali="0"							-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="perform leidong|perform sanxian"					-- MP时使用的pfm，多个pfm用|分隔
	mpyun=""						-- MP时运用的心法
	skills_lingwu="sword|cuff|parry|dodge|strike"								-- 领悟清单，用|分隔
	skills_xue="force|zixia-gong|dodge|cuff|strike|parry"		-- 学习清单，用|分隔
end

-- setting="qz" 纯全真教相关设置
function set_qz()
	fjweapon=""								-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="basic"						-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali=0								-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform kong|perform ming"		-- FJ时使用的pfm，多个pfm用|分隔
	fjyun=""								-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="0|1|0|0|0|0|0|1",
		sl="1|1|0|0|0|0|0|0",
		th="0|0|0|0|0|0|0|0",
		wd="1|0|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="1|0|0|0|0|0|0|0",
		em="0|1|0|0|0|0|0|0",
	}

	ftbweapon=""							-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="basic"						-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali=0								-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform kong|perform ming"		-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun=""								-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|0|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon=""								-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="basic"						-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali=0								-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="perform sanqing"					-- MP时使用的pfm，多个pfm用|分隔
	mpyun=""								-- MP时运用的心法
	skills_lingwu="cuff|sword|parry|dodge|strike"								-- 领悟清单，用|分隔
	skills_xue="force|xiantian-gong|sword|strike|parry|dodge|cuff|beidou-zhenfa"		-- 学习清单，用|分隔
end

-- setting="wd" 纯武当相关设置
function set_wd()
	fjweapon="jian"							-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="max"							-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali=0								-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform chan"					-- FJ时使用的pfm，多个pfm用|分隔
	fjyun="yun taiji"						-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="0|1|0|0|0|0|0|1",
		sl="1|1|0|0|0|0|0|0",
		th="1|0|0|0|0|0|0|0",
		wd="1|0|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="1|0|0|0|0|0|0|0",
		em="0|1|0|0|0|0|0|0",
	}

	ftbweapon="jian"						-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="max"							-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali=0								-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform chan"					-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yun taiji"						-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|0|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon="jian"							-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="max"							-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali=0								-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="perform chan"					-- MP时使用的pfm，多个pfm用|分隔
	mpyun="yun taiji"						-- MP时运用的心法
	skills_lingwu="sword|parry|dodge|cuff|strike"								-- 领悟清单，用|分隔
	skills_xue="taoism|taiji-shengong"		-- 学习清单，用|分隔
end
-- setting="wdhbmz" 武当HBMZ相关设置
function set_wdhbmz()
	fjweapon=""								-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="max"							-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali="max"							-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform mian"					-- FJ时使用的pfm，多个pfm用|分隔
	fjyun="yun yin"							-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="0|1|0|0|0|0|0|1",
		sl="1|1|0|0|0|0|0|0",
		th="1|0|0|0|0|0|0|0",
		wd="1|0|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="1|0|0|0|0|0|0|0",
		em="0|1|0|0|0|0|0|0",
	}

	ftbweapon=""							-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="max"							-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali="max"							-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform mian"					-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yun yin"						-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|0|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon=""								-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="max"							-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali="max"							-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="perform mian"					-- MP时使用的pfm，多个pfm用|分隔
	mpyun="yun yin"							-- MP时运用的心法
	skills_lingwu="parry|dodge|strike"								-- 领悟清单，用|分隔
	skills_xue="force|taoism|strike|parry|dodge|sword|cuff"		-- 学习清单，用|分隔
end
-- setting="sl" 纯少林相关设置
function set_sl()
	fjweapon="dao"							-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="max"							-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali=0								-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform xianfo"					-- FJ时使用的pfm，多个pfm用|分隔
	fjyun="yun jinzhongzhao"				-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|1|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="0|1|0|0|0|0|0|1",
		sl="1|1|0|0|0|0|0|0",
		th="1|0|0|0|0|0|0|0",
		wd="1|0|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="1|0|0|1|0|0|1|0",
		gb="1|0|0|0|0|0|0|0",
		em="0|1|0|0|0|0|0|0",
	}

	ftbweapon="dao"							-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin=200							-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali=0								-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform xianfo"					-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yun jinzhongzhao"				-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon="dao"							-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin=200							-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali=0								-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="perform xianfo"					-- MP时使用的pfm，多个pfm用|分隔
	mpyun="yun jinzhongzhao"				-- MP时运用的心法
	skills_lingwu="force|blade|dodge|finger|parry|whip|strike|cuff|claw|hand|sword|staff|club"								-- 领悟清单，用|分隔
	skills_xue="force|hunyuan-yiqi|strike|whip|parry|cuff|hand|claw|sword|staff|club"		-- 学习清单，用|分隔
end
-- setting="slhbmz" 少林HBMZ相关设置
function set_slhbmz()
	fjweapon=""								-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="max"							-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali="max"							-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform mian"					-- FJ时使用的pfm，多个pfm用|分隔
	fjyun="yun yin"							-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="0|1|0|0|0|0|0|1",
		sl="1|1|0|0|0|0|0|0",
		th="1|0|0|0|0|0|0|0",
		wd="1|0|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="1|0|0|0|0|0|0|0",
		em="0|1|0|0|0|0|0|0",
	}

	ftbweapon=""							-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="max"							-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali="max"							-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform mian"					-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yun yin"						-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|0|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon=""								-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="max"							-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali="max"							-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="perform mian"					-- MP时使用的pfm，多个pfm用|分隔
	mpyun="yun yin"							-- MP时运用的心法
	skills_lingwu="blade|strike|sword|parry|dodge|blade|finger"								-- 领悟清单，用|分隔
	skills_xue="hunyuan-yiqi|force"		-- 学习清单，用|分隔
end
-- setting="xs" 纯XS相关设置
function set_xs()
	fjweapon="lun"							-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin=1								-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali="max"							-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform dazhuan|perform fen"		-- FJ时使用的pfm，多个pfm用|分隔
	fjyun="yun longxiang"					-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="0|0|0|0|0|0|0|0",
		sl="0|0|0|0|0|0|0|0",
		th="0|0|0|0|0|0|0|0",
		wd="0|0|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="0|0|0|0|0|0|0|0",
		em="0|0|0|0|0|0|0|0",
	}

	ftbweapon="lun"							-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin=1								-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali="max"							-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform dazhuan|perform fen"	-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yun longxiang"					-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon="lun"								-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin=1								-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali="max"							-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="perform dazhuan|perform fen"		-- MP时使用的pfm，多个pfm用|分隔
	mpyun="yun longxiang"					-- MP时运用的心法
	skills_lingwu="hammer|strike|dodge|parry"								-- 领悟清单，用|分隔
	skills_xue="longxiang-banruo|force|hammer|strike|dodge"		-- 学习清单，用|分隔
end
-- setting="xshbmz" XSHBMZ相关设置
function set_xshbmz()
	fjweapon=""								-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="max"							-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali="max"							-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform mian"					-- FJ时使用的pfm，多个pfm用|分隔
	fjyun="yun yin"							-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="0|1|0|0|0|0|0|1",
		sl="1|1|0|0|0|0|0|0",
		th="1|0|0|0|0|0|0|0",
		wd="1|0|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="1|0|0|0|0|0|0|0",
		em="0|1|0|0|0|0|0|0",
	}

	ftbweapon=""							-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="max"							-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali="max"							-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform mian"					-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yun yin"						-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|0|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon=""								-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="max"							-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali="max"							-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="perform mian"					-- MP时使用的pfm，多个pfm用|分隔
	mpyun="yun yin"							-- MP时运用的心法
	skills_lingwu="blade|strike|sword|parry|dodge|blade|finger"								-- 领悟清单，用|分隔
	skills_xue="hunyuan-yiqi|force"		-- 学习清单，用|分隔
end
-- setting="em" 纯EM相关设置
function set_em()
	fjweapon="jian"							-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="max"							-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali=0								-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform miejue"					-- FJ时使用的pfm，多个pfm用|分隔
	fjyun="yun daxiao"						-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="0|0|0|0|0|0|0|0",
		sl="0|0|0|0|0|0|0|0",
		th="0|0|0|0|0|0|0|0",
		wd="0|0|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="0|0|0|0|0|0|0|0",
		em="0|0|0|0|0|0|0|0",
	}

	ftbweapon="jian"						-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="max"							-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali=0								-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform miejue"					-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yun daxiao"						-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon="jian"							-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="basic"						-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali=0								-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm=""								-- MP时使用的pfm，多个pfm用|分隔
	mpyun=""								-- MP时运用的心法
	skills_lingwu="sword|cuff|parry|dodge"								-- 领悟清单，用|分隔
	skills_xue="linji-zhuang|persuading|mahayana|force|sword|parry|dodge"		-- 学习清单，用|分隔
end
-- setting="gm" 纯GM相关设置
function set_gm()
	fjweapon="jian"							-- job3时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="max"							-- job3时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali=0								-- job3时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform hebi;perform suxin"		-- job3时使用的pfm，多个pfm用|分隔，GM是个特例，如果先hebi再suxin的话，用;分隔
	fjyun="yun suxin"						-- job3时运用的心法
	fjselectnpc={							-- job3时敌对NPC是否要击杀的选择
		bt="1|1|1|1|1|1|0|1",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|1|1|1|1|1|1|1",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|1|1|1|1|1|1",
		qz="1|1|1|1|1|1|1|1",
		sl="1|1|1|1|1|1|1|1",
		th="1|1|1|1|1|1|1|1",
		wd="1|1|1|1|1|1|1|1",
		xx="0|1|1|1|1|1|1|1",
		xs="1|1|1|1|1|1|1|1",
		gb="1|1|1|1|1|1|1|1",
		em="1|1|1|1|1|1|1|1",
		mj="1|1|1|1|1|1|1|1",
	}

	ftbweapon="jian"						-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="max"							-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali=0								-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform hebi;perform suxin"		-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yun suxin"						-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon="jian"							-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="basic"						-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali=0								-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm=""								-- MP时使用的pfm，多个pfm用|分隔
	mpyun=""								-- MP时运用的心法
	skills_lingwu="sword|parry|dodge|cuff|whip"								-- 领悟清单，用|分隔
	skills_xue="linji-zhuang|persuading|mahayana|force|sword|parry|dodge"		-- 学习清单，用|分隔
end
-- setting="bt" 纯BT相关设置
function set_bt()
	fjweapon="staff"						-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="max"							-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali=0								-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform heji"					-- FJ时使用的pfm，多个pfm用|分隔
	fjyun="yunbt"							-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|0|0|1|0|0|0|0",
		qz="0|0|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|0|0|0|0|0|0|0",
		wd="1|0|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="1|0|0|0|0|0|1|0",
		em="0|0|0|0|0|0|0|0",
	}

	ftbweapon="staff"						-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="basic"						-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali=0								-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform heji"					-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yunbt"							-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon="staff"							-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="basic"						-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali=0								-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="perform heji"						-- MP时使用的pfm，多个pfm用|分隔
	mpyun="yunbt"								-- MP时运用的心法
	skills_lingwu="staff|dodge|parry|strike|cuff"								-- 领悟清单，用|分隔
	skills_xue="force|hamagong|staff|dodge|strike|parry|cuff"		-- 学习清单，用|分隔
end
-- setting="xx" 纯XX相关设置
function set_xx()
	fjweapon=""								-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="basic"						-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali=0								-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="xxpfm"							-- FJ时使用的pfm，多个pfm用|分隔
	fjyun="yun hua"							-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="0|0|0|0|0|0|0|0",
		sl="0|1|0|0|0|0|0|0",
		th="0|0|0|0|0|0|0|0",
		wd="1|0|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="0|0|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	ftbweapon=""							-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="basic"						-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali=0								-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="xxpfm"							-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yun hua"						-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon=""								-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="basic"						-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali=0								-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="xxpfm"							-- MP时使用的pfm，多个pfm用|分隔
	mpyun="yun hua"							-- MP时运用的心法
	skills_lingwu="dodge|parry|strike|claw|staff"								-- 领悟清单，用|分隔
	skills_xue="huagong-dafa|force|poison|claw|dodge|strike|staff"		-- 学习清单，用|分隔
end
-- setting="th" 纯TH相关设置
function set_th()
	fjweapon=""								-- FJ时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	fjjiajin="basic"						-- FJ时的jiajin值，如果用数值的话用这样：fjjiajin=10
	fjjiali="max"							-- FJ时的jiali值，如果用数值的话用这样：fjjiali=10
	fjpfm="perform kuangfeng"				-- FJ时使用的pfm，多个pfm用|分隔
	fjyun="yun yixing"							-- FJ时运用的心法
	fjselectnpc={							-- FJ时敌对NPC是否要击杀的选择
		bt="0|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="0|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|0|0|1|0|0|0|0",
		qz="0|0|0|0|0|0|0|0",
		sl="1|0|0|0|0|0|0|1",
		th="0|0|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|0|0|0|0|0|1|0",
		xs="0|0|0|1|0|0|1|0",
		gb="0|0|0|0|1|0|0|0",
		em="1|0|0|0|0|0|0|0",
	}

	ftbweapon=""							-- FTB时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	ftbjiajin="basic"						-- FTB时的jiajin值，如果用数值的话用这样： ftbjiajin=10
	ftbjiali="max"							-- FTB时的jiali值，如果用数值的话用这样： ftbjiali=10
	ftbpfm="perform kuangfeng"				-- FTB时使用的pfm，多个pfm用|分隔
	ftbyun="yun yixing"						-- FTB时运用的心法
	ftbselectnpc={							-- FTB时敌对NPC是否要击杀的选择
		bt="1|0|0|0|0|0|0|0",				-- "bt"表示门派，后面分别为装备不同武器的选择,1=杀,2=不杀。
		dl="1|1|0|0|0|0|0|0",				-- 后面的数字分别代表 空手|剑|箫|刀|棒|法轮|杖|鞭
		hs="1|1|0|1|0|0|0|0",
		qz="1|1|0|0|0|0|0|0",
		sl="1|1|0|0|0|0|0|0",
		th="1|1|0|0|0|0|0|0",
		wd="1|1|0|0|0|0|0|0",
		xx="0|1|0|0|0|0|1|0",
		xs="1|1|0|1|0|0|1|0",
		gb="1|1|0|0|0|0|0|0",
		em="1|1|0|0|0|0|0|0",
	}

	mpweapon=""								-- MP时使用的武器，空=空手，其它还有jian,dao,staff,bang等等
	mpjiajin="basic"						-- MP时的jiajin值，如果用数值的话用这样： mpjiajin=10
	mpjiali="max"							-- MP时的jiali值，如果用数值的话用这样： mpjiali=10
	mppfm="perform kuangfeng"				-- MP时使用的pfm，多个pfm用|分隔
	mpyun="yun yixing"						-- MP时运用的心法
	skills_lingwu="strike|parry|dodge|kick"								-- 领悟清单，用|分隔
	skills_xue="qimen-dunjia|force|bitao-xuangong|strike|dodge|parry|qimen-dunjia|music"		-- 学习清单，用|分隔
end
