** Create 
clear
cd "H:/PhDThesis/ExchangeRateAnalysis/"
** Define a local macro with the names of the variables you're interested in
import delimited "H:\PhDThesis\ExchangeRateAnalysis\VAR Analysis\epias_average_data.csv", encoding(UTF-8) stringcols(1) clear 

tsset timevar
tsreport
// List of variables to test
local vars "mrptftl D.mrptftl mrusdtl D.mrusdtl mrgrftl D.mrgrftl mprosurplusnorm D.mprosurplusnorm"
// Loop over the variables
foreach var of local vars {
    // Conduct the ADF test
    dfuller `var', lags(30)
    dfuller `var', drift lags(30)
	dfuller `var', trend lags(30)
}

// Models for analysis TVGC
varsoc mrptftl mrgrftl, maxlag(30)  exog(mrusdtl)
varsoc mprosurplusnorm mrgrftl, maxlag(30) exog(mrusdtl)
varsoc mrgrftl mrptftl, maxlag(30)  exog(mrusdtl)


tvgc mrptftl mrusdtl mrgrftl, p(9) d(1) trend robust sizecontrol(120) seed(123) boot(300) prefix(M1_) graph 
matrix b = r(gcres) 
matrix V = r(gccv95)
matrix V2 = r(gccv99)
mat2txt, matrix(b) saving("matrix_test_statistics_model1.csv") replace 
mat2txt, matrix(V) saving("matrix_critical_values95_model1.csv") replace
mat2txt, matrix(V2) saving("matrix_critical_values99_model1.csv") replace

tvgc mprosurplusnorm mrusdtl mrgrftl, p(8) d(1) trend robust sizecontrol(120) seed(123) boot(300) prefix(M2_) graph 
matrix b = r(gcres) 
matrix V = r(gccv95)
matrix V2 = r(gccv99)
mat2txt, matrix(b) saving("matrix_test_statistics_model2.csv") replace 
mat2txt, matrix(V) saving("matrix_critical_values95_model2.csv") replace
mat2txt, matrix(V2) saving("matrix_critical_values99_model2.csv") replace

tvgc mrgrftl mrusdtl mrptftl, p(9) d(1) trend robust sizecontrol(52) seed(120) boot(300) prefix(M3_) graph 
matrix b = r(gcres) 
matrix V = r(gccv95)
matrix V2 = r(gccv99)
mat2txt, matrix(b) saving("matrix_test_statistics_model3.csv") replace 
mat2txt, matrix(V) saving("matrix_critical_values95_model3.csv") replace
mat2txt, matrix(V2) saving("matrix_critical_values99_model3.csv") replace


export	delimited using	"tvgc_completed.csv", replace
