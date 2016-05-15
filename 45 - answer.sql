--41、查询各个课程及相应的选修人数；
--思路：联结 + 分组
--given answer
select cno 课程号, count(1) 选修人数 from sc group by cno;

--my answer
SELECT sc.cno 课程号, c.cname 课程名称, COUNT(sno) 选修人数
FROM sc, course c
WHERE sc.cno = c.cno
GROUP BY sc.cno, c.cno;

------------------------------------------------------------------
--42、查询不同课程成绩相同的学生的学号、课程号、学生成绩；
--思路：表与复制表进行比较
--given answer
select distinct A.sno, A.cno,B.score
from sc A ,sc B
where A.Score=B.Score and A.cno <>B.cno
order by B.score;

--my answer
SELECT sc.sno, sc.cno, sc.score
FROM sc, sc s
WHERE sc.score = s.score
AND sc.sno != s.sno
AND sc.cno != s.cno;


------------------------------------------------------------------
--43、查询每门课程成绩最好的前两名的学生ID；
--思路：表与复制表进行比较，以得到名次，同24、25题
--given answer，网上的答案是MS SQL，不支持MySQL

--my answer
SELECT a.cno, a.sno, a.score
FROM sc AS a
WHERE (SELECT COUNT(cno) FROM sc WHERE cno = a.cno AND a.score < score) <= 1
ORDER BY a.cno ASC, a.score DESC;

------------------------------------------------------------------
--44、统计每门课程的学生选修人数(至少有2人选修的课程才统计)。要求输出课程号和选修人数，
--查询结果按人数降序排列，若人数相同，按课程号升序排列；
--思路：GROUP BY + HAVING + ORDER BY
--given answer
select cno as 课程号,count(1) as 人数 
from sc 
group by cno having count(1) > 1
order by count(1) desc,cno;

--my answer
SELECT cno, COUNT(cno)
FROM sc
GROUP BY cno
HAVING COUNT(cno) >= 2
ORDER BY COUNT(cno) DESC, cno ASC;

------------------------------------------------------------------
--45、检索至少选修了5门课程的学生学号；
--思路：GROUP BY + HAVING
--given answer
select sno from sc group by sno having count(1) >= 5;

--my answer
SELECT sno
FROM sc
GROUP BY sno
HAVING COUNT(cno) >= 5;