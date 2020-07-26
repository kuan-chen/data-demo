** change path to output folder
cd "$PROJ\output"

** read data
use "cleaned_data.dta", clear

*** Log file

*** User-contributed packages
*** Again, use caution when installing/applying user-written packages, they could be
* 1. unsafe -> check that the authors at least appear to be credible, nice people;
* 2. wrong -> verify the results or read the source if you could.

** desctable
desctable price mpg weight length turn displacement gear_ratio i.rep78, ///
	filename(example_desctable1) ///
	stat(freq mean sd med iqr)
	
desctable price mpg weight length turn displacement gear_ratio i.rep78, ///
	filename(example_desctable2) ///
	stat(freq mean sd med iqr) ///
	group(foreign)

** estout
/*
The syntax for estout is quite comprehensive and therefore a little complex.
The following example based on the package help file provides a simple 
illustration of its typical use.
*/
replace price = price / 1000
replace weight = weight / 1000
regress price weight mpg
estimates store m1, title(Model 1)

regress price weight i.foreign##c.mpg
estimates store m2, title(Model 2)
* view stored estimates and 'copy table'.
estout m1 m2
* produce a txt file, which we can import into Excel.
estout * using example_estout.txt

** outreg2
* reuse stored estimated and produce an Word file
outreg2 m1 m2 using example_outreg2, word replace

