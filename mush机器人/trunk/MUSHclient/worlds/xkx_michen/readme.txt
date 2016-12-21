--近期TODO
	模块化的最后两个模块：使者处理(这个简单，加个触发，如果使者来了，stopall，调用打架模块处理掉使者，然后继续工作就行)，重连后继续工作部份(跟使者一样，开始工作的时候在MCL变量里面记录一下目前跑的是哪个RBT，然后继续这个就行)
	关于发呆的处理，反正就是不想用KISS里面那种方式来防发呆，MUSH里面应该有更好的方式，有空的时候再考虑考虑，反正MC其实只要把所有的情况都考虑到，是完全不可能发呆的。。。
	需要写一下获得GOLD、获得相应武器、装备的模块



首先声明下，这个不是完整RBT，只是一个半成品，但是如果你当他是一个框架，在这个基础上开发自己的RBT，那是绝对的够了，而且熟悉之后，你会发现这玩意比ZMUD好用不要太多

------------------------------------------------------
如果有修改代码，或者新增模块，请发一份给我，谢谢
xmichen@gmail.com
------------------------------------------------------


目前RBT你能做啥？
除了按钮里面有的东西之外，就只有一个goto命令了，用法如下：
	print("命令格式： goto [房间名|房间ID] [区域名]")
	print("例： ")	
	print("goto 985")
	print("goto 武庙 ")
	print("goto 中央广场 扬州")


使用说明：
把xkxMAP.db放在mushclient根目录下
xkx_robot和xkx_frame和mods目录放在worlds目录下

运行mushclient，随便新建一个连接到MUD
配置Game->Configure->Scripting，
	1.scripting选Lua
	2.点Browse，选择xkx.robot.lua文件
	3.点确定

好了，可以用了：）

开始的时候点一下   登陆设置，技能设置，PFM设置，分别进行配置







各文件说明
xkx_robot		-- 通用的一些配置的东东放这边
xkx_frame		-- 加载各模块

mods目录：
system			-- 系统模块，定义一些常用的函数
status			-- 状态采集模块，抓取HP,SCORE等等信息
rest			-- dazuo,lingwu,dubook,xuexi,lianxi等等模块(还有很多是PKUXKX带的，我还没删掉)
quest_xx_job		-- XX新手抓虫任务，基本功能实现之后发现这个任务做了基本没意义，就没搞了
quest_xx_btjob		-- 其实就是BT咬家丁RBT，随便做了一下，没优化，连ASK 怪蛇都没处理，正常是要单独的把咬NPC部份做个模块的，不过改改也简单
quest_xkd		-- 侠客岛机器人
quest_qzwd		-- qzwd机器人，有一些丹凤坪之类的特殊房间没有去处理，做着玩的
quest_lingwu		-- 最早写的gumu caimi之后去练功室读墙的，可以删了，没啥用
quest_gumu_love		-- GUMU哭声JOB模块
quest_gumu_caimi	-- GUMU采蜜JOB模块
quest_gumu		-- 整合上面两个模块，的GUMU机器人，这三个文件可以演示模块化的方便性，把任务，学习等等的部份都做成模块，在整合机器人部份，依照自己的情况，做简单判断，去调用不同模块就行
quest_gb_sx		-- 原来想做送信的模块，后来没做
quest_clb		-- 长乐帮，只做了收保护费，其它懒的做了，CLB现在就是垃圾，没什么用
quest			-- 任务模块，所有quest打头的文件，都在这里面注册
michen_walker		-- 自动行走模块
michen_blocker		-- 自动行走里面要调用的特殊ALIAS处理模块(这部份还有两个TAOHUA的ALIAS没做，懒的做了，一般没用)
michen_stat		-- 这个模块以后用来记录各种状态触发，做了点例子在里面
michen_info		-- 方便用户使用的按钮
michen_fight		-- 打架模块，目前只做了杀人和打晕的，对PFM要手工设置这点还不太满意，太久没玩XKX了，不知道各门派情况，手工设置是目前最通用了。。。
hook			-- 不用管
endfunction		-- 不用管