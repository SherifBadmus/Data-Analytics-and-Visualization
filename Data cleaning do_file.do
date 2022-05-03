*****************************
*IPA FRANCOPHONE WEST AFRICA RESEARCH ASSOCIATE RECRUITMENT EXCERCISE
******************************
*************
*Question B1
*************
import excel "[the path on your computer]\Household_survey.xlsx", sheet("Sheet1") firstrow

*************
*Question B2
************
browse

*************
*Question B3
*************
**200 observations

**************
*Question B4
**************
rename consent respconsent
label variable respconsent "HHH consent Yes or No"
rename hhhage HHH age
rename ros_05_1 hhhage
label variable hhhage "HHH age"
rename id_05 hhcode
label variable hhcode "Household code"
rename ros_04_1 sex_1
label variable sex_1 "Sex of member 1"

******Saving progress
save "C:[the path on your computer]\Household_survey.dta"
******

rename ros_04_2 sex_2
label variable sex_2 "Sex of member 2"
rename ros_04_3 sex_3
label variable sex_3 "Sex of member 3"
rename ros_04_4 sex_4
label variable sex_4 "Sex of member 4"
rename ros_04_5 sex_5
label variable sex_5 "Sex of member 5"
rename ros_04_6 sex_6
label variable sex_6 "Sex of member 6"
rename ros_04_15 sex_15
label variable sex_15 "Sex of member 15"
rename d3_name1 respname_1
label variable respname_1 "Respondent 1 name"
rename d3_name2 respname_2
label variable respname_2 "Respondent 2 name"
rename d3_name3 respname_3
label variable respname_3 "Respondent 3 name"
rename d3_name4 respname_4
label variable respname_4 "Respondent 4 name"

******Saving progress
save "[the path on your computer]\ Household_survey.dta", replace
******

rename d3_name15 respname_15
rename ros_07_1 respeduc_1
label variable respeduc_1 "Respondent 1 education level"
rename ros_07_2 respeduc_2
label variable respeduc_2 "Respondent 2 education level"
rename ros_07_3 respeduc_3
label variable respeduc_3 "Respondent 3 education level"
rename ros_07_4 respeduc_4
label variable respeduc_4 "Respondent 4 education level"
rename ros_07_5 respeduc_5
drop respeduc_5
rename ros_07_15 respeduc_15
label variable respeduc_15 "Respondent 15 education level"

*************
*Question B5
*************
rename respeduc_1 hhheduc
label define hhheduc_lab 1 "none" 2 "Some primary school" 3 "Completed primary school" 4 "Some secondary school" 5 "Completed secondary school" 6 "Other"
label values hhheduc hhheduc_lab
tab hhheduc

*************
*Question B6
*************
summ hhhage
recode hhhage (0/18=0) (19/max=1), gen(hhhisabove18)

************
*Question B7
************
tab hhcode
*The duplicates are the household code with frequency above one
*These are  5020049386  5020079987 5020089017 5020090011
sort hhcode
quietly by hhcode: gen dup = cond(_N==1 ,0,_n)
tab dup
tab hhcode if dup>1

************
*Question B8
************
drop if dup>1

************
*Question B9
************
drop ros_01 sex_1 sex_2 ros_05_2 respeduc_2 sex_3 ros_05_3 respeduc_3 sex_4 ros_05_4 respeduc_4 d3_name5 sex_5 ros_05_5 d3_name6 sex_6 ros_05_6 ros_07_6 d3_name7 ros_04_7 ros_05_7 ros_07_7 d3_name8 ros_04_8 ros_05_8 ros_07_8 d3_name9 ros_04_9 ros_05_9 ros_07_9 d3_name10 ros_04_10 ros_05_10 ros_07_10 d3_name11 ros_04_11 ros_05_11 ros_07_11 d3_name12 ros_04_12 ros_05_12 ros_07_12 d3_name13 ros_04_13 ros_05_13 ros_07_13 d3_name14 ros_04_14 ros_05_14 ros_07_14 sex_15 ros_05_15 respeduc_15

*************
*Question B10
*************
sum hhhage

*************
*Question B11
*************
tab hhheduc
