CREATE VIEW ViewA
AS
SELECT sc.snum,course.cnum,course.cname,sc.score
FROM course,sc,sections
WHERE sc.secnum=sections.secnum AND sections.cnum=course.cnum

SELECT *
FROM ViewA

SELECT cname
FROM ViewA
EXCEPT
SELECT cname
FROM ViewA
WHERE score<60

CREATE PROC ProcA
AS
SELECT * FROM student


EXEC ProcA

CREATE PROC ProcB
@_year INT
AS
SELECT * FROM student WHERE @_year=YEAR(birthday)

DECLARE @myYear INT
SET @myYear=1999
EXEC ProcB @myYear

CREATE PROC ProcC
@_snum CHAR(4),
@_avg INT OUT,
@_all_cource INT OUT,
@_fail INT OUT
AS
SELECT @_avg=AVG(score),@_all_cource=COUNT(snum),@_fail=sum(case when score<60 then 1 else 0 end)
FROM sc WHERE snum=@_snum
GROUP BY snum

DECLARE @my_snum CHAR(4)
DECLARE @my_avg INT 
DECLARE @my_all_course INT
DECLARE @my_fail INT
SET @my_snum='s005'
EXEC ProcC @my_snum,@my_avg OUT,@my_all_course OUT,@my_fail OUT
PRINT @my_snum+'同学的平均分是:'+CAST(@my_avg AS CHAR(3))+',选课门数是:'+CAST(@my_all_course AS CHAR(2))
+',不及格课程门数是:'+CAST(@my_fail AS CHAR(2))


CREATE TRIGGER TA
ON sc
FOR INSERT,UPDATE
AS
BEGIN
    IF((SELECT snum FROM inserted) NOT IN(SELECT snum FROM student))
	BEGIN
	    PRINT'违反参照完整性约束'
		ROLLBACK
	END
END

insert into sc
values('s009','11601',100)



CREATE  TRIGGER TB
ON student
FOR INSERT
AS
     DECLARE @_snum AS CHAR(4)
     SELECT @_snum=i.snum FROM inserted I
     DECLARE @age AS INTEGER
     SELECT @age=year(getdate())-year(birthday) 
     FROM student 
     WHERE  snum=@_snum
     IF @age>=14 and @age<=35
          PRINT  '数据录入成功'
     ELSE
          BEGIN
               PRINT '年龄越界!'
               ROLLBACK TRAN
          END

insert into student
values('s009','余周周','女','城市规划','2007-1-19','070-88888888')

insert into student
values('s010','林杨','男','数学与应用数学','1977-2-5','080-88888888')

insert into student
values('s011','蒋川','男','数学与应用数学','1997-4-18','090-88888888')

DELETE FROM student WHERE snum='s011'

CREATE TRIGGER TC
ON course
FOR INSERT
AS
	DECLARE @_textbook CHAR(20)
	SELECT @_textbook=right(i.textbook,7)
	FROM inserted i
	IF(@_textbook!='高等教育出版社' AND @_textbook!='清华大学出版社' AND @_textbook!='复旦大学出版社' AND @_textbook!='同济大学出版社')
		BEGIN
			PRINT'不是制定出版社,不能订购!'
			ROLLBACK TRAN
		END
	ELSE
		PRINT'订购成功!'


INSERT INTO course
VALUES('c140','C++程序设计',3,'限选课','计算机系','《C++程序设计》,同济大学出版社')

INSERT INTO course
VALUES('c140','C++程序设计',3,'限选课','计算机系','《C++程序设计》,北京大学出版社')

DELETE FROM course WHERE cnum='c140'





CREATE TRIGGER TD
ON sc
FOR INSERT,UPDATE
AS
	DECLARE @_snum CHAR(4)
	DECLARE @_secnum CHAR(5)
	DECLARE @_cnum CHAR(4)
	DECLARE @_score INT
	SELECT @_snum=i.snum,@_secnum=i.secnum,@_score=i.score FROM inserted i
	SELECT @_cnum=s.cnum FROM sections s WHERE @_secnum=secnum
	IF EXISTS(SELECT * FROM sc,sections WHERE sc.secnum=sections.secnum AND @_snum=snum AND @_cnum=cnum AND @_secnum!=sc.secnum)
		BEGIN
			PRINT'已存在该生选此课信息!'
			ROLLBACK 
		END
	ELSE IF EXISTS(SELECT * FROM sc,sections WHERE sc.secnum=sections.secnum AND @_snum=snum AND @_cnum=cnum AND @_secnum=sc.secnum AND @_score!=sc.score)
		BEGIN
			PRINT'已将该同学的课程成绩更新!'
			DELETE FROM sc WHERE @_snum=snum AND @_secnum=sc.secnum AND @_score!=sc.score
		END
	ELSE
		PRINT'已成功插入学生记录!'



insert into sc
values
('s001','11602',77)

insert into sc
values
('s001','12001',80)

insert into sc
values
('s005','12001',70)

DELETE FROM sc WHERE snum='s005' AND secnum='12001' AND score=70
