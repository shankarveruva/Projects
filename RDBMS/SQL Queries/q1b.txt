/* (i) Create a set of sequences which will allow you to enter data into the PATIENT, ADMISSION and
ADM_PRC tables - all such sequences must start at 200000 and go up in steps of 10 (ie. the first
value is 200000, the next 200010 etc)*/

DROP SEQUENCE pat_seq_no;
DROP SEQUENCE adm_seq_no;
DROP SEQUENCE admproc_seq_no;

CREATE SEQUENCE pat_seq_no
    START WITH 200000
    INCREMENT BY 10;

CREATE SEQUENCE adm_seq_no
    START WITH 200000
    INCREMENT BY 10;
    
CREATE SEQUENCE admproc_seq_no
    START WITH 200000
    INCREMENT BY 10;





/* (ii) Peter Xiue who lives at "14 Narrow Lane Caulfield" was admitted on the 16th May 2019 at 10
AM as a new patient. He was born on the 1st October 1981 and has a contact phone number of
0123456789. His supervising doctor will be Dr Sawyer HAISELL (you may assume that this
doctor's name is unique). Peter has not been discharged as yet. Add Peter to the Monash Hospital
system.*/

INSERT INTO patient 
    (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) 
VALUES 
    (pat_seq_no.NEXTVAL,'Peter','Xiue','14 Narrow Lane Caulfield',TO_DATE('01-Oct-1981','dd-Mon-yyyy'),'0123456789');

INSERT INTO admission 
    (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) 
VALUES 
    (adm_seq_no.NEXTVAL, TO_DATE('16-May-2019 10:00','dd-Mon-yyyy hh24:mi'), NULL, pat_seq_no.CURRVAL, 
    (SELECT doctor_id FROM doctor WHERE UPPER(doctor_title)='DR' AND UPPER(DOCTOR_FNAME)='SAWYER' AND UPPER(DOCTOR_LNAME)='HAISELL'));




/* (iii) Dr Decca BLANKHORN has changed her "Thoracic surgery" specialisation to "Vascular
surgery" (you may assume that this doctors name is unique). In making this change you may not
use insert or delete.*/

UPDATE doctor_speciality
SET 
    spec_code = (SELECT spec_code from speciality where upper(spec_description) = 'VASCULAR SURGERY')
WHERE 
    doctor_id = (SELECT doctor_id from doctor WHERE UPPER(doctor_title)='DR' AND UPPER(DOCTOR_FNAME)='DECCA' 
    AND UPPER(DOCTOR_LNAME)='BLANKHORN' AND spec_code = (SELECT spec_code from speciality where upper(spec_description) = 'THORACIC SURGERY'));


      
/* (iv) Following several legal challenges, the hospital has decided that they no longer wish to support the "Medical genetics" specialisation
and want it removed from the areas in which a doctor can
indicate a specialisation. In arriving at your solution remember you are not permitted to alter the
supplied schema in any form, including using an alter statement on the created tables.*/

DELETE FROM doctor_speciality 
WHERE spec_code = (SELECT spec_code from speciality where UPPER(spec_description) = 'MEDICAL GENETICS');

DELETE FROM speciality 
WHERE UPPER(spec_description) = 'MEDICAL GENETICS';



commit;