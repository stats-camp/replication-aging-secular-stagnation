/* ****************** GENERATE TABLE A2 PANEL C - APPENDIX *********************** */
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
global age  50

/* IV instruments */
global instruments birthrate1960_1965 birthrate1965_1970 birthrate1970_1975 birthrate1975_1980 birthrate1980_1985 birthrate1985_1990

/*Create variables*/
gen lpop1990=ln(pop1990)
gen lpop2008=ln(pop2008)
gen devo1990=ln(rgdpna1990/pop1990)
gen devo2008=ln(rgdpna2008/pop2008)
gen devo2014=ln(rgdpna2014/pop2014)

gen gdp_90_14=devo2014-devo1990
gen gdp_90_08=devo2008-devo1990
gen gdp_08_14=devo2014-devo2008

gen dependency_50_y2008 = dependency_50_y2005 + (3/5)*(dependency_50_y2010 - dependency_50_y2005)
gen dependency_65_y2008 = dependency_65_y2005 + (3/5)*(dependency_65_y2010 - dependency_65_y2005)

gen dependency_90_15=dependency_${age}_y2015-dependency_${age}_y1990
gen dependency_90_08=dependency_${age}_y2008-dependency_${age}_y1990
gen dependency_08_15=dependency_${age}_y2015-dependency_${age}_y2008

gen base_dependency_1990=dependency_${age}_y1990
gen base_dependency_2008=dependency_${age}_y2008

gen japan=0 
replace japan=1 if cname_ifr=="Japan"
egen region_code=group(region)

eststo clear

eststo: reg gdp_08_14 dependency_08_15, r
eststo: reg gdp_08_14 dependency_08_15 devo1990, r
eststo: reg gdp_08_14 dependency_08_15 devo1990 lpop1990 base_dependency_1990, r
eststo: reg gdp_08_14 dependency_08_15 devo1990 lpop1990 base_dependency_1990  i.region_code, r
eststo: ivreg2 gdp_08_14 (dependency_08_15=$instruments ) devo1990 lpop1990 base_dependency_1990  i.region_code, r partial(lpop1990 i.region_code base_dependency_1990 )
eststo: reg gdp_08_14 dependency_08_15 japan if sample_oecd==1 , r 
eststo: reg gdp_08_14 dependency_08_15 devo1990  lpop1990 base_dependency_1990 japan  if sample_oecd==1 , r 
eststo: ivreg2 gdp_08_14 (dependency_08_15=$instruments )  devo1990 lpop1990 base_dependency_1990 japan if sample_oecd==1 , r partial(lpop1990 base_dependency_1990 ) 
esttab, starlevels(* 0.10 ** 0.05 *** 0.01) se stats(N r2)
