--LeetCode Database
--182. Duplicate Emails
--思路：找出重复值，用分组的方法

SELECT Email
FROM Person
GROUP BY Email
HAVING COUNT(Email) > 1;