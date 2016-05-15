--21、查询不同老师所教不同课程平均分, 从高到低显示
--张老师 数据库 88；
--思路：
--given answer
select max(c.tname) as 教师, max(b.cname) 课程, avg(a.score) 平均分
from sc a, course b, teacher c
where a.cno = b.cno and b.tno = c.tno
group by a.cno
order by 平均分 desc;

--my answer
SELECT MAX(t.tname) AS 教师,
MAX(c.cname) AS 课程,
AVG(score) AS 平均分
FROM sc, course AS c, teacher AS t
WHERE sc.cno = c.cno
AND c.tno = t.tno
GROUP BY t.tno
ORDER BY 平均分 DESC;

------------------------------------------------------------------
--22、查询如下课程成绩均在第3名到第6名之间的学生的成绩：
--[学生ID],[学生姓名],企业管理,马克思,UML,数据库,平均成绩；
--思路：分组后的CASE + 子查询中使用limit + 注意要有嵌套和别名
--given answer
select max(a.sno) 学号, max(b.sname) 姓名,
max(case when cno = 1 then score end) as 企业管理,
max(case when cno = 2 then score end) as 马克思,
max(case when cno = 3 then score end) as UML,
max(case when cno = 4 then score end) as 数据库,
avg(score) as 平均分
from sc a, student b
where a.sno in (select sno from (select sno from sc where cno = 1 order by score desc limit 2, 4) as in1)
  and a.sno in (select sno from (select sno from sc where cno = 2 order by score desc limit 2, 4) as in2)
  and a.sno in (select sno from (select sno from sc where cno = 3 order by score desc limit 2, 4) as in3)
  and a.sno in (select sno from (select sno from sc where cno = 4 order by score desc limit 2, 4) as in4)
  and a.sno = b.sno
group by a.sno;

--my answer，这题没做出来，仿照正确答案写了自己的答案
SELECT MAX(sc.sno) AS 学生ID,
MAX(s.sname) AS 学生姓名,
MAX(CASE WHEN sc.cno = 1 THEN score END) AS 企业管理,
MAX(CASE WHEN sc.cno = 2 THEN score END) AS 马克思,
MAX(CASE WHEN sc.cno = 3 THEN score END) AS UML,
MAX(CASE WHEN sc.cno = 4 THEN score END) AS 数据库,
AVG(score) AS 平均成绩
FROM sc, student AS s
WHERE sc.sno = s.sno
AND sc.sno IN (SELECT sno FROM (SELECT sno FROM sc WHERE cno = 1 ORDER BY score DESC LIMIT 2, 4) AS in1)
AND sc.sno IN (SELECT sno FROM (SELECT sno FROM sc WHERE cno = 2 ORDER BY score DESC LIMIT 2, 4) AS in1)
AND sc.sno IN (SELECT sno FROM (SELECT sno FROM sc WHERE cno = 3 ORDER BY score DESC LIMIT 2, 4) AS in1)
AND sc.sno IN (SELECT sno FROM (SELECT sno FROM sc WHERE cno = 4 ORDER BY score DESC LIMIT 2, 4) AS in1)
GROUP BY sc.sno;

------------------------------------------------------------------
--23、统计打印各科成绩,各分数段人数:课程ID,课程名称,[100-85],[85-70],[70-60],[ <60]；
--思路：别名中如果有特殊符号，需要用''包起来
--given answer
select sc.cno as 课程ID, cname as 课程名称,
sum(case when score >= 85 then 1 else 0 end) as '[100-85]',
sum(case when score < 85 and score >= 70 then 1 else 0 end) as '[85-70]',
sum(case when score < 70 and score >= 60 then 1 else 0 end) as '[70-60]',
sum(case when score < 60 then 1 else 0 end) as '[ <60]'
from sc, course
where sc.cno = course.cno
group by sc.cno, cname;

--my answer
SELECT sc.cno AS 课程ID,
c.cname AS 课程名称,
SUM(CASE WHEN score >= 85 THEN 1 ELSE 0 END) AS '[100-85]',
SUM(CASE WHEN score < 85 AND score >= 70 THEN 1 ELSE 0 END) AS '[85-70]',
SUM(CASE WHEN score < 70 AND score >= 60 THEN 1 ELSE 0 END) AS '[70-60]',
SUM(CASE WHEN score < 60 THEN 1 ELSE 0 END) AS '[ <60]'
FROM sc, course AS c
WHERE sc.cno = c.cno
GROUP BY sc.cno;

------------------------------------------------------------------
--24、查询学生平均分及其名次；
--思路：用两个相同的表进行对比，以计算名次
--given answer
SELECT 1+(SELECT COUNT(DISTINCT 平均成绩)
		  FROM (SELECT sno, AVG(score) AS 平均成绩 FROM sc GROUP BY sno) AS T1
	      WHERE T1.平均成绩 > T2.平均成绩) AS 名次,
sno AS 学生学号, T2.平均成绩 AS 平均成绩
FROM (SELECT sno, AVG(score) AS 平均成绩 FROM sc GROUP BY sno) AS T2
ORDER BY 平均成绩 desc;

--my answer，这题没做出来，仿照正确答案写了自己的答案
SELECT 1+(SELECT COUNT(DISTINCT 平均成绩)
		  FROM (SELECT sno, AVG(score) AS 平均成绩 FROM sc GROUP BY sno) AS T1
	      WHERE T1.平均成绩 > T2.平均成绩) AS 名次,
sno AS 学生学号, T2.平均成绩 AS 平均成绩
FROM (SELECT sno, AVG(score) AS 平均成绩 FROM sc GROUP BY sno) AS T2
ORDER BY 平均成绩 desc;

------------------------------------------------------------------
--25、查询各科成绩前三名的记录:(不考虑成绩并列情况)；
--思路：WHERE子句，是对 “每一行” 分别进行计算，如果不符合条件则过滤掉
--given answer
SELECT a.cno, a.sno, a.score
FROM sc AS a
WHERE (SELECT COUNT(cno) FROM sc WHERE cno = a.cno AND a.score < score) <= 2
ORDER BY a.cno ASC, a.score DESC;

--my answer，这题没做出来，仿照正确答案写了自己的答案
SELECT a.cno, a.sno, a.score
FROM sc AS a
WHERE (SELECT COUNT(cno) FROM sc WHERE cno = a.cno AND a.score < score) <= 2
ORDER BY a.cno ASC, a.score DESC;