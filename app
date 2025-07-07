import streamlit as st
from ui.layout import AppLayout
from core.download_manager import DataDownloader

def main():
    st.set_page_config(page_title="Trade + Exception Downloader", layout="wide")
    st.title("📥 Parallel Data Downloader")

    layout = AppLayout()
    product_type, legal_entity, source_system, start_date, end_date, run = layout.render_filters()

    if run:
        downloader = DataDownloader(
            product_type=product_type,
            legal_entity=legal_entity,
            source_system=source_system,
            start_date=start_date,
            end_date=end_date
        )
        downloader.run_parallel_download()

if __name__ == "__main__":
    main()

