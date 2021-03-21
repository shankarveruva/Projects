-- AccountDetails Table
create table AccountDetails(
AcctID int not null,
AcctDesc varchar(80) not null
);

-- Add primary key to AccountDetails table
alter table AccountDetails
add constraint AccountDetails_PK primary key (AcctID);

-- EntityDetails table
create table EntityDetails(
EntID varchar(5) not null,
EntDesc varchar(80) not null
);

-- Add primary key to EntityDetails table
alter table EntityDetails
add constraint EntityDetails_PK primary key (EntID);

-- Logs table
create table Logs(
LogID int not null,
TimeStamp datetime not null,
UserName varchar(80),
UploadDesc varchar(80) not null
);

-- Add primary key to Logs table
alter table Logs
add constraint Logs_PK primary key (LogID);

-- Values table
create table [Values](
ID int not null,
AcctID int not null,
EntID varchar(5) not null,
LogID int not null,
Month varchar(6) not null,
Value int not null
);

-- Add primary key to Values table
alter table [Values]
add constraint Values_PK primary key (ID);

-- Add foreign key to Values table from AccountDetails table
alter table [Values]
add constraint AccountDetails_FK foreign key (AcctID)
references AccountDetails (AcctID);

-- Add foreign key to Values table from EntityDetails table
alter table [Values]
add constraint EntityDetails_FK foreign key (EntID)
references EntityDetails (EntID);

-- Add foreign key to Values table from Logs table
alter table [Values]
add constraint Logs_FK foreign key (LogID)
references Logs (LogID);


-- Insert into AccountDetails
insert into [dbo].[AccountDetails] values (10020,'Cash at bank');
insert into [dbo].[AccountDetails] values (20030,'Interest received');


-- Insert into EntityDetails
insert into [dbo].[EntityDetails] values ('B1','XYZ Division');
insert into [dbo].[EntityDetails] values ('C1','ABC Division');


-- Insert into Logs
insert into [dbo].[Logs] values (1,'20140803 12:33:00 PM','Joe Bloggs','Initial upload of July TB');
insert into [dbo].[Logs] values (2,'20140806 1:21:00 PM','','Initial upload of July TB');
insert into [dbo].[Logs] values (3,'20140807 10:00:00 AM','Joe Bloggs','Update - found an error!');


-- Insert into Values
insert into [dbo].[Values] values (1,10020,'B1',1,'Jul-14',10);
insert into [dbo].[Values] values (2,20030,'B1',1,'Jul-14',-10);
insert into [dbo].[Values] values (3,10020,'C1',2,'Jul-14',81);
insert into [dbo].[Values] values (4,20030,'C1',2,'Jul-14',-81);
insert into [dbo].[Values] values (5,10020,'B1',3,'Jul-14',12);
insert into [dbo].[Values] values (6,20030,'B1',3,'Jul-14',-12);


-- Checking if data is inserted properly in all the tables using select statement
select * from [dbo].[Values]
select * from [dbo].[AccountDetails]
select * from [dbo].[EntityDetails]
select * from [dbo].[Logs]


-- Q1. Draft an SQL query (in T-SQL) that would return all fields in the Values table and also pull in the Account, Entity and Upload descriptions.
select val.ID, val.AcctID, ad.AcctDesc, val.EntID, ed.EntDesc, val.LogID, l.UploadDesc, val.Month, val.Value from [dbo].[Values] val
left outer join [dbo].[AccountDetails] ad on val.AcctID = ad.AcctID
left outer join [dbo].[EntityDetails] ed on val.EntID = ed.EntID
left outer join [dbo].[Logs] l on val.LogID = l.LogID
order by val.AcctID;

-- Another way of writing above query
select val.*, ad.AcctDesc, ed.EntDesc, l.UploadDesc from [dbo].[Values] val
left outer join [dbo].[AccountDetails] ad on val.AcctID = ad.AcctID
left outer join [dbo].[EntityDetails] ed on val.EntID = ed.EntID
left outer join [dbo].[Logs] l on val.LogID = l.LogID
order by val.AcctID;


-- Q2. Describe how you would use the logs table to query the most recent data available in the database for each entity/account/month combination.
-- A. Firstly, I would join the Values and Logs table on LogID and then group by Account ID, Entity ID and Month. 
-- Then, I'll fetch the distinct fields of Account ID, Entity ID, Month and TimeStamp which is the latest. SQL query for the same is as below.
select distinct val.AcctID, val.EntID, val.Month, max(l.TimeStamp) as 'Latest TimeStamp'
from [dbo].[Values] val
left outer join [dbo].[Logs] l on val.LogID = l.LogID
group by val.AcctID, val.EntID, val.Month
order by val.AcctID;
