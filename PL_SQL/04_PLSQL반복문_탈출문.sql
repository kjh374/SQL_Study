
-- WHILE��

DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1; --begin
BEGIN
    WHILE v_count <= 10 --end
    LOOP 
        v_num := v_num + v_count;
        v_count := v_count + 1; --step
    END LOOP;        
    
    dbms_output.put_line(v_num);

END;


-- Ż�⹮
DECLARE
    v_num NUMBER := 0;
    v_count NUMBER := 1; --begin
BEGIN
    WHILE v_count <= 10 --end
    LOOP 
        EXIT WHEN v_count = 5;
        
        v_num := v_num + v_count;
        v_count := v_count + 1; --step
    END LOOP;        
    
    dbms_output.put_line(v_num);

END;

-- FOR��
DECLARE
    v_num NUMBER := 4;
BEGIN
   
    FOR i IN 1..9 -- .�� �� �� �ۼ��ؼ� ������ ǥ��.
    LOOP
        dbms_output.put_line(v_num || 'x' || i || ' = ' || v_num*i);     
    END LOOP;
END;

-- CONTINUE��
DECLARE
    v_num NUMBER := 3;
BEGIN
   
    FOR i IN 1..9 -- .�� �� �� �ۼ��ؼ� ������ ǥ��.
    LOOP
        CONTINUE WHEN i = 5;
        dbms_output.put_line(v_num || 'x' || i || ' = ' || v_num*i);     
    END LOOP;
END;

-- 1. ��� �������� ����ϴ� �͸� ����� ���弼��. (2 ~ 9��)
-- ¦���ܸ� ����� �ּ���. (2, 4, 6, 8)
-- ����� ����Ŭ ������ �߿��� �������� �˾Ƴ��� �����ڰ� �����. (% ����~)

DECLARE
    v_num NUMBER := 1;
    
BEGIN
    FOR i IN 2..9
    LOOP
        IF MOD(i, 2) = 0  THEN
            dbms_output.put_line('������' || i || '��');
        FOR j IN 1..9
        LOOP
            -- CONTINUE WHEN MOD(i, 2) = 1;
            dbms_output.put_line(i || 'x' || j || '=' || i*j);
        END LOOP;
        dbms_output.put_line('--------------------------------------------------');
        END IF;
    END LOOP;    
END;



-- 2. INSERT�� 300�� �����ϴ� �͸� ����� ó���ϼ���.
-- board��� �̸��� ���̺��� ���弼��. (bno, writer, title �÷��� �����մϴ�.)
-- bno�� SEQUENCE�� �÷� �ֽð�, writer�� title�� ��ȣ�� �ٿ��� INSERT ������ �ּ���.
-- ex) 1, test1, title1 -> 2 test2 title2 -> 3 test3 title3 ....
CREATE TABLE board (
    bno NUMBER PRIMARY KEY,
    writer VARCHAR2(30),
    title VARCHAR2(30)
);

ALTER TABLE board
MODIFY (bno NUMBER);
    
DROP TABLE board; 

CREATE SEQUENCE board_seq 
    START WITH 1
    INCREMENT BY 1
    MAXVALUE 300
    NOCACHE
    NOCYCLE; 
    
DROP SEQUENCE board_seq;   
    
BEGIN
    FOR i IN 1..300
    LOOP
        INSERT INTO board 
        VALUES (board_seq.NEXTVAL, 'writer' || i, 'title' || i);
    END LOOP;
END;

SELECT * FROM board;