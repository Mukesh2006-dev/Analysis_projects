# E-commerce Funnel Analysis (SQL + Power BI)

## Project Overview

This project analyzes the **user journey in an e-commerce platform** to understand how users move through the purchase funnel and where they drop off before completing a purchase.

The analysis focuses on identifying **conversion rates, funnel drop-offs, user behavior across devices, marketing source performance, and repeat purchase behavior**.

The goal is to help businesses **optimize the customer journey and increase conversions.**

---

# Business Problem

Many e-commerce platforms struggle with understanding:

* Where users drop off during the purchase journey
* Which marketing channels bring high-converting users
* Which devices perform better
* How many users become repeat buyers

Without this understanding, companies lose **potential revenue due to friction in the funnel**.

This project aims to **identify bottlenecks in the user funnel and provide insights for improving conversion rates.**

---

# Funnel Stages Analyzed

The funnel analyzed in this project consists of five key stages:

1. Homepage Visit
2. Product View
3. Add to Cart
4. Checkout
5. Purchase

Users are tracked through event-level data to determine how many progress through each stage.

---

# Dataset

Two tables are used in the analysis.

### Users Table

Contains information about registered users.

Columns:

* `userid` – Unique user identifier
* `signuptimestamp` – Time when the user signed up
* `source` – Marketing acquisition channel (Ads, Email, Social, etc.)
* `devicetype` – Device used by the user (Mobile, Desktop, Tablet)
* `country` – User location

### Events Table

Tracks all user actions on the platform.

Columns:

* `eventid` – Unique event identifier
* `userid` – User performing the event
* `sessionid` – Session identifier
* `eventname` – Type of action performed
* `eventtimestamp` – Time of the event
* `productid` – Product interacted with
* `revenue` – Revenue generated
* `quantity` – Quantity purchased

---

# Tools Used

* **PostgreSQL** – Data cleaning and analysis using SQL
* **Power BI** – Data visualization and dashboard creation
* **GitHub** – Project documentation and version control

---

# Key Analysis Performed

## 1. Funnel Drop-off Analysis

Calculated the number of users progressing through each stage of the funnel to identify where the largest drop-offs occur.

Stages analyzed:

* Homepage → Product View
* Product View → Add to Cart
* Add to Cart → Checkout
* Checkout → Purchase

---

## 2. Overall Conversion Rate

Measured the percentage of users who completed a purchase.

Conversion Rate Formula:

Purchasers / Total Users

---

## 3. Conversion Rate by Marketing Source

Analyzed which acquisition channels bring users who are most likely to convert.

Sources analyzed:

* Ads
* Email
* Referral
* Organic
* Social

---

## 4. Device Performance Analysis

Examined how users behave across different devices.

Devices analyzed:

* Mobile
* Desktop
* Tablet

Metrics evaluated:

* Number of users
* Purchases
* Conversion rate

---

## 5. Repeat Purchase Analysis

Identified how many customers make repeat purchases after their first transaction.

Metrics calculated:

* First-time buyers
* Repeat buyers
* Repeat purchase rate

---

## 6. Monthly Conversion Trends

Analyzed how conversion rates change over time to identify seasonal trends or performance shifts.

---

## 7. Purchase Timing Analysis

Studied how long it takes users to convert after their first interaction with the platform.

---

## Dashboard

The Power BI dashboard visualizes:

* Funnel progression
* Drop-off percentages
* Conversion rates by device
* Conversion rates by marketing source
* Monthly conversion trends
* Repeat purchase rate
* User distribution by device and country

---

# Key Insights

### 1. Checkout Has the Largest Drop-off

The biggest user drop occurs between **Add to Cart and Checkout**, indicating friction during the final purchase stage.

### 2. Mobile Generates Most Traffic

The majority of users access the platform through **mobile devices**, making mobile optimization critical.

### 3. Ads and Email Have the Best Conversion Rates

Users acquired through **paid ads and email marketing convert at higher rates** compared to social traffic.

### 4. Repeat Purchase Rate Is Low

Only a small percentage of users return for another purchase, suggesting opportunities for **customer retention strategies.**

---

# Business Recommendations

Based on the analysis:

1. Simplify the checkout process to reduce drop-offs.
2. Optimize the mobile user experience.
3. Invest more in high-performing marketing channels such as Ads and Email.
4. Introduce loyalty programs or personalized marketing to increase repeat purchases.

---

# Project Structure

```
ecommerce-funnel-analysis/
│
├── SQL
│   └── funnel_analysis_queries.sql
│
├── Dashboard
│   └── funnel_dashboard.pbix
│
├── Data
│   └── sample_dataset.csv
│
└── README.md
```

---

# Conclusion

This project demonstrates how **SQL and data visualization can be used to analyze user behavior and optimize conversion funnels in e-commerce platforms.**

By identifying **drop-off points and high-performing marketing channels**, businesses can make data-driven decisions to **increase revenue and improve the customer experience.**

## How to Run
1. Clone the repository:
   ```bash
   git clone <[https://github.com/Mukesh2006-dev/Analysis_projects/tree/main/Olist%20Analysis](https://github.com/Mukesh2006-dev/Analysis_projects/edit/main/Funnel%20analysis)>
