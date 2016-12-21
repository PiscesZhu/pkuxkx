mp_wd={}
mp_wd_pre={}
mp_wd_start={}
mp_wd_watch={}

------------------------------------------------------------------------------------
-- mp_wd_pre
------------------------------------------------------------------------------------
function mp_wd_pre.dosomething1(n,l,w)
	if findstring(l,"你目前还没有任何为 dazuo=over 的变量设定。") then
		if not isopen("boat") then
			alias.resetidle()
			alias.startworkflow()
		end
	end
	if findstring(l,"你面对着石梁跌坐静思，良久，似有所悟") then
		alias.checkbusy("mb")
	end
	if findstring(l,"你目前还没有任何为 busyover=mb 的变量设定。") then
		alias.et()
		run("yun regenerate")
		alias.checkexp("mp")
	end
	if findstring(l,"你目前还没有任何为 dealwithitems=over 的变量设定。") then
		alias.flytoid(me.menpaiJobStart)
	end
	if findstring(l,"你目前还没有任何为 checkexpover=mp 的变量设定。") then
		alias.resetidle()
		if hp.neili<(hp.maxneili*set_neili_global/100) then alias.dz(set_neili) else alias.startworkflow() end
	end
	if findstring(l,"数码世界，数字地图，"..tostring(me.menpaiJobStart).."就是这里！") then
		alias.resetidle()
		run("hp;mianbi")
	end
	if findstring(l,"你觉得烦躁不安，难以聚精入定。") then
		run("yun regenerate;mianbi")
	end
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function mp_wd.update()
	local  mp_wd_pre_triggerlist={
	       {name="mp_wd_pre_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    mp_wd_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(mp_wd_pre_triggerlist) do
		addtri(v.name,v.regexp,"mp_wd_pre",v.script,v.line)
	end
	closeclass("mp_wd_pre")
end
mp_wd.update()
