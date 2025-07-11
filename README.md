# Smart College Management System (SCMS)

## Project Overview

This project provides a comprehensive database schema for a Smart College Management System (SCMS). It is designed to efficiently manage data related to students, courses, faculty, attendance, exams, results, and fees. The schema is built using SQL and includes tables, views, triggers, and stored procedures to ensure data integrity and automate common tasks.

## Features

* **Modular Schema:** Well-defined tables for core college entities like `Students`, `Courses`, `Faculty`, `Subjects`, `Attendance`, `Exams`, `Results`, and `Fees`.
* **Data Integrity:** Uses primary keys, foreign keys, and constraints to maintain data accuracy and consistency.
* **Automated Tasks:** Includes a trigger to automatically update the due fee amount after a new payment is recorded.
* **Complex Calculations:** A stored procedure is available to calculate the CGPA for a specific student.
* **Data Analysis Views:**
    * `StudentPerformanceView`: Provides a quick look at student marks and grades in different subjects.
    * `AttendanceSummaryView`: Summarizes the attendance percentage for each student in each subject.

## Database Schema

The database consists of the following tables:
1.  `Courses`: Stores details about the courses offered.
2.  `Students`: Manages student information and their enrollment.
3.  `Faculty`: Contains information about the faculty members.
4.  `Subjects`: Links subjects to courses and faculty.
5.  `Attendance`: Tracks student attendance for each subject.
6.  `Exams`: Stores information about examinations.
7.  `Results`: Manages student marks and grades.
8.  `Fees`: Tracks fee payments and dues for each student.

## Setup Instructions

1.  **Database Setup:** Make sure you have a MySQL or a compatible SQL server installed.
2.  **Run Schema Script:** Execute the `schema.sql` file to create the database, tables, views, trigger, and procedure.
    ```bash
    mysql -u your_username -p < schema.sql
    ```
3.  **Insert Sample Data:** Execute the `data.sql` file to populate the tables with sample data.
    ```bash
    mysql -u your_username -p SCMS < data.sql
    ```

## Usage Examples

Once the database is set up and populated, you can use the following commands to test its functionality:

* **View Student Performance:**
    ```sql
    SELECT * FROM StudentPerformanceView;
    ```
* **View Attendance Summary:**
    ```sql
    SELECT * FROM AttendanceSummaryView;
    ```
* **Calculate CGPA for a Student:**
    ```sql
    CALL CalculateCGPA(1); -- Replace 1 with the desired StudentID
    ```

---
