# E-Commerce Return Analysis | SQL & Power BI

## 1. Project Overview

This project analyzes e-commerce product returns to understand why customers return products, which areas have higher return rates, and how returns affect the business financially.

The project follows an end-to-end data analytics workflow:

**Data Cleaning → SQL Analysis → Power BI Dashboard → Key Findings → Business Recommendations**

---

## 2. Business Problem

Product returns can negatively affect revenue, profitability, and customer experience.

The main business question addressed in this project is:

> Why are customers returning products, which factors are associated with higher return rates, and what is the financial impact of these returns?

---

## 3. Business Objectives

- Identify the most common reasons for product returns.
- Compare return rates across product categories.
- Analyze regional differences in return rates.
- Examine return rates by payment method.
- Analyze return patterns across discount bands.
- Measure the financial impact of returned orders.
- Identify areas where the business should prioritize corrective action.

---

## 4. Dataset

The dataset was obtained from **Kaggle** and contains e-commerce order-level information.

**Dataset Coverage:** 12 September 2023 – 11 September 2025

**Key Fields Used:**
- Order Date
- Gender
- Region
- Product Category
- Payment Method
- Discount
- Return Status
- Return Reason
- Revenue
- Profit-related financial metrics

The dataset was inspected and validated before being used for SQL analysis and Power BI reporting.

---

## 5. Data Cleaning

The dataset was cleaned and prepared before analysis in MySQL.

The main data-cleaning and validation activities included:

- Checking for missing values.
- Checking for duplicate records.
- Validating data types.
- Standardizing categorical values.
- Validating date fields and date ranges.
- Checking numerical ranges and potential anomalies.
- Creating and validating analytical fields required for the analysis.

The cleaned data was then used for SQL analysis and Power BI dashboard development.

---

## 6. SQL Analysis

MySQL was used to analyze the dataset and answer the project's core business questions.

The analysis covered:

- Overall return rate.
- Return rate by product category.
- Return rate by region.
- Return rate by payment method.
- Return rate by discount band.
- Most common return reasons.
- Financial impact of returns.
- Category-level revenue loss.
- Cross-dimensional analysis: return reason by category, and return rate by category within each region.

The complete SQL queries and business analysis are available in analysis.sql

---

## 7. Power BI Dashboard

An interactive Power BI dashboard was developed to provide a clear view of e-commerce return performance.

**Key KPIs**

| KPI | Result |
|---|---|
| Total Orders | 34,500 |
| Returned Orders | 1,903 |
| Return Rate | 5.52% |
| Revenue Lost | ₹388,755.97 |
| Profit Affected | ₹61,805.46 |

**Dashboard Visuals**

1. Revenue Lost & Return Rate by Category (combo chart)
2. Return Rate Trend (quarterly)
3. Top Return Reasons
4. Return Rate by Region
5. Return Rate by Payment Method

**Interactive Filters**

The dashboard allows users to filter the analysis by:

- Order Date
- Gender
- Region
- Product Category
- Payment Method

**Dashboard Preview**

<img width="1173" height="653" alt="screenshot 2" src="https://github.com/user-attachments/assets/f4228d24-e4c2-46f9-b880-aadcb82195ef" />


<img width="1169" height="656" alt="screenshot" src="https://github.com/user-attachments/assets/47b7fae0-7a3c-4880-91bb-87e6a01f8fa8" />


---

## 8. Key Findings

- The overall return rate was 5.52% (1,903 of 34,500 orders).
- The most common return reason was "Not as described" at 25.75%, followed closely by "No longer needed" (25.28%) and "Defective" (24.44%).
- Fashion had the highest return rate at 8.28%, followed by Electronics at 7.30% — but Electronics caused the highest revenue loss (₹245K), making these two distinct problems requiring different fixes.
- East had the highest regional return rate at 5.91%; Central had the lowest at 5.10%.
- Returns resulted in ₹388,755.97 in revenue loss and ₹61,805.46 in affected profit.
- Delivery time showed a mild positive relationship with returns (8+ day deliveries: 6.06% vs. 3–5 day deliveries: 5.47%).
- Discount level showed no meaningful correlation with return rate (range: 4.26%–5.80% across all bands).
- Return rate remained range-bound (4.3%–6.0%) across the two-year analysis window, with no sustained upward or downward trend.

---

## 9. Assumptions & Limitations

- The dataset was obtained from Kaggle and is not live business data. Patterns observed (return reasons, regional splits, category rates) reflect this dataset's structure and should not be treated as industry benchmarks.
- Null values in `return_reason` and `request_date` are structural, not missing data — they occur only for orders where `returned = "No"`, since a non-returned order has nothing to log.
- `profit_margin` is an absolute currency value, not a percentage, despite the field name. Negative values represent genuine loss-making orders and are not data errors.
- `shipping_cost` reflects the original delivery cost only. The dataset does not capture reverse-logistics cost (return shipping, restocking, inspection), so the "Profit Affected" figure likely understates the true financial cost of returns.
- The relationships observed between delivery time, discount level, and return rate are correlational, not causal. Category and region are likely confounding variables, and no controlled comparison was run to isolate either factor independently.
- Customer age and gender exist as dashboard filters but were not analyzed as standalone dimensions in this iteration — scoped out to keep the analysis focused on category, region, reason, and financial impact.
- Analysis covers a single ~2-year window (September 2023 – September 2025) with no prior-period baseline, so trend observations are limited to what is visible within this window.

---

## 10. Business Recommendations

1. Enhance product descriptions, specifications, and images — "Not as described" and "No longer needed" together account for over half of all returns, and both point to expectation-setting at the point of purchase.
2. Investigate SKU-level return drivers in Fashion (highest rate) and Electronics (highest dollar loss) specifically, since they require different interventions.
3. Prioritize Electronics for financial loss reduction, given its outsized revenue impact relative to other categories.
4. Investigate the causes of higher returns in the East region.
5. Implement targeted discount strategies rather than assuming higher discounts cause returns — the data does not support that assumption.
6. Deprioritize delivery-speed initiatives as a return-reduction lever; the effect size is real but small relative to reason-driven returns.

---

## 11. Tools Used

- **MySQL** — Data cleaning, validation, and all business-question analysis
- **Power BI** — Interactive dashboard and data visualization

---

## 12. Conclusion

This project analyzes e-commerce returns from data preparation through business recommendations.

The analysis shows that returns are concentrated around a small set of return reasons and product categories, and create a measurable financial impact on the business. Return rate has remained stable over the two-year window rather than worsening, indicating this is a structural cost to address at the root cause rather than a recent operational failure.

The findings provide a starting point for reducing returns by improving product information, investigating high-return categories, addressing regional differences, and prioritizing areas with the greatest financial impact.
