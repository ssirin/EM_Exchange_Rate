use "H:\PhDThesis\ExchangeRateAnalysis\Section 5 Surplus_Analysis\section_5_surplus_analysis.dta", clear
rename *, lower
encode governor, gen(gvrn)
xtset hour timevar

** Conduct the same analysisi with lagged values as done in ARDL model
xi: xtgls dprusplusratio resdemandreturn windreturn riverreturn L.ttfreturn L.excreturn L.wvol nt3 pt3  i.gvrn weekend i.month i.year covid, panels(correlated) corr(psar1) igls
est sto surplusmodel1a, title("Model 1a")

xi: xtgls dprusplusratio resdemandreturn windreturn riverreturn L(1/7).ttfreturn L(1/7).excreturn L.wvol nt3 pt3  i.gvrn weekend i.month i.year covid, panels(correlated) corr(psar1) igls
est sto surplusmodel1b, title("Model 1b")

xi: xtgls dprusplusratio resdemandreturn windreturn riverreturn L(1/14).ttfreturn L(1/14).excreturn L.wvol nt3 pt3  i.gvrn weekend i.month i.year covid, panels(correlated) corr(psar1) igls
est sto surplusmodel1c, title("Model 1c")

xi: xtgls dprusplusratio resdemandreturn windreturn riverreturn L.ttfreturn L.excreturn L.wvol nt7 pt7  i.gvrn weekend i.month i.year covid, panels(correlated) corr(psar1) igls
est sto surplusmodel2a, title("Model 2a")

xi: xtgls dprusplusratio resdemandreturn windreturn riverreturn L(1/7).ttfreturn L(1/7).excreturn L.wvol nt7 pt7  i.gvrn weekend i.month i.year covid, panels(correlated) corr(psar1) igls
est sto surplusmodel2b, title("Model 2b")

xi: xtgls dprusplusratio resdemandreturn windreturn riverreturn L(1/14).ttfreturn L(1/14).excreturn L.wvol nt7 pt7 i.gvrn weekend i.month i.year covid, panels(correlated) corr(psar1) igls
est sto surplusmodel2c, title("Model 2c")

xi: xtgls dprusplusratio resdemandreturn windreturn riverreturn L.ttfreturn L.excreturn L.wvol nt14 pt14  i.gvrn weekend i.month i.year covid, panels(correlated) corr(psar1) igls
est sto surplusmodel3a, title("Model 3a")

xi: xtgls dprusplusratio resdemandreturn windreturn riverreturn L(1/7).ttfreturn L(1/7).excreturn L.wvol nt14 pt14  i.gvrn weekend i.month i.year covid, panels(correlated) corr(psar1) igls
est sto surplusmodel3b, title("Model 3b")

xi: xtgls dprusplusratio resdemandreturn windreturn riverreturn L(1/14).ttfreturn L(1/14).excreturn L.wvol nt14 pt14 i.gvrn weekend i.month i.year covid, panels(correlated) corr(psar1) igls
est sto surplusmodel3c, title("Model 3c")


cd "H:\PhDThesis\ExchangeRateAnalysis\Section 5 Surplus_Analysis\" 
estout surplusmodel1a surplusmodel1b surplusmodel1c surplusmodel2a surplusmodel2b surplusmodel2c surplusmodel3a surplusmodel3b surplusmodel3c using section_5_surpslus_analysis.txt, style(tex) cells(b(star fmt(3)) se(par fmt(2))) stats(r2 rmse ll N) label legend replace




 wvol mpr wdayno covid governor timevar mcpreturn excreturn ttfreturn windreturn riverreturn demandreturn resdemandreturn  dprusplusratio gvrn nt3 pt3 nt7 pt7 nt14 pt14