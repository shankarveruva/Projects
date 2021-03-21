/* (i) The hospital has decided that it would like to be able to change the item_code for an ITEM, for
example, change KN056 for the "Right Knee Brace" to KNR56. Code a trigger which will support
this request. A message should be displayed to indicate the change has occurred successfully.*/

CREATE OR REPLACE TRIGGER item_code_update 
AFTER UPDATE OF item_code ON item 
FOR EACH ROW
BEGIN
    UPDATE item_treatment
    SET item_code = :NEW.item_code
    WHERE item_code = :OLD.item_code;
    
    dbms_output.put_line ('Item codes have been updated successfully in item_treatment table!');

END;
/

--Test trigger
SET SERVEROUTPUT ON
SET ECHO ON

----Prior state
SELECT * FROM item;
SELECT * FROM item_treatment;

--Update on item
UPDATE item 
SET item_code = 'KNR56' 
WHERE item_code = 'KN056';

--Post state
SELECT * FROM item;
SELECT * FROM item_treatment;

--Undo changes
ROLLBACK;
SET ECHO OFF;
SET SERVEROUTPUT OFF




/* (ii) Write a trigger which will prevent a patient's first and last names from being entered with both
names blank (null).*/

CREATE OR REPLACE TRIGGER patient_name_check 
BEFORE INSERT OR UPDATE ON patient
FOR EACH ROW
BEGIN
    IF :NEW.patient_fname IS NULL AND :NEW.patient_lname IS NULL 
    THEN
        raise_application_error(-20000, 'The first and the last name of a patient cannot be NULL!');
    END IF;
END;
/


--Test Trigger
SET SERVEROUTPUT ON
SET ECHO ON

--Insert first/last name as NULL into patient
INSERT INTO patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (10300, 'Sarah', NULL, '373 Glen Iris', to_date('30-Nov-1991','dd-Mon-yyyy'), '6547896542');
INSERT INTO patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (10400, NULL, NULL, '373 Glen Iris', to_date('29-Nov-1991','dd-Mon-yyyy'), '6547896542');

--Just to close a transaction or to reverse the test insert data (if successfuly inserted)
ROLLBACK;
SET ECHO OFF;
SET SERVEROUTPUT OFF



/* (iii) Write a trigger which will automatically adjust the stock level of an item when an item is
recorded as being used in an admission procedure. The items used in an admission procedure are
recorded immediately after the procedure has been completed. You may assume that the items
used in an admission procedure after being recorded in the system are not permitted to be deleted
or updated.*/

CREATE OR REPLACE TRIGGER item_stock_update 
AFTER INSERT ON item_treatment
FOR EACH ROW
DECLARE
    stock NUMBER(3);
BEGIN
    IF :NEW.it_qty_used > 0
    THEN
        SELECT item_stock INTO stock FROM item WHERE item_code = :NEW.item_code;
        
        IF :NEW.it_qty_used <= stock
        THEN
            UPDATE item
            SET item_stock = item_stock - :NEW.it_qty_used
            where item_code = :NEW.item_code;
        ELSE
            raise_application_error(-20000, 'Items used quantity should less than the items stock available!');
        END IF;
    ELSE
       raise_application_error(-20000, 'Items used quantity should be a positive integer only!'); 
    END IF;
END;
/

--Test trigger
SET SERVEROUTPUT ON
SET ECHO ON

--INSERT CASE
--Prior state
SELECT * FROM item;
SELECT * FROM item_treatment ORDER BY adprc_no;

--Inserting new record into adm_prc and item_treatment
INSERT INTO adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) VALUES (30040,to_date('20-May-2019 15:30','dd-Mon-yyyy hh24:mi'),75,10.35,100030,15510,1060,1060);
INSERT INTO item_treatment (adprc_no, item_code, it_qty_used, it_item_total_cost) VALUES (30040, 'NE001', 3, 3.45);

--After trigger is run
SELECT * FROM item;
SELECT * FROM item_treatment ORDER BY adprc_no;

--Inserting new wrong record into adm_prc and item_treatment
INSERT INTO adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) VALUES (30041,to_date('21-May-2019 15:30','dd-Mon-yyyy hh24:mi'),75,10.35,100030,15510,1060,1060);
INSERT INTO item_treatment (adprc_no, item_code, it_qty_used, it_item_total_cost) VALUES (30041, 'NE001', -1, 3.45);

--After trigger is run
SELECT * FROM item;
SELECT * FROM item_treatment ORDER BY adprc_no;

--Undo changes
ROLLBACK;
SET ECHO OFF;
SET SERVEROUTPUT OFF

