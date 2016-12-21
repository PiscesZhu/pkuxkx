alias_stop=function(m,l,w)
	quest.stop=false
end

alias_watch=function(m,l,w)
	quest.stop=true
	do_watch()
end