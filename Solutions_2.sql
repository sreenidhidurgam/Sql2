---Problem 1 : Rank Scores(https://leetcode.com/problems/rank-scores/ )
select score, dense_rank()over(order by score desc) as rank
from scores
order by score desc

---Problem 2 : Exchange Seats	(https://leetcode.com/problems/exchange-seats/ )
SELECT 
    CASE
        WHEN MOD(id, 2) != 0 AND id != cnt THEN id + 1
        WHEN MOD(id, 2) != 0 AND id = cnt THEN id
        ELSE id - 1
    END AS id,
    student
FROM Seat,
    (SELECT COUNT(*) AS cnt FROM Seat) AS seat_counts
ORDER BY id;


---Problem 3 : Tree Node		(https://leetcode.com/problems/tree-node/ )

select id, 
case when p_id is null Then 'Root'
when id not in ( select distinct p_id from Tree where P_id is not null) then 'Leaf' Else 'Inner' 
end as type
from tree

---Problem 4 : Deparment Top 3 Salaries		(https://leetcode.com/problems/department-top-three-salaries/ )
WITH cte AS (
    SELECT 
        d.name AS Department,
        e.name AS Employee,
        e.salary AS Salary,
        DENSE_RANK() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) AS ranked
    FROM employee e
    LEFT JOIN department d ON d.id = e.departmentId
)
SELECT Department,Employee,Salary
FROM cte where ranked <= 3;
