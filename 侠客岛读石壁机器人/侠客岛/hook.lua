----------hook相关--------------------- 
hooks={}
hooks.isbusy="isbusy"
--是否busy的hook


_hooklist={}

hook=function(str,callback,...)			--将需要运行的函数hook进来
	_hooklist[str]=callback
end

callhook=function(str,removehook)
	thook=_hooklist[str]
	if removehook==true then
		hook(str,nil)
	end
	call(thook)
end

call=function(func,...)					--执行该函数
	if (func~=nil) then
		func(...)
	end
end


----------hook相关-----------结束---------- 
