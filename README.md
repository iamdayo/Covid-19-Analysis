# Are People Still Getting COVID in 2026?
## COVID-19 Global Analysis (SQL Project)
**Tool:** PostgreSQL | **By:** Temidayo Olubayo

COVID-19 has faded from the headlines, but with 86,319 new cases and 3,174 deaths recorded in just the first two months of 2026, the data tells a more complicated story.

## Business Context

Over the past few years, COVID-19 has shifted from a global emergency to something that feels almost negligible. Governments have ended mandates. News channels have mostly moved on. Most people stopped tracking it.

But its reduced visibility does not mean total elimination.

This analysis investigates global COVID-19 activity through January and February 2026 to understand whether the virus still poses a measurable public health risk, and where in the world it still remains most active.

The goal is to move beyond assumptions and answer a simple question with data:

> **Is COVID-19 still relevant in 2026?**

## Table of Contents

1. [Project Overview](#project-overview)
2. [Dataset Overview](#dataset-overview)
3. [Data Preparation](#data-preparation)
4. [Data Alignment](#data-alignment)
5. [Analysis Structure](#analysis-structure)
6. [Key Findings](#key-findings)
7. [Recommendations](#recommendations)
8. [Limitations](#limitations)
9. [Tools Used](#tools-used)

## Project Overview

This project analyzes global COVID-19 data using SQL to understand how the virus has evolved over the years into 2026.

The analysis focuses on case counts, death counts, population-adjusted rates, and time-based comparisons across years.

A key design decision was accounting for **incomplete 2026 data**: because only January and February records exist so far, all multi-year comparisons were aligned to the same two-month window to ensure fair, accurate results.

## Dataset Overview

The analysis is based on two primary datasets.

### COVID-19 Dataset
- Country-level daily reporting
- Includes: new cases, cumulative cases, new deaths, cumulative deaths

### Population Dataset
- Country-level population estimates (2026)
- Yearly global population trends

These datasets were joined to enable population-adjusted metrics such as **cases per 100,000** and **deaths per 100,000**, which were critical for comparing countries of vastly different population sizes.

## Data Preparation

Before analysis, both datasets were staged and cleaned to ensure consistency and reliability.

Key steps included:

- **Staging tables**: were created to preserve raw data before any transformation
- **Population data**: was integrated into the COVID dataset for rate calculations
- **Null deaths**: were replaced with 0 to prevent calculation errors
- **Duplicate records**: no duplicate record was identified
- **Country naming inconsistencies**: were resolved as this wass a major challenge across both datasets

Some countries matched directly between datasets, while others required manual mapping due to naming differences (e.g. "United States" vs "United States of America").

To resolve this, country codes were used as the primary join key, with missing mappings handled manually. This ensured accurate merging across all records.

## Data Alignment

One critical issue identified during analysis was the **partial nature of 2026 data**, as to only January and February records are available.

Comparing two months of 2026 data against a full year of 2024 or 2025 data would produce misleading results.

To avoid this:

- All multi-year comparisons were restricted to **January–February periods only**
- Year-over-year calculations were aligned to the same two-month window
- Full-year figures were used only for historical trend context and never in direct comparisons with 2026

This step was essential to maintaining analytical accuracy.

## Analysis Structure

The analysis was built across five layers.

### 1. 2026 Snapshot (Year-to-Date)
A current-state summary of COVID activity across the two available months:
- Total cases, total deaths
- Cases per 100,000 population
- Deaths per 100,000 population
- Case fatality rate

### 2. Monthly Breakdown (2026)
Cases and deaths split by month (January vs February) to identify early-year patterns.

### 3. Country-Level Analysis
Ranking countries by:
- Total cases
- Cases per 100,000 population
- Total deaths
- Case fatality rate

### 4. Historical Trend Analysis
Year-by-year case and death counts, adjusted for population, to show how the virus has evolved from peak pandemic years through 2026.

### 5. Comparative Analysis
- **2026 vs 2025 (Jan–Feb):** Change in cases and deaths over one year
- **2026 vs Peak Year (Jan–Feb):** Relative scale against peak pandemic activity
- **Year-over-year trends:** Growth and decline patterns across the full timeline

## Key Findings

### COVID-19 is still present in 2026:

**86,319 cases and 3,174 deaths** have been recorded globally in just the first two months of 2026.

**Cases and Deaths 2026**

<img width="750" height="454" alt="image" src="https://github.com/user-attachments/assets/8beac8f5-2a29-4858-b849-92b01998bfcb" />

While these numbers are low relative to peak years, they confirm that the virus has not been completely eliminated and active transmission continues across multiple countries.

### Infection rates have dropped to near-invisible levels:

At **1.04 cases per 100,000 people**, the 2026 infection rate represents a dramatic decline from peak pandemic levels.

**Cases and Deaths Per 100k People**

<img width="749" height="453" alt="image" src="https://github.com/user-attachments/assets/3d6eaadd-99dd-4b06-8f4a-75fb3450860b" />

The virus has transitioned from widespread transmission to minimal background activity, but it has not reached total zero.

### Deaths remain measurable but minimal at population scale:

The global death rate stands at **0.04 deaths per 100,000 population** in 2026.

**Deaths Per 100k Pepople**

<img width="748" height="453" alt="image" src="https://github.com/user-attachments/assets/0d99c2e8-7df0-4007-a1ff-1cccedf32709" />

This represents a significant improvement in outcomes compared to earlier pandemic years, likely reflecting residual immunity and reduced case volume. However, a **case fatality rate of 3.68%** still exists, meaning roughly 1 in 27 confirmed cases results in death, suggests the virus still carries real risk for those who contract it.

**Case Fatality Rate**

<img width="749" height="453" alt="image" src="https://github.com/user-attachments/assets/90714a2f-78ed-4c96-b005-9088fd1fa459" />

### Peak COVID activity occurred in earlier years:

Historical trend analysis confirms that global cases peaked in earlier pandemic years, followed by a sharp and sustained decline.

**Covid Cases Per Year**

<img width="750" height="455" alt="image" src="https://github.com/user-attachments/assets/cb2e1194-de2d-494d-82af-342475929365" />

2026 represents the lowest level of recorded activity in the dataset, but the decline curve has flattened since 2024, suggesting COVID has stabilized rather than disappeared.

### Activity is geographically concentrated:

Despite the global decline, COVID activity in 2026 is not evenly distributed, a small number of countries account for a disproportionate share of reported cases

**2026 Covid Cases by Country**

<img width="1606" height="868" alt="image" src="https://github.com/user-attachments/assets/6f92180a-31ed-4e8f-87a6-734ccda50838" />

This uneven distribution indicates that COVID has not disappeared uniformly, it persists more actively in specific regions.

**All-time Covid Cases by Country**

<img width="1200" height="750" alt="image" src="https://github.com/user-attachments/assets/011b0861-ffe1-4013-97c3-fee6c13e160f" />

## Recommendations

**1. Avoid declaring COVID over based on case volume alone:**

A 3.68% case fatality rate is not negligible. Low case counts combined with a meaningful fatality rate means the virus still needs monitoring, particularly for vulnerable populations.

**2. Investigate the countries still reporting elevated activity:**

Country-level analysis reveals that COVID has not declined equally across all regions. Understanding which countries continue to report cases, and why, could inform targeted public health responses.

**3. Expand the dataset as 2026 progresses:**

This analysis covers only January and February. Updating the dataset to include the full year will allow stronger year-over-year comparisons and reveal whether the current trend continues, accelerates, or reverses.

**4. Pair case data with vaccination and variant tracking:**

Case and death counts alone do not explain why some countries still see activity. Linking this data to vaccination rates or variant surveillance would provide a more complete picture.

## Limitations

- **2026 data covers January and February only.** All conclusions about 2026 are based on a two-month window.
- **Some territories and special regions were excluded** due to missing or unreliable population data.
- **Population source discrepancies** exist between the COVID reporting dataset and the population dataset. Minor mismatches were handled during preparation but may affect precision at the country level.

These limitations do not invalidate the analysis, but they affect how results should be interpreted — particularly for year-over-year comparisons.

## Tools Used

| Tool | Purpose |
|------|---------|
| PostgreSQL | Data staging, cleaning, transformation, and analysis |
| SQL | Aggregation, joins, CTEs, window functions |
### Temidayo Olubayo | Data Analytics

**Temidayo Olubayo**  
Data Analytics | SQL | PostgreSQL | Power BI
