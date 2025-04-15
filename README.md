# Library Management System

## Project Description
A complete library management solution featuring:
- SQL Server database backend with stored procedures
- Python Tkinter GUI interface
- Book borrowing/returning system with automatic fine calculation
- Member and inventory management

## Technical Stack
- Backend: Microsoft SQL Server
- Frontend: Python Tkinter
- Database Driver: pyodbc

## Installation Guide

### Prerequisites
- SQL Server (2012 or later)
- Python 3.6+
- ODBC Driver 17 for SQL Server

### Setup
1. Database Setup:
   Execute DDL_Code.sql in your SQL Server environment

2. Application Setup:
   pip install pyodbc
   python Tkinter_Gui.py

3. Configuration:
   Modify the connection string in Tkinter_Gui.py:
   conn = pyodbc.connect(
       'DRIVER=ODBC Driver 17 for SQL Server;'
       'SERVER=YOUR_SERVER_NAME;'
       'DATABASE=Library_Management_System;'
       'Trusted_Connection=yes;'
   )

## Features
- Member Management:
  - Add/view members
  - Update information

- Book Management:
  - Add/view books
  - Check availability

- Borrowing System:
  - Track borrowed books
  - Automatic fines (2/day after 14 days)

## Database Schema
### Tables
- Members: Member_ID (PK), Name, Email, Phone
- Books: Book_ID (PK), Title, Author, ISBN, Status
- Borrow_Records: Borrow_Num (PK), Member_ID (FK), Book_ID (FK), Dates, Fine

### Stored Procedures
1. Borrow_Book:
   - Checks availability
   - Updates status
   - Creates record

2. Return_Book:
   - Calculates fines
   - Updates return date
   - Sets status to available

## Future Enhancements
- Add book search functionality
- Implement user authentication
- Generate reports
- Add reservation system
