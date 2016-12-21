mudvar={}
initmudvar=function()
	mudvar.teller=""
	chatroom=""
	mudvar.eatjz=false
	mudvar.dragon=""
	mudvar.powerup=nopowerup.powerup
	mudvar.canaccept={}
end
mudlistre=rex.new("([^,]+)")

getmudvar=function()
	initmudvar()
	catch("mudvar","set;alias")
end

mudvar_teller=function(n,l,w)
	print("“£øÿ’ﬂ£∫"..w[1])
	mudvar.teller=w[1]
end

mudvar_chatroom=function(n,l,w)
	print("¡ƒÃÏ “£∫"..w[1])
	chatroom=w[1]
end

mudvar_eatjz=function(n,l,w)
	mudvar.eatjz=true
end

nopowerup={}
nopowerup.powerup=0
nopowerup.nopowerup=1
nopowerup.drunk=2

mudvar_nopowerup=function(n,l,w)
	if w[1]=="drunk" then
	mudvar.powerup=nopowerup.drunk
	else
	mudvar.powerup=nopowerup.nopowerup
	end
end

mudvar_dragon=function(n,l,w)
	mudvar.dragon=w[1]
end

mudvar_canaccept=function(n,l,w)
	n=mudlistre:gmatch(w[1],function (m, t)
		mudvar.canaccept[m]=true
	end)
end
