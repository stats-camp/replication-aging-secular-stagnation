/* ****************** GENERATE TABLE 1 PANEL B *********************** */
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

gen Thresh=1.5
gen ZLB=0
replace ZLB=1 if min_i_08_14 <= Thresh

* Working age adult - linearize labor force 
gen LF_08_UN=LF_05_UN+(LF_10_UN-LF_05_UN)*3/5
gen LF_14_UN=LF_10_UN+(LF_15_UN-LF_10_UN)*4/5

gen dependency_${age}_y2008 = dependency_${age}_y2005 + (3/5)*(dependency_${age}_y2010 - dependency_${age}_y2005)
gen dependency_${age}_y2014 = dependency_${age}_y2010 + (4/5)*(dependency_${age}_y2015 - dependency_${age}_y2010)

* Capital per working age adult
gen k2014=ln(rkna14/LF_14_UN)
gen k2008=ln(rkna08/LF_08_UN)
gen k1990=ln(rkna90/LF_90_UN)

gen change_k_9008=k2008-k1990
gen change_k_9014=k2014-k1990
gen change_k_0814=k2014-k2008

gen change_dependency_0814 = dependency_${age}_y2014-dependency_${age}_y2008
gen change_dependency_9014 = dependency_${age}_y2014-dependency_${age}_y1990
gen change_dependency_9008 = dependency_${age}_y2008-dependency_${age}_y1990

// Regression for 1990-2014:
gen dependency = change_dependency_9014
eststo: reg change_k_9014 dependency, r

// Regression for 1990-2008:
replace dependency = change_dependency_9008
eststo: reg change_k_9008 dependency, r

// Regression for 2008-2014:
replace dependency = change_dependency_0814
eststo: reg change_k_0814 dependency, r

// Regression for 2008-2014 Lower rates:
eststo: reg change_k_0814 dependency  if ZLB==1, r

// Regression for 2008-2014 Higher rates:
eststo: reg change_k_0814 dependency  if ZLB==0, r

esttab, starlevels(* 0.10 ** 0.05 *** 0.01) se r2
eststo clear

