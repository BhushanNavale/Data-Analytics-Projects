# Data Cleaning

## General Cleaning

* Removed leading and trailing whitespace
* Converted missing values to null where appropriate
* Corrected inappropriate data types

---

## Table: customers

**Rows before cleaning:** 5025

**Rows after cleaning:** 5000

### Issues identified:

* 25 duplicate records
* 90 missing emails
* Inconsistent gender values
* Inconsistent city capitalization

### Cleaning Performed:

* Removed 25 duplicate records
* Converted missing emails to null
* Standardized gender values (M, F, Male, Female) to Male and Female
* Standardized city names for consistent capitalization

---

## Table: categories

### Issues identified:

* Column headers were missing
* Inconsistent category_name capitalization

### Cleaning Performed:

* Promoted the first row to column headers
* Standardized category_name for consistent capitalization

---

## Table: order_items

### Issues Identified:

* quantity had an incorrect Text data type
* unit_price had an incorrect Text data type
* discount had an incorrect Text data type
* 20 order items had a quantity of 0
* Negative discount values were present

### Cleaning Performed:

* Converted quantity from Text to Whole Number
* Converted unit_price from Text to Decimal Number
* Converted discount from Text to Decimal Number
* Removed order items with invalid quantity values of 0
* Removed order items with negative discount values

---

## Table: orders

### Issues identified:

* order_date had an incorrect Text data type
* 30 missing order_status
* Inconsistent order_status capitalization

### Cleaning Performed:

* Converted order_date from Text to Date
* Converted missing order_status to null
* Standardized order_status for consistent capitalization

---

## Table: payments

### Issues identified:

* 60 missing payment_method
* Inconsistent payment_method capitalization
* Inconsistent payment_status capitalization

### Cleaning Performed:

* Converted missing payment_method to null
* Standardized payment_method values, including Upi to UPI
* Standardized payment_status for consistent capitalization

---

## Table: products

### Issues identified:

* Inconsistent product_name capitalization
* Inconsistent brand capitalization
* 35 missing cost values

### Cleaning Performed:

* Standardized product_name for consistent capitalization
* Standardized brand for consistent capitalization
* Retained 35 missing cost values as null

---

## Table: reviews

### Issues identified:

* rating contained 0 & -1 values outside the valid 1–5 rating scale
* 100 missing review_text

### Cleaning Performed:

* Converted 0 & -1 ratings to null because they do not represent a valid 1–5 rating
* Retained the associated review text and review records
* Converted missing review_text to null

---

## During Importing Data

> "Some missing values were represented as empty strings during the CSV-to-MySQL import, so I standardized those empty strings to NULL before changing the column datatype."
