--Найти информацию о всех контрактах, связанных с сотрудниками департамента «Logistic». Вывести: contract_id, employee_name

SELECT contract_id, e2.name FROM executor e
	JOIN contract c ON c.id = e.contract_id
	JOIN employees e2 ON e2.id = e.tab_no
	JOIN department d ON d.id = e2.department_id
WHERE d.name = 'Logistic'

--Найти среднюю стоимость контрактов, заключенных сотрудников Ivan Ivanov. Вывести: среднее значение amount

SELECT e2.name, AVG(c.amount) FROM executor e
	JOIN contract c ON c.id = e.contract_id
	JOIN employees e2 ON e2.id = e.tab_no
WHERE e2.name = 'Ivan Ivanov'

--Найти самую частовстречающуюся локации среди всех заказчиков. Вывести: location, count

SELECT location, COUNT(location) AS lcount FROM customer c
GROUP BY location
ORDER BY lcount
DESC
LIMIT 1

--Найти контракты одинаковой стоимости. Вывести count, amount

SELECT COUNT(amount) AS count, amount FROM contract c
GROUP BY amount
HAVING COUNT(DISTINCT c.id) >1

--Найти заказчика с наименьшей средней стоимостью контрактов. Вывести customer_name, среднее значение amount

SELECT c2.customer_name, AVG(c.amount) FROM contract c
	JOIN customer c2 ON c2.id = c.customer_id
GROUP BY c2.customer_name
HAVING AVG(c.amount)=
(
SELECT AVG(c.amount) FROM contract c
	JOIN customer c2 ON c2.id = c.customer_id
GROUP BY c2.customer_name
ORDER BY AVG(c.amount)
ASC
LIMIT 1
)

--Найти отдел, заключивший контрактов на наибольшую сумму. Вывести: department_name, sum

SELECT d.name, SUM(c.amount)  FROM executor e
	JOIN employees e2 ON e2.id = e.tab_no
	JOIN contract c ON c.id = e.contract_id
	JOIN department d ON d.id = e2.department_id
GROUP BY d.name
HAVING SUM(c.amount) = 	
(
SELECT SUM(c.amount)  FROM executor e
	JOIN employees e2 ON e2.id = e.tab_no
	JOIN contract c ON c.id = e.contract_id
	JOIN department d ON d.id = e2.department_id
GROUP BY d.name
ORDER BY SUM(c.amount)
DESC
LIMIT 1
)
