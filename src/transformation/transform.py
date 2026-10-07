
import pandas as pd


def transform_sales_data(df: pd.DataFrame) -> pd.DataFrame:

    # Remove exact duplicate rows
    df = df.drop_duplicates().copy()

    # Remove cancelled invoices
    df = df[~df["InvoiceNo"].astype(str).str.startswith("C")]

    # Keep only positive quantities
    df = df[df["Quantity"] > 0]

    # Keep only positive prices
    df = df[df["UnitPrice"] > 0]

    # Calculate revenue
    df["Revenue"] = df["Quantity"] * df["UnitPrice"]

    return df



if __name__ == "__main__":
    from src.ingestion.ingest import extract_data

    file_path = "data/raw/Online Retail.xlsx"

    # Extract raw data
    df = extract_data(file_path)

    print(f"Raw rows: {len(df):,}")

    # Transform data
    clean_df = transform_sales_data(df)

    print(f"Clean rows: {len(clean_df):,}")
    print(f"Rows removed: {len(df) - len(clean_df):,}")

    print("\nCleaned columns:")
    print(list(clean_df.columns))

    print("\nSample:")
    print(clean_df.head())