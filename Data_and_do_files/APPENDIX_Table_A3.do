/* ****************** GENERATE TABLE A3 - APPENDIX *********************** */
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

****************************************************************************************

/*Create variables*/

***** GDP per Capita *****
gen devo2014=ln(rgdpna2014/pop2014)
gen devo2008=ln(rgdpna2008/pop2008)
gen devo1990=ln(rgdpna1990/pop1990)
**************************/

gen change_gdp_9008=devo2008-devo1990
gen change_gdp_9014=devo2014-devo1990
gen change_gdp_0814=devo2014-devo2008

gen Thresh=1.5
gen ZLB=0
replace ZLB=1 if min_i_08_14 <= Thresh

//Labor Input: WORKING AGE ADULTS / TOTAL ADULTS
// Linear approximations:
replace dependency_${age}_y1990=1/(1+dependency_${age}_y1990)
replace dependency_${age}_y2005=1/(1+dependency_${age}_y2005)
replace dependency_${age}_y2010=1/(1+dependency_${age}_y2010) 
replace dependency_${age}_y2015=1/(1+dependency_${age}_y2015) 
gen dependency_${age}_y2008 = dependency_${age}_y2005 + (3/5)*(dependency_${age}_y2010 - dependency_${age}_y2005)
gen dependency_${age}_y2014 = dependency_${age}_y2010 + (4/5)*(dependency_${age}_y2015 - dependency_${age}_y2010)

// dependent variable
gen change_dependency_0814 = dependency_${age}_y2014-dependency_${age}_y2008
gen change_dependency_9014 = dependency_${age}_y2014-dependency_${age}_y1990
gen change_dependency_9008 = dependency_${age}_y2008-dependency_${age}_y1990

// Regression for 1990-2014:
gen dependency = change_dependency_9014
eststo: reg change_gdp_9014 dependency , r
*outreg2 using Table.doc, tex replace

// Regression for 1990-2008:
replace dependency = change_dependency_9008
eststo: reg change_gdp_9008 dependency, r

// Regression for 2008-2014:
replace dependency = change_dependency_0814
eststo: reg change_gdp_0814 dependency, r

// Regression for 2008-2014 Lower rates:
eststo: reg change_gdp_0814 dependency  if ZLB==1, r

// Regression for 2008-2014 Higher rates:
eststo: reg change_gdp_0814 dependency  if ZLB==0, r

esttab, starlevels(* 0.10 ** 0.05 *** 0.01) se r2
