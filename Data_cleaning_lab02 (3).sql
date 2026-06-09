USE AdventureWorksDW2019;
GO

DROP TABLE IF EXISTS dbo.DimCustomer_CleaningActivity;
GO

WITH dirty_customer_data AS (

    SELECT
        CustomerKey,
        GeographyKey,
        CustomerAlternateKey,
        Title,

        CASE
            WHEN CustomerKey = 11060 THEN '  john  '
            ELSE FirstName
        END AS FirstName,

        MiddleName,

        CASE
            WHEN CustomerKey = 11061 THEN '  SMITH  '
            ELSE LastName
        END AS LastName,

        NameStyle,

        CASE
            WHEN CustomerKey IN (11027, 11028, 11029) THEN NULL
            WHEN CustomerKey IN (11055, 11056) THEN CAST('1900-01-01' AS date)
            WHEN CustomerKey = 11057 THEN CAST('2035-01-01' AS date)
            ELSE BirthDate
        END AS BirthDate,

        CASE
            WHEN CustomerKey IN (11022, 11023, 11024, 11025, 11026) THEN NULL
            WHEN CustomerKey = 11064 THEN 'single'
            WHEN CustomerKey = 11065 THEN 'married'
            ELSE MaritalStatus
        END AS MaritalStatus,

        Suffix,

        CASE
            WHEN CustomerKey IN (11017, 11018, 11019, 11020, 11021) THEN NULL
            WHEN CustomerKey = 11062 THEN 'm'
            WHEN CustomerKey = 11063 THEN 'female'
            ELSE Gender
        END AS Gender,

        CASE
            WHEN CustomerKey IN (11000, 11001, 11002, 11003, 11004, 11005, 11006, 11007) THEN NULL
            ELSE EmailAddress
        END AS EmailAddress,

        CASE
            WHEN CustomerKey IN (11030, 11031, 11032, 11033, 11034, 11035) THEN NULL
            WHEN CustomerKey IN (11049, 11050) THEN 999999
            WHEN CustomerKey = 11051 THEN -5000
            ELSE YearlyIncome
        END AS YearlyIncome,

        CASE
            WHEN CustomerKey IN (11036, 11037, 11038) THEN NULL
            WHEN CustomerKey = 11058 THEN 25
            ELSE TotalChildren
        END AS TotalChildren,

        CASE
            WHEN CustomerKey IN (11039, 11040, 11041) THEN NULL
            WHEN CustomerKey = 11059 THEN 20
            ELSE NumberChildrenAtHome
        END AS NumberChildrenAtHome,

        EnglishEducation,
        SpanishEducation,
        FrenchEducation,
        EnglishOccupation,
        SpanishOccupation,
        FrenchOccupation,
        HouseOwnerFlag,

        CASE
            WHEN CustomerKey IN (11042, 11043, 11044) THEN NULL
            WHEN CustomerKey IN (11052, 11053) THEN 99
            WHEN CustomerKey = 11054 THEN -1
            ELSE NumberCarsOwned
        END AS NumberCarsOwned,

        CASE
            WHEN CustomerKey IN (11013, 11014, 11015, 11016) THEN NULL
            ELSE AddressLine1
        END AS AddressLine1,

        AddressLine2,

        CASE
            WHEN CustomerKey IN (11002, 11003, 11008, 11009, 11010, 11011, 11012) THEN NULL
            ELSE Phone
        END AS Phone,

        DateFirstPurchase,

        CASE
            WHEN CustomerKey IN (11045, 11046, 11047, 11048) THEN NULL
            ELSE CommuteDistance
        END AS CommuteDistance

    FROM dbo.DimCustomer

    UNION ALL

    SELECT
        999001 AS CustomerKey,
        GeographyKey,
        CustomerAlternateKey,
        Title,
        FirstName,
        MiddleName,
        LastName,
        NameStyle,
        BirthDate,
        MaritalStatus,
        Suffix,
        Gender,
        EmailAddress,
        YearlyIncome,
        TotalChildren,
        NumberChildrenAtHome,
        EnglishEducation,
        SpanishEducation,
        FrenchEducation,
        EnglishOccupation,
        SpanishOccupation,
        FrenchOccupation,
        HouseOwnerFlag,
        NumberCarsOwned,
        AddressLine1,
        AddressLine2,
        Phone,
        DateFirstPurchase,
        CommuteDistance
    FROM dbo.DimCustomer
    WHERE CustomerKey = 11008

    UNION ALL

    SELECT
        999002 AS CustomerKey,
        GeographyKey,
        CustomerAlternateKey,
        Title,
        FirstName,
        MiddleName,
        LastName,
        NameStyle,
        BirthDate,
        MaritalStatus,
        Suffix,
        Gender,
        EmailAddress,
        YearlyIncome,
        TotalChildren,
        NumberChildrenAtHome,
        EnglishEducation,
        SpanishEducation,
        FrenchEducation,
        EnglishOccupation,
        SpanishOccupation,
        FrenchOccupation,
        HouseOwnerFlag,
        NumberCarsOwned,
        AddressLine1,
        AddressLine2,
        Phone,
        DateFirstPurchase,
        CommuteDistance
    FROM dbo.DimCustomer
    WHERE CustomerKey = 11020

    UNION ALL

    SELECT
        999003 AS CustomerKey,
        GeographyKey,
        CustomerAlternateKey,
        Title,
        FirstName,
        MiddleName,
        LastName,
        NameStyle,
        BirthDate,
        MaritalStatus,
        Suffix,
        Gender,
        EmailAddress,
        YearlyIncome,
        TotalChildren,
        NumberChildrenAtHome,
        EnglishEducation,
        SpanishEducation,
        FrenchEducation,
        EnglishOccupation,
        SpanishOccupation,
        FrenchOccupation,
        HouseOwnerFlag,
        NumberCarsOwned,
        AddressLine1,
        AddressLine2,
        Phone,
        DateFirstPurchase,
        CommuteDistance
    FROM dbo.DimCustomer
    WHERE CustomerKey = 11035
)

SELECT *
INTO dbo.DimCustomer_CleaningActivity
FROM dirty_customer_data;
GO

Task 1

-- Task 1: Review the Table
-- Show the first 10 rows of DimCustomer_CleaningActivity

SELECT TOP 10 *
FROM dbo.DimCustomer_CleaningActivity;

-- Task 2: Count Missing Values Per Column

SELECT
    COUNT(*) AS TotalRows,

    SUM(CASE WHEN EmailAddress        IS NULL THEN 1 ELSE 0 END) AS Null_EmailAddress,
    SUM(CASE WHEN Phone               IS NULL THEN 1 ELSE 0 END) AS Null_Phone,
    SUM(CASE WHEN AddressLine1        IS NULL THEN 1 ELSE 0 END) AS Null_AddressLine1,
    SUM(CASE WHEN Gender              IS NULL THEN 1 ELSE 0 END) AS Null_Gender,
    SUM(CASE WHEN MaritalStatus       IS NULL THEN 1 ELSE 0 END) AS Null_MaritalStatus,
    SUM(CASE WHEN BirthDate           IS NULL THEN 1 ELSE 0 END) AS Null_BirthDate,
    SUM(CASE WHEN YearlyIncome        IS NULL THEN 1 ELSE 0 END) AS Null_YearlyIncome,
    SUM(CASE WHEN TotalChildren       IS NULL THEN 1 ELSE 0 END) AS Null_TotalChildren,
    SUM(CASE WHEN NumberChildrenAtHome IS NULL THEN 1 ELSE 0 END) AS Null_NumberChildrenAtHome,
    SUM(CASE WHEN NumberCarsOwned     IS NULL THEN 1 ELSE 0 END) AS Null_NumberCarsOwned,
    SUM(CASE WHEN CommuteDistance     IS NULL THEN 1 ELSE 0 END) AS Null_CommuteDistance

FROM dbo.DimCustomer_CleaningActivity;


-- Task 3: View Rows with Missing Values
-- Show all rows where any important customer field is NULL

SELECT
    CustomerKey,
    FirstName,
    LastName,
    EmailAddress,
    Phone,
    AddressLine1,
    Gender,
    MaritalStatus,
    BirthDate,
    YearlyIncome,
    TotalChildren,
    NumberChildrenAtHome,
    NumberCarsOwned,
    CommuteDistance

FROM dbo.DimCustomer_CleaningActivity

WHERE
    EmailAddress         IS NULL
    OR Phone             IS NULL
    OR AddressLine1      IS NULL
    OR Gender            IS NULL
    OR MaritalStatus     IS NULL
    OR BirthDate         IS NULL
    OR YearlyIncome      IS NULL
    OR TotalChildren     IS NULL
    OR NumberChildrenAtHome IS NULL
    OR NumberCarsOwned   IS NULL
    OR CommuteDistance   IS NULL

ORDER BY CustomerKey;

-- Task 4: Find Duplicate Customers
-- Use CustomerAlternateKey to detect rows appearing more than once

SELECT
    CustomerAlternateKey,
    COUNT(*)                              AS DuplicateCount,
    MIN(CustomerKey)                      AS OriginalKey,
    MAX(CustomerKey)                      AS DuplicateKey,
    MIN(FirstName)                        AS FirstName,
    MIN(LastName)                         AS LastName,
    MIN(EmailAddress)                     AS EmailAddress

FROM dbo.DimCustomer_CleaningActivity

GROUP BY CustomerAlternateKey

HAVING COUNT(*) > 1

ORDER BY DuplicateCount DESC;

-- ============================================================
-- TASK 5: View Duplicate Records
-- Display full details of all duplicated customers
-- ============================================================

SELECT
    CustomerKey,
    CustomerAlternateKey,
    FirstName,
    LastName,
    EmailAddress,
    Phone,
    BirthDate,
    Gender,
    MaritalStatus,
    AddressLine1,
    YearlyIncome,
    DateFirstPurchase

FROM dbo.DimCustomer_CleaningActivity

WHERE CustomerAlternateKey IN (
    SELECT CustomerAlternateKey
    FROM dbo.DimCustomer_CleaningActivity
    GROUP BY CustomerAlternateKey
    HAVING COUNT(*) > 1
)

ORDER BY CustomerAlternateKey, CustomerKey;

-- ============================================================
-- TASK 6: Detect Income Outliers
-- Flag YearlyIncome below 0 or above 250,000
-- ============================================================

SELECT
    CustomerKey,
    FirstName,
    LastName,
    YearlyIncome,

    CASE
        WHEN YearlyIncome < 0      THEN 'Negative Income'
        WHEN YearlyIncome > 250000 THEN 'Unrealistically High'
        ELSE 'Valid'
    END AS IncomeFlag

FROM dbo.DimCustomer_CleaningActivity

WHERE YearlyIncome < 0
   OR YearlyIncome > 250000

ORDER BY YearlyIncome;
-- ============================================================
-- TASK 7: Detect Car Ownership Outliers
-- Flag NumberCarsOwned below 0 or above 5
-- ============================================================

SELECT
    CustomerKey,
    FirstName,
    LastName,
    NumberCarsOwned,

    CASE
        WHEN NumberCarsOwned < 0 THEN 'Negative Value'
        WHEN NumberCarsOwned > 5 THEN 'Unrealistically High'
        ELSE 'Valid'
    END AS CarsOwnedFlag

FROM dbo.DimCustomer_CleaningActivity

WHERE NumberCarsOwned < 0
   OR NumberCarsOwned > 5

ORDER BY NumberCarsOwned;

-- ============================================================
-- TASK 8: Detect Children Count Outliers
-- Flag TotalChildren or NumberChildrenAtHome above 10
-- ============================================================

SELECT
    CustomerKey,
    FirstName,
    LastName,
    TotalChildren,
    NumberChildrenAtHome,

    CASE
        WHEN TotalChildren > 10        THEN 'Unrealistically High'
        WHEN TotalChildren IS NULL     THEN 'Missing'
        ELSE 'Valid'
    END AS TotalChildren_Flag,

    CASE
        WHEN NumberChildrenAtHome > 10     THEN 'Unrealistically High'
        WHEN NumberChildrenAtHome IS NULL  THEN 'Missing'
        ELSE 'Valid'
    END AS ChildrenAtHome_Flag

FROM dbo.DimCustomer_CleaningActivity

WHERE TotalChildren > 10
   OR NumberChildrenAtHome > 10

ORDER BY TotalChildren DESC, NumberChildrenAtHome DESC;

-- ============================================================
-- TASK 9: Detect Birth Date Outliers
-- Flag BirthDate before 1920-01-01 or after today
-- ============================================================

SELECT
    CustomerKey,
    FirstName,
    LastName,
    BirthDate,

    CASE
        WHEN BirthDate < '1920-01-01'          THEN 'Too Far in the Past'
        WHEN BirthDate > CAST(GETDATE() AS DATE) THEN 'Future Date'
        ELSE 'Valid'
    END AS BirthDate_Flag,

    DATEDIFF(YEAR, BirthDate, GETDATE()) AS ApparentAge

FROM dbo.DimCustomer_CleaningActivity

WHERE BirthDate < '1920-01-01'
   OR BirthDate > CAST(GETDATE() AS DATE)

ORDER BY BirthDate;

-- ============================================================
-- TASK 10: Check Text Quality Issues
-- Check FirstName, LastName, Gender, MaritalStatus
-- ============================================================

-- ── 10A: Leading / Trailing Spaces ──────────────────────────
SELECT
    CustomerKey,
    FirstName,
    LastName,
    LEN(FirstName)              AS FirstName_Len,
    LEN(LTRIM(RTRIM(FirstName))) AS FirstName_Trimmed_Len,
    LEN(LastName)               AS LastName_Len,
    LEN(LTRIM(RTRIM(LastName)))  AS LastName_Trimmed_Len,

    CASE
        WHEN LEN(FirstName) != LEN(LTRIM(RTRIM(FirstName))) THEN 'Extra Spaces'
        ELSE 'Clean'
    END AS FirstName_SpaceFlag,

    CASE
        WHEN LEN(LastName) != LEN(LTRIM(RTRIM(LastName))) THEN ' Extra Spaces'
        ELSE 'Clean'
    END AS LastName_SpaceFlag

FROM dbo.DimCustomer_CleaningActivity

WHERE LEN(FirstName) != LEN(LTRIM(RTRIM(FirstName)))
   OR LEN(LastName)  != LEN(LTRIM(RTRIM(LastName)));


-- ── 10B: Lowercase / Non-Standard Names ─────────────────────
SELECT
    CustomerKey,
    FirstName,
    LastName

FROM dbo.DimCustomer_CleaningActivity

WHERE FirstName = UPPER(LEFT(LTRIM(FirstName),1)) 
                 + LOWER(SUBSTRING(LTRIM(FirstName),2,LEN(FirstName)))
   OR LastName  = UPPER(LEFT(LTRIM(LastName),1))  
                 + LOWER(SUBSTRING(LTRIM(LastName),2,LEN(LastName)));


-- ── 10C: Gender — Non-Standard Values ───────────────────────
SELECT
    CustomerKey,
    Gender,

    CASE
        WHEN Gender = 'm'      THEN ' Lowercase m  → should be M'
        WHEN Gender = 'female' THEN ' Full word    → should be F'
        WHEN Gender IS NULL    THEN ' Missing'
        ELSE 'Valid'
    END AS Gender_Flag

FROM dbo.DimCustomer_CleaningActivity

WHERE Gender NOT IN ('M','F')
   OR Gender IS NULL;


-- ── 10D: MaritalStatus — Non-Standard Values ────────────────
SELECT
    CustomerKey,
    MaritalStatus,

    CASE
        WHEN MaritalStatus = 'single'  THEN ' Full word → should be S'
        WHEN MaritalStatus = 'married' THEN ' Full word → should be M'
        WHEN MaritalStatus IS NULL     THEN 'Missing'
        ELSE 'Valid'
    END AS MaritalStatus_Flag

FROM dbo.DimCustomer_CleaningActivity

WHERE MaritalStatus NOT IN ('S','M')
   OR MaritalStatus IS NULL;
