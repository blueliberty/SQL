--1、查询课程1的成绩 比 课程2的成绩 高 的所有学生的学号；
--思路：子查询 + 表的别名 + 联结 + 过滤
--given answer
select a.sno from
(select sno,score from sc where cno=1) AS a,
(select sno,score from sc where cno=2) AS b
where a.score>b.score and a.sno=b.sno;

--my answer
SELECT a.sno
FROM (SELECT sno, score
	  FROM sc
	  WHERE cno = 1) AS a,
	 (SELECT sno, score
	  FROM sc
	  WHERE cno = 2) AS b
WHERE a.sno = b.sno
AND a.score > b.score;

------------------------------------------------------------------
--2、查询平均成绩大于60分的同学的学号和平均成绩；
--思路：分组 + HAVING分组过滤
--given answer
select sno,avg(score) as sscore from sc group by sno having avg(score) >60;

--my answer
SELECT sno, AVG(score) AS avg
FROM sc
GROUP BY sno
HAVING AVG(score) > 60;

------------------------------------------------------------------
--3、查询所有同学的学号、姓名、选课数、总成绩；
--思路：联结 + 分组
--given answer
select a.sno as 学号, b.sname as 姓名,
count(a.cno) as 选课数, sum(a.score) as 总成绩
from sc a, student b
where a.sno = b.sno
group by a.sno, b.sname;

--my answer
SELECT sc.sno, s.sname, COUNT(sc.cno) AS totalnum, SUM(sc.score) AS totalscore
FROM sc, student AS s
WHERE sc.sno = s.sno
GROUP BY sc.sno;

------------------------------------------------------------------
--4、查询姓“李”的老师的个数；
--思路：通配符的使用
--given answer
select count(distinct(tname)) from teacher where tname like '李%';

--my answer
SELECT COUNT(DISTINCT tname) AS 姓“李”的老师的个数
FROM teacher
WHERE tname LIKE '李%';

------------------------------------------------------------------
--5、查询没学过“叶平”老师课的同学的学号、姓名；
--思路：找出学过“叶平”老师课的同学，然后用NOT IN
--given answer
select student.sno,student.sname from student
where sno not in (select distinct(sc.sno) from sc,course,teacher
where sc.cno=course.cno and teacher.tno=course.tno and teacher.tname='叶平');

--my answer
SELECT s.sno, s.sname
FROM student AS s
WHERE s.sno NOT IN (SELECT sc.sno
					FROM sc, teacher AS t, course AS c
					WHERE sc.cno = c.cno
					AND c.tno = t.tno
					AND t.tname='叶平');

------------------------------------------------------------------
--6、查询同时学过课程1和课程2的同学的学号、姓名；
--思路：IN 的 交集
--given answer
select sno, sname from student
where sno in (select sno from sc where sc.cno = 1)
and sno in (select sno from sc where sc.cno = 2);

--my answer
SELECT sno, sname
FROM student
WHERE sno IN (SELECT a.sno
			  FROM (SELECT sno
					FROM sc
					WHERE cno = 1) AS a,
				   (SELECT sno
					FROM sc
					WHERE cno = 2) AS b
			  WHERE a.sno = b.sno);

------------------------------------------------------------------
--7、查询学过“叶平”老师所教所有课程的所有同学的学号、姓名；
--思路：IN + 子查询
--given answer
select a.sno, a.sname from student a, sc b
where a.sno = b.sno and b.cno in
(select c.cno from course c, teacher d where c.tno = d.tno and d.tname = '叶平');

--my answer
SELECT sno, sname
FROM student
WHERE sno IN (SELECT sc.sno
			  FROM sc, teacher AS t, course AS c
			  WHERE sc.cno = c.cno
			  AND c.tno = t.tno
			  AND t.tname = '叶平');

------------------------------------------------------------------
--8、查询 课程编号1的成绩 比 课程编号2的成绩 高的所有同学的学号、姓名；
--思路：
--given answer
select a.sno, a.sname from student a,
(select sno, score from sc where cno = 1) b,
(select sno, score from sc where cno = 2) c
where b.score > c.score and b.sno = c.sno and a.sno = b.sno;

--my answer
SELECT sno, sname
FROM student
WHERE sno IN (SELECT a.sno
			  FROM (SELECT sno, score
			        FROM sc
			        WHERE cno = 1) AS a,
			       (SELECT sno, score
			        FROM sc
			        WHERE cno = 2) AS b
		  	  WHERE a.sno = b.sno
			  AND a.score > b.score);

------------------------------------------------------------------
--9、查询课程成绩全部小于60分的同学的学号、姓名；
--思路：所有成绩小于60 其补集为 有至少一门成绩大于60
--given answer
select sno, sname from student
where sno not in (select distinct sno from sc where score > 60);

--my answer
SELECT sno, sname
FROM student
WHERE sno NOT IN (SELECT DISTINCT sno
				  FROM sc
				  WHERE score > 60);

------------------------------------------------------------------
--10、查询课程成绩全部大于60分的同学的学号、姓名；
--思路：与第9题相同
--given answer
select sno,sname from student
where sno not in (select distinct sno from sc where score < 60);

--my answer
SELECT sno, sname
FROM student
WHERE sno NOT IN (SELECT DISTINCT sno
				  FROM sc
				  WHERE score < 60);