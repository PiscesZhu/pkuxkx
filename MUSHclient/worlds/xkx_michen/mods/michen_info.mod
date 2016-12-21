---------------------------------------------------------------------------
-- File name   : michen_info.lua
-- Description : 这个模块用来做一个按钮窗，方便大家使用
--
-- Author: Michen (xmichen@gmail.com)
-- Version:	2014.05
---------------------------------------------------------------------------

print("Loading Michen info mod OK!")

require "InfoBox"

infowin={
	win=nil,
}

function infowin.accountconfig()
	SetOption("auto_repeat",1)
	SetOption("enable_command_stack",1)
	SetAlphaOption("command_stack_character",";")
	SetOption("script_errors_to_output_window",1)
	local account=utils.inputbox("请输入您的游戏帐号：","XKX Robot By Michen",GetAlphaOption("player"))
	if account~=nil then SetAlphaOption("player",account) end
	local password=utils.inputbox("请输入您的登陆密码：","XKX Robot By Michen",GetAlphaOption("password"))
	if password~=nil then SetAlphaOption("password",password) end
	Save()
end

function infowin.skillconfig()
	local lingwuskill=utils.editbox("请输入您要领悟的技能列表(按顺序写入，用|分隔，如：force|dodge|parry)：","XKX Robot By Michen",GetVariable("lingwuskill"))
	if lingwuskill~=nil then SetVariable("lingwuskill",lingwuskill) end
	local learnskill=utils.editbox("请输入您要学习的技能列表(按顺序写入，用|分隔，如：force|dodge|parry)：","XKX Robot By Michen",GetVariable("learnskill"))
	if learnskill~=nil then SetVariable("learnskill",learnskill) end
	Save()
end

function infowin.pfmsetting()
	local yun=utils.editbox("请输入您要使用的心法(yun daxiao;yun tiandi)：","XKX Robot By Michen",GetVariable("yun"))
	if yun~=nil then SetVariable("yun",yun) end
	local pfm=utils.editbox("请输入您要使用的PFM(perform hebi;perform suxin)：","XKX Robot By Michen",GetVariable("pfm"))
	if pfm~=nil then SetVariable("pfm",pfm) end
	Save()
end

function infowin.countreset()
	SetVariable("exp_count_start",os.time())
	me.expcheck=2
	run("hp")
	Save()
end

function infowin.stopall()
	system.allstop()
end

infowin.button={
	{"登陆设置","infowin.accountconfig","帐号登陆信息等基本配置",},
	{"技能设置","infowin.skillconfig","设置学习和领悟的技能清单",},
	{"PFM设置","infowin.pfmsetting","设置杀人时用的心法和PFM",},
	{"重置统计信息","infowin.countreset","重新开始获得经验值统计",},
	{"停止所有工作","infowin.stopall","完全停止机器人",},
	{"侠客岛机器人","qxkd.start","侠客岛全自动机器人",},
	{"开始古墓任务","qgm.start","目前只做采蜜和哭声任务，采花大盗毒太厉害，完全没办法做",},
	{"修炼QZWD","qqzwd.start","开始修炼千蛛万毒手",},
	{"白驼新手放蛇","qxxbt.start","新手放蛇咬家丁到80K",},
}
function infowin.update()
	infowin.win = infowin.win or InfoBox:New("config")
	infowin.win.columns=2
	infowin.win:WindowPosition(infowin.win.windowPositions.NE)
	infowin.win.Bar.barStyle = InfoBox.barStyles.flat
	for k,v in pairs(infowin.button) do
		local tw = infowin.win.Bars[k] or infowin.win:AddBar(v[1])
		tw.barStyle = InfoBox.barStyles.flat
		tw.button={mouseDown=v[2],tooltipText=v[3],cursor=1}
	end
	infowin.win:Update()
end

function infowin.close()
	infowin.win:CloseWindow()
end
infowin.update()
