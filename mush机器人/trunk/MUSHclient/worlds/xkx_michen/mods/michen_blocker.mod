---------------------------------------------------------------------------
-- File name   : michen_blocker.lua
-- Description : 地图模块中，特殊alias的处理部份
--
-- Author: Michen (xmichen@gmail.com)
-- Version:	2014.05
---------------------------------------------------------------------------
print("Loading Michen blocker mod OK!")

alias={}

alias.blocker={
	-- explimit 表示经验大于这个值才会杀这个NPC，不然就直接行走失败了
	-- needpfm 表示经验小于这个值的时候，会用PFM杀NPC
	["狮吼子"]={id="shihou zi",								explimit=100000,			needpfm=3000000,},
	["邱山风"]={id="qiu shanfeng",						explimit=100000,			needpfm=500000,},
	["灵虚道长"]={id="zhike daozhang",				explimit=100000,			needpfm=500000,},
	["凌虚道长"]={id="zhixiang daozhang",			explimit=100000,			needpfm=500000,},
	["张松溪"]={id="zhang songxi",						explimit=700000,			needpfm=6400000,},
	["静心师太"]={id="jing xin",								explimit=100000,			needpfm=1000000,},
	["葛伦布"]={id="ge lunbu",								explimit=50000,			needpfm=100000,},
	["萨木活佛"]={id="samu huofo",						explimit=100000,			needpfm=250000,},
	["戒律僧"]={id="jielv seng",								explimit=500000,			needpfm=2000000,},
	["说不得"]={id="shuo bude",							explimit=1000000,		needpfm=6400000,},
	["张志光"]={id="zhang zhiguang",					explimit=50000,			needpfm=100000,},
	["施戴子"]={id="shi daizi",								explimit=50000,			needpfm=100000,},
	["劳德诺"]={id="lao denuo",							explimit=50000,			needpfm=200000,},
	["岳灵姗"]={id="yue lingshan",						explimit=50000,			needpfm=100000,},
	["陆大有"]={id="lu dayou",								explimit=50000,			needpfm=100000,},
	["宁中则"]={id="ning zhongze",						explimit=1000000,		needpfm=6400000,},
	["梁发"]={id="liang fa",									explimit=50000,			needpfm=100000,},
	["高根明"]={id="gao genming",						explimit=50000,			needpfm=100000,},
	["婢女"]={id="binu",										explimit=10000,			needpfm=10000,},
	["江百胜"]={id="jiang",									explimit=50000,			needpfm=200000,},
	["司徒横"]={id="situ heng",								explimit=50000,			needpfm=200000,},
	["帮众"]={id="bangzhong",								explimit=10000,			needpfm=200000,},
	["简长老"]={id="jian zhanglao",						explimit=100000,			needpfm=500000,},
	["天鹰教守卫"]={id="shou wei",						explimit=100000,			needpfm=500000,},
	["都大锦"]={id="du dajin",								explimit=50000,			needpfm=500000,},
	["胡老爷"]={id="hu laoye",								explimit=10000,			needpfm=100000,},
	["采花子"]={id="caihua zi",								explimit=50000,			needpfm=200000,},
	["家丁"]={id="jia ding",									explimit=50000,			needpfm=100000,},
	["虚??"]={id="xu",											explimit=10000,			needpfm=10000,},
	["一品堂武士"]={id="wu shi",							explimit=400000,			needpfm=2000000,},
	["校尉"]={id="xiao wei",									explimit=400000,			needpfm=2000000,},
	["皇宫卫士"]={id="wei shi",								explimit=400000,			needpfm=2000000,},
	["蒙古军官"]={id="menggu junguan",				explimit=400000,			needpfm=2000000,},
	["清观比丘"]={id="biqiu",									explimit=10000,			needpfm=10000,},
	["清乐比丘"]={id="biqiu",									explimit=10000,			needpfm=10000,},
	["日月神教卫士"]={id="rysj weishi",					explimit=400000,			needpfm=2000000,},
	["谭处端"]={id="tan chuduan",						explimit=400000,			needpfm=2000000,},
	
	["官兵"]={id="bing",										explimit=10000,			needpfm=10000,					throw=1,},
	["武将"]={id="jiang",										explimit=50000,			needpfm=50000,					throw=1,},
	["傅思归"]={id="fu",											explimit=400000,			needpfm=2000000,				throw=1,},
	["凌退思"]={id="ling",										explimit=40000,			needpfm=100000,				throw=1,},
	["衙役"]={id="ya yi",										explimit=10000,			needpfm=10000,					throw=1,},
	["守城官兵"]={id="guanbing",							explimit=400000,			needpfm=2000000,				throw=1,},
}

blocker_name=nil
blocker_id=nil
blocker_fx=nil
alias.alias_table={
	{
		name="gumuenter",
		alias=function() alias.gumuenter() end,
	},{
		name="enterguan",
		alias=function() alias.spcmd("enter guan") end,
	},{
		name="turnleft",
		alias=function() alias.spcmd("turn left") end,
	},{
		name="opendoordown",
		alias=function() alias.opendoor("down") end,
	},{
		name="opendooreast",
		alias=function() alias.opendoor("east") end,
	},{
		name="opendoorne",
		alias=function() alias.opendoor("ne") end,
	},{
		name="opendoornorth",
		alias=function() alias.opendoor("north") end,
	},{
		name="opendoornw",
		alias=function() alias.opendoor("nw") end,
	},{
		name="opendoorse",
		alias=function() alias.opendoor("se") end,
	},{
		name="opendoorsouth",
		alias=function() alias.opendoor("south") end,
	},{
		name="opendoorsw",
		alias=function() alias.opendoor("sw") end,
	},{
		name="opendoorup",
		alias=function() alias.opendoor("up") end,
	},{
		name="opendoorwest",
		alias=function() alias.opendoor("west") end,
	},{
		name="opengatesouth",
		alias=function() alias.opendoor("south","gate") end,
	},{
		name="gbmdcenter",
		alias=function() alias.gbmdcenter() end,
	},{
		name="gbmdemcp",
		alias=function() alias.movelid() end,
	},{
		name="gbmdxssl",
		alias=function() alias.jumpkeng() end,
	},{
		name="gbmddgc",
		alias=function() alias.entergudui() end,
	},{
		name="gbmdsc",
		alias=function() alias.pushshibei() end,
	},{
		name="gbmdslcf",
		alias=function() alias.enterdong() end,
	},{
		name="gbmdqzhtdm",
		alias=function() alias.enterdong() end,
	},{
		name="gbmdtdm",
		alias=function() alias.enterdong() end,
	},{
		name="enterdong",
		alias=function() alias.enterdong() end,
	},{
		name="gbmdtfw",
		alias=function() alias.enterdong() end,
	},{
		name="gbqzl-gbtdm",
		alias=function() alias.gb_qzl() end,
	},{
		name="tsysd-xxgg1",												-- 星宿干沟处理
		alias=function() alias.tsysd_xxgg1() end,
	},{
		name="xxgg1-xxgg2",											-- 星宿干沟处理
		alias=function() alias.xxgg1_xxgg2() end,
	},{
		name="xxgg1-tsysd",												-- 星宿干沟处理
		alias=function() alias.xxgg1_tsysd() end,
	},{
		name="xxgg2-xxgg1",											-- 星宿干沟处理
		alias=function() alias.xxgg2_xxgg1() end,
	},{
		name="yztd1-yztd2",												-- 扬州田地处理
		alias=function() alias.yztd1_yztd2() end,
	},{
		name="yztd2-yztd3",												-- 扬州田地处理
		alias=function() alias.yztd2_yztd3() end,
	},{
		name="yztd3-yztd2",												-- 扬州田地处理
		alias=function() alias.yztd3_yztd2() end,
	},{
		name="yztd2-yztd1",												-- 扬州田地处理
		alias=function() alias.yztd2_yztd1() end,
	},{
		name="xxysd-xxh",													-- 星宿银山道到星宿海，处理狮吼子
		alias=function() alias.check_blocker("nd","狮吼子") end,
	},{
		name="xxysd-xxxw",													-- 星宿银山道到星宿海，处理狮吼子
		alias=function() alias.check_blocker("w","狮吼子") end,
	},{
		name="clbdm-clbdt",												-- 长乐帮大门到长乐帮大厅，处理虎猛堂香主 邱山风
		alias=function() alias.check_blocker("enter","邱山风") end,
	},{
		name="wdxym-wdsj",												-- 知客道长拔出长剑对着你：如不是上山敬香，即刻请回！ 灵虚道长
		alias=function() alias.check_blocker("su","灵虚道长") end,
	},{
		name="wdyzg-wdbl",												-- 凌虚道长喝道：如不是上山敬香，即刻请回！ 凌虚道长
		alias=function() alias.check_blocker("su","凌虚道长") end,
	},{
		name="guohe",
		alias=function() alias.yellboat() end,
	},{
		name="cc-dmkz",
		alias=function() alias.dmkz("east") end,
	},{
		name="dmkz-cc",
		alias=function() alias.dmkz("west") end,
	},{
		name="qzxm-lsg",														-- 处理泉州的新门吊桥
		alias=function() alias.qzxm_lsg() end,
	},{
		name="qzlsg-xm",														-- 处理泉州的新门吊桥
		alias=function() alias.qzxm_lsg() end,
	},{
		name="hsl-wjggk",
		alias=function() alias.hsl_wjggk() end,
	},{
		name="emjld-99guai",												-- 峨嵋九老洞口到九十九道拐
		alias=function() alias.em_jumang("emjld") end,
	},{
		name="emqfa-99guai",												-- 峨嵋千佛庵到九十九道拐
		alias=function() alias.em_jumang("emqfa") end,
	},{
		name="emhcazd-emhcagc",										-- 峨嵋华藏庵正殿到华藏庵广场，处理静心师太
		alias=function() alias.check_blocker("s","静心师太") end,
	},{
		name="xssm-xsdgc",													-- 雪山山门到雪山大广场，处理葛伦布
		alias=function() alias.check_blocker("n","葛伦布") end,
	},{
		name="xsjgy-xshy",													-- 雪山金刚院到雪山后院，处理萨木活佛
		alias=function() alias.check_blocker("n","萨木活佛") end,
	},{
		name="xscl-xsdd",													-- 雪山长廊到雪山大殿，处理戒律僧
		alias=function() alias.check_blocker("n","戒律僧") end,
	},{
		name="klmlm-sj",													-- 昆仑山摩罗门到石阶，处理说不得
		alias=function() alias.check_blocker("u","说不得") end,
	},{
		name="wdhdzl-wdhy",												-- 武当后殿走廊到武当后院，处理「武当四侠」张松溪
		alias=function() alias.check_blocker("s","张松溪") end,
	},{
		name="wdhdzl-wdxxzl",													-- 武当后殿走廊到西厢走廊，处理「武当四侠」张松溪
		alias=function() alias.check_blocker("w","张松溪") end,
	},{
		name="wdhdzl-wddxzl",													-- 武当后殿走廊到东厢走廊，处理「武当四侠」张松溪
		alias=function() alias.check_blocker("e","张松溪") end,
	},{
		name="askwangsd",
		alias=function() alias.spcmd("ask wang about miji;sd") end,
	},{
		name="askwangn",
		alias=function() alias.spcmd("ask wang about miji;n") end,
	},{
		name="qztj-qzyxd",													-- 全真台阶到养心殿，处理张志光
		alias=function() alias.check_blocker("wu","张志光") end,
	},{
		name="hsxsl-hsxz",													-- 华山小山路到华山华山小筑，处理施戴子
		alias=function() alias.check_blocker("w","施戴子") end,
	},{
		name="hslwc-hsbqf",													-- 华山练武场到华山兵器房，处理劳德诺
		alias=function() alias.check_blocker("w","劳德诺") end,
	},{
		name="hslwc-hskt",													-- 华山练武场到华山客厅，处理劳德诺
		alias=function() alias.check_blocker("s","劳德诺") end,
	},{
		name="hsxl-hscf",													-- 华山西廊到华山厨房，处理岳灵姗
		alias=function() alias.check_blocker("w","岳灵姗") end,
	},{
		name="hshy-hszl",													-- 华山后院到华山走廊，处理陆大有
		alias=function() alias.check_blocker("w","陆大有") end,
	},{
		name="hspt-hsxlgf",													-- 华山偏厅到华山西练功房，处理宁中则
		alias=function() alias.check_blocker("w","宁中则") end,
	},{
		name="hspt-hsqs",													-- 华山偏厅到华山寝室，处理宁中则
		alias=function() alias.check_blocker("s","宁中则") end,
	},{
		name="hspt-hsdlgf",													-- 华山偏厅到华山东练功房，处理宁中则
		alias=function() alias.check_blocker("e","宁中则") end,
	},{
		name="hsdl-hssy",													-- 华山东廊到华山书院，处理梁发
		alias=function() alias.check_blocker("e","梁发") end,
	},{
		name="ynfsl-ynfxj",													-- 华山玉女峰山路到华山玉女峰小径，处理高根明
		alias=function() alias.check_blocker("nu","高根明") end,
	},{
		name="yzxl-yzxsq",													-- 扬州小路到欧阳克的小山丘，处理婢女
		alias=function() alias.check_blocker("wu","婢女") end,
	},{
		name="nantian-yuhuang",													--
		alias=function() alias.check_blocker("ask jiang about 上山;nu","江百胜") end,
	},{
		name="clbxt-clbws",													-- 长乐帮小厅到长乐帮卧室，处理「八爪金龙」司徒横
		alias=function() alias.check_blocker("n","司徒横") end,
	},{
		name="clbyd-clbss",													-- 长乐帮甬道到长乐帮石室，处理虎猛堂 帮众
		alias=function() alias.check_blocker("e","帮众") end,
	},{
		name="gb-killjian",													-- 丐帮竹林小道到竹林小道，处理「执法长老」简长老
		alias=function() alias.check_blocker("e","简长老") end,
	},{
		name="hztyjdm-qsl",													-- 杭州天鹰教大门到青石路，处理天鹰教守卫
		alias=function() alias.check_blocker("n","天鹰教守卫") end,
	},{
		name="lmbj-xy",													-- 杭州龙门镖局到小院，处理都大锦
		alias=function() alias.check_blocker("enter","都大锦") end,
	},{
		name="byjy-bykt",													-- 西域巴依家院到巴依家客厅，处理巴依 胡老爷
		alias=function() alias.check_blocker("e","胡老爷") end,
	},{
		name="qzxy-climbup",													-- 全真悬崖到崖顶 
		alias=function() alias.climbxy("up") end,
	},{
		name="qzxy-climbdown",													-- 崖顶到全真悬崖
		alias=function() alias.climbxy("down") end,
	},{
		name="qzqc-xy",																-- 全真青城到悬崖
		alias=function() alias.spcmd("n;e;e;e;e;e") end,
	},{
		name="qzxy-qc",																-- 全真悬崖到青城
		alias=function() alias.spcmd("w;w;w;w;w;s") end,
	},{
		name="qzqc-jy",																-- 全真青城到靖远
		alias=function() alias.spcmd("n;e;s;w;n;n") end,
	},{
		name="qzjy-qc",																-- 全真靖远到青城
		alias=function() alias.spcmd("s;s;e;n;w;s") end,
	},{
		name="xxsd-xxxyd",													-- 星宿石道到逍遥洞，处理采花子
		alias=function() alias.check_blocker("tear cloth;give piece to caihua zi;enter","采花子") end,
	},{
		name="gyzdm-qy",													-- 归云庄大门到归云庄前院，给家丁书信
		alias=function() alias.check_blocker("give ding xin;enter","家丁") end,
	},{
		name="gyz-guohe",													-- 
		alias=function() alias.gyz_guohe() end,
	},{
		name="slsl-slsl",													-- 
		alias=function() alias.slsl_slsl() end,
	},{
		name="sls-sj",													-- 少林寺2虚到石阶，处理虚通虚明
		alias=function() alias.check_blocker("eu","虚??") end,
	},{
		name="xxyptdm-yptdy",													-- 西夏一品堂大门到一品堂大院，处理一品堂武士
		alias=function() alias.check_blocker("n","一品堂武士") end,
	},{
		name="lzdjjf-jjfdy",													-- 西夏灵州大将军府到将军府大院，处理校尉
		alias=function() alias.check_blocker("s","校尉") end,
	},{
		name="lzbm-cf",													-- 西夏灵州边门到柴房，处理国皇宫卫士
		alias=function() alias.check_blocker("open door;w","皇宫卫士") end,
	},{
		name="slgc-slsmd",													-- 少林广场到山门殿，处理敲门
		alias=function() alias.slgc_slsmd() end,
	},{
		name="movegang",
		alias=function() alias.spcmd("move gang") end,
	},{
		name="yzsclk-nshp",													-- 扬州郊外三岔路口到女山湖畔，处理蒙古军官
		alias=function() alias.check_blocker("se","蒙古军官") end,
	},{
		name="qlyc-mgdcy",													-- 永昌到蒙古大草原
		alias=function() alias.spcmd("n;n;n;n;n;n;n;n;e;e;n;n;n;e;n;n;n;yun refresh") end,
	},{
		name="qlmgdcy-yc",													-- 蒙古大草原到永昌
		alias=function() alias.spcmd("s;s;s;s;s;s;s;s;s;s;s;s;s;s;s;yun refresh") end,
	},{
		name="slzl-sldmd",													-- 少林竹林到达摩洞
		alias=function() alias.spcmd("sw;se;n;s;w;e;w;e;e;s;w;n;nw;n") end,
	},{
		name="slqfd-slzl",													-- 少林千佛殿到竹林，处理清观比丘
		alias=function() alias.check_blocker("open door;n","清观比丘") end,
	},{
		name="slqyp-slsj",													-- 少林青云坪到少林石阶
		alias=function() alias.spcmd("sd;w;e;n;e;s;n;e;w;s") end,
	},{
		name="slssl-slqyp",													-- 少林松树林到少林青云坪
		alias=function() alias.spcmd("w;e;s;e;n;n;e;w;s") end,
	},{
		name="btssm-qy",													-- 白驼山山门到前院，处理白驼山第四代弟子 家丁
		alias=function() alias.check_blocker("wu","家丁") end,
	},{
		name="xydsm-sczl",													-- 西域大沙漠到丝绸之路
		alias=function() alias.spcmd("e;e;e;e;e;e;e;e;e;e;yun refresh;drink jiudai") end,
	},{
		name="xydsm-hyl",													-- 西域大沙漠到胡杨林
		alias=function() alias.spcmd("w;w;w;w;w;w;w;w;w;w;yun refresh;drink jiudai;drink jiudai;drink jiudai") end,
	},{
		name="sgyyd-sgysd",													-- 
		alias=function() alias.spcmd("wield jian;strike wall;out;unwield jian") end,
	},{
		name="sgysd-sgyyd",													-- 
		alias=function() alias.sgysd_sgyyd() end,
	},{
		name="sgyyd-sgymd",													-- 
		alias=function() alias.spcmd("use fire;left") end,
	},{
		name="right",													-- 
		alias=function() alias.spcmd("right") end,
	},{
		name="qldt-ht",													-- 日月神教大堂到后厅，处理日月神教卫士
		alias=function() alias.check_blocker("n","日月神教卫士") end,
	},{
		name="qlqtf-sd",													-- 祁连山齐天峰到日月神教山洞
		alias=function() alias.spcmd("move stone;enter") end,
	},{
		name="qlxt-dl",													-- 日月神教大堂到大牢，处理日月神教卫士
		alias=function() alias.check_blocker("open door;d","日月神教卫士") end,
	},{
		name="qldl-xt",													-- 日月神教大牢到日月神教刑堂
		alias=function() alias.waitrelease() end,
	},{
		name="kljs-sk",													-- 
		alias=function() alias.spcmd("push dashi;enter") end,
	},{
		name="kldsm-hks",													-- 昆仑大沙漠到汉哭山
		alias=function() alias.spcmd("se;s") end,
	},{
		name="yzjwsl-yzjwxf",													-- 扬州郊外树林到萧府大门
		alias=function() alias.spcmd("pa shang;pa zuo;pa shang;pa zuo;pa shang;pa zuo;pa shang;pa zuo;pa xia;pa xia;pa xia;pa xia;w;") end,
	},{
		name="yzjwxf-yzjwsl",													-- 扬州郊外萧府大门到树林
		alias=function() alias.spcmd("halt;e;pa shang;pa shang;pa shang;pa shang;pa you;pa xia;pa you;pa xia;pa you;pa xia;pa you;pa xia") end,
	},{
		name="qzsm-xy",													-- 全真沙漠到悬崖
		alias=function() alias.spcmd("n;e;e;e;e;e") end,
	},{
		name="qzsm-qzqc",													-- 全真沙漠到青城
		alias=function() alias.spcmd("s") end,
	},{
		name="qc-qzsm",													-- 青城到全真沙漠
		alias=function() alias.spcmd("n") end,
	},{
		name="xy-qzsm",													-- 悬崖到全真沙漠
		alias=function() alias.spcmd("w;w;w;w;w") end,
	},{
		name="openzhumenwest",
		alias=function() alias.opendoor("w","竹门") end,
	},{
		name="openzhumeneast",
		alias=function() alias.opendoor("e","竹门") end,
	},{
		name="qc-sdw",													-- 青城到梅超风石洞外
		alias=function() alias.spcmd("n;e;s") end,
	},{
		name="sdw-qc",													-- 梅超风石洞外到青城
		alias=function() alias.spcmd("n;w;s") end,
	},{
		name="findway",													-- 
		alias=function() alias.spcmd("findway") end,
	},{
		name="qzcjg-cjg3l",													-- 全真藏经阁二楼到三楼，处理谭处端
		alias=function() alias.check_blocker("ask tan about 进修;u","谭处端") end,
	},{
		name="slcs-fzl",													-- 少林茶室到方丈楼，处理清乐比丘
		alias=function() alias.check_blocker("n","清乐比丘") end,
	},{
		name="hsxy-pt",													-- 华山悬崖到领悟的平台
		alias=function() alias.spcmd("zha stone;climb down;guanmo jianhen") end,
	},{
		name="hspt-xy",													-- 华山领悟的平台到悬崖
		alias=function() alias.spcmd("climb up") end,
	},{
		name="fengqy",													-- 
		alias=function() alias.spcmd("feng") end,
	},{
		name="knockqz",													-- 
		alias=function() alias.spcmd("knock door;n") end,
	},{
		name="nxsjump",													-- 清音阁到牛心石
		alias=function() alias.spcmd("jump 牛心石") end,
	},{
		name="nxsback",													-- 牛心石到清音阁
		alias=function() alias.spcmd("jump back") end,
	},{
		name="leave9ld",													-- 离开峨嵋九老洞
		alias=function() alias.spcmd("leave") end,
	},{
		name="yellzhou",													-- 九老洞口到周芷若
		alias=function() alias.yellzhou() end,
	},{
		name="qzhnt-ms",													-- 泉州药铺内堂到密室
		alias=function() alias.spcmd("turn ball;d") end,
	},{
		name="qzhms-nt",													-- 泉州药铺密室到内堂
		alias=function() alias.spcmd("turn ball;u") end,
	},{
		name="tsths-up",													-- 泰山探海石上去
		alias=function() alias.spcmd("jump up") end,
	},{
		name="tsths-down",													-- 泰山探海石下来
		alias=function() alias.spcmd("jump down") end,
	},{
		name="slgate-sl",													-- 泉州施琅将军府到将军府，处理官兵和武将
		alias=function() alias.check_blocker("n","武将") end,
	},{
		name="qzlc-mcx",													-- 泉州粮仓到米仓巷，处理官兵和武将
		alias=function() alias.check_blocker("ne","武将") end,
	},{
		name="dladf-xy",													-- 大理定安府到小院，处理大理国武将 傅思归
		alias=function() alias.check_blocker("s","傅思归") end,
	},{
		name="yzhy-yzwf",													-- 扬州后院到丫鬟卧房，处理凌退思
		alias=function() alias.check_blocker("w","凌退思") end,
	},{
		name="thxz-dd",													-- 
		alias=function() alias.spcmd("push left;push left;push left;push right;push right;push right;push front;enter") end,
	},{
		name="thdthl-xj",													-- 桃花阵
		alias=function() alias.thdthl_xj() end,
	},{
		name="xydcy-sl",													-- 
		alias=function() alias.xydcy_sl() end,
	},{
		name="xydcy1-xydcy2",													-- 西域大草原
		alias=function() alias.xydcy1_xydcy2() end,
	},{
		name="nycj-nynm",													-- 南阳城郊到南阳南门，处理守城官兵
		alias=function() alias.check_blocker("enter","守城官兵") end,
	},{
		name="slhda-slhxa",													-- 疏勒河东岸到西岸
		alias=function() alias.slhda_slhxa() end,
	},{
		name="zs-thdht",													-- 舟山到桃花岛
		alias=function() alias.chuango("桃花岛") end,
	},{
		name="thdht-zs",													-- 桃花岛到舟山
		alias=function() alias.chuango("舟山") end,
	},{
		name="lsddy-tgk",													-- 灵蛇岛到塘沽口
		alias=function() alias.chuango("塘沽口") end,
	},{
		name="tgk-lsddy",													-- 塘沽口到灵蛇岛
		alias=function() alias.chuango("灵蛇岛") end,
	},
}
--[[
%if( (@hp.exp<11000000 and %pos( @killnpcover, "emhcazd-emhcagc|dladf-xy|lmbj-xy|lzdjjf-jjfdy|xxyptdm-yptdy|xxyptdt-yptms|yzsclk-nshp")>0) or (@hp.exp<13000000 and %pos( @killnpcover, "gb-killjian|klmlm-sj|hspt-hsdlgf|hspt-hsxlgf|qzcjg-cjg3l|xxysd-xxh|xxysd-xxxw")>0) or (@hp.exp<16400000 and %pos( @killnpcover, "wdhdzl-wdhy|wdhdzl-wddxzl|wdhdzl-wdxxzl")>0), 1, 0)


Direction===ID===LinkRoomNo===RoomNo===Condition===

thjs-slx===3626===1733===1730======
thdd-ms===3679===1757===1756======
--]]
function alias.chuango(where)
	local msg_tri={
		"你喊了半天，也没见一条船过来。",
		"别叫了，这么大眼睛没看见船？",
		"一条渔船应声慢慢驶了过来，渔夫将一块踏脚板搭在沙滩上。",
		"一条战船慢慢驶了过来，水手将一块踏脚板搭在码头上。",
	}

	local _ftri=linktri(msg_tri)
	chuan_fx={n=0,s=0,e=0,w=0}
	chuan_over=where
	run("yell chuan")
	wait.make(function()
		local l,w=wait.regexp(_ftri,2)
		if l==nil then
			alias.zs_thdht()
			return
		end
		if findstring(l,msg_tri[1]) then
			wait.time(5)
			alias.zs_thdht()
			return
		end
		if findstring(l,msg_tri[2],msg_tri[3],msg_tri[4]) then
			alias.chuanupdate()
			trigrpon("gps_chuan")
			run("enter;enter1;enter2;enter3;enter4;start")
			if chuan_over=="桃花岛" then run("e") end
			if chuan_over=="舟山" then run("n") end
			if chuan_over=="灵蛇岛" then run("s") end
			if chuan_over=="塘沽口" then run("w") end

			wait.time(2)
			run("locate")
			--alias.chuango()
			return
		end
	end)
end

chuan_fx={n=0,s=0,e=0,w=0}
chuan_over=""
function alias.locate_cmd()
	run("locate")
end
function alias.lookout_cmd()
	run("lookout")
end
function alias.chuan_locate1(n,l,w)
	chuan_fx["n"]=ctonum(w[3])
	if chuan_over=="桃花岛" or chuan_over=="舟山" or chuan_over=="灵蛇岛" or chuan_over=="塘沽口" then run("s") end
	delay(1,alias.locate_cmd)
end
function alias.chuan_locate2(n,l,w)
	chuan_fx["s"]=ctonum(w[3])
	if chuan_over=="桃花岛" then run("e") end
	if chuan_over=="舟山" then run("n") end
	if chuan_over=="灵蛇岛" then
		if chuan_fx["s"]<50 then run("s") else run("e") end
	end
	if chuan_over=="塘沽口" then run("n") end

	delay(1,alias.locate_cmd)
end
function alias.chuan_locate3(n,l,w)
	chuan_fx["e"]=ctonum(w[3])
	chuan_fx["n"]=ctonum(w[4])
	if chuan_over=="桃花岛" then
		if chuan_fx["e"]<19 then
			run("e")
		elseif chuan_fx["e"]>21 then
			run("w")
		else
			run("s")
		end
	end
	if chuan_over=="舟山" or chuan_over=="灵蛇岛" or chuan_over=="塘沽口" then run("s") end
	delay(1,alias.locate_cmd)
end
function alias.chuan_locate4(n,l,w)
	chuan_fx["e"]=ctonum(w[3])
	chuan_fx["s"]=ctonum(w[4])
	if chuan_over=="桃花岛" then
		if (math.abs(chuan_fx["e"]-20)+math.abs(chuan_fx["s"]-10))<4 then
			alias.lookout_cmd()
			return
		else
			if chuan_fx["e"]<19 then
				run("e")
			elseif chuan_fx["e"]>21 then
				run("w")
			else
				run("s")
			end
		end
	end
	if chuan_over=="舟山" then
		if chuan_fx["s"]<3 then run("w") else run("n") end
	end
	if chuan_over=="灵蛇岛" then
		if chuan_fx["e"]<39 then
			run("e")
		elseif chuan_fx["e"]>41 then
			run("w")
		elseif chuan_fx["s"]<51 then
			run("s")
		elseif chuan_fx["e"]>52 then
			run("n")
		else
			alias.lookout_cmd()
			return
		end
	end
	if chuan_over=="塘沽口" then run("w") end
	delay(1,alias.locate_cmd)
end
function alias.chuan_locate5(n,l,w)
	chuan_fx["e"]=ctonum(w[3])
	if chuan_over=="桃花岛" then
		if chuan_fx["e"]<19 then
			run("e")
		elseif chuan_fx["e"]>21 then
			run("w")
		else
			run("s")
		end
	end
	if chuan_over=="舟山" then run("s") end
	if chuan_over=="灵蛇岛" then run("s") end
	if chuan_over=="塘沽口" then run("w") end
	delay(1,alias.locate_cmd)
end
function alias.chuan_nomoney(n,l,w)
	trigrpoff("gps_chuan")
	walkgo_end_fail()
end
function alias.chuan_done(n,l,w)
	if w[2]==chuan_over then
		trigrpoff("gps_chuan")
		run("halt;out")
		alias.finish()
	end
end
function alias.chuan_lookout(n,l,w)
	if chuan_over=="桃花岛" then
		if string.find(w[2],"东") then
			run("e")
		elseif string.find(w[2],"西") then
			run("w")
		elseif string.find(w[2],"北") then
			run("n")
		else
			run("s")
		end
	end
	delay(1,alias.lookout_cmd)
end
function alias.chuan_onzhoushan(n,l,w)
	if w[2]=="舟山" and chuan_over=="舟山" then run("n") end
	if w[2]=="塘沽口" and chuan_over=="塘沽口" then run("n") end
	if w[2]=="塘沽口" and chuan_over=="灵蛇岛" then run("s") end
	delay(1,alias.locate_cmd)
end
function alias.lookout_lsd(n,l,w)
	if w[2]=="东" then run("go east") end
	if w[2]=="南" then run("go south") end
	if w[2]=="西" then run("go west") end
	if w[2]=="北" then run("go north") end
	if w[2]=="东南" then run("go south") end
	if w[2]=="东北" then run("go north") end
	if w[2]=="西南" then run("go south") end
	if w[2]=="西北" then run("go north") end
	delay(1,alias.lookout_cmd)
end
function alias.chuanupdate()
	addtri("alias_chuan_locate1","^(> > |> |)你现在在(.+)正北约(.+)海哩","gps_chuan","alias.chuan_locate1")
	addtri("alias_chuan_locate2","^(> > |> |)你现在在(.+)正南约(.+)海哩","gps_chuan","alias.chuan_locate2")
	addtri("alias_chuan_locate3","^(> > |> |)你现在在(.+)东约(.+)海哩北约(.+)海哩","gps_chuan","alias.chuan_locate3")
	addtri("alias_chuan_locate4","^(> > |> |)你现在在(.+)东约(.+)海哩南约(.+)海哩","gps_chuan","alias.chuan_locate4")
	addtri("alias_chuan_locate5","^(> > |> |)你现在在(.+)正东约(.+)海哩","gps_chuan","alias.chuan_locate5")
	addtri("alias_chuan_nomoney","^(> > |> |)穷光蛋，一边呆着去！","gps_chuan","alias.chuan_nomoney")
	addtri("alias_chuan_done","^(> > |> |)船夫说：“(.+)到啦，上岸吧”。","gps_chuan","alias.chuan_done")
	addtri("alias_chuan_lookout","^(> > |> |)你极目远眺，发现(.+)方向有一股夹着扑鼻花香的海风吹来。","gps_chuan","alias.chuan_lookout")
	addtri("alias_chuan_onzhoushan","^(> > |> |)你现在在(.+)。","gps_chuan","alias.chuan_onzhoushan")
	addtri("alias_chuan_sigh","^(> > |> |)船夫说：叹！漂到了一荒岛，还是赶紧离开吧。","gps_chuan","alias.locate_cmd")
	addtri("alias_chuan_lookout_lsd","^(> > |> |)你极目远眺，发现(.+)方向数里外是个树木葱翠的海岛，岛上奇峰挺拔，耸立着好几座高山。","gps_chuan","alias.lookout_lsd")
end

gps_yztd322=""
gps_yztd122=""
gps_yztd221=""
gps_yztd223=""
function alias.yztd3_yztd2()											-- 处理扬州田地，从右走到左
	local list_tri={
		".*这里明显的出口是\\s+([^、]+)\\s+和\\s+(.+)。",
	}
	local l_tri=linktri(list_tri)
	run("look")
	wait.make(function()
		local l,w=wait.regexp(l_tri,2)
		if l==nil then
			alias.yztd3_yztd2()
			return
		end
		local tmpfx={"east","west","south","north"}
		if findinlist(w[3],tmpfx) and findinlist(w[4],tmpfx) then
			alias.finish()
			return
		end
		if w[3]=="northeast" then
			gps_yztd322=w[4]
		else
			gps_yztd322=w[3]
		end
		gps_yztd122=""
		run(gps_yztd322)
		alias.yztd3_yztd2()
		--alias.finish()
	end)
end
function alias.yztd2_yztd1()
	local list_tri={
		".*这里明显的出口是\\s+([^、]+)\\s+和\\s+(.+)。",
		--".*这里唯一的出口是\\s+(.+)。",
	}
	local l_tri=linktri(list_tri)
	run("look")
	wait.make(function()
		local l,w=wait.regexp(l_tri,2)
		if l==nil then
			alias.yztd2_yztd1()
			return
		end
		if w[3]=="northwest" or w[4]=="northwest" then
			alias.finish()
			return
		end
		if w[3]==opposite_dir(gps_yztd122) or w[3]==opposite_dir(gps_yztd322) then
			gps_yztd221=w[4]
		else
			gps_yztd221=w[3]
		end
		run(gps_yztd221)
		alias.yztd2_yztd1()
		--alias.finish()
	end)
end
function alias.yztd1_yztd2()											-- 处理扬州田地，从左走到右
	local list_tri={
		".*这里明显的出口是\\s+([^、]+)\\s+和\\s+(.+)。",
	}
	local l_tri=linktri(list_tri)
	run("look")
	wait.make(function()
		local l,w=wait.regexp(l_tri,2)
		if l==nil then
			alias.yztd1_yztd2()
			return
		end
		local tmpfx={"east","west","south","north"}
		if findinlist(w[3],tmpfx) and findinlist(w[4],tmpfx) then
			alias.finish()
			return
		end
		if w[3]=="northwest" then
			gps_yztd122=w[4]
		else
			gps_yztd122=w[3]
		end
		gps_yztd322=""
		run(gps_yztd122)
		alias.yztd1_yztd2()
		--alias.finish()
	end)
end
function alias.yztd2_yztd3()
	local list_tri={
		".*这里明显的出口是\\s+([^、]+)\\s+和\\s+(.+)。",
		--".*这里唯一的出口是\\s+(.+)。",
	}
	local l_tri=linktri(list_tri)
	run("look")
	wait.make(function()
		local l,w=wait.regexp(l_tri,2)
		if l==nil then
			alias.yztd2_yztd3()
			return
		end
		if w[3]=="northeast" or w[4]=="northeast" then
			alias.finish()
			return
		end
		if w[3]==opposite_dir(gps_yztd122) or w[3]==opposite_dir(gps_yztd322) then
			gps_yztd223=w[4]
		else
			gps_yztd223=w[3]
		end
		run(gps_yztd223)
		alias.yztd2_yztd3()
		--alias.finish()
	end)
end

gps_xxgg322=""
gps_xxgg122=""
gps_xxgg221=""
gps_xxgg223=""
function alias.tsysd_xxgg1()											-- 处理星宿干沟，从右走到左
	local list_tri={
		".*这里明显的出口是\\s+([^、]+)\\s+和\\s+(.+)。",
	}
	local l_tri=linktri(list_tri)
	run("look")
	wait.make(function()
		local l,w=wait.regexp(l_tri,2)
		if l==nil then
			alias.tsysd_xxgg1()
			return
		end
		local tmpfx={"east","west","south","north"}
		if findinlist(w[3],tmpfx) and findinlist(w[4],tmpfx) then
			alias.finish()
			return
		end
		if w[3]=="eastdown" then
			gps_xxgg322=w[4]
		else
			gps_xxgg322=w[3]
		end
		gps_xxgg122=""
		run(gps_xxgg322)
		alias.tsysd_xxgg1()
		--alias.finish()
	end)
end
function alias.xxgg1_xxgg2()
	local list_tri={
		".*这里明显的出口是\\s+([^、]+)\\s+和\\s+(.+)。",
		".*这里明显的出口是\\s+([^、]+)、([^、]+)\\s+和\\s+northup。",
		--".*这里唯一的出口是\\s+(.+)。",
	}
	local l_tri=linktri(list_tri)
	run("look")
	wait.make(function()
		local l,w=wait.regexp(l_tri,2)
		if l==nil then
			alias.xxgg1_xxgg2()
			return
		end
		if w[5]~=nil and w[5]~="" then
			alias.finish()
			return
		end
		if w[3]==opposite_dir(gps_xxgg122) or w[3]==opposite_dir(gps_xxgg322) then
			gps_xxgg221=w[4]
		else
			gps_xxgg221=w[3]
		end
		run(gps_xxgg221)
		alias.xxgg1_xxgg2()
		--alias.finish()
	end)
end
function alias.xxgg2_xxgg1()											-- 处理星宿干沟，从左走到右
	local list_tri={
		".*这里明显的出口是\\s+([^、]+)、([^、]+)\\s+和\\s+northup。",
		".*这里明显的出口是\\s+([^、]+)\\s+和\\s+(.+)。",
	}
	local l_tri=linktri(list_tri)
	run("look")
	wait.make(function()
		local l,w=wait.regexp(l_tri,2)
		if l==nil then
			alias.xxgg2_xxgg1()
			return
		end
		local tmpfx={"east","west","south","north"}
		if findinlist(w[5],tmpfx) and findinlist(w[6],tmpfx) then
			alias.finish()
			return
		end
		if w[3]=="westup" then
			gps_xxgg122=w[4]
		else
			gps_xxgg122=w[3]
		end
		gps_xxgg322=""
		run(gps_xxgg122)
		alias.xxgg2_xxgg1()
		--alias.finish()
	end)
end
function alias.xxgg1_tsysd()
	local list_tri={
		".*这里明显的出口是\\s+([^、]+)\\s+和\\s+(.+)。",
		--".*这里唯一的出口是\\s+(.+)。",
	}
	local l_tri=linktri(list_tri)
	run("look")
	wait.make(function()
		local l,w=wait.regexp(l_tri,2)
		if l==nil then
			alias.xxgg1_tsysd()
			return
		end
		if w[3]=="eastdown" or w[4]=="eastdown" then
			alias.finish()
			return
		end
		if w[3]==opposite_dir(gps_xxgg122) or w[3]==opposite_dir(gps_xxgg322) then
			gps_xxgg223=w[4]
		else
			gps_xxgg223=w[3]
		end
		run(gps_xxgg223)
		alias.xxgg1_tsysd()
		--alias.finish()
	end)
end

function alias.climbxy(fx)
	local msg_tri={
		"你爬了上来。",
		"你爬了下来。",
		"那个方向没法爬。",
		"四面光溜溜的崖陡如壁，你轻功不够，怎么也爬不上去。",
	}
	
	local _ftri=linktri(msg_tri)
	run("climb "..fx)
	wait.make(function()
		local l,w=wait.regexp(_ftri,2)
		if l==nil then
			alias.climbxy(fx)
			return
		end
		if findstring(l,msg_tri[1],msg_tri[2]) then
			busytest(alias.climbxy,nil,fx)
			return
		end
		if findstring(l,msg_tri[3]) then
			wait.time(5)
			alias.finish()
			return
		end
		if findstring(l,msg_tri[4]) then
			busytest(alias.climbxy,nil,"down")
			return
		end
	end)
end

function alias.gumuenter()
	local fight_tri={
		"这么急的水，你想跳下去自杀呀？",
	}

	local ok_tri="^(> > |> |)(\\S+) -"

	local _ftri=linktri(fight_tri)
	run("wd")
	wait.make(function()
		local l,w=wait.regexp(ok_tri.."|".._ftri,5)
		--print(ok_tri.."|".._ftri)
		if l==nil then
			wait.time(1)
			alias.gumuenter()
			return
		end
		if w[2]~=nil and w[2]~="" then
			alias.finish()
			return
		end
		if findstrlist(l,fight_tri) then
			walkgo_end_fail()
			return
		end
	end)
end
function alias.sgysd_sgyyd()
	local msg_tri={
		"良久，你突然有一股破壁",
	}

	local _ftri=linktri(msg_tri)
	run("mianbi")
	wait.make(function()
		local l,w=wait.regexp(_ftri,1)
		if l==nil then
			alias.sgysd_sgyyd()
			return
		end
		if findstrlist(l,msg_tri) then
			run("wield jian;strike wall;enter")
			alias.finish()
			return
		end
	end)
end
function alias.yellzhou()
	run("yell 有侣乎？")
	delay(4,alias.finish)
end
function alias.spcmd(cmd)
	run(cmd)
	alias.finish()
end
function alias.gbmdcenter()
	run("say 天堂有路你不走呀;down")
	alias.finish()
end
function alias.pushshibei()
	run("push shibei")
	alias.finish()
end
function alias.enterdong()
	run("enter dong")
	alias.finish()
end
function alias.entergudui()
	run("enter gudui")
	alias.finish()
end
function alias.movelid()
	run("move lid")
	alias.finish()
end
function alias.jumpkeng()
	run("jump 雪坑")
	alias.finish()
end
function alias.xydcy1_xydcy2()
	local msg_tri={
		'设定环境变量：no_more = "goshule"$',
	}

	local _ftri=linktri(msg_tri)
	if #roominfo["exits"]==5 then
		alias.finish()
		return
	end
			
	run("e;set no_more goshule")
	wait.make(function()
		local l,w=wait.regexp(_ftri,2)
		if l==nil then
			alias.xydcy1_xydcy2()
			return
		end
		if findstrlist(l,msg_tri) then
			alias.xydcy1_xydcy2()
		end
	end)
end
function alias.xydcy_sl()
	local msg_tri={
		'设定环境变量：no_more = "goshule"$',
	}

	local _ftri=linktri(msg_tri)
	if roominfo["name"]=="疏勒" then
		alias.finish()
		return
	end
			
	run("n;set no_more goshule")
	wait.make(function()
		local l,w=wait.regexp(_ftri,2)
		if l==nil then
			alias.xydcy_sl()
			return
		end
		if findstrlist(l,msg_tri) then
			alias.xydcy_sl()
		end
	end)
end
function alias.gyz_guohe() 
	run("ask lu about 归云庄;decide")
	alias.yellboat()
end
function alias.waitrelease_ok()
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
	DeleteTrigger("alias_waitrelease")
	run("halt;yun refresh;up;thanks")
	alias.finish()
end
function alias.waitrelease()
	DeleteTrigger("alias_waitrelease")
	addtri("alias_waitrelease","^(> > |> |)牢门缓缓地开启了．．．","alias","alias.waitrelease_ok")
	run("chat 失败啊，被关地牢了，请求好心人搭救～～")
	delay(60, alias.waitrelease)
end
function alias.qzxm_lsg()												-- 处理泉州的新门吊桥
	local msg_tri={
		'设定环境变量：no_more = "checklook"$',
	}

	local _ftri=linktri(msg_tri)
	run("look;set no_more checklook")
	wait.make(function()
		local l,w=wait.regexp(_ftri,5)
		if l==nil then
			wait.time(3)
			alias.qzxm_lsg()
			return
		end
		if findstrlist(l,msg_tri) then
			if table.getn(roominfo["exits"])==4 then
				run("halt;west")
				alias.finish()
				return
			elseif table.getn(roominfo["exits"])==2 then
				run("halt;east")
				alias.finish()
				return
			else
				wait.time(10)
				alias.qzxm_lsg()
				return
			end
		end
	end)
end
function slsl_slsl()
	if #roominfo["exits"]==2 then
		if roominfo["exits"][1]=="southdown" then
			run(roominfo["exits"][2])
			alias.finish()
		elseif roominfo["exits"][2]=="southdown" then
			run(roominfo["exits"][1])
			alias.finish()
		else
			walkgo_end_fail()
		end
	else
		walkgo_end_fail()
	end
end
function alias.opendoor(fx,door)
	local doorn="door"
	if door~=nil then doorn=door end
	run("open "..doorn)
	if roomno_now==2026 and (fx=="up" or fx=="u") then
		run("release yuanshi")
	end
	run(fx)
	alias.finish()
end
function alias.hsl_wjggk() 
	run("enter 第四株")
	alias.finish()
end
function alias.slhda_slhxa()
	local msg_tri={
		"空手砍树恐怕不行吧？",
		"这儿的树枝都被砍光了，等它们长出来时再砍吧。",
		'你砍下的树枝似乎足够做',
	}

	local _ftri=linktri(msg_tri)
	run("wield jian;wield blade;chop shuzhi")
	wait.make(function()
		local l,w=wait.regexp(_ftri,2)
		if l==nil then
			alias.slhda_slhxa()
			return
		end
		if findstring(l,msg_tri[1],msg_tri[2]) then
			walkgo_end_fail()
			return
		end
		if findstring(l,msg_tri[3]) then
			busytest(alias.makeraft)
			return
		end
	end)
end
function alias.makeraft()
	run("make raft;ride raft;rowing")
	alias.rowing()
end
function alias.rowing()
	local msg_tri={
		"你划了半天，木筏终於靠岸了。",
		"木筏又被冲到河中央去了。",
	}

	local _ftri=linktri(msg_tri)
	wait.make(function()
		local l,w=wait.regexp(_ftri,2)
		if l==nil then
			alias.rowing()
			return
		end
		if findstring(l,msg_tri[1]) then
			run("halt;up;unwield jian;unwield blade")
			alias.finish()
			return
		end
		if findstring(l,msg_tri[2]) then
			run("rowing")
			return
		end
		alias.rowing()
	end)
end
function alias.thdthl_xj()
	local msg_tri={
		"现在泥潭时间是(.+)年(.+)月(.+)日(.+)时(.+)。",
	}

	local _ftri=linktri(msg_tri)
	if roominfo["name"]=="小径" then
		alias.finish()
		return
	end
	run("time")
	wait.make(function()
		local l,w=wait.regexp(_ftri,2)
		if l==nil then
			alias.thdthl_xj()
			return
		end
		if w[6]==nil then
			alias.thdthl_xj()
		else
			local fx=nil
			if w[6]=="子" then
				fx="east"
			elseif w[6]=="丑" then
				fx="southeast"
			elseif w[6]=="寅" then
				fx="southeast"
			elseif w[6]=="卯" then
				fx="southwest"
			elseif w[6]=="辰" then
				fx="northeast"
			elseif w[6]=="巳" then
				fx="northeast"
			elseif w[6]=="午" then
				fx="west"
			elseif w[6]=="未" then
				fx="south"
			elseif w[6]=="申" then
				fx="south"
			elseif w[6]=="酉" then
				fx="northwest"
			elseif w[6]=="戌" then
				fx="north"
			elseif w[6]=="亥" then
				fx="north"
			end
			run(fx)
			busytest(alias.thdthl_xj)
		end
	end)
end
function alias.slgc_slsmd()
	local msg_tri={
		"壮年僧人合十为礼，侧身让开，说道：原来是贵客驾到，请进请进！",
		"壮年僧人急忙躬身道：原来是闯过罗汉大阵的大英雄驾到，请进！",
		"壮年僧人侧身让开，说道：师兄辛苦了，请进。",
		"壮年僧人沉下脸来，说道：戒律院主持玄痛大师请师兄",

		"壮年僧人说道：对不起，俗家弟子不得入寺修行。",
		"壮年僧人说道：这位女施主还是请回罢，",
		"壮年僧人说道：这位施主请回罢，本寺不接待俗人。",
		"壮年僧人立时从身畔挚出一把雪亮的戒刀来，把明晃晃的",
		
		'大门天亮前不开，怎么敲也没用。',
		--'吱地一声，里面有人把大门打开了',
		--'大门已经是开着了。',
		--'你轻轻地敲了敲门，只听吱地一声，一位壮年僧人应声打开大门',
		--"你轻轻的敲了敲门,只见一个僧人探出头看了看,",
	}

	local _ftri=linktri(msg_tri)
	run("knock gate;n")
	wait.make(function()
		local l,w=wait.regexp(_ftri,2)
		if l==nil then
			wait.time(3)
			alias.slgc_slsmd()
			return
		end
		if findstring(l,msg_tri[1],msg_tri[2],msg_tri[3],msg_tri[4]) then
			alias.finish()
			return
		end
		if findstring(l,msg_tri[5],msg_tri[6],msg_tri[7],msg_tri[8]) then
			walkgo_end_fail()
			return
		end
		if findstring(l,msg_tri[9]) then
			wait.time(3)
			alias.slgc_slsmd()
			return
		end
	end)
end
function alias.gb_qzl() --丐帮青竹林
--n;e;n;w;n;e;n;w;n 996
   print("丐帮青竹林")
   run("east;north;west;north;east;north;west;north")
   --print("hui diao",self.finish)
   alias.finish()
end
--[[
#ALIAS emjld-99guai {
#if @debug=1 {#say 峨嵋九老洞口到九十九道拐};
#alias cmdonsuccess {northeast;setcmd 1} "always|always_gpsalias";
#alias yinshecmd {#8 {halt;ne;sw};setcmd 24} "always|always_gpsalias";
#alias cmdonsheexist {down;wu;setcmd 2} "always|always_gpsalias";
#t+ gps_dealwith;#t+ gps_99guai;
set 检查蟒蛇在不在;setcmd 1}

#ALIAS emqfa-99guai {#if @debug=1 {#say 峨嵋千佛庵到九十九道拐};#alias cmdonsuccess {southwest;setcmd 1} "always|always_gpsalias";#alias yinshecmd {halt;#8 {sw;ne};setcmd 24} "always|always_gpsalias";#alias cmdonsheexist {down;ne;ed;setcmd 3} "always|always_gpsalias";#t+ gps_dealwith;#t+ gps_99guai;set 检查蟒蛇在不在;setcmd 1}
--]]
function alias.em_jumang(flag)
	local fight_tri={
		"忽然一阵腥风袭来，一条巨蟒从身旁大树上悬下，把你卷走了。",
	}
	local _ftri=linktri(fight_tri)
	local cmd=nil
	if flag=="emjld" then
		cmd="halt;ne;sw;halt;ne;sw;halt;ne;sw;halt;ne;sw;halt;ne;sw;halt;ne;sw;halt;ne;sw;halt;ne;sw"
	elseif flag=="emqfa" then
		cmd="halt;sw;ne;halt;sw;ne;halt;sw;ne;halt;sw;ne;halt;sw;ne;halt;sw;ne;halt;sw;ne;halt;sw;ne;"
	else
		alias.finish()
		return
	end
	wait.make(function()
		run(cmd)
		local l,w=wait.regexp(_ftri,10)
		if l==nil then
			wait.time(1)
			if flag=="emjld" then
				run("halt;ne")
			elseif flag=="emqfa" then
				run("halt;sw")
			end
			alias.finish()
			return
		end
		if findstrlist(l,fight_tri) then
			alias.em_jumang_kill()
			return
		end
	end)
end
function alias.em_jumang_kill()
	local fight_tri={
		"巨蟒全身扭曲，翻腾挥舞，终於僵直而死了。",
		"这里没有这个人。",
	}
	local _ftri=linktri(fight_tri)
	run("kill ju mang")
	wait.make(function()
		local l,w=wait.regexp(_ftri,10)
		if l==nil then
			alias.em_jumang_kill()
			return
		end
		if findstrlist(l,fight_tri) then
			wait.time(1)
			if flag=="emjld" then
				run("halt;down;wu")
			elseif flag=="emqfa" then
				run("halt;down;ne;ed")
			end			
			alias.finish()
			return
		end
	end)
end
--[[
function alias.xxysd_xxh() 								-- 星宿银山道到星宿海，处理狮吼子

	local fight_tri={
		"星宿海",
		"狮吼子一言不发，闪身拦在你面前。",
	}
	blocker_name="狮吼子"
	blocker_id="shihou zi"
	local _ftri=linktri(fight_tri)
	run("nd")
	wait.make(function()
		local l,w=wait.regexp(_ftri,5)
		if l==nil then
			wait.time(1)
			alias.xxysd_xxh()
			return
		end
		if findstring(l,fight_tri[1]) then
			print("::路障NPC清除完毕！::")
			alias.finish()
			return
		end
		if findstring(l,fight_tri[2]) then
			run("kill "..blocker_id)
			wait.time(1)
			alias.kill_blocker()
			return
		end
		------print("Fight:All trigger is match!")
		--alias.kill_jiang()
	-------------------------------------------------
		wait.time(5)
	end)
end

function alias.clbdm_clbdt()							-- 长乐帮大门到长乐帮大厅，处理虎猛堂香主 邱山风
	local fight_tri={
		"大厅 -",
		"怎么连一点江湖规矩都不懂？起码也得孝敬一下老子。",
	}
	blocker_name="邱山风"
	blocker_id="qiu shanfeng"
	local _ftri=linktri(fight_tri)
	run("enter")
	wait.make(function()
		local l,w=wait.regexp(_ftri,5)
		if l==nil then
			wait.time(1)
			alias.clbdm_clbdt()
			return
		end
		if findstring(l,fight_tri[1]) then
			--print("::路障NPC清除完毕！::")
			wait.time(1)
			alias.finish()
			return
		end
		if findstring(l,fight_tri[2]) then
			run("kill "..blocker_id)
			wait.time(1)
			alias.kill_blocker()
			return
		end
	end)
end
function alias.kill_blocker()
	local fight_tri={
		".+倒在地上，挣扎了几下就死了。",
		"这里没有这个人",
	}
	local _ftri=linktri(fight_tri)
	run("kill "..blocker_id)
	wait.make(function()
		local l,w=wait.regexp(_ftri,5)
		if l==nil then
			wait.time(1)
			alias.kill_blocker()
			return
		end
		if findstring(l,fight_tri[1],fight_tri[2]) then
			print("::路障NPC清除完毕！::")
			alias.finish()
			return
		end

		------print("Fight:All trigger is match!")
		--alias.kill_sl()
		-------------------------------------------------
		wait.time(5)
	end)
end
--]]
function alias.check_blocker(fx,name)
	local fight_tri={
		"怎么连一点江湖规矩都不懂？起码也得孝敬一下老子。",
		"狮吼子一言不发，闪身拦在你面前。",
		"知客道长拔出长剑对着你：如不是上山敬香，即刻请回！",
		"凌虚道长喝道：如不是上山敬香，即刻请回！",
		"张松溪喝道：里面是武当重地，闲人请止步。",
		"静心师太走上前说：后边是峨嵋弟子练功休息的地方，请留步。",
		"葛伦布挡住你说：你准备用什麽供奉我们佛爷呀？",
		"萨木活佛挡住你说道：後面是本寺高僧修行之地，施主请回。",
		"戒律僧挡住你说：后面乃本寺重地，请回吧！",
		"说不得伸手拦住你，说道：上面是明教光明顶，这位*并非我教弟子，请止步!",
		"张志光拦住说道：对不起，养心殿不对外开放！",
		"施戴子拦住你说：两位师叔祖不欲见客，请回吧。",
		"劳德诺欠身说道：这位",
		"岳灵姗拦身说道：后面是本派厨房",
		"陆大有喝道：后面是华山派的内院，这位",
		"宁中则拦在你身前斥道：外人不能随易出入本派重地！还不快给我离开？",
		"梁发挡住你说道：后面是本派书院，这位",
		"高根明拦住你说：由此往上乃本派禁地，请止步。",
		"婢女伸手挡住了你的去路：少庄主正在调训毒蛇，请改日再来。",
		"江百胜伸手拦住你说道：盟主很忙，现在不见外客，你下山去吧！",
		"司徒横拦在你面前，喝道：",
		"帮众拦在你面前，说道：里面是关押本帮叛徒的地方，你请回吧。",
		"简长老一把揪住你的衣领说：“慢着！”",
		"天鹰教守卫喝道：这位",
		"都大锦拦在你面前，喝道：",
		"胡老爷说: 我把阿凡提关在我的客厅里了，谁也不许进去。",
		"采花子挡住了你：我的小妞可不是给你们",
		"虚通伸手拦住你白眼一翻说道：千年以来，少林向不许",
		"虚明迈步挡在你身前，双手合什说道：阿弥陀佛，",
		"虚通拦住你说道：这位",
		"虚明迈步挡在你身前，双手合什说道：阿",
		"一品堂武士挡住了你的去路！",
		"校尉挡住了你的去路！",
		"卫士对你大吼一声：放肆！那不是你能进去的地方。",
		"蒙古军官一语不发，站在你面前挡著你的去路！",
		"清观喝道：你不是少林弟子，不得进入后山竹林！",
		"家丁挡住了你的去路：老爷正在练功，请改日再来。",
		"卫士对你喝道：看招！别妄想闯入本教重地！",
		"未经许可，不得进入藏经阁三楼！",
		"清乐比丘拦住你说；你资格不够，不能进入方丈室。",
		
		"守卫喝道：闲杂人等，不得乱闯。",
		"凌翰林挡住了你：请勿入内宅。",
		"衙役喝道：“威……武……。”",
		"守城军官瞅著你，举起手中兵器，挡住你的去路。",
	}
	
	local throw_tri={
		"官兵拦住了你的去路。",
		"武将拦住了你的去路。",
		"官兵大喝道：都督有令，闲杂人等不能由此经过！",
		"武将大喝道：都督有令，闲杂人等不能由此经过！",
	}

	local ok_tri="^(> > |> |)(\\S+) -"
	
	blocker_fx=fx
	blocker_name=name
	blocker_id=alias.blocker[blocker_name]["id"]

	local _ftri=linktri(fight_tri)
	local t_ftri=linktri(throw_tri)
	run("hp;"..blocker_fx)
	wait.make(function()
		local l,w=wait.regexp(ok_tri.."|".._ftri.."|"..t_ftri,5)
		--print(ok_tri.."|".._ftri)
		if l==nil then
			wait.time(1)
			alias.check_blocker(blocker_fx,blocker_name)
			return
		end
		if w[2]~=nil and w[2]~="" then
			print("::路障NPC清除完毕！::")
			--wait.time(1)		-- 不要等了，万一刚好刷新NPC比较麻烦
			alias.finish()
			return
		end
		if findstrlist(l,fight_tri) then
			print("::开始清理路障NPC >>"..blocker_name.."<<::>>"..blocker_id.."<<::")
			alias.check_do_blocker()
			return
		end
		
		if findstring(l,throw_tri[1],throw_tri[3]) then
			blocker_name="官兵"
		end
		if findstring(l,throw_tri[2],throw_tri[4]) then
			blocker_name="武将"
		end
		alias.check_do_blocker()
	end)
end
alias.check_do_blocker=function()					-- 检查是不是要杀人
	blocker_id=alias.blocker[blocker_name]["id"]
	local throw=false
	if alias.blocker[blocker_name]["throw"]~=nil then
		throw=true
	end
	if me.hp["exp"]<alias.blocker[blocker_name]["explimit"] then
		print("::现在还打不过>>"..blocker_name.."<<多吃几年饭再来吧::")
		walkgo_end_fail()
	elseif me.hp["exp"]<alias.blocker[blocker_name]["needpfm"] then				-- 用PFM杀
		do_killnpc(blocker_name, blocker_id,true,throw,1,0,alias.blocker_ok,alias.blocker_fail)
	elseif me.hp["exp"]>alias.blocker[blocker_name]["needpfm"] then				-- 不用PFM杀
		do_killnpc(blocker_name, blocker_id,false,throw,1,0,alias.blocker_ok,alias.blocker_fail)
	end
end
alias.blocker_ok=function()												-- 杀人成功回调函数
	alias.check_blocker(blocker_fx,blocker_name)
end
alias.blocker_fail=function()											-- 杀人失败回调函数
	walkgo_end_fail()
end
-----------------------------------------------------------------------------------------------------------------------------
-- 过河模块开始
-----------------------------------------------------------------------------------------------------------------------------
function alias.dmkz(fx)
	local yell_tri={
		"松花江化冻了，你喊",
		"你见江面结冻，便壮起胆子踩冰而过。",
	}
	local yell_reg=linktri(yell_tri)
	
	wait.make(function()
		run(fx)
		local l,w=wait.regexp(yell_reg,2)
		if l==nil then
			alias.dmkz(fx)
			return
		end
		if findstring(l,yell_tri[1]) then
			alias.yellboat()
			return
		end
		if findstring(l,yell_tri[2]) then
			run(fx)
			alias.finish()
			return
		end
	end)
end
function alias.yellboat()
	if me.menpai=="sl" and me.master=="觉心" and me.skills["shaolin-shenfa"]["lv"]>200 and me.skills["hunyuan-yiqi"]["lv"]>160 and me.hp["neilimax"]>2000 then
		run("yun du")
		busytest(alias.finish)
		return
	end
	alias.yellboat_cmd()
end
function alias.yellboat_cmd()
	local yell_tri={
		"一叶扁舟缓缓地驶了过来，艄公将一块踏脚板搭上堤岸，以便乘客",
		"岸边一只渡船上的老艄公说道：正等着你呢，上来吧。",
		
		"^(> > |> |)只听得(.+)面上隐隐传来：“别急嘛，",
		
		"艄公把踏脚板收起来，说了一声“坐稳喽”，",
		"江船 -","渡船 -","小舟 -","大船 -",
	}
	local yell_reg=linktri(yell_tri)

	wait.make(function()
		run("look;yell boat")
		local l,w=wait.regexp(yell_reg,2)
		if l==nil then
			alias.yellboat_cmd()
			return
		end
		if findstring(l,yell_tri[1],yell_tri[2]) then
			run("halt;enter")
			run("set no_more boatbusy")
			alias.yellboat_busy()
			return
		end
		if findstring(l,yell_tri[3]) then
			print("渡船繁忙，尝试叫船")
			alias.yellboat_busy()
			return
		end
		if findstring(l,yell_tri[4],yell_tri[5],yell_tri[6],yell_tri[7],yell_tri[8]) then		-- 已经在船上了
			alias.yellboat_outboat()
			return
		end
		run("set no_more boatbusy")
		alias.yellboat_busy()
	end)
end
function alias.yellboat_busy()
	local yell_tri={
		'设定环境变量：no_more = "boatbusy"$',
		"艄公把踏脚板收起来，说了一声“坐稳喽”，",
		"江船 -","渡船 -","小舟 -","大船 -",
	}
	local yell_reg=linktri(yell_tri)

	wait.make(function()
		local l,w=wait.regexp(yell_reg,1)
		----print("yellboat_busy:",l)
		if l==nil then
			alias.yellboat_cmd()
			return
		end
		if findstring(l,yell_tri[2],yell_tri[3],yell_tri[4],yell_tri[5],yell_tri[6]) then		-- 已经在船上了
			alias.yellboat_outboat()
			return
		end
		if findstring(l,yell_tri[1]) then
			alias.yellboat_wait()
			return
	  end
	  alias.yellboat_busy()
	  wait.time(1)
   end)
end
function alias.yellboat_wait()			-- 这里可以改成打坐、练技能的
	if me.jifa["force"]==nil then me.jifa["force"]=0;run("jifa") end
	gethp(alias.yellboat_wait_check)
end
function alias.yellboat_wait_check()
	hp_check(alias.yellboat)
end
function alias.yellboat_outboat()
	local outboat_tri={
		"艄公说“到啦，上岸吧”，随即把一块踏脚板搭上堤岸。",
	}
	local outboat_reg=linktri(outboat_tri)

	wait.make(function()
		local l,w=wait.regexp(outboat_reg,2)
		if l==nil then
			alias.yellboat_outboat()
			return
		end
		if findstrlist(l,outboat_tri)then
			print("到地方了，下船！")
			local f=function()
				run("halt;out")
				alias.finish()
				end
			delay(1,f)
			return
		end
		wait.time(2)
	end)
end
-----------------------------------------------------------------------------------------------------------------------------
-- 过河模块结束
-----------------------------------------------------------------------------------------------------------------------------

function alias.exec(alias_name)
	for _,a in ipairs(alias.alias_table) do
	  if a.name==alias_name then
		local f=a.alias
		f()
		break
	  end
   end
end

function alias.finish()
	busytest(walk_auto_next)
end
