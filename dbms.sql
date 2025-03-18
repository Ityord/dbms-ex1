1. SELECT building, room_number, capacity
FROM classroom
WHERE capacity > 50;
2. SELECT name
FROM instructor
WHERE dept_name = 'Computer Science';
3. SELECT DISTINCT c.title
FROM course c
JOIN section s ON c.course_id = s.course_id
WHERE s.semester = 'Spring' AND s.year = 2023;
4. SELECT ID, name, tot_cred
FROM student
WHERE tot_cred > 100;
5. SELECT dept_name
FROM department
WHERE budget > 1000000;
6. SELECT dept_name, building
FROM department;
7. SELECT name
FROM student
WHERE dept_name = 'Biology';
8. SELECT title
FROM course
WHERE credits = 3;
9. SELECT ID, name
FROM instructor
WHERE dept_name IS NULL;
10. SELECT building, COUNT(*) AS total_classrooms
FROM classroom
GROUP BY building;
11. SELECT DISTINCT c.course_id, c.title
FROM course c
JOIN teaches t ON c.course_id = t.course_id
WHERE t.ID = '10101';
12. SELECT d.dept_name, COUNT(s.ID) AS total_students
FROM department d
LEFT JOIN student s ON d.dept_name = s.dept_name
GROUP BY d.dept_name;
13. SELECT DISTINCT s.name
FROM student s
JOIN takes t ON s.ID = t.ID
WHERE t.course_id = 'CS-101'
  AND t.grade = 'A';
14. SELECT ID, name, salary
FROM instructor
WHERE salary > 50000;
15. SELECT dept_name, AVG(salary) AS average_salary
FROM instructor
GROUP BY dept_name;
16. SELECT s.name
FROM student s
LEFT JOIN advisor a ON s.ID = a.s_ID
WHERE a.s_ID IS NULL;
17. SELECT c.course_id, c.title
FROM course c
JOIN prereq p ON c.course_id = p.course_id
WHERE p.prereq_id = 'CS-101';
18. SELECT building, COUNT(*) AS total_sections
FROM section
GROUP BY building;
19. SELECT DISTINCT s.name
FROM student s
JOIN takes t ON s.ID = t.ID
WHERE t.semester = 'Fall' AND t.year = 2022;
20. SELECT c.building, c.room_number
FROM classroom c
LEFT JOIN section s 
  ON c.building = s.building AND c.room_number = s.room_number
WHERE s.building IS NULL;
21. SELECT course_id, title
FROM course
WHERE dept_name = 'Mathematics';
22. SELECT DISTINCT s.name
FROM student s
JOIN takes t1 ON s.ID = t1.ID
JOIN takes t2 ON s.ID = t2.ID
WHERE t1.semester = 'Fall' 
AND t2.semester = 'Spring';
23. SELECT i.name
FROM instructor i
JOIN teaches t ON i.ID = t.ID
GROUP BY i.ID, i.name
HAVING COUNT(*) > 5;
24. SELECT c.course_id, c.title
FROM course c
WHERE NOT EXISTS (
  SELECT 1
  FROM prereq p
  WHERE p.course_id = c.course_id
);
25. SELECT dept_name, AVG(tot_cred) AS avg_credits
FROM student
GROUP BY dept_name;

