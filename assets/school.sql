USE project_db;
CREATE TABLE Students2 (
    Student_number INT PRIMARY KEY,
    Student_name VARCHAR(100),
    Date_of_Birth VARCHAR(100),
    Exam_Score VARCHAR(100),
    Support VARCHAR(100)
);
INSERT INTO Students2(Student_number, Student_name, Date_of_Birth, Exam_Score, Support) VALUES
(1001,'Bob Baker','25/08/01','78','no'),
(1002,'Sally Davies','02/10/99','55','yes' ),
(1003,'Mark Hanmill','05/06/95','90','no'),
(1004,'Anas Ali','03/08/80','70','no'),
(1005,'Cheuk Yin','01/05/02','45','yes');
CREATE TABLE Course (
Course_number INT PRIMARY KEY,
Course_name VARCHAR(100)
);
ALTER TABLE Course
 MODIFY Course_number VARCHAR(10);
 INSERT INTO Course ( Course_number, Course_Name) VALUES
('CS01','Computer Science'),
('M02','Maths'),
('P03','Physics'),
('MC04','Music'),
('B05','Biology');
CREATE TABLE ExamBoard (
Exam_Board_Number VARCHAR(10) NOT NULL,
Exam_Board_Name VARCHAR(100) NOT NULL,		
PRIMARY KEY (Exam_Board_Number)
);
INSERT INTO ExamBoard (Exam_Board_Number, Exam_Board_Name) VALUES
('ED01','EDExcel'),
('AQ02','AQA'),
('OC03','OCR'),
('WJ04','WJEC'),
('BC05','BSC');
CREATE TABLE CourseTeachers (
Course_teacher_number VARCHAR(10) NOT NULL,
Course_teacher_name VARCHAR(100) NOT NULL,
PRIMARY KEY (Course_teacher_number)
);
INSERT INTO CourseTeachers (Course_teacher_number, Course_teacher_name) VALUES
('JNS01','Mr. Jones'),
('PKR02','Mr. Parker'),
('PTR03','Mr. Peters'),
('DNL04','Ms. Daniels'),
('PTL05','Mr. Patel');
CREATE TABLE Student_Course (
Student_number INT,
Course_number VARCHAR(100),
PRIMARY KEY (Student_number, Course_number),
FOREIGN KEY (Student_number)
REFERENCES Students2(Student_number),
FOREIGN KEY (Course_number)
REFERENCES Course(Course_number)
);
INSERT INTO Student_Course (Student_number, Course_number) VALUES
('1001','CS01'),
('1001','M02'),
('1001','P03'),
('1002','M02'),
('1002','B05'),
('1002','MC04'),
('1003','CS01'),
('1003','M02'),
('1003','P03'),
('1004','M02'),
('1004','P03'),
('1004','B05'),
('1005','CS01'),
('1005','M02'),
('1005','MC04');
CREATE TABLE Course_Teacher(
Course_number VARCHAR(100),
Course_teacher_number VARCHAR(100),
PRIMARY KEY(Course_number,Course_teacher_number),
FOREIGN KEY(Course_number)
REFERENCES Course(Course_number),
FOREIGN KEY(Course_teacher_number)
REFERENCES CourseTeachers(Course_teacher_number)
);
INSERT INTO Course_Teacher(Course_number,Course_teacher_number) VALUES
('CS01','JNS01'),
('M02','PKR02'),
('P03','PTR03'),
('MC04','DNL04'),
('B05','PTL05');
CREATE TABLE Course_ExamBoard(
Course_number VARCHAR(100),
Exam_Board_Number VARCHAR(100),
PRIMARY KEY(Course_number,Exam_Board_Number),
FOREIGN KEY(Course_number)
REFERENCES Course(Course_number),
FOREIGN KEY(Exam_Board_Number)
REFERENCES ExamBoard(Exam_Board_Number)
);
INSERT INTO Course_ExamBoard (Course_number,Exam_Board_Number) VALUES
('CS01','Bc05'),
('M02','ED01'),
('M02','AQ02'),
('P03','OC03'),
('MC04','AQ02'),
('B05','WJ04');
SELECT Student_number, Course_number, COUNT(*)
FROM Student_Course
GROUP BY Student_number, Course_number
HAVING COUNT(*) > 1;
SELECT Course_number, Course_teacher_number, COUNT(*)
FROM Course_Teacher
GROUP BY Course_number, Course_teacher_number
HAVING COUNT(*) > 1;
SELECT Course_number, Exam_Board_Number, COUNT(*)
FROM Course_ExamBoard
GROUP BY Course_number, Exam_Board_Number
HAVING COUNT(*) > 1;
SELECT Student_number
FROM Student_Course
WHERE Student_number NOT IN (SELECT Student_number FROM Students2);
SELECT Course_number
FROM Student_Course
WHERE Course_number NOT IN (SELECT Course_number FROM Course);
SELECT Course_number
FROM Course_Teacher
WHERE Course_number NOT IN (SELECT Course_number FROM Course);
SELECT Course_number
FROM Course_ExamBoard
WHERE Course_number NOT IN (SELECT Course_number FROM Course);
UPDATE Course_ExamBoard
SET Exam_Board_Number = 'BC05'
WHERE Exam_Board_Number = 'BC05';
SELECT Exam_Board_Number
FROM Course_ExamBoard
WHERE Exam_Board_Number NOT IN (SELECT Exam_Board_Number FROM ExamBoard);
INSERT INTO Student_Course(Student_number, Course_number) VALUES (9999, 'CS01');
INSERT INTO Student_Course(Student_number, Course_number) VALUES (1001,'X99?');
DELETE FROM Students2 WHERE Student_number = 1001;
DELETE FROM Course WHERE Course_number = 'CS01';
SELECT s.Student_name, c.Course_name
FROM Student_Course sc
JOIN Students2 s ON sc.Student_number = s.Student_number
JOIN Course c ON sc.Course_number = c.Course_number;
SELECT c.Course_name, t.Course_teacher_name
FROM Course_Teacher ct
JOIN Course c ON ct.Course_number = c.Course_number
JOIN CourseTeachers t ON ct.Course_teacher_number = t.Course_teacher_number;
SELECT c.Course_name, e.Exam_Board_Name
FROM Course_ExamBoard ce
JOIN Course c ON ce.Course_number = c.Course_number
JOIN ExamBoard e ON ce.Exam_Board_Number = e.Exam_Board_Number;




















 