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
4.
