--洗沙
xishaloc=mapper.newarea(1)
mapper.readroom(xishaloc,tostring(xishaloc).."=洗沙|n:1455,")
mapper.addpath(1455,"s:"..tostring(xishaloc)..",")

--th新路
tiejiangsloc=mapper.newarea(1)
mapper.readroom(tiejiangsloc,tostring(tiejiangsloc).."=大院|th>ride diao*:1986,n:66,")
--mapper.readroom(1979,"1979=前院|n:1980,out:1978,")
--mapper.readroom(1986,"1986=桃花山庄正门|e:2000,n:2007,s:1987,")
mapper.addpath(1994,"th>ride diao:"..tostring(tiejiangsloc)..",")
mapper.addpath(66,"s:"..tostring(tiejiangsloc)..",")
