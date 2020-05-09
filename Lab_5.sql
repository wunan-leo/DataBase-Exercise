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
PRINT @my_snum+'ͬѧ��ƽ������:'+CAST(@my_avg AS CHAR(3))+',ѡ��������:'+CAST(@my_all_course AS CHAR(2))
+',������γ�������:'+CAST(@my_fail AS CHAR(2))


CREATE TRIGGER TA
ON sc
FOR INSERT,UPDATE
AS
BEGIN
    IF((SELECT snum FROM inserted) NOT IN(SELECT snum FROM student))
	BEGIN
	    PRINT'Υ������������Լ��'
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
          PRINT  '����¼��ɹ�'
     ELSE
          BEGIN
               PRINT '����Խ��!'
               ROLLBACK TRAN
          END

insert into student
values('s009','������','Ů','���й滮','2007-1-19','070-88888888')

insert into student
values('s010','����','��','��ѧ��Ӧ����ѧ','1977-2-5','080-88888888')

insert into student
values('s011','����','��','��ѧ��Ӧ����ѧ','1997-4-18','090-88888888')

DELETE FROM student WHERE snum='s011'

CREATE TRIGGER TC
ON course
FOR INSERT
AS
	DECLARE @_textbook CHAR(20)
	SELECT @_textbook=right(i.textbook,7)
	FROM inserted i
	IF(@_textbook!='�ߵȽ���������' AND @_textbook!='�廪��ѧ������' AND @_textbook!='������ѧ������' AND @_textbook!='ͬ�ô�ѧ������')
		BEGIN
			PRINT'�����ƶ�������,���ܶ���!'
			ROLLBACK TRAN
		END
	ELSE
		PRINT'�����ɹ�!'


INSERT INTO course
VALUES('c140','C++�������',3,'��ѡ��','�����ϵ','��C++������ơ�,ͬ�ô�ѧ������')

INSERT INTO course
VALUES('c140','C++�������',3,'��ѡ��','�����ϵ','��C++������ơ�,������ѧ������')

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
			PRINT'�Ѵ��ڸ���ѡ�˿���Ϣ!'
			ROLLBACK 
		END
	ELSE IF EXISTS(SELECT * FROM sc,sections WHERE sc.secnum=sections.secnum AND @_snum=snum AND @_cnum=cnum AND @_secnum=sc.secnum AND @_score!=sc.score)
		BEGIN
			PRINT'�ѽ���ͬѧ�Ŀγ̳ɼ�����!'
			DELETE FROM sc WHERE @_snum=snum AND @_secnum=sc.secnum AND @_score!=sc.score
		END
	ELSE
		PRINT'�ѳɹ�����ѧ����¼!'



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
