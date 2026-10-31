/* ****************** GENERATE TABLE A4 PANEL A - APPENDIX *********************** */
/*Cleaning*/
cls
clear all
set more off

/* Directories*/
cd D:/Users/Manuel/Dropbox/Papers/Age_Eggerstsson_Lancastre/Final_materials/Data_and_do_files
global maindir D:/Users/Manuel/Dropbox/Papers/Age_Eggerstsson_Lancastre/Final_materials/Data_and_do_files

/* Dataset */
use AGING_GROWTH.dta

/* Drop Equatorial Guinea */
drop if countrycode=="GNQ"

/* Define threshold for "old" */
global age  65

/* IV instruments */
global instruments birthrate1960_1965 birthrate1965_1970 birthrate1970_1975 birthrate1975_1980 birthrate1980_1985 birthrate1985_1990

gen devo2014=ln(rgdpna2014/pop2014)
gen devo2008=ln(rgdpna2008/pop2008)
gen devo1990=ln(rgdpna1990/pop1990)

gen change_gdp_9008=devo2008-devo1990
gen change_gdp_9014=devo2014-devo1990
gen change_gdp_0814=devo2014-devo2008

gen japan=0 
replace japan=1 if cname_ifr=="Japan"
egen region_code=group(region)

replace dependency_${age}_y1990=1/(1+dependency_${age}_y1990)
replace dependency_${age}_y2005=1/(1+dependency_${age}_y2005)
replace dependency_${age}_y2010=1/(1+dependency_${age}_y2010) 
replace dependency_${age}_y2015=1/(1+dependency_${age}_y2015) 

gen dependency_${age}_y2008 = dependency_${age}_y2005 + (3/5)*(dependency_${age}_y2010 - dependency_${age}_y2005)
gen dependency_${age}_y2014 = dependency_${age}_y2010 + (4/5)*(dependency_${age}_y2015 - dependency_${age}_y2010)

gen change_dependency_0814 = dependency_${age}_y2014-dependency_${age}_y2008
gen change_dependency_9014 = dependency_${age}_y2014-dependency_${age}_y1990
gen change_dependency_9008 = dependency_${age}_y2008-dependency_${age}_y1990

gen base_dependency_1990=dependency_${age}_y1990
gen base_dependency_2008=dependency_${age}_y2008

gen lpop1990=ln(POP_90_UN-CH_90_UN)

eststo clear

gen gdp_90_14=change_gdp_9014
gen dependency_90_14=change_dependency_9014

eststo: reg gdp_90_14 dependency_90_14, r
eststo: reg gdp_90_14 dependency_90_14 devo1990, r
eststo: reg gdp_90_14 dependency_90_14 devo1990 lpop1990 base_dependency_1990, r
eststo: reg gdp_90_14 dependency_90_14 devo1990 lpop1990 base_dependency_1990  i.region_code, r
eststo: ivreg2 gdp_90_14 (dependency_90_14=$instruments ) devo1990 lpop1990 base_dependency_1990  i.region_code, r partial(lpop1990 i.region_code base_dependency_1990 )
eststo: reg gdp_90_14 dependency_90_14 japan if sample_oecd==1 , r
eststo: reg gdp_90_14 dependency_90_14 devo1990  lpop1990 base_dependency_1990 japan if sample_oecd==1 , r
eststo: ivreg2 gdp_90_14 (dependency_90_14=$instruments )  devo1990 lpop1990 base_dependency_1990 japan if sample_oecd==1 , r partial(lpop1990 base_dependency_1990 )

esttab, starlevels(* 0.10 ** 0.05 *** 0.01) se
