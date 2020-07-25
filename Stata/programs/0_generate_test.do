/*
This do file generates 4 samples of 20 observations from Stata's system
data file 'auto' with N = 74, named test_data_j.dta, j = 1, 2, 3, 4.
*/

sysuse auto, clear
describe
local j = 1
foreach i in 1 19 37 55{
	preserve
	local ii = `i' + 19
	keep in `i'/`ii'
	describe
	save ".\data\test_data_`j'", replace
	disp as text "----- Subsample" as result `j'
	restore
	local ++j
	}
