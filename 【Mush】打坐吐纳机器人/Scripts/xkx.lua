function waittime(time)
    local time=tonumber(time)
    DoAfterSpecial(time,'wait',10)
end
--- 公用睡觉
function waitsleep()
    DoAfter(20,'sleep')
    Execute('say 那我等等再睡')
end

--- 打坐吐纳所需变量赋值
function dz_tn_var(zm,sd1,sd2)
SetVariable("zhoumu",zm)
SetVariable("jiangdisudu",sd2)
end

---打坐吐纳主要部分
function dz_tn(jingyan,pot,maxneili,nowneili,maxjingli,nowjingli,maxqi,nowqi,maxshen,nowshen)

mmneili=GetVariable("force_level")*12
mmjingli=GetVariable("force_level")*12
forcebase=GetVariable("force_level")/10+1
Note("内力极值是"..mmneili..",精力极值是"..mmjingli..",内力基数是"..forcebase)

zhoumu=GetVariable("zhoumu")
jiangdisudu=GetVariable("jiangdisudu")
if zhoumu=="休息" then
dzsudu=130
elseif zhoumu=="噩梦" then
dzsudu=100-jiangdisudu
else
dzsudu=100
end
Note("当前效率是"..dzsudu)

if maxneili<=1000 then
	xuyaoqi=math.ceil((maxneili*2-nowneili)/2*100/dzsudu)
else
	xuyaoqi=math.ceil((maxneili*2-nowneili)*100/dzsudu)
end
Note("最大内力是"..maxneili.."当前内力是"..nowneili..",需要气血是"..xuyaoqi)

if maxneili<mmneili then
	if nowqi<=maxqi/10 then
		Execute("yun recover",10)
	else
		keyongqi=math.floor(nowqi-maxqi/10)
		Note("可用气血是"..keyongqi)
		
		if keyongqi<=xuyaoqi then
			local dzqi=math.ceil(math.floor(keyongqi/forcebase)*forcebase)
			Note("打坐气血是"..dzqi)
			Execute("dazuo "..dzqi,10)
		else
			if xuyaoqi<=10 then
				Execute("dazuo 10",10)
			else
				local dzqi=math.ceil(math.floor(xuyaoqi/forcebase)*forcebase)
				if dzqi<=10 then
				Execute("dazuo 10",10)
				else
				Note("打坐气血是"..dzqi)
				Execute("dazuo "..dzqi,10)
				end
			end
		end
	end
else
	if maxjingli<=1000 then
		xuyaoshen=math.ceil((maxjingli*2-nowjingli)/2*100/dzsudu)
	else
		xuyaoshen=math.ceil((maxjingli*2-nowjingli)*100/dzsudu)
	end
	Note("最大精力是"..maxjingli.."当前精力是"..nowjingli..",需要精神是"..xuyaoshen)
	
	if maxjingli<mmjingli then
		if nowshen<=maxshen/10 then
			Execute("yun regenerate",10)
		else
			keyongshen=math.ceil(nowshen-maxshen/10)
			Note("可用精神是"..keyongshen)
			if keyongshen<=xuyaoshen then
				local tnshen=math.ceil(math.floor(keyongshen/forcebase)*forcebase)
				Note("吐纳精神是"..tnshen)
				Execute("tuna "..tnshen,10)
			else
				if xuyaoshen<=10 then
					Execute("tuna 10",10)
				else
					local tnshen=math.ceil(math.floor(xuyaoshen/forcebase)*forcebase)
					if tnshen<=10 then
					Execute("tuna 10",10)
					else
					Note("吐纳精神是"..tnshen)
					Execute("tuna "..tnshen,10)
					end
				end
			end
		end
	else
	Execute("tt- 打坐吐纳")
	DoAfterSpecial(1,"say 打坐吐纳结束，精力内力已达上限。",10)
	end
end
end

