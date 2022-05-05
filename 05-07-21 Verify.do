clear all
drop _all   
macro drop _all
sca drop _all
mat drop _all
clear
set more off 
set seed 1000
scalar User = "Sheriff"

if User == "Ayo" {
	cd "C:\Users\Stata 16"
	}
else if User == "Sheriff" {
	cd 	"C:\Users\DELL\Desktop\FutureLearn\Research\Ayo-UCL\Methodology\Newdo\"
	}
use "resfull4data_12_10_20", replace
use  "C:\Users\DELL\Desktop\FutureLearn\Research\Ayo-UCL\Methodology\Newdo\resfull4data_12_10_20" 

*************************************
*REPLICATION OF METHODS- 15th April, 2021
*************************************
*DESCRIPTIVE AND SUMMARY STATISTICS
clear all
*In order ro tun a descriptive analysis, we opt for a cross sectional/basic form of the data
use "C:\Users\DELL\Desktop\FutureLearn\Research\Methodology\Newdo\4-5-21 SPSSRes" 
*************************
*DATA REFERENCING FOR SPSSres
*************************
rename A1 backup_type
rename A3 backup_weekend
rename A4 gen_exp
rename A7 ibedc_weekday
rename A8 ibedc_weekend
rename A10 ibedc_exp
rename B1 elec_avail
rename B2 ibedc_satis
rename D1 housetype_B1
rename D2 housetype_B2/
rename D3 housetype_B3
rename D4 housetype_B4
rename E1 children
rename E3 hinc
rename E6 occupation
rename E4 hheduc
rename E5 hhsize
rename Gender gender
rename Age age
rename Marital_Status marital_status
*We us the tabulate command to get the frequencies and percentages
*TABLE A1- Summary statistics of respondent socioeconomic characteristics (N = 649)
tabulate hhsize 
tabulate children 
tabulate gender 
tabulate marital_status 
tabulate age 
tabulate urban 
tabulate hinc 
tabulate occupation
tabulate hheduc
*TABLE A2- Summary statistics of respondent energy preference (N = 649).  
tabulate backup_type
tabulate petrol_only
tabulate diesel_only
tabulate solar_total
tabulate petrol_solar_inverter
tabulate gen_exp
tabulate ibedc_exp
tabulate ibedc_weekend
tabulate ibedc_weekday
tabulate backup_weekend
tabulate elec_avail
tabulate ibedc_satis
*TABLE A3- Distribution of choices among alternatives
tabulate housetype_B1
tabulate housetype_B2
tabulate housetype_B3
tabulate housetype_B4
*Table 2: Estimation results, conditional logit
clear all
*CONDITIONAL LOGIT MODEL
use  "C:\Users\DELL\Desktop\FutureLearn\Research\Ayo-UCL\Methodology\Newdo\resfull4data_12_10_20" 
*************************
*DATA REFERENCING FOR resfull4data_12_10_20
*************************
rename solar backup_si
gen backup_sol = backup_si
replace backup_sol= 2 if backup_sol==0
replace backup_sol=0 if backup_sol==1
replace backup_sol =1 if backup_sol==2
drop backup_si
rename backup_sol backup_si
tab backup_si
*******************
rename none no_pollution
rename selling energy_trade01
rename low low_pollution
********************

********************
gen new_solar=backup
label define labelnew_solar3 0 "Otherwise - Generator or Inverter" 1 "Solar is present in choice set"
label values new_solar labelnew_solar3
replace new_solar =0 if new_solar==1
replace new_solar = 1 if new_solar==2
* Change gender to dummy variable labeled 0 and 1
gen gender2 = gender
replace gender2 = 0 if gender==1
replace gender2= 1 if gender==2
label define labelgender2 0 "Male" 1 "Female"
label values gender2 labelgender2
tab gender2
tab gender2, nolabel

****************
*Table 2: Estimation results, conditional logit
****************
*We cmset the data to declare it a choice dataset
cmset id t alt
*Correlation analysis to have a view of the likely relationships
correlate res backup no_pollution energy_trade01 nhouseprice nbackupprice
*Base Model
cmclogit res backup no_pollution energy_trade01 nhouseprice nbackupprice
*Indicating a base class
cmclogit res backup_si no_pollution energy_trade01 nhouseprice nbackupprice, base(3)
***inuding case-specific variables to generate model_2 and model_3
*Model_2
cmclogit res backup_si no_pollution energy_trade01 nhouseprice nbackupprice, base(3) casevars(age gender2) altwise
*All attributes but backup_si were significant at all levels (i.e 1,5 & 10%).
*stored as matrix b234
cmclogit res backup_si no_pollution energy_trade01 nhouseprice nbackupprice, base(3) casevars(age gender2 hinc hheduc hhsize children) altwise vce()
matrix b234 = e(b)
estimates store model_2
*Model_3
cmclogit res new_solar low_pollution buying nhouseprice nbackupprice
*Adding a base and casevars
cmclogit res new_solar low_pollution buying nhouseprice nbackupprice, base(3)
cmclogit res new_solar buying low_pollution nhouseprice nbackupprice, base(3) casevars(age gender2) altwise
*All attributes but new_solar were significant at all levels (i.e 1,5 & 10%).
*elec_exp was sig. for optionA
*stored as matrix b260
cmclogit res new_solar low_pollution buying nhouseprice nbackupprice, base(3) casevars(ibedc_exp elec_availn elec_expn backup_interest  phealth_risk) altwise vce()
 matrix b260 = e(b)
 estimates store model_3
*We can use AIC and BIC to determine which of these models fits best.
* Modelc has smaller values of AIC and BIC and thus it fits best
estimates stats model_2 model_3
*Trying out the Principal Components 
cmclogit res new_solar low_pollution buying nhouseprice nbackupprice, base(3) casevars(ibedc_exp elec_availn pc1 pc2 kc1 zc1 zc2) altwise vce()
*Trading Analysis
cmclogit res new_solar low_pollution buying nhouseprice nbackupprice, base(3) casevars(selling_additiol lower_expenses) altwise vce() 
cmclogit res buying, base(3) casevars(selling_additiol lower_expenses reduce_reliance constant_supply) altwise vce() 
*************
*Table 3: Mixed Logit Estimates of Household Choices
*************
clear all
use  "C:\Users\DELL\Desktop\FutureLearn\Research\Ayo-UCL\Methodology\Newdo\resfull4data_12_10_20" 
*in order to declare the data as a choice data set, we have to input the code;
cmset id t alt
*PANEL MIXED LOGIT MODEL
*We need to delabel the alt variable before runnung the model because stata does not run margin when the alt variable is labelled.
 label values alt .
 *The RPL was first estimated with all attributes being random and normally distributed based on the recommendation by sagebiel (2017) and Meijer and Rouwendal (2006). However, the iteration was backed up when estimated along case specific variables. According to Sillano&Ortúzar (2005), fixing the cost parameter clearly produces biased estimates . Many other had opined that the cost paramters can be non-random  Morrison M and Nalder C. (2009); Carlsson F and Martinsson P. (2008) and; Revelt D and Train K (1998). Hence, the cost parameters were random while other attributes were fixed to avoid biased 	WTP  estimates
The variables no_pollution and low_pollution: buying and energy_trade01 should not be included in a single model to avoid multicollinearity
*We first start with a simple model
cmxtmixlogit res, random(backup_si new_solar)
*Then we add some attributes, the speed of the analysis decreases as variables increases
*cmxtmixlogit res, random(backup_si new_solar no_pollution buying)
cmxtmixlogit res, random(backup_si new_solar low_pollution energy_trade01 nhouseprice nbackupprice)
*Then, we added some variables and made option C the base alternative
*Not converging
   /*cmxtmixlogit res, random(solar none selling nhouseprice nbackupprice) base(3)
    cmxtmixlogit res, random(solar inverter none selling nhouseprice nbackupprice) base(3) intpoints(200)*/
 *Not coverging
   *cmxtmixlogit res, random(new_solar low_pollution buying nhouseprice nbackupprice ) base(3)
 cmxtmixlogit res, random(backup_si no_pollution energy_trade01 nhouseprice nbackupprice) base(3) altwise intpoints(1000)
 *Specifying the model according to Siliano to avoid biased WTP estimates
*Model A. All attributes but backup_si were significant at all levels (i.e 1,5 & 10%). Int points was 614
   cmxtmixlogit res backup_si no_pollution selling, random(nhouseprice nbackupprice) base(3)
*Model B. All attributes but new_solar were significant at all levels (i.e 1,5 & 10%). Int points was 614
    cmxtmixlogit res new_solar buying low_pollution, random(nhouseprice nbackupprice) base(3)
* Adding casevars to both models step-wisely
  cmxtmixlogit res backup_si no_pollution energy_trade01, random(nhouseprice nbackupprice) base(3) casevars(age gender2) altwise
 cmxtmixlogit res new_solar buying low, random(nhouseprice nbackupprice) base(3) casevars(age gender) altwise
 ********
 *Including case-specific variables in both models
*All attributes but solar were significant at all levels (i.e 1,5 & 10%). Int points was 606
*elec_exp and age were significant
*stored as matrix b888
cmxtmixlogit res backup_si no_pollution energy_trade01, random(nhouseprice nbackupprice) base(3) casevars(age gender2 hinc hheduc hhsize children) altwise
matrix b888 = e(b)
*All attributes but inverter were significant at all levels (i.e 1,5 & 10%). Int points was 612
*hhedu and children were sig.
*stored as matrix b777
cmxtmixlogit res new_solar low_pollution buying, random(nhouseprice nbackupprice) base(3) casevars(ibedc_exp elec_availn elec_expn backup_interest phealth_risk) altwise
 matrix b777 = e(b)
 **************
*Test for stability of models by setting intpoints at 1000
*All attributes but solar were significant at all levels (i.e 1,5 & 10%). Int points was 606
* age was significant
cmxtmixlogit res backup_si no_pollution energy_trade01, random(nhouseprice nbackupprice) base(3) casevars(age gender2 hinc hheduc hhsize children) aoltwise intpoints(1000)
estimates store modela
matrix b111 = e(b)
*We compare the coefficient vector matrix b888  with the matrix b111 results using the mreldif() function, which computes relative differences between vectors (or between matrices). We see that there is a maximum relative difference between the coefficients from the two estimations of about 5.5%. It is expected that the relative difference would become more insignificant as the intpoints increases
display mreldif(b888, b111)
*All attributes but new_solar were significant at all levels (i.e 1,5 & 10%). Int points 1000
 *elec_exp is the only sig. variable
*stored as matrix b999
cmxtmixlogit res new_solar low_pollution buying, random(nhouseprice nbackupprice) base(3) casevars(ibedc_exp elec_availn elec_expn backup_interest  phealth_risk) altwise intpoints(1000)
estimates store modelb
matrix b999 = e(b)
*We compare the coefficient vector matrix b777  with the matrix b999 results using the mreldif() function, which computes relative differences between vectors (or between matrices). We see that there is a maximum relative difference between the coefficients from the two estimations of about 1.2%. It is expected that the relative difference would become more insignificant as the intpoints increases
display mreldif(b777, b999)
*We can use AIC and BIC to determine which of these models fits best.
* Modela has smaller values of AIC and BIC and thus it fits best
estimates stats modela modelb

*cmxtmixlogit res, random (buying) base(3) casevars(selling_additiol lower_expenses reduce_reliance constant_supply) altwise  intpoints(1000)vce() 
*MARGIN FOR modela ATTRIBUTES
margins, at(backup_si=0) outcome(1 2 3)
marginsplot 
margins, at(backup_si=1) outcome(1 2 3)
marginsplot
margins, at(nhouseprice=(0)) outcome( 1 2 3)
marginsplot
margins, at(nbackupprice=(2)) outcome( 1 2 3)
marginsplot
*MARGINS FOR modela CASE-SPECIFIC CONTINOUS VARIABLE
margins, at(elec_expn=(2(4)20))
marginsplot
margins, at(backup_interest=(0(3)15))
marginsplot
margins, at(phealth_risk=(5(5)35))
marginsplot, noci
margins, at(elec_exp =(1(1)6)) subpop(if t==1)
marginsplot, noci
margins, at(elect_exp =(1(1)6)) subpop(if t==2)
marginsplot, noci
margins, at(elec_exp =(1(1)6)) subpop(if t==3)
marginsplot, noci
margins, at(ele_exp =(1(1)6)) subpop(if t==4)
marginsplot, noci
margins, at(elec_availn =(1(1)5))
marginsplot, noci
************************
*Table 5: Estimation results, latent class logit
************************
*LCLOGIT
ssc install lclogit2
clear all
use  "C:\Users\DELL\Desktop\FutureLearn\Research\Ayo-UCL\Methodology\Newdo\resfull4data_12_10_20" 
*qui tab alt, gen(asc)
lclogit2 res , group(str) rand(backup_si no_pollution energy_trade01 nhouseprice nbackupprice asc1 asc2 ) nclasses(3) id(id) memb (age gender2 hinc hheduc hhsize children elec_expn elec_availn backup_interest)
matrix start = e(b)
lclogitml2 res , group(str) rand(backup_si no_pollution energy_trade01 nhouseprice nbackupprice asc1 asc2 ) nclasses(3) id(id) memb (age gender2 hinc hheduc hhsize children elec_expn elec_availn ibedc_exp backup_interest) from(start)
estimates store modele
lclogitwtp2, cost(nhouseprice)
lclogitwtp2, cost(nbackupprice)
*This model did not converge
*lclogit2 res , group(str) rand(inverter low buying nhouseprice nbackupprice asc1 asc2 ) nclasses(3) id(id)
*doesn't converge without inverter
*lclogit2 res, group(str) rand(low buying nhouseprice nbackupprice asc1 asc2 ) nclasses(3) id(id)
*converges with low 
 *lclogit2 res, group(str) rand(low nhouseprice nbackupprice asc1 asc2 ) nclasses(3) id(id)
*low and inverter converges
 *lclogit2 res, group(str) rand(low inverter nhouseprice nbackupprice asc1 asc2 ) nclasses(3) id(id)
*buying converges with modela

************************
*Table 6: Number of latent classes
************************
*Models with 4,5&6 classes were not converging
*Two classes
lclogit2 res , group(str) rand(backup_si no_pollution energy_trade01 nhouseprice nbackupprice asc1 asc2 ) nclasses(2) id(id)
matrix start = e(b)
lclogitml2 res , group(str) rand(backup_si no_pollution energy_trade01 nhouseprice nbackupprice asc1 asc2 ) nclasses(2) id(id) from(start)
estimates store modele
*Three classes
lclogit2 res , group(str) rand(backup_si no_pollution energy_trade01 buying nhouseprice nbackupprice asc1 asc2 ) nclasses(3) id(id)
matrix sthat = e(b)
lclogitml2 res , group(str) rand(backup_si no_pollution energy_trade01 buying nhouseprice nbackupprice asc1 asc2 ) nclasses(3) id(id) from(sthat)
estimates store modelk
*We can use AIC and BIC to determine which of these models fits best.
* Modela has smaller values of AIC and BIC and thus it fits best
estimates stats modelk modele, n(2183)
***********************
drop pclres
drop presrpl
drop pr
drop pr1
drop pr2
drop pr3
drop cp1
drop cp2 
drop cp3
drop predictedres
************************
*Table 7: Measures of fit for estimated models
************************
*predicting values of res from CL estimates
cmclogit res backup_si no_pollution energy_trade01 nhouseprice nbackupprice, base(3)
predict pclres
 cmxtmixlogit res, random(backup_si no_pollution energy_trade01 nhouseprice nbackupprice) base(3) altwise intpoints(1000)
*predicting values of res from RPL estimates
predict presrpl
*predicting values of res from LCL estimates
 lclogit2 res , group(str) rand(backup_si no_pollution energy_trade01 buying nhouseprice nbackupprice asc1 asc2 ) nclasses(3) id(id)
  matrix start = e(b)
lclogitml2 res , group(str) rand(backup_si no_pollution energy_trade01 buying nhouseprice nbackupprice asc1 asc2 ) nclasses(3) id(id) from(start)
 predict preslcl
*As can be seen, the mean highest posterior probability is about 0.9 , meaning that the model does very well in distinguishing among different underlying taste patterns for the observed choice behavior. We next examine the model’s ability to make in-sample predictions of the actual choice outcomes. For this purpose, we first classify a respondent as a member of class c if class c gives him or her highest posterior membership probability. Then for each subsample of such respondents, we predict the unconditional probability of actual choice and the probability of actual choice conditional on being in class c:
 lclogitpr2 pr, pr
*Kindly access the excel file named "model prediction 06-3-21" to view the comparison of the accuracies
 Accuracy of predictions
 60% accuracy
 *latent class
  gen npr=pr
  replace npr = 0 if npr<0.45
  replace npr =1 if npr>0.6
  *Mixed logit
  gen nrpl=presrpl
  replace nrpl = 0 if nrpl<0.45
  replace nrpl =1 if nrpl>0.6
  *CL
  gen ncl=pclres
  replace ncl = 0 if ncl<0.45
  replace ncl =1 if ncl>0.6
  
  70% accuracy
  *latent class
  gen sevpr=pr
  replace sevpr = 0 if sevpr<0.45
  replace sevpr =1 if sevpr>0.7
  *Mixed logit
  gen sevrpl=presrpl
  replace sevrpl = 0 if sevrpl<0.45
  replace sevrpl =1 if sevrpl>0.7
  *CL
  gen sevcl=pclres
  replace sevcl = 0 if sevcl<0.45
  replace sevcl =1 if sevcl>0.7
  
  80% accuracy
  *latent class
  gen acpr=pr
  replace acpr = 0 if acpr<0.45
  replace acpr =1 if acpr>0.8
  *Mixed logit
  gen acrpl=presrpl
  replace acrpl = 0 if acrpl<0.45
  replace acrpl =1 if acrpl>0.8
  *CL
  gen accl=pclres
  replace accl = 0 if accl<0.45
  replace accl =1 if accl>0.8
 
********************************************
*Table 8: Linear regression of the choice probabilities of the RPL on the LCL.
*******************************************
regress pr presrpl

**************************************
*Table 9: Willingness to Pay Values for House
**************************************
____________________
*Conditional Logit
____________________
cmclogit res backup_si no_pollution energy_trade01 nhouseprice nbackupprice, base(3) casevars(age gender2 hinc hheduc hhsize children) altwise vce()
*How much will the respondnets pay for a house that has a solar and inverter as backup energy?
nlcom (WTP:( _b[backup_si])/-_b[nhouseprice])
*Similarly, how much houseprice are respondents willing to sacrifice for living a district with no pollution is given by:
nlcom (WTP: ( _b[no_pollution])/-_b[nhouseprice])
*How much houseprice are respondents willing to pay if they can sell energy is given by:
nlcom (WTP: ( _b[energy_trade01])/-_b[nhouseprice])
cmclogit res new_solar low_pollution buying nhouseprice nbackupprice, base(3) casevars(ibedc_exp elec_availn elec_expn backup_interest  phealth_risk) altwise vce()
*How much will the respondnets pay for a house that has a solar backup only?
nlcom (WTP:( _b[new_solar])/-_b[nhouseprice])
*____
*Random Parameters Logit
*_________
cmxtmixlogit res backup_si no_pollution energy_trade01, random(nhouseprice nbackupprice) base(3) casevars(age gender2 hinc hheduc hhsize children) altwise intpoints(1000)
nlcom (WTP:( _b[backup_si])/-_b[nhouseprice])
nlcom (WTP: ( _b[no_pollution])/-_b[nhouseprice])
nlcom (WTP: ( _b[energy_trade01])/-_b[nhouseprice])
cmxtmixlogit res new_solar low_pollution buying, random(nhouseprice nbackupprice) base(3) casevars(ibedc_exp elec_availn elec_expn backup_interest  phealth_risk) altwise intpoints(1000)
nlcom (WTP:( _b[new_solar])/-_b[nhouseprice])
*_________________________
*Latent class Logit
*________________________
lclogit2 res , group(str) rand(backup_si no_pollution energy_trade01 buying nhouseprice nbackupprice asc1 asc2 ) nclasses(3) id(id)
  matrix start = e(b)
lclogitml2 res , group(str) rand(backup_si no_pollution energy_trade01 buying nhouseprice nbackupprice asc1 asc2 ) nclasses(3) id(id) from(start)
lclogitwtp2, cost(nhouseprice)

**************************************
*Table 10: Willingness to Pay Values for Backup
**************************************
___________________
*Conditional Logit
____________________
cmclogit res backup_si no_pollution energy_trade01 nhouseprice nbackupprice, base(3) casevars(age gender2 hinc hheduc hhsize children) altwise vce()
*So, for example, to calculate the willingness to sacrifice more money for a solar backup energy rather than generator, the nlcom command will be the following:
nlcom (WTP:( _b[backup_si])/-_b[nbackupprice])
*Similarly, how much backup price are respondents willing to sacrifice for living a district with no pollution is given by:
nlcom (WTP: ( _b[no_pollution])/-_b[nbackupprice])
*How much backup price are respondents willing to pay if they can sell energy is given by:
nlcom (WTP: ( _b[energy_trade01])/-_b[nbackupprice])
cmclogit res new_solar low_pollution buying nhouseprice nbackupprice, base(3) casevars(ibedc_exp elec_availn elec_expn backup_interest  phealth_risk) altwise  vce() 
*So, for example, to calculate the willingness to sacrifice more money for a solar backup only rather than generator, this will be:
nlcom (WTP:( _b[new_solar])/-_b[nbackupprice)
________________________
*Random Parameters Logit
________________________
cmxtmixlogit res backup_si no_pollution energy_trade01, random(nhouseprice nbackupprice) base(3) casevars(age gender2 hinc hheduc hhsize children) aoltwise intpoints(1000)
nlcom (WTP:( _b[backup_si])/-_b[nbackupprice])
nlcom (WTP: ( _b[no_pollution])/-_b[nbackupprice])
nlcom (WTP: ( _b[energy_trade01])/-_b[nbackupprice])
cmxtmixlogit res new_solar low_pollution buying, random(nhouseprice nbackupprice) base(3) casevars(ibedc_exp elec_availn elec_expn backup_interest  phealth_risk) altwise intpoints(1000)
nlcom (WTP:( _b[new_solar])/-_b[nbackupprice])
________________________
*Latent Class Logit
________________________
lclogit2 res , group(str) rand(backup_si no_pollution energy_trade01 buying nhouseprice nbackupprice asc1 asc2 ) nclasses(3) id(id)
  matrix start = e(b)
lclogitml2 res , group(str) rand(backup_si no_pollution energy_trade01 buying nhouseprice nbackupprice asc1 asc2 ) nclasses(3) id(id) from(start)
lclogitwtp2, cost(nbackupprice)

 *Conditional WTP estimates
 *RPL
 *Houseprice for backup_si
 gen cond_slrpl= 2.7882*presrpl
 summarize cond_slrpl
 *Houseprice for no_pollution
 gen cond_norpl= 37.28687*presrpl
 summarize cond_norpl
 *Houseprice for energy_trade01
 gen cond_sellrpl= 17.55121*presrpl
 summarize cond_sellrpl
 *LCL
*Houseprice for backup_si
 gen cond_sllcl= -0.466*pr
 summarize cond_sllcl
  *Houseprice for buying
 gen cond_buycl= -4.333*pr
 summarize cond_buycl
  *Houseprice for energy_trade01
 gen cond_sellcl= -10*pr
 summarize cond_sellcl
 *Houseprice for no_pollution
 gen cond_nolcl= 8.0043*pr
 summarize cond_nolcl

 
 
 *Conditional WTP estimates
 *RPL
 *Backupprice for backup_si
 gen cdbp_slrpl= 0.05992*presrpl
 summarize cdbp_slrpl
 *Backupprice for no_pollution
 gen cdbp_norpl= 0.8013*presrpl
 summarize cdbp_norpl
 *Backupprice for energy_trade01
 gen cdbp_sellrpl= 0.3772*presrpl
 summarize cdbp_sellrpl
 *LCL
 bacckupprice for backup_si
 gen cdbp_sllcl= 0.213*pr
 summarize cdbp_sllcl
 *backupprice for buying
 gen cond_buycl= -0.65*pr
 summarize cdbp_buycl
 *bacckupprice for energy_trade01
 gen cdbp_sellcl= -0.38*pr
 summarize cdbp_sellcl
 *bacckupprice for no_pollution
 gen cdbp_nolcl= 3.67*pr
 summarize cdbp_nolcl
 
*********************
*GMNL
********************
gmnl res backup_si no_pollution energy_trade01 nhouseprice nbackupprice,  group(str) id(id) nrep(500)
gmnl res, rand (backup_si no_pollution energy_trade01 nhouseprice nbackupprice)  group(str) id(id) nrep(500) gamma(0)
*gmnl res lower_expenses##(energy_trade01) reduce_reliance##(energy_trade01) constant_supply##(energy_trade01), group(str) id(id) nrep(500) gamma(0)
*gmnl res energy_trade01##(selling_additiol lower_expenses reduce_reliance constant_supply), group(str) id(id) nrep(500) gamma(0)
gen trade_selladd= energy_trade01*selling_additiol
gen trade_lowerexp= energy_trade01*lower_expenses
gen trade_redreliance =energy_trade01*reduce_reliance
gen trade_consupply= energy_trade01*constant_supply
tabulate trade_selladd, generate(trselad)
tabulate trade_lowerexp, generate(trlwexp)
tabulate trade_redreliance, generate(trredrl)
tabulate trade_consupply, generate(trconsup)
gmnl res trselad5 trlwexp5 trconsup5 trredrl5, rand (energy_trade01)  group(str) id(id) nrep(500) gamma(0)
gen trade_selladd2= energy_trade01*nselling_add
gen trade_lowerexp2= energy_trade01*nlow_expense
gen trade_redreliance2 =energy_trade01*nreduce_reliance
gen trade_consupply2= energy_trade01*nconst_supply
gen trade_age= energy_trade01*age
gen trade_hinc= energy_trade01*hinc
gen trade_hheduc= energy_trade01*hheduc
gen trade_hhsize= energy_trade01*hhsize
gen trade_child= energy_trade01*children
gmnl res trade_selladd2 trade_lowerexp2 trade_redreliance2 trade_consupply2, rand (energy_trade01)  group(str) id(id) nrep(500) gamma(0)
gmnl res trade_selladd2 trade_lowerexp2 trade_redreliance2 trade_consupply2 trade_hinc trade_age trade_hheduc trade_hhsize trade_child, rand (energy_trade01)  group(str) id(id) nrep(500) gamma(0)
gmnl res trade_hinc trade_age trade_hheduc trade_hhsize trade_child, rand (energy_trade01)  group(str) id(id) nrep(500) gamma(0)

global xlist1 trade_selladd2 trade_lowerexp2 trade_redreliance2 trade_consupply2 trade_hinc trade_age trade_hheduc trade_hhsize trade_child energy_trade01
global xlist2 trade_selladd2 trade_lowerexp2 trade_redreliance2 trade_consupply2 trade_hinc trade_age trade_hheduc trade_hhsize trade_child
* Estimate SH model
gmnl res $xlist1, group(str) id(id) vce(robust)
* Estimate G-MNL model with normally distributed intercept
gmnl res $xlist2, group(str) id(id) rand(energy_trade01) gamma(0) vce(robust)

tabulate selling_additiol, generate(selad)
tabulate lower_expenses, generate(lwexp)
tabulate reduce_reliance, generate(redrl)
tabulate constant_supply, generate(consup)

gen trade_selladd2= energy_trade01*ns
gen trade_lowerexp2= energy_trade01*nlow_expense
gen trade_redreliance2 =energy_trade01*nreduce_reliance
gen trade_consupply2= energy_trade01*nconst_supply

gmnl res trselad6 trredrl6 trconsup6 trlwexp6, rand (energy_trade01)  group(str) id(id) nrep(500) gamma(0)
 
gmnl res trselad6 trredrl6 trconsup6 trlwexp6 trade_hinc trade_age trade_hheduc trade_hhsize trade_child, rand (energy_trade01)  group(str) id(id) nrep(500) gamma(0)

*Trading classification
use  "C:\Users\DELL\Desktop\FutureLearn\Research\Ayo-UCL\Methodology\Newdo\resfulldata-3" 
60% accuracy
 *latent class
gen classpr=pr2
replace classpr = 0 if pr2<0.45
replace classpr =1 if pr2>0.55
*******************************  
gen newclass1= pr1
replace newclass1=1 if pr1>0.45
replace newclass1=0 if pr1<0.45
tab hinc if newclass1==1
*tab id if newclass1 = 1
gen newclass2= pr2
replace newclass2=1 if pr2>0.45
replace newclass2=0 if pr2<0.45
tab hinc if newclass2==1

tab hinc
tab hinc if newclass2==1 & t==1
 tab hinc if newclass1==1 & t==1
tab hinc if pr1>0.8
 tab hinc if pr1>0.7
 tab hinc if pr2>0.7
 tab hinc if pr3>0.7
 tab hhsize if pr1>0.7
 tab hinc if pr2>0.7
 tab hhsize if pr1>0.7
 tab hhsize if pr1>0.7
 tab hhsize if pr2>0.7
 tab hhsize if pr2>0.7
 
 ************************
spearman energy_trade01 lower_expenses reduce_reliance constant_supply selling_additiol
logit energy_trade01 lower_expenses reduce_reliance constant_supply selling_additiol
logit energy_trade01 lower_expenses reduce_reliance constant_supply selling_additiol if t==1
logit energy_trade01 lower_expenses reduce_reliance constant_supply selling_additiol if t==2
logit energy_trade01 lower_expenses reduce_reliance constant_supply selling_additiol if t==3
logit energy_trade01 lower_expenses reduce_reliance constant_supply selling_additiol if t==4
logit energy_trade01 lower_expenses reduce_reliance constant_supply selling_additiol if hinc ==1
logit energy_trade01 lower_expenses reduce_reliance constant_supply selling_additiol if hinc ==2
logit energy_trade01 lower_expenses reduce_reliance constant_supply selling_additiol if hinc==3
logit energy_trade01 lower_expenses reduce_reliance constant_supply selling_additiol if hinc ==4
logit energy_trade01 lower_expenses reduce_reliance constant_supply selling_additiol if hinc==5
logit energy_trade01 lower_expenses reduce_reliance constant_supply selling_additiol if hinc ==6
logit energy_trade01 lower_expenses reduce_reliance constant_supply selling_additiol if age==1
logit energy_trade01 reduce_reliance constant_supply
logit buying lower_expenses reduce_reliance constant_supply selling_additiol
logit buying lower_expenses reduce_reliance constant_supply selling_additiol age hinc occupation hheduc hhsize 
logit buying lower_expenses reduce_reliance constant_supply selling_additiol i.age i.hinc i.occupation i.hheduc i.hhsize
/*
gen housetype_A=.
replace housetype_A = 1 if housetype_B1 ==1
replace housetype_A = 1 if housetype_B2 ==1
replace housetype_A = 1 if housetype_B3 ==1
replace housetype_A = 1 if housetype_B4 ==1
gen housetype_B=.
replace housetype_B = 2 if housetype_B1 ==2
replace housetype_B = 2 if housetype_B2 ==2
replace housetype_B = 2 if housetype_B3 ==2
replace housetype_B = 2 if housetype_B4 ==2
gen housetype_C=.
replace housetype_C = 3 if housetype_B1 ==3
replace housetype_C = 3 if housetype_B2 ==3
replace housetype_C = 3 if housetype_B3 ==3
replace housetype_C = 3 if housetype_B4 ==3
gen housetype =.
replace housetype =1 if housetype_A ==1
replace housetype =2 if housetype_B ==2
replace housetype =3 if housetype_C ==3
tabulate housetype_A
tabulate housetype_B
tabulate housetype_C
tabulate housetype