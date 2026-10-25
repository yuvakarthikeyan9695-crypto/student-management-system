-- ==========================================================
-- Student Management System Database Script (MySQL)
-- Three-Tier Architecture Database Server Configuration
-- ==========================================================

CREATE DATABASE IF NOT EXISTS student_db;
USE student_db;

-- 1. Students Table
DROP TABLE IF EXISTS students;
CREATE TABLE students (
    roll_no VARCHAR(20) PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    department VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    mobile VARCHAR(15) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Marks Table (For Student Mark List)
DROP TABLE IF EXISTS marks;
CREATE TABLE marks (
    mark_id INT AUTO_INCREMENT PRIMARY KEY,
    roll_no VARCHAR(20),
    subject_1 INT DEFAULT 0,
    subject_2 INT DEFAULT 0,
    subject_3 INT DEFAULT 0,
    subject_4 INT DEFAULT 0,
    subject_5 INT DEFAULT 0,
    FOREIGN KEY (roll_no) REFERENCES students(roll_no) ON DELETE CASCADE
);

-- 3. Online Exam Results Table
DROP TABLE IF EXISTS exam_results;
CREATE TABLE exam_results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    roll_no VARCHAR(20),
    subject_name VARCHAR(50),
    score INT,
    total_questions INT,
    percentage DECIMAL(5,2),
    exam_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (roll_no) REFERENCES students(roll_no) ON DELETE CASCADE
);

-- Insert Sample Students
INSERT INTO students (roll_no, student_name, department, email, mobile) VALUES
('CS101', 'Arun', 'CSE', 'arun@college.edu', '9876543210'),
('EC102', 'Priya', 'ECE', 'priya@college.edu', '9123456780'),
('IT103', 'Karthik', 'IT', 'karthik@college.edu', '9988776655'),
('ME104', 'Sneha', 'ME', 'sneha@college.edu', '9876501234'),
('CE105', 'Vivek', 'CE', 'vivek@college.edu', '9876598765');

-- Insert Sample Marks (out of 100 per subject)
INSERT INTO marks (roll_no, subject_1, subject_2, subject_3, subject_4, subject_5) VALUES
('CS101', 92, 88, 95, 90, 89),
('EC102', 85, 82, 89, 78, 86),
('IT103', 95, 96, 92, 94, 98),
('ME104', 78, 80, 82, 85, 75),
('CE105', 88, 91, 87, 90, 94);
