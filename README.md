# olist-analytics
End-to-end SQL analytics project using the Olist Brazilian e-commerce dataset. Covers schema design, data loading, joins, KPIs, funnel analysis, delivery performance, and business insights for decision-making.

Project Overview

This project was built to replicate how SQL analytics work in a real business environment, not as a one-off exploratory exercise. Instead of jumping straight into analysis, the focus here is on creating a structured, repeatable pipeline that starts from raw data and ends with business-ready insights.

The dataset represents an e-commerce marketplace, and the analysis is designed from the perspective of a company that needs reliable metrics for decision-making. Emphasis is placed on data quality, clear transformations, and a clean analytical model that can be reused or extended later.

## Datasets

The project uses the public Olist Brazilian e-commerce dataset, which contains transactional and operational data such as:

- Customer and seller information

- Orders and order items

- Payments and reviews

- Product details and categories

- Geographic data

All datasets are first loaded into raw tables exactly as provided, without any modification.

## Project Structure & Workflow

The project follows a layered SQL workflow similar to what is used in production analytics systems:
Raw Data → Data Quality Checks → Staging → Dimensions → Facts → Analysis
Each step has a clear purpose and is implemented in a separate SQL file to keep the logic easy to follow and maintain.
Each layer is versioned separately to ensure reproducibility and clarity.


## SQL Pipeline Breakdown

### 01_schema.sql — Raw Tables

This file creates the raw database tables based directly on the source CSV files.
No transformations or business logic are applied at this stage. The goal is to store the data as-is so it can act as a reliable source of truth for the rest of the pipeline.

### 02_data_quality_checks.sql — Data Validation

Before doing any transformations, basic data quality checks are performed to understand the structure and reliability of the data. These checks include:
Total row counts
Primary key uniqueness
Null values in critical columns
Basic integrity checks across related tables
Even when no major issues are found, these checks are intentionally kept to reflect defensive practices used in real analytics workflows.

### 03_staging.sql — Staging Layer

The staging layer is where the raw data is cleaned and standardized. This includes:
Consistent column naming
Data type corrections
Timestamp normalization
Creation of helper columns such as dates
No aggregations or cross-table joins are done here. Each staging table maps directly to a single raw table.

### 04_dimensions.sql — Dimension Tables

Dimension tables are created to support analytical queries and reporting. These tables contain descriptive attributes for key entities such as customers, sellers, products, and geography.
The dimensions are designed to work within a star schema and make downstream analysis simpler and more readable.

### 05_facts.sql — Fact Tables

Fact tables store measurable business events such as orders, payments, and order items. Each fact table has a clearly defined grain and includes only numeric metrics and foreign keys to the dimension tables.
This layer is the foundation for KPIs and trend analysis.

### 06_analysis.sql — Business Analysis

This file contains analytical queries that answer practical business questions, such as revenue trends, product performance, seller behavior, and delivery outcomes.
Each query is written with clarity and is intended to be understandable by someone reviewing the project for business or technical evaluation.

## Tools Used

- SQL

- Relational database concepts

- Star schema modeling

- Git & GitHub for version control


## Project Goal

The goal of this project is to demonstrate strong SQL fundamentals, structured thinking, and an understanding of how analytics is done in real organizations. It is meant to be readable, reproducible, and easy to extend with additional metrics or dashboards in the future.
