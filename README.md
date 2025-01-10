# Walmart Sales Analysis Project

## Project Overview
This project focuses on analyzing Walmart sales data to uncover trends, patterns, and actionable insights. The workflow includes data acquisition, cleaning, database management, and visualization.

## Data Source
- **Kaggle API**: Used to fetch Walmart sales data.

## Key Objectives
1. Clean and preprocess raw data to ensure consistency and accuracy.
2. Perform in-depth analysis to identify key sales trends.
3. Visualize findings effectively using Power BI.

## Tools and Technologies
- **Python (Pandas)**: For data cleaning and preprocessing.
- **PostgreSQL**: To store and manage the cleaned data.
- **Power BI**: For creating an interactive dashboard.
- **Kaggle API**: To acquire the dataset programmatically.

## Workflow
1. **Data Acquisition**:
   - Accessed the dataset via the Kaggle API.
2. **Data Cleaning**:
   - Removed duplicates, handled missing values, and ensured data integrity using Pandas.
3. **Data Storage**:
   - Saved cleaned data into PostgreSQL for structured querying.
4. **Data Analysis**:
   - Conducted analysis using SQL queries to extract insights.
5. **Visualization**:
   - Imported data into Power BI to create an interactive dashboard.

## Power BI Dashboard
The dashboard includes the following:
- **KPIs**:
  - Total Sales
  - Monthly Growth Rate
  - Average Sales per Region
- **Charts**:
  - Sales Trends by Product Category
  - Regional Sales Distribution
  - Year-over-Year Comparisons
  - Top-Selling Products and Revenue Share

## Results and Insights
- Identified the top-performing product categories.
- Highlighted seasonal trends and regional preferences.
- Provided actionable insights for marketing and inventory planning.

## How to Run the Project
1. Clone this repository:
   ```bash
   git clone https://github.com/username/walmart-sales-analysis.git
   ```
2. Install required Python libraries:
   ```bash
   pip install -r requirements.txt
   ```
3. Use the Kaggle API to download the dataset (instructions provided in the `data/README.md` file).
4. Run the data cleaning script (`scripts/data_cleaning.py`).
5. Load the cleaned data into PostgreSQL using the provided SQL scripts.
6. Open the Power BI file (`dashboard/walmart_sales.pbix`) to view the dashboard.

## Folder Structure
```
.
├── data/
│   ├── raw/ (raw data)
│   ├── processed/ (cleaned data)
├── scripts/
│   ├── data_cleaning.py
│   ├── data_analysis.sql
├── dashboard/
│   ├── walmart_sales.pbix
├── README.md
```

## Conclusion
This project demonstrates a complete workflow from data collection to actionable insights through visualization. It showcases skills in Python, SQL, and Power BI for end-to-end data analysis.
