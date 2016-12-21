---------------------------------------------------------------------------
-- File name   : endfunction.mod
-- Description : 此文件为《一个脚本框架》文件的底部调用函数模块。
--
-- Author: 胡小子littleknife (applehoo@126.com)
-- Version:	2011.12.06.2215
---------------------------------------------------------------------------
systemtri={system=true,status=true,fight=true,allways_on=true,stat=true}----基本无用--->测试与2011.12.06.2210
----应用此触发器初始化触发条件:
----若需要载入系统前完成则应：
----1、相应模块加载于本模块之前。
----2、应用本模块addtri加载的触发，无法通过这个列表初始化。必须自行激发EnableTriggerGroup
inittri=function()

	print("Loading Endfunction ::>>初始化触发器<<::")
	system.update()

	local tri=GetTriggerList()
------------------------------------------------------------------------
	if tri~=nil then
		for k,v in ipairs(tri) do

			gpname=GetTriggerInfo(v,26)
			if string.sub(gpname,0,2)=="q_" then
				deltri(v)
			end
			------------------------------------
			if systemtri[GetTriggerInfo(v,26)]==true then
				----print(v)
				EnableTrigger(v,true)
			else
				EnableTrigger(v,false)
				----print("close trigger::",v)
			end
		end
	end
------------------------------------------------------------------------

	local ali=GetAliasList()
	if ali~=nil then
		for k,v in ipairs(ali) do

			alname=GetAliasInfo(v,16)
			if string.sub(alname,0,2)=="q_" then
				delali(v)
			end
		end
	end

	local tm=GetTimerList()
	---print(tm)
	if tm~=nil then
		for k,v in ipairs(tm) do

			if string.sub(v,0,2)=="q_" then
				DeleteTimer(v)
			end
		end
	end

------------------------------------------------------------------------
end

inittri()

