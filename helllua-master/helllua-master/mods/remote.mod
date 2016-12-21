msg=function()
end
remote={}
remote.name=""
remote.cmd=""
remote_called=function(n,l,w)
	remote.name=string.lower(w[2])
	remote.cmd=w[3]
	if mudvar.teller==nil then
		getmudvar()
		infoend(check_tell)
	else
		check_tell()
	end
end

check_tell=function()
	if validtellername(remote.name) then
		print("收到远程控制命令"..remote.cmd)
		Execute(remote.cmd)
	end
end

validtellername=function(str)
	if str==mudvar.teller then return true end
	return false
end

