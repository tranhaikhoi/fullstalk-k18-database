CREATE TABLE students (
    student_id INT PRIMARY KEY,
    full_name  VARCHAR(100),
    class      VARCHAR(20),
    gender     CHAR(1)
);

CREATE TABLE subjects (
    subject_id   INT PRIMARY KEY,
    subject_name VARCHAR(100),
    credits      INT
);

CREATE TABLE scores (
    score_id   INT PRIMARY KEY,
    student_id INT,
    subject_id INT,
    score      DECIMAL(4,1),
    exam_date  DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

INSERT INTO students VALUES
(1,  'Nguyen Thi An',    'CNTT01', 'F'),
(2,  'Tran Van Binh',    'CNTT01', 'M'),
(3,  'Le Thi Cam',       'CNTT02', 'F'),
(4,  'Pham Van Duc',     'CNTT02', 'M'),
(5,  'Hoang Thi Em',     'CNTT01', 'F'),
(6,  'Vu Van Phong',     'CNTT03', 'M'),
(7,  'Dang Thi Giang',   'CNTT02', 'F'),
(8,  'Bui Van Hung',     'CNTT01', 'M'),
(9,  'Ngo Thi Lan',      'CNTT03', 'F'),
(10, 'Do Van Minh',      'CNTT02', 'M'),
(11, 'Trinh Thi Ngoc',   'CNTT01', 'F'),
(12, 'Ly Van Oanh',      'CNTT03', 'M');

INSERT INTO subjects VALUES
(1, 'Co so du lieu',        3),
(2, 'Lap trinh C',          3),
(3, 'Toan roi rac',         2),
(4, 'Mang may tinh',        3),
(5, 'Lap trinh Web',        2);

INSERT INTO scores VALUES
(1,  1,  1, 4.5,  '2024-06-10'),
(2,  1,  2, 8.0,  '2024-06-11'),
(3,  1,  3, 3.0,  '2024-06-12'),
(4,  2,  1, 7.5,  '2024-06-10'),
(5,  2,  2, 6.0,  '2024-06-11'),
(6,  3,  1, 4.0,  '2024-06-10'),
(7,  3,  2, 5.5,  '2024-06-11'),
(8,  3,  3, 8.5,  '2024-06-12'),
(9,  4,  1, 9.0,  '2024-06-10'),
(10, 4,  2, 8.5,  '2024-06-11'),
(11, 5,  1, 3.5,  '2024-06-10'),
(12, 5,  3, 6.5,  '2024-06-12'),
(13, 6,  1, 7.0,  '2024-06-10'),
(14, 6,  2, 9.0,  '2024-06-11'),
(15, 7,  1, 5.0,  '2024-06-10'),
(16, 7,  2, 8.0,  '2024-06-11'),
(17, 8,  1, 6.5,  '2024-06-10'),
(18, 8,  3, 5.0,  '2024-06-12'),
(19, 9,  2, 8.5,  '2024-06-11'),
(20, 9,  4, 9.0,  '2024-06-13'),
(21, 10, 1, 4.5,  '2024-06-10'),
(22, 10, 2, 7.0,  '2024-06-11'),
(23, 11, 1, 8.0,  '2024-06-10'),
(24, 11, 3, 9.5,  '2024-06-12'),
(25, 12, 2, 6.0,  '2024-06-11'),
(26, 12, 4, 7.5,  '2024-06-13'),
(27, 1,  4, 8.5,  '2024-06-13'),
(28, 2,  4, 9.0,  '2024-06-13'),
(29, 3,  5, 8.0,  '2024-06-14'),
(30, 4,  5, 9.5,  '2024-06-14');

--Câu 2.1: Tìm sinh viên nữ lớp 'CNTT01' hoặc 'CNTT02' có ít nhất 1 môn dưới 5 điểm.
select students.student_id, students.full_name, students.class, scores.score
        from students
        join scores on scores.student_id = students.student_id
        where students.gender = 'F' and students.class in ('CNTT01','CNTT02') and scores.score <5

--Câu 2.2: Tính điểm trung bình từng môn — chỉ hiển thị môn có TB < 6.5 và có từ 10 sinh viên thi trở lên.
select subjects.subject_name, avg(scores.score), count(scores.student_id)
    from subjects
    join scores on subjects.subject_id = scores.subject_id
    group by subjects.subject_id, subjects.subject_name
    having avg(scores.score) < 6.5 and count(scores.student_id) >= 10

--Câu 2.3: Hiển thị tên sinh viên, tên môn, điểm số — chỉ lấy điểm ≥ 8, phân trang: bỏ 10 bản ghi đầu, lấy 5 bản ghi tiếp theo.
select students.full_name, subjects.subject_name, scores.score
    from students
    join scores on scores.student_id = students.student_id
    join subjects on subjects.subject_id = scores.subject_id
    where scores.score >= 8 
    order by scores.score desc
    limit 5 offset 10;