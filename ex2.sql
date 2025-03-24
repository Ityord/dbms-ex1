1. SELECT DISTINCT i.name
FROM instructor i
JOIN teaches t ON i.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE c.dept_name = 'Computer Science';
2. SELECT s.name
FROM student s
JOIN takes t1 ON s.ID = t1.ID
JOIN takes t2 ON s.ID = t2.ID
WHERE t1.year = t2.year 
AND t1.semester = 'Fall'
AND t2.semester = 'Spring';
3. SELECT c.building, c.room_number, c.capacity
FROM classroom c
LEFT JOIN section s ON c.building = s.building AND c.room_number = s.room_number
WHERE c.capacity > 100 AND s.course_id IS NULL;
4. SELECT c.course_id, c.title, c.credits, p.prereq_id 
FROM course c
LEFT JOIN prereq p ON c.course_id = p.course_id;
5. SELECT i.ID, i.name, i.dept_name, i.salary
FROM instructor i
LEFT JOIN teaches t ON i.ID = t.ID
WHERE t.ID IS NULL;
6. SELECT SUM(d.budget) AS total_budget
FROM department d
WHERE d.dept_name IN (
    SELECT i.dept_name
    FROM instructor i
    WHERE i.salary > 100000
);
7. SELECT i.dept_name, AVG(i.salary) AS avg_salary
FROM instructor i
GROUP BY i.dept_name
HAVING COUNT(i.ID) > 5;
8. SELECT t.course_id, t.semester, t.year, COUNT(t.ID) AS total_students
FROM takes t
GROUP BY t.course_id, t.semester, t.year
ORDER BY t.semester, total_students DESC;
9.SELECT c.dept_name, AVG(c.credits) AS avg_credits
FROM course c
GROUP BY c.dept_name
ORDER BY avg_credits DESC
FETCH FIRST 1 ROW ONLY;
10. SELECT t.course_id, c.title, COUNT(t.ID) AS total_students
FROM takes t
JOIN course c ON t.course_id = c.course_id
GROUP BY t.course_id, c.title
ORDER BY total_students DESC
FETCH FIRST 3 ROWS ONLY;
11. WITH john_courses AS (
    SELECT t.course_id
    FROM teaches t
    JOIN instructor i ON t.ID = i.ID
    WHERE i.name = 'John Doe'
)

SELECT s.name
FROM student s
WHERE NOT EXISTS (
    SELECT jc.course_id
    FROM john_courses jc
    WHERE NOT EXISTS (
        SELECT 1
        FROM takes tk
        WHERE tk.ID = s.ID AND tk.course_id = jc.course_id
    )
);
12. SELECT s.name
FROM student s
JOIN advisor a ON s.ID = a.s_ID
JOIN instructor i ON a.i_ID = i.ID
WHERE s.name = i.name;
13. SELECT DISTINCT i.name
FROM instructor i
JOIN teaches t ON i.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE i.dept_name <> c.dept_name;
14. SELECT s.name
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN section sec ON t.course_id = sec.course_id 
               AND t.sec_id = sec.sec_id 
               AND t.semester = sec.semester 
               AND t.year = sec.year
JOIN classroom c ON sec.building = c.building 
                AND sec.room_number = c.room_number
WHERE c.capacity < (
    SELECT COUNT(*) 
    FROM takes t2
    WHERE t2.course_id = sec.course_id
    AND t2.sec_id = sec.sec_id
    AND t2.semester = sec.semester
    AND t2.year = sec.year
);
15. SELECT s.name
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE c.dept_name = s.dept_name
GROUP BY s.ID, s.name
HAVING COUNT(DISTINCT c.course_id) = (
    SELECT COUNT(*)
    FROM course c2
    WHERE c2.dept_name = s.dept_name
);
16. SELECT dept_name, COUNT(DISTINCT course_id) AS num_courses
FROM course
GROUP BY dept_name
ORDER BY num_courses DESC
FETCH FIRST 1 ROWS WITH TIES;
17. SELECT s.ID, s.name
FROM student s
JOIN takes t ON s.ID = t.ID
WHERE t.grade IS NULL;
18. SELECT i1.*
FROM instructor i1
JOIN instructor i2 ON i1.salary = i2.salary AND i1.ID <> i2.ID;
19. SELECT c1.course_id, c1.title
FROM course c1
JOIN prereq p1 ON c1.course_id = p1.course_id
LEFT JOIN prereq p2 ON p1.prereq_id = p2.course_id
WHERE p2.course_id IS NULL;
20. SELECT s.ID, s.name
FROM student s
JOIN takes t ON s.ID = t.ID
WHERE t.semester IN ('Fall', 'Winter', 'Spring', 'Summer')
GROUP BY s.ID, s.name
HAVING COUNT(DISTINCT t.semester) = 4;
21. WITH RECURSIVE PrereqChain AS (
    SELECT p.prereq_id, p.course_id
    FROM prereq p
    WHERE p.course_id = 'CS-101' 
    UNION ALL
    SELECT p.prereq_id, pc.course_id
    FROM prereq p
    JOIN PrereqChain pc ON p.course_id = pc.prereq_id
)
SELECT * FROM PrereqChain;
22. WITH RECURSIVE PrereqChain AS (
    SELECT p.prereq_id AS prereq_of_prereq, p.course_id AS direct_prereq
    FROM prereq p
    UNION ALL
    SELECT pc.prereq_of_prereq, p.course_id
    FROM prereq p
    JOIN PrereqChain pc ON p.prereq_id = pc.direct_prereq
)

SELECT DISTINCT direct_prereq
FROM PrereqChain;

