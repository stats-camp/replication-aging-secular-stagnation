/* ****************** GENERATE TABLE 1 PANEL A *********************** */
/*Cleaning*/
cls
clear all
set more off

/* Directories*/
cd D:/Users/Manuel/Dropbox/Papers/Age_Eggerstsson_Lancastre/Final_materials/Data_and_do_files
global maindir D:/Users/Manuel/Dropbox/Papers/Age_Eggerstsson_Lancastre/Final_materials/Data_and_do_files

/* Dataset */
use AGING_GROWTH.dta

/* Define threshold for "old" */
global age  65

/* Drop Equatorial Guinea */
drop if countrycode=="GNQ"

/*Create variables*/
gen devo2014=ln(rgdpna2014/pop2014)
gen devo2008=ln(rgdpna2008/pop2008)
gen devo2007=ln(rgdpna2007/pop2007)
gen devo1990=ln(rgdpna1990/pop1990)

gen change_gdp_9008=devo2008-devo1990
gen change_gdp_9014=devo2014-devo1990
gen change_gdp_0814=devo2014-devo2008

// Linear approximation of dependency in 2008:
gen dependency_${age}_y2008 = dependency_${age}_y2005 + (3/5)*(dependency_${age}_y2010 - dependency_${age}_y2005)
gen change_dependency_0815 = dependency_${age}_y2015-dependency_${age}_y2008
gen change_dependency_9015 = dependency_${age}_y2015-dependency_${age}_y1990
gen change_dependency_9008 = dependency_${age}_y2008-dependency_${age}_y1990

gen dependency = change_dependency_0815

gen Thresh=0.5
gen ZLB=0
replace ZLB=1 if min_i_08_14 <= Thresh
// Regression for 2008-2015 Lower rates:
eststo: reg change_gdp_0814 dependency if ZLB==1, r
// Regression for 2008-2015 Higher rates:
eststo: reg change_gdp_0814 dependency if ZLB==0, r

replace Thresh=1.0
replace ZLB=0
replace ZLB=1 if min_i_08_14 <= Thresh
// Regression for 2008-2015 Lower rates:
eststo: reg change_gdp_0814 dependency if ZLB==1, r
// Regression for 2008-2015 Higher rates:
eststo: reg change_gdp_0814 dependency if ZLB==0, r

replace Thresh=1.5
replace ZLB=0
replace ZLB=1 if min_i_08_14 <= Thresh
// Regression for 2008-2015 Lower rates:
eststo: reg change_gdp_0814 dependency if ZLB==1, r
// Regression for 2008-2015 Higher rates:
eststo: reg change_gdp_0814 dependency if ZLB==0, r

replace Thresh=2.0
replace ZLB=0
replace ZLB=1 if min_i_08_14 <= Thresh
// Regression for 2008-2015 Lower rates:
eststo: reg change_gdp_0814 dependency if ZLB==1, r
// Regression for 2008-2015 Higher rates:
eststo: reg change_gdp_0814 dependency if ZLB==0, r

esttab, starlevels(* 0.10 ** 0.05 *** 0.01) se r2
