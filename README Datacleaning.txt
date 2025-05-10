# Data Cleaning and Transformations in SQL

## Description

This script demonstrates key SQL data cleaning and transformation techniques, including:
- Data type conversions
- Identifying and cleaning dirty data
- Conditional logic using `CASE` statements
- String and date handling
- Handling `NULL` values and applying default values

## Sections

### 1. View Existing Tables
Queries to view existing data in `Products` and `Orders` tables.

### 2. Data Type Conversions
- Converting `DECIMAL` to `INT` for price rounding
- Converting `DECIMAL` to `VARCHAR` for total order amounts
- Using `SQL_VARIANT_PROPERTY` to check data types before and after conversions

### 3. Create and Populate Customers Table (TempDB)
- Create a `Customers` table in `tempdb`
- Insert sample customer data including some dirty data (e.g., `NULL` values, invalid characters, and duplicates)

### 4. Identify Dirty Data
- Identifying rows with `NULL` values in key fields
- Finding duplicate entries based on name and email
- Detecting invalid characters in names
- Checking inconsistent casing for country names

### 5. Clean the Data
- Updating `NULL` country values to `'Unknown'`
- Standardizing country names to uppercase
- Removing duplicate customer records, keeping the record with the lowest `CustID`

### 6. Handle Strings and Invalid Characters
- Trimming and formatting names
- Removing invalid characters using regular expressions (PostgreSQL and SQL Server examples)

### 7. Working with Dates
- Calculating the age of customers based on their date of birth
- SQL Server and PostgreSQL examples for age calculation

### 8. Handling NULLs and Default
