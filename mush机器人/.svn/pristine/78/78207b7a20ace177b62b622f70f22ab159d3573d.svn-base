michen_yb={}
michen_yb_pre={}
michen_yb_start={}

--[[
整体思路：
ASK JOB部份：
1.要到JOB了，n或者sw，shang che,check che
2.还不能要JOB，startworkflow
3.已经有任务，就放弃吧
送镖部份：
1.CHECK CHE来判断要送去的地点，路径
2.建一个TIMER，每秒check busy，如果不busy就可以继续行走，如果在FIGHT,就YQ和PFM
	不BUSY的时候，如果有FJ，并且在安全房间，就回去FJ
	如果安全房间就在前方路径上，就送到安全房间，再回去FJ
	如果安全房间就在附近，就送到安全房间，再回去FJ
3.车子行走成功的描述，来确认行走成功了，继续下一个路径
4.车子行走错误，重新定位，寻找路径
5.出贼的描述，标记FIGHT状态，交给TIMER处理
到的目的地部份：
1.回到镖局了，startworkflow
2.到取货的地点了，check che
3.到卸货的地点了，返回镖局
4.NPC没在，找当前房间的SAFEEXIT，来回走，一直到NPC回来
特殊部份：
1.超过时间了，回去放弃任务
2.车没了，回去放弃任务
]]
setybjob=1
ybjob={
	ybstatus=0,						-- 运镖状态：1=去取货，2=送货，3=返回
	ybnpcname="",					-- 目标NPC的名字
	ybnpcid="",						-- 目标NPC的ID
	ybroomno=0,						-- 目标房间ID
	ybpath="",						-- 运镖的路径
	ybpathnum=0,					-- 运镖要走的步数
	ybpathnow=1,					-- 当前走到的步数
	ybfx="",						-- 当前要走的方向
	ganche=0,						-- 是否在赶车
	ybfight=0,						-- 是否在战斗中
	needfangqi=0,					-- 是否需要放弃任务
	biaohuo=0,
	ssyb="",
}

-- 安全房间清单
ybsaferoom_list={
	-- 华山村
	814,815,818,820,825,827,832,834,836,
	-- 泉州
	1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,86,87,88,89,90,91,120,
	1279,1280,1281,1282,1283,1284,1285,1286,1287,1288,1289,1290,1291,1292,1293,1294,1295,1296,2057,
	-- 长白山
	1472,1473,1474,1475,1476,1477,1478,1479,1480,1481,1482,1483,1484,1485,1486,1487,1488,1489,1490,1491,1492,1493,1494,1495,1496,1497,1498,1499,1500,1501,1502,1503,1504,1505,1506,1507,1508,1509,1510,1511,1512,1513,1514,1515,1516,1517,1518,1519,1520,1521,1522,1523,1524,1525,1526,1527,1528,1529,1530,1531,1532,1533,1534,1535,1536,1537,1538,1539,1540,1541,1542,1543,1544,1545,
	-- 佛山
	92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,111,112,113,114,115,116,117,118,119,
	622,623,624,625,626,627,628,629,648,938,
	-- 杭州
	1125,1126,1127,1128,1129,1130,1131,1132,1133,1134,1135,1136,1137,1138,1139,1140,1141,1142,1143,1144,1145,1146,1147,1148,1149,1150,1151,1152,1153,1154,1155,1156,1157,1158,1159,1160,1161,1162,1163,1164,1165,1166,1167,1168,1169,1170,1171,1172,1173,1174,1175,1176,1177,1178,1179,1180,1181,1182,1183,1184,1185,1186,1187,1188,1189,1190,1191,1192,1193,1194,1195,1196,1197,1198,1199,1200,1201,1202,1203,1204,1205,1206,1207,1208,1209,1210,1211,1212,1213,1214,1215,1216,1217,1218,1219,1220,1221,1222,1223,1224,1225,1226,1227,1228,1229,1230,1231,1232,1233,1234,1235,1236,1237,1238,1239,1240,1241,1242,1243,1244,1245,1246,1247,1248,1249,1250,1251,1252,1253,1254,1255,1256,1257,1258,1259,1260,1261,1262,1263,1264,1265,1266,1267,1268,1269,1270,1271,1272,1273,1274,1275,1276,1277,1278,
	-- 武当
	620,621,622,623,624,625,626,627,628,629,630,631,632,633,634,635,636,637,638,639,640,641,642,643,644,645,646,647,648,649,650,651,652,653,654,655,656,657,658,659,660,661,662,663,664,665,666,667,668,669,670,671,672,673,674,675,676,677,678,679,680,681,682,683,684,685,686,687,688,689,690,691,692,693,694,695,696,697,698,699,700,701,702,703,704,705,706,707,708,709,710,711,712,713,714,715,716,717,718,719,720,721,
	-- 黄河边
	1303,1304,1305,
	1314,1315,1316,1317,1318,1319,1320,1321,
	1393,1394,1395,1396,1397,1423,
	-- 嘉兴
	1267,1268,1269,1270,1271,1272,1273,1274,1275,1276,
	-- 南阳
	1855,1856,1857,1858,1859,1860,1861,1862,1863,1864,1865,1866,1867,1868,1869,1870,1871,1872,1873,1874,1875,1876,1877,1878,1879,1880,1881,1882,1883,1884,1885,1886,1887,1888,1889,1890,1891,1892,1893,1894,1895,1896,1897,1898,1899,1900,1901,1902,1903,1904,1905,1906,1907,1908,1909,1910,1911,1912,1913,1914,1915,1916,1917,1918,1919,1920,1921,1922,1923,1924,1925,1926,1927,1928,1929,1930,1931,1932,1933,1934,1935,1936,1937,1938,1939,1940,1941,1942,1943,1944,1945,1946,1947,1948,1949,1950,1951,1952,1953,1954,1955,1956,
	-- 祁连山
	939,1338,1339,1340,1341,1342,1343,1344,1345,1346,1347,1348,1349,1350,1351,1352,1353,1354,1355,1356,1357,1358,1359,1360,1361,1362,1363,1364,1365,1366,1367,1368,1369,1370,1371,1372,1373,1374,1375,1376,1377,1378,1379,1380,1381,1382,1383,1384,1385,1386,1387,1388,1389,1390,1391,1392,1398,1399,1401,1459,1828,1829,
	-- 泰山
	1056,1057,1058,1059,1060,1061,1062,1063,1064,1065,1066,1067,1068,1069,1070,1071,1072,1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1086,1087,1088,1089,
	-- 太湖边
	1090,1091,1092,1297,1298,1299,1301,1302,1460,1461,1462,1463,1464,1465,1466,1467,1468,1469,1470,1471,
	-- 西夏
	1362,1363,1364,1365,1366,1367,1368,1369,1370,1371,1372,1400,1403,
	1554,1555,1556,1557,1558,1559,1560,1561,1562,1563,1564,1565,1566,1567,1568,1569,1570,1571,1572,1573,1574,1575,1576,1577,1578,1579,1580,1581,1582,1583,1584,1585,1586,1587,1588,1589,1590,1591,1592,1593,1594,1595,1596,1597,1598,1599,1600,1601,1602,1603,1604,1605,1606,1607,1608,1609,1610,1611,1612,1613,1614,
	1975,1976,1977,1986,
	-- 扬州
	945,946,947,948,949,950,951,952,953,954,955,956,957,958,959,960,961,962,963,964,965,966,967,968,969,970,971,972,973,974,975,976,977,978,979,980,981,982,983,984,985,986,987,988,989,990,991,992,993,994,995,996,997,998,999,1000,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1016,1017,1018,1019,1020,1021,1022,1023,1024,1025,1026,1027,1028,1029,1030,1031,1032,1033,1034,1035,1036,1037,1038,1039,1040,1041,1042,1043,1044,1045,1046,1047,1048,1049,1050,1051,1052,1053,1054,1055,1056,1057,1058,1059,1060,1061,1062,1063,1064,1065,1066,1067,1068,1069,1070,1071,1072,1073,1074,1075,1076,1077,1078,1079,1080,1081,1082,1083,1084,1085,1086,1087,1088,1089,1090,1091,1092,1093,1094,1095,1096,1097,1098,1099,
	1100,1115,1123,1124,1300,1322,1323,
	-- 扬州郊外
	923,924,925,926,927,1032,1053,1054,
	1101,1102,1103,1104,1105,1106,1107,1108,1109,1110,1111,1112,1113,1114,1306,1307,1308,1309,1310,1311,1312,1313,
	-- 大理
	121,122,123,124,125,126,127,128,129,130,131,132,133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150,151,152,153,154,155,156,157,158,159,160,161,162,163,164,165,166,167,168,169,170,171,172,173,174,175,176,177,178,179,180,181,182,183,184,185,186,187,188,189,190,191,192,193,194,195,196,197,198,199,200,201,202,203,204,205,206,207,208,209,210,211,212,213,214,215,216,217,218,219,220,221,222,223,224,225,226,227,228,229,230,231,232,233,234,235,236,237,238,239,240,241,242,243,244,245,246,247,248,249,250,251,252,253,254,255,256,257,258,259,260,261,262,263,264,265,266,267,268,269,270,271,272,273,274,275,276,277,278,279,280,281,282,283,284,285,286,287,288,289,290,292,293,294,295,296,297,298,299,300,301,302,303,304,305,306,307,308,309,310,311,312,313,314,315,316,317,318,319,320,321,322,323,324,325,617,618,619,408,645,
}
ybplace_list={}
table.insert(ybplace_list,{NpcId="fu sigui",NpcName1="傅思归",NpcName2="傅将军",NpcArea="大理",Place="定安府",Roomno=285,})
table.insert(ybplace_list,{NpcId="duan xing",NpcName1="段陉",NpcName2="段判官",NpcArea="大理",Place="法堂",Roomno=292,})
table.insert(ybplace_list,{NpcId="xue laoban",NpcName1="薛老板",NpcName2="薛大老板",NpcArea="大理",Place="城内成衣铺",Roomno=283,})
table.insert(ybplace_list,{NpcId="he hongyao",NpcName1="何红药",NpcName2="五毒教何堂主",NpcArea="大理",Place="城内药铺",Roomno=282,})
table.insert(ybplace_list,{NpcId="song laoban",NpcName1="宋老板",NpcName2="太和居老板",NpcArea="大理",Place="城内",Roomno=280,})
table.insert(ybplace_list,{NpcId="chu wanli",NpcName1="褚万里",NpcName2="褚将军",NpcArea="大理",Place="王府",Roomno=177,})
table.insert(ybplace_list,{NpcId="cui baiquan",NpcName1="崔管家",NpcName2="金算盘崔百泉",NpcArea="大理",Place="王府门房",Roomno=178,})
table.insert(ybplace_list,{NpcId="hua hegen",NpcName1="华赫艮",NpcName2="华司徒",NpcArea="大理",Place="司徒堂",Roomno=181,})
table.insert(ybplace_list,{NpcId="ba tianshi",NpcName1="巴天石",NpcName2="巴司空",NpcArea="大理",Place="司徒堂",Roomno=180,})
table.insert(ybplace_list,{NpcId="fan ye",NpcName1="范骅",NpcName2="范司马",NpcArea="大理",Place="司马堂",Roomno=182,})
table.insert(ybplace_list,{NpcId="zhu danchen",NpcName1="朱丹臣",NpcName2="朱将军",NpcArea="大理",Place="王府内院",Roomno=194,})
table.insert(ybplace_list,{NpcId="gao shengtai",NpcName1="侯爷高升泰",NpcName2="善阐侯",NpcArea="大理",Place="城外五华楼",Roomno=,})
table.insert(ybplace_list,{NpcId="daizu shouling",NpcName1="傣族首领",NpcName2="洪源洞洞主",NpcArea="大理",Place="五华楼内",Roomno=322,})
table.insert(ybplace_list,{NpcId="nuerhai",NpcName1="努儿海",NpcName2="一品堂总管",NpcArea="西夏",Place="账房",Roomno=1975,})
table.insert(ybplace_list,{NpcId="helian tieshu",NpcName1="赫连铁树",NpcName2="征东大将军",NpcArea="西夏",Place="一品堂",Roomno=1977,})
table.insert(ybplace_list,{NpcId="lao daoshi",NpcName1="老道士",NpcName2="老道士",NpcArea="西夏",Place="八仙观",Roomno=1612,})
table.insert(ybplace_list,{NpcId="duan yanqing",NpcName1="段延庆",NpcName2="恶贯满盈",NpcArea="西夏",Place="一品堂",Roomno=1986,})
table.insert(ybplace_list,{NpcId="ye erniang",NpcName1="叶二娘",NpcName2="无恶不作",NpcArea="西夏",Place="林中大屋",Roomno=1590,})
table.insert(ybplace_list,{NpcId="nanhai eshen",NpcName1="南海鳄神",NpcName2="凶神恶煞",NpcArea="西夏",Place="林中大屋",Roomno=1590,})
table.insert(ybplace_list,{NpcId="yun zhonghe",NpcName1="云中鹤",NpcName2="穷凶极恶",NpcArea="西夏",Place="接引堂",Roomno=1976,})
table.insert(ybplace_list,{NpcId="qiu shanfeng",NpcName1="邱山风",NpcName2="长乐帮虎猛堂香主",NpcArea="宜兴",Place="近郊",Roomno=1101,})
table.insert(ybplace_list,{NpcId="bei haishi",NpcName1="贝海石",NpcName2="着手成春",NpcArea="宜兴",Place="近郊长乐帮",Roomno=1102,})
table.insert(ybplace_list,{NpcId="ding dang",NpcName1="丁当",NpcName2="叮叮当当",NpcArea="宜兴",Place="近郊长乐帮",Roomno=1112,})
table.insert(ybplace_list,{NpcId="situ heng",NpcName1="司徒横",NpcName2="长乐帮主八爪金龙",NpcArea="宜兴",Place="近郊长乐帮",Roomno=1107,})
table.insert(ybplace_list,{NpcId="zhuang yuncheng",NpcName1="庄允城",NpcName2="庄允城",NpcArea="宜兴",Place="南浔镇",Roomno=1297,})
table.insert(ybplace_list,{NpcId="feng liang",NpcName1="风良",NpcName2="青龙门掌门人",NpcArea="宜兴",Place="近郊树林",Roomno=1095,})
table.insert(ybplace_list,{NpcId="gao san",NpcName1="高三娘子",NpcName2="万马庄女庄主",NpcArea="宜兴",Place="近郊树林",Roomno=1095,})
table.insert(ybplace_list,{NpcId="fan yifei",NpcName1="范一飞",NpcName2="鹤笔门掌门人",NpcArea="宜兴",Place="近郊树林",Roomno=1094,})
table.insert(ybplace_list,{NpcId="lu zhengping",NpcName1="吕正平",NpcName2="快刀门掌门人",NpcArea="宜兴",Place="近郊树林",Roomno=1094,})
table.insert(ybplace_list,{NpcId="hu laoye",NpcName1="巴依",NpcName2="胡老爷",NpcArea="伊犁",Place="小镇",Roomno=1336,})
table.insert(ybplace_list,{NpcId="li wenxiu",NpcName1="李文秀",NpcName2="李文秀",NpcArea="伊犁",Place="小镇",Roomno=1335,})
table.insert(ybplace_list,{NpcId="jia renda",NpcName1="贾人达",NpcName2="青城派弟子",NpcArea="泉州",Place="郊区",Roomno=1289,})
table.insert(ybplace_list,{NpcId="wang tongzhi",NpcName1="王通治",NpcName2="药铺掌柜",NpcArea="泉州",Place="济世堂老店",Roomno=4,})
table.insert(ybplace_list,{NpcId="shi lang",NpcName1="施琅",NpcName2="靖海侯",NpcArea="泉州",Place="将军府",Roomno=86,})
table.insert(ybplace_list,{NpcId="ouyang zhan",NpcName1="欧阳詹",NpcName2="欧阳老师",NpcArea="泉州",Place="学堂",Roomno=83,})
table.insert(ybplace_list,{NpcId="tao lao",NpcName1="陶老人",NpcName2="陶老先生",NpcArea="泉州",Place="淘然茶居",Roomno=59,})
table.insert(ybplace_list,{NpcId="wu laoban",NpcName1="吴老板",NpcName2="烟雨楼大老板",NpcArea="泉州",Place="万国烟雨楼",Roomno=73,})
table.insert(ybplace_list,{NpcId="xu laoban",NpcName1="许老板",NpcName2="绸缎庄老板",NpcArea="泉州",Place="鸿翔绸缎庄",Roomno=71,})
table.insert(ybplace_list,{NpcId="ma wude",NpcName1="马五德",NpcName2="马师傅",NpcArea="泉州",Place="武馆",Roomno=34,})
table.insert(ybplace_list,{NpcId="long quan",NpcName1="龙铨",NpcName2="龙铨师傅",NpcArea="泉州",Place="武馆",Roomno=42,})
table.insert(ybplace_list,{NpcId="chen hu",NpcName1="陈浒",NpcName2="陈浒师傅",NpcArea="泉州",Place="武馆",Roomno=41,})
table.insert(ybplace_list,{NpcId="xiao fei",NpcName1="萧飞",NpcName2="萧飞师傅",NpcArea="泉州",Place="武馆",Roomno=40,})
table.insert(ybplace_list,{NpcId="liu hongying",NpcName1="刘虹瑛",NpcName2="刘虹瑛师傅",NpcArea="泉州",Place="武馆",Roomno=38,})
table.insert(ybplace_list,{NpcId="miao zhu",NpcName1="庙祝",NpcName2="城隍庙祝",NpcArea="泉州",Place="城隍庙",Roomno=15,})
table.insert(ybplace_list,{NpcId="lu guanying",NpcName1="陆冠英",NpcName2="归云庄少庄主",NpcArea="杭州",Place="太湖",Roomno=1091,})
table.insert(ybplace_list,{NpcId="gu yanwu",NpcName1="顾炎武",NpcName2="顾老师",NpcArea="杭州",Place="玉泉书院",Roomno=1171,})
table.insert(ybplace_list,{NpcId="ou yezi",NpcName1="欧冶子",NpcName2="欧铁匠",NpcArea="杭州",Place="铁匠铺",Roomno=1256,})
table.insert(ybplace_list,{NpcId="guo xiaotian",NpcName1="郭啸天",NpcName2="郭啸天",NpcArea="嘉兴",Place="牛家村",Roomno=1277,})
table.insert(ybplace_list,{NpcId="yang tiexin",NpcName1="杨铁心",NpcName2="杨铁心",NpcArea="嘉兴",Place="牛家村",Roomno=1277,})
table.insert(ybplace_list,{NpcId="qu san",NpcName1="曲三",NpcName2="曲老板",NpcArea="嘉兴",Place="牛家村酒店",Roomno=1278,})
table.insert(ybplace_list,{NpcId="feng qi",NpcName1="凤七",NpcName2="凤楼主",NpcArea="佛山",Place="英雄楼",Roomno=105,})
table.insert(ybplace_list,{NpcId="feng yiming",NpcName1="凤一鸣",NpcName2="凤馆主",NpcArea="佛山",Place="英雄会馆",Roomno=103,})
table.insert(ybplace_list,{NpcId="wang laohan",NpcName1="王老汉",NpcName2="王老汉",NpcArea="佛山",Place="烧饼油条铺",Roomno=109,})
table.insert(ybplace_list,{NpcId="zhang chaotang",NpcName1="张朝唐",NpcName2="张公子",NpcArea="佛山",Place="郊道",Roomno=113,})
table.insert(ybplace_list,{NpcId="xiaoxiang zi",NpcName1="潇湘子",NpcName2="湘西名宿",NpcArea="三不管",Place="麻溪铺",Roomno=626,})
table.insert(ybplace_list,{NpcId="qi changfa",NpcName1="戚长发",NpcName2="铁锁横江",NpcArea="三不管",Place="戚家大院",Roomno=627,})
table.insert(ybplace_list,{NpcId="li mochou",NpcName1="李莫愁",NpcName2="赤练仙子",NpcArea="嘉兴",Place="南湖",Roomno=1271,})
table.insert(ybplace_list,{NpcId="xiang wentian",NpcName1="向问天",NpcName2="向右使",NpcArea="嘉兴",Place="城外",Roomno=1269,})
table.insert(ybplace_list,{NpcId="jin xin",NpcName1="金鑫",NpcName2="柜房掌柜",NpcArea="南阳城",Place="柜房",Roomno=1886,})
table.insert(ybplace_list,{NpcId="yu jiang",NpcName1="玉匠",NpcName2="瑰玮阁大老板",NpcArea="南阳城",Place="瑰玮阁",Roomno=1894,})
table.insert(ybplace_list,{NpcId="yu jiang",NpcName1="玉匠",NpcName2="瑰玮阁老板",NpcArea="南阳城",Place="瑰玮阁",Roomno=1894,})
table.insert(ybplace_list,{NpcId="lang zhong",NpcName1="郎中",NpcName2="大夫",NpcArea="南阳城",Place="张仲景墓",Roomno=1925,})
table.insert(ybplace_list,{NpcId="xiao yuanshan",NpcName1="萧远山",NpcName2="黑衣僧",NpcArea="赫图阿拉",Place="官道",Roomno=1537,})
table.insert(ybplace_list,{NpcId="yuzhen zi",NpcName1="玉真子",NpcName2="护国真人",NpcArea="赫图阿拉",Place="木桥",Roomno=1707,})
table.insert(ybplace_list,{NpcId="teng yilei",NpcName1="滕一雷",NpcName2="关东大魔",NpcArea="赫图阿拉",Place="南城",Roomno=1474,})
table.insert(ybplace_list,{NpcId="feng xifan",NpcName1="冯锡范",NpcName2="一剑无血",NpcArea="赫图阿拉",Place="老龙头",Roomno=1535,})
table.insert(ybplace_list,{NpcId="jiao wenqi",NpcName1="焦文期",NpcName2="关东三魔",NpcArea="赫图阿拉",Place="土窑馆",Roomno=1479,})
table.insert(ybplace_list,{NpcId="ma guangzuo",NpcName1="马光佐",NpcName2="白驼山庄武师",NpcArea="扬州郊外",Place="小路",Roomno=925,})
table.insert(ybplace_list,{NpcId="ouyang ke",NpcName1="欧阳克",NpcName2="白驼山少庄主",NpcArea="扬州郊外",Place="小山丘",Roomno=926,})
table.insert(ybplace_list,{NpcId="cui hua",NpcName1="翠花",NpcName2="翠姑娘",NpcArea="华山村",Place="民房",Roomno=826,})
table.insert(ybplace_list,{NpcId="feng",NpcName1="冯铁匠",NpcName2="冯铁匠",NpcArea="华山村",Place="铁匠铺",Roomno=833,})
table.insert(ybplace_list,{NpcId="li si",NpcName1="李四",NpcName2="小店老板",NpcArea="华山村",Place="杂货店",Roomno=831,})
table.insert(ybplace_list,{NpcId="li tiezui",NpcName1="李铁嘴",NpcName2="李师傅",NpcArea="华山",Place="玉泉院",Roomno=922,})
table.insert(ybplace_list,{NpcId="shan zheng",NpcName1="单正",NpcName2="铁面判官",NpcArea="泰山",Place="岱宗坊",Roomno=1060,})
table.insert(ybplace_list,{NpcId="zu qianqiu",NpcName1="祖千秋",NpcName2="祖先生",NpcArea="黄河",Place="黄河岸边",Roomno=1304,})
table.insert(ybplace_list,{NpcId="hou tonghai",NpcName1="侯通海",NpcName2="三头蛟",NpcArea="黄河",Place="黄河岸边",Roomno=1314,})
table.insert(ybplace_list,{NpcId="shen qinggang",NpcName1="沈青刚",NpcName2="黄河四鬼老大",NpcArea="黄河",Place="黄河帮寨门",Roomno=1315,})
table.insert(ybplace_list,{NpcId="ma qingxiong",NpcName1="马青雄",NpcName2="黄河四鬼老三",NpcArea="黄河",Place="黄河帮寨门",Roomno=1315,})
table.insert(ybplace_list,{NpcId="wu qinglie",NpcName1="吴青烈",NpcName2="黄河四鬼老二",NpcArea="黄河",Place="广场",Roomno=1316,})
table.insert(ybplace_list,{NpcId="qian qingjian",NpcName1="钱青健",NpcName2="黄河四鬼老四",NpcArea="黄河",Place="广场",Roomno=1316,})
table.insert(ybplace_list,{NpcId="sha tongtian",NpcName1="沙通天",NpcName2="黄河帮帮主",NpcArea="黄河",Place="侠义厅",Roomno=1317,})
table.insert(ybplace_list,{NpcId="liang ziweng",NpcName1="梁子翁",NpcName2="参仙老怪",NpcArea="黄河",Place="侠义厅",Roomno=1317,})
table.insert(ybplace_list,{NpcId="peng lianhu",NpcName1="彭连虎",NpcName2="千手人屠",NpcArea="黄河",Place="侠义厅",Roomno=1317,})
table.insert(ybplace_list,{NpcId="lu tianshu",NpcName1="陆天抒",NpcName2="仁义陆大刀",NpcArea="大雪山",Place="大雪山山路",Roomno=419,})
table.insert(ybplace_list,{NpcId="shui dai",NpcName1="水岱",NpcName2="冷月剑",NpcArea="大雪山",Place="大雪山山路",Roomno=419,})
table.insert(ybplace_list,{NpcId="hua tiegan",NpcName1="花铁干",NpcName2="中平无敌",NpcArea="大雪山",Place="大雪山北麓",Roomno=418,})
table.insert(ybplace_list,{NpcId="liu chengfeng",NpcName1="刘承风",NpcName2="柔云剑",NpcArea="大雪山",Place="山路",Roomno=647,})
table.insert(ybplace_list,{NpcId="lin zhennan",NpcName1="林震南",NpcName2="林震南",NpcArea="扬州",Place="正厅",Roomno=964,})
table.insert(ybplace_list,{NpcId="zhen xibei",NpcName1="镇西北",NpcName2="镇西北",NpcArea="祁连山",Place="神鹰镖局",Roomno=1376,})

robber_list={}
table.insert(robber_list,{name="流氓",id="liu mang",})
table.insert(robber_list,{name="无赖",id="wu lai",})
table.insert(robber_list,{name="路霸",id="lu ba",})
table.insert(robber_list,{name="草寇",id="cao kou",})
table.insert(robber_list,{name="流寇",id="liu kou",})
table.insert(robber_list,{name="恶霸",id="e ba",})
table.insert(robber_list,{name="抢匪",id="qiang fei",})
table.insert(robber_list,{name="帮匪",id="bang fei",})
table.insert(robber_list,{name="毛贼",id="mao zei",})
table.insert(robber_list,{name="小贼",id="xiao zei",})
table.insert(robber_list,{name="贼头",id="zei tou",})
table.insert(robber_list,{name="小贼头",id="xiaozei tou",})
table.insert(robber_list,{name="毛贼头",id="maozei tou",})
table.insert(robber_list,{name="流氓头",id="liumang tou",})
table.insert(robber_list,{name="山大王",id="shan dawang",})
table.insert(robber_list,{name="独行盗",id="duxing dao",})
table.insert(robber_list,{name="盗贼",id="dao zei",})
table.insert(robber_list,{name="盗贼王",id="daozei wang",})
table.insert(robber_list,{name="盗贼首领",id="daozei shouling",})
table.insert(robber_list,{name="盗贼领袖",id="daozei lingxiu",})
table.insert(robber_list,{name="盗贼大王",id="daozei dawang",})
table.insert(robber_list,{name="寨主",id="zhai zhu",})
table.insert(robber_list,{name="山寨主",id="shan zhaizhu",})
table.insert(robber_list,{name="山寨首领",id="shanzhai shouling",})
table.insert(robber_list,{name="山寨领袖",id="shanzhai lingxiu",})
table.insert(robber_list,{name="山寨大王",id="shanzhai dawang",})
table.insert(robber_list,{name="强盗",id="qiang dao",})
table.insert(robber_list,{name="强盗头",id="qiangdao tou",})
table.insert(robber_list,{name="强盗王",id="qiangdao wang",})
table.insert(robber_list,{name="强盗首领",id="qiangdao shouling",})
table.insert(robber_list,{name="强盗领袖",id="qiangdao lingxiu",})
table.insert(robber_list,{name="强盗大王",id="qiangdao dawang",})
table.insert(robber_list,{name="土匪",id="tu fei",})
table.insert(robber_list,{name="土匪头",id="tufei tou",})
table.insert(robber_list,{name="土匪首领",id="tufei shouling",})
table.insert(robber_list,{name="土匪领袖",id="tufei lingxiu",})
table.insert(robber_list,{name="土匪大王",id="tufei dawang",})
table.insert(robber_list,{name="山贼",id="shan zei",})
table.insert(robber_list,{name="小山贼",id="xiao shanzei",})
table.insert(robber_list,{name="山贼头",id="shanzei tou",})
table.insert(robber_list,{name="山贼首领",id="shanzei shouling",})
table.insert(robber_list,{name="山贼领袖",id="shanzei lingxiu",})
table.insert(robber_list,{name="山贼大王",id="shanzei dawang",})
robber_act={
	a={"无预警地","","突然","不知从哪里","不知从何处","毫无征兆地","无征兆地","忽然","毫无预警地","从某处",},
	b={"跳了","跑了","窜了","走了","跃了","冲了","跳","跑","窜","走","跃","冲"},
}
function michen_yb.getybinfo()
	local _tb,msg,_t
	for k,v in pairs(ybplace_list) do
		if v["NpcName1"]==ybjob.ybnpcname or v["NpcName2"]==ybjob.ybnpcname then
			ybjob.ybnpcid=v["NpcId"]
			ybjob.ybroomno=tonumber(v["Roomno"])
			ybjob.ybpathnow=1
			-- 这里特别处理一下，不能钻狗洞的
			_t=xkxGPS.EntranceCondition
			xkxGPS.setEntranceCondition("condition is null")
			ybjob.ybpath=xkxGPS.search(roomno_now,ybjob.ybroomno)
			xkxGPS.setEntranceCondition(_t)
			_tb=utils.split(ybjob.ybpath,"|")
			ybjob.ybpathnum=table.getn(_tb)
			msg="运镖路径查找完成，送给"..tostring(ybjob.ybnpcname).."需要走"..tostring(ybjob.ybpathnum).."步"
			if findstring(ybjob.ybpath,"guohe") then msg=msg.."，需要过河。" else msg=msg.."，不需要过河。" end
			print(msg)
			break
		end
	end
	print("获取押镖信息失败！NPCNAME="..tostring(ybjob.ybnpcname))
	addlog("获取押镖信息失败！NPCNAME="..tostring(ybjob.ybnpcname))
	alias.close_yb()
	ybjob.ybstatus=0
	alias.startworkflow()
end
function michen_yb.ganche()
	local _tb,_t
	-- 这里要加上如果有FJ，或者马上要来FJ了，并且如果在安全房间，就回去做FJ先。
	_tb=utils.split(ybjob.ybpath,"|")
	if ybjob.ybpathnow>table.getn(_tb) or _tb[ybjob.ybpathnow]=="isHere" then
		-- 已经走到了
	else
		-- 找出下一步的方向
		_t=_tb[ybjob.ybpathnow]
		_t=string.gsub(_t,"-","")
		if aliasStepNum[_t]~=nil then Execute("/alias.".._t.."()")
		else
			ybjob.ybfx=ybfx(_tb[ybjob.ybpathnow])
			run("gan che "..tostring(ybjob.ybfx))
		end
	end
end
------------------------------------------------------------------------------------
-- michen_yb_pre
------------------------------------------------------------------------------------
function michen_yb_pre.dosomething1(n,l,w)
	local _f
	if findstring(w[0],"你向.+打听有关「job」的消息。\n.+说道：你这不中用的家伙，亏你","你向.+打听有关「job」的消息。\n.+说道：我这里倒有几桩差事，可是暂时信不过你去干","你向.+打听有关「job」的消息。\n.+说道：今天所有的镖都已送完了，你明天早点来吧。") then
		alias.close_yb()
		ybjob.ybstatus=0
		alias.startworkflow()
	end
	if findstring(w[0],"你向.+打听有关「job」的消息。\n.+忙着呢，你等会儿在问话吧","这里没有 lin zhennan 这个人。","这里没有 zhen xibei 这个人。") then
		wait.make(function()
			_f=function() if setybjob==1 then run("ask zhen xibei about job") else run("ask lin zhennan about job") end end
			wait.time(2);_f()
		end)
	end
	if findstring(w[0],"你向.+打听有关「job」的消息。\n.+说道：.+是黑道上的英雄，就算我信得过你，我客户也信不过你。") then
		setybjob=1
		alias.startworkflow()
	end
	if findstring(w[0],"你向.+打听有关「job」的消息。\n.+说道：.+难道是福威镖局派来卧底的？") then
		setybjob=0
		alias.startworkflow()
	end
	if findstring(w[0],"你向.+打听有关「job」的消息。\n.+生气地撅了撅嘴。") then
		ybjob.needfangqi=0
		if setybjob==1 then run("ask zhen xibei about 放弃") else run("ask lin zhennan about 放弃") end
	end
	if findstring(w[0],"你向.+打听有关「job」的消息。\n.+说道：好吧，你来得正是时候，我这儿正缺人用。") then
		workflow.nowjob="yb"
		if setybjob==1 then run("sw") else run("n") end
		closeclass("michen_yb_pre")
		openclass("michen_yb_start")
		run("shang che;shang che 2;shang che 3;check")
	end
	if findstring(w[0],"你向.+打听有关「放弃」的消息。\n.+说道：你又没有任务，放弃什么？") then
		ybjob.needfangqi=0
		alias.startworkflow()
	end
	if findstring(w[0],"你向.+打听有关「放弃」的消息。\n.+生气地撅了撅嘴。") then
		ybjob.needfangqi=0
		alias.startworkflow()
	end
	if findstring(w[0],"你向.+打听有关「放弃」的消息。\n.+忙着呢，你等会儿在问话吧") then
		wait.make(function()
			_f=function() if setybjob==1 then run("ask zhen xibei about 放弃") else run("ask lin zhennan about 放弃") end end
			wait.time(2);_f()
		end)
	end
end
------------------------------------------------------------------------------------
-- michen_yb_start
------------------------------------------------------------------------------------
function michen_yb_start.timer()
	if yjob.ybfight>0 then
		if string.len(ybpfm)>0 then
			_tb=utils.split(ybpfm,"|")
			run(_tb[1])
		end
		if hp.qi<(hp.maxqi*4/5) then run("yun recover") end
		run("hp")
	end
	run("eat yb")
end

function michen_yb_start.dosomething1(n,l,w)
	local _f,a,b,c,d,_t,_tb
	wait.make(function()
		if findstring(l,"周围没人能帮你去了解别人的消息","只有乞丐才能打探别人的技能！") then
			ybjob.needfangqi=1
			run("leave che")
			if setybjob==1 then alias.flytoid(1386) else alias.flytoid(965) end
		end
		if findstring(l,"数码世界，数字地图，1386就是这里！","数码世界，数字地图，965就是这里！") then
			if ybjob.needfangqi>0 then
				if setybjob==1 then run("ask zhen xibei about 放弃") else run("ask lin zhennan about 放弃") end
			end
		end
		a,b,c=string.find(l,"这是(.+)押运的空车，正在归途中")
		if c~=nil then
			if c==me.charname then
				if setybjob==1 then ybjob.ybnpcname="镇西北" else ybjob.ybnpcname="林震南" end
				ybjob.ybstatus=3
				michen_yb.getybinfo()
				run("shang che;set ybjob=start")
			else
				-- 不是我的车
				_f=function() run("check") end
				wait.time(1);_f()
			end
		end
		a,b,c,d=string.find(l,"这是(.+)押运的镖车，要去向(.+)取货。")
		if c~=nil and d~=nil then
			if c==me.charname then
				ybjob.ybnpcname=d
				ybjob.ybstatus=1
				michen_yb.getybinfo()
				run("shang che;set ybjob=start")
			else
				-- 不是我的车
				_f=function() run("check") end
				wait.time(1);_f()
			end
		end
		a,b,c,d=string.find(l,"这是(.+)押运的重镖，要送给(.+)的。")
		if c~=nil and d~=nil then
			if c==me.charname then
				ybjob.ybnpcname=d
				ybjob.ybstatus=2
				michen_yb.getybinfo()
				run("shang che;set ybjob=start")
			else
				-- 不是我的车
				_f=function() run("check") end
				wait.time(1);_f()
			end
		end
		if findstring(l,"你目前还没有任何为 ybjob=start 的变量设定。") then
			openclass("michen_yb_start_t")
		end
		if findstring(l,"你身上没有 yb 这样食物。") then
			ybjob.ybfight=0
			michen_yb.ganche()
		end
		if findstring(l,"你神气地跳上了镖车，握住缰绳，手拿起鞭子，吆喝了起来！","你已经在镖车上！") then
			ybjob.ganche=1
		end
		if findstring(l,"你跳下了镖车！","你已经不在镖车上！") then
			ybjob.ganche=0
		end
		
		-- YB过程中，强盗的处理部份
		if findstring(w[0],"你驾着镖车扬了扬鞭子，高声驱赶骡子朝.+驶去。\n.+：.+！") then
			ybjob.ybfight=1
		end
		a,b,c=string,find(l,"^[> ]*(.+)出来!")
		if c~=nil and ybjob.ybstatus==2 then
			for k,v in pairs(robber_act.a) do
				for i,j in pairs(robber_act.b) do
					for a,b in pairs(robber_list) do
						_t=tostring(b["name"])..tostring(v)..tostring(j)
						if c==_t then
							ybjob.ybfight=1
							if string.len(ybweapon)>0 then
								if ybweapon=="staff" then alias.wi(staffid) else alias.wi(ybweapon) end
							else alias.uw() end
							if string.len(ybyun)>0 then
								_tb=utils.split(ybyun,"|")
								for f,g in ipairs(_tb) do run(g) end
							end
							run("attack "..tostring(b["id"]))
							if me.menpai=="bt" then run("convert staff;attack "..tostring(b["id"])) end
							if me.menpai=="mj" then run("order fighter do attack "..tostring(b["id"])..";order fighter 2 do attack "..tostring(b["id"])) end
							run("kill "..tostring(b["id"]))
							if string.len(ybpfm)>0 then
								_tb=utils.split(ybpfm,"|")
								run(_tb[1])
							end
							return
						end
					end
				end
			end
		end
		
		-- YB过程中，赶车部份的处理
		if findstring(l,"^[> ]*无此方向可去！","^[> ]*此方向无路可行！","^[> ]*此方向去不了！","^[> ]*此方向无法去！","^[> ]*此方向无法前进！","^[> ]*此路不通！","^[> ]*无法前进！","^[> ]*前进不了！","^[> ]*无法走！") then
		end
		if findstring(l,"^侧.*你.*车.*来。","^靠.*你.*车.*来。","^立.*你.*车.*来。","^你.*车.*来。","^斜.*你.*车.*来。","^倚.*你.*车.*来。","^站.*你.*车.*来。","^坐.*你.*车.*来。") then
			ybjob.ybfight=0
			_tb=utils.split(ybjob.ybpath,"|")
			_t=_tb[ybjob.ybpathnow]
			roomno_now=xkxGPS.getnextroomno(roomno_now,_t)
			ybjob.ybpathnow=ybjob.ybpathnow+1
		end
		
		-- YB到地方了
		if findstring(l,"可是你却找不到主人，把你急得直冒汗") then
		end
		if findstring(l,"你松了一口气说道：「终于回到了镖局！」") then
			alias.resetidle()
			alias.checkbusy("yb_back_ok")
		end
		if findstring(l,"你把骡子拴在镖车尾端，跟着开始.*卸货") then
			alias.checkbusy("xiehuo")
		end
		if findstring(l,"你目前还没有任何为 busyover=xiehuo 的变量设定。") then
			ybjob.biaohuo=0
			ybjob.ssyb=ybnpcname
			ybjob.needgps=0
			if setybjob==1 then ybjob.ybnpcname="镇西北" else ybjob.ybnpcname="林震南" end
			ybjob.ybstatus=3
			michen_yb.getybinfo()
			run("shang che;shang che 2;shang che 3;set 开始押镖吧")
		end
		if findstring(w[0],".+上前对着你抱拳道：「.+」\n.+道：「.+能.+的.+处，",".+上前对着你抱拳道：「.+」\n.+道：「.+能.+的.+手上，") then
		end
		if findstring(l,"你目前还没有任何为 busyover=yb_back_ok 的变量设定。") then
			alias.resetidle()
			if setybjob==1 then
				run("ne")
				roomno_now=1386
			else
				run("s")
				roomno_now=965
		end
		if findstring(l,"林震南对着你笑道：你干的好！咱们福威镖局全靠你这样的人才","镇西北对着你笑道：你干的好！神鹰镖局就要你这样的人才") then
			alias.resetidle()
			alias.checkexp("yb")
		end
		if findstring(l,"你目前还没有任何为 checkexpover=yb 的变量设定。") then
			alias.resetidle()
			--[[if add.exp>10 and mpLimited.MarkExp<me.menpaiLimited then mpLimited.MarkExp=tonumber(me.menpaiLimited) end
			if add.exp<10 then
				mpJobLimited=1
				print("统计到的yb上限为："..mpLimited.mpexp)
				mpLimited.MarkExp=tonumber(mpLimited.mpexp)
				if mpLimited.MarkTime<(os.time()-3600) then
					-- 到时间却仍然busy，推迟2分钟
					mpLimited.MarkTime=tonumber(os.time()-3600+120)
				end
			end]]
			alias.startworkflow()
		end
		-- 骡子突然发疯似的拉着镖车就跑，把你一屁股甩在地上，转眼就跑没影了
		-- 你抬头看了看天空，估算着日子，突然发觉时限已到！真倒霉
	end)
end
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function michen_yb.update()
	local  michen_yb_pre_triggerlist={
	       {name="michen_yb_pre_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    michen_yb_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(michen_yb_pre_triggerlist) do
		addtri(v.name,v.regexp,"michen_yb_pre",v.script,v.line)
	end
	local _tb2={
		"你向(镇西北|林震南)打听有关「job」的消息。\\n(.+)\\Z",
		"你向(镇西北|林震南)打听有关「放弃」的消息。\\n(.+)\\Z",
	}
	local  michen_yb_pre_m_triggerlist={
	       {name="michen_yb_pre_m_dosth2",line=2,regexp=linktri2(_tb2),script=function(n,l,w)    michen_yb_pre.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(michen_yb_pre_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"michen_yb_pre",v.script,v.line)
	end
	closeclass("michen_yb_pre")
	
	local  michen_yb_start_triggerlist={
	       {name="michen_yb_start_dosth1",regexp="^(> > > |> > |> |)(.+)$",script=function(n,l,w)    michen_yb_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(michen_yb_start_triggerlist) do
		addtri(v.name,v.regexp,"michen_yb_start",v.script,v.line)
	end
	local _tb2={
		"你驾着镖车扬了扬鞭子，高声驱赶骡子朝.+驶去。\\n.+：.+！\\Z",
		".+上前对着你抱拳道：「.+」\\n.+道：「.+能.+的.+处，.+\\Z",
		".+上前对着你抱拳道：「.+」\\n.+道：「.+能.+的.+手上，.+\\Z",
	}
	local  michen_yb_start_m_triggerlist={
	       {name="michen_yb_start_m_dosth2",line=2,regexp=linktri2(_tb2),script=function(n,l,w)    michen_yb_start.dosomething1(n,l,w)  end,},
	}
	for k,v in pairs(michen_yb_start_m_triggerlist) do
		addtri_multiline(v.name,v.regexp,"michen_yb_start",v.script,v.line)
	end
	closeclass("michen_yb_start")
	
	AddTimer("michen_yb_start_timer", 0, 0, 1, "", timer_flag.Enabled + timer_flag.Replace, "michen_yb_start.timer")
	SetTimerOption("michen_yb_start_timer", "group", "michen_yb_start_t")
	closeclass("michen_yb_start_t")
end
michen_yb.update()
