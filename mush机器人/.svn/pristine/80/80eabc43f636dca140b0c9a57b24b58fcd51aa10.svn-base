---------------------------------------------------------------------------
-- File name   : michen_stat.lua
-- Description : 这个模块监控并记录所有的状态
--
-- Author: Michen (xmichen@gmail.com)
-- Version:	2014.05
---------------------------------------------------------------------------

print("Loading Michen stat mod OK!")

stat={}

function stat.bt_yun1_0() stat.reverse=false end
function stat.bt_yun1_1() stat.reverse=true end
function stat.bt_yun2_0() stat.powerup=false end
function stat.bt_yun2_1() stat.powerup=true end
stat.update=function()
	addtri("bt_yun1_0","^(> > |> |)你的经脉倒转运行完毕，经脉回复一如往常。","stat","stat.bt_yun1_0")
	addtri("bt_yun1_1","^(> > |> |)只见你口中叫道「差尔刺呼，哈虎」，忽做头下脚上之形，双手撑地，蹦来蹦去。","stat","stat.bt_yun1_1")
	addtri("bt_yun2_0","^(> > |> |)只见你的蛤蟆功运行完毕，将内力收回丹田。","stat","stat.bt_yun2_0")
	addtri("bt_yun2_1","^(> > |> |)只见你蹲在地下，双手弯与肩齐，宛似一只大青蛙般作势相扑，口中发出老牛嘶鸣般的咕咕之声，时歇时作。","stat","stat.bt_yun2_1")
end
stat.update()
--[[

--]]
