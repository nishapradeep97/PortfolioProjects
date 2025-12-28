1.**Automatic File Sorter**
    A simple Python script that automatically organizes files in a directory by sorting them into folders based on file type.
    **Features**
      Scans a target directory
      Creates folders if missing
      Moves files by extension:
      CSV (.csv)
      Images (.jpg)
      Text (.txt)
      PDFs (.pdf)
      Prevents duplicate overwrites
    **Tech Stack**
      Python
      os and shutil modules
    **How to Run**
        1.Update the directory path in the script
        2.Run:
          python file_organizer.py

2.**NHL Team Statistics Web Scraping Project**
        This project scrapes NHL team statistics from a website using BeautifulSoup, cleans the extracted data, and structures it into a usable tabular format for         analysis.
    **📌 Project Overview**
        The goal of this project is to demonstrate how raw HTML data can be collected, cleaned, and transformed into structured data suitable for analysis or              automation workflows.
        **⚙️ Key Steps**
        Scraped HTML table data using BeautifulSoup
        Extracted team-wise statistics row by row
        Cleaned text data using .strip()
        Handled missing values
        Converted data into a structured Pandas DataFrame
        **Tech Stack**
        Python
        BeautifulSoup
        Pandas
        **Data Fields**
        Team Name
        Year
        Wins
        Losses
        OT Losses
        Win Percentage
        Goals For
        Goals Against
        Goal Difference
        **Use Case**
        Web scraping practice
        Data cleaning & preprocessing
        Beginner data pipeline project

3. **Data Cleaning in SQL – Global Layoffs Dataset**
    This project focuses on cleaning and standardizing a global layoffs dataset using SQL. The goal is to transform raw, inconsistent data into a reliable format suitable for analysis.
    **Project Overview**
       The dataset contained duplicates, inconsistent text values, incorrect date formats, and missing data. SQL queries were used to systematically clean, standardize, and validate the data.
    **Key Data Cleaning Steps**
       Created staging tables to preserve raw data
       Identified and removed duplicate records using ROW_NUMBER()
       Trimmed whitespace and standardized text fields
       Normalized industry and country values
       Converted date column from text to DATE format
       Handled NULL and blank values
       Removed irrelevant rows and temporary columns
    **Tech Stack**
       **SQL (MySQL)**
           Window Functions
           CTEs
           Data Definition & Manipulation Queries
    **Dataset Fields**
        Company
        Location
        Industry
        Total Laid Off
        Percentage Laid Off
        Date
        Stage
        Country
        Funds Raised (Millions)
   **Use Case**
        Data cleaning & preprocessing practice
        SQL portfolio project
        Foundation for exploratory data analysis
        Data / BI / AI Automation internship showcase

   
