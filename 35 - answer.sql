--31、1981年出生的学生名单(注：student表中sage列的类型是datetime)；
--思路：对日期和时间处理函数的运用
--given answer，网上给的答案是错误的

--my answer
SELECT sno, sname
FROM student
WHERE Year(sage) = 1981;

------------------------------------------------------------------
--32、查询每门课程的平均成绩，结果按平均成绩升序排列，平均成绩相同时，按课程号降序排列；
--思路：
--given answer
select cno 课程号, avg(score) 平均分
from sc group by cno order by 平均分 asc, cno desc;

--my answer
SELECT cno AS 课程号, AVG(score) AS 平均成绩
FROM sc
GROUP BY cno
ORDER BY 平均成绩 ASC, cno DESC;

------------------------------------------------------------------
--33、查询平均成绩大于80的所有学生的学号、姓名和平均成绩；
--思路：联结 + 分组 + HAVING
--given answer
select 
s1.sno,
s.sname,
AVG(s1.score) as '平均成绩'
from student s,sc s1
where s.sno=s1.sno 
group by s1.sno,s.sname
having AVG(s1.score)>80;

--my answer
SELECT sc.sno AS 学号, s.sname AS 姓名, AVG(score) AS 平均成绩
FROM sc, student AS s
WHERE sc.sno = s.sno
GROUP BY sc.sno, s.sno
HAVING 平均成绩 > 80;

------------------------------------------------------------------
--34、查询 数据库 分数 低于60的学生姓名和分数；
--思路：
--given answer
select c.sname, a.score
from sc a, course b, student c
where a.cno = b.cno and a.sno = c.sno
 and b.cname = '数据库' and score < 60;

--my answer
SELECT s.sname AS 姓名, score AS 分数
FROM sc, student AS s, course AS c
WHERE sc.sno = s.sno
AND sc.cno = c.cno
AND c.cname = '数据库'
AND score < 60;

------------------------------------------------------------------
--35、查询所有学生的选课情况；
--思路：联结
--given answer
SELECT sc.sno 学号,sname 姓名,cname 课程, sc.cno 课号
FROM sc,student,course 
WHERE sc.sno=student.sno and sc.cno=course.cno
ORDER BY sc.sno

--my answer
SELECT sc.sno AS 学生ID, s.sname AS 学生姓名, sc.cno AS 课程ID, c.cname AS 课程名
FROM sc, student AS s, course AS c
WHERE sc.sno = s.sno
AND sc.cno = c.cno
ORDER BY sc.sno;