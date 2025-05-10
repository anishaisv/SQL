# Employee and Sales Subqueries Practice

## Description

This repository contains SQL queries for practicing:
- Subqueries and correlated subqueries
- Joins to combine data from multiple tables
- Employee and department data analysis
- Sales database setup and queries

## Sections

### 1. Employee & Department
Queries for analyzing employee data, including:
- Average salary and employees earning above average
- Maximum salary by department
- Correlated subqueries for department-specific analysis
- Employees with maximum salary in the company

### 2. Sales Database Setup
Setting up a sample sales database with tables for:
- `Products`
- `Customers`
- `Orders`

### 3. Sales Subqueries
Sales-related queries using subqueries, including:
- Customers who ordered products priced over $40
- Customers who ordered more than 5 units
- Customers with total order amount greater than John Doe's orders

## Setup

1. **Create the database**:
    ```sql
    CREATE DATABASE Sales2;
    ```

2. **Create tables**: Run the provided SQL scripts to create `Products`, `Customers`, `Orders`, `da06emp`, and `da06dept` tables.

3. **Insert sample data**: Run the `INSERT INTO` queries to populate the tables with sample data.

