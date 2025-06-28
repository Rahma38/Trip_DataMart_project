# 🚌 Trip Data Mart - Bus Trips Analytical Solution

## 📦 Project Overview
This project presents a fully designed and implemented Data Mart for analyzing bus trip data using PostgreSQL.

The solution follows a Star Schema model and incorporates Slowly Changing Dimension (SCD) Type 2 to ensure accurate historical tracking of specific dimensions.

---

## 🎯 Objectives
- Build a structured data model for efficient analysis of bus trips.
- Track historical changes in critical dimensions such as drivers and buses.
- Provide a solid foundation for analytical queries and decision support.

---

## 🛠️ Technologies & Tools
- PostgreSQL (Database Management System)
- Star Schema Design
- SCD Type 2 Implementation
- pgAdmin 

---

## 🗂️ Data Mart Structure

The Data Mart is structured using the Star Schema approach:

- Dimensions  
  Includes descriptive tables such as drivers, buses, dates, and times.

- Fact Table  
  Stores measurable information related to bus trips, such as distance, duration, and completion status.

SCD Type 2 is applied to selected dimensions to ensure historical accuracy when attribute values change over time.

---

## 📊 Implementation Details

The project folder contains:

- A visual ERD diagram illustrating the overall Data Mart structure.
- Sample screenshots of tables populated with data after loading, demonstrating successful implementation.

---

## 💻 Project Files

- SQL_Scripts/  
  Contains SQL code for creating tables and sample analytical queries.

- Documentation/  
  Includes additional project descriptions or documents (if applicable).

- Images/  
  Contains ERD diagrams and screenshots of the Data Mart after data loading.

---

## ⚡ Additional Notes

- The project uses sample data for demonstration and learning purposes.
- The model can be extended or modified to fit real-world business scenarios.
- Best practices for Data Warehousing and dimensional modeling were followed throughout the implementation.

---

## ✅ Author
Rahma Abdelrazek
