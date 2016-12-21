---------------------------------------------------------------------------
-- File name   : pkukxk_playerid.lua
-- Description : 此文件为《一个脚本框架》文件的总调用、配置文件。
-- Author: 胡小子littleknife (applehoo@126.com)
-- Version:	2012.02.10.0752
-- Useage:在mcl中，调用此文件，即可加载全部模块。
-- Michen 修改于2014.05，去掉了所有乱七八糟的东西，只保留了加载其它RBT的部份
-- 同时把所有的游戏内部配置放到这个文件中，以后游戏万一更新只要改这边就好
-- 所有角色等特殊的变量都做到MCL的变量里，这样多帐号支持的更好些
---------------------------------------------------------------------------

conf={}

-- 保存所有的师傅信息
conf.master={
	["自学贯通"]			={"none",				0,},		-- 第一个是师傅的ID，第二个是师傅所在房间的ID
	["觉心"]				={"juexin",				0,},
	["一灯大师"]			={"yideng",				0,},
	["黄药师"]				={"huang",				0,},
	["张三丰"]				={"zhang",				0,},
	["马钰"]				={"ma",					0,},
	["欧阳锋"]				={"ouyang",			0,},
	["风清扬"]				={"feng",					0,},
	["天狼子"]				={"tianlang",			1435,},
	["阿紫"]				={"azi",					0,},
	["出尘子"]				={"chuchen",			0,},
	["狮吼子"]				={"shihou",				0,},
	["丁春秋"]				={"ding",					1442,},
	["鲁有脚"]				={"youjiao",			1116,},
	["马光佐"]				={"ma",					925,},
	["欧阳克"]				={"ke",					926,},
}

region_names={
	"西域白驼山","北京","关外长白山","扬州","扬州郊外","云南大理","四川峨嵋","广东佛山",
	"丐帮所在地","杭州","黄河边","安徽黄山","华山","海外","嘉兴","昆仑山","云南苗疆",
	"祈连山","福建泉州","嵩山少林","辽东神龙岛","太湖边","山东泰山","东海桃花岛","华山村",
	"湖北武当山","西域","西夏","藏边大雪山","终南山","东海灵蛇岛","昆仑山","南阳",
}

_force_data={}
_force_data["hunyuan-yiqi"]={}
_force_data["hunyuan-yiqi"]["family"]={"少林派"}
_force_data["hunyuan-yiqi"]["factor"]=8
_force_data["hunyuan-yiqi"]["zheng_xie"]=1
_force_data["hunyuan-yiqi"]["gang_rou"]=1
_force_data["linji-zhuang"]={}
_force_data["linji-zhuang"]["family"]={"峨嵋派"}
_force_data["linji-zhuang"]["factor"]=8
_force_data["linji-zhuang"]["zheng_xie"]=1
_force_data["linji-zhuang"]["gang_rou"]=-1
_force_data["taiji-shengong"]={}
_force_data["taiji-shengong"]["family"]={"武当派"}
_force_data["taiji-shengong"]["factor"]=8
_force_data["taiji-shengong"]["zheng_xie"]=1
_force_data["taiji-shengong"]["gang_rou"]=-1
_force_data["huntian-qigong"]={}
_force_data["huntian-qigong"]["family"]={"丐帮"}
_force_data["huntian-qigong"]["factor"]=7
_force_data["huntian-qigong"]["zheng_xie"]=1
_force_data["huntian-qigong"]["gang_rou"]=1
_force_data["huagong-dafa"]={}
_force_data["huagong-dafa"]["family"]={"星宿派"}
_force_data["huagong-dafa"]["factor"]=8
_force_data["huagong-dafa"]["zheng_xie"]=-1
_force_data["huagong-dafa"]["gang_rou"]=-1
_force_data["bitao-xuangong"]={}
_force_data["bitao-xuangong"]["family"]={"桃花岛"}
_force_data["bitao-xuangong"]["factor"]=7
_force_data["bitao-xuangong"]["zheng_xie"]=0
_force_data["bitao-xuangong"]["gang_rou"]=0
_force_data["hamagong"]={}
_force_data["hamagong"]["family"]={"白驼山"}
_force_data["hamagong"]["factor"]=7
_force_data["hamagong"]["zheng_xie"]=-1
_force_data["hamagong"]["gang_rou"]=1
_force_data["longxiang-banruo"]={}
_force_data["longxiang-banruo"]["family"]={"血刀门","雪山派"}
_force_data["longxiang-banruo"]["factor"]=6
_force_data["longxiang-banruo"]["zheng_xie"]=-1
_force_data["longxiang-banruo"]["gang_rou"]=1
_force_data["zixia-gong"]={}
_force_data["zixia-gong"]["family"]={"华山派"}
_force_data["zixia-gong"]["factor"]=7
_force_data["zixia-gong"]["zheng_xie"]=1
_force_data["zixia-gong"]["gang_rou"]=0
_force_data["dulong-dafa"]={}
_force_data["dulong-dafa"]["family"]={"神龙教"}
_force_data["dulong-dafa"]["factor"]=5
_force_data["dulong-dafa"]["zheng_xie"]=-1
_force_data["dulong-dafa"]["gang_rou"]=-1
_force_data["kurong-changong"]={}
_force_data["kurong-changong"]["family"]={"大理段家"}
_force_data["kurong-changong"]["factor"]=7
_force_data["kurong-changong"]["zheng_xie"]=1
_force_data["kurong-changong"]["gang_rou"]=1
_force_data["xiantian-gong"]={}
_force_data["xiantian-gong"]["family"]={"全真教"}
_force_data["xiantian-gong"]["factor"]=8
_force_data["xiantian-gong"]["zheng_xie"]=1
_force_data["xiantian-gong"]["gang_rou"]=1
_force_data["guangming-shenghuo"]={}
_force_data["guangming-shenghuo"]["family"]={"明教"}
_force_data["guangming-shenghuo"]["factor"]=7
_force_data["guangming-shenghuo"]["zheng_xie"]=1
_force_data["guangming-shenghuo"]["gang_rou"]=1
_force_data["diandao-gong"]={}
_force_data["diandao-gong"]["family"]={"明教"}
_force_data["diandao-gong"]["factor"]=5
_force_data["diandao-gong"]["zheng_xie"]=0
_force_data["diandao-gong"]["gang_rou"]=1
_force_data["mile-gong"]={}
_force_data["mile-gong"]["family"]={"明教"}
_force_data["mile-gong"]["factor"]=5
_force_data["mile-gong"]["zheng_xie"]=1
_force_data["mile-gong"]["gang_rou"]=0
_force_data["motian-yunqi"]={}
_force_data["motian-yunqi"]["family"]={"明教"}
_force_data["motian-yunqi"]["factor"]=6
_force_data["motian-yunqi"]["zheng_xie"]=1
_force_data["motian-yunqi"]["gang_rou"]=1
_force_data["hunyuan-gong"]={}
_force_data["hunyuan-gong"]["family"]={"明教"}
_force_data["hunyuan-gong"]["factor"]=6
_force_data["hunyuan-gong"]["zheng_xie"]=1
_force_data["hunyuan-gong"]["gang_rou"]=1
_force_data["xiuling-yaozhi"]={}
_force_data["xiuling-yaozhi"]["family"]={"明教"}
_force_data["xiuling-yaozhi"]["factor"]=5
_force_data["xiuling-yaozhi"]["zheng_xie"]=0
_force_data["xiuling-yaozhi"]["gang_rou"]=0
_force_data["xuanmen-daoyin"]={}
_force_data["xuanmen-daoyin"]["factor"]=5
_force_data["xuanmen-daoyin"]["zheng_xie"]=1
_force_data["xuanmen-daoyin"]["gang_rou"]=-1
_force_data["xuanyin-zhenqi"]={}
_force_data["xuanyin-zhenqi"]["family"]={"明教"}
_force_data["xuanyin-zhenqi"]["factor"]=6
_force_data["xuanyin-zhenqi"]["zheng_xie"]=1
_force_data["xuanyin-zhenqi"]["gang_rou"]=-1
_force_data["yunu-xinjing"]={}
_force_data["yunu-xinjing"]["family"]={"古墓派"}
_force_data["yunu-xinjing"]["factor"]=8
_force_data["yunu-xinjing"]["zheng_xie"]=0
_force_data["yunu-xinjing"]["gang_rou"]=0
_force_data["jiuyang-shengong"]={}
_force_data["jiuyang-shengong"]["family"]=0
_force_data["jiuyang-shengong"]["factor"]=10
_force_data["jiuyang-shengong"]["zheng_xie"]=1
_force_data["jiuyang-shengong"]["gang_rou"]=1
_force_data["taixuan-gong"]={}
_force_data["taixuan-gong"]["family"]=0
_force_data["taixuan-gong"]["factor"]=7
_force_data["taixuan-gong"]["zheng_xie"]=1
_force_data["taixuan-gong"]["gang_rou"]=0

luapath=string.match(GetInfo(35),"^.*\\")
mclpath=GetInfo(67)
include=function(str)
	dofile(luapath..str)
end
loadmod=function(str)
	include("mods\\"..str)
end

loadmclfile=function(str)
		local f=(loadfile(mclpath..str))
		if f~=nil then f() end
end
include("xkx_frame.mod")














