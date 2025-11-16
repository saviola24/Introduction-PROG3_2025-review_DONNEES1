
CREATE TABLE Team (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);


CREATE TABLE Employee (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    contract_type VARCHAR(50) NOT NULL,
    salary INT NOT NULL, 
    
    team_id INT NULL, 
    FOREIGN KEY (team_id) REFERENCES Team(id)
);


CREATE TABLE Leave (
    id INT AUTO_INCREMENT PRIMARY KEY,
    start_date DATE NOT NULL, 
    end_date DATE NOT NULL, 
    
    employee_id INT NOT NULL, 
    FOREIGN KEY (employee_id) REFERENCES Employee(id)
);

--REQUETE
--Employee sans equipe
SELECT id,first_name,last_name FROM Employee WHERE team_id IS NULL

--Employee sans congé
SELECT E.id,E.first_name,E.last_name FROM Employee as E LEFT JOIN Leave as L ON E.id = L.employee_id WHERE L.id IS NULL

--Afficher les congés de tel sorte qu’on voie l’id du congé, le début du congé, la fin du
congé, le nom & prénom de l’employé qui prend congé et le nom de son équipe.
SELECT L.id AS leave_id,L.start_date,L.end_date,E.first_name,E.last_name,T.name AS team_name FROM Leave AS L JOIN 
Employee AS E ON L.employee_id = E.id
LEFT JOIN Team AS T ON E.team_id = E.id;

--le nombre d’employés par contract_type, vous devez afficher le type de contrat, et le nombre d’employés associés.
SELECT
    contract_type
    COUNT(id) AS employee_count
FROM
    Employee
GROUP BY
    contract_type;

--le nombre d’employés en congé aujourd'hui. La période de congé s'étend de start_date inclus jusaqu'a end_date inclus
SELECT
    COUNT(DISTINCT employee_id) AS number_of_employee_on_leave
FROM
    Leave
WHERE
    CURRENT_DATE() BETWEEN start_date AND end_date

--l’id, le nom, le prénom de tous les employés + le nom de leur équipe qui sont en congé aujourd’hui. Pour rappel, la end_date est incluse dans le congé, l’employé ne revient que le lendemain
SELECT
    E.id,
    E.first_name,
    E.last_name,
    T.name AS team_name
FROM
    Employee AS E
JOIN
    Leave AS L ON E.id = L.employee_id
LEFT JOIN
    Team AS T ON E.team_id = T.id
WHERE
    CURRENT_DATE() BETWEEN L.start_date AND L.end_date;