/* 
   Comments to your marker: 
   Inserted 20 records into patient
   Inserted 34 records into admission
   Inserted 39 records into adm_prc
   Inserted 19 records into item_treatment
   
*/


--Patient Insert Script

insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50000,'Alyse','Seakin','3 Fulton Street',to_date('14-Jul-2009','dd-Mon-yyyy'),'6741411470');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50001,'Josie','Nizard','2560 Scofield Way',to_date('04-Oct-2012','dd-Mon-yyyy'),'9729250802');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50002,'Nikos','Russel','98741 Scott Park',to_date('24-Jan-1998','dd-Mon-yyyy'),'4008230338');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50003,'Donall','Brotherick','3 Sundown Terrace',to_date('14-Jul-1994','dd-Mon-yyyy'),'5018886956');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50004,'Mirella','Kennelly','66499 Duke Junction',to_date('04-Sep-2000','dd-Mon-yyyy'),'4808813935');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50005,'Sybila','Lemar','99019 Westend Place',to_date('20-Feb-2004','dd-Mon-yyyy'),'8659416001');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50006,'Andi','Weeds','922 Eggendart Avenue',to_date('30-Jun-1995','dd-Mon-yyyy'),'7617066743');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50007,'Pernell','Theriot','803 Dakota Parkway',to_date('04-Dec-1985','dd-Mon-yyyy'),'8149870682');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50008,'Bartlett','Stendall','16262 Pierstorff Plaza',to_date('09-Jun-2009','dd-Mon-yyyy'),'4768553683');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50009,'Piper','Corn','50712 Schiller Junction',to_date('23-Jun-1988','dd-Mon-yyyy'),'4683026201');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50010,'Pearce','Jizhaki','17 Calypso Point',to_date('29-Oct-1988','dd-Mon-yyyy'),'8122627693');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50011,'Crystal','Miners','6947 Hallows Road',to_date('08-Nov-1988','dd-Mon-yyyy'),'4296605681');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50012,'Terencio','Degenhardt','2175 Bunting Junction',to_date('02-Feb-2005','dd-Mon-yyyy'),'3892077746');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50013,'Thornton','Lees','84007 Westerfield Parkway',to_date('08-May-1980','dd-Mon-yyyy'),'3352428371');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50014,'Aldridge','Elleton','54 Charing Cross Street',to_date('13-Apr-2000','dd-Mon-yyyy'),'4397531697');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50015,'Hana','Boatwright','55 Sauthoff Road',to_date('16-Aug-2010','dd-Mon-yyyy'),'3153873955');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50016,'Johannah','Coom','5 Orin Court',to_date('29-Apr-1993','dd-Mon-yyyy'),'2303472694');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50017,'Keir','Lawtie','38104 Westend Circle',to_date('25-Aug-1997','dd-Mon-yyyy'),'8973336823');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50018,'Tomasina','Matoshin','058 Ludington Center',to_date('13-Mar-2002','dd-Mon-yyyy'),'3079058663');
insert into patient (patient_id, patient_fname, patient_lname, patient_address, patient_dob, patient_contact_phn) values (50019,'Scot','Dye','21 Cardinal Pass',to_date('31-Dec-2012','dd-Mon-yyyy'),'2072986785');




--Admission Insert Script

insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100001, to_date('04-Jan-2019 17:37','dd-Mon-yyyy hh24:mi'), to_date('10-Jan-2019 10:12','dd-Mon-yyyy hh24:mi'),50000,1012);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100002, to_date('10-Jan-2019 12:41','dd-Mon-yyyy hh24:mi'), to_date('21-Jan-2019 09:23','dd-Mon-yyyy hh24:mi'),50001,1005);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100003, to_date('15-Jan-2019 09:16','dd-Mon-yyyy hh24:mi'), to_date('10-Feb-2019 22:45','dd-Mon-yyyy hh24:mi'),50002,1056);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100004, to_date('22-Jan-2019 12:36','dd-Mon-yyyy hh24:mi'), to_date('13-Feb-2019 23:00','dd-Mon-yyyy hh24:mi'),50003,1048);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100005, to_date('26-Jan-2019 15:11','dd-Mon-yyyy hh24:mi'), to_date('31-Jan-2019 21:04','dd-Mon-yyyy hh24:mi'),50004,1084);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100006, to_date('01-Feb-2019 03:14','dd-Mon-yyyy hh24:mi'), to_date('14-May-2019 13:13','dd-Mon-yyyy hh24:mi'),50005,1069);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100007, to_date('05-Feb-2019 12:05','dd-Mon-yyyy hh24:mi'), to_date('09-Apr-2019 14:42','dd-Mon-yyyy hh24:mi'),50006,7900);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100008, to_date('13-Feb-2019 15:46','dd-Mon-yyyy hh24:mi'), to_date('19-Mar-2019 08:52','dd-Mon-yyyy hh24:mi'),50007,7890);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100009, to_date('21-Feb-2019 09:23','dd-Mon-yyyy hh24:mi'), to_date('16-Mar-2019 12:34','dd-Mon-yyyy hh24:mi'),50008,1095);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100010, to_date('27-Feb-2019 09:05','dd-Mon-yyyy hh24:mi'), to_date('03-May-2019 15:30','dd-Mon-yyyy hh24:mi'),50009,1028);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100011, to_date('28-Feb-2019 12:40','dd-Mon-yyyy hh24:mi'), to_date('16-Mar-2019 16:43','dd-Mon-yyyy hh24:mi'),50010,1298);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100012, to_date('08-Mar-2019 07:17','dd-Mon-yyyy hh24:mi'), to_date('22-Mar-2019 18:24','dd-Mon-yyyy hh24:mi'),50011,1005);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100013, to_date('11-Mar-2019 08:00','dd-Mon-yyyy hh24:mi'), to_date('15-Apr-2019 07:56','dd-Mon-yyyy hh24:mi'),50012,1018);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100014, to_date('14-Mar-2019 13:01','dd-Mon-yyyy hh24:mi'), to_date('07-Apr-2019 19:21','dd-Mon-yyyy hh24:mi'),50013,1033);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100015, to_date('14-Mar-2019 23:56','dd-Mon-yyyy hh24:mi'), to_date('16-Apr-2019 20:00','dd-Mon-yyyy hh24:mi'),50014,1027);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100016, to_date('26-Mar-2019 11:36','dd-Mon-yyyy hh24:mi'), to_date('30-Mar-2019 09:09','dd-Mon-yyyy hh24:mi'),50015,1012);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100017, to_date('27-Mar-2019 13:52','dd-Mon-yyyy hh24:mi'), to_date('13-May-2019 13:28','dd-Mon-yyyy hh24:mi'),50016,7900);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100018, to_date('28-Mar-2019 17:23','dd-Mon-yyyy hh24:mi'), to_date('10-Apr-2019 12:19','dd-Mon-yyyy hh24:mi'),50017,1095);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100019, to_date('29-Mar-2019 10:00','dd-Mon-yyyy hh24:mi'), to_date('31-Mar-2019 17:22','dd-Mon-yyyy hh24:mi'),50018,2459);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100020, to_date('31-Mar-2019 18:08','dd-Mon-yyyy hh24:mi'), to_date('14-May-2019 19:49','dd-Mon-yyyy hh24:mi'),50019,1048);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100021, to_date('07-Apr-2019 19:00','dd-Mon-yyyy hh24:mi'), to_date('02-May-2019 11:10','dd-Mon-yyyy hh24:mi'),50012,1084);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100022, to_date('12-Apr-2019 10:45','dd-Mon-yyyy hh24:mi'), to_date('01-May-2019 11:02','dd-Mon-yyyy hh24:mi'),50003,1060);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100023, to_date('18-Apr-2019 14:40','dd-Mon-yyyy hh24:mi'), to_date('30-Apr-2019 13:09','dd-Mon-yyyy hh24:mi'),50014,1012);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100024, to_date('25-Apr-2019 12:00','dd-Mon-yyyy hh24:mi'), NULL,50001,7900);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100025, to_date('26-Apr-2019 13:30','dd-Mon-yyyy hh24:mi'), to_date('13-May-2019 22:06','dd-Mon-yyyy hh24:mi'),50000,1048);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100026, to_date('29-Apr-2019 09:13','dd-Mon-yyyy hh24:mi'), NULL,50008,1027);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100027, to_date('03-May-2019 14:12','dd-Mon-yyyy hh24:mi'), NULL,50010,1061);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100028, to_date('10-May-2019 15:30','dd-Mon-yyyy hh24:mi'), to_date('13-May-2019 23:45','dd-Mon-yyyy hh24:mi'),50013,1064);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100029, to_date('13-May-2019 22:02','dd-Mon-yyyy hh24:mi'), NULL,50007,1033);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100030, to_date('19-May-2019 20:00','dd-Mon-yyyy hh24:mi'), NULL,50004,1027);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100031, to_date('19-May-2019 20:00','dd-Mon-yyyy hh24:mi'), to_date('19-May-2019 22:00','dd-Mon-yyyy hh24:mi'),50014,1027);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100032, to_date('19-May-2019 22:00','dd-Mon-yyyy hh24:mi'), to_date('19-May-2019 23:00','dd-Mon-yyyy hh24:mi'),50014,1027);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100033, to_date('20-May-2019 08:00','dd-Mon-yyyy hh24:mi'), to_date('20-May-2019 13:00','dd-Mon-yyyy hh24:mi'),50013,1027);
insert into admission (adm_no, adm_date_time, adm_discharge, patient_id, doctor_id) values (100034, to_date('20-May-2019 18:00','dd-Mon-yyyy hh24:mi'), to_date('20-May-2019 23:00','dd-Mon-yyyy hh24:mi'),50013,1027);

--Admission Procedure Insert Script

insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30000,to_date('05-Jan-2019 17:37','dd-Mon-yyyy hh24:mi'),30,3.98,100001,40100,1028,1028);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30001,to_date('11-Jan-2019 15:30','dd-Mon-yyyy hh24:mi'),75,0,100002,15510,1060,1060);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30002,to_date('20-Jan-2019 09:16','dd-Mon-yyyy hh24:mi'),200,365.48,100003,15511,1048,1048);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30003,to_date('15-Jan-2019 17:41','dd-Mon-yyyy hh24:mi'),350,123,100002,49518,2459,2459);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30004,to_date('26-Jan-2019 19:19','dd-Mon-yyyy hh24:mi'),109.28,0,100005,29844,1060,1060);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30005,to_date('20-Mar-2019 03:14','dd-Mon-yyyy hh24:mi'),244,0,100006,54132,1095,1095);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30006,to_date('14-Feb-2019 15:40','dd-Mon-yyyy hh24:mi'),68,0,100008,19887,1060,1060);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30007,to_date('07-Feb-2019 12:05','dd-Mon-yyyy hh24:mi'),70.45,0,100007,33335,1060,1060);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30008,to_date('24-Feb-2019 09:12','dd-Mon-yyyy hh24:mi'),40,0,100009,40099,1012,NULL);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30009,to_date('02-Apr-2019 10:08','dd-Mon-yyyy hh24:mi'),33.5,364.66,100010,40100,1028,1028);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30010,to_date('01-Mar-2019 12:40','dd-Mon-yyyy hh24:mi'),33.5,4.76,100011,40100,1028,1028);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30011,to_date('11-Mar-2019 08:34','dd-Mon-yyyy hh24:mi'),30,0,100012,65554,1061,1061);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30012,to_date('12-Mar-2019 09:00','dd-Mon-yyyy hh24:mi'),70.45,0,100013,33335,1060,1060);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30013,to_date('15-Mar-2019 19:27','dd-Mon-yyyy hh24:mi'),76,4.28,100012,32266,1027,1027);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30014,to_date('06-Apr-2019 13:01','dd-Mon-yyyy hh24:mi'),250,0,100014,12055,1056,1056);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30015,to_date('28-Mar-2019 19:56','dd-Mon-yyyy hh24:mi'),120.66,0,100015,43114,1005,1005);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30016,to_date('27-Mar-2019 11:36','dd-Mon-yyyy hh24:mi'),70.45,0,100016,33335,1060,NULL);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30017,to_date('01-Apr-2019 13:52','dd-Mon-yyyy hh24:mi'),300,365.48,100017,54132,1095,1095);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30018,to_date('30-Mar-2019 10:00','dd-Mon-yyyy hh24:mi'),200,0,100019,15511,1048,1048);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30019,to_date('05-Apr-2019 17:23','dd-Mon-yyyy hh24:mi'),244,4.28,100018,54132,1095,1095);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30020,to_date('29-Mar-2019 11:36','dd-Mon-yyyy hh24:mi'),500,0,100016,17122,1056,1056);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30021,to_date('20-Apr-2019 18:08','dd-Mon-yyyy hh24:mi'),109.28,0,100020,29844,1060,1060);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30022,to_date('09-Apr-2019 07:30','dd-Mon-yyyy hh24:mi'),30,17.12,100021,65554,1061,1061);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30023,to_date('19-Apr-2019 11:00','dd-Mon-yyyy hh24:mi'),76,0,100021,32266,1027,1027);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30024,to_date('10-May-2019 18:08','dd-Mon-yyyy hh24:mi'),30,4.28,100020,65554,1061,1061);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30025,to_date('12-May-2019 18:08','dd-Mon-yyyy hh24:mi'),80,182.33,100020,32266,1027,1027);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30026,to_date('21-Apr-2019 10:45','dd-Mon-yyyy hh24:mi'),75,0,100022,15510,1060,NULL);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30027,to_date('30-Apr-2019 10:45','dd-Mon-yyyy hh24:mi'),350,3.98,100022,49518,2459,2459);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30028,to_date('19-Apr-2019 14:40','dd-Mon-yyyy hh24:mi'),76,0,100023,32266,1027,1027);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30029,to_date('15-May-2019 13:00','dd-Mon-yyyy hh24:mi'),225,215.1,100024,12055,1056,1056);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30030,to_date('22-Apr-2019 14:40','dd-Mon-yyyy hh24:mi'),399,3.98,100023,43112,1060,1060);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30031,to_date('10-May-2019 09:13','dd-Mon-yyyy hh24:mi'),40,4.28,100026,40099,1012,NULL);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30032,to_date('27-Apr-2019 13:30','dd-Mon-yyyy hh24:mi'),244,3.98,100025,54132,1095,1095);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30033,to_date('16-May-2019 09:13','dd-Mon-yyyy hh24:mi'),33.5,0,100026,40100,1028,1028);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30034,to_date('18-May-2019 14:12','dd-Mon-yyyy hh24:mi'),70.45,3.98,100027,33335,1060,1060);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30035,to_date('11-May-2019 15:30','dd-Mon-yyyy hh24:mi'),75,0,100028,15510,1060,1060);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30036,to_date('20-May-2019 14:12','dd-Mon-yyyy hh24:mi'),633,1096.44,100027,27459,1060,1060);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30037,to_date('12-May-2019 15:30','dd-Mon-yyyy hh24:mi'),75,45.3,100028,15509,1048,1048);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30038,to_date('14-May-2019 20:02','dd-Mon-yyyy hh24:mi'),355,0,100029,43111,1005,1005);
insert into adm_prc (adprc_no, adprc_date_time, adprc_pat_cost, adprc_items_cost, adm_no, proc_code, request_dr_id, perform_dr_id) values (30039,to_date('22-Apr-2019 19:00','dd-Mon-yyyy hh24:mi'),110,81.2,100021,43114,1005,1005);





--Item Treatment Script

insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30000, 'CE010',1,3.98);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30002, 'BI500',1,365.48);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30010, 'PS318',1,4.76);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30009, 'AN002',2,364.66);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30013, 'OV001',1,4.28);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30019, 'OV001',1,4.28);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30027, 'CE010',1,3.98);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30022, 'OV001',4,17.12);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30024, 'OV001',1,4.28);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30030, 'CE001',1,3.98);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30031, 'OV001',1,4.28);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30017, 'BI500',1,365.48);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30036, 'BI500',3,1096.44);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30029, 'LB250',1,215.1);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30032, 'CE001',1,3.98);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30025, 'AN002',1,182.33);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30034, 'CE001',1,3.98);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30039, 'AP050',1,81.2);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30003, 'KN056',1,123);
insert into item_treatment (adprc_no, item_code, it_qty_used,it_item_total_cost) values (30037, 'SS006',3,45.3);


commit;