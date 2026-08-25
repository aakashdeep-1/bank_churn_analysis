USE BankChurn;

-- ============================================================
-- Create Demographic Table
-- ============================================================

CREATE TABLE demographic (
	CustomerId INT AUTO_INCREMENT PRIMARY KEY,
	Gender VARCHAR(10),
	Age INT,
    Salary DECIMAL(10, 2),
    LocationId INT,
    Churned BIT
);

-- ============================================================
-- Create Account Table
-- ============================================================

CREATE TABLE account (
	CustomerId INT,
	Tenure INT,
	Balance DECIMAL(10, 2),
    NumProducts INT,
    HasCreditCard BIT,
    IsActive BIT
);

-- ============================================================
-- Create Location Table
-- ============================================================

CREATE TABLE location(
	LocationId INT AUTO_INCREMENT PRIMARY KEY,
	Geography VARCHAR(15)
);

-- ============================================================
-- Join : combined customer dataset by joining account, demographic, and location information.
-- ============================================================

SELECT A.CustomerId,
		A.Tenure,
        A.Balance,
        D.Gender,
        D.LocationId,
        L.Geography;
        
FROM account A
JOIN demographic D ON D.CustomerId = A.CustomerId
JOIN location L ON D.LocationId = L.LocationId;



-- ============================================================
-- Q1: Which customer profiles have the highest churn risk rate based on gender?
-- ============================================================

USE BankChurn;

WITH
	MainTbl AS
    (
	SELECT 
		Gender,
		COUNT(*) AS TotalCustomer,
		SUM(Churned) AS TotalChurn
	FROM demographic
	GROUP BY Gender
	)

SELECT *,
	CONCAT(FORMAT((TotalChurn * 100 / TotalCustomer), 2), '%') AS ChurnRate
FROM MainTbl;

-- ============================================================
-- Q2: How does churn rate vary across customer segments within each geography?
-- ============================================================

WITH MainTbl AS (
	SELECT
		CASE
			WHEN D.Age < 30 THEN 'Under 30'
			WHEN D.Age BETWEEN 30 AND 50 THEN 'Between 30-50'
			ELSE 'Above 50'
		END AS AgeGroup,
		D.Churned,
		L.Geography AS Country
	FROM demographic D
	JOIN location L ON L.LocationId = D.LocationId),
    
    SecondTbl AS(
    SELECT 
		Country, AgeGroup,
		COUNT(*) AS TotalCustomers,
        AVG(CAST(Churned AS FLOAT)) AS AverageChurnRate,
        AVG(AVG(CAST(Churned AS FLOAT))) OVER(PARTITION BY Country) AS AverageChurnCounty
    FROM MainTbl
    GROUP BY Country, AgeGroup
    ORDER BY Country, AgeGroup)

SELECT *,
	AverageChurnCounty - AverageChurnRate AS Diff
FROM SecondTbl;

-- ============================================================
-- Q3: How does churn behaviour change when we dynamically slice customers by business parameters?
-- ============================================================

SET @MinTenure = 9;
SET @MaxBalance = 120000;
SET @MaxProduct = 6;

SELECT
	A.CustomerId,
	A.Tenure,
	A.Balance,
	A.NumProducts,
    D.Churned
FROM account A
JOIN demographic D ON D.CustomerId = A.CustomerId
WHERE
	Tenure > @MinTenure
    AND Balance < @MaxBalance
    AND NumProducts < @MaxProduct;

