/*Cleaning*/
cls
clear all
set more off

/* Details on the models (age=50 for panel A, ave for panel B) */
global age  65

use AGING_GROWTH.dta

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


// Scatter plots

*Figure 1A
gen annual_g_gdp_9014 = change_gdp_9014
graph twoway scatter annual_g_gdp_9014 change_dependency_9015, xscale(r(-0.05 0.28)) xlabel( 0 0.1 0.2 )  yscale(r(-0.55 1.9)) ylabel(-0.5 0 0.5 1 1.5) ///
ytitle("Change in GDP per capita") xtitle("Change in the ratio of old to working age adults") legend(off) title(1990-2015) name(graph1) mlabel(countrycode) mlabsize(tiny) ///
|| lfit annual_g_gdp_9014 change_dependency_9015

*Figure 1B
gen annual_g_gdp_9008 = change_gdp_9008
graph twoway scatter annual_g_gdp_9008 change_dependency_9008, xscale(r(-0.04 0.17)) xlabel(0 0.05 0.1 0.15 ) yscale(r(-0.6 1.6)) ylabel(-0.5 0 0.5 1 1.5)   ///
ytitle("Change in GDP per capita") xtitle("Change in the ratio of old to working age adults") legend(off) title(1990-2008) name(graph2)mlabel(countrycode) mlabsize(tiny) ///
|| lfit annual_g_gdp_9008 change_dependency_9008
*graph export Figure_1B.png

*Figure 1C
gen annual_g_gdp_0814 = change_gdp_0814
graph twoway scatter annual_g_gdp_0814 change_dependency_0815, xscale(r(-0.03 0.11)) xlabel(0 0.05 0.1) yscale(r(-0.5 0.7)) ylabel(-0.5 0 0.5) ///
ytitle("Change in GDP per capita") xtitle("Change in the ratio of old to working age adults") legend(off) title(2008-2015) name(graph3)mlabel(countrycode) mlabsize(tiny) ///
|| lfit annual_g_gdp_0814 change_dependency_0815
