*** Intro ***
* The data sets consists of 4 overlapping samples of the 'auto' data.

*** change path to data folder
cd ".\data"
/*
The syntax above is called "relative path", it points us to 
a folder named "data" following the directoy that was set in
0_master.do, which is indicated by ".".
Alternatively, we could set up an "absolute path", and replace
part of the directoty with the global macro we have already set up:
cd "$PROJ\data"
*/

*** Manipulate 1 data set

* read the first data set
use "test_data_1.dta", clear
* generate an indicator for variable being larger than median in the sample
gen mpg_above_med = (mpg > 20)
gen price_above_med = (price > 5000)
* generate a string for brand
* this also demonstrates 3 of Nick Cox's "best string quartet outside Vienna"
gen name = substr(make, strpos(make, " "), .)
gen brand = strtrim(subinstr(make, name, "", .))
order brand, after(make)
drop name

*** taking it to all 4 data sets

* we don't want to copy and paste this for all 4 samples.
* solution: for-loops
forv i = 1(1)4{
	use "test_data_`i'.dta", clear
	
	gen mpg_above_med = (mpg > 20)
	gen price_above_med = (price > 5000)
	tab mpg_above_med price_above_med
	
	gen name = substr(make, strpos(make, " "), .)
	gen brand = strtrim(subinstr(make, name, "", .))
	order brand, after(make)
	drop name
	
	* save results from each iteration in the loop to a temporary location
	tempfile data_`i'
	save `data_`i''
	}

*** combine the 4 temporary data sets
use `data_1', clear
append using `data_2' `data_3' `data_4', gen(sub_sample)


*** ensure unique ID's
* we started with N=74, we now have 80 obs.
duplicates report
duplicates report make
drop sub_sample
duplicates drop
isid make

*** save output
save "..\output\cleaned_data.dta", replace
