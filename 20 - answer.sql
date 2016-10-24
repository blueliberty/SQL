--16、向sc表中插入一些记录，这些记录要求符合以下条件：
--将没有课程3成绩同学的该成绩补齐, 其成绩取所有学生的课程2的平均成绩；
--思路：INSERT SELECT + SELECT中可以有常数
--given answer
INSERT sc select sno, 3, (select avg(score) from sc where cno = 2)
from student
where sno not in (select sno from sc where cno = 3);

--my answer，这题没做出来，仿照正确答案写了自己的答案
INSERT INTO sc
SELECT sno, 3, (SELECT AVG(score)
				FROM sc
				WHERE cno = 2)
FROM student
WHERE sno NOT IN (SELECT sno
				  FROM sc
				  WHERE cno = 3);

------------------------------------------------------------------
--17、按平均分从高到低显示所有学生的如下统计报表：
--学号,企业管理,马克思,UML,数据库,物理,课程数,平均分；
--思路：CASE WHEN THEN ELSE END 的用法，在分组后，要提取每个组中的特定值（非聚合值）时用到 + CASE对分组中每一列都会运算，所以注意加上MAX，否则会输出NULL
--given answer
SELECT sno as 学号
,max(case when cno = 1 then score end) AS 企业管理
,max(case when cno = 2 then score end) AS 马克思
,max(case when cno = 3 then score end) AS UML
,max(case when cno = 4 then score end) AS 数据库
,max(case when cno = 5 then score end) AS 物理
,count(cno) AS 课程数
,avg(score) AS 平均分
FROM sc
GROUP by sno
ORDER by avg(score) DESC;

--my answer，这题没做出来，仿照正确答案写了自己的答案
SELECT sno AS 学号,
MAX(CASE WHEN cno = 1 THEN score END) AS 企业管理,
MAX(CASE WHEN cno = 2 THEN score END) AS 马克思,
MAX(CASE WHEN cno = 3 THEN score END) AS UML,
MAX(CASE WHEN cno = 4 THEN score END) AS 数据库,
MAX(CASE WHEN cno = 5 THEN score END) AS 物理,
COUNT(cno) AS 课程数,
AVG(score) AS 平均分
FROM sc
GROUP BY sno
ORDER BY AVG(score) DESC;

------------------------------------------------------------------
--18、查询各科成绩最高分和最低分：以如下形式显示：课程号，最高分，最低分；
--思路：用AS来命名列名
--given answer
select cno as 课程号, max(score) as 最高分, min(score) 最低分
from sc group by cno;

--my answer
SELECT cno AS 课程号, MAX(score) AS 最高分, MIN(score) AS 最低分
FROM sc
GROUP BY cno;

------------------------------------------------------------------
--19、查询课程号、课程名、各科平均成绩、及格率，按各科平均成绩从低到高和及格率的百分数从高到低顺序；
--思路：IFNULL的用法(IFNULL在这里可以省略) + 分组后计算及格率的方法 + 分组的SELECT要用聚合函数 + 同时升序和降序的语法
--given answer
SELECT max(t.cno) AS 课程号,
max(course.cname) AS 课程名,
ifnull(AVG(score),0) AS 平均成绩,
100 * SUM(CASE WHEN ifnull(score,0)>=60 THEN 1 ELSE 0 END)/count(score) AS 及格率
FROM sc t, course
where t.cno = course.cno
GROUP BY t.cno
ORDER BY 平均成绩 asc, 及格率 desc;

--my answer，这题没做出来，仿照正确答案写了自己的答案
SELECT MAX(c.cno) AS 课程号,
MAX(c.cname) AS 课程名,
IFNULL(AVG(score), 0) AS 平均成绩,
100 * SUM(CASE WHEN IFNULL(score, 0) >= 60 THEN 1 ELSE 0 END) / COUNT(score) AS 及格率
FROM sc, course AS c
WHERE sc.cno = c.cno
GROUP BY c.cno
ORDER BY 平均成绩 ASC, 及格率 DESC;

------------------------------------------------------------------
--20、查询如下课程平均成绩和及格率的百分数(用"1行"显示): 企业管理（001），马克思（002），UML （003），数据库（004）；
--思路：CASE WHEN AND THEN ELSE END 实现分组；比前面的例子多了AND
--given answer
select 
avg(case when cno = 1 then score end) as 平均分1,
avg(case when cno = 2 then score end) as 平均分2,
avg(case when cno = 3 then score end) as 平均分3,
avg(case when cno = 4 then score end) as 平均分4,
100 * sum(case when cno = 1 and score > 60 then 1 else 0 end) / sum(case when cno = 1 then 1 else 0 end) as 及格率1,
100 * sum(case when cno = 2 and score > 60 then 1 else 0 end) / sum(case when cno = 2 then 1 else 0 end) as 及格率2,
100 * sum(case when cno = 3 and score > 60 then 1 else 0 end) / sum(case when cno = 3 then 1 else 0 end) as 及格率3,
100 * sum(case when cno = 4 and score > 60 then 1 else 0 end) / sum(case when cno = 4 then 1 else 0 end) as 及格率4
from sc

--my answer，这题没做出来，仿照正确答案写了自己的答案
SELECT
AVG(CASE WHEN cno = 1 THEN score END) AS 平均成绩1,
AVG(CASE WHEN cno = 2 THEN score END) AS 平均成绩2,
AVG(CASE WHEN cno = 3 THEN score END) AS 平均成绩3,
AVG(CASE WHEN cno = 4 THEN score END) AS 平均成绩4,
100 * SUM(CASE WHEN cno = 1 AND score >= 60 THEN 1 ELSE 0 END) / SUM(CASE WHEN cno = 1 THEN 1 ELSE 0 END) AS 及格率1,
100 * SUM(CASE WHEN cno = 2 AND score >= 60 THEN 1 ELSE 0 END) / SUM(CASE WHEN cno = 2 THEN 1 ELSE 0 END) AS 及格率2,
100 * SUM(CASE WHEN cno = 3 AND score >= 60 THEN 1 ELSE 0 END) / SUM(CASE WHEN cno = 3 THEN 1 ELSE 0 END) AS 及格率3,
100 * SUM(CASE WHEN cno = 4 AND score >= 60 THEN 1 ELSE 0 END) / SUM(CASE WHEN cno = 4 THEN 1 ELSE 0 END) AS 及格率4
FROM sc;