-- SMART COLLEGE MANAGEMENT SYSTEM (SCMS)

DROP DATABASE IF EXISTS SCMS;
CREATE DATABASE SCMS;
USE SCMS;

-- 1. COURSES TABLE
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY AUTO_INCREMENT,
    CourseName VARCHAR(100) NOT NULL,
    Duration INT NOT NULL, -- in months
    Fees DECIMAL(10,2) NOT NULL
);

-- 2. STUDENTS TABLE
CREATE TABLE Students (
    StudentID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    DOB DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Address TEXT,
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15),
    CourseID INT,
    DateOfAdmission DATE,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 3. FACULTY TABLE
CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Department VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    Phone VARCHAR(15)
);

-- 4. SUBJECTS TABLE
CREATE TABLE Subjects (
    SubjectID INT PRIMARY KEY AUTO_INCREMENT,
    SubjectName VARCHAR(100),
    CourseID INT,
    FacultyID INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    FOREIGN KEY (FacultyID) REFERENCES Faculty(FacultyID)
);

-- 5. ATTENDANCE TABLE
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    SubjectID INT,
    Date DATE,
    Status ENUM('Present', 'Absent'),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

-- 6. EXAMS TABLE
CREATE TABLE Exams (
    ExamID INT PRIMARY KEY AUTO_INCREMENT,
    ExamName VARCHAR(100),
    ExamDate DATE,
    CourseID INT,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID)
);

-- 7. RESULTS TABLE
CREATE TABLE Results (
    ResultID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    SubjectID INT,
    MarksObtained DECIMAL(5,2),
    MaxMarks DECIMAL(5,2),
    Grade VARCHAR(2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID),
    FOREIGN KEY (SubjectID) REFERENCES Subjects(SubjectID)
);

-- 8. FEES TABLE
CREATE TABLE Fees (
    FeeID INT PRIMARY KEY AUTO_INCREMENT,
    StudentID INT,
    AmountPaid DECIMAL(10,2),
    PaymentDate DATE,
    Mode ENUM('Cash', 'Online'),
    DueAmount DECIMAL(10,2),
    FOREIGN KEY (StudentID) REFERENCES Students(StudentID)
);

-- VIEW: STUDENT PERFORMANCE
CREATE VIEW StudentPerformanceView AS
SELECT 
    s.Name AS StudentName,
    sub.SubjectName,
    r.MarksObtained,
    r.MaxMarks,
    r.Grade
FROM Results r
JOIN Students s ON r.StudentID = s.StudentID
JOIN Subjects sub ON r.SubjectID = sub.SubjectID;

-- VIEW: ATTENDANCE SUMMARY
CREATE VIEW AttendanceSummaryView AS
SELECT 
    s.StudentID,
    s.Name,
    sub.SubjectName,
    COUNT(*) AS TotalLectures,
    SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) AS Presents,
    ROUND(SUM(CASE WHEN a.Status = 'Present' THEN 1 ELSE 0 END) / COUNT(*) * 100, 2) AS AttendancePercentage
FROM Attendance a
JOIN Students s ON a.StudentID = s.StudentID
JOIN Subjects sub ON a.SubjectID = sub.SubjectID
GROUP BY s.StudentID, sub.SubjectID;

-- TRIGGER: UPDATE DUE AMOUNT AUTOMATICALLY (demo logic)
DELIMITER //
CREATE TRIGGER update_due_amount AFTER INSERT ON Fees
FOR EACH ROW
BEGIN
    UPDATE Fees
    SET DueAmount = (SELECT c.Fees FROM Courses c
                     JOIN Students s ON s.CourseID = c.CourseID
                     WHERE s.StudentID = NEW.StudentID) - 
                    (SELECT SUM(AmountPaid) FROM Fees WHERE StudentID = NEW.StudentID)
    WHERE FeeID = NEW.FeeID;
END;
//
DELIMITER ;

-- PROCEDURE: CALCULATE CGPA
DELIMITER //
CREATE PROCEDURE CalculateCGPA(IN StudID INT)
BEGIN
    SELECT 
        StudentID,
        ROUND(AVG((MarksObtained / MaxMarks) * 10), 2) AS CGPA
    FROM Results
    WHERE StudentID = StudID
    GROUP BY StudentID;
END;
//
DELIMITER ;
