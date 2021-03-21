/* (i) The hospital is experiencing an issue where stocks of some items are allowed to get
unreasonably low and as a consequence cause admission procedures to be postponed due to
insufficient stock. The hospital administration would like to include a re-order level for items so that
when a stock item falls to this level it will be a warning to procurement staff that the item needs to
be re-ordered.
An analysis of the current stock levels for all items has resulted in a decision that this reorder stock
level for a particular item should be set initially for the current stock held at half the current stock of
the item. For example, the current stock level of SS006 "Stainless Steel Pins" is 100, the reorder
level for SS006 should thus be set at 50.
All new items added to the items table must be required to provide a re-order stock level.
Change the database to satisfy this requirement.*/

--Drop constraints of same name on this table
ALTER TABLE item
DROP CONSTRAINT stock_check;

-- Altered item table to add new column reorder_level, set it's data type as number (3 characters)
ALTER TABLE item 
ADD reorder_level NUMBER(3);

-- Updated the reorder_level for existing entries to item_stock/2
UPDATE item
SET reorder_level = TRUNC(item_stock/2);

-- Altered item table to modify column reorder_level by adding not null constraint and add a check constraint on reorder_level
ALTER TABLE item 
MODIFY reorder_level NUMBER(3) NOT NULL
ADD CONSTRAINT stock_check CHECK (reorder_level < item_stock);


/* (ii) Initially, the hospital administration was only interested in the lead doctor who performed an
admission procedure. A review of this approach has resulted in a request to change the database
so that, from this point forward, all doctors who perform an admission procedure will be recorded.
Some procedures, for example, an Angiogram may require a team of doctors.
The hospital wishes to record, for all the doctors involved, whether the doctor was the Lead doctor
(the doctor in charge) or an Ancillary doctor (a doctor assisting).
Prior admission procedures will be viewed as only having a Lead doctor based on the doctor who
is recorded as performing the admission procedure.
Change the database to satisfy this requirement. After making the change add a doctor to one of
your admission procedures as an Ancillary doctor.*/

-- Drop table if already exists
DROP TABLE adm_prc_doc CASCADE CONSTRAINTS;

-- Create table Admission Procedure Doctor
CREATE TABLE adm_prc_doc (
    adprc_no           NUMBER(7) NOT NULL,
    perform_dr_id      NUMBER(4) NOT NULL,
    doctor_role      VARCHAR2(9) NOT NULL
);

-- Comments on columns
COMMENT ON COLUMN adm_prc_doc.adprc_no IS
    'Admission procedure doctor identifier (PK)';

COMMENT ON COLUMN adm_prc_doc.perform_dr_id IS
    'Doctor id (PK)';
    
COMMENT ON COLUMN adm_prc_doc.doctor_role IS
    'Role of a doctor in a procedure';    

-- Altering the table to assign adprc_no as foreign key from adm_prc (adprc_no) table
ALTER TABLE adm_prc_doc
ADD CONSTRAINT adm_prc_adm_prc_doc FOREIGN KEY ( adprc_no )
REFERENCES adm_prc ( adprc_no );

-- Altering the table to assign perform_dr_id as foreign key from doctor (doctor_id) table        
ALTER TABLE adm_prc_doc
ADD CONSTRAINT doctor_adm_prc_doc FOREIGN KEY ( perform_dr_id )
REFERENCES doctor ( doctor_id );    

-- Altering the table to assign adprc_no, perform_dr_id as primary key
ALTER TABLE adm_prc_doc 
ADD CONSTRAINT adm_prc_doc_pk PRIMARY KEY (adprc_no,perform_dr_id);

-- Altering the table to add check constraint for doctor's role
ALTER TABLE adm_prc_doc 
ADD CONSTRAINT doc_role_check CHECK (doctor_role in ('Ancillary', 'Lead'));

-- Inserting existing data into adm_prc_doc
INSERT INTO adm_prc_doc (adprc_no, perform_dr_id, doctor_role) SELECT adprc_no, perform_dr_id, 'Lead' FROM adm_prc WHERE perform_dr_id IS NOT NULL;

-- Inserting a new doctor to existing adprc_no as Ancillary (role)
INSERT INTO adm_prc_doc (adprc_no, perform_dr_id, doctor_role) VALUES (30000, 1084, 'Ancillary');

-- Altering the table adm_prc to remove perform_dr_id as it's no more required
ALTER TABLE adm_prc
DROP COLUMN perform_dr_id;

