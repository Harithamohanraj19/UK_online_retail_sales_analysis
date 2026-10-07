
import pandas as pd

def run_quality_checks(df: pd.DataFrame) -> dict:
    results = {
        "row_count": len(df),
        "duplicate_rows": int(df.duplicated().sum()),
        "missing_customer_id": int(df['CustomerID'].isna().sum()),
        "missing_description": int(df['Description'].isna().sum()),
        "cancelled_rows": int(
            df["InvoiceNo"].astype(str).str.startswith("C").sum()
        ),
        "negative_quantity_rows": int((df['Quantity'] < 0).sum()),
        "zero_price_rows": int((df['UnitPrice'] == 0).sum()),
        "negative_price_rows": int((df['UnitPrice'] < 0).sum()),
    }
    
    return results



if __name__ == "__main__":
    from src.ingestion.ingest import extract_data

    file_path = "data/raw/Online Retail.xlsx"

    df = extract_data(file_path)

    results = run_quality_checks(df)

    for check, value in results.items():
        print(f"{check}: {value:,}")