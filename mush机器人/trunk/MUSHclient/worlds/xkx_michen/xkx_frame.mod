---------------------------------------------------------------------------
-- File name   : xkx_frame.lua
-- Description : 此文件为《一个脚本框架》文件的总框架调用文件。
--
-- Author: 胡小子littleknife (applehoo@126.com)
-- Version:	2012.01.05.1221
---------------------------------------------------------------------------
print("----**********************************************************----")
print("::>>框架模块载入Start<<::")

loadlist={

	"system.mod",
	"hook.mod",
	----------------------------
	"status.mod",
	"rest.mod",

	"quest.mod",
	
	"michen_stat.mod",
	"michen_blocker.mod",
	"michen_walker.mod",
	"michen_fight.mod",
	
	"michen_info.mod",
	
	"endfunction.mod",

  }
  for i=1,#loadlist do
      loadmod(loadlist[i])
  end

print("::>>框架模块载入Over<<::")
print("----**********************************************************----")

