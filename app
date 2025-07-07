import streamlit as st
from ui.layout import AppLayout
from core.download_manager import DataDownloader
from core.matcher import TradeDataMatcher

def main():
    st.set_page_config(page_title="Trade & Exception Data Downloader", layout="wide")
    st.title("📥 Parallel Data Downloader")

    layout = AppLayout()
    product_type, legal_entities, source_systems, start_date, end_date, run = layout.render_filters()

    if run and legal_entities and source_systems:
        downloader = DataDownloader(
            product_type=product_type,
            legal_entities=legal_entities,
            source_systems=source_systems,
            start_date=start_date,
            end_date=end_date
        )
        downloader.run_parallel_download()
    elif run:
        st.warning("Please select at least one legal entity and one source system.")

    # After downloader.run_parallel_download()
    matcher = TradeDataMatcher()
    matched = matcher.match_files()
    
    if matched:
        st.success(f"✅ {len(matched)} matched files created in `downloads/MATCHED`")
    else:
        st.warning("⚠️ No matching records found between UAT and PROD files.")

