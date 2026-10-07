### UK Online Retail — Data Analytics & ETL Pipeline

#### Overview

This project implements an end-to-end data analytics and ETL pipeline using the **UK Online Retail dataset**, containing 541,909 transaction records.

The project covers data ingestion, data quality validation, transformation, MySQL database loading, dimensional data modelling, and analytical SQL views. A Jupyter Notebook is also included for exploratory analysis and understanding the dataset before and during the pipeline development.

#### Architecture

```text
Online Retail.xlsx
        ↓
Python Ingestion
        ↓
Raw Data
        ↓
Data Quality Validation
        ↓
Data Transformation
        ↓
MySQL Staging
        ↓
Dimension & Fact Tables
        ↓
Analytical SQL Views
        ↓
Data Analysis & Reporting
```

#### Data Engineering

The pipeline includes:

- Python-based data ingestion
- Data quality checks and validation
- Duplicate and invalid-record handling
- Data cleaning and transformation
- Revenue calculation
- MySQL database loading
- Staging layer
- Dimension tables
- Fact table
- Analytical SQL views
- Data validation and reconciliation checks

#### Data Quality

The source dataset contains several data-quality issues, including:

- 5,268 duplicate rows
- 135,080 missing CustomerID values
- 1,454 missing Description values
- 9,288 cancelled transactions
- 10,624 negative Quantity values
- 2,515 zero UnitPrice values
- 2 negative UnitPrice values

The pipeline validates and transforms the source data before loading the cleaned dataset into the MySQL database.

#### Data Model

The project uses a dimensional modelling approach consisting of:

- `fact_sales`
- `dim_customer`
- `dim_product`
- `dim_date`

The fact and dimension tables provide a structured foundation for analytical queries and reporting.

#### Analytics

SQL analytical views are created to support analysis of:

- Revenue
- Orders
- Customers
- Products
- Sales trends
- Average order value
- Transaction-level metrics

#### Exploratory Analysis

The project includes a Jupyter Notebook for exploratory data analysis, initial data inspection, data-quality assessment, and understanding the characteristics of the retail dataset.

**Jupyter Notebook:** [UK_Online_Retail_Analysis.ipynb](notebooks/UK_Online_Retail_Analysis.ipynb)

#### Technologies

- Python
- Pandas
- NumPy
- MySQL
- SQL
- Jupyter Notebook
- Git & GitHub

#### Project Status

Core ETL, data validation, MySQL data modelling, and analytical SQL components have been implemented. The project can be extended with additional reporting, cloud-based data storage, orchestration, and modern data engineering tools as future enhancements.



