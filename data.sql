INSERT INTO Courses (CourseName, Duration, Fees) VALUES
('BCA', 36, 150000),
('BBA', 36, 140000);

INSERT INTO Students (Name, DOB, Gender, Address, Email, Phone, CourseID, DateOfAdmission) VALUES
('Ravi Kumar', '2003-07-12', 'Male', 'Delhi', 'ravi@gmail.com', '9876543210', 1, '2022-08-01'),
('Priya Singh', '2004-05-10', 'Female', 'Noida', 'priya@gmail.com', '9876501234', 2, '2023-07-15');

INSERT INTO Faculty (Name, Department, Email, Phone) VALUES
('Dr. Sharma', 'Computer Science', 'sharma@college.com', '9123456789'),
('Ms. Verma', 'Management', 'verma@college.com', '9123498765');

INSERT INTO Subjects (SubjectName, CourseID, FacultyID) VALUES
('DBMS', 1, 1),
('Operating Systems', 1, 1),
('Marketing', 2, 2);

INSERT INTO Attendance (StudentID, SubjectID, Date, Status) VALUES
(1, 1, '2024-05-01', 'Present'),
(1, 2, '2024-05-02', 'Absent'),
(2, 3, '2024-05-01', 'Present');

INSERT INTO Results (StudentID, SubjectID, MarksObtained, MaxMarks, Grade) VALUES
(1, 1, 85, 100, 'A'),
(1, 2, 90, 100, 'A+'),
(2, 3, 75, 100, 'B+');

INSERT INTO Fees (StudentID, AmountPaid, PaymentDate, Mode, DueAmount) VALUES
(1, 50000, '2024-05-05', 'Online', 100000),
(2, 140000, '2024-05-06', 'Cash', 0);
SELECT * FROM StudentPerformanceView;
SELECT * FROM AttendanceSummaryView;

CALL CalculateCGPA(1);
CALL CalculateCGPA(2);
