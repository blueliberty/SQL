--xx.查询成绩最好的课程；
--思路：
--given answer


--my answer
SELECT sc.cno 课程号, c.cname 课程名称, AVG(score) 平均分
FROM sc, course c
WHERE sc.cno = c.cno
GROUP BY sc.cno
ORDER BY AVG(score) DESC
LIMIT 1;

------------------------------------------------------------------
--xx.查询最受欢迎的老师(选修学生最多的老师)；
--思路：
--given answer


--my answer
SELECT t.tname 老师, c.cname 课程名, COUNT(sno) 选课人数
FROM sc, course c, teacher t
WHERE sc.cno = c.cno
AND c.tno = t.tno
GROUP BY sc.cno
ORDER BY COUNT(sno) DESC
LIMIT 1;

------------------------------------------------------------------
--xx.查询教学质量最好的老师；
--思路：
--given answer


--my answer
SELECT t.tname 老师, c.cname 课程名称, AVG(score) 平均分
FROM sc, course c, teacher t
WHERE sc.cno = c.cno
AND c.tno = t.tno
GROUP BY sc.cno
ORDER BY AVG(score) DESC
LIMIT 1;

------------------------------------------------------------------
--xx.查询需要补考的各科学生清单；
--思路：
--given answer


--my answer
SELECT c.cname 课程, s.sno 学生ID, s.sname 学生名, score 成绩
FROM sc, course c, student s
WHERE sc.cno = c.cno
AND sc.sno = s.sno
AND score < 60
ORDER BY 课程, 学生ID;