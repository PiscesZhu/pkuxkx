require "InfoBox"

infobtn={
	win=nil,
}

function _isopen(a)
	if a~=nil and a>0 then return "启动" else return "关闭" end
end
function infobtn.accountconfig()
	local account=utils.inputbox("请输入您的游戏帐号：","XKX Robot By Michen",GetAlphaOption("player"))
	if account~=nil then SetAlphaOption("player",account) end
	local password=utils.inputbox("请输入您的登陆密码：","XKX Robot By Michen",GetAlphaOption("password"))
	if password~=nil then SetAlphaOption("password",password) end
	Save()
end
function infobtn.idle()
	if setting_resetidle>0 then setting_resetidle=0 else setting_resetidle=1 end
	if setting_resetidle>0 then resetidle=1 else resetidle=0 end
	for k,v in pairs(infobtn.button) do
		if v[2]=="infobtn.idle" then
			local tw=infobtn.win.Bars[k]
			tw:Caption("防发呆".._isopen(setting_resetidle))
			infobtn.win:Update()
			break
		end
	end
end
function infobtn.fj()
	if workflow.fj>0 then workflow.fj=0 else workflow.fj=1 end
	for k,v in pairs(infobtn.button) do
		if v[2]=="infobtn.fj" then
			local tw=infobtn.win.Bars[k]
			tw:Caption("FJ模块".._isopen(workflow.fj))
			infobtn.win:Update()
			break
		end
	end
end
function infobtn.mp()
	if workflow.mp>0 then workflow.mp=0 else workflow.mp=1 end
	for k,v in pairs(infobtn.button) do
		if v[2]=="infobtn.mp" then
			local tw=infobtn.win.Bars[k]
			tw:Caption("MP模块".._isopen(workflow.mp))
			infobtn.win:Update()
			break
		end
	end
end
function infobtn.xf()
	if workflow.xf>0 then workflow.xf=0 else workflow.xf=1 end
	for k,v in pairs(infobtn.button) do
		if v[2]=="infobtn.xf" then
			local tw=infobtn.win.Bars[k]
			tw:Caption("XF模块".._isopen(workflow.xf))
			infobtn.win:Update()
			break
		end
	end
end
function infobtn.cm()
	if workflow.cm>0 then workflow.cm=0 else workflow.cm=1 end
	for k,v in pairs(infobtn.button) do
		if v[2]=="infobtn.cm" then
			local tw=infobtn.win.Bars[k]
			tw:Caption("CM模块".._isopen(workflow.cm))
			infobtn.win:Update()
			break
		end
	end
end
function infobtn.ftb()
	if workflow.ftb>0 then workflow.ftb=0 else workflow.ftb=1 end
	for k,v in pairs(infobtn.button) do
		if v[2]=="infobtn.ftb" then
			local tw=infobtn.win.Bars[k]
			tw:Caption("FTB模块".._isopen(workflow.ftb))
			infobtn.win:Update()
			break
		end
	end
end
function infobtn.set_neili_job()
	local neili=utils.inputbox("工作内力达到最大内力的百分之多少开始工作","XKX Robot By Michen",set_neili_job)
	if neili~=nil then
		for k,v in pairs(infobtn.button) do
			if v[2]=="infobtn.set_neili_job" then
				local tw=infobtn.win.Bars[k]
				tw:Caption("工作内力"..tostring(set_neili_job).."%")
				infobtn.win:Update()
				break
			end
		end
		set_neili_job=neili
	end
end
function infobtn.set_neili_global()
	local neili=utils.inputbox("全局内力达到最大内力的百分之多少开始工作","XKX Robot By Michen",set_neili_global)
	if neili~=nil then
		for k,v in pairs(infobtn.button) do
			if v[2]=="infobtn.set_neili_global" then
				local tw=infobtn.win.Bars[k]
				tw:Caption("全局内力"..tostring(set_neili_global).."%")
				infobtn.win:Update()
				break
			end
		end
		set_neili_job=neili
	end
end
function infobtn.set_GbSecretWay()
	if set_GbSecretWay>0 then set_GbSecretWay=0 else set_GbSecretWay=1 end
	for k,v in pairs(infobtn.button) do
		if v[2]=="infobtn.set_GbSecretWay" then
			local tw=infobtn.win.Bars[k]
			tw:Caption("钻狗洞".._isopen(set_GbSecretWay))
			infobtn.win:Update()
			break
		end
	end
end
function infobtn.resetstatus()
	mark.time=os.time()
	mark.sTime=os.time()
	addneili.fj=0
	addneili.dazuo=0
	addneili.dahuandan=0
	addneili.putizi=0
	list.shizhe=""
	list.putizi=""
	list.pk=""
	cmd.waitcount=0
	sum.fj=0
	sum.mp=0
	sum.ftb=0
	sum.death=0
	sum.lifesave=0
	count.fj=0
	count.mp=0
	count.ftb=0
	count.death=0
	count.lifesave=0
	resetExplist=""
	ErrList=""
	DeathList=""
end
function infobtn.skillconfig()
	local lingwuskill=utils.editbox("请输入您要领悟的技能列表(按顺序写入，用|分隔，如：force|dodge|parry)：","XKX Robot By Michen",skills_lingwu)
	if lingwuskill~=nil then skills_lingwu=lingwuskill end
	local learnskill=utils.editbox("请输入您要学习的技能列表(按顺序写入，用|分隔，如：force|dodge|parry)：","XKX Robot By Michen",skills_xue)
	if learnskill~=nil then skills_xue=learnskill end
end
function infobtn.potuseC()
	if usepot=="none" then return "不消耗"
	elseif usepot=="xue" then return "学习"
	elseif usepot=="lingwu" then return "领悟"
	else return "精要" end
end
function infobtn.potuse()
	if usepot=="none" then usepot="xue"
	elseif usepot=="xue" then usepot="lingwu"
	elseif usepot=="lingwu" then usepot="jingyao"
	else usepot="none" end
	for k,v in pairs(infobtn.button) do
		if v[2]=="infobtn.potuse" then
			local tw=infobtn.win.Bars[k]
			tw:Caption("潜能："..infobtn.potuseC())
			infobtn.win:Update()
			break
		end
	end
end
function infobtn.xuelitC()
	if havegoldxuelit>0 then
		if xuelit>0 then return "优先"
		else return "没钱" end
	else
		if xuelit>0 then return "学习"
		else return "不学" end
	end
end
function infobtn.xuelit()
	if havegoldxuelit==1 then
		if xuelit==0 then
			havegoldxuelit=0
			xuelit=1
		else
			havegoldxuelit=1
			xuelit=0
		end
	else
		if xuelit==0 then
			havegoldxuelit=1
			xuelit=1
		else
			havegoldxuelit=0
			xuelit=0
		end
	end
	for k,v in pairs(infobtn.button) do
		if v[2]=="infobtn.xuelit" then
			local tw=infobtn.win.Bars[k]
			tw:Caption("读书写字"..infobtn.xuelitC())
			infobtn.win:Update()
			break
		end
	end
end
function infobtn.xuefirstC()
	if xuefirst>0 then return "优先" else return "低于" end
end
function infobtn.xuefirst()
	if xuefirst==0 then xuefirst=1 else xuefirst=0 end
	for k,v in pairs(infobtn.button) do
		if v[2]=="infobtn.xuefirst" then
			local tw=infobtn.win.Bars[k]
			tw:Caption("学习"..infobtn.xuefirstC().."经验")
			infobtn.win:Update()
			break
		end
	end
end
function infobtn.lingwuatC()
	if lingwuat=="menpai" then return "门派" else return "少林" end
end
function infobtn.lingwuat()
	if lingwuat=="menpai" then lingwuat="shaolin" else lingwuat="menpai" end
	for k,v in pairs(infobtn.button) do
		if v[2]=="infobtn.lingwuat" then
			local tw=infobtn.win.Bars[k]
			tw:Caption("领悟地点"..infobtn.lingwuatC())
			infobtn.win:Update()
			break
		end
	end
end
infobtn.button={
	{"登陆设置","infobtn.accountconfig","帐号登陆信息等基本配置",},
	{"开始工作","startjob","开始挂机！",},
	{"设定统计时点","infobtn.resetstatus","重新开始统计",},
	{"停止所有工作","alias.initialize_trigger","停止所有工作",},
	{"防发呆".._isopen(setting_resetidle),"infobtn.idle","开启或关闭防发呆功能",},
	{"钻狗洞".._isopen(set_GbSecretWay),"infobtn.set_GbSecretWay","是否钻狗洞",},
	{"FJ模块".._isopen(workflow.fj),"infobtn.fj","开启或关闭FJ模块",},
	{"MP模块".._isopen(workflow.mp),"infobtn.mp","开启或关闭MP模块",},
	{"XF模块".._isopen(workflow.xf),"infobtn.xf","开启或关闭XF模块",},
	{"CM模块".._isopen(workflow.cm),"infobtn.cm","开启或关闭CM模块",},
	{"FTB模块".._isopen(workflow.ftb),"infobtn.ftb","开启或关闭FTB模块",},
	{"技能设置","infobtn.skillconfig","设置学习和领悟的技能清单",},
	{"工作内力"..tostring(set_neili_job).."%","infobtn.set_neili_job","内力达到最大内力的"..tostring(set_neili_job).."%时开始工作",},
	{"全局内力"..tostring(set_neili_global).."%","infobtn.set_neili_global","内力达到最大内力的"..tostring(set_neili_global).."%时开始工作",},
	{"潜能："..infobtn.potuseC(),"infobtn.potuse","设置潜能的用途",},
	{"读书写字"..infobtn.xuelitC(),"infobtn.xuelit","设置是否学习读书写字",},
	{"学习"..infobtn.xuefirstC().."经验","infobtn.xuefirst","设置是否学习是否优先",},
	{"领悟地点"..infobtn.lingwuatC(),"infobtn.lingwuat","设置领悟的地点",},
}
function infobtn.update()
	infobtn.win = infobtn.win or InfoBox:New("config")
	infobtn.win.columns=2
	infobtn.win:WindowPosition(infobtn.win.windowPositions.NE)
	infobtn.win.Bar.barStyle = InfoBox.barStyles.flat
	for k,v in pairs(infobtn.button) do
		local tw = infobtn.win.Bars[k] or infobtn.win:AddBar(v[1])
		tw.barStyle = InfoBox.barStyles.flat
		tw.button={mouseDown=v[2],tooltipText=v[3],cursor=1}
	end
	infobtn.win:Update()
end

function infobtn.close()
	infobtn.win:CloseWindow()
end
infobtn.update()
