* some preamble
cap log close _all
set more off
clear all

*** Set up directories ***
global PROJ "C:\Users\kuany\REPOS\data-demo\Stata"
cd $PROJ
/* 
Setting this path to a folder in Box or Dropbox could introduce some 
version control functionality if you don't want to use Git.
*/
mkdir ".\data"
mkdir ".\output"

*** Packages
* This part only needs to be run once and should be commented out.
*** Exercise caution when installing user-contributed packages.
*ssc install outreg2, replace
*ssc install estout, replace
*net install desctable, from("https://tdmize.github.io/data/desctable")

*** Generate test data sets ***
do ".\programs\0_generate_test.do"

*** Read, manipulate, and combine 4 subsamples ***
do ".\programs\1_read_data.do"
