use "H:\PhDThesis\ExchangeRateAnalysis\Section 5 Firm Behavior Analysis\section_5_technology_behavior_dataset.dta", clear
tsset TimeVar
encode GOVERNOR, gen(GVRN)


**
local firmgeneration "EUASDAMHYDRO EUASLIGNITE EUASNGAS PRIVDAMHYDRO PRIVNGAS PRIVIMCOAL"
// Loop over the variables
foreach var of local firmgeneration {
    // Conduct the Unit root tests tests
	display as text "----------------------------------------------------------------------------------------------" 
	display as text "ADF Unit Root test results (None) for `var':" 
	dfuller `var', lags(30) 
	
	
	display as text "----------------------------------------------------------------------------------------------" 
	display as text "ADF Unit Root test results (Drift) for `var':" 
	dfuller `var', lags(30) drift 
	
	
	display as text "----------------------------------------------------------------------------------------------" 
	display as text "ADF Unit Root test results (Trend) for `var':" 
    dfuller `var', lags(30) trend  
	
}


xi: ivreg2 EUASDAMHYDRO VRE L.EUASTCOAL L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT3 PT3 i.YEAR i.MONTH WEEKEND COVID i.GVRN,  robust bw(7) ffirst gmm2s
est sto euashydro

xi: ivreg2 EUASDAMHYDRO VRE L.EUASTCOAL L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT3 PT3 i.YEAR i.MONTH WEEKEND COVID i.GVRN,  robust bw(7) ffirst cue
est sto euashydrocue

xi: ivreg2 EUASTCOAL VRE L.EUASDAMHYDRO L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT3 PT3 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) gmm2s ffirst 
est sto euastcoal

xi: ivreg2 EUASTCOAL VRE L.EUASDAMHYDRO L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT3 PT3 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) ffirst cue
est sto euastcoalcue

xi: ivreg2 EUASNGAS VRE L.EUASDAMHYDRO L.EUASTCOAL  L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT3 PT3 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) gmm2s ffirst
est sto euasngas

xi: ivreg2 EUASNGAS VRE L.EUASDAMHYDRO L.EUASTCOAL  L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT3 PT3 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) ffirst cue
est sto euasngascue

xi: ivreg2 PRIVNGAS VRE  L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL  i.YEAR i.MONTH WEEKEND COVID) NT3 PT3 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) ffirst gmm2
est sto privngas

xi: ivreg2 PRIVNGAS VRE  L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL  i.YEAR i.MONTH WEEKEND COVID) NT3 PT3 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) ffirst cue
est sto privngascue

xi: ivreg2 PRIVDAMHYDRO VRE L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVNGAS  L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT3 PT3 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) gmm2s ffirst
est sto privhydro

xi: ivreg2 PRIVDAMHYDRO VRE L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVNGAS  L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT3 PT3 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) ffirst cue
est sto privhydrocue

xi: ivreg2 PRIVTCOAL VRE L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L(1/1).USDTL L(1/1).TTF L.WVOL (PTFTL = L(1/2).PTFTL  i.YEAR i.MONTH WEEKEND COVID) NT3 PT3 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) gmm2s ffirst
est sto privtcoal

xi: ivreg2 PRIVTCOAL VRE L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L(1/1).USDTL L(1/1).TTF  L.WVOL (PTFTL = L(1/2).PTFTL  i.YEAR i.MONTH WEEKEND COVID) NT3 PT3 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) ffirst cue
est sto privtcoalcue

cd "H:\PhDThesis\ExchangeRateAnalysis\Section 5 Firm Behavior Analysis\" 
estout euashydro euastcoal euasngas privhydro privtcoal privngas using model_time3_results.txt, style(tex) cells(b(star fmt(3)) se(par fmt(2))) stats(r2 r2_a rmse N sargan sarganp j jp idstat idp  widstat) label legend replace

estout euashydrocue euastcoalcue euasngascue privhydrocue privtcoalcue privngascue using model_time3_cue_results.txt, style(tex) cells(b(star fmt(3)) se(par fmt(2))) stats(r2 r2_a rmse N sargan sarganp j jp idstat idp  widstat) label legend replace


**** 7 day adjustment window

xi: ivreg2 EUASDAMHYDRO VRE L.EUASTCOAL L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT7 PT7 i.YEAR i.MONTH WEEKEND COVID i.GVRN,  robust bw(7) gmm2s ffirst 
est sto euashydro7

xi: ivreg2 EUASDAMHYDRO VRE L.EUASTCOAL L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT7 PT7 i.YEAR i.MONTH WEEKEND COVID i.GVRN,  robust bw(7) cue ffirst 
est sto euashydro7cue

xi: ivreg2 EUASTCOAL VRE L.EUASDAMHYDRO L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT7 PT7 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) gmm2 ffirst
est sto euastcoal7

xi: ivreg2 EUASTCOAL VRE L.EUASDAMHYDRO L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT7 PT7 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) cue ffirst
est sto euastcoal7cue

xi: ivreg2 EUASNGAS VRE L.EUASDAMHYDRO L.EUASTCOAL  L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT7 PT7 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) gmm2s ffirst 
est sto euasngas7

xi: ivreg2 EUASNGAS VRE L.EUASDAMHYDRO L.EUASTCOAL  L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT7 PT7 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) ffirst cue
est sto euasngas7cue

xi: ivreg2 PRIVNGAS VRE  L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL  i.YEAR i.MONTH WEEKEND COVID) NT7 PT7 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) gmm2s ffirst 
est sto privngas7

xi: ivreg2 PRIVNGAS VRE  L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL  i.YEAR i.MONTH WEEKEND COVID) NT7 PT7 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) ffirst cue
est sto privngas7cue

xi: ivreg2 PRIVDAMHYDRO VRE L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVNGAS  L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT7 PT7 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) gmm2s ffirst
est sto privhydro7

xi: ivreg2 PRIVDAMHYDRO VRE L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVNGAS  L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT7 PT7 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) ffirst cue
est sto privhydro7cue

xi: ivreg2 PRIVTCOAL VRE L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L(1/1).USDTL L(1/1).TTF  L.WVOL (PTFTL = L(1/2).PTFTL  i.YEAR i.MONTH WEEKEND COVID) NT7 PT7 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) gmm2s ffirst 
est sto privtcoal7

xi: ivreg2 PRIVTCOAL VRE L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L(1/1).USDTL L(1/1).TTF L.WVOL (PTFTL = L(1/2).PTFTL  i.YEAR i.MONTH WEEKEND COVID) NT7 PT7 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) ffirst cue
est sto privtcoal7cue

cd "H:\PhDThesis\ExchangeRateAnalysis\Section 5 Firm Behavior Analysis\" 
estout euashydro7  euastcoal7  euasngas7  privhydro7  privtcoal7  privngas7  using model_time7_results.txt, style(tex) cells(b(star fmt(3)) se(par fmt(2))) stats(r2 r2_a rmse N sargan sarganp j jp idstat idp estat estatp  widstat) label legend replace

estout euashydro7cue euastcoal7cue euasngas7cue privhydro7cue privtcoal7cue privngas7cue using model_time7cue_results.txt, style(tex) cells(b(star fmt(3)) se(par fmt(2))) stats(r2 r2_a rmse N sargan sarganp j jp idstat idp estat estatp  widstat) label legend replace


** 14-day adjustment window

xi: ivreg2 EUASDAMHYDRO VRE L.EUASTCOAL L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT14 PT14 i.YEAR i.MONTH WEEKEND COVID i.GVRN,  robust bw(7) gmm2s ffirst
est sto euashydro14

xi: ivreg2 EUASDAMHYDRO VRE L.EUASTCOAL L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT14 PT14 i.YEAR i.MONTH WEEKEND COVID i.GVRN,  robust bw(7) cue ffirst
est sto euashydro14cue

xi: ivreg2 EUASTCOAL VRE L.EUASDAMHYDRO L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT14 PT14 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) gmm2s ffirst
est sto euastcoal14

xi: ivreg2 EUASTCOAL VRE L.EUASDAMHYDRO L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT14 PT14 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) ffirst cue
est sto euastcoal14cue

xi: ivreg2 EUASNGAS VRE L.EUASDAMHYDRO L.EUASTCOAL  L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT14 PT14 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) gmm2s ffirst 
est sto euasngas14

xi: ivreg2 EUASNGAS VRE L.EUASDAMHYDRO L.EUASTCOAL  L.PRIVNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT14 PT14 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) ffirst cue
est sto euasngas14cue

xi: ivreg2 PRIVNGAS VRE L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL  i.YEAR i.MONTH WEEKEND COVID) NT14 PT14 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) gmm2s ffirst
est sto privngas14

xi: ivreg2 PRIVNGAS VRE L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVDAMHYDRO L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL  i.YEAR i.MONTH WEEKEND COVID) NT14 PT14 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) ffirst cue
est sto privngas14cue

xi: ivreg2 PRIVDAMHYDRO VRE L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVNGAS  L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT14 PT14 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) gmm2s ffirst
est sto privhydro14

xi: ivreg2 PRIVDAMHYDRO VRE L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVNGAS  L.PRIVTCOAL L(1/1).TTF L(1/1).USDTL L.WVOL (PTFTL = L(1/2).PTFTL i.YEAR i.MONTH WEEKEND COVID) NT14 PT14 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) ffirst cue
est sto privhydro14cue

xi: ivreg2 PRIVTCOAL VRE L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L(1/1).USDTL L(1/1).TTF  L.WVOL (PTFTL = L(1/2).PTFTL  i.YEAR i.MONTH WEEKEND COVID) NT14 PT14 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) gmm2s ffirst
est sto privtcoal14

xi: ivreg2 PRIVTCOAL VRE L.EUASDAMHYDRO L.EUASTCOAL L.EUASNGAS L.PRIVNGAS L.PRIVDAMHYDRO L(1/1).USDTL L(1/1).TTF  L.WVOL (PTFTL = L(1/2).PTFTL  i.YEAR i.MONTH WEEKEND COVID) NT14 PT14 i.YEAR i.MONTH WEEKEND COVID i.GVRN, robust bw(7) ffirst cue
est sto privtcoal14cue



cd "H:\PhDThesis\ExchangeRateAnalysis\Section 5 Firm Behavior Analysis\" 
estout euashydro14 euastcoal14 euasngas14 privhydro14 privtcoal14 privngas14 using model_time14_results.txt, style(tex) cells(b(star fmt(3)) se(par fmt(2))) stats(r2 r2_a rmse N sargan sarganp j jp idstat idp estat estatp widstat) label legend replace

estout euashydro14cue euastcoal14cue euasngas14cue privhydro14cue privtcoal14cue privngas14cue using model_time14cue_results.txt, style(tex) cells(b(star fmt(3)) se(par fmt(2))) stats(r2 r2_a rmse N sargan sarganp j jp idstat idp estat estatp widstat) label legend replace


