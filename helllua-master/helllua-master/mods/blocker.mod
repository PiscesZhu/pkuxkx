blocker={}
blocker["虚通"]={id="xu tong",exp=50000}
blocker["虚明"]={id="xu ming",exp=50000}
blocker["虚通伸手"]={id="xu tong",exp=50000}
blocker["虚明伸手"]={id="xu ming",exp=50000}
blocker["校尉"]={id="xiao wei",exp=50000}
blocker["采花子"]={id="caihua zi",exp=0}
blocker["衙役"]={id="ya yi",exp=50000}
blocker["摘星子"]={id="zhaixing zi",exp=800000}
blocker["出尘子伸手"]={id="wuchen zi",exp=-1}
blocker["劳德诺"]={id="lao denuo",exp=-1}
blocker["鳌府侍卫"]={id="shi wei",exp=50000}
blocker["鳌拜"]={id="ao bai",exp=200000}
blocker["心砚"]={id="xin yan",exp=790000}
blocker["周绮"]={id="zhou yi",exp=790000}
blocker["蒋四根"]={id="jiang sigen",exp=790000}
blocker["石双英"]={id="shi shuangying",exp=790000}
blocker["卫春华"]={id="wei chunhua",exp=790000}
blocker["杨成协"]={id="yang chengxie",exp=790000}
blocker["徐天宏长刀一摆，"]={id="xu tianhong",exp=790000}
blocker["常伯志飞身"]={id="chang bozhi",exp=790000}
blocker["常赫志"]={id="chang hezhi",exp=790000}
blocker["安健刚一把"]={id="an jiangang",exp=790000}
blocker["孟健雄一把"]={id="meng jianxiong",exp=790000}
blocker["赵半山笑嘻嘻地"]={id="zhao banshan",exp=790000}
blocker["周仲英"]={id="zhou zhongying",exp=790000}
blocker["陆菲青"]={id="lu feiqing",exp=790000}
blocker["无尘"]={id="wuchen daozhang",exp=1190000}



block_onnpc=function(n,l,w)
	print(w[2])
--	if not(hashook(hooks.steptimeout)) then return end
	if not(hashook(hooks.step)) then return end
	if blocker[w[2]]==nil then return end
	if blocker[w[2]].exp>getnum(me.hp.exp) or blocker[w[2]].exp==-1 then
		if not hashook(hooks.steptimeout) then
			delay(1,walkagain)
		end
		return
	end
	if GetVariable("pfm")==nil or GetVariable("pfm")=="" then return end
	fightpreper()
	do_kill(blocker[w[2]].id,block_step,block_step)
end
block_step=function()
	run(walking.step)
end

walkagain=function()
	eatdrink()
	run(walking["step"])
end
