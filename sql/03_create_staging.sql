USE uk_online_retail;

CREATE TABLE IF NOT EXISTS stg_sales (
    InvoiceNo VARCHAR(20),
    StockCode VARCHAR(20),
    Description VARCHAR(255),
    Quantity INT,
    InvoiceDate DATETIME,
    UnitPrice DECIMAL(10,2),
    CustomerID INT,
    Country VARCHAR(100),
    Revenue DECIMAL(12,2)
);

TRUNCATE TABLE stg_sales;

INSERT INTO stg_sales (
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    Revenue
)
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDate,
    UnitPrice,
    CustomerID,
    Country,
    Quantity * UnitPrice AS Revenue
FROM (
    SELECT
        InvoiceNo,
        StockCode,
        Description,
        Quantity,
        InvoiceDate,
        UnitPrice,
        CustomerID,
        Country,
        ROW_NUMBER() OVER (
            PARTITION BY
                InvoiceNo,
                StockCode,
                Description,
                Quantity,
                InvoiceDate,
                UnitPrice,
                CustomerID,
                Country
            ORDER BY InvoiceNo
        ) AS row_num
    FROM raw_sales
    WHERE Quantity > 0
      AND UnitPrice > 0
      AND InvoiceNo NOT LIKE 'C%'
) AS ranked_sales
WHERE row_num = 1;