
/*
���� 1.
-1.1 EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� �����͸� ��� �ϼ��� 
(AVG(�÷�) ���)
-1.2 EMPLOYEES ���̺��� ��� ������� ��ձ޿����� ���� ������� ���� ����ϼ���
-1.3 EMPLOYEES ���̺��� job_id�� IT_PROG�� ������� ��ձ޿����� ���� ������� 
�����͸� ����ϼ���
*/

SELECT 
    *
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees);
                
SELECT 
    COUNT(*) AS ����� 
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees);

SELECT *
FROM employees 
WHERE salary > (SELECT AVG(salary) FROM employees
                WHERE job_id = 'IT_PROG');

/*
���� 2.
-DEPARTMENTS���̺��� manager_id�� 100�� �μ��� �����ִ� ������� 
��� ������ ����ϼ���.
*/

SELECT *
FROM employees
WHERE department_id = (SELECT department_id
                        FROM departments d
                        WHERE manager_id = 100);

/*
���� 3.
-3.1 EMPLOYEES���̺��� ��Pat���� manager_id���� ���� manager_id�� ���� ��� ����� �����͸� 
����ϼ���
-3.2 EMPLOYEES���̺��� ��James��(2��)���� manager_id�� ���� ��� ����� �����͸� ����ϼ���.
*/

SELECT * FROM employees 
WHERE manager_id > (SELECT manager_id FROM employees
                    WHERE first_name = 'Pat');

SELECT * FROM employees
WHERE manager_id IN (SELECT manager_id FROM employees
                    WHERE first_name = 'James');
                    
/*
���� 4.
-EMPLOYEES���̺��� first_name�������� �������� �����ϰ�, 41~50��° �������� 
�� ��ȣ, �̸��� ����ϼ���
*/
SELECT *
FROM (
      SELECT ROWNUM AS rn, first_name AS �̸�
      FROM (
            SELECT *
            FROM employees
            ORDER BY first_name DESC
      )
)    
WHERE rn BETWEEN 41 AND 50;        


/*
���� 5.
-EMPLOYEES���̺��� hire_date�������� �������� �����ϰ�, 31~40��° �������� 
�� ��ȣ, ���id, �̸�, ��ȭ��ȣ, �Ի����� ����ϼ���.
*/

SELECT *
FROM (
      SELECT ROWNUM AS rn, employee_id, first_name, phone_number, hire_date
      FROM (
            SELECT *
            FROM employees
            ORDER BY hire_date
      )
)
WHERE rn > 30 AND rn <= 40;    

/*
���� 6.
employees���̺� departments���̺��� left �����ϼ���
����) �������̵�, �̸�(��, �̸�), �μ����̵�, �μ��� �� ����մϴ�.
����) �������̵� ���� �������� ����
*/

SELECT e.employee_id, CONCAT(e.first_name, e.last_name) AS �̸�, d.department_id, d.department_name
FROM employees e 
LEFT JOIN departments d
ON e.department_id = d.department_id
ORDER BY employee_id;

/*
���� 7.
���� 6�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/

SELECT 
    employee_id, 
    CONCAT(first_name, last_name) AS �̸�, 
    department_id, 
    (SELECT department_name FROM departments d
     WHERE e.department_id = d.department_id) AS �μ���
FROM employees e
ORDER BY employee_id;
/*
���� 8.
departments���̺� locations���̺��� left �����ϼ���
����) �μ����̵�, �μ��̸�, �Ŵ������̵�, �����̼Ǿ��̵�, ��Ʈ��_��巹��, ����Ʈ �ڵ�, ��Ƽ �� ����մϴ�
����) �μ����̵� ���� �������� ����
*/

SELECT 
    d.department_id, d.department_name, d.manager_id, 
    loc.location_id, loc.street_address, loc.postal_code, loc.city
FROM departments d
LEFT JOIN locations loc
ON d.location_id = loc.location_id
ORDER BY department_id ;

/*
���� 9.
���� 8�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/

SELECT department_id, department_name, manager_id, 
        (SELECT street_address FROM locations loc
        WHERE d.location_id = loc.location_id) AS street_address,
        (SELECT postal_code FROM locations loc
        WHERE d.location_id = loc.location_id) AS postal_code,
        (SELECT city FROM locations loc
        WHERE d.location_id = loc.location_id) AS city
FROM departments d
ORDER BY department_id;
/*
���� 10.
locations���̺� countries ���̺��� left �����ϼ���
����) �����̼Ǿ��̵�, �ּ�, ��Ƽ, country_id, country_name �� ����մϴ�
����) country_name���� �������� ����
*/

SELECT loc.location_id, loc.street_address, loc.city, c.country_id, c.country_name
FROM locations loc
LEFT JOIN countries c
ON loc.country_id = c.country_id
ORDER BY c.country_name;

/*
���� 11.
���� 10�� ����� (��Į�� ����)�� �����ϰ� ��ȸ�ϼ���
*/

SELECT location_id, street_address, city, 
    (SELECT country_id FROM countries c
    WHERE loc.country_id = c.country_id) AS country_id,
    (SELECT country_name FROM countries c
    WHERE loc.country_id = c.country_id) AS country_name
FROM locations loc
ORDER BY country_name;
