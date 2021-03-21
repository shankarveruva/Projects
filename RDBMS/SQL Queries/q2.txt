/* (i) List the doctor title, first name, last name and contact phone number for all doctors who
specialise in the area of "ORTHOPEDIC SURGERY" (this is the specialisation description). Order
the list by the doctors' last name and within this, if two doctors have the same last name, order
them by their respective first names.*/

SELECT 
    doctor_title, 
    doctor_fname, 
    doctor_lname,
    doctor_phone 
FROM 
    doctor WHERE doctor_id IN 
    (SELECT doctor_id FROM doctor_speciality 
    WHERE doctor_speciality.spec_code = (SELECT spec_code FROM speciality WHERE UPPER(speciality.spec_description)='ORTHOPEDIC SURGERY'))
ORDER BY doctor_lname,doctor_fname;



/* (ii) List the item code, item description, item stock and the cost centre title which provides these
items for all items which have a stock greater than 50 items and include the word 'disposable' in
their item description. Order the output by the item code.*/

SELECT 
    item_code, 
    item_description, 
    item_stock, 
    costcentre.cc_title 
FROM 
    item JOIN costcentre ON item.cc_code = costcentre.cc_code
WHERE item.item_stock > 50 
and UPPER(item.item_description) like '%DISPOSABLE%'
ORDER BY item.item_code;


    
/* (iii) List the patient id, patient's full name as a single column called 'Patient Name', admission date
and time and the supervising doctor's full name (including title) as a single column called 'Doctor
Name' for all those patients admitted on the 14th March 2019. Your output must include at least
two admissions on this date which occurred at different times. Order the output by the admission
time with the earliest admission first.*/

SELECT 
    p.patient_id, 
    (p.patient_fname || ' ' || p.patient_lname) AS "Patient Name", 
    to_char(a.adm_date_time, 'dd-Mon-yyyy hh24:mi') AS "ADMDATETIME", 
    (d.doctor_title || ' ' || d.doctor_fname || ' ' || d.doctor_lname) AS "Doctor Name" 
FROM 
    patient p JOIN admission a ON p.patient_id = a.patient_id
JOIN doctor d ON a.doctor_id = d.doctor_id
WHERE to_char(a.adm_date_time,'dd-Mon-yyyy') = '14-Mar-2019'
ORDER BY a.adm_date_time;



/* (iv) List the procedure code, name, description, and standard cost where the procedure is less
expensive than the average procedure standard cost. The output must show the most expensive
procedure first. The procedure standard cost must be displayed with two decimal points and a
leading $ symbol, for example as $120.54*/

SELECT 
    proc_code, 
    proc_name, 
    proc_description, 
    ('$' || TO_CHAR(proc_std_cost, '999.99')) AS "standard cost" 
FROM 
    procedure
WHERE proc_std_cost < (SELECT AVG(proc_std_cost) FROM procedure)
ORDER BY proc_std_cost DESC;



 
/* (v) List the patient id, first name, last name, date of birth and the number of times the patient has
been admitted to the hospital where the number of admissions is greater than 2. The output should
show patients with the most number of admissions first and for patients with the same number of
admissions, show the patients in their date of birth order. Your output must include at least two
patients with the same number of admissions.*/

SELECT 
    p.patient_id, 
    patient_fname, 
    patient_lname, 
    TO_CHAR(p.patient_dob, 'dd-Mon-yyyy') AS "DOB", 
    COUNT(a.patient_id) as "NUMBERADMISSIONS"
FROM 
    patient p JOIN admission a ON p.patient_id = a.patient_id
GROUP BY p.patient_id, patient_fname, patient_lname, to_char(p.patient_dob, 'dd-Mon-yyyy')
HAVING COUNT(a.patient_id) > 2
ORDER BY COUNT(a.patient_id) DESC, to_char(p.patient_dob, 'dd-Mon-yyyy');


    
/* (vi) List the admission number, patient id, first name, last name and the length of their stay in the
hospital for all patients who have been discharged and who were in the hospital longer than the
average stay for all discharged patients. The length of stay must be shown in the form 10 days 2.0
hrs where hours are rounded to one decimal digit.*/

--rounding off prob
SELECT 
    a.adm_no,
    p.patient_id, 
    patient_fname, 
    patient_lname,
    (trunc(adm_discharge - adm_date_time) || ' days ') ||
    to_char(mod(adm_discharge-adm_date_time, 1)*24,'99.9') || ' hrs ' AS "STATYLENGTH"
FROM 
    patient p
JOIN admission a ON p.patient_id = a.patient_id
WHERE round(adm_discharge-adm_date_time,2) > (SELECT AVG(round(adm_discharge-adm_date_time,2)) FROM admission);


--working fine
SELECT 
    a.adm_no,
    p.patient_id, 
    patient_fname, 
    patient_lname,
    (TRUNC(adm_discharge - adm_date_time) || ' days ' || 
    to_char(((round(adm_discharge-adm_date_time,2) - floor(round(adm_discharge-adm_date_time,2)))*(24)),'99.9') || ' hrs') AS "STATYLENGTH"
FROM 
    patient p
JOIN admission a ON p.patient_id = a.patient_id
WHERE adm_discharge-adm_date_time > (SELECT AVG(adm_discharge-adm_date_time) FROM admission);





    
/* (vii) Given a doctor may charge more or less than the standard charge for a procedure carried out
during an admission procedure, the hospital administration is interested in finding out what
variations on the standard price have been charged. The hospital terms the difference between the
procedure standard cost and the average actual charged procedure cost which has been charged
to patients for all such procedures which have been carried out as the "Procedure Price
Differential". For all procedures which have been carried out on an admission determine the
procedure price differential. The list should show the procedure code, name, description, standard
time and the procedure price differential in procedure code order.*/

SELECT 
    p.proc_code, 
    proc_name, 
    proc_description, 
    proc_time, 
    to_char((p.proc_std_cost - tmp.avg),'90.9') AS "Price Differential"
FROM 
    procedure p
JOIN (SELECT proc_code, AVG(adprc_pat_cost) AS avg FROM adm_prc GROUP BY proc_code) tmp
ON p.proc_code = tmp.proc_code
WHERE p.proc_std_cost != tmp.avg
ORDER BY p.proc_code;






    
/* (viii) List for every procedure, the items which have been used and the maximum number of those
items used when the procedure was carried on an admission. Your list must show the procedure
code, procedure name, item code and item description and the maximum quantity of this item used
for the given procedure.
For example, Vascular Surgery may require one standard anaesthetic pack, and then a number of
Bupivacaine injections; sometimes one has been used sometimes two*/

SELECT 
    a.proc_code, 
    p.proc_name, 
    NVL(it.item_code,'---') AS "ITEM_CODE", 
    NVL(i.item_description,'---') AS "ITEM_DESCRIPTION", 
    NVL(to_char(MAX(it.it_qty_used)),'---') AS "MAX_QTY_USED"
FROM adm_prc a
LEFT OUTER JOIN PROCEDURE p ON a.proc_code = p.proc_code
LEFT OUTER JOIN item_treatment it ON a.adprc_no = it.adprc_no
LEFT OUTER JOIN item i ON i.item_code = it.item_code
GROUP BY a.proc_code, p.proc_name, it.item_code, i.item_description;