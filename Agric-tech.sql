# create the database
CREATE DATABASE agric_tech;

# The first table will be to store information about the Agricultural training prorgram

CREATE TABLE program(
	program_id INT PRIMARY KEY AUTO_INCREMENT,
	program_name CHAR(100) NOT NULL,
	duration_months INT NOT NULL,
    descriptions TEXT
);

INSERT INTO Program(program_name, duration_months, descriptions) VALUES
('Crop Production', 12, 'Training on crop farming techniques'),
('Animal Husbandry', 10, 'Livestock management and care'),
('Agro-Processing', 8, 'Processing and preservation of farm produce'),
('Agribusiness Management', 6, 'Business and financial skills in agriculture'),
('Organic Farming', 9, 'Sustainable and organic farming practices');

# The second table will be to store student records in the program

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name CHAR(50) NOT NULL,
    last_name CHAR(50) NOT NULL,
    email CHAR(100) UNIQUE NOT NULL,
    phone_number CHAR(20) NOT NULL,
    gender ENUM ('male', 'female') default 'male',
    date_of_birth DATE NOT NULL,
    enrollment_date DATE NOT NULL,
    program_id INT NOT NULL,
    FOREIGN KEY (program_id) REFERENCES Program(program_id)
);

/*
The foreign key constraint ensures that every student is enrolled in a valid program by linking 
"Students.program_id" to "Program.program_id", thereby maintaining referential integrity.
*/

INSERT INTO Students 
(first_name, last_name, email, phone_number, gender, date_of_birth, enrollment_date, program_id) 
VALUES
('Daniel', 'Ibrahim', 'daniel.ibrahim@student.com', '08100000001', 'male', '1998-05-10', '2025-01-15', 1),
('Aisha', 'Musa', 'aisha.musa@student.com', '08100000002', 'female', '1999-08-21', '2025-01-15', 2),
('Chinedu', 'Okorie', 'chinedu.okorie@student.com', '+2348100000003', 'male', '1997-11-03', '2025-01-15', 3),
('Fatima', 'Sule', 'fatima.sule@student.com', '08100000004', 'female', '2000-02-14', '2025-01-15', 4),
('Joseph', 'Ade', 'joseph.ade@student.com', '08100000005', 'male', '1998-09-30', '2025-01-15', 5);


# Stores information about trainers/instructors.

CREATE TABLE Trainers (
    trainer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name CHAR(50) NOT NULL,
    last_name CHAR(50) NOT NULL,
    email CHAR(100) UNIQUE NOT NULL,
    expertise_area CHAR(100) NOT NULL,
    phone_number CHAR(20) NOT NULL
);

INSERT INTO Trainers (first_name, last_name, email, expertise_area, phone_number) VALUES
('Chris', 'Awoke', 'chris.awoke@agroedu.com', 'Crop Science', '08030000001'),
('Bassey', 'Edikan', 'bassey.edikan@agroedu.com', 'Animal Production', '08030000002'),
('Peter', 'Okoye', 'peter.okoye@agroedu.com', 'Agribusiness', '08030000003'),
('Grace', 'Lawal', 'grace.lawal@agroedu.com', 'Soil Science', '08030000004'),
('Samuel', 'Daniels', 'samuel.daniels@agroedu.com', 'Agro-Processing', '08030000005');

# courses offered under each programs

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name CHAR(100) NOT NULL,
    course_code CHAR(20) NOT NULL,
    program_id INT NOT NULL,
    trainer_id INT NOT NULL,
    FOREIGN KEY (program_id) REFERENCES Program(program_id), # A course can only be created for a program that already exists.
    FOREIGN KEY (trainer_id) REFERENCES Trainers(trainer_id) # Every course must be assigned to a trainer that exists in the Trainers table.
);

/*
The foreign keys in the Courses table link each course to a valid program and a valid trainer, 
enforcing referential integrity and establishing one-to-many relationships.
*/

INSERT INTO Courses (course_name, course_code, program_id, trainer_id) VALUES
('Introduction to Crop Farming', 'CPF101', 1, 1),
('Livestock Management Basics', 'AHB101', 2, 2),
('Food Processing Techniques', 'AGP101', 3, 5),
('Farm Business Planning', 'ABM101', 1, 1),
('Organic Soil Management', 'ORG101', 5, 4);

SELECT * FROM courses;


# Tracks which students are enrolled in which courses.

CREATE TABLE Course_Enrollments (
	enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrolled_on DATE NOT NULL,
    grade CHAR(5) NOT NULL,
    FOREIGN KEY (student_id) REFERENCES Students(student_id), # You cannot enroll a student unless that student already exists.
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) # You cannot enroll a student in a course that does not exist.
);

/*
The foreign keys in the Course_Enrollments table link each enrollment to an existing student and an existing course, 
enforcing referential integrity and enabling a many-to-many relationship between students and courses.

N.B: Reerential integrity is a database constraint ensuring that relationships between tables remain consistent and valid by
requiring every foreign key value to match an existing primary key in the parents table. 
*/

INSERT INTO Course_Enrollments (student_id, course_id, enrolled_on, grade)  VALUES
(1, 1, '2026-02-01', 'A'),
(2, 2, '2026-02-01', 'B'),
(3, 3, '2026-02-01', 'A'),
(4, 4, '2026-02-01', 'B'),
(5, 5, '2026-02-01', 'A');

# stores agricualtual projects completed by students

CREATE TABLE farm_projects(
	project_id INT PRIMARY KEY  AUTO_INCREMENT,
	student_id INT,
    project_title CHAR(150),
    start_date DATE,
    end_date DATE,
    crop_type CHAR(50),
    report ENUM('pending', 'ongoing', 'completed'),
    FOREIGN KEY (student_id) REFERENCES Students (student_id) # each farm projects must belong to registered student in the program.
);


# The foreign key ensures that every "student_id" in "farm_projects" already exists in the "Students" table.

INSERT INTO farm_projects 
(student_id, project_title, start_date, end_date, crop_type, report) 
VALUES
(1, 'Maize Cultivation Project', '2025-11-01', '2026-01-30', 'Maize', 'completed'),
(2, 'Poultry Farming Project', '2025-12-01', '2026-04-30', 'Poultry', 'ongoing'),
(3, 'Cassava Processing Project', '2025-11-15', '2025-12-31', 'Cassava', 'completed'),
(4, 'Farm Marketing Plan', '2025-12-01', '2026-09-01', 'Mixed Crops', 'pending'),
(5, 'Organic Vegetable Farming', '2026-01-01', '2026-05-30', 'Vegetables', 'ongoing');


# stores farm resouces used in the farm_projects

CREATE TABLE agricultural_resources(
	resource_id INT PRIMARY KEY AUTO_INCREMENT,
    resource_name CHAR(100),
    resource_type CHAR(50),
    quantity INT,
    acquired_date DATE,
    assigned_to_project_id INT,
    FOREIGN KEY (assigned_to_project_id) REFERENCES farm_projects (project_id)
);

/*
Every agricultural resource that is assigned to a project must reference a project that already 
exists in the "farm_projects" table.
*/

INSERT INTO agricultural_resources 
(resource_name, resource_type, quantity, acquired_date, assigned_to_project_id) 
VALUES
('Hybrid Maize Seeds', 'Seeds', 50, '2026-02-12', 1),
('Poultry Feed', 'Feed', 200, '2026-02-01', 2),
('Cassava Grater', 'Tool', 2, '2026-02-10', 3),
('Marketing Manuals', 'Material', 10, '2026-02-03', 4),
('Organic Fertilizer', 'Fertilizer', 30, '2026-01-30', 5);



/*
program ────< students ────< course_enrollments >──── courses >──── trainers
                  |
                  |
                  v
            farm_projects ────< agricultural_resources 

This Entity diagram means one program can have many student, and one student can enrol in many courses which means one course 
can have many student. 
So, if:
	1. one student can have multiple courses and 
	2. and one course can have multiple student.
 
That means a "Many-to-Many" relationship and we have to use a junction table "course_enrolment" to bridge them. 

Also, one trainer can have different course. and one student can have many farm project, and one project can have 
many agricultural resources.

*/
