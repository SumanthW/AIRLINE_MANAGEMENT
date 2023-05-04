--STORED PROCEDURES
/

CREATE OR REPLACE PROCEDURE ADD_NEW_AIRLINE 
( p_NAME varchar2,
  p_INITIAL_HUB varchar2
) AS
    v_AIRPORT number;
    v_AIRLINE_NAME varchar2(20);
BEGIN
    
    BEGIN
        SELECT id INTO v_AIRPORT from AIRPORT where CODE = p_INITIAL_HUB;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.put_line('Oops! AIRPORT CODE IS INVALID FOR INITIAL HUB');
            rollback;
    END;
    BEGIN
        SELECT NAME INTO v_AIRLINE_NAME from AIRLINE where NAME = p_INITIAL_HUB;
        DBMS_OUTPUT.put_line('Oops! AIRLINE NAME ALREADY EXISTS. TRY ANOTHER ONE!');
        rollback;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            BEGIN
                INSERT INTO AIRLINE(NAME,id) values (p_NAME, airline_id_seq.nextval);
                INSERT INTO Account(id, Balance, airline_id) values(account_id_seq.nextval, 2000000,airline_id_seq.currval);
                INSERT INTO FUEL(id,CAP,AVL,airline_id) values (fuel_id_seq.nextval, 3000000,3000000,airline_id_seq.currval);
                INSERT INTO CO2(id,CAP,AVL,airline_id) values (co2_id_seq.nextval, 3000000,3000000,airline_id_seq.currval);
                INSERT INTO HANGAR(id,port_id,airline_id,AC_CAPACITY,AC_OCCUPIED) values (hangar_id_seq.nextval,v_AIRPORT,airline_id_seq.currval,20,0);
                INSERT INTO HUB(id,port_id,airline_id) values (hangar_id_seq.nextval,v_AIRPORT,airline_id_seq.currval);
                commit;
            EXCEPTION
                WHEN OTHERS THEN
                rollback;
            END;
    END;
END ADD_NEW_AIRLINE;
/

CREATE OR REPLACE PROCEDURE PURCHASE_AIRCRAFT()
AS
BEGIN
END PURCHASE_AIRCRAFT;
/


CREATE OR REPLACE PROCEDURE PURCHASE_FUEL()
AS
BEGIN
END PURCHASE_FUEL;
/


CREATE OR REPLACE PROCEDURE PURCHASE_CO2()
AS
BEGIN
END PURCHASE_CO2;
/


CREATE OR REPLACE PROCEDURE PURCHASE_HANGAR_SPOTS()
AS
BEGIN
END PURCHASE_HANGAR_SPOTS;
/

CREATE OR REPLACE PROCEDURE SET_TRIP()
AS
BEGIN
END SET_TRIP;
/

CREATE OR REPLACE PROCEDURE ADVERTISE_AIRLINE()
AS
BEGIN
END ADVERTISE_AIRLINE;
/

CREATE OR REPLACE PROCEDURE RECALL_AC()
AS
BEGIN
END RECALL_AC;
/

CREATE OR REPLACE PROCEDURE DEPART_AC()
AS
BEGIN
END DEPART_AC;
/

CREATE OR REPLACE PROCEDURE SET_FUEL_PRICE
AS
    v_UPPER_LIMIT number;
    v_LOWER_LIMIT number;
BEGIN
    v_UPPER_LIMIT := 2500;
    v_LOWER_LIMIT := 250;
    
    INSERT INTO FUEL_PRICE values (trunc(dbms_random.value(1,100)*(v_UPPER_LIMIT/100)+v_LOWER_LIMIT),systimestamp AT TIME ZONE 'AMERICA/NEW_YORK');
    DELETE FROM FUEL_PRICE where AT_TIME < systimestamp AT TIME ZONE 'AMERICA/NEW_YORK' - 1;
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('Oops! Some fault with generation!');
        ROLLBACK;
END SET_FUEL_PRICE;
/

CREATE OR REPLACE PROCEDURE SET_CO2_PRICE
AS
    v_UPPER_LIMIT number;
    v_LOWER_LIMIT number;
BEGIN
    v_UPPER_LIMIT := 300;
    v_LOWER_LIMIT := 100;
    
    INSERT INTO CO2_PRICE values (trunc(dbms_random.value(1,100)*(v_UPPER_LIMIT/100)+v_LOWER_LIMIT),systimestamp AT TIME ZONE 'AMERICA/NEW_YORK');
    DELETE FROM CO2_PRICE where AT_TIME < systimestamp AT TIME ZONE 'AMERICA/NEW_YORK' - 1;
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.put_line('Oops! Some fault with generation!');
        ROLLBACK;
END SET_CO2_PRICE;
/
