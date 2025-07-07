import os
import pandas as pd

class TradeDataMatcher:
    def __init__(self, uat_dir="downloads/UAT", prod_dir="downloads/PROD", output_dir="downloads/MATCHED"):
        self.uat_dir = uat_dir
        self.prod_dir = prod_dir
        self.output_dir = output_dir
        os.makedirs(output_dir, exist_ok=True)

    def match_files(self):
        matched_files = []

        # Loop over UAT files
        for filename in os.listdir(self.uat_dir):
            if not filename.endswith(".csv"):
                continue

            uat_file = os.path.join(self.uat_dir, filename)
            prod_file = os.path.join(self.prod_dir, filename)

            if os.path.exists(prod_file):
                df_uat = pd.read_csv(uat_file)
                df_prod = pd.read_csv(prod_file)

                # 👇 Replace these with actual join columns
                join_cols = ["TradeID", "TradeDate", "Instrument"]

                if all(col in df_uat.columns and col in df_prod.columns for col in join_cols):
                    df_matched = pd.merge(df_uat, df_prod, on=join_cols, suffixes=("_uat", "_prod"))
                    
                    if not df_matched.empty:
                        output_file = os.path.join(self.output_dir, filename)
                        df_matched.to_csv(output_file, index=False)
                        matched_files.append(output_file)
                        print(f"✅ Matched file created: {output_file}")
                    else:
                        print(f"⚠️ No matching records in: {filename}")
                else:
                    print(f"❌ Missing join columns in {filename}")

        return matched_files
