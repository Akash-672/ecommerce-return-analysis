# E-Commerce Return Analysis | SQL & Power BI

## 1. Project Overview

This project analyzes e-commerce product returns to understand **why customers return products, which areas have higher return rates, and how returns affect the business financially**.

The project follows an end-to-end data analytics workflow:

**Data Cleaning → SQL Analysis → Power BI Dashboard → Key Findings → Business Recommendations**

---

## 2. Business Problem

Product returns can negatively affect revenue, profitability, and customer experience.

The main business question addressed in this project is:

> **Why are customers returning products, which factors are associated with higher return rates, and what is the financial impact of these returns?**

---

## 3. Business Objectives

* Identify the most common reasons for product returns.
* Compare return rates across product categories.
* Analyze regional differences in return rates.
* Examine return rates by payment method.
* Analyze return patterns across discount bands.
* Measure the financial impact of returned orders.
* Identify areas where the business should prioritize corrective action.

---

## 4. Dataset

The dataset was obtained from **Kaggle** and contains e-commerce order-level information.

### Dataset Coverage

**12 September 2023 – 11 September 2025**

### Key Fields Used

* Order Date
* Gender
* Region
* Product Category
* Payment Method
* Discount
* Return Status
* Return Reason
* Revenue
* Profit-related financial metrics

The dataset was inspected and validated before being used for SQL analysis and Power BI reporting.

---

## 5. Data Cleaning

The dataset was cleaned and prepared before analysis.

The main data-cleaning and validation activities included:

* Checking for missing values.
* Checking for duplicate records.
* Validating data types.
* Standardizing categorical values.
* Validating date fields and date ranges.
* Checking numerical ranges and potential anomalies.
* Creating and validating analytical fields required for the analysis.

The cleaned data was then used for SQL analysis and Power BI dashboard development.

---

## 6. SQL Analysis

MySQL was used to analyze the dataset and answer the project's core business questions.

The analysis covered:

* Overall return rate.
* Return rate by product category.
* Return rate by region.
* Return rate by payment method.
* Return rate by discount band.
* Most common return reasons.
* Financial impact of returns.
* Category-level revenue loss.

The complete SQL queries and business analysis are available in the repository.

---

## 7. Power BI Dashboard

An interactive Power BI dashboard was developed to provide a clear view of e-commerce return performance.

### Key KPIs

| KPI             |          Result |
| --------------- | --------------: |
| Total Orders    |      **34,500** |
| Returned Orders |       **1,903** |
| Return Rate     |       **5.52%** |
| Revenue Lost    | **₹388,755.97** |
| Profit Affected |  **₹61,805.46** |

### Dashboard Visuals

The dashboard includes:

1. **Top Return Reasons**
2. **Return Rate by Category**
3. **Return Rate by Region**
4. **Return Rate by Payment Method**
5. **Return Rate by Discount Band**
6. **Financial Impact by Category**

### Interactive Filters

The dashboard allows users to filter the analysis by:

* Order Date
* Gender
* Region
* Product Category
* Payment Method

### Dashboard Preview

<img width="1169" height="656" alt="screenshot" src="https://github.com/user-attachments/assets/b68e51eb-54e6-4ac2-a1a1-11c12b678a47" />


---

## 8. Key Findings

- The overall return rate was 5.52% exceeding the <5% target.

- The most common return reason was ‘Not as described’ at 25.75%.

- Fashion had the highest return rate at 8.28% followed by Electronics at 7.30%.

- East had the highest regional return rate at 5.91%.

- Returns resulted in ₹388,755.97 in revenue loss and ₹61,805.46 in affected profit.

- Electronics had the highest category-level revenue loss.

---

## 9. Business Recommendations

1. Enhance product descriptions specifications and images.

2. Investigate SKU-level return drivers in Fashion and Electronics.

3. Prioritise Electronics for financial loss reduction.

4. Investigate the causes of higher returns in the East region.

5. Implement targeted discount strategies rather than assuming higher discounts cause returns.

---

## 10. Tools Used

* **Excel** — Data inspection
* **MySQL** — SQL for cleaning, analysis and business questions
* **Power BI** — Interactive dashboard and data visualization

---

## 11. Conclusion

This project analyzes e-commerce returns from data preparation through business recommendations.

The analysis shows that returns are concentrated around certain **return reasons and product categories** and create a measurable financial impact on the business.

The findings provide a starting point for reducing returns by improving product information, investigating high-return categories, addressing regional differences, and prioritizing areas with greater financial impact.
