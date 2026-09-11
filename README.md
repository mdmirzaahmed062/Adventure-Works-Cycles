# AdventureWorks Cycles

Data analysis project built on the AdventureWorks sample dataset (a fictional bicycle manufacturer, "Adventure Works Cycles"). This repo covers data cleaning, SQL analysis, and dashboards/visualizations derived from the AdventureWorks OLTP/OLAP database.

## 📌 Overview

Adventure Works Cycles is a multinational manufacturer and reseller of bicycles and cycling accessories. This project uses the publicly available AdventureWorks sample database to explore sales performance, customer behavior, product trends, and operational metrics.

## 🎯 Objectives

- Clean and prepare raw AdventureWorks data for analysis
- Write SQL queries to answer key business questions
- Build interactive dashboards (Power BI / Tableau / Excel)
- Identify trends in sales, customers, and product categories
- Document insights and recommendations

## 🗂️ Project Structure
## 🛠️ Tech Stack

- *Database:* SQL Server / PostgreSQL / MySQL
- *Language:* SQL
- *BI Tools:* Power BI / Tableau
- *Version Control:* Git & GitHub

## 📊 Dataset

The AdventureWorks database is Microsoft's official sample dataset, available in several editions:
- AdventureWorksLT (lightweight version, ideal for BI projects)
- AdventureWorks (full OLTP version)
- AdventureWorksDW (data warehouse / OLAP version)

Download link: [Microsoft SQL Server Samples](https://github.com/microsoft/sql-server-samples/releases)

## 🚀 Getting Started

### Prerequisites
- SQL Server / PostgreSQL installed
- Power BI Desktop or Tableau (optional, for dashboards)

### Installation

```bash
-- Example for SQL Server
RESTORE DATABASE AdventureWorks
FROM DISK = 'path\to\AdventureWorks.bak'
# Clone the repository
git clone https://github.com/your-username/adventureworks-cycles.git
cd adventureworks-cycles
