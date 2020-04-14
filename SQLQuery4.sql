CREATE TABLE student
(
 snum CHAR(4) NOT NULL PRIMARY KEY
              CHECK(snum LIKE 's[0-9][0-9][0-9]'),
 sname VARCHAR(20),
 sex CHAR(2) CHECK(sex IN('男','女')),
 dept VARCHAR(30),
 birthday DATE,
 telephone CHAR(12) CHECK(isnumeric(left(telephone,3))=1   
             and  isnumeric(right(telephone,8))=1)
)

CREATE TABLE course
(
 cnum CHAR(4) NOT NULL PRIMARY KEY
              CHECK(cnum LIKE 'c[0-9][0-9][0-9]'),
 cname VARCHAR(30),
 credits SMALLINT CHECK(credits BETWEEN 0 AND 8),
 descr VARCHAR(40),
 dept VARCHAR(30),
 textbook VARCHAR(40)
)

 CREATE TABLE sections
 (
  secnum CHAR(5) PRIMARY KEY
                 CHECK(secnum LIKE'[0-9][0-9][0-9][0-9][0-9]'),
  cnum CHAR(4) NOT NULL FOREIGN KEY REFERENCES.course,
  pnum CHAR(4) CHECK(pnum LIKE 'p___')
 )

CREATE TABLE sc
(
 snum CHAR(4) NOT NULL FOREIGN KEY REFERENCES.student,
 secnum CHAR(5) NOT NULL FOREIGN KEY REFERENCES.sections,
 score INT CHECK(score BETWEEN 0 AND 100)
 )

 INSERT INTO student
 VALUES('s001','赵剑','男','计算机','1999-3-25','010-11111111'),
       ('s002','王谦','男','交通工程','1998-1-1','027-55555555'),
	   ('s003','孙启明','男','土木工程','1999-4-1','021-44444444'),
	   ('s004','宇帆','男','机械工程','1999-9-17','021-33333333'),
	   ('s005','李晓静','女','生物工程','2000-6-21','030-22222222'),
	   ('s006','金之林','女','计算机','2000-9-11','040-66666666'),
       ('s007','张东晓','男','城市规划','1999-8-2','050-77777777'),
       ('s008','海琳','女','城市规划','2000-5-23','070-88888888')

 INSERT INTO course
 VALUES('c116','大学英语',6,'必修课','外语系','《大学英语》,同济大学出版社'),
       ('c120','高等数学',6,'必修课','数学系','《高等数学》,复旦大学出版社'),
	   ('c126','大学物理',3,'必修课','物理系','《大学物理》,高等教育出版社'),
	   ('c130','数据库技术',3,'限选课','计算机系','《数据库技术与应用》,高等教育出版社'),
       ('c132','多媒体技术',3,'限选课','计算机系','《多媒体技术与应用》,清华大学出版社'),
       ('c135','VB程序设计',3,'限选课','计算机系','《VB.NET程序设计》,高等教育出版社')

 INSERT INTO sections
 VALUES('11601','c116','p001'),
	   ('11602','c116','p002'),
	   ('12001','c120','p003'),
	   ('12002','c120','p003'),
	   ('12601','c126','p004'),
	   ('13001','c130','p005'),
	   ('13002','c130','p006'),
       ('13201','c132','p007'),
       ('13501','c135','p007')

 INSERT INTO sc
 VALUES('s001','11601',77),
       ('s001','12001',80),
	   ('s001','12601',89),
	   ('s001','13002',90),
	   ('s001','13201',92),
	   ('s001','13501',94),
	   ('s002','11602',90),
	   ('s002','12601',88),
	   ('s002','13201',98),
	   ('s003','11601',90),
	   ('s003','12002',94),
	   ('s003','12601',88),
	   ('s004','11601',89),
	   ('s004','13001',90),
	   ('s004','13201',92),
	   ('s004','13501',89),
	   ('s005','11602',56),
	   ('s006','11601',88),
	   ('s006','12601',78),
	   ('s007','11602',90),
	   ('s007','13201',95),
	   ('s007','13501',50),
	   ('s008','11601',89),
	   ('s008','12001',90),
       ('s008','12601',93)