--26、查询每门课程被选修的学生数；
--思路：简单的分组
--given answer
 select cno,count(sno) from sc group by cno;

--my answer
SELECT cno, COUNT(cno) AS 学生数
FROM sc
GROUP BY cno;

------------------------------------------------------------------
--27、查查询出只选修了一门课程的全部学生的学号和姓名；
--思路：联结 + 分组 + HAVING与WHERE的区别
--given answer
SELECT sc.sno, student.sname, count(cno) AS 选课数 
FROM sc, student 
WHERE sc.sno = student.sno
GROUP BY sc.sno, student.sname
HAVING count(cno) = 1;

--my answer
SELECT s.sno AS 学号, s.sname AS 姓名
FROM sc, student AS s
WHERE sc.sno = s.sno
GROUP BY sc.sno
HAVING COUNT(cno) = 1;

------------------------------------------------------------------
--28、查询男生、女生人数；
--思路：CASE or COUNT
--given answer
select 
(select count(1) from student where ssex = '男') 男生人数,
(select count(1) from student where ssex = '女') 女生人数;

--my answer
SELECT
SUM(CASE WHEN ssex = '男' THEN 1 ELSE 0 END) AS 男生人数,
SUM(CASE WHEN ssex = '女' THEN 1 ELSE 0 END) AS 女生人数
FROM student;

------------------------------------------------------------------
--29、查询姓“张”的学生名单；
--思路：通配符
--given answer
SELECT sname FROM student WHERE sname like '张%';

--my answer
SELECT sname
FROM student
WHERE sname LIKE '张%';

------------------------------------------------------------------
--30、查询同名同性学生名单，并统计同名人数；
--思路：分组
--given answer
select sname,count(*) from student group by sname having count(*)>1;

--my answer
SELECT sname, COUNT(sname)
FROM student
GROUP BY sname
HAVING COUNT(sname) > 1;