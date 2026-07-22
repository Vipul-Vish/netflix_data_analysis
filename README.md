# 🎬 Netflix Data Analysis using SQL

## 📌 Project Overview

This project focuses on analyzing the **Netflix Movies and TV Shows dataset** using **PostgreSQL**. The goal of this project is to explore Netflix's content catalog, perform data cleaning and transformation, and extract meaningful business insights using SQL queries.

The analysis covers content distribution, ratings, countries, directors, genres, release trends, movie duration, mature content, and TV show seasons.

This project demonstrates practical SQL skills including **Data Cleaning, Aggregation, Filtering, Grouping, Conditional Aggregation, Subqueries, String Manipulation, Date Extraction, and Analytical Queries**.

---

## 🎯 Project Objectives

The main objectives of this project are:

* Analyze the distribution of **Movies vs TV Shows** on Netflix.
* Identify the most common **content ratings**.
* Find the **top countries** producing Netflix titles.
* Identify directors with the highest number of titles.
* Analyze yearly trends in titles added to Netflix.
* Find the oldest and newest release years by content type.
* Analyze Netflix content distribution across different decades.
* Calculate average movie duration by release year.
* Identify the most common genres on Netflix.
* Calculate the average number of genres per title.
* Find titles with the longest gap between release and Netflix availability.
* Compare Movies and TV Shows across countries.
* Analyze the percentage of mature-rated content over the years.
* Identify TV Shows with the highest number of seasons.

---

## 🛠️ Tools & Technologies

* **Database:** PostgreSQL
* **Language:** SQL
* **Data Analysis:** SQL Aggregations & Analytical Queries
* **Version Control:** Git & GitHub

---

## 🗂️ Dataset

The dataset contains information about Netflix Movies and TV Shows, including:

* `show_id`
* `type`
* `title`
* `director`
* `casts`
* `country`
* `date_added`
* `release_year`
* `rating`
* `duration`
* `listed_in`
* `description`

The dataset was cleaned and transformed before performing the analysis.

---

## 🧹 Data Cleaning & Transformation

Before performing analysis, several data preparation steps were completed.

### 1. Handling Missing Values

Missing values in important columns were identified and handled.

* Missing `director` → `Not Specified`
* Missing `casts` → `Not Specified`
* Missing `country` → `Not Specified`
* Missing `rating` → `Not Rated`

This helped make the dataset more consistent for analysis.

### 2. Date Transformation

The original `date_added` column was stored as text. A new `date_added_clean` column was created with the proper `DATE` data type.

This allowed year-based analysis of when titles were added to Netflix.

### 3. Duration Transformation

The original `duration` column contained values such as:

* `120 min`
* `2 Seasons`

Separate numeric columns were created:

* `duration_minutes` → Movie duration in minutes
* `seasons` → Number of seasons for TV Shows

This made numerical analysis easier.

---

# 📊 Data Analysis & Business Questions

## 1. Movies vs TV Shows Distribution

**Question:** What is the distribution of Movies and TV Shows on Netflix?

This analysis calculates the total number of Movies and TV Shows and their percentage of the overall Netflix catalog.

---

## 2. Content Rating Distribution

**Question:** What is the distribution of Netflix titles by rating?

This analysis identifies the most common content ratings and calculates their percentage of the overall Netflix catalog.

---

## 3. Top 10 Countries by Number of Titles

**Question:** What are the top 10 countries producing the most Netflix titles?

This analysis identifies the countries with the highest number of Netflix titles.

---

## 4. Top 10 Directors

**Question:** Who are the top 10 directors with the most titles on Netflix?

This analysis identifies directors who have the highest number of titles in the dataset.

---

## 5. Titles Added by Year

**Question:** How many Netflix titles were added in each year?

This analysis examines the yearly trend of content added to Netflix.

---

## 6. Oldest and Newest Releases

**Question:** What are the oldest and newest release years for Movies and TV Shows on Netflix?

This analysis identifies the earliest and latest release years for Movies and TV Shows separately.

---

## 7. Titles Released by Decade

**Question:** How many Netflix titles were released in each decade?

This analysis groups titles into decades based on their release year to identify long-term content trends.

---

## 8. Average Movie Duration by Release Year

**Question:** What is the average duration of Netflix Movies by release year?

This analysis calculates the average movie duration for each release year.

---

## 9. Top 10 Most Common Genres

**Question:** What are the top 10 most common genres on Netflix?

This analysis identifies the most frequently occurring genres. Since a title can belong to multiple genres, the genre data is split and analyzed individually.

---

## 10. Average Genres per Title

**Question:** What is the average number of genres per Netflix title?

This analysis calculates how many genres are associated with a Netflix title on average.

---

## 11. Longest Gap Between Release and Netflix Addition

**Question:** Which Netflix titles had the longest gap between their release year and the year they were added to Netflix?

This analysis identifies titles that were added to Netflix many years after their original release.

---

## 12. Movies vs TV Shows by Country

**Question:** Which countries have the highest number of Netflix Movies and TV Shows?

This analysis compares the number of Movies and TV Shows associated with each country.

---

## 13. Mature Content Analysis

**Question:** What percentage of Netflix titles released each year are rated for mature audiences?

This analysis calculates the percentage of titles rated as `TV-MA`, `R`, or `NC-17` for each release year.

---

## 14. TV Shows with the Most Seasons

**Question:** Which TV Shows on Netflix have the most seasons?

This analysis identifies the top 10 TV Shows with the highest number of seasons available in the dataset.

---

# 💡 Key SQL Concepts Used

This project demonstrates the following SQL concepts:

* `SELECT`
* `WHERE`
* `GROUP BY`
* `ORDER BY`
* `LIMIT`
* `COUNT()`
* `AVG()`
* `MIN()`
* `MAX()`
* `ROUND()`
* `FILTER`
* `CASE`
* `EXTRACT()`
* `IS NULL`
* `IN`
* Subqueries
* Aggregate Functions
* Conditional Aggregation
* String Manipulation
* Date Transformation
* `STRING_TO_ARRAY()`
* `UNNEST()`
* `ARRAY_LENGTH()`
* Regular Expressions
* Data Cleaning
* Data Transformation

---

# 📁 Project Structure

```text
Netflix-SQL-Data-Analysis/
 README.md
netflix_data_analysis.sql
netflix_titles.csv

```

---

# 🚀 How to Run This Project

### Step 1: Clone the Repository

```bash
git clone YOUR_GITHUB_REPOSITORY_URL
```

### Step 2: Open PostgreSQL

Create a database and connect to it using PostgreSQL or pgAdmin.

### Step 3: Create the Netflix Table

Run the table creation query provided in the SQL file.

### Step 4: Load the Dataset

Import the Netflix dataset into the `netflix` table.

### Step 5: Run Data Cleaning Queries

Execute the data cleaning and transformation queries.

### Step 6: Run Analysis Queries

Execute the analytical SQL queries to explore Netflix content and generate insights.

---

# 📈 Project Insights

The analysis helps answer questions such as:

* Is Netflix dominated by Movies or TV Shows?
* Which ratings are most common?
* Which countries contribute the most titles?
* Which directors have the most titles?
* How has Netflix content growth changed over time?
* Which genres are most popular?
* How many genres are associated with an average title?
* Which titles took the longest to appear on Netflix?
* Which countries have more Movies compared to TV Shows?
* How has mature-rated content changed over the years?
* Which TV Shows have the most seasons?

---

# 🔍 Important Note

The `country` and `listed_in` columns may contain multiple comma-separated values within a single row. For more accurate country-level or genre-level analysis, these values should be normalized or split into separate rows.

This project uses PostgreSQL-specific features such as `FILTER`, `STRING_TO_ARRAY()`, `UNNEST()`, and `ARRAY_LENGTH()`.

---

# 👨‍💻 Author

**Vipul Kumar**


---

## ⭐ If you found this project useful

Feel free to ⭐ star this repository and explore the SQL queries to learn more about Netflix data analysis.
