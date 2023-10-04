/*
���ν����� divisor_proc
���� �ϳ��� ���޹޾� �ش� ���� ����� ������ ����ϴ� ���ν����� �����մϴ�.
*/

CREATE OR REPLACE PROCEDURE divisor_proc (
    p_num IN NUMBER,
    p_count OUT NUMBER
)
IS
    v_count NUMBER := 0;
BEGIN
    FOR i IN 1..p_num
    LOOP
        IF MOD(p_num, i) = 0 THEN
            v_count := v_count + 1;
        END IF;    
    END LOOP;
    dbms_output.put_line(v_count);
    p_count := v_count;
END;

EXEC divisor_proc(72, ???);

DECLARE
    v_num NUMBER := 8;
    v_count NUMBER;
BEGIN
    divisor_proc(v_num, v_count);
    dbms_output.put_line(v_num || '�� ����� ����: ' || v_count);
END;

/*
�μ���ȣ, �μ���, �۾� flag(I: insert, U:update, D:delete)�� �Ű������� �޾� 
depts ���̺� 
���� INSERT, UPDATE, DELETE �ϴ� depts_proc �� �̸��� ���ν����� ������.
�׸��� ���������� commit, ���ܶ�� �ѹ� ó���ϵ��� ó���ϼ���.
*/

CREATE OR REPLACE PROCEDURE depts_proc(
    p_department_id IN depts.department_id%TYPE,
    p_department_name IN depts.department_name%TYPE,
    p_flag IN VARCHAR2
)
IS
        v_cnt NUMBER := 0;
BEGIN

    SELECT COUNT(*)
    INTO v_cnt
    FROM depts
    WHERE department_id = p_department_id;

    IF p_flag = 'I' THEN
        INSERT INTO depts (department_id, department_name)
        VALUES (p_department_id, p_department_name);
    ELSIF p_flag = 'U' THEN
        UPDATE depts SET
        department_name = p_department_name
        WHERE department_id = p_department_id;
    ELSIF p_flag = 'D' THEN
        IF v_cnt = 0 THEN
            dbms_output.put_line('�����ϰ��� �ϴ� �μ��� �������� �ʽ��ϴ�.');
            RETURN;
        END IF;
        
        DELETE FROM depts
        WHERE department_id = p_department_id;
    ELSE
        dbms_output.put_line('�ش� flag�� ���� ������ �غ���� �ʾҽ��ϴ�.');
    END IF;
    
    COMMIT;
    
    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('���ܰ� �߻��߽��ϴ�.');
            dbms_output.put_line('ERROR MSG: ' || SQLERRM);
            ROLLBACK;
END;

EXEC depts_proc(700, '������', 'D');
SELECT * FROM depts;


/*
employee_id�� �Է¹޾� employees�� �����ϸ�,
�ټӳ���� out�ϴ� ���ν����� �ۼ��ϼ���. (�͸��Ͽ��� ���ν����� ����)
���ٸ� exceptionó���ϼ���
*/

CREATE OR REPLACE PROCEDURE hire_out (
    v_employee_id IN NUMBER,
    v_hire_date OUT DATE
)
IS
    p_hire_date DATE;
BEGIN
        SELECT hire_date
        INTO p_hire_date
        FROM employees
        WHERE employee_id = v_employee_id;
    
    v_hire_date := p_hire_date;
    
    
END;

SELECT * FROM employees;
DECLARE
    v_hire_date DATE;
BEGIN
    hire_out(101, v_hire_date);
        dbms_output.put_line('�ټ� ���' || v_hire_date);

    EXCEPTION
        WHEN OTHERS THEN
            dbms_output.put_line('���ܹ߻�');
END;

/*
���ν����� - new_emp_proc
employees ���̺��� ���� ���̺� emps�� �����մϴ�.
employee_id, last_name, email, hire_date, job_id�� �Է¹޾�
�����ϸ� �̸�, �̸���, �Ի���, ������ update, 
���ٸ� insert�ϴ� merge���� �ۼ��ϼ���

������ �� Ÿ�� ���̺� -> emps
���ս�ų ������ -> ���ν����� ���޹��� employee_id�� dual�� select ������ ��.
���ν����� ���޹޾ƾ� �� ��: ���, last_name, email, hire_date, job_id
*/

CREATE TABLE emps AS (SELECT * FROM employees);

CREATE OR REPLACE PROCEDURE new_emp_proc
    (
        p_employee_id IN NUMBER,
        p_last_name IN VARCHAR2,
        p_email IN VARCHAR2,
        p_hire_date IN DATE,
        p_job_id IN NUMBER
    )
IS
BEGIN
    
    MERGE INTO emps e
        USING (SELECT p_employee_id AS employee_id FROM dual) p
        ON (p.employee_id = e.employee_id)
WHEN MATCHED THEN        
    UPDATE SET e.last_name = p_last_name,
            e.email = p_email,
            e.hire_date = p_hire_date,
            e.job_id = p_job_id
WHEN NOT MATCHED THEN
    INSERT (e.last_name, e.email, e.hire_date, e.job_id) 
        VALUES(p_last_name, p_email, p_hire_date, p_job_id);
        
END;

EXEC new_emp_proc(120, '��fds��', 'fds����', sysdate, 20);
SELECT * FROM emps;

