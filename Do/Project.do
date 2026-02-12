* ================== Econometrics Project - STATA ==================
* Working with different datasets to analyze relationships between variables


* ================== Part 1: CEO Salaries ==================
* Let's look at CEO compensation and their years of experience

use "Data\CEOSAL2.dta", clear

* First, let me see what the salary distribution looks like for different age groups
histogram salary if age < 60, title("CEO Salaries - Under 60") ///
    name(h_sal_under60, replace)

histogram salary if age >= 60, title("CEO Salaries - Age 60 and Above") ///
    name(h_sal_60plus, replace)

* Now let's get some basic statistics
summarize salary ceoten

* How many CEOs are in their first year?
count if ceoten == 0

* And what's the longest someone has been CEO?
summarize ceoten

* Let's try a simple regression to see if tenure affects salary
regress lsalary ceoten

* The coefficient tells us that each additional year as CEO 
* is associated with about 0.97% higher salary on average.
* But this effect isn't statistically significant (p-value = 0.128).


* ================== Part 2: Understanding Wage Differences ==================
* Now let's look at workers and see how tenure, education, and experience 
* all affect wages

use "Data\WAGE2.dta", clear

* First, let's run a full model with all variables together
generate lnwage = ln(wage)
regress lnwage educ exper tenure

* The coefficient on tenure is about 0.0134, which means an extra year
* at the same job increases wages by about 1.34 percent.

* But wait - maybe tenure is related to education and experience.
* Let me check the "pure" effect of tenure by removing its relationship
* with other variables.

regress tenure educ exper
predict u_tenure, resid

* Now regress wages on just the leftover part of tenure
regress lnwage u_tenure

* Interesting - we get the same coefficient! This shows that the effect
* of tenure on wages is independent of education and experience.


* ================== Part 3: Who Saves More? ==================
* Let's analyze what factors influence household savings

use "Data\SAVING.dta", clear

describe
summarize

* First model: just use raw income
regress sav inc educ size age

* Second model: use log of income (to account for nonlinear effects)
generate linc = ln(inc)
regress sav linc educ size age

* Third model: also take log of savings to see percentage effects
generate lsav = ln(sav)
regress lsav linc educ size age

* The first two models show income doesn't have a strong effect on savings.
* But in the third model (looking at percentage changes), the income elasticity
* is about 0.84 - meaning a 1% income increase leads to 0.84% more savings.
* This one is actually statistically significant!


* ================== Part 4: Education, Experience, and Wages ==================
* How much do education and experience really matter for wages?

use "Data\WAGE1.dta", clear

describe
summarize wage educ exper tenure

* Let's estimate a simple wage equation
regress wage educ exper

* Each additional year of education increases hourly wage by about $0.64
* Each additional year of experience increases it by about $0.07
* Both effects are very statistically significant.

* Now let's see how tenure (time at current job) correlates with these variables
pwcorr tenure wage educ exper, sig

* Tenure is correlated with wages (0.347) and experience (0.499)
* but not really with education (-0.056).
* This makes sense - the longer you stay at a job, the more experience you gain.


* ================== Part 5: Does Ability Matter for Education? ==================
* Let's see how family background and ability affect education level

use "Data\HTV.dta", clear

describe educ motheduc fatheduc abil tuit17 tuit18
summarize educ motheduc fatheduc abil tuit17 tuit18

* First, let's see if ability affects education in a simple linear way
generate abil2 = abil^2
regress educ motheduc fatheduc abil abil2

* The ability term has coefficient 0.40, and ability squared has 0.05
test abil2

* The test shows that the squared term is significant - meaning the relationship
* between ability and education is not just linear, it curves!

* Now let's check if parents' education has the same effect
test motheduc = fatheduc

* The test gives p = 0.053, which is borderline. At the 5% level, we can't
* say for sure that mother's and father's education have different effects.

* Finally, does college tuition matter?
regress educ motheduc fatheduc abil abil2 tuit17 tuit18

test tuit17 tuit18

* The test shows that tuition is NOT significant - probably because by the time
* people reach college age, their education is already determined by ability
* and family background.


* ================== Part 6: Analyzing Cars ==================
* Let's work with car data to practice data manipulation

sysuse auto, clear

* Remove some variables we don't need
drop headroom trunk

* Rename a variable to be clearer
rename foreign origin

* Fix the label for a variable
label variable mpg "mile per gallon"

* Remove expensive cars from analysis
drop if price > 12000

* Convert measurements to metric
generate weight_kg = weight * 0.454
generate length_cm = length * 2.54

* Create a fuel efficiency measure (liters per 100km)
generate LP100km = (3.79/mpg) * (100/1.6)
label variable LP100km "liter per 100km"

* Compare fuel consumption by car origin
by origin, sort: summarize LP100km

* Foreign cars average 9.9 liters per 100km while domestic cars use 12.3
* So foreign cars are more fuel efficient

* Finally, let's look at repair records
tabulate rep78 origin

* Foreign cars seem to have better repair ratings overall (mostly 4s and 5s)
* while domestic cars are spread more evenly across the rating scale
