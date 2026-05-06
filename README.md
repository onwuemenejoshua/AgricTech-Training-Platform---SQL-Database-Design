# AgricTech Training Platform - SQL Database Design

A relational database built to manage an agricultural technology training program. It tracks students, trainers, courses, enrollments, farm projects, and the resources used in each project.

This project models a real-world agric-tech training system using SQL. The goal was to design a clean, well-structured relational schema that enforces data integrity and reflects how such a platform would actually work — from registering students into programs, assigning them courses with trainers, all the way to tracking their hands-on farm projects and the resources used.

It was also a personal exercise in thinking carefully about referential integrity, foreign key constraints, and many-to-many relationships.

## Database Structure

The database is named `agric_tech` and contains 7 tables:

| Table | Description   |
|---------|---------|
| program   | The agricultural training programs offered   |
| students  | Student records including enrollment date and assigned program   |
| trainers   | Instructors with their areas of expertise   |
| courses  | Courses linked to specific programs and trainers  |
| course_enrollments   | Junction table bridging the many-to-many relationship between students and courses   |
| farm_projects  | Hands-on projects completed by students   |
| agricultural_resources   | Materials and resources assigned to each farm project  |

```
program -< students -< course_enrollments >- courses >- trainers
                  |
                  |
                  v
            farm_projects -< agricultural_resources 
```

* One program can have many students
* One student can enrol in many courses, and one course can have many students. handled via the course_enrollments junction table
* One trainer can teach many courses
* One student can have many farm projects
* One farm project can have many agricultural resources

**What I Learned**

Designing this from scratch pushed me to think beyond just writing SQL. I had to ask questions like:

* What happens to student records if a program is deleted?
* How do I model a relationship where one student can take multiple courses and one course can have multiple students?
* How should I track which resources belong to which project?

