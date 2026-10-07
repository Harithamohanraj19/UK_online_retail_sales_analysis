
import pandas as pd
from sqlalchemy import create_engine


def load_raw_data(filepath: str):
    df = pd.read_excel(filepath)

    engine = create_engine("mysql+mysqlconnector://root:1234@localhost/uk_online_retail")

    df.to_sql(
        name="raw_sales",
        con=engine,
        if_exists="append",
        index=False
    )

    print(f"Loaded {len(df):,} rows into raw_sales")


if __name__ == "__main__":
    file_path = "data/raw/Online Retail.xlsx"

    load_raw_data(file_path)