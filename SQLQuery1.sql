SELECT sname
FROM student,sc
WHERE student.snum=sc.snum AND sc.score<=60 

SELECT distinct sname,
(Year(current_timestamp)-Year(birthday))-(case when Month(current_timestamp)>Month(birthday) then 0 else 1 end ) as age
FROM student,course,sections,sc
WHERE course.dept='计算机系' AND
      course.cnum=sections.cnum AND
	  sections.secnum=sc.secnum AND
      sc.snum=student.snum

SELECT distinct sname,student.dept
FROM student,course,sections,sc
WHERE course.cname='数据库技术' AND
      course.cnum=sections.cnum AND
	  sections.secnum=sc.secnum AND
      sc.snum=student.snum

SELECT distinct sname FROM student WHERE not exists(
    SELECT cnum FROM course WHERE not exists(
       SELECT sc.snum,sections.cnum FROM sections,sc WHERE sc.secnum=sections.secnum 
	       AND sections.cnum=course.cnum AND sc.snum=student.snum
    )
)


SELECT distinct sname
FROM student,sc
WHERE student.snum=sc.snum
EXCEPT
SELECT sname
FROM student,sc
WHERE score<80 AND student.snum=sc.snum

SELECT distinct sname
FROM student 
WHERE not exists(
SELECT score
FROM sc
WHERE student.snum=sc.snum AND score<80
)


SELECT sname
FROM student,sc
WHERE student.snum=sc.snum
GROUP BY sname   
HAVING avg(score)>=90 
EXCEPT
SELECT sname
FROM student,sc
WHERE score<80 AND student.snum=sc.snum

SELECT distinct sname
FROM student,sc
WHERE student.snum=sc.snum AND not exists(
SELECT score
FROM sc
WHERE student.snum=sc.snum AND score<80)
GROUP BY sname
HAVING avg(score)>=90


SELECT sname,score
FROM student,sc
WHERE student.snum=sc.snum AND sc.secnum in('11601','11602')
ORDER BY score DESC

SELECT sections.cnum as '课程号',count(sections.cnum) as '人数' 
FROM course,sc,sections
WHERE course.cnum=sections.cnum AND sections.secnum=sc.secnum
GROUP BY sections.cnum 

SELECT sname,student.dept
FROM student,sections,course,sc
WHERE course.cnum=sections.cnum AND sections.secnum=sc.secnum
AND sc.snum=student.snum AND course.cname='数据库技术'
EXCEPT
SELECT sname,student.dept
FROM student,sections,course,sc
WHERE course.cnum=sections.cnum AND sections.secnum=sc.secnum
AND sc.snum=student.snum AND course.cname='高等数学'


SELECT cname
FROM course
WHERE textbook LIKE('%,高等教育出版社')

SELECT cname as '课程名',MAX(score) as '最高分',MIN(score) as '最低分',AVG(score) as '平均分'
FROM sc,sections,course
WHERE sc.secnum=sections.secnum AND sections.cnum=course.cnum
GROUP BY(cname)

SELECT cname as '课程名',count(snum) as '选课人数',sum(case when score<60 then 1 else 0 end) as '不及格人数'
FROM course,sections,sc
WHERE course.cnum=sections.cnum AND sections.secnum=sc.secnum
GROUP BY cname

SELECT snum,sname FROM student
WHERE dept IN('土木工程','交通工程','城市规划')

SELECT student.snum 
FROM student,course,sections,sc
WHERE student.snum=sc.snum AND sc.secnum=sections.secnum 
AND sections.cnum=course.cnum AND course.cname='数据库技术'
UNION
SELECT student.snum 
FROM student,course,sections,sc
WHERE student.snum=sc.snum AND sc.secnum=sections.secnum 
AND sections.cnum=course.cnum AND course.cname='多媒体技术'

SELECT *
FROM student
WHERE dept='计算机'
INTERSECT
SELECT *
FROM student
WHERE (Year(current_timestamp)-Year(birthday))-(case when Month(current_timestamp)>Month(birthday) then 0 else 1 end )<=19

SELECT *
FROM student
WHERE dept='计算机'
INTERSECT
SELECT *
FROM student
WHERE (Year(current_timestamp)-Year(birthday))-(case when Month(current_timestamp)>Month(birthday) then 0 else 1 end )>19
