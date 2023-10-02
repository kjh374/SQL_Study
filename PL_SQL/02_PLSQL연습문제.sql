
-- 1. employees ���̺��� 201�� ����� �̸��� �̸��� �ּҸ� ����ϴ�
-- �͸����� ����� ����. (������ ��Ƽ� ����ϼ���.)

DECLARE
    v_emp_name employees.first_name%TYPE;
    v_emp_email employees.email%TYPE;
BEGIN
    
    SELECT
        first_name, email
    INTO 
        v_emp_name, v_emp_email
    FROM employees
    WHERE employee_id = 201;
    
    DBMS_OUTPUT.put_line(v_emp_name || ':' || v_emp_email);
END;

SELECT * FROM employees;
-- 2. employees ���̺��� �����ȣ�� ���� ū ����� ã�Ƴ� �� (MAX �Լ� ���)
-- �� ��ȣ + 1������ �Ʒ��� ����� emps ���̺�
-- employee_id, last_name, email, hire_date, job_id�� �ű� �����ϴ� �͸� ����� ���弼��.
-- SELECT�� ���Ŀ� INSERT�� ����� �����մϴ�.
/*
<�����>: steven
<�̸���>: stevenjobs
<�Ի�����>: ���ó�¥
<JOB_ID>: CEO
*/

DECLARE
    v_emp_employee_id employees.employee_id%TYPE; 
    v_emp_last_name employees.last_name%TYPE := 'steven';
    v_emp_email employees.email%TYPE := 'stevenjobs';
    v_emp_hire_date employees.hire_date%TYPE := sysdate;
    v_emp_job_id employees.job_id%TYPE := 'CEO';
BEGIN
        SELECT
            MAX(employee_id) 
        INTO v_emp_employee_id    
        FROM employees;
    
        INSERT INTO emps (employee_id, last_name, email, hire_date, job_id) 
        VALUES(v_emp_employee_id + emps_seq.NEXTVAL, v_emp_last_name, v_emp_email, v_emp_hire_date, v_emp_job_id);
    
END;

SELECT * FROM emps
WHERE last_name = 'steven';

DELETE FROM emps
WHERE last_name = 'steven';



ROLLBACK;

CREATE SEQUENCE emps_seq
    START WITH 1
    INCREMENT BY 1
    MINVALUE 1
    NOCACHE
    NOCYCLE;
    
ALTER SEQUENCE emps_seq INCREMENT BY -3;
SELECT emps_seq.NEXTVAL FROM dual;
ALTER SEQUENCE emps_seq INCREMENT BY 1;

DROP SEQUENCE emps_seq;