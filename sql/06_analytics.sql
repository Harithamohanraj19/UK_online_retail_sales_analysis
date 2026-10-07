USE uk_online_retail;

CREATE VIEW vw_monthly_revenue AS
SELECT
    d.year,
    d.month,
    d.month_name,
    SUM(f.revenue) AS total_revenue,
    SUM(f.quantity) AS total_quantity,
    COUNT(DISTINCT f.invoice_no) AS total_orders
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY
    d.year,
    d.month,
    d.month_name;


CREATE VIEW vw_country_revenue AS
SELECT
    COALESCE(c.country, 'Unknown') AS country,
    SUM(f.revenue) AS total_revenue,
    SUM(f.quantity) AS total_quantity,
    COUNT(DISTINCT f.invoice_no) AS total_orders
FROM fact_sales f
LEFT JOIN dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY
    COALESCE(c.country, 'Unknown');


CREATE VIEW vw_product_revenue AS
SELECT
    p.stock_code,
    p.description,
    SUM(f.quantity) AS total_quantity,
    SUM(f.revenue) AS total_revenue,
    COUNT(DISTINCT f.invoice_no) AS total_orders
FROM fact_sales f
JOIN dim_product p
    ON f.product_key = p.product_key
GROUP BY
    p.stock_code,
    p.description;


CREATE VIEW vw_customer_revenue AS
SELECT
    c.customer_id,
    c.country,
    SUM(f.revenue) AS total_revenue,
    SUM(f.quantity) AS total_quantity,
    COUNT(DISTINCT f.invoice_no) AS total_orders
FROM fact_sales f
JOIN dim_customer c
    ON f.customer_key = c.customer_key
GROUP BY
    c.customer_id,
    c.country;


CREATE VIEW vw_order_metrics AS
SELECT
    f.invoice_no,
    d.full_date,
    d.year,
    d.month,
    SUM(f.quantity) AS total_quantity,
    SUM(f.revenue) AS order_value
FROM fact_sales f
JOIN dim_date d
    ON f.date_key = d.date_key
GROUP BY
    f.invoice_no,
    d.full_date,
    d.year,
    d.month;


CREATE VIEW vw_average_order_value AS
SELECT
    COUNT(*) AS total_orders,
    SUM(order_value) AS total_revenue,
    AVG(order_value) AS average_order_value
FROM vw_order_metrics;