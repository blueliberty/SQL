--46、查询全部学生都选修的课程的课程号和课程名；
--思路：GROUP BY + HAVING
--given answer
select course.cno, cname
from sc, course
where sc.cno = course.cno
group by course.cno, cname
having count(sc.cno) = (select count(1) from student);

--my answer
SELECT c.cno, c.cname
FROM sc, course c
WHERE sc.cno = c.cno
GROUP BY sc.cno
HAVING COUNT(sno) = (SELECT COUNT(*) FROM student);

------------------------------------------------------------------
--47、查询没学过“叶平”老师讲授的任一门课程的学生姓名；
--思路：反向思维，找出选修过'叶平'老师课程的学生
--given answer
select sno, sname from student
where sno not in(
    select sno from sc where cno in
    (select a.cno from course a, teacher b where a.tno = b.tno and b.tname = '叶平'));

--my answer
SELECT s.sno, s.sname
FROM student s
WHERE s.sno NOT IN (SELECT s.sno
				FROM sc, student s, course c, teacher t
				WHERE sc.sno = s.sno
				AND sc.cno = c.cno
				AND c.tno = t.tno
				AND t.tname = '叶平');

------------------------------------------------------------------
--48、查询两门以上不及格课程的同学的学号及其平均成绩；
--思路：先WHERE过滤再GROUP BY or CASE WHEN THEN ELSE END
--given answer
select sno 学号, avg(score) 平均分, count(1) 不及格课程数
from sc where score < 60 group by sno having count(1) > 2;

--my answer
SELECT sno 学号, AVG(score) 平均分, SUM(CASE WHEN score < 60 THEN 1 ELSE 0 END) 不及格课程数
FROM sc
GROUP BY sno
HAVING SUM(CASE WHEN score < 60 THEN 1 ELSE 0 END) > 2;

------------------------------------------------------------------
--49、检索4号课程分数大于60的同学学号，按分数降序排列；
--思路：WHERE + ORDER BY
--given answer
select sno, score from sc where cno = 4 and score > 60 order by score desc;

--my answer
SELECT sno, score
FROM sc
WHERE cno = 4
AND score > 60
ORDER BY score DESC;

------------------------------------------------------------------
--50、删除2号同学的课程1的成绩；
--思路：DELETE
--given answer
delete from sc where sno = 2 and cno = 1;

--my answer
DELETE FROM sc
WHERE sno = 2
AND cno = 1;