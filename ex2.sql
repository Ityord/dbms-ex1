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
23. SELECT prereq_id, course_id, LEVEL AS chain_length
FROM prereq
START WITH course_id = 'CS101'
CONNECT BY PRIOR prereq_id = course_id
ORDER BY chain_length ASC
FETCH FIRST 1 ROW ONLY;
24. SELECT s.ID, s.name, t.course_id
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN prereq p ON t.course_id = p.course_id
LEFT JOIN takes t2 ON s.ID = t2.ID AND t2.course_id = p.prereq_id
WHERE t2.course_id IS NULL;
25. SELECT DISTINCT i.ID, i.name
FROM instructor i
JOIN teaches t ON i.ID = t.ID
JOIN prereq p ON t.course_id = p.course_id;
26. SELECT s1.ID AS student_1_id, s1.name AS student_1_name, s1.dept_name AS student_1_dept,
       s2.ID AS student_2_id, s2.name AS student_2_name, s2.dept_name AS student_2_dept,
       s1.tot_cred AS total_credits
FROM student s1
JOIN student s2 ON s1.tot_cred = s2.tot_cred
WHERE s1.ID <> s2.ID AND s1.dept_name <> s2.dept_name;
27. WITH dept_max_salary AS (
    SELECT dept_name, MAX(salary) AS max_salary
    FROM instructor
    GROUP BY dept_name
)

SELECT i.ID, i.name, i.dept_name, i.salary
FROM instructor i
JOIN dept_max_salary dms ON i.dept_name = dms.dept_name AND i.salary = dms.max_salary
WHERE i.salary < (SELECT MAX(max_salary) FROM dept_max_salary WHERE dept_name <> i.dept_name);
28. WITH course_count AS (
    SELECT t.ID,
           COUNT(*) AS total_courses,
           SUM(CASE WHEN t.grade = 'F' THEN 1 ELSE 0 END) AS failed_courses
    FROM takes t
    GROUP BY t.ID
)
SELECT s.ID, s.name, cc.total_courses, cc.failed_courses
FROM student s
JOIN course_count cc ON s.ID = cc.ID
WHERE cc.total_courses > 1 AND cc.failed_courses >= (cc.total_courses / 2);
29. WITH dept_max_salary AS (
    SELECT i.dept_name,
           MAX(i.salary) AS max_salary,
           COUNT(*) AS num_instructors
    FROM instructor i
    GROUP BY i.dept_name
),
dept_budget AS (
    SELECT d.dept_name,
           d.budget
    FROM department d
)
SELECT dms.dept_name, 
       dms.max_salary, 
       (db.budget / dms.num_instructors) AS avg_budget_per_instructor
FROM dept_max_salary dms
JOIN dept_budget db ON dms.dept_name = db.dept_name
WHERE dms.max_salary > (db.budget / dms.num_instructors);
30. WITH taught_courses AS (
    SELECT course_id, semester, year
    FROM section
)
SELECT c.course_id
FROM course c
WHERE NOT EXISTS (
    SELECT 1
    FROM taught_courses t1
    JOIN taught_courses t2 
        ON t1.course_id = t2.course_id
        AND t1.semester = t2.semester
        AND t1.year = t2.year - 1
    WHERE t1.course_id = c.course_id
);
31. WITH RankedInstructors AS (
    SELECT i.*,
           ROW_NUMBER() OVER (PARTITION BY dept_name ORDER BY salary DESC) AS rn
    FROM instructor i
)
SELECT dept_name, name, salary
FROM RankedInstructors
WHERE rn = 2;
32. WITH StudentSemesterCredits AS (
  SELECT t.ID, t.semester, t.year, SUM(c.credits) AS total_credits
  FROM takes t
  JOIN course c ON t.course_id = c.course_id
  GROUP BY t.ID, t.semester, t.year
),
MaxCredits AS (
  SELECT MAX(total_credits) AS max_credits
  FROM StudentSemesterCredits
)
SELECT s.name, ssc.semester, ssc.year, ssc.total_credits
FROM StudentSemesterCredits ssc
JOIN student s ON s.ID = ssc.ID
JOIN MaxCredits m ON ssc.total_credits = m.max_credits;
33. WITH RankedStudents AS (
    SELECT s.ID, s.name, s.tot_cred,
           RANK() OVER (ORDER BY s.tot_cred DESC) AS rnk
    FROM student s
)
SELECT ID, name, tot_cred
FROM RankedStudents
WHERE rnk <= 5;
34. WITH UniqueCourses AS (
    SELECT t.ID, COUNT(DISTINCT t.course_id) AS unique_courses
    FROM teaches t
    GROUP BY t.ID
)
SELECT i.ID, i.name, uc.unique_courses
FROM UniqueCourses uc
JOIN instructor i ON uc.ID = i.ID
WHERE uc.unique_courses = (SELECT MAX(unique_courses) FROM UniqueCourses);
35. WITH CourseMaxGrade AS (
  SELECT course_id, MAX(grade) AS max_grade
  FROM takes
  GROUP BY course_id
),
StudentHighCourses AS (
  SELECT t.ID, t.course_id
  FROM takes t
  JOIN CourseMaxGrade cmg 
    ON t.course_id = cmg.course_id 
   AND t.grade = cmg.max_grade
  GROUP BY t.ID, t.course_id
),
StudentCount AS (
  SELECT ID, COUNT(*) AS high_grade_course_count
  FROM StudentHighCourses
  GROUP BY ID
),
MaxCount AS (
  SELECT MAX(high_grade_course_count) AS max_count
  FROM StudentCount
)
SELECT s.ID, s.name, sc.high_grade_course_count
FROM StudentCount sc
JOIN student s ON sc.ID = s.ID
JOIN MaxCount mc ON sc.high_grade_course_count = mc.max_count;
36. SELECT s.ID, s.name
FROM student s
JOIN takes t ON s.ID = t.ID
JOIN course c ON t.course_id = c.course_id
GROUP BY s.ID, s.name
HAVING SUM(CASE WHEN c.dept_name = 'Computer Science' THEN 1 ELSE 0 END) > 0
   AND SUM(CASE WHEN c.dept_name = 'Mathematics' THEN 1 ELSE 0 END) > 0
   AND SUM(CASE WHEN c.dept_name = 'Physics' THEN 1 ELSE 0 END) = 0;
37.WITH TotalDeptCourses AS (
    SELECT dept_name, COUNT(*) AS total_courses
    FROM course
    GROUP BY dept_name
),
StudentDeptTaken AS (
    SELECT s.ID, s.name, s.dept_name, COUNT(DISTINCT c.course_id) AS taken_courses
    FROM student s
    LEFT JOIN takes t ON s.ID = t.ID
    LEFT JOIN course c ON t.course_id = c.course_id 
                      AND c.dept_name = s.dept_name
    GROUP BY s.ID, s.name, s.dept_name
)
SELECT s.ID, s.name, s.dept_name
FROM StudentDeptTaken s
JOIN TotalDeptCourses d ON s.dept_name = d.dept_name
WHERE d.total_courses - s.taken_courses = 1;
38. SELECT i.ID, i.name
FROM instructor i
JOIN teaches t ON i.ID = t.ID
GROUP BY i.ID, i.name
HAVING COUNT(DISTINCT t.semester) = 4;
39. WITH AdvisorsMultiDepts AS (
    SELECT a.i_ID
    FROM advisor a
    JOIN student s ON a.s_ID = s.ID
    GROUP BY a.i_ID
    HAVING COUNT(DISTINCT s.dept_name) > 1
)
SELECT s.ID, s.name, s.dept_name, a.i_ID AS advisor
FROM advisor a
JOIN student s ON a.s_ID = s.ID
WHERE a.i_ID IN (SELECT i_ID FROM AdvisorsMultiDepts);
40. SELECT DISTINCT c.course_id, c.title
FROM prereq p
JOIN course c ON p.prereq_id = c.course_id
WHERE EXISTS (
    -- Find at least one student who took the prerequisite course
    -- but never took the corresponding main course.
    SELECT 1
    FROM takes t1
    WHERE t1.course_id = p.prereq_id
      AND NOT EXISTS (
            SELECT 1
            FROM takes t2
            WHERE t2.course_id = p.course_id
              AND t2.ID = t1.ID
      )
);


