USE uk_online_retail;

CREATE TABLE IF NOT EXISTS dim_product (
    product_key INT AUTO_INCREMENT PRIMARY KEY,
    stock_code VARCHAR(20) NOT NULL,
    description VARCHAR(255)
);

INSERT INTO dim_product (
    stock_code,
    description
)
SELECT
    StockCode,
    MAX(Description) AS Description
FROM stg_sales
GROUP BY StockCode;


CREATE TABLE IF NOT EXISTS dim_customer (
    customer_key INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT NOT NULL,
    country VARCHAR(100)
);

INSERT INTO dim_customer (
    customer_id,
    country
)
SELECT
    CustomerID,
    MAX(Country) AS Country
FROM stg_sales
WHERE CustomerID IS NOT NULL
GROUP BY CustomerID;


CREATE TABLE IF NOT EXISTS dim_date (
    date_key INT PRIMARY KEY,
    full_date DATE NOT NULL,
    year INT,
    quarter INT,
    month INT,
    month_name VARCHAR(20),
    day INT,
    weekday_name VARCHAR(20)
);

INSERT INTO dim_date (
    date_key,
    full_date,
    year,
    quarter,
    month,
    month_name,
    day,
    weekday_name
)
WITH RECURSIVE date_series AS (
    SELECT MIN(DATE(InvoiceDate)) AS full_date
    FROM stg_sales

    UNION ALL

    SELECT DATE_ADD(full_date, INTERVAL 1 DAY)
    FROM date_series
    WHERE full_date < (
        SELECT MAX(DATE(InvoiceDate))
        FROM stg_sales
    )
)
SELECT
    CAST(DATE_FORMAT(full_date, '%Y%m%d') AS UNSIGNED),
    full_date,
    YEAR(full_date),
    QUARTER(full_date),
    MONTH(full_date),
    MONTHNAME(full_date),
    DAY(full_date),
    DAYNAME(full_date)
FROM date_series;