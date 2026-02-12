# Applied Econometrics Project - STATA

## Course: Applied Econometrics

## Project Overview

This repository contains practical projects for the Applied Econometrics course using STATA software. All analyses are conducted using Do Files and Log Files with complete documentation.

## ⚠️ Important Note

All assignments must include **Do Files** and **Log Files** with results saved in them. Manual calculations are also documented in the Do Files. Assignments without these files will not receive credit.

## Project Structure

```
STATA-Econometrics-Project/
│
├── Question1_CEOSAL2/           # Question 1: CEO Salary Analysis
│   ├── q1.do                    # Do File for Question 1
│   ├── q1.log                   # Log File for Question 1
│   └── CEOSAL2.dta              # Dataset
│
├── Question2_WAGE2/             # Question 2: Partialling Out Method
│   ├── q2.do
│   ├── q2.log
│   └── WAGE2.dta
│
├── Question3_SAVING/            # Question 3: Model Comparison
│   ├── q3.do
│   ├── q3.log
│   └── SAVING.dta
│
├── Question4_WAGE1/             # Question 4: Wage Analysis
│   ├── q4.do
│   ├── q4.log
│   └── WAGE1.dta
│
├── Question5_HTV/               # Question 5: Education Analysis
│   ├── q5.do
│   ├── q5.log
│   └── HTV.dta
│
├── Question6_AUTO/              # Question 6: Data Management
│   ├── q6.do
│   ├── q6.log
│   └── auto.dta
│
└── README.md                    # This file
```

## Project Questions

### Question 1: CEO Salary Analysis (CEOSAL2)

**Dataset:** 177 CEOs of American companies

**Variables:**
- `salary`: Annual CEO salary (thousand USD)
- `ceoten`: Years of managerial experience at current company

**Analysis Tasks:**
- a) Calculate mean and standard deviation of `salary` for first 60 and last 60 companies separately, create box plots
- b) Calculate coefficient of variation for `salary` and `ceoten`
- c) Identify CEOs with zero years of experience (`ceoten = 0`) and their salary ranges
- d) Estimate the regression model: `log(salary) = β₀ + β₁·ceoten + u`
  - Interpret β₁ as a percentage (how much does one additional year increase salary?)
- e) Test whether `ceoten` has a statistically significant positive effect on salary (5% significance level)

### Question 2: Partialling Out Method (WAGE2)

**Model:**
```
ln(wage) = β₀ + β₁·educ + β₂·exper + β₃·tenure + ε
```

Where `tenure` is the number of years at the current company.

**Analysis:**
Using the **Partialling Out** method, calculate β₃:
- a) Regress `tenure` on `educ` and `exper`, save residuals
- b) Regress `ln(wage)` on the residuals from step (a)
- The coefficient obtained equals β₃ in the original model
- Interpret the results

### Question 3: Model Comparison (SAVING)

Estimate three models and compare results in a summary table:

**Model 1 (Level-Level):**
```
sav = β₀ + β₁·inc + β₂·educ + β₃·size + β₄·age + u
```

**Model 2 (Level-Log):**
```
sav = β₀ + β₁·ln(inc) + β₂·educ + β₃·size + β₄·age + u
```

**Model 3 (Log-Log):**
```
ln(sav) = β₀ + β₁·ln(inc) + β₂·educ + β₃·size + β₄·age + u
```

Interpret coefficient β₁ in each model.

### Question 4: Wage Analysis (WAGE1)

**Analysis:**
- a) Estimate the model using OLS:
  ```
  wage = α₀ + β₁·educ + β₂·exper + ε
  ```
  Test β₂ at 5% significance level. Is it positive and significant?

- b) Should the variable `tenure` (years at current company) be added to the model? Justify your answer.

### Question 5: Education Analysis (HTV)

**Analysis:**
- a) Estimate the model:
  ```
  educ = β₀ + β₁·motheduc + β₂·fatheduc + β₃·abil + β₄·(abil²) + u
  ```
  - Interpret β₃
  - Plot the relationship between `educ` and `abil`
  - Is the relationship linear or quadratic?

- b) Test the hypothesis H₀: β₁ = β₂ (mother's and father's education have equal impact)
  - Report the P-value and interpret results

- c) Add variables `tuit17` and `tuit18` (college tuition at ages 17 and 18) to the model
  - Do these variables significantly affect education level?

### Question 6: Data Management (AUTO)

**Operations:**
- a) Drop variables `headroom` and `trunk`
- b) Rename `foreign` to `origin`
- c) Rename `mpg` to `mile_per_gallon`
- d) Drop first 12 observations
- e) Create two new variables:
  - Convert length from inches to centimeters (1 inch = 2.54 cm)
  - Convert weight from pounds to kilograms (1 pound = 0.454 kg)
- f) Create new variable `LP100km` (fuel consumption in liters per 100 km):
  ```
  LP100km = 235.215 / mile_per_gallon
  ```
  (Note: 1 gallon ≈ 3.79 liters, 1 mile ≈ 1.6 km)
- g) Create variables showing average fuel consumption for domestic and foreign cars
- h) Use `tabulate` to create a contingency table between `rep78` (repair quality) and `origin`
  - Analyze quality differences between domestic and foreign cars

## How to Use

### Prerequisites

- STATA (version 14 or higher recommended)
- Dataset files (.dta)

### Running the Code

For each question:

```stata
cd "path/to/QuestionX"
do qX.do
```

Or in STATA:
1. File → Open → Select .do file
2. Click "Do"

### Viewing Results

Results are saved in Log files:
```stata
view qX.log
```

## Key STATA Commands Used

### Statistical Analysis
- `summarize`: Descriptive statistics
- `tabulate`: Frequency tables
- `graph box`: Box plots
- `correlate`: Correlation coefficients

### Regression
- `regress`: Linear regression (OLS)
- `predict`: Predictions and residuals
- `test`: Hypothesis testing

### Data Management
- `drop`: Remove variables or observations
- `rename`: Rename variables
- `generate`: Create new variables
- `replace`: Replace values

### Output
- `log using`: Start Log File
- `log close`: Close Log File

## Key Formulas

### Coefficient of Variation
```
CV = (Standard Deviation / Mean) × 100
```

### Unit Conversions
- Inches to centimeters: `cm = inch × 2.54`
- Pounds to kilograms: `kg = pound × 0.454`
- Fuel consumption: `LP100km = 235.215 / mpg`

### Logarithmic Models

#### Log-Level Model
```
log(y) = β₀ + β₁·x + u
Interpretation: One unit increase in x → (β₁ × 100)% change in y
```

#### Level-Log Model
```
y = β₀ + β₁·log(x) + u
Interpretation: 1% increase in x → (β₁/100) unit change in y
```

#### Log-Log Model (Elasticity)
```
log(y) = β₀ + β₁·log(x) + u
Interpretation: 1% increase in x → β₁% change in y
```

## Results and Key Findings

Detailed results are available in the Log files for each question. To view:

```stata
cd "path/to/Question"
view q*.log
```

## Implementation Checklist

✅ All code written in Do Files  
✅ Results saved in Log Files  
✅ Manual calculations documented in Do Files  
✅ Graphs and comparison tables generated  
✅ Economic interpretations provided  

## References

- Wooldridge, J. M. (2020). *Introductory Econometrics: A Modern Approach*
- STATA Manual and Documentation
- Applied Econometrics Course Materials

## Author

**Name:** Mobin Ghorbani  
**Major:** Computer Science  
**Course:** Applied Econometrics (Class 405-1404)

## License

This project is for educational purposes.

---

## Git Bash Upload Guide

### Initial Setup (One Time)
```bash
git config --global user.name "Mobin Ghorbani"
git config --global user.email "mobinghorbanihokmabad@gmail.com"
```

### Upload Project
```bash
cd /path/to/your/stata/project
git init
git add .
git commit -m "Initial commit: STATA Econometrics Project"
git branch -M main
git remote add origin https://github.com/VictimPickle/STATA-Econometrics-Project.git
git push -u origin main
```

### Update Files
```bash
git add .
git commit -m "Update: description of changes"
git push
```

**Good luck! 🎓**
