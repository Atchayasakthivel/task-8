-- Step 1: Create table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10, 2),
    department VARCHAR(50)
);

-- Step 2: Insert sample data
INSERT INTO employees VALUES 
(1, 'Alice', 60000, 'HR'),
(2, 'Bob', 45000, 'IT'),
(3, 'Charlie', 52000, 'Finance'),
(4, 'David', 30000, 'Sales'),
(5, 'Eva', 75000, 'IT');

-- Step 3: Create procedure to update salary conditionally
DELIMITER $$

CREATE PROCEDURE UpdateSalary(IN empId INT, IN newSalary DECIMAL(10,2))
BEGIN
    DECLARE currentSalary DECIMAL(10,2);

    SELECT salary INTO currentSalary FROM employees WHERE emp_id = empId;

    IF newSalary > currentSalary THEN
        UPDATE employees SET salary = newSalary WHERE emp_id = empId;
        SELECT CONCAT('Salary updated to ', newSalary) AS message;
    ELSE
        SELECT 'New salary must be higher' AS message;
    END IF;
END $$

DELIMITER ;

-- Step 4: Create function to get bonus
DELIMITER $$

CREATE FUNCTION GetBonus(salary DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE bonus DECIMAL(10,2);

    IF salary > 50000 THEN
        SET bonus = salary * 0.20;
    ELSE
        SET bonus = salary * 0.10;
    END IF;

    RETURN bonus;
END $$

DELIMITER ;
