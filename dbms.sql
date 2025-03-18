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
26. SELECT DISTINCT s.name
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN teaches te ON t.course_id = te.course_id 
                AND t.sec_id = te.sec_id 
                AND t.semester = te.semester 
                AND t.year = te.year
JOIN instructor i ON te.ID = i.ID
WHERE i.name = 'Einstein';
27. SELECT course_id, sec_id, semester, year, room_number, time_slot_id
FROM section
WHERE building = 'Watson';
28. SELECT SUM(budget) AS total_budget
FROM department;
29. SELECT DISTINCT s.name
FROM student s
JOIN takes t ON s.ID = t.ID
WHERE t.grade = 'B';
30. SELECT i.ID, i.name
FROM instructor i
LEFT JOIN teaches t ON i.ID = t.ID
WHERE t.ID IS NULL;
31. SELECT s.name
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
WHERE c.dept_name = 'Computer Science'
GROUP BY s.name
HAVING COUNT(DISTINCT c.course_id) = (
    SELECT COUNT(DISTINCT course_id)
    FROM course
    WHERE dept_name = 'Computer Science'
);
32. SELECT i.name
FROM instructor i
WHERE (
    SELECT COUNT(DISTINCT c.course_id)
    FROM course c
    WHERE c.dept_name = i.dept_name
) = (
    SELECT COUNT(DISTINCT t.course_id)
    FROM teaches t
    WHERE t.ID = i.ID
    AND t.course_id IN (
        SELECT course_id
        FROM course
        WHERE dept_name = i.dept_name
    )
);
33. SELECT s.name
FROM student s
WHERE (
    SELECT COUNT(DISTINCT i.ID)
    FROM instructor i
    WHERE i.dept_name = s.dept_name
) = (
    SELECT COUNT(DISTINCT t.ID)
    FROM takes tk
    JOIN teaches t ON tk.course_id = t.course_id
        AND tk.sec_id = t.sec_id
        AND tk.semester = t.semester
        AND tk.year = t.year
    WHERE tk.ID = s.ID
    AND t.ID IN (
        SELECT ID 
        FROM instructor 
        WHERE dept_name = s.dept_name
    )
);
34. WITH PrereqCounts AS (
    SELECT course_id, COUNT(prereq_id) AS num_prereqs
    FROM prereq
    GROUP BY course_id
)
SELECT course_id, num_prereqs
FROM PrereqCounts
WHERE num_prereqs = (SELECT MAX(num_prereqs) FROM PrereqCounts);
35. SELECT s.name
FROM student s
JOIN (
    SELECT ID, course_id
    FROM takes
    GROUP BY ID, course_id
    HAVING COUNT(*) > 1
) retakes ON s.ID = retakes.ID
GROUP BY s.name;
36. SELECT i.name
FROM instructor i
WHERE 4 = (
    SELECT COUNT(DISTINCT t.semester)
    FROM teaches t
    WHERE t.ID = i.ID
      AND t.year = 2023
      AND t.semester IN ('Fall', 'Winter', 'Spring', 'Summer')
);
37. SELECT d.dept_name
FROM department d
JOIN instructor i ON d.dept_name = i.dept_name
GROUP BY d.dept_name
HAVING AVG(i.salary) > (SELECT AVG(salary) FROM instructor);
38. SELECT s.name
FROM student s
WHERE (
    SELECT COUNT(DISTINCT sec.time_slot_id)
    FROM takes t
    JOIN section sec 
      ON t.course_id = sec.course_id 
     AND t.sec_id = sec.sec_id 
     AND t.semester = sec.semester 
     AND t.year = sec.year
    WHERE t.ID = s.ID
) = (
    SELECT COUNT(DISTINCT time_slot_id)
    FROM time_slot
);
39. SELECT c.course_id, c.title
FROM course c
WHERE c.course_id IN (
    SELECT prereq_id
    FROM prereq
)
AND c.course_id NOT IN (
    SELECT course_id
    FROM prereq
);
40. WITH student_semester_counts AS (
    SELECT t.ID, t.semester, t.year, COUNT(*) AS course_count
    FROM takes t
    GROUP BY t.ID, t.semester, t.year
),
max_courses AS (
    SELECT MAX(course_count) AS max_count
    FROM student_semester_counts
)
SELECT s.name, ssc.semester, ssc.year, ssc.course_count
FROM student_semester_counts ssc
JOIN max_courses m ON ssc.course_count = m.max_count
JOIN student s ON s.ID = ssc.ID;




