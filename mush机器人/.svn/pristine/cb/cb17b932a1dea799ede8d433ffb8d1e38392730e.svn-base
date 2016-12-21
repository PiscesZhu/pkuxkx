-- 看不懂的话千万别乱改，谢谢罗~

------------------------------------------------------------------------------------
-- jifa
------------------------------------------------------------------------------------
function alias.jfxx()
	run("jifa dodge zhaixinggong;jifa stroke duoming-bi;jifa parry duoming-bi;jifa claw sanyin-zhua;jifa strike chousui-zhang;bei none;bei chousui-zhang sanyin-zhua")
end
function alias.jfwd()
	run("jifa dodge tiyunzong;jifa parry taiji-jian;jifa sword taiji-jian;jifa cuff taiji-quan;jifa strike mian-zhang;bei none;bei taiji-quan;bei mian-zhang")
end
function alias.jfth()
	run("jifa dodge luoying-shenfa;jifa parry luoying-shenjian;jifa sword yuxiao-jian;jifa strike luoying-shenjian;jifa kick xuanfeng-saoye;jifa hand lanhua-fuxue;jifa finger tanzhi-shentong;bei none;bei xuanfeng-saoye luoying-shenjian")
end
function alias.jfsl()
	run("jifa dodge shaolin-shenfa;jifa blade ranmu-dao;jifa cuff jingang-quan;jifa finger yizhi-chan;jifa parry ranmu-dao;jifa strike banruo-zhang;jifa sword damo-jian;jifa whip heilong-bianfa;jifa claw longzhua-gong;jifa club weituo-gun;jifa hand fengyun-shou;jifa staff wuchang-zhang;bei none;bei banruo-zhang yizhi-chan")
end
function alias.jfqz()
	run("jifa dodge jinyangong;jifa parry quanzhen-jian;jifa sword quanzhen-jian;jifa strike sanhua-juding;jifa staff jinhua-zhang;jifa hand nilin-shou")
	if skillslist["kongming-quan"]~=nil and skillslist["kongming-quan"]["lvl"]>0 and findstring(fjpfm,"perform kong","perform ming") then
		run("jifa cuff kongming-quan;jifa parry sanhua-juding;bei none;bei kongming-quan")
	else
		run("jifa cuff chunyang-quan;bei none;bei chunyang-quan;bei sanhua-juding")
	end
end
function alias.jfhs()
	run("jifa cuff pishi-poyu;jifa blade liangyi-dao")
	if me.master=="风清扬" then
		run("jifa dodge dugu-jiujian;jifa parry dugu-jiujian;jifa sword dugu-jiujian;jifa strike dugu-jiujian;jifa staff dugu-jiujian")
	else
		run("jifa dodge huashan-shenfa;jifa parry huashan-jianfa;jifa blade liangyi-dao;jifa sword huashan-jianfa;jifa strike hunyuan-zhang;jifa staff jinhua-zhang")
	end
	run("bei none;bei hunyuan-zhang;bei pishi-poyu")
end
function alias.jfhbmz()
	run("jifa strike hanbing-mianzhang;jifa parry hanbing-mianzhang;jifa dodge guifu-fei;bei none;bei hanbing-mianzhang")
end
function alias.jfgb()
	run("jifa strike xianglong-zhang;jifa dodge xiaoyaoyou")
	if fjweapon=="stick" then run("jifa parry dagou-bang") else run("jifa parry xianglong-zhang") end
	run("jifa cuff xiaoyaoyou;jifa stick dagou-bang;jifa hand jilin-shou;bei none;bei xianglong-zhang;bei xiaoyaoyou")
end
function alias.jfdl()
	if jifa.forcename~="xuanyinzhenqi" then
		run("jifa dodge duanshi-shenfa;jifa parry yiyang-zhi;jifa finger yiyang-zhi;jifa strike qingyan-zhang;jifa cuff jinyu-quan;jifa staff duanjia-jian;jifa sword duanjia-jian")
		if findstring(killpfm,"perform piaomiao") then run("bei none;bei qingyan-zhang;bei jinyu-quan") else run("bei none;bei yiyang-zhi") end
	end
end
function alias.jfbt()
	run("jifa dodge chanchubu;jifa staff lingshe-zhang;jifa parry lingshe-zhang;jifa strike shentuo-zhang;jifa sword pixie-jian;bei none;bei shentuo-zhang;bei lingshe-quan")
end
function alias.jfgm()
	run("jifa dodge gumu-shenfa;jifa cuff meinu-quan;jifa whip yinsuo-jinling;jifa sword yunu-jianfa;jifa parry meinu-quan;bei none;bei meinu-quan")
end
function alias.jfxs()
	run("jifa parry huoyan-dao;jifa hammer riyue-lun;jifa dodge shenkongxing;jifa staff jingang-chu;jifa strike huoyan-dao;jifa hand dashou-yin;bei none;bei huoyan-dao")
end
function alias.jfem()
	run("jifa sword emei-jian;jifa parry emei-jian;jifa blade yanxing-dao;jifa strike jinding-zhang;jifa claw jiuyin-zhao;jifa finger qianzhu-wandu;jifa finger tiangang-zhi;jifa dodge zhutian-bu;bei none;bei jinding-zhang;bei tiangang-zhi")
end
function alias.jfxx()
	run("jifa dodge zhaixinggong;jifa stroke duoming-bi;jifa parry duoming-bi;jifa claw sanyin-zhua;jifa strike chousui-zhang;bei none;bei chousui-zhang sanyin-zhua")
end
------------------------------------------------------------------------------------
-- startworkflow 工作流程
------------------------------------------------------------------------------------
function alias.startworkflow()
	local _f
	-- 选择流程开始
	alias.setmpLimitedMark()
	if reEnableSkills>0 then
		reEnableSkills=0
		if jifa.forcename=="xuanyinzhenqi" then alias.jfhbmz() else Execute("/alias.jf"..me.menpai.."()") end
	end
	if stat.haveyyz>0 then alias.starttongmai()
	elseif stat.havedu>0 then alias.startliaoshang()
	else
		if workflow.nowjob=="death" then workflow.nowjob="mp" end
		if workflow.nowjob=="lzjob" then workflow.nowjob="mp" end
		if cmd.nums<cmd.setnums then Execute("/alias.startworkflow_"..me.menpai.."()")
		else
			wait.make(function()
				_f=function() Execute("/alias.startworkflow_"..me.menpai.."()") end
				wait.time(1);_f()
			end)
		end
	end
	run("jiajin basic;jiali 0;yield no")
end
function alias.startworkflow_th()
	-- #if @debug {#say 桃花流程开始，历史任务@workflow.nowjob}
	havedo=1
	if havefj>0 then alias.startfj()
	elseif havedo==1 and hp.thpot>math.abs(hp.maxpot*10-10) then
		run("halt")
		havefj=0
		run("ask lu about 要事在身")
		alias.startxue()
		havedo="xue"
	elseif havedo==1 then
		if workflow.mp>0 and mpjoblimited==0 then
			alias.startmp()
			havedo="mp"
		end
	end
end
function alias.startworkflow_gb()
	-- 丐帮流程开始，历史任务@workflow.nowjob
	if workflow.nowjob=="fj" then alias.startworkflow_gb_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_gb_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_gb_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_gb_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_gb_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_gb_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_gb_xue() end
end
function alias.startworkflow_gb_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_gb_fj()
	-- print("startworkflow_gb_fj")
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm() else alias.startxue() end
	else
		if xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
		else
			if workflow.mp>0 then
				gold.num=0
				if gold.roomNo>0 then alias.startgbresume() else alias.startmp() end
			else
				if workflow.cm>0 then alias.startcm() else alias.startxue() end
			end
		end
	end
end
function alias.startworkflow_gb_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else startfjclose() end
	else
		if mpJobLimited>0 then
			if workflow.cm>0 then alias.startcm()
			else
				if workflow.ftb>0 then alias.startftb()
				else
					if skillsfull>0 then
						alias.dz("addneili")
						resumejob=""
					else
						if workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
						else
							alias.dz("addneili")
							resumejob=""
						end
					end
				end
			end
		else
			if workflow.mp>0 then
				gold.num=0
				if gold.roomNo>0 then alias.startgbresume() else alias.startmp() end
			else
				if workflow.cm>0 then alias.startcm()
				else
					if workflow.ftb>0 then alias.startftb()
					else
						alias.dz("addneili")
						resumejob=""
					end
				end
			end
		end
	end
end
function alias.startworkflow_gb_mp()
	-- print("startworkflow_gb_mp")
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	else
		if xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
		else
			if mpJobLimited>0 then
				if workflow.cm>0 then alias.startcm()
				else
					if workflow.ftb>0 then alias.startftb() else alias.startxue() end
				end
			else
				if gold.num==nil then gold.num=0 end
				if gold.num<gold.setnum then
					if gold.roomNo>0 then alias.startgbresume() else alias.startmp() end
				else
					if workflow.cm>0 then alias.startcm() else alias.startxue() end
				end
			end
		end
	end
end
function alias.startworkflow_gb_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb() else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_gb_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then
		gold.num=0
		if gold.roomNo>0 then alias.startgbresume() else alias.startmp() end
	else alias.startftb() end
end
function alias.startworkflow_gb_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then
			gold.num=0
			if gold.roomNo>0 then alias.startgbresume() else alias.startmp() end
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_dl()
	-- 大理流程开始，历史任务@workflow.nowjob
	if workflow.nowjob=="fj" then alias.startworkflow_dl_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_dl_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_dl_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_dl_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_dl_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_dl_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_dl_xue() end
end
function alias.startworkflow_dl_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_dl_fj()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then alias.startxinfa()
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startxinfa() end
end
function alias.startworkflow_dl_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_dl_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	elseif tonumber(roomno_now)==tonumber(me.menpaiJobStart) then alias.flytonpc(dl.jobnpc)
	else alias.startmp() end
end
function alias.startworkflow_dl_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_dl_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_dl_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_hs()
	-- 华山流程开始，历史任务@workflow.nowjob
	if workflow.nowjob=="fj" then
		if workflow.qzwd>0 then alias.startqzwd()
		else alias.startxinfa() end
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_hs_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_hs_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_hs_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_hs_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_hs_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_hs_xue() end
end
function alias.startworkflow_hs_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_hs_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 then alias.startxue()
	elseif mpJobLimited>0 then
		if have.ling<mmr.targetNum then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_hs_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xinfa()>0 then alias.startxinfa()
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif mpJobLimited>0 then
		if tonumber(have.ling)<tonumber(mmr.targetNum) then
			if findstrlist2(roomno_now,utils.split(mmr.searchroomno,"|")) and isopen("mp_hs_pre") then
				run("set searchmmr=yes")
			else alias.startmp() end
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if findstrlist2(roomno_now,utils.split(mmr.searchroomno,"|")) and isopen("mp_hs_pre") then
			run("set searchmmr=yes")
		else alias.startmp() end
	end
end
function alias.startworkflow_hs_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xinfa()>0 then alias.startxinfa()
	elseif xuefirst>0 then alias.startxue()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_hs_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_hs_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if have.ling<mmr.targetNum then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob="startmp"
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob="startmp"
		end
	end
end
function alias.startworkflow_qz()
	-- #if @debug {#say 全真流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="fj" then alias.startworkflow_qz_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_qz_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_qz_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_qz_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_qz_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_qz_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_qz_xue() end
end
function alias.startworkflow_qz_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_qz_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_qz_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
		elseif bdz.askqiu==0 then alias.startmp()
		elseif isopen("mp_qz_pre") then
			closeclass("mp_qz_pre")
			openclass("mp_qz_start")
			alias.flytoid(723)
		else alias.startmp() end
	end
end
function alias.startworkflow_qz_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_qz_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_qz_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_qz_fj()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then alias.startxinfa()
	elseif xuefirst>0 then alias.startxue()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startxinfa() end
end
function alias.startworkflow_wd()
	-- #if @debug {#say 武当流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="fj" then alias.startworkflow_wd_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_wd_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_wd_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_wd_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_wd_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_wd_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_wd_xue() end
end
function alias.startworkflow_wd_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_wd_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	else
		if workflow.mp>0 then
			alias.dz("addneili")
			resumejob=""
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_wd_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if me.shen>hp.exp then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_wd_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	else alias.startftb() end
end
function alias.startworkflow_wd_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_wd_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 and me.shen>hp.exp then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_wd_fj()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then
		if xuefirst>0 then alias.startxue()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp() 
		elseif xuefirst>0 then alias.startxue()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_sl()
	-- #if @debug {#say 少林流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="fj" then alias.startworkflow_sl_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_sl_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_sl_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_sl_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_sl_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_sl_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_sl_xue() end
end
function alias.startworkflow_sl_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_sl_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_sl_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then
		-- sl和em不一样，诵经有时间，所以需要在mp未满的情况下去启动xf模块诵经
		alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if isopen("mp_sl_pre") then run("set searchseng=yes")
		else alias.startmp() end
	end
end
function alias.startworkflow_sl_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_sl_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_sl_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_sl_fj()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then alias.startxinfa()
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startxinfa() end
end
function alias.startworkflow_xs()
	-- #if @debug {#say 雪山流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="fj" then alias.startworkflow_xs_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_xs_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_xs_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_xs_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_xs_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_xs_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_xs_xue() end
end
function alias.startworkflow_xs_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_xs_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_xs_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if tonumber(roomno_now)==tonumber(me.menpaiJobStart) and isopen("mp_xs_pre") then
			if me.suyou~=nil and me.suyou>=49 then alias.flytoid(428) else alias.flytoid(417) end
		else alias.startmp() end
	end
end
function alias.startworkflow_xs_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_xs_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_xs_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_xs_fj()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then alias.startxinfa()
	elseif xuefirst>0 then alias.startxue()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startxinfa() end
end
function alias.startworkflow_em()
	-- #if @debug {#say 峨嵋流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="fj" then alias.startworkflow_em_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_em_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_em_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_em_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_em_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_em_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_em_xue() end
end
function alias.startworkflow_em_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_em_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			if skillsfull>0 then
				alias.dz("addneili")
				resumejob=""
			elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
			else
				alias.dz("addneili")
				resumejob=""
			end
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_em_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if tonumber(roomno_now)==tonumber(me.menpaiJobStart) and isopen("mp_em_pre") then
			run("get fuling from yaodai")
			run("set searchnpc=yes")
		else alias.startmp() end
	end
end
function alias.startworkflow_em_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_em_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		else alias.startxue() end
	end
end
function alias.startworkflow_em_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_em_fj()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then
		if xuefirst and hp.pot>=hp.maxpot then alias.startxue()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if xuefirst>0 then alias.startxue()
		elseif workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_gm()
	-- #if @debug {#say 古墓流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="mp" then alias.startworkflow_gm_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_gm_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_gm_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_gm_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_gm_xue() end
end
function alias.startworkflow_gm_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_gm_xue()
	if mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_gm_mp()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif do_gm_job3>0 and hp.exp>500000 and (os.time()-gmjob3time)>500 then
		alias.flytoid(607)
		openclass("mp_gm_job3")
	elseif xuefirst>0 then alias.startxue()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else alias.startmp() end
end
function alias.startworkflow_gm_ftb()
	if xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_gm_cm()
	if mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_bt()
	-- #if @debug {#say 白驼流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="fj" then
		if workflow.qzwd>0 then alias.startqzwd()
		else alias.startxinfa() end
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_bt_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_bt_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_bt_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_bt_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_bt_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_bt_xue() end
end
function alias.startworkflow_bt_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_bt_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_bt_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if isopen("mp_bt_pre") then alias.dz(set_neili)
		else alias.startmp() end
	end
end
function alias.startworkflow_bt_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_bt_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if xuefirst>0 then alias.startxue()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if xuefirst>0 then alias.startxue()
		elseif workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_bt_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_xx()
	-- #if @debug {#say 星宿流程开始，历史任务@workflow.nowjob}
	if workflow.nowjob=="fj" then alias.startworkflow_xx_fj()
	elseif workflow.nowjob=="xinfa" then alias.startworkflow_xx_xf()
	elseif workflow.nowjob=="mp" then alias.startworkflow_xx_mp()
	elseif workflow.nowjob=="ftb" then alias.startworkflow_xx_ftb()
	elseif workflow.nowjob=="cm" then alias.startworkflow_xx_cm()
	elseif workflow.nowjob=="qzwd" then alias.startworkflow_xx_qzwd()
	elseif workflow.nowjob=="xue" then alias.startworkflow_xx_xue() end
end
function alias.startworkflow_xx_qzwd()
	if havefj>0 then
		if workflow.fj>0 then
			alias.close_qzwd()
			alias.startfj()
		else alias.startfjclose() end
	else alias.startqzwd() end
end
function alias.startworkflow_xx_xue()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else
			alias.dz("addneili")
			resumejob=""
		end
	end
end
function alias.startworkflow_xx_mp()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else alias.startmp() end
end
function alias.startworkflow_xx_ftb()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif xuefirst>0 and hp.pot>=hp.maxpot then alias.startxue()
	elseif workflow.xf>0 and workflow.xinfa()>0 then alias.startxinfa()
	elseif mpJobLimited>0 then alias.startftb()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startftb() end
end
function alias.startworkflow_xx_xf()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.cm>0 then alias.startcm()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.cm>0 then alias.startcm()
		else alias.startxue() end
	end
end
function alias.startworkflow_xx_cm()
	if havefj>0 then
		if workflow.fj>0 then alias.startfj() else alias.startfjclose() end
	elseif mpJobLimited>0 then
		if workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	else
		if workflow.mp>0 then alias.startmp()
		elseif workflow.ftb>0 then alias.startftb()
		else alias.startxue() end
	end
end
function alias.startworkflow_xx_fj()
	if workflow.qzwd>0 then alias.startqzwd()
	elseif mpJobLimited>0 then alias.startxinfa()
	elseif xuefirst>0 then alias.startxue()
	elseif workflow.mp>0 then alias.startmp()
	else alias.startxinfa() end
end
