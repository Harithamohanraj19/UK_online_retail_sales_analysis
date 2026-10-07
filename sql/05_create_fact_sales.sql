USE uk_online_retail;

CREATE TABLE IF NOT EXISTS fact_sales (
    sales_key BIGINT AUTO_INCREMENT PRIMARY KEY,
    invoice_no VARCHAR(20) NOT NULL,
    product_key INT NOT NULL,
    customer_key INT NULL,
    date_key INT NOT NULL,
    quantity INT NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    revenue DECIMAL(12,2) NOT NULL,

    FOREIGN KEY (product_key)
        REFERENCES dim_product(product_key),

    FOREIGN KEY (customer_key)
        REFERENCES dim_customer(customer_key),

    FOREIGN KEY (date_key)
        REFERENCES dim_date(date_key)
);

INSERT INTO fact_sales (
    invoice_no,
    product_key,
    customer_key,
    date_key,
    quantity,
    unit_price,
    revenue
)
SELECT
    s.InvoiceNo,
    p.product_key,
    c.customer_key,
    d.date_key,
    s.Quantity,
    s.UnitPrice,
    s.Revenue
FROM stg_sales s
JOIN dim_product p
    ON s.StockCode = p.stock_code
LEFT JOIN dim_customer c
    ON s.CustomerID = c.customer_id
JOIN dim_date d
    ON DATE(s.InvoiceDate) = d.full_date;