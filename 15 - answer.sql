--11、查询没有学全所有课的同学的学号、姓名；
--思路：NOT + 子查询
--given answer
select student.sno, student.sname
from student, sc
where student.sno = sc.sno
group by student.sno, student.sname
having count(sc.cno) < (select count(cno) from course);

--my answer
SELECT sno, sname
FROM student
WHERE sno NOT IN (SELECT sno
FROM sc, course AS c
WHERE sc.cno = c.cno
GROUP BY sc.sno
HAVING COUNT(sc.cno) = (SELECT COUNT(cno)
					    FROM course));

------------------------------------------------------------------
--12、查询至少有一门课程 与 学号为1的同学所学课程 相同的同学的学号和姓名；
--思路：联结 or 子查询
--given answer
select distinct a.sno, a.sname
from student a, sc b
where a.sno <> 1 and a.sno=b.sno and
b.cno in (select cno from sc where sno = 1);

--my answer
--子查询
SELECT sno, sname
FROM student
WHERE sno IN (SELECT DISTINCT sno
			  FROM sc
			  WHERE cno IN (SELECT cno
						    FROM sc
						    WHERE sno = 1))
AND sno != 1;

--联结
SELECT DISTINCT s.sno, s.sname
FROM sc, student AS s
WHERE sc.sno = s.sno
AND s.sno != 1
AND sc.cno IN (SELECT cno
			   FROM sc
			   WHERE sno = 1);

------------------------------------------------------------------
--13、把“sc”表中“刘老师”所教课的成绩都更改为此课程的平均成绩；
--思路：更改数据UPDATE + 子查询 + 注意：SET子句中的子查询必须来源于复制的表sc1
--given answer，网上的答案是错误的
update sc set score = (select avg(sc_2.score) from sc sc_2 where sc_2.cno=sc.cno)
from course,teacher where course.cno=sc.cno and course.tno=teacher.tno and teacher.tname='刘老师';

--my answer
--创建测试表sc1
CREATE TABLE sc1(
    sno int NOT NULL,
    cno int NOT NULL,
    score int NOT NULL
);

INSERT INTO sc1
SELECT *
FROM sc;

--更改数据
UPDATE sc
SET score = (SELECT AVG(score)
	 		 FROM sc1
		 	 GROUP BY sc1.cno
		 	 HAVING sc1.cno = (SELECT c.cno
					  		   FROM course AS c, teacher AS t
						       WHERE c.tno = t.tno
						       AND t.tname = '刘老师'))
WHERE cno IN (SELECT c.cno
			 FROM course AS c, teacher AS t
			 WHERE c.tno = t.tno
			 AND t.tname = '刘老师');

--恢复sc
TRUNCATE TABLE sc;

INSERT INTO sc
SELECT *
FROM sc1;

--删除sc1
DROP TABLE sc1;

------------------------------------------------------------------
--14、查询和2号同学学习的课程完全相同的其他同学学号和姓名；
--思路：课程完全相同 转化为 课程号的总和、均值完全相同 从而可以使用聚合函数
--given answer
select b.sno, b.sname
from sc a, student b
where b.sno <> 2 and a.sno = b.sno
group by b.sno, b.sname
having sum(cno) = (select sum(cno) from sc where sno = 2);

--my answer
SELECT s.sno, s.sname
FROM sc, student AS s
WHERE sc.sno = s.sno
AND sc.sno != 2
GROUP BY s.sno
HAVING SUM(sc.cno) = (SELECT SUM(cno)
					  FROM sc
					  WHERE sno = 2)
AND AVG(sc.cno) = (SELECT AVG(cno)
				   FROM sc
				   WHERE sno = 2);

------------------------------------------------------------------
--15、删除学习“叶平”老师课的sc表记录；
--思路：删除数据 + 子查询
--given answer，网上的答案是错误的
delete sc from course, teacher
where course.cno = sc.cno and course.tno = teacher.tno and tname = '叶平';

--my answer
--创建测试表sc1
CREATE TABLE sc1(
    sno int NOT NULL,
    cno int NOT NULL,
    score int NOT NULL
);

INSERT INTO sc1
SELECT *
FROM sc;

--删除数据
DELETE FROM sc
WHERE cno = (SELECT c.cno
             FROM course AS c, teacher AS t
             WHERE c.tno = t.tno
             AND t.tname = '叶平');

--恢复sc
TRUNCATE TABLE sc;

INSERT INTO sc
SELECT *
FROM sc1;

--删除sc1
DROP TABLE sc1;