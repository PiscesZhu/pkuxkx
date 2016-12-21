require "InfoBox"
charinfo={
	--win=nil,
}
charinfo.win = charinfo.win or InfoBox:New("charinfo")
charinfo.win.columns=1
charinfo.win:WindowPosition(charinfo.win.windowPositions.SE)
charinfo.win.Bar.barStyle = InfoBox.barStyles.textOnly
function charinfo.update()
	local _tb
	_tb={
	{"信息："..tostring(me.charid).."  门派："..tostring(me.menpai).."  房间："..tostring(roomname).." "..tostring(roomno_now),},
	--{"精神："..tostring(hp.jing).."/"..tostring(hp.maxjing).."  精力："..tostring(hp.jingli).."/"..tostring(hp.maxjingli),},
	--{"气血："..tostring(hp.qi).."/"..tostring(hp.maxqi).."  内力："..tostring(hp.neili).."/"..tostring(hp.maxneili),},
	{"任务："..tostring(workflow.nowjob).."  地点："..tostring(a).."  敌人："..tostring(killname),},
	}
	for k,v in pairs(_tb) do
	local tw = charinfo.win.Bars[k] or charinfo.win:AddBar(v[1])
		tw.barStyle = InfoBox.barStyles.textOnly
	end
	charinfo.win:Update()
end
charinfo.update()