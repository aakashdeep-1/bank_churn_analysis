# Bank Churn Analysis

An end-to-end bank customer churn analysis using **Python, MySQL, and statistical testing** to explore customer behavior and identify factors associated with churn.

## Project Overview

The project covers the workflow from data preparation and database setup to SQL analysis and statistical hypothesis testing.

### Data Preparation

* Loaded customer data from Excel
* Performed categorical and data type validation
* Checked for missing values
* Examined distributions and outliers
* Handled missing `Balance` values
* Removed unnecessary columns
* Exported cleaned data into CSV files

### MySQL

Cleaned datasets are loaded into a MySQL database named `BankChurn`.

The database contains three tables:

* `demographic`
* `account`
* `location`

The SQL analysis includes questions such as:

* How does churn rate vary by gender?
* How does churn rate vary across age groups within different countries?
* How does churn behavior change when filtering customers by tenure, balance, and number of products?

### Statistical Analysis

Three hypothesis tests were performed:

**Welch's t-test**
Compare average account balance between churned and retained customers.

**Chi-Square Test of Independence**
Test the relationship between account activity and customer churn.

**One-Way ANOVA**
Test whether average customer tenure differs across countries.

Effect sizes were also calculated using:

* Cohen's d
* Cramér's V
* Eta Squared
* Omega Squared

## Key Findings

* There was **no statistically significant difference** in average account balance between churned and retained customers.
* Customer activity (`IsActive`) showed a **statistically significant association** with churn.
* The association between activity and churn was **weak** based on Cramér's V (0.15).
* There was **no statistically significant difference** in average tenure across countries.
* The effect of country on tenure was negligible, with Eta Squared ≈ **0.00046** and Omega Squared ≈ **0**.
* Cohen's d for account balance was approximately **0.03**, indicating a negligible effect.

## Tools & Technologies

* **Python**
* **Pandas**
* **NumPy**
* **SciPy**
* **Seaborn**
* **Matplotlib**
* **MySQL**
* **Jupyter Notebook**

## Project Structure

```text
bank_churn_analysis/
│
├── data/
│   └── processed/
│       ├── demographic.csv
│       ├── account.csv
│       └── location.csv
│
├── notebook/
│   ├── Bank.ipynb
│   ├── mysql_connection.ipynb
│   └── statistical_testing.ipynb
│
├── analysis_queries.sql
│
└── README.md
```

## Notebooks

* `Bank.ipynb` — Data cleaning, validation, and preprocessing
* `mysql_connection.ipynb` — Loading processed data into MySQL
* `statistical_testing.ipynb` — Hypothesis testing and effect-size analysis

## SQL

`analysis_queries.sql` contains the database schema, table joins, and business analysis queries used in the project.
