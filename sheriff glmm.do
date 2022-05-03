use "C:\Users\Dell\Downloads\pfarmdata\11-1-21 excelres.dta" 
tab will_purchase
replace will_purchase=0 if will_purchase==1
 replace will_purchase=1 if will_purchase==2
drop if will_purchase==0
cmset ID QES ALT
cmxtmixlogit RES price capacity china solarinv
cmxtmixlogit RES price china solarinv
cmxtmixlogit RES china solarinv, random(price)
cmxtmixlogit RES china solarinv, random(capacity price, correlated)
cmxtmixlogit RES, random(capacity china solarinv price, correlated)
cmxtmixlogit RES, random(capacity china solarinv price, correlated)
cmxtmixlogit RES capacity china solarinv, random(price, correlated)
ladder price
reg RES price capacity solarinv
ladder price
ladder capacity
ladder solarinv
logit RES price capacity solarinv
cmxtmixlogit RES price
cmxtmixlogit RES, (price capacity, correlated)
cmxtmixlogit RES, rand(price capacity, correlated)
matrix scale = 0,1,1,1,1
gmnl RES ASC price capacity solarinv china, group(STR) id(ID) nrep(500) scale(scale)
gmnl RES ASC price capacity solarinv china, group(STR) id(ID) scale(scale)
matrix scale = 1,1,1,1,0
gmnl RES price capacity solarinv china, group(STR) id(ID) nrep(500) scale(scale) rand(ASC)
gmnl RES price capacity solarinv china, group(STR) id(ID) scale(scale) rand(ASC)
gmnl RES price capacity solarinv china, group(STR) id(ID) scale(scale) rand(ASC) gamma(0)
matrix scale = 1,1,1,0,1
gmnl RES capacity solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0)
matrix scale = 1,1,0,1,1
gmnl RES solarinv china, group(STR) id(ID) scale(scale) rand(ASC price capacity) gamma(0)
. matrix start = b[1,1..7],0,0,b[1,8],0,b[1,9..10]
gmnl RES price capacity solarinv china, group(STR) id(ID) scale(scale) rand(ASC) gamma(0)
gmnl RES capacity solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0)
matrix b = e(b)
. matrix start = b[1,1..7],0,0,b[1,8],0,b[1,9..10]
. matrix start = e(b)
gmnl RES capacity solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) corr gamma(0) from(start)
gmnl RES capacity solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) corr gamma(0) from(start,copy)
gmnl RES capacity solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) corr gamma(0)
matrix scale = 1,1,1,0,1
gmnl RES capacity solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0)
gmnl RES price solarinv china, group(STR) id(ID) scale(scale) rand(ASC capacity) gamma(0)
matrix scale = 1,1,0,1,1
gmnl RES price china, group(STR) id(ID) scale(scale) rand(ASC capacity solarinv) gamma(0)
gmnl RES solarinv china, group(STR) id(ID) scale(scale) rand(ASC capacity price) gamma(0)s
********************
gmnl RES capacity priceage capage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0)
nlcom (WTP: (_b[capacity])/-_b[price])
nlcom (WTP: (_b[solarinv])/-_b[price])
**********************
use "C:\Users\Dell\Downloads\pfarmdata\10-26-21 Sheriffres.dta" 
summarize farming_experience
tab ease_operate
summarize high_costinvest noaccess_install insecure lackinfo low_sun qual_control
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 grpedu4 dumhinc7 dum_hcinvest3 dumnoaceinst3 insecure3 qual_control3 dumnoisepol3 dumrely7 dumrely11 easeoperadum13 easeoperadum9  dumairpoll3 dumajorsoz3 dumbackup4 dumbackup3
replace will_purchase =0 if will_purchase ==1
 replace will_purchase =1 if will_purchase ==2
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 grpedu4 dumhinc7 dum_hcinvest3 dumnoaceinst3 insecure3 qual_control3 dumnoisepol3 dumrely7 dumrely11 easeoperadum13 easeoperadum9  dumairpoll3 dumajorsoz3 dumbackup4 dumbackup3
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 grpedu4 dumhinc7 dum_hcinvest3 dumnoaceinst3 insecure3 qual_control3 dumnoisepol3 dumrely7 dumrely11 easeoperadum13 easeoperadum9  dumairpoll3
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 grpedu4 dumhinc7 dum_hcinvest3 dumnoaceinst3 insecure3 qual_control3 dumnoisepol3 dumrely7 dumrely11 easeoperadum13   dumairpoll3
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 grpedu4 dumhinc7 dum_hcinvest3 dumnoaceinst3 insecure3 qual_control3 dumnoisepol3 dumrely7 dumrely11 easeoperadum13 easeoperadum9  dumairpoll3
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 grpedu4 dumhinc7 dum_hcinvest3 dumnoaceinst3 insecure3 qual_control3 dumnoisepol3 dumrely7 dumrely11  easeoperadum9  dumairpoll3
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 grpedu4 dumhinc7 dum_hcinvest3 dumnoaceinst3 qual_control3 dumnoisepol3 dumrely7 dumrely11  easeoperadum9  dumairpoll3
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 grpedu4 dumhinc7 dum_hcinvest3 dumnoaceinst3 qual_control3 dumnoisepol3 dumrely7 dumrely11  easeoperadum9
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 grpedu4 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 dumrely7 dumrely11  easeoperadum9
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 grpedu4 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 dumrely11  easeoperadum9
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 grpedu4 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 easeoperadum9
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 grpedu4 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu3
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1
xtlogit will_purchase gendern hhsize age dumrelstat2 dum_hcinvest3 insecure3 dumlackinfo3 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1 farming_experience dumrely7 dumrely11
logit will_purchase gendern hhsize age dumrelstat2 dum_hcinvest3 insecure3 dumlackinfo3 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1 farming_experience dumrely7 dumrely11
logit will_purchase gendern hhsize age dumrelstat2 dum_hcinvest3 insecure3 dumlackinfo3 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1 farming_experience dumrely7 dumrely11 grpedu4
logit will_purchase gendern hhsize age dumrelstat2 dum_hcinvest3 insecure3 dumlackinfo3 dumhinc7 dumnoaceinst3 qual_control3 du mnoisepol3 grpedu1 farming_experience dumrely7 dumrely11
logit will_purchase gendern hhsize age dumrelstat2 dum_hcinvest3 insecure3 dumlackinfo3 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1 farming_experience dumrely7 dumrely11
tab use_solar
logit will_purchase gendern hhsize age dumrelstat2 dum_hcinvest3 insecure3 dumlackinfo3 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1 farming_experience dumrely7 dumrely11 dumairpoll3
logit will_purchase gendern hhsize age dumrelstat2 dum_hcinvest3 insecure3 dumlackinfo3 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1 farming_experience dumrely7 dumrely11 dumairpoll3 dumairpoll1 dumairpoll3
logit will_purchase gendern hhsize age dumrelstat2 dum_hcinvest3 insecure3 dumlackinfo3 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1 farming_experience dumrely7 dumrely11  dumairpoll1
nlcom (WTP: (_b[china])/-_b[price])
**********************
do "C:\Users\Dell\AppData\Local\Temp\STD111c_000000.tmp"
cmset ID QES ALT
xtlogit will_purchase gendern hhsize age dumrelstat2 dumhinc2 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1 will_purchase gendern hhsize age dumrelstat2 dumhinc2 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1
tab will_purchase
xtlogit will_purchase gendern hhsize age
xtlogit will_purchase gendern
xtlogit will_purchase hhsize
xtlogit will_solarinv age
xtlogit will_purchase dumhinc7 dumaware_source3 dumaware_source4
logit will_purchase gendern hhsize age dumrelstat2 dumhinc2 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1
xtlogit will_purchase gendern hhsize age dumrelstat2 dumhinc2 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1
xtlogit will_purchase gendern hhsize age dumrelstat2 dum_hcinvest3 insecure3 dumlackinfo3 qual_control3 dumnoisepol3 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1 farming_experience
xtlogit will_purchase gendern hhsize age dumrelstat2 dum_hcinvest3 insecure3 dumlackinfo3 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1 farming_experience dumrely7 dumrely11
logit will_purchase gendern hhsize age dumrelstat2 dum_hcinvest3 insecure3 dumlackinfo3 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1 farming_experience dumrely7 dumrely11 grpedu4
xtlogit will_purchase gendern hhsize age dumrelstat2 dum_hcinvest3 insecure3 dumlackinfo3 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1 farming_experience dumrely7 dumrely11 grpedu4
do "C:\Users\Dell\AppData\Local\Temp\STD111c_000000.tmp"
drop if will_purchase==0
do "C:\Users\Dell\AppData\Local\Temp\STD111c_000000.tmp"
 gmnl RES price solarinv china, group(STR) id(ID) scale(scale) rand(ASC capacity) gamma(0)
 gmnl RES price capacity china, group(STR) id(ID) scale(scale) rand(ASC solarinv) gamma(0)
 gmnl RES price capacity solarinv, group(STR) id(ID) scale(scale) rand(ASC china) gamma(0)
matrix scale = 1,1,0,1,1
 gmnl RES capacity china, group(STR) id(ID) scale(scale) rand(ASC price solarinv) gamma(0)
gen capage= capacity*age
matrix scale = 1,1,1,0,1,1
 gmnl RES capacity capage china, group(STR) id(ID) scale(scale) rand(ASC price solarinv) gamma(0)
 gmnl RES capacity capage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0)
gen priceage = price*age
matrix scale = 1,1,1,1,0,1
 gmnl RES capacity priceage capage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0)
matrix scale = 1,1,1,1,1,0,1
 gmnl RES capacity priceage capage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0)
genchina= gendern*china
gen genchina= gendern*china
matrix scale =1,1,1,1,1,1,0,1
 gmnl RES capacity priceage genchina capage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0)
gen priceasc= price*ASC
 gmnl RES capacity priceasc genchina capage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0)
 gmnl RES capacity priceage capage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0) seed(123)
matrix scale =1,1,1,1,1,0,1
 gmnl RES capacity priceage capage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0) seed(123)
gen solinvage= solarinv*age
matrix scale =1,1,1,1,1,1,1,0,1
 gmnl RES capacity priceage genchina solinvage capage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0)
matrix scale =1,1,1,1,1,1,0,1
 gmnl RES capacity priceage solinvage capage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0)
matrix scale =1,1,1,1,1,0,1
 gmnl RES capacity priceage capage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0)
matrix scale =1,1,1,1,0,1
 gmnl RES capacity priceage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0)
matrix scale =1,1,1,1,1,0,1
 gmnl RES capacity priceage capage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0) seed(124)
 gmnl RES capacity priceage capage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0) seed(100)
 gmnl RES capacity priceage capage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0)
 gmnl RES capacity priceage capage solarinv china, group(STR) id(ID) scale(scale) rand(ASC price) gamma(0) intpoints(1000)
nlcom (WTP: (_b[capacity])/-_b[price])
nlcom (WTP: (_b[solarinv])/-_b[price])
nlcom (WTP: (_b[china])/-_b[price])
tab gender
replace gendern = 0 if gendern ==1
replace gendern = 1 if gendern ==2
xtlogit will_purchase gendern hhsize age dumrelstat2 dum_hcinvest3 insecure3 dumlackinfo3 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1 farming_experience dumrely7 dumrely11
doedit "C:\Users\Dell\Downloads\pfarmdata\sheriff glmm.do" 
do "C:\Users\Dell\AppData\Local\Temp\STD23a4_000000.tmp"
do "C:\Users\Dell\AppData\Local\Temp\STD23a4_000000.tmp"
do "C:\Users\Dell\AppData\Local\Temp\STD23a4_000000.tmp"
xtlogit will_purchase gendern hhsize age dumrelstat2  dumhinc7 dumnoisepol2 grpedu4 farming_experience dumrely7 dumrely11 dumairpoll1
xtlogit will_purchase gendern hhsize age dumrelstat2 dumhinc7 dumnoisepol2 grpedu4 farming_experience dumrely7 dumairpoll1
xtlogit will_purchase gendern hhsize age dumrelstat2  dumhinc7 dumnoisepol1 grpedu4 farming_experience dumrely7 dumrely11 dumairpoll1
xtlogit will_purchase gendern hhsize age dumrelstat2  dumhinc7 dumnoisepol1 grpedu4 farming_experience dumrely7 dumrely11 dumairpoll3
xtlogit will_purchase gendern hhsize age dumrelstat2  dumhinc7 grpedu4 farming_experience dumrely7 dumrely11 dumairpoll1
xtlogit will_purchase gendern hhsize age dumrelstat2  dumhinc7 grpedu4 farming_experience dumrely7 dumrely11 dumairpoll2
xtlogit will_purchase gendern hhsize age dumrelstat2  dumhinc7 grpedu4 farming_experience dumrely7 dumrely11 dumairpoll1
xtlogit will_purchase gendern hhsize age dumrelstat2  dumhinc7 grpedu4 farming_experience dumrely7 dumrely11 dumnoisepol3
xtlogit will_purchase gendern hhsize age dumrelstat2 dumhinc7 dumnoaceinst3 qual_control3 dumnoisepol3 grpedu1 farming_experience dumrely7 dumrely11
xtlogit will_purchase gendern hhsize age dumrelstat2 dumhinc7 qual_control3 dumnoisepol3 grpedu4 farming_experience dumrely7 dumrely11
xtlogit will_purchase gendern hhsize age dumrelstat2 dumhinc7 qual_control3 dumnoisepol1 grpedu4 farming_experience dumrely7 dumrely11 dumairpoll1
xtlogit will_purchase gendern hhsize age dumrelstat2 dumhinc7 dumnoisepol1 grpedu4 farming_experience dumrely7 dumrely11 dumairpoll1
xtlogit will_purchase gendern hhsize age dumrelstat2 dumhinc7 dumnoisepol1 grpedu4 farming_experience dumrely7 dumrely11 dumairpoll1
xtlogit will_purchase gendern hhsize age dumrelstat2 dumhinc7 dumnoisepol3 grpedu4 farming_experience dumrely7 dumrely11 dumairpoll1
do "C:\Users\Dell\AppData\Local\Temp\STD23a4_000000.tmp"s
use "C:\Users\Dell\Downloads\pfarmdata\10-26-21 Sheriffres.dta" 
br
logit will_purchase gendern hhsize age dumrelstat2 dumhinc7 dumnoisepol3 grpedu4 farming_experience dumrely7 dumrely11 dumairpoll1
replace will_purchase=0 if will_purchase==1
 replace will_purchase=1 if will_purchase==2
logit will_purchase gendern hhsize age dumrelstat2 dumhinc7 dumnoisepol3 grpedu4 farming_experience dumrely7 dumrely11 dumairpoll1
logit will_purchase gendern hhsize age dumrelstat2 dumhinc7 dumnoisepol3 grpedu4 farming_experience dumrely7 dumrely11 dumairpoll1