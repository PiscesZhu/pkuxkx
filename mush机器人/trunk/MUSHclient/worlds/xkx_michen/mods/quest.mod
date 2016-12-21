---------------------------------------------------------------------------
-- File name   : quest.mod
-- Description : 此文件为《一个脚本框架》文件的总任务框架注册文件。
--
-- Author: 胡小子littleknife (applehoo@126.com)
-- Version:	2012.01.05.1329
-- Usage: 用于各个quest_xxx.mod文件的注册以及设定。
--[[
----如：编辑了一个任务模块，如quest_job.mod
	----应在这里注册，同时设定该quest的相关配置，总配置文件调用它。
	----初始设定为：开始、暂停、返回、继续、配置文件等快捷按钮。
	----cfg为每个任务的特殊配置设定。
--]]
---------------------------------------------------------------------------
print("任务模块载入Start....")
require "tprint"
--[[
----usage:
-->>qlist:use(qlist_name)
local q=qlist.new()
	q:use("hubiao")
	print(q.name)
	print(q.filename)
	print(q.startcmd)
	print(q.stopcmd)
	print(q.backcmd)
	print(q.continuecmd)

--]]
quest={}
qlist={
	new=function()
     local ql={}
	 setmetatable(ql,{__index=qlist})
	 ql.qlist_table={}
	 return ql
   end,
	qlist_table={},
}
-------------------------------------------------------------------------
-------------------------------------------------------------------------
function qlist:register()
		-----不同的身份所对应的autoperform
	local _qlist={}
	----***************************************
	_qlist={}
	_qlist.name="lingwu"
	_qlist.cnname="领悟"
	_qlist.filename="quest_lingwu.lua"
	_qlist.startcmd="#lingwu"
	_qlist.stopcmd="#lwstop"
	_qlist.backcmd=""
	_qlist.continuecmd="#lwgoon"
	_qlist.cfg={}
	table.insert(self.qlist_table,_qlist)
	----***************************************
	_qlist={}
	_qlist.name="qgm"
	_qlist.cnname="古墓全自动任务"
	_qlist.filename="quest_gumu.mod"
	_qlist.startcmd=""
	_qlist.stopcmd=""
	_qlist.backcmd=""
	_qlist.continuecmd=""
	_qlist.cfg={}
	table.insert(self.qlist_table,_qlist)
	----***************************************
	_qlist={}
	_qlist.name="gmlove"
	_qlist.cnname="古墓帮助妇女任务"
	_qlist.filename="quest_gumu_love.lua"
	_qlist.startcmd="#gmlove"
	_qlist.stopcmd="#gmlovestop"
	_qlist.backcmd=""
	_qlist.continuecmd="#gmlovegoon"
	_qlist.cfg={}
	table.insert(self.qlist_table,_qlist)
	----***************************************
	_qlist={}
	_qlist.name="gmcaimi"
	_qlist.cnname="古墓采蜜任务"
	_qlist.filename="quest_gumu_caimi.lua"
	_qlist.startcmd="#gmcaimi"
	_qlist.stopcmd="#gmcaimistop"
	_qlist.backcmd=""
	_qlist.continuecmd="#gmcaimigoon"
	_qlist.cfg={}
	table.insert(self.qlist_table,_qlist)
	----***************************************
	_qlist={}
	_qlist.name="qxkd"
	_qlist.cnname="侠客岛全自动"
	_qlist.filename="quest_xkd.lua"
	_qlist.startcmd="#xkdstart"
	_qlist.stopcmd="#xkdstop"
	_qlist.backcmd=""
	_qlist.continuecmd=""
	_qlist.cfg={}
	table.insert(self.qlist_table,_qlist)
	----***************************************
	_qlist={}
	_qlist.name="qxxmp"
	_qlist.cnname="星宿门派任务"
	_qlist.filename="quest_xx_job.lua"
	_qlist.startcmd="#xxmpstart"
	_qlist.stopcmd="#xxmpstop"
	_qlist.backcmd=""
	_qlist.continuecmd=""
	_qlist.cfg={}
	table.insert(self.qlist_table,_qlist)
	----***************************************
	_qlist={}
	_qlist.name="qclb"
	_qlist.cnname="长乐帮任务"
	_qlist.filename="quest_clb.lua"
	_qlist.startcmd="#clbstart"
	_qlist.stopcmd="#clbstop"
	_qlist.backcmd=""
	_qlist.continuecmd=""
	_qlist.cfg={}
	table.insert(self.qlist_table,_qlist)
	----***************************************
	_qlist={}
	_qlist.name="qgbsx"
	_qlist.cnname="丐帮送信任务"
	_qlist.filename="quest_gb_sx.lua"
	_qlist.startcmd="#gbsxstart"
	_qlist.stopcmd="#gbsxstop"
	_qlist.backcmd=""
	_qlist.continuecmd=""
	_qlist.cfg={}
	table.insert(self.qlist_table,_qlist)
	----***************************************
	_qlist={}
	_qlist.name="qqzwd"
	_qlist.cnname="千蛛万毒手"
	_qlist.filename="quest_qzwd.lua"
	_qlist.startcmd=""
	_qlist.stopcmd=""
	_qlist.backcmd=""
	_qlist.continuecmd=""
	_qlist.cfg={}
	table.insert(self.qlist_table,_qlist)
	----***************************************
	_qlist={}
	_qlist.name="qxxbt"
	_qlist.cnname="白驼新手放蛇"
	_qlist.filename="quest_xx_btjob.lua"
	_qlist.startcmd=""
	_qlist.stopcmd=""
	_qlist.backcmd=""
	_qlist.continuecmd=""
	_qlist.cfg={}
	table.insert(self.qlist_table,_qlist)
	----***************************************
end

function qlist:use(qlist_name)
	self:register()
	for _,a in ipairs(self.qlist_table) do
	  if a.name==qlist_name then
		qlist.filename=a.filename
		qlist.startcmd=a.startcmd
		qlist.stopcmd=a.stopcmd
		qlist.backcmd=a.backcmd
		qlist.continuecmd=a.continuecmd
		qlist.cnname=a.cnname
		qlist.cfg=a.cfg
		break
	  end
   end
end

function qlist:fileLoad()
	self:register()

	for _,a in ipairs(self.qlist_table) do
		if a.filename~=nil then
		loadmod(a.filename)
		end
   end
   print("任务模块载入Over....")
end
qlist.listjob=function()
	local q=qlist.new()
	q:register()
	print("-------------------------------")
	for _,a in ipairs(q.qlist_table) do
		for k,v in pairs(a) do
			if v=="" then a[k]="无" end
		end
		print("任务模块名：[",a.cnname,"]")
		print("任务文件名：[",a.filename,"]")
		print("默认开始命令：[",a.startcmd,"]")
		print("默认停止命令：[",a.stopcmd,"]")
		print("默认返回命令：[",a.backcmd,"]")
		print("默认继续命令：[",a.continuecmd,"]")
		print("默认配置：[")
		tprint(a.cfg)
		print("]")
		print("-------------------------------")
	  end
end

qlist:fileLoad()
addali("alias_questlist","#qlist","quest","qlist.listjob")







