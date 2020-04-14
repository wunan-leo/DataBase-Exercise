SELECT sname
FROM student,sc
WHERE student.snum=sc.snum AND sc.score<=60 

SELECT distinct sname,
(Year(current_timestamp)-Year(birthday))-(case when Month(current_timestamp)>Month(birthday) then 0 else 1 end ) as age
FROM student,course,sections,sc
WHERE course.dept='�����ϵ' AND
      course.cnum=sections.cnum AND
	  sections.secnum=sc.secnum AND
      sc.snum=student.snum

SELECT distinct sname,student.dept
FROM student,course,sections,sc
WHERE course.cname='���ݿ⼼��' AND
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

SELECT sections.cnum as '�γ̺�',count(sections.cnum) as '����' 
FROM course,sc,sections
WHERE course.cnum=sections.cnum AND sections.secnum=sc.secnum
GROUP BY sections.cnum 

SELECT sname,student.dept
FROM student,sections,course,sc
WHERE course.cnum=sections.cnum AND sections.secnum=sc.secnum
AND sc.snum=student.snum AND course.cname='���ݿ⼼��'
EXCEPT
SELECT sname,student.dept
FROM student,sections,course,sc
WHERE course.cnum=sections.cnum AND sections.secnum=sc.secnum
AND sc.snum=student.snum AND course.cname='�ߵ���ѧ'


SELECT cname
FROM course
WHERE textbook LIKE('%,�ߵȽ���������')

SELECT cname as '�γ���',MAX(score) as '��߷�',MIN(score) as '��ͷ�',AVG(score) as 'ƽ����'
FROM sc,sections,course
WHERE sc.secnum=sections.secnum AND sections.cnum=course.cnum
GROUP BY(cname)

SELECT cname as '�γ���',count(snum) as 'ѡ������',sum(case when score<60 then 1 else 0 end) as '����������'
FROM course,sections,sc
WHERE course.cnum=sections.cnum AND sections.secnum=sc.secnum
GROUP BY cname

SELECT snum,sname FROM student
WHERE dept IN('��ľ����','��ͨ����','���й滮')

SELECT student.snum 
FROM student,course,sections,sc
WHERE student.snum=sc.snum AND sc.secnum=sections.secnum 
AND sections.cnum=course.cnum AND course.cname='���ݿ⼼��'
UNION
SELECT student.snum 
FROM student,course,sections,sc
WHERE student.snum=sc.snum AND sc.secnum=sections.secnum 
AND sections.cnum=course.cnum AND course.cname='��ý�弼��'

SELECT *
FROM student
WHERE dept='�����'
INTERSECT
SELECT *
FROM student
WHERE (Year(current_timestamp)-Year(birthday))-(case when Month(current_timestamp)>Month(birthday) then 0 else 1 end )<=19

SELECT *
FROM student
WHERE dept='�����'
INTERSECT
SELECT *
FROM student
WHERE (Year(current_timestamp)-Year(birthday))-(case when Month(current_timestamp)>Month(birthday) then 0 else 1 end )>19
