### 🐔 Chicken Factory Database System (MySQL)

This project is a complete relational **database schema** for managing operations in a chicken production factory.  
It includes everything from employees, machines, fridges, vehicles, and internal logistics — built with **MySQL Workbench** and exported to SQL.

---

## 🧱 Database Overview

The schema models key aspects of a poultry production facility:

### 👷 Employees & Roles
- `Employee`: Basic employee info (SSN, name, salary, etc.)
- Specialized roles:
  - `Driver`
  - `Accountant`
  - `Emp_machine`, `Emp_cracking_machine`, `Emp_packing_machine`
  - `Emp_avg_fridge`
  - `Internal_transfer` (`Intrnal_trans`)

### 🏭 Machines
- `Machine`: Base table for machines
- `Cracking_machine` / `Packing_machine`: Specialized types
- Relations to employees who operate each

### ❄️ Fridges
- `Fridge`: General table
- `Short_fridge`, `Avg_fridge`, `Long_fridge`: Types for different storage stages

### 🚚 Logistics & Movement
- Movement tables for product tracking between stations:
  - `car_to_avg`
  - `avg_to_cracking`
  - `packing_to_short`
  - `short_to_long`
  - `long_to_car`

### 💵 Financials
- `pay`: Tracks payments between accountants and drivers

---

## 📂 File Structure

- `chicken_factory.sql`  
  Full SQL schema containing only `CREATE DATABASE`, `CREATE TABLE`, and `FOREIGN KEY` constraints (no inserted data).  
  → Suitable for initializing a clean database structure.

- `chicken factory inserted.sql`  
  Full SQL script including:
  - Schema creation
  - Table definitions
  - Foreign key constraints
  - **Pre-inserted sample data** (via `INSERT INTO` statements)

- `chickens_factory.mwb`  
  (Optional) MySQL Workbench model used to design the database schema (ERD format).

---

## 🚀 How to Use

1. Open your **MySQL Server** or use **phpMyAdmin**.
2. Execute the script:
   ```sql
   SOURCE path/to/chicken factory inserted.sql;
The schema chickens_factory will be created with all tables and data.

## 📈 Sample Use Cases
Track product movement across stages (from avg fridge to packing to long fridge)

Assign machines to specific employees

Link drivers to car deliveries

Trace salaries, supervision, and internal logistics

## 🛠️ Future Enhancements
Add stored procedures for automating daily processes

Build a web dashboard with PHP/Python for CRUD and reporting

Track production KPIs (efficiency, losses, delays)

Add user authentication layer for data integrity

## 👨‍💻 Author
Designed and developed by Nour Mohamed
Faculty of Science – Statistics & Computer Science Department – Ain Shams University

## 🪪 License
Open for academic use and educational development. Attribution appreciated.
