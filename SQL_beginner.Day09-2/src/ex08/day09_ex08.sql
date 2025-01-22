CREATE OR REPLACE FUNCTION fnc_fibonacci(pstop integer DEFAULT 10)
RETURNS TABLE(fib_number bigint) AS $$
DECLARE
    a bigint := 0;
    b bigint := 1;
    next_num bigint;
BEGIN
    fib_number := a;
    RETURN NEXT;
    
    fib_number := b;
    RETURN NEXT;
    
    WHILE true LOOP
        next_num := a + b;
        EXIT WHEN next_num >= pstop;
        
        fib_number := next_num;
        RETURN NEXT;
        
        a := b;
        b := next_num;
    END LOOP;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM fnc_fibonacci(100);
SELECT * FROM fnc_fibonacci();
