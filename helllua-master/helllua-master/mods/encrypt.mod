print("ÔØÈë¼ÓÃÜÄ£¿é")
assert  (package.loadlib (luapath.."aeslib.dll","luaopen_aes")) ()
encrypt=function(text,key)
	if key==nil then key="" end
	return utils.base64encode(aes.encrypt(text,key))
end

decrypt=function(text,key)
	if key==nil then key="" end
	return aes.decrypt(utils.base64decode(text),key)
end

if helpfindpassword==nil then helpfindpassword="" end
if dragonpassword==nil then dragonpassword="" end
