--36、查询成绩在70分以上的学生姓名、课程名称和分数；
--思路：联结
--given answer
select 
s.sname,
c.cname,
(s1.score) as '分数'
from student s,sc s1,course c
where s.sno=s1.sno  and c.cno=s1.cno and s1.score>70;

--my answer
SELECT s.sname AS 学生姓名, c.cname AS 课程名, sc.score AS 分数
FROM sc, student AS s, course AS c
WHERE sc.sno = s.sno
AND sc.cno = c.cno
AND score > 70;

------------------------------------------------------------------
--37、查询不及格的课程，并按课程号从大到小排列；
--思路：联结 + 排序
--given answer
select 
sc.cno
,c.cname
,sc.score
from sc ,course c
where sc.score<60 and c.cno=sc.cno
order by sc.cno desc;

--my answer
SELECT sc.cno AS 课程号, s.sname AS 学生姓名, c.cname AS 课程名, sc.score AS 分数
FROM sc, student AS s, course AS c
WHERE sc.sno = s.sno
AND sc.cno = c.cno
AND score < 60
ORDER BY sc.cno DESC;

------------------------------------------------------------------
--38、查询课程编号为3且课程成绩在80分以上的学生的学号和姓名；
--思路：
--given answer
select sc.sno,student.sname from sc,student where sc.sno=student.sno and score>80 and cno=3;

--my answer
SELECT sc.sno, s.sname
FROM sc, student AS s
WHERE sc.sno = s.sno
AND cno = 3
AND score > 80;

------------------------------------------------------------------
--39、求选了课程的学生人数；
--思路：DISTINCT 的用法
--given answer
select count(distinct sno) from sc;

--my answer
SELECT COUNT(DISTINCT sno) AS 人数
FROM sc;

------------------------------------------------------------------
--40、查询选修“叶平”老师所授课程的学生中，成绩最高的学生姓名及其成绩；
--思路：LIMIT 1 选取最大值
--given answer
select student.sname,cname, score 
from student,sc,course C,teacher 
where student.sno=sc.sno and sc.cno=C.cno and C.tno=teacher.tno
and teacher.tname ='叶平'
and sc.score=(select max(score) from sc where cno = C.cno);

--my answer
SELECT s.sname AS 学生姓名, 	c.cname AS 课程, sc.score AS 成绩
FROM sc, student s, course c, teacher t
WHERE sc.sno = s.sno
AND sc.cno = c.cno
AND c.tno = t.tno
AND t.tname = '叶平'
ORDER BY score DESC
LIMIT 1;