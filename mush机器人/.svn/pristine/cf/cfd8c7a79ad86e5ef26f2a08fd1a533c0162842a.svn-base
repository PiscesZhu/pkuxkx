---------------------------------------------------------------------------
-- File name   : quest_gb_sx.lua
-- Description : gb送信任务
-- Author: Michen (xmichen@gmail.com)
-- Version:	2014.05.05
---------------------------------------------------------------------------
		
print("quest:XKD Loading ok!")

qgbsx={}

function qgbsx:finish()
end
function qgbsx:fail()
end

qgbsx.end_ok=function()
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
	qgbsx.finish()
end
qgbsx.end_fail=function()
	unhookall()
	DiscardQueue()
	DeleteTemporaryTimers()
	qgbsx.fail()
end

function do_gbsx(sx_ok,sx_fail)
	if sx_ok~=nil then
		qgbsx.finish=function()
			sx_ok()
		end
	else qgbsx.finish=nil end
	if sx_fail~=nil then
		qgbsx.finish=function()
			sx_fail()
		end
	else qgbsx.fail=nil end
	qgbsx.start()
end

function qgbsx.start()
	qgbsx.askjob()
end

function qgbsx.askjob()
	local msg_tri={
		"鲁有脚对你说道：你把这封密函交给(.+)，务必亲自送到！",
		
		"这里没有 lu youjiao 这个人。",
		"鲁有脚说道：你还没完成我交待的工作，怎麽又来问我？",
		"鲁有脚说道：我现在没要事让你去干，待会儿你再来吧。",
		
		"你忙着呢，你等会儿在问话吧。",
		"对方正忙着呢，你等会儿在问话吧。",
		"但是很显然的，他现在的状况没有办法给你任何答覆。",
		"噢！你那麽快便回来啦？",
		"噢！你回来啦？",
	}

	local _ftri=linktri(msg_tri)
	run("ask lu youjiao about job")
	wait.make(function()
		local l,w=wait.regexp(_ftri,5)
		if l==nil then
			--wait.time(1)
			qgbsx.askjob()
			return
		end
		if findstring(l,msg_tri[2]) then
			tprint(w)
		end
		if findstring(l,msg_tri[2],msg_tri[3],msg_tri[4]) then
			print("任务失败，结束任务模块。")
			qgbsx.end_fail()
			return
		end
		if findstring(l,msg_tri[5],msg_tri[6],msg_tri[7],msg_tri[8],msg_tri[9]) then
			run("dazuo 20")
			busytest(qgbsx.askjob())
			return
		end
	end)
end
