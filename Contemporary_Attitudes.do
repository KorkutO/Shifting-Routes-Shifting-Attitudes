clear all

use "C:\Users\KORKUT\Desktop\Paper2_Final\IVS_cleaning\Integrated_valuessurveys1981-2022CLEAN.dta", clear

* Merge: many (IVS respondents) to one (language-level distances)
merge m:1 language_spkn_home using "C:\Users\KORKUT\Desktop\Paper2_Final\IVS_distances\ivs_distances.dta"

drop _merge

merge 1:1 uid using "C:\Users\KORKUT\Desktop\Paper2_Final\IVS_distances\cntmp_distacnes.dta"
* (Optional but recommended) Inspect merge results
tab _merge
* keep if _merge==3   // keep matched only (if that is what you want)
 drop _merge

merge 1:1 uid using "C:\Users\KORKUT\Desktop\Paper2_Final\IVS_distances\old_world_cntmp.dta"
 
drop _merge
 
merge 1:1 uid using "C:\Users\KORKUT\Desktop\Paper2_Final\conflict_choke_points_ports\cntmp_conflict.dta"

drop _merge 

merge m:1 language_spkn_home using "C:\Users\KORKUT\Desktop\Paper2_Final\conflict_choke_points_ports\ethno_conflict.dta"

drop _merge

* Globals
global religion_dummies "atheist muslim christian hindu buddhist"


global indvars "male age employed marital_bin"

*** Table 5 Support for democracy - Supplement ***

*-----------------------
* Chokepoints models
*-----------------------
reghdfe sfd_indx lndist_6chokes if respondent_migrant == 0, absorb(year country) vce(cluster country)
est store f0
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "No"
estadd local FE_origin  "No"
estadd local TownSize   "No"
estadd local Religion   "No"

reghdfe sfd_indx lndist_6chokes ${indvars} if respondent_migrant == 0, absorb(year country) vce(cluster country)
est store f1
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "Yes"
estadd local FE_origin  "No"
estadd local TownSize   "No"
estadd local Religion   "No"

reghdfe sfd_indx lndist_6chokes ${indvars} if respondent_migrant == 0, absorb(year country origin_macro_region) vce(cluster country)
est store f2
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "Yes"
estadd local FE_origin  "Yes"
estadd local TownSize   "No"
estadd local Religion   "No"

reghdfe sfd_indx lndist_6chokes ${indvars} size_town if respondent_migrant == 0, absorb(year country origin_macro_region) vce(cluster country)
est store f3
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "Yes"
estadd local FE_origin  "Yes"
estadd local TownSize   "Yes"
estadd local Religion   "No"

reghdfe sfd_indx lndist_6chokes ${indvars} ${religion_dummies} if respondent_migrant == 0, absorb(year country origin_macro_region) vce(cluster country)
est store f4
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "Yes"
estadd local FE_origin  "Yes"
estadd local TownSize   "No"
estadd local Religion   "Yes"

*-----------------------
* Natural harbour models
*-----------------------
reghdfe sfd_indx lndist_naturalharbour if respondent_migrant == 0, absorb(year country) vce(cluster country)
est store f5
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "No"
estadd local FE_origin  "No"
estadd local TownSize   "No"
estadd local Religion   "No"

reghdfe sfd_indx lndist_naturalharbour ${indvars} if respondent_migrant == 0, absorb(year country) vce(cluster country)
est store f6
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "Yes"
estadd local FE_origin  "No"
estadd local TownSize   "No"
estadd local Religion   "No"

reghdfe sfd_indx lndist_naturalharbour ${indvars} if respondent_migrant == 0, absorb(year country origin_macro_region) vce(cluster country)
est store f7
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "Yes"
estadd local FE_origin  "Yes"
estadd local TownSize   "No"
estadd local Religion   "No"

reghdfe sfd_indx lndist_naturalharbour ${indvars} size_town if respondent_migrant == 0, absorb(year country origin_macro_region) vce(cluster country)
est store f8
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "Yes"
estadd local FE_origin  "Yes"
estadd local TownSize   "Yes"
estadd local Religion   "No"

reghdfe sfd_indx lndist_naturalharbour ${indvars} ${religion_dummies} if respondent_migrant == 0, absorb(year country origin_macro_region) vce(cluster country)
est store f9
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "Yes"
estadd local FE_origin  "Yes"
estadd local TownSize   "No"
estadd local Religion   "Yes"
*-----------------------
* Export table with Yes/No rows
*-----------------------
estout f0 f1 f2 f3 f4 f5 f6 f7 f8 f9, ///
    cells(b(star fmt(%9.3f)) se(par) t(fmt(%9.2f))) ///
    order(lndist_6chokes lndist_naturalharbour) ///
    keep(lndist_6chokes lndist_naturalharbour  ${indvars} size_town ${religion_dummies}) ///
    stats(FE_year FE_country IndCtrls FE_origin TownSize Religion r2 N, ///
          fmt(%9s %9s %9s %9s %9s %9s %9.3f %9.0g) ///
          labels("Year FE" "Country FE" "Individual controls" "Origin macro-region FE" "Town size" "Religion dummies" "R²" "Observations")) ///
    starlevels(* 0.1 ** 0.05 *** 0.01) ///
    style(fixed)

	
*** Table 6 Distances from Respondents' contemporary Locations ***
*** Support for democracy and Contemporary Distances ***
* (1) Choke points: baseline
reghdfe sfd_indx ln_cntmprydist_6chokes ///
    if old_world_cntmpr == 1 & respondent_migrant == 0, ///
    absorb(year country) vce(cluster country)
est store f0
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "No"
estadd local TownSize   "No"
estadd local Religion   "No"

* (2) + individual controls
reghdfe sfd_indx ln_cntmprydist_6chokes ${indvars} ///
    if old_world_cntmpr == 1 & respondent_migrant == 0, ///
    absorb(year country) vce(cluster country)
est store f1
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "Yes"
estadd local TownSize   "No"
estadd local Religion   "No"

* (3) + town size
reghdfe sfd_indx ln_cntmprydist_6chokes ${indvars} size_town ///
    if old_world_cntmpr == 1 & respondent_migrant == 0, ///
    absorb(year country) vce(cluster country)
est store f2
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "Yes"
estadd local TownSize   "Yes"
estadd local Religion   "No"

* (4) + religion dummies
reghdfe sfd_indx ln_cntmprydist_6chokes ${indvars} ${religion_dummies} ///
    if old_world_cntmpr == 1 & respondent_migrant == 0, ///
    absorb(year country) vce(cluster country)
est store f3
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "Yes"
estadd local TownSize   "No"
estadd local Religion   "Yes"


* (5) Natural harbours: baseline
reghdfe sfd_indx ln_cntmprydist_naturalharbour ///
    if old_world_cntmpr == 1 & respondent_migrant == 0, ///
    absorb(year country) vce(cluster country)
est store f4
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "No"
estadd local TownSize   "No"
estadd local Religion   "No"

* (6) + individual controls
reghdfe sfd_indx ln_cntmprydist_naturalharbour ${indvars} ///
    if old_world_cntmpr == 1 & respondent_migrant == 0, ///
    absorb(year country) vce(cluster country)
est store f5
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "Yes"
estadd local TownSize   "No"
estadd local Religion   "No"

* (7) + town size
reghdfe sfd_indx ln_cntmprydist_naturalharbour ${indvars} size_town ///
    if old_world_cntmpr == 1 & respondent_migrant == 0, ///
    absorb(year country) vce(cluster country)
est store f6
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "Yes"
estadd local TownSize   "Yes"
estadd local Religion   "No"

* (8) + religion dummies
reghdfe sfd_indx ln_cntmprydist_naturalharbour ${indvars} ${religion_dummies} ///
    if old_world_cntmpr == 1 & respondent_migrant == 0, ///
    absorb(year country) vce(cluster country)
est store f7
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local IndCtrls   "Yes"
estadd local TownSize   "No"
estadd local Religion   "Yes"
*-----------------------
* Summary table with FE + controls shown
*-----------------------
estout f0 f1 f2 f3 f4 f5 f6 f7, ///
    cells(b(star fmt(%9.3f)) se(par) t(fmt(%9.2f))) ///
    order(ln_cntmprydist_6chokes ln_cntmprydist_naturalharbour) ///
    keep(ln_cntmprydist_6chokes ln_cntmprydist_naturalharbour size_town ${indvars} ${religion_dummies}) ///
    stats(FE_year FE_country IndCtrls TownSize Religion r2 N, ///
          fmt(%9s %9s %9s %9s %9s %9.3f %9.0g) ///
          labels("Year FE" "Country FE" "Individual controls" "Town size" "Religion dummies" "R²" "Observations")) ///
    starlevels(* 0.1 ** 0.05 *** 0.01) ///
    style(fixed)
	

*Table 7  Supplement - Controlling Exposure to Historical and Contemporary Conflict*
reghdfe sfd_indx lndist_6chokes ${indvars} ln_conf_1000_1500_100km if respondent_migrant == 0, absorb(year country origin_macro_region) vce(cluster country)
est store f1
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local FE_origin  "Yes"
estadd local IndCtrls   "Yes"

reghdfe sfd_indx lndist_6chokes ${indvars} ln_conf_1501_1800_100km if respondent_migrant == 0, absorb(year country origin_macro_region) vce(cluster country)
est store f2
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local FE_origin  "Yes"
estadd local IndCtrls   "Yes"

reghdfe sfd_indx lndist_6chokes ${indvars} ln_conf_1801_1989_100km  if respondent_migrant == 0, absorb(year country origin_macro_region) vce(cluster country)
est store f3
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local FE_origin  "Yes"
estadd local IndCtrls   "Yes"

reghdfe sfd_indx lndist_6chokes ${indvars} ln_cntmp_conflict100km if respondent_migrant == 0, absorb(year country origin_macro_region) vce(cluster country)
est store f4
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local FE_origin  "Yes"
estadd local IndCtrls   "Yes"

estout f1 f2 f3 f4, ///
    cells(b(star fmt(%9.3f)) se(par) t(fmt(%9.2f))) ///
    drop(_cons) ///
    order( ///
        lndist_6chokes ///
        ln_conf_1000_1500_100km ///
        ln_conf_1501_1800_100km ///
        ln_conf_1801_1989_100km ///
        ln_cntmp_conflict100km ///
        ${indvars} ///
    ) ///
    stats(FE_year FE_country FE_origin IndCtrls r2 N, ///
          fmt(%9s %9s %9s %9s %9.3f %9.0g) ///
          labels("Year FE" "Country FE" "Origin macro-region FE" "Individual controls" ///
                 "R²" "Observations")) ///
    starlevels(* 0.1 ** 0.05 *** 0.01) ///
    style(fixed)

	
*****************************
***Table 8 Supplement *******
***English Channel Included**
***Support for democracy*****
*****************************
*-----------------------
* 7 chokepoints models
*-----------------------
reghdfe sfd_indx lndist_7chokes if respondent_migrant == 0, ///
    absorb(year country) vce(cluster country)
est store f0
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local FE_origin  "No"
estadd local IndCtrls   "No"
estadd local TownSize   "No"
estadd local Religion   "No"

reghdfe sfd_indx lndist_7chokes ${indvars} if respondent_migrant == 0, ///
    absorb(year country) vce(cluster country)
est store f1
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local FE_origin  "No"
estadd local IndCtrls   "Yes"
estadd local TownSize   "No"
estadd local Religion   "No"

reghdfe sfd_indx lndist_7chokes ${indvars} if respondent_migrant == 0, ///
    absorb(year country origin_macro_region) vce(cluster country)
est store f2
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local FE_origin  "Yes"
estadd local IndCtrls   "Yes"
estadd local TownSize   "No"
estadd local Religion   "No"

reghdfe sfd_indx lndist_7chokes ${indvars} size_town if respondent_migrant == 0, ///
    absorb(year country origin_macro_region) vce(cluster country)
est store f3
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local FE_origin  "Yes"
estadd local IndCtrls   "Yes"
estadd local TownSize   "Yes"
estadd local Religion   "No"

reghdfe sfd_indx lndist_7chokes ${indvars} ${religion_dummies} if respondent_migrant == 0, ///
    absorb(year country origin_macro_region) vce(cluster country)
est store f4
estadd local FE_year    "Yes"
estadd local FE_country "Yes"
estadd local FE_origin  "Yes"
estadd local IndCtrls   "Yes"
estadd local TownSize   "No"
estadd local Religion   "Yes"
estout f0 f1 f2 f3 f4, ///
    cells(b(star fmt(%9.3f)) se(par) t(fmt(%9.2f))) ///
    drop(_cons) ///
    order(lndist_7chokes ${indvars} size_town ${religion_dummies}) ///
    stats(FE_year FE_country FE_origin IndCtrls TownSize Religion r2 N, ///
          fmt(%9s %9s %9s %9s %9s %9s %9.3f %9.0g) ///
          labels("Year FE" "Country FE" "Origin macro-region FE" ///
                 "Individual controls" "Town size" "Religion dummies" ///
                 "R²" "Observations")) ///
    starlevels(* 0.1 ** 0.05 *** 0.01) ///
    style(fixed)


