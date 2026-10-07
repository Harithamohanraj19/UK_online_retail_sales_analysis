
import pandas as pd
from pathlib import Path


def extract_data(file_path: str) -> pd.DataFrame:
    path = Path(file_path)

    if not path.exists():
        raise FileNotFoundError(f"Source file not found: {path}")
    
    df = pd.read_excel(path)

    return df




if __name__ == "__main__":
    file_path = "data/raw/Online Retail.xlsx"

    df = extract_data(file_path)

    print(f"Rows {len(df):,}")
    print(f"Columns: {list(df.columns)}")