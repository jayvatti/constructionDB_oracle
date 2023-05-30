
CREATE TABLE CONTRACTORS (
  ContractorID NUMBER(4) PRIMARY KEY,
  FirstName VARCHAR(32) NOT NULL,
  LastName VARCHAR(32) NOT NULL,
  Email VARCHAR(128) UNIQUE,
  PhoneNumber VARCHAR(12) UNIQUE,
  Company VARCHAR(64),
  CONSTRAINT CONTRACTORS_PHONENUMBER CHECK (REGEXP_LIKE(PhoneNumber, '^\d{3}-\d{3}-\d{4}$')) --#17
);

create sequence ContractorID increment by 1 start with 1000;

INSERT INTO CONTRACTORS VALUES 
(ContractorID.NEXTVAL, 'Jane', 'Smith', 'jane.smith@buildwellinc.com', '212-555-1262', 'Buildwell Inc.');

INSERT INTO CONTRACTORS VALUES 
(ContractorID.NEXTVAL, 'Bob', 'Johnson', 'bob.johnson@premierconstructionco.com', '415-155-6712', 'Premier Construction Co.');

INSERT INTO CONTRACTORS VALUES 
(ContractorID.NEXTVAL, 'Maria', 'Garcia', 'maria.garcia@oceanviewbuilders.com', '305-655-1882', 'Oceanview Builders');

INSERT INTO CONTRACTORS VALUES 
(ContractorID.NEXTVAL, 'David', 'Lee', 'david.lee@structuralsolutionsinc.com', '312-555-1312', 'Structural Solutions Inc.');

INSERT INTO CONTRACTORS 
VALUES (ContractorID.NEXTVAL, 'Karen', 'Nguyen', 'karen.nguyen@buildingblocksco.com', '206-355-1212', 'Building Blocks Co.');

INSERT INTO CONTRACTORS VALUES 
(ContractorID.NEXTVAL, 'Tom', 'Wilson', 'tom.wilson@skyscraperbuilders.com', '219-535-1292', 'Skyscraper Builders');

INSERT INTO CONTRACTORS VALUES 
(ContractorID.NEXTVAL, 'Chris', 'Davis', 'chris.davis@pinnaclecontractors.com', '310-555-9812', 'Pinnacle Contractors');

--  --------------------------------------------------------------------------------
CREATE TABLE MANAGERS AS --#16
SELECT FirstName, LastName, Email, PhoneNumber
FROM CONTRACTORS
WHERE 1=2;

ALTER TABLE MANAGERS ADD YearsOfExperience NUMBER(2) NOT NULL;
ALTER TABLE MANAGERS ADD ManagerID NUMBER(4) PRIMARY KEY;
ALTER TABLE MANAGERS ADD CONSTRAINT MANAGERS_PHONENUMBER CHECK (REGEXP_LIKE(PhoneNumber, '^\d{3}-\d{3}-\d{4}$'));

create sequence ManagerID increment by 1 start with 1000;

INSERT INTO MANAGERS (ManagerID, FirstName, LastName, Email, PhoneNumber, YEARSOFEXPERIENCE) VALUES 
(ManagerID.NEXTVAL, 'John', 'Smith', 'john.smith@gmail.com','123-456-7890', 10);

INSERT INTO MANAGERS (ManagerID, FirstName, LastName, Email, PhoneNumber, YEARSOFEXPERIENCE) VALUES 
(ManagerID.NEXTVAL, 'Emily', 'Davis', 'emily.davis@gmail.com','234-567-8901', 5);

INSERT INTO MANAGERS (ManagerID, FirstName, LastName, Email, PhoneNumber, YEARSOFEXPERIENCE) VALUES 
(ManagerID.NEXTVAL, 'Jessica', 'Lee', 'jessica.lee@gmail.com', '345-678-9012', 8);

INSERT INTO MANAGERS (ManagerID, FirstName, LastName, Email, PhoneNumber, YEARSOFEXPERIENCE) VALUES 
(ManagerID.NEXTVAL, 'Michael', 'Johnson', 'michael.johnson@gmail.com', '456-789-0123', 12);

INSERT INTO MANAGERS (ManagerID, FirstName, LastName, Email, PhoneNumber, YEARSOFEXPERIENCE) VALUES 
(ManagerID.NEXTVAL, 'William', 'Brown', 'william.brown@outlook.com', '567-890-1234', 7);

INSERT INTO MANAGERS (ManagerID, FirstName, LastName, Email, PhoneNumber, YEARSOFEXPERIENCE) VALUES 
(ManagerID.NEXTVAL, 'Emma', 'Garcia', 'emma.garcia@outlook.com', '678-901-2345', 3);

INSERT INTO MANAGERS (ManagerID, FirstName, LastName, Email, PhoneNumber, YEARSOFEXPERIENCE) VALUES 
(ManagerID.NEXTVAL, 'Carson', 'Strohm', 'carson.strohm@gmail.com', '123-143-3456', 13);

INSERT INTO MANAGERS (ManagerID, FirstName, LastName, Email, PhoneNumber, YEARSOFEXPERIENCE) VALUES 
(ManagerID.NEXTVAL, 'David', 'Wilson', 'david.wilson@gmail.com', '345-041-3889', 4);

INSERT INTO MANAGERS (ManagerID, FirstName, LastName, Email, PhoneNumber, YEARSOFEXPERIENCE) VALUES 
(ManagerID.NEXTVAL, 'Luke', 'Peter', 'luke.peter@gmail.com', '456-012-3456', 1);

INSERT INTO MANAGERS (ManagerID, FirstName, LastName, Email, PhoneNumber, YEARSOFEXPERIENCE) VALUES 
(ManagerID.NEXTVAL, 'Abel', 'Wade', 'abel.wader@gmail.com', '567-232-1236', 2);

--  --------------------------------------------------------------------------------

-- referenced as CONSTRUCTION 
CREATE TABLE CONSTRUCTION_PROJECTS (
  ProjectID number(4) PRIMARY KEY,
  ProjectName varchar(32) UNIQUE,
  StartDate date NOT NULL,
  Duration varchar(16) NOT NULL,
  Contractor number(4) NOT NULL,
  CONSTRAINT FK_CONSTRUCTION_MANAGERS
    FOREIGN KEY (Contractor)
    REFERENCES CONTRACTORS(ContractorID)
);
create sequence ProjectID increment by 1 start with 2000;

INSERT INTO CONSTRUCTION_PROJECTS 
VALUES (ProjectID.NEXTVAL, 'Luxury Apartments', TO_DATE('2022-03-01', 'YYYY-MM-DD'), '12 months', 1001);

INSERT INTO CONSTRUCTION_PROJECTS 
VALUES (ProjectID.NEXTVAL, 'Regional Medical Hospital', TO_DATE('2021-03-15', 'YYYY-MM-DD'), '18 months', 1002);

INSERT INTO CONSTRUCTION_PROJECTS 
VALUES (ProjectID.NEXTVAL, 'City Hall Renovation', TO_DATE('2020-04-15', 'YYYY-MM-DD'), '36 months', 1004);

INSERT INTO CONSTRUCTION_PROJECTS 
VALUES (ProjectID.NEXTVAL, 'Capitol Hill Government Offices', TO_DATE('2019-05-01', 'YYYY-MM-DD'), '48 months', 1005);

INSERT INTO CONSTRUCTION_PROJECTS 
VALUES (ProjectID.NEXTVAL, 'Ocean View Condos', TO_DATE('2023-05-15', 'YYYY-MM-DD'), '12 months', 1004);

INSERT INTO CONSTRUCTION_PROJECTS 
VALUES (ProjectID.NEXTVAL, 'Crescent Heights Highrise', TO_DATE('2024-06-01', 'YYYY-MM-DD'), '18 months', 1006);

INSERT INTO CONSTRUCTION_PROJECTS 
VALUES (ProjectID.NEXTVAL, 'University Research Center', TO_DATE('2021-06-15', 'YYYY-MM-DD'), '24 months', 1000);

INSERT INTO CONSTRUCTION_PROJECTS 
VALUES (ProjectID.NEXTVAL, 'Riverfront Shopping Center', TO_DATE('2023-07-01', 'YYYY-MM-DD'), '36 months', 1001);

INSERT INTO CONSTRUCTION_PROJECTS 
VALUES (ProjectID.NEXTVAL, 'Coastal Resort Hotel', TO_DATE('2023-07-15', 'YYYY-MM-DD'), '48 months', 1002);

INSERT INTO CONSTRUCTION_PROJECTS 
VALUES (ProjectID.NEXTVAL, 'Central Station Renovation', TO_DATE('2013-04-21', 'YYYY-MM-DD'), '9 months', 1005);

create unique index CONSTRUCTION$ProjectName_Contractor on CONSTRUCTION_PROJECTS(ProjectName, Contractor);
create unique index CONSTRUCTION$ProjectName_StartDate_Duration on CONSTRUCTION_PROJECTS(ProjectName, StartDate, Duration);

--  --------------------------------------------------------------------------------

CREATE TABLE WORKERS AS  --#16
SELECT FirstName, LastName, Email, PhoneNumber
FROM CONTRACTORS
WHERE 1=2;

ALTER TABLE WORKERS ADD WorkerID NUMBER(4) PRIMARY KEY;
ALTER TABLE WORKERS ADD WagePerHour NUMBER(3) NOT NULL;
ALTER TABLE WORKERS ADD GRADE CHAR(1) NOT NULL;
ALTER TABLE WORKERS ADD  Role varchar(16) NOT NULL;
ALTER TABLE WORKERS ADD Project number(4) NOT NULL;
ALTER TABLE WORKERS ADD Manager number(4) NOT NULL;
ALTER TABLE WORKERS ADD CONSTRAINT WORKERS_PHONENUMBER CHECK (REGEXP_LIKE(PhoneNumber, '^\d{3}-\d{3}-\d{4}$'));
ALTER TABLE WORKERS ADD CONSTRAINT WORKERS_WagePerHour CHECK (WagePerHour > 15); -- above minimum wage --#17
ALTER TABLE WORKERS ADD CONSTRAINT WORKERS_GRADE CHECK (Grade IN ('A', 'B', 'C', 'D', 'F'));
ALTER TABLE WORKERS ADD CONSTRAINT FK_WORKERS_MANAGERS
      FOREIGN KEY (Manager)
      REFERENCES MANAGERS(ManagerID);
ALTER TABLE WORKERS ADD CONSTRAINT FK_WORKERS_CONSTRUCTION
      FOREIGN KEY (Project)
      REFERENCES CONSTRUCTION_PROJECTS(ProjectID);

CREATE SEQUENCE WorkerID increment by 1 start with 3000;


INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Adam', 'Smith', 'adam.smith@gmail.com', '416-123-4567', 20, 'A', 'Mason', 2000, 1000);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES
(WorkerID.NEXTVAL, 'Benjamin', 'Jones', 'ben.jones@gmail.com', '905-456-7890', 18, 'B', 'Carpenter', 2002, 1002);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Christopher', 'Wilson', 'chris.wilson@gmail.com', '613-555-1212', 24, 'A', 'Plumber', 2003, 1003);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'David', 'Thompson', 'david.thompson@gmail.com', '416-999-9999', 26, 'B', 'Electrician', 2006, 1006);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Edward', 'Clark', 'edward.clark@gmail.com', '905-123-4567', 17, 'A', 'Welder', 2002, 1002);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Frank', 'Allen', 'frank.allen@gmail.com', '613-555-5555', 18, 'F', 'Technician', 2000, 1000);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'George', 'Young', 'george.young@gmail.com', '905-555-1212', 16, 'D', 'Painter', 2003, 1003);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Henry', 'Robinson', 'henry.robinson@gmail.com', '613-123-4567', 24, 'B', 'General', 2006, 1006);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Isaac', 'Scott', 'isaac.scott@gmail.com', '416-555-5555', 20, 'C', 'Equipment', 2006, 1006);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'James', 'Green', 'james.green@gmail.com', '613-999-9999', 28, 'A', 'Electrician', 2002, 1002);

INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES
(WorkerID.NEXTVAL, 'Nathan', 'Wilson', 'nathan.wilson@gmail.com', '032-155-6767', 19, 'C', 'Electrician', 2000, 1000);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES
(WorkerID.NEXTVAL, 'Lucas', 'Brown', 'lucas.brown@gmail.com', '236-235-2424', 22, 'B', 'Carpenter', 2003, 1003);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES
(WorkerID.NEXTVAL, 'Daniel', 'Lee', 'daniel.lee@gmail.com', '900-775-7890', 18, 'D', 'Technician', 2003, 1003);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES
(WorkerID.NEXTVAL, 'Cameron', 'Thompson', 'cameron.thompson@gmail.com', '206-521-2345', 21, 'B', 'Electrician', 2006, 1006);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES
(WorkerID.NEXTVAL, 'Owen', 'Garcia', 'owen.garcia@gmail.com', '120-555-0585', 23, 'A', 'Mason', 2002, 1002);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES
(WorkerID.NEXTVAL, 'William', 'Allen', 'william.allen@gmail.com', '110-500-7676', 20, 'C', 'Equipment', 2000, 1000);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES
(WorkerID.NEXTVAL, 'Matthew', 'Wright', 'matthew.wright@gmail.com', '121-191-9876', 17, 'F', 'Painter', 2002, 1002);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES
(WorkerID.NEXTVAL, 'Ethan', 'Robinson', 'ethan.robinson@gmail.com', '688-215-5005', 25, 'A', 'Welder', 2003, 1003);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES
(WorkerID.NEXTVAL, 'Jacob', 'Green', 'jacob.green@gmail.com', '466-515-9992', 27, 'A', 'General', 2006, 1006);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES
(WorkerID.NEXTVAL, 'Noah', 'Parker', 'noah.parker@gmail.com', '995-885-1114', 24, 'B', 'Carpenter', 2000, 1000);

INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'William', 'Smith', 'william.smith@gmail.com', '020-123-4567', 20, 'A', 'Mason', 2000, 1000);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'George', 'Brown', 'george.brown@gmail.com', '010-234-5678', 18, 'B', 'Carpenter', 2000, 1000);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Henry', 'Jones', 'henry.jones@gmail.com', '040-345-6789', 24, 'B', 'Plumber', 2003, 1003);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Arthur', 'Taylor', 'arthur.taylor@gmail.com', '011-456-7890', 26, 'C', 'Electrician', 2002, 1002);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Jack', 'Robinson', 'jack.robinson@gmail.com', '424-567-8901', 22, 'A', 'Welder', 2003, 1003);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Thomas', 'Clark', 'thomas.clark@gmail.com', '720-678-9012', 20, 'C', 'Technician', 2002, 1002);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Edward', 'Wright', 'edward.wright@gmail.com', '323-789-0123', 18, 'F', 'Painter', 2006, 1006);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Charles', 'King', 'charles.king@gmail.com', '222-901-2345', 28, 'A', 'Equipment', 2002, 1002);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Richard', 'Scott', 'richard.scott@gmail.com', '123-321-6543', 26, 'D', 'Mason', 2000, 1000);

INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'William', 'Baker', 'william.baker@gmail.com', '122-333-6667', 20, 'A', 'Mason', 2000, 1000);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'George', 'Harris', 'george.harris@gmail.com', '022-234-5678', 18, 'B', 'Carpenter', 2002, 1002);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Henry', 'Evans', 'henry.evans@gmail.com', '221-345-6789', 24, 'B', 'Plumber', 2003, 1003);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Arthur', 'King', 'arthur.king@gmail.com', '422-456-7890', 26, 'C', 'Electrician', 2003, 1003);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Jack', 'Brown', 'jack.brown@gmail.com', '155-567-8901', 22, 'A', 'Welder', 2006, 1006);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Thomas', 'Davis', 'thomas.davis@gmail.com', '929-678-9012', 20, 'C', 'Technician', 2006, 1006);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Edward', 'Wilson', 'edward.wilson@gmail.com', '228-789-0123', 18, 'F', 'Painter', 2003, 1003);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'James', 'Jackson', 'james.jackson@gmail.com', '120-890-1234', 24, 'B', 'General', 2000, 1000);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Charles', 'Taylor', 'charles.taylor@gmail.com', '229-901-2345', 28, 'A', 'Equipment', 2002, 1002);
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Richard', 'Clark', 'richard.clark@gmail.com', '217-012-3456', 26, 'D', 'Mason', 2003, 1003);

--  --------------------------------------------------------------------------------
--referenced as LOCATION
CREATE TABLE PROJECT_LOCATION_DATA (
  LocationID number(4) PRIMARY KEY,
  Project number(4) NOT NULL,
  StreetAddress varchar(32) NOT NULL,
  City varchar(16) NOT NULL,
  State char(2) NOT NULL,
  WorkerCount number(6) DEFAULT NULL,
  Manager number(4) NOT NULL,
  CONSTRAINT FK_LOCATION_CONSTRUCTION FOREIGN KEY (Project) REFERENCES CONSTRUCTION_PROJECTS(ProjectID),
  CONSTRAINT FK_LOCATION_MANAGERS FOREIGN KEY (Manager) REFERENCES Managers(ManagerID)
);

ALTER TABLE PROJECT_LOCATION_DATA 
ADD CONSTRAINT LOCATION_WORKERCOUNT CHECK (WorkerCount >= 0);

UPDATE PROJECT_LOCATION_DATA
SET WORKERCOUNT = 0
WHERE WORKERCOUNT IS NULL;

ALTER TABLE PROJECT_LOCATION_DATA
MODIFY (WORKERCOUNT DEFAULT 0);

ALTER TABLE PROJECT_LOCATION_DATA
MODIFY (WORKERCOUNT NOT NULL);




create sequence LocationID increment by 1 start with 2000;

INSERT INTO PROJECT_LOCATION_DATA VALUES 
(LocationID.NEXTVAL, 2000, '123 Main St', 'Springfield', 'IL',
NVL((SELECT COUNT(*) FROM WORKERS WHERE PROJECT = 2000 GROUP BY PROJECT), 0)
, 1000);

INSERT INTO PROJECT_LOCATION_DATA VALUES (LocationID.NEXTVAL, 2001, '456 Elm St', 'Wilmington', 'DE',
NVL((SELECT COUNT(*) FROM WORKERS WHERE PROJECT = 2001 GROUP BY PROJECT), 0) 
,1001);

INSERT INTO PROJECT_LOCATION_DATA VALUES (LocationID.NEXTVAL, 2002, '789 Oak St', 'Madison', 'WI',
NVL((SELECT COUNT(*) FROM WORKERS WHERE PROJECT = 2002 GROUP BY PROJECT), 0)
,1002);

INSERT INTO PROJECT_LOCATION_DATA VALUES (LocationID.NEXTVAL, 2003, '1011 Maple Ave', 'Trenton', 'NJ',
NVL((SELECT COUNT(*) FROM WORKERS WHERE PROJECT = 2003 GROUP BY PROJECT), 0)
,1003);

INSERT INTO PROJECT_LOCATION_DATA VALUES (LocationID.NEXTVAL, 2004, '1314 Cedar St', 'Bismarck', 'ND',
NVL((SELECT COUNT(*) FROM WORKERS WHERE PROJECT = 2004 GROUP BY PROJECT), 0)
,1004);

INSERT INTO PROJECT_LOCATION_DATA VALUES (LocationID.NEXTVAL, 2005, '1516 Pine Rd', 'Augusta', 'ME',
NVL((SELECT COUNT(*) FROM WORKERS WHERE PROJECT = 2005 GROUP BY PROJECT), 0)
,1005);

INSERT INTO PROJECT_LOCATION_DATA VALUES (LocationID.NEXTVAL, 2006, '1718 Birch Ave', 'Helena', 'MT',
NVL((SELECT COUNT(*) FROM WORKERS WHERE PROJECT = 2006 GROUP BY PROJECT), 0)
,1006);

INSERT INTO PROJECT_LOCATION_DATA VALUES (LocationID.NEXTVAL, 2007, '1920 Spruce St', 'Montgomery', 'AL',
NVL((SELECT COUNT(*) FROM WORKERS WHERE PROJECT = 2007 GROUP BY PROJECT), 0)
,1007);

INSERT INTO PROJECT_LOCATION_DATA VALUES (LocationID.NEXTVAL, 2008, '2122 Cedar Ln', 'Concord', 'NH',
NVL((SELECT COUNT(*) FROM WORKERS WHERE PROJECT = 2008 GROUP BY PROJECT), 0)
,1008);

INSERT INTO PROJECT_LOCATION_DATA VALUES (LocationID.NEXTVAL, 2009, '2324 Oak Dr', 'Salt Lake City', 'UT',
NVL((SELECT COUNT(*) FROM WORKERS WHERE PROJECT = 2009 GROUP BY PROJECT), 0)
,1009);

--  --------------------------------------------------------------------------------

CREATE TABLE INSPECTIONS (
  InspectionID number(4),
  InspectorName varchar(64) NOT NULL,
  InspectionType varchar(32) NOT NULL,
  InspectionDate date NOT NULL,
  PassFail varchar(4) DEFAULT NULL,
  LocationID number(4) NOT NULL,
  PRIMARY KEY (InspectionID),
  CONSTRAINT FK_INSPECTIONS_LOCATION FOREIGN KEY (LOCATIONID) REFERENCES PROJECT_LOCATION_DATA(LOCATIONID),
  CONSTRAINT INSPECTIONS_PassFail CHECK (PassFail IN ('Pass', 'Fail', NULL,'WIP'))
); -- WIP = work in progress

create sequence inspectionID increment by 1 start with 100;

INSERT INTO INSPECTIONS VALUES (InspectionID.NEXTVAL, 'Seamus Connor', 'Electrical', TO_DATE('2022-01-01', 'YYYY-MM-DD'), 'Pass', 2000);
INSERT INTO INSPECTIONS VALUES (InspectionID.NEXTVAL, 'Aoife Murphy', 'Plumbing', TO_DATE('2022-02-15', 'YYYY-MM-DD'), 'Fail', 2004);
INSERT INTO INSPECTIONS VALUES (InspectionID.NEXTVAL, 'Padraig Sullivan', 'Structural', TO_DATE('2022-03-25', 'YYYY-MM-DD'), 'Pass', 2000);
INSERT INTO INSPECTIONS VALUES (InspectionID.NEXTVAL, 'Caoimhe Walsh', 'Fire Safety', TO_DATE('2023-03-10', 'YYYY-MM-DD'), NULL, 2000);
INSERT INTO INSPECTIONS VALUES (InspectionID.NEXTVAL, 'Tadhg Byrne', 'Environmental', TO_DATE('2022-04-10', 'YYYY-MM-DD'), 'Pass', 2003);
INSERT INTO INSPECTIONS VALUES (InspectionID.NEXTVAL, 'Siobhan Kelly', 'Electrical', TO_DATE('2022-04-20', 'YYYY-MM-DD'), 'Fail', 2003);
INSERT INTO INSPECTIONS VALUES (InspectionID.NEXTVAL, 'Fionnuala Doyle', 'Plumbing', TO_DATE('2023-03-07', 'YYYY-MM-DD'), NULL, 2002);
INSERT INTO INSPECTIONS VALUES (InspectionID.NEXTVAL, 'Bridget Flynn', 'Fire Safety', TO_DATE('2022-06-01', 'YYYY-MM-DD'), 'Fail', 2005);
INSERT INTO INSPECTIONS VALUES (InspectionID.NEXTVAL, 'Colm Reilly', 'Environmental', TO_DATE('2022-07-02', 'YYYY-MM-DD'), 'Pass', 2007);
INSERT INTO INSPECTIONS VALUES (InspectionID.NEXTVAL, 'Grainne Ryan', 'Electrical', TO_DATE('2023-03-09', 'YYYY-MM-DD'), NULL, 2003);
INSERT INTO INSPECTIONS VALUES (InspectionID.NEXTVAL, 'Fergus McCarthy', 'Plumbing', TO_DATE('2022-07-15', 'YYYY-MM-DD'), 'Pass', 2008);
INSERT INTO INSPECTIONS VALUES (InspectionID.NEXTVAL, 'Niamh Burke', 'Structural', TO_DATE('2022-08-03', 'YYYY-MM-DD'), 'Fail', 2001);
INSERT INTO INSPECTIONS VALUES (InspectionID.NEXTVAL, 'Eamon Hogan', 'Fire Safety', TO_DATE('2022-09-01', 'YYYY-MM-DD'), 'Pass', 2004);
INSERT INTO INSPECTIONS VALUES (InspectionID.NEXTVAL, 'Mairead Neill', 'Environmental', TO_DATE('2023-03-06', 'YYYY-MM-DD'), NULL, 2005);
INSERT INTO INSPECTIONS VALUES (InspectionID.NEXTVAL, 'Aoife Brennan', 'Electrical', TO_DATE('2022-03-02', 'YYYY-MM-DD'), 'Pass', 2006);

--  --------------------------------------------------------------------------------

CREATE TABLE SAFETY_INCIDENTS(
  IncidentID number(4),
  IncidentDate date NOT NULL,
  IncidentType varchar(32) NOT NULL,
  Description varchar(256),
  LocationID number(4) NOT NULL,
  PRIMARY KEY (IncidentID),
  CONSTRAINT FK_SAFETY_LOCATION
    FOREIGN KEY (LocationID)
    REFERENCES PROJECT_LOCATION_DATA(LocationID)
);
create sequence IncidentID increment by 1 start with 100;

INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2022-01-01', 'YYYY-MM-DD'), 'Slip and Fall', 'Worker slipped on a wet floor', 2000);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2022-02-15', 'YYYY-MM-DD'), 'Injury', 'Worker cut their hand on a saw', 2002);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2022-03-25', 'YYYY-MM-DD'), 'Fall', 'Worker fell off a ladder', 2002);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2023-03-10', 'YYYY-MM-DD'), 'Fire', 'Fire broke out on the construction site', 2003);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2022-04-10', 'YYYY-MM-DD'), 'Electrocution', 'Worker was electrocuted while working on wiring', 2003);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2022-04-20', 'YYYY-MM-DD'), 'Injury', 'Worker was hit in the head by a falling object', 2003);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2023-03-07', 'YYYY-MM-DD'), 'Fall', 'Worker fell through a hole in the floor', 2003);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2022-05-12', 'YYYY-MM-DD'), 'Fire', 'Small fire broke out in a storage room', 2006);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2022-06-01', 'YYYY-MM-DD'), 'Injury', 'Worker sprained their ankle on uneven ground', 2006);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2022-07-02', 'YYYY-MM-DD'), 'Fall', 'Worker fell off scaffolding', 2006);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2022-07-02', 'YYYY-MM-DD'), 'Fall', 'Worker fell off scaffolding', 2000);


INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2021-02-01', 'YYYY-MM-DD'), 'Fall from height', 'Worker fell off scaffolding, broke two legs', 2002);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2021-02-15', 'YYYY-MM-DD'), 'Electric shock', 'Worker received electric shock from exposed wires, unconscious and taken to hospital', 2006);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2019-02-28', 'YYYY-MM-DD'), 'Burn injury', 'Worker suffered severe burn injury while working with welding equipment', 2001);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2018-03-05', 'YYYY-MM-DD'), 'Inhaling toxic substance', 'Worker inhaled toxic fumes from chemicals, taken to hospital', 2001);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2020-04-12', 'YYYY-MM-DD'), 'Falling object', 'A heavy object fell off the crane and hit a worker, taken to hospital', 2004);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2019-05-21', 'YYYY-MM-DD'), 'Caught in equipment', 'Worker got caught in equipment and lost a finger', 2005);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2014-06-01', 'YYYY-MM-DD'), 'Excessive noise', 'Worker suffered permanent hearing loss due to excessive noise exposure', 2008);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2014-06-15', 'YYYY-MM-DD'), 'Heat exhaustion', 'Worker suffered from heat exhaustion, taken to hospital', 2008);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2021-07-01', 'YYYY-MM-DD'), 'Chemical burn', 'Worker suffered chemical burn while handling hazardous chemicals', 2007);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2020-07-15', 'YYYY-MM-DD'), 'Explosion', 'Explosion at the site, several workers injured', 2007);
INSERT INTO SAFETY_INCIDENTS VALUES (IncidentID.NEXTVAL, TO_DATE('2020-08-05', 'YYYY-MM-DD'), 'Crushing injury', 'Worker suffered crushing injury from heavy machinery', 2008);

select * from safety_incidents;
--  --------------------------------------------------------------------------------

CREATE TABLE TRAINING (
  TrainingID number(4),
  WorkerID number(4) NOT NULL,
  TrainingType varchar(128),
  TrainingDate DATE,
  Description varchar(256) NOT NULL,
  PRIMARY KEY (TrainingID),
  CONSTRAINT FK_TRAINING_WORKERS
    FOREIGN KEY (WorkerID)
      REFERENCES WORKERS(WorkerID)
);
CREATE sequence trainingID increment by 1 start with 4000;

INSERT INTO TRAINING VALUES (trainingID.NEXTVAL, 3005, 'Fall Protection', TO_DATE('2022-01-01', 'YYYY-MM-DD'), 'Proper use of fall protection equipment');
INSERT INTO TRAINING VALUES (trainingID.NEXTVAL, 3008, 'First Aid', TO_DATE('2022-02-15', 'YYYY-MM-DD'), 'Basic first aid and CPR training');
INSERT INTO TRAINING VALUES (trainingID.NEXTVAL, 3023, 'Scaffolding Safety', TO_DATE('2022-03-25', 'YYYY-MM-DD'), 'Safe use and inspection of scaffolding');
INSERT INTO TRAINING VALUES (trainingID.NEXTVAL, 3032, 'Hazard Communication', TO_DATE('2022-04-10', 'YYYY-MM-DD'), 'Understanding of hazard communication standards and labeling');
INSERT INTO TRAINING VALUES (trainingID.NEXTVAL, 3034, 'Crane Safety', TO_DATE('2022-04-20', 'YYYY-MM-DD'), 'Safe operation and inspection of cranes');
INSERT INTO TRAINING VALUES (trainingID.NEXTVAL, 3015, 'Excavation Safety', TO_DATE('2023-03-07', 'YYYY-MM-DD'), 'Safe excavation practices and procedures');
INSERT INTO TRAINING VALUES (trainingID.NEXTVAL, 3015, 'Electrical Safety', TO_DATE('2022-05-12', 'YYYY-MM-DD'), 'Safe work practices and procedures for electrical work');
INSERT INTO TRAINING VALUES (trainingID.NEXTVAL, 3010, 'Welding Safety', TO_DATE('2022-06-01', 'YYYY-MM-DD'), 'Safe welding practices and procedures');
INSERT INTO TRAINING VALUES (trainingID.NEXTVAL, 3032, 'Heavy Equipment Operation', TO_DATE('2022-07-02', 'YYYY-MM-DD'), 'Safe operation and inspection of heavy equipment');
INSERT INTO TRAINING VALUES (trainingID.NEXTVAL, 3032, 'Lockout/Tagout', TO_DATE('2022-08-03', 'YYYY-MM-DD'), 'Procedures for the control of hazardous energy');

INSERT INTO TRAINING VALUES (trainingID.nextVal, 3003, 'First Aid', TO_DATE('2022-01-10', 'YYYY-MM-DD'), 'Basic first aid training');
INSERT INTO TRAINING VALUES (trainingID.nextVal, 3002, 'Fire Safety', TO_DATE('2022-03-15', 'YYYY-MM-DD'), 'Fire safety and prevention training');
INSERT INTO TRAINING VALUES (trainingID.nextVal, 3005, 'Confined Spaces', TO_DATE('2022-04-20', 'YYYY-MM-DD'), 'Training on working in confined spaces');
INSERT INTO TRAINING VALUES (trainingID.nextVal, 3032, 'Heavy Machinery', TO_DATE('2022-02-01', 'YYYY-MM-DD'), 'Training on using heavy machinery safely');
INSERT INTO TRAINING VALUES (trainingID.nextVal, 3031, 'Fall Protection', TO_DATE('2023-01-15', 'YYYY-MM-DD'), 'Training on fall protection equipment and procedures');
INSERT INTO TRAINING VALUES (trainingID.nextVal, 3022, 'Asbestos Awareness', TO_DATE('2023-02-28', 'YYYY-MM-DD'), 'Training on identifying and handling asbestos');
INSERT INTO TRAINING VALUES (trainingID.nextVal, 3020, 'Scaffolding Safety', TO_DATE('2022-07-15', 'YYYY-MM-DD'), 'Training on assembling and using scaffolding safely');
INSERT INTO TRAINING VALUES (trainingID.nextVal, 3019, 'Hazard Communication', TO_DATE('2022-05-10', 'YYYY-MM-DD'), 'Training on identifying and communicating hazards');

--  --------------------------------------------------------------------------------
CREATE TABLE ARCHITECTURE (
  ArchitectureID number(4),
  ProjectID number(4),
  ArchitectName varchar(64) NOT NULL, 
  Type varchar(64) NOT NULL,
  DesignStatus varchar(64) NOT NULL,
  TotalArea number(8), -- sq ft
  EstimatedCost number(10),
  PRIMARY KEY (ArchitectureID),
  CONSTRAINT ARCHITECTURE_DesignStatus CHECK (DesignStatus in ('PASS','FAIL','In Progress')),
  CONSTRAINT ARCHITECTURE_TotalArea CHECK(TotalArea > 0),
  CONSTRAINT ARCHITECTURE_EstimatedCost CHECK(EstimatedCost > 0),
  CONSTRAINT FK_ARCHITECTURE_CONSTRUCTION
    FOREIGN KEY (ProjectID)
      REFERENCES CONSTRUCTION_PROJECTS(ProjectID)
);

Create sequence architectureID increment by 1 start with 500;

Select * from CONSTRUCTION_PROJECTS;

INSERT INTO ARCHITECTURE VALUES (ArchitectureID.NEXTVAL, 2000, 'John Smith', 'Residential', 'In Progress', 2000,600000);
INSERT INTO ARCHITECTURE VALUES (ArchitectureID.NEXTVAL, 2001, 'Sarah Johnson', 'Hospital', 'PASS', 3500, 200000);
INSERT INTO ARCHITECTURE VALUES (ArchitectureID.NEXTVAL, NULL, 'David Garcia', 'Residential', 'FAIL', 5000, 600000);
INSERT INTO ARCHITECTURE VALUES (ArchitectureID.NEXTVAL, 2002, 'Michael Brown', 'Government', 'In Progress',2000, 600000);
INSERT INTO ARCHITECTURE VALUES (ArchitectureID.NEXTVAL, 2003, 'Emily Davis', 'Government', 'In Progress',3000, 450000);
INSERT INTO ARCHITECTURE VALUES (ArchitectureID.NEXTVAL, NULL, 'Caleb Young', 'Residential', 'FAIL', 3000, 5000000);
INSERT INTO ARCHITECTURE VALUES (ArchitectureID.NEXTVAL, 2004, 'David Garcia', 'Residential', 'PASS', 2500,500000);
INSERT INTO ARCHITECTURE VALUES (ArchitectureID.NEXTVAL, 2005, 'Alexis Hernandez', 'Residential', 'PASS', 3500, 650000);
INSERT INTO ARCHITECTURE VALUES (ArchitectureID.NEXTVAL, NULL, 'Cian Ryan', 'Industrial', 'FAIL', 25000, 300000000);
INSERT INTO ARCHITECTURE VALUES (ArchitectureID.NEXTVAL, 2006, 'Jessica Martinez', 'Government', 'In Progress', 2000,7000000);
INSERT INTO ARCHITECTURE VALUES (ArchitectureID.NEXTVAL, 2007, 'Joshua Miller', 'Commercial', 'PASS', 19000, 5500000);
INSERT INTO ARCHITECTURE VALUES (ArchitectureID.NEXTVAL, NULL, 'Aoife Byrne', 'Commercial', 'FAIL', 1000, 9000000);
INSERT INTO ARCHITECTURE VALUES (ArchitectureID.NEXTVAL, 2008, 'Avery Wilson', 'Commercial', 'PASS', 9600, 3500000);
INSERT INTO ARCHITECTURE VALUES (ArchitectureID.NEXTVAL, 2009, 'Caleb Young', 'Government', 'PASS', 2600,3210000);
INSERT INTO ARCHITECTURE VALUES (ArchitectureID.NEXTVAL, NULL, 'Niamh Flynn', 'Hospital', 'FAIL', 2000, 300000);

--  --------------------------------------------------------------------------------
CREATE TABLE PERMITS (
  PermitsID number(4) PRIMARY KEY,
  ProjectID number(4) NOT NULL,
  IssuanceDate DATE NOT NULL,
  PermitType varchar(64) NOT NULL,
  Duration number(4) NOT NULL,
  Cost number(10) NOT NULL,
  IssuingAuthority varchar(32) NOT NULL,
  CONSTRAINT PERMITS_COST CHECK(Cost > 0),
  CONSTRAINT FK_PERMITS_CONSTRUCTION
    FOREIGN KEY (ProjectID)
      REFERENCES CONSTRUCTION_PROJECTS(ProjectID)
);

Create sequence permitID increment by 1 start with 200;

INSERT INTO PERMITS VALUES (permitID.NEXTVAL, 2000, TO_DATE('2022-01-01', 'YYYY-MM-DD'), 'Construction', 90, 10000, 'City Department of Buildings');
INSERT INTO PERMITS VALUES (permitID.NEXTVAL, 2001, TO_DATE('2022-02-15', 'YYYY-MM-DD'), 'Demolition', 30, 5000, 'City Department of Buildings');
INSERT INTO PERMITS VALUES (permitID.NEXTVAL, 2002, TO_DATE('2022-03-25', 'YYYY-MM-DD'), 'Excavation', 10, 8000, 'City Department of Buildings');
INSERT INTO PERMITS VALUES (permitID.NEXTVAL, 2003, TO_DATE('2023-03-10', 'YYYY-MM-DD'), 'Renovation', 12, 15000, 'City Department of Buildings');
INSERT INTO PERMITS VALUES (permitID.NEXTVAL, 2004, TO_DATE('2022-04-10', 'YYYY-MM-DD'), 'Construction', 90, 12000, 'City Department of Buildings');
INSERT INTO PERMITS VALUES (permitID.NEXTVAL, 2005, TO_DATE('2022-04-20', 'YYYY-MM-DD'), 'Demolition', 30, 7000, 'City Department of Buildings');
INSERT INTO PERMITS VALUES (permitID.NEXTVAL, 2006, TO_DATE('2023-03-07', 'YYYY-MM-DD'), 'Excavation', 6, 10000, 'City Department of Buildings');
INSERT INTO PERMITS VALUES (permitID.NEXTVAL, 2007, TO_DATE('2022-05-12', 'YYYY-MM-DD'), 'Renovation', 12, 20000, 'City Department of Buildings');
INSERT INTO PERMITS VALUES (permitID.NEXTVAL, 2008, TO_DATE('2022-06-01', 'YYYY-MM-DD'), 'Construction',26, 8000, 'City Department of Buildings');
INSERT INTO PERMITS VALUES (permitID.NEXTVAL, 2009, TO_DATE('2013-12-02', 'YYYY-MM-DD'), 'Demolition', 30, 4000, 'City Department of Buildings');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2001, TO_DATE('2022-01-11', 'YYYY-MM-DD'), 'Building Permit', 18, 5000, 'City Planning');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2002, TO_DATE('2022-02-25', 'YYYY-MM-DD'), 'Environmental Permit', 36, 10000, 'Environmental Protection Agency');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2002, TO_DATE('2022-03-25', 'YYYY-MM-DD'), 'Zoning Permit', 90, 15000, 'City Planning');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2003, TO_DATE('2023-03-18', 'YYYY-MM-DD'), 'Fire Permit', 60, 5000, 'Fire Department');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2003, TO_DATE('2022-04-04', 'YYYY-MM-DD'), 'Plumbing Permit', 30, 10000, 'City Planning');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2005, TO_DATE('2022-04-22', 'YYYY-MM-DD'), 'Electrical Permit', 90, 2500, 'City Planning');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2006, TO_DATE('2023-03-17', 'YYYY-MM-DD'), 'Building Permit', 30, 1000, 'City Planning');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2007, TO_DATE('2022-05-22', 'YYYY-MM-DD'), 'Zoning Permit', 30, 5000, 'City Planning');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2007, TO_DATE('2022-06-15', 'YYYY-MM-DD'), 'Environmental Permit', 18, 3000, 'Environmental Protection Agency');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2009, TO_DATE('2014-01-05', 'YYYY-MM-DD'), 'Fire Permit', 90, 1000, 'Fire Department');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2004, TO_DATE('2022-01-11', 'YYYY-MM-DD'), 'Building Permit', 19, 5000, 'City Planning');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2002, TO_DATE('2022-02-25', 'YYYY-MM-DD'), 'Environmental Permit', 36, 10000, 'Environmental Protection Agency');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2001, TO_DATE('2022-03-25', 'YYYY-MM-DD'), 'Zoning Permit', 30, 15000, 'City Planning');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2005, TO_DATE('2023-03-18', 'YYYY-MM-DD'), 'Fire Permit', 30, 5000, 'Fire Department');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2005, TO_DATE('2022-04-04', 'YYYY-MM-DD'), 'Plumbing Permit', 30, 1000, 'City Planning');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2008, TO_DATE('2022-04-22', 'YYYY-MM-DD'), 'Electrical Permit', 20, 25000, 'City Planning');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2008, TO_DATE('2023-03-17', 'YYYY-MM-DD'), 'Building Permit', 36, 1000, 'City Planning');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2006, TO_DATE('2022-05-22', 'YYYY-MM-DD'), 'Zoning Permit', 30, 5000, 'City Planning');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2004, TO_DATE('2022-06-15', 'YYYY-MM-DD'), 'Environmental Permit', 18, 3000, 'Environmental Protection Agency');
INSERT INTO PERMITS VALUES (PermitID.NEXTVAL, 2003, TO_DATE('2014-01-05', 'YYYY-MM-DD'), 'Fire Permit', 10, 1000, 'Fire Department');
INSERT INTO PERMITS VALUES (permitID.NEXTVAL, 2001, TO_DATE('2021-12-01', 'YYYY-MM-DD'), 'Construction',26, 8000, 'City Department of Buildings');
INSERT INTO PERMITS VALUES (permitID.NEXTVAL, 2002, TO_DATE('2022-09-02', 'YYYY-MM-DD'), 'Demolition', 30, 4000, 'City Department of Buildings');

--  --------------------------------------------------------------------------------

CREATE TABLE MARKETING (
  MarketingID number(4),
  ProjectID number(4) NOT NULL,
  MarketingStrategy varchar(64) NOT NULL,
  CampaignStartDate DATE NOT NULL,
  CampaignEndDate DATE NOT NULL,
  Cost number(10) NOT NULL,
  Results varchar(64) NOT NULL,
  PRIMARY KEY (MarketingID),
  CONSTRAINT FK_MARKETING_CONSTRUCTION FOREIGN KEY (ProjectID) REFERENCES CONSTRUCTION_PROJECTS(ProjectID),
  CONSTRAINT MARKETING_COST CHECK(Cost > 0)
);


CREATE SEQUENCE MarketingID START WITH 5000 INCREMENT BY 1;

INSERT INTO MARKETING (MarketingID, ProjectID, MarketingStrategy, CampaignStartDate, CampaignEndDate, Cost, Results) VALUES 
(MARKETINGID.nextval, 2000, 'Social media ads', to_date('2022-01-01', 'YYYY-MM-DD'), to_date('2022-01-31', 'YYYY-MM-DD'), 5000, '20% increase in website traffic');

INSERT INTO MARKETING (MarketingID, ProjectID, MarketingStrategy, CampaignStartDate, CampaignEndDate, Cost, Results) VALUES 
(MARKETINGID.nextval, 2001, 'Email marketing', to_date('2022-02-01', 'YYYY-MM-DD'), to_date('2022-02-28', 'YYYY-MM-DD'), 8000, '50 new leads generated');

INSERT INTO MARKETING (MarketingID, ProjectID, MarketingStrategy, CampaignStartDate, CampaignEndDate, Cost, Results) VALUES 
(MARKETINGID.nextval, 2003, 'Billboards', to_date('2022-03-01', 'YYYY-MM-DD'), to_date('2022-03-31', 'YYYY-MM-DD'), 10000, '5% increase in sales');

INSERT INTO MARKETING (MarketingID, ProjectID, MarketingStrategy, CampaignStartDate, CampaignEndDate, Cost, Results) VALUES 
(MARKETINGID.nextval, 2003, 'TV commercials', to_date('2022-04-01', 'YYYY-MM-DD'), to_date('2022-04-30', 'YYYY-MM-DD'), 15000, '1000 new website visitors');

INSERT INTO MARKETING (MarketingID, ProjectID, MarketingStrategy, CampaignStartDate, CampaignEndDate, Cost, Results) VALUES 
(MARKETINGID.nextval, 2008, 'Google Ads', to_date('2022-05-01', 'YYYY-MM-DD'), to_date('2022-05-31', 'YYYY-MM-DD'), 12000, '10% increase in product purchases');

INSERT INTO MARKETING (MarketingID, ProjectID, MarketingStrategy, CampaignStartDate, CampaignEndDate, Cost, Results) VALUES 
(MARKETINGID.nextval, 2007, 'Influencer marketing', to_date('2022-06-01', 'YYYY-MM-DD'), to_date('2022-06-30', 'YYYY-MM-DD'), 20000, '50% increase in social media followers');

INSERT INTO MARKETING (MarketingID, ProjectID, MarketingStrategy, CampaignStartDate, CampaignEndDate, Cost, Results) VALUES 
(MARKETINGID.nextval, 2006, 'Social media promotion', to_date('2023-01-01', 'YYYY-MM-DD'), to_date('2023-01-31', 'YYYY-MM-DD'), 5000, '25% increase in website traffic');

INSERT INTO MARKETING (MarketingID, ProjectID, MarketingStrategy, CampaignStartDate, CampaignEndDate, Cost, Results) VALUES 
(MARKETINGID.nextval, 2002, 'Radio ads', to_date('2022-07-01', 'YYYY-MM-DD'), to_date('2022-07-31', 'YYYY-MM-DD'), 8000, '15% increase in store foot traffic');

INSERT INTO MARKETING (MarketingID, ProjectID, MarketingStrategy, CampaignStartDate, CampaignEndDate, Cost, Results) VALUES 
(MARKETINGID.nextval, 2000, 'Content marketing', to_date('2022-08-01', 'YYYY-MM-DD'), to_date('2022-08-31', 'YYYY-MM-DD'), 10000, '200 new email subscribers');

INSERT INTO MARKETING (MarketingID, ProjectID, MarketingStrategy, CampaignStartDate, CampaignEndDate, Cost, Results) VALUES 
(MARKETINGID.nextval, 2001, 'Direct mail', to_date('2022-09-01', 'YYYY-MM-DD'), to_date('2022-09-30', 'YYYY-MM-DD'), 6000, '5% increase in website conversion rate');

INSERT INTO MARKETING (MarketingID, ProjectID, MarketingStrategy, CampaignStartDate, CampaignEndDate, Cost, Results) VALUES
(MARKETINGID.nextval, 2004, 'Event sponsorship', to_date('2022-10-01', 'YYYY-MM-DD'), to_date('2022-10-31', 'YYYY-MM-DD'), 25000, '1000 new leads generated');

INSERT INTO MARKETING (MarketingID, ProjectID, MarketingStrategy, CampaignStartDate, CampaignEndDate, Cost, Results) VALUES 
(MARKETINGID.nextval, 2006, 'Radio ads', to_date('2022-07-01', 'YYYY-MM-DD'), to_date('2022-07-31', 'YYYY-MM-DD'), 8000, '15% increase in store foot traffic');

--  --------------------------------------------------------------------------------

CREATE TABLE PURCHASE_ORDERS (
    --referenced as PURCHASES 
  OrdersID number(4) PRIMARY KEY,
  ProjectID number(4) NOT NULL,
  OrderDate DATE NOT NULL,
  Supplier varchar(64) NOT NULL,
  Material varchar(64) NOT NULL,
  Quantity number(10) NOT NULL,
  TotalCost number(10) NOT NULL,
  Status varchar(64) NOT NULL,
  CONSTRAINT FK_PURCHASES_CONSTRUCTION FOREIGN KEY (ProjectID) REFERENCES CONSTRUCTION_PROJECTS(ProjectID),
  CONSTRAINT PURCHASES_TotalCost CHECK(TotalCost > 0),
  CONSTRAINT PURCHASES_Quantity CHECK(Quantity > 0),
  Constraint PURCHASES_Status CHECK(Status IN ('Pending', 'Received', 'Cancelled'))
);

CREATE SEQUENCE OrdersID START WITH 5000 INCREMENT BY 1;

INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2000, to_date('2022-01-01', 'YYYY-MM-DD'), 'ABC Company', 'Concrete', 100, 5000, 'Pending');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2002, to_date('2022-02-02', 'YYYY-MM-DD'), 'XYZ Corporation', 'Lumber', 50, 10000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2002, to_date('2022-03-03', 'YYYY-MM-DD'), 'PQR Suppliers', 'Bricks', 2000, 20000, 'Pending');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2000, to_date('2022-04-05', 'YYYY-MM-DD'), 'LMN Enterprises', 'Cement', 500, 15000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2003, to_date('2022-05-01', 'YYYY-MM-DD'), 'ABC Company', 'Steel', 1000, 20000, 'Pending');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2003, to_date('2022-06-07', 'YYYY-MM-DD'), 'PQR Suppliers', 'Concrete', 200, 8000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2003, to_date('2022-07-06', 'YYYY-MM-DD'), 'XYZ Corporation', 'Lumber', 75, 15000, 'Cancelled');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2006, to_date('2022-08-11', 'YYYY-MM-DD'), 'ABC Company', 'Bricks', 500, 5000, 'Pending');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2006, to_date('2022-09-01', 'YYYY-MM-DD'), 'LMN Enterprises', 'Cement', 750, 22500, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2006, to_date('2022-10-01', 'YYYY-MM-DD'), 'PQR Suppliers', 'Steel', 1500, 30000, 'Pending');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2005, to_date('2021-11-11', 'YYYY-MM-DD'), 'XYZ Corporation', 'Concrete', 100, 5000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2001, to_date('2021-12-21', 'YYYY-MM-DD'), 'ABC Company', 'Lumber', 50, 10000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2001, to_date('2021-08-25', 'YYYY-MM-DD'), 'PQR Suppliers', 'Bricks', 2000, 20000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2005, to_date('2020-09-01', 'YYYY-MM-DD'), 'LMN Enterprises', 'Cement', 500, 15000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2005, to_date('2020-10-01', 'YYYY-MM-DD'), 'XYZ Corporation', 'Steel', 1000, 20000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2004, to_date('2020-11-01', 'YYYY-MM-DD'), 'ABC Company', 'Concrete', 200, 8000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2004, to_date('2020-12-01', 'YYYY-MM-DD'), 'PQR Suppliers', 'Lumber', 75, 15000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2004, to_date('2020-01-01', 'YYYY-MM-DD'), 'LMN Enterprises', 'Bricks', 500, 5000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2007, to_date('2020-12-01', 'YYYY-MM-DD'), 'XYZ Corporation', 'Cement', 750, 22500, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2008, to_date('2020-11-01', 'YYYY-MM-DD'), 'ABC Company', 'Steel', 1500, 30000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2007, to_date('2020-10-01', 'YYYY-MM-DD'), 'PQR Suppliers', 'Concrete', 100, 5000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2008, to_date('2020-09-01', 'YYYY-MM-DD'), 'LMN Enterprises', 'Lumber', 50, 10000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2009, to_date('2013-12-01', 'YYYY-MM-DD'), 'XYZ Corporation', 'Bricks', 2000, 20000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2009, to_date('2013-11-01', 'YYYY-MM-DD'), 'ABC Company', 'Cement', 500, 15000, 'Received');
INSERT INTO PURCHASE_ORDERS VALUES (OrdersID.nextval, 2009, to_date('2014-02-01', 'YYYY-MM-DD'), 'PQR Suppliers', 'Steel', 1000, 20000, 'Received');

--  --------------------------------------------------------------------------------
CREATE TABLE EXPENSES (
  ExpenseID number(4) PRIMARY KEY,
  ProjectID number(4) NOT NULL UNIQUE, 
  Labor number(10) NOT NULL,
  Materials number(10) NOT NULL,
  Permits number(10) NOT NULL,
  Marketing number(10) NOT NULL,
  Misc number(10) NOT NULL,
  CONSTRAINT FK_EXPENSES_CONSTRUCTION FOREIGN KEY (ProjectID) REFERENCES CONSTRUCTION_PROJECTS(ProjectID),
  CONSTRAINT EXPENSES_Labor CHECK(Labor > 0),
  CONSTRAINT EXPENSES_Materials CHECK(Materials > 0),
  CONSTRAINT EXPENSES_Permits CHECK(Permits > 0),
  CONSTRAINT EXPENSES_Marketing CHECK(Marketing >= 0),
  CONSTRAINT EXPENSES_Misc CHECK(Misc >= 0)
);
CREATE SEQUENCE ExpenseID START WITH 5000 INCREMENT BY 1; --#19

CREATE OR REPLACE VIEW EXPENSES_VIEW AS  -- #4
SELECT CP.ProjectID, COALESCE(MC.COST, 0) AS MARKETING_COST,
       COALESCE(PC.COST, 0) AS MATERIALS_COST,
       COALESCE(PE.COST, 0) AS PERMITS_COST
FROM CONSTRUCTION_PROJECTS CP
INNER JOIN (
    SELECT DISTINCT ProjectID
    FROM PURCHASE_ORDERS
) PO ON CP.ProjectID = PO.ProjectID
LEFT JOIN ( --#10 #11
    SELECT ProjectID, SUM(Cost) as COST
    FROM Marketing
    GROUP BY ProjectID
) MC ON CP.ProjectID = MC.ProjectID
LEFT JOIN (
    SELECT ProjectID, SUM(Cost) as COST
    FROM PERMITS
    GROUP BY ProjectID
) PE ON CP.ProjectID = PE.ProjectID
LEFT JOIN (
    SELECT ProjectID, SUM(TotalCost) as COST
    FROM PURCHASE_ORDERS
    GROUP BY ProjectID
) PC ON CP.ProjectID = PC.ProjectID;

Select * from expenses_view;

INSERT INTO EXPENSES (ExpenseID, ProjectID, Materials, Permits, Marketing, Labor, Misc)
SELECT ExpenseID.nextval, Expenses_view.ProjectID, materials_cost, permits_cost, marketing_cost, 10000, 90000
FROM Expenses_view
WHERE Expenses_view.ProjectID = 2000;

INSERT INTO EXPENSES (ExpenseID, ProjectID, Materials, Permits, Marketing, Labor, Misc)
SELECT ExpenseID.nextval, Expenses_view.ProjectID, materials_cost, permits_cost, marketing_cost,12000, 80000
FROM Expenses_view
WHERE Expenses_view.ProjectID = 2001;

INSERT INTO EXPENSES (ExpenseID, ProjectID, Materials, Permits, Marketing, Labor, Misc)
SELECT ExpenseID.nextval, Expenses_view.ProjectID, materials_cost, permits_cost, marketing_cost, 15000, 70000
FROM Expenses_view
WHERE Expenses_view.ProjectID = 2002;

INSERT INTO EXPENSES (ExpenseID, ProjectID, Materials, Permits, Marketing, Labor, Misc)
SELECT ExpenseID.nextval, Expenses_view.ProjectID, materials_cost, permits_cost, marketing_cost, 918000, 965000
FROM Expenses_view
WHERE Expenses_view.ProjectID = 2003;

INSERT INTO EXPENSES (ExpenseID, ProjectID, Materials, Permits, Marketing, Labor, Misc)
SELECT ExpenseID.nextval, Expenses_view.ProjectID, materials_cost, permits_cost, marketing_cost, 120000, 150000
FROM Expenses_view
WHERE Expenses_view.ProjectID = 2004;

INSERT INTO EXPENSES (ExpenseID, ProjectID, Materials, Permits, Marketing, Labor, Misc)
SELECT ExpenseID.nextval, Expenses_view.ProjectID, materials_cost, permits_cost, marketing_cost, 92000, 240000
FROM Expenses_view
WHERE Expenses_view.ProjectID = 2005;

INSERT INTO EXPENSES (ExpenseID, ProjectID, Materials, Permits, Marketing, Labor, Misc)
SELECT ExpenseID.nextval, Expenses_view.ProjectID, materials_cost, permits_cost, marketing_cost, 5225000, 250000
FROM Expenses_view
WHERE Expenses_view.ProjectID = 2006;

INSERT INTO EXPENSES (ExpenseID, ProjectID, Materials, Permits, Marketing, Labor, Misc)
SELECT ExpenseID.nextval, Expenses_view.ProjectID, materials_cost, permits_cost, marketing_cost, 530000, 5260000
FROM Expenses_view
WHERE Expenses_view.ProjectID = 2007;

INSERT INTO EXPENSES (ExpenseID, ProjectID, Materials, Permits, Marketing, Labor, Misc)
SELECT ExpenseID.nextval, Expenses_view.ProjectID, materials_cost, permits_cost, marketing_cost, 1220000, 1503000
FROM Expenses_view
WHERE Expenses_view.ProjectID = 2008;

INSERT INTO EXPENSES (ExpenseID, ProjectID, Materials, Permits, Marketing, Labor, Misc)
SELECT ExpenseID.nextval, Expenses_view.ProjectID, materials_cost, permits_cost, marketing_cost, 2122000, 150000
FROM Expenses_view
WHERE Expenses_view.ProjectID = 2009;

 --#18
create unique index EXPENSES$ProjectID_Labor on EXPENSES(ProjectID,Labor);
create unique index EXPENSES$ProjectID_Marketing on EXPENSES(ProjectID,Marketing);
create unique index EXPENSES$ProjectID_Permits on EXPENSES(ProjectID,Permits);
create unique index EXPENSES$ProjectID_Materials on EXPENSES(ProjectID,Materials);
create unique index EXPENSES$ProjectID_Misc on EXPENSES(ProjectID,Misc);

-- ------------------------------------------------------------------------------------------------
CREATE TABLE Budget (
  BudgetID number(4) PRIMARY KEY,
  ProjectID number(4) NOT NULL UNIQUE,
  TotalBudget number(10) NOT NULL,
  UsedBudget number(10) NOT NULL,
  CONSTRAINT FK_BUDGET_CONSTRUCTION FOREIGN KEY (ProjectID) REFERENCES CONSTRUCTION_PROJECTS(ProjectID),
  CONSTRAINT BUDGET_TotalBudget CHECK(TotalBudget > 0 AND TOTALBUDGET > UsedBudget),
  CONSTRAINT BUDGET_UsedBudget CHECK(UsedBudget > 0 AND UsedBudget < TotalBudget)
);
CREATE SEQUENCE BudgetID START WITH 5000 INCREMENT BY 1;


Create or replace VIEW TOTAL_EXPENSES AS -- #4
SELECT PROJECTID, Materials + Permits + Marketing + Labor + Misc as Total_cost from Expenses;

INSERT INTO Budget (BudgetID, ProjectID, TotalBudget, UsedBudget)
SELECT BudgetID.nextval, TOTAL_EXPENSES.ProjectID, 60000000 , TOTAL_EXPENSES.Total_cost
FROM TOTAL_EXPENSES
WHERE TOTAL_EXPENSES.ProjectID = 2000;

INSERT INTO Budget (BudgetID, ProjectID, TotalBudget, UsedBudget)
SELECT BudgetID.nextval, TOTAL_EXPENSES.ProjectID, 200000 , TOTAL_EXPENSES.Total_cost
FROM TOTAL_EXPENSES
WHERE TOTAL_EXPENSES.ProjectID = 2001;

INSERT INTO Budget (BudgetID, ProjectID, TotalBudget, UsedBudget)
SELECT BudgetID.nextval, TOTAL_EXPENSES.ProjectID, 59200000 , TOTAL_EXPENSES.Total_cost
FROM TOTAL_EXPENSES
WHERE TOTAL_EXPENSES.ProjectID = 2002;

INSERT INTO Budget (BudgetID, ProjectID, TotalBudget, UsedBudget)
SELECT BudgetID.nextval, TOTAL_EXPENSES.ProjectID, 398000000 , TOTAL_EXPENSES.Total_cost
FROM TOTAL_EXPENSES
WHERE TOTAL_EXPENSES.ProjectID = 2003;

INSERT INTO Budget (BudgetID, ProjectID, TotalBudget, UsedBudget)
SELECT BudgetID.nextval, TOTAL_EXPENSES.ProjectID, 5000000 , TOTAL_EXPENSES.Total_cost
FROM TOTAL_EXPENSES
WHERE TOTAL_EXPENSES.ProjectID = 2004;

INSERT INTO Budget (BudgetID, ProjectID, TotalBudget, UsedBudget)
SELECT BudgetID.nextval, TOTAL_EXPENSES.ProjectID, 6000000 , TOTAL_EXPENSES.Total_cost
FROM TOTAL_EXPENSES
WHERE TOTAL_EXPENSES.ProjectID = 2005;

INSERT INTO Budget (BudgetID, ProjectID, TotalBudget, UsedBudget)
SELECT BudgetID.nextval, TOTAL_EXPENSES.ProjectID, 600000000 , TOTAL_EXPENSES.Total_cost
FROM TOTAL_EXPENSES
WHERE TOTAL_EXPENSES.ProjectID = 2006;

INSERT INTO Budget (BudgetID, ProjectID, TotalBudget, UsedBudget)
SELECT BudgetID.nextval, TOTAL_EXPENSES.ProjectID, 6050000 , TOTAL_EXPENSES.Total_cost
FROM TOTAL_EXPENSES
WHERE TOTAL_EXPENSES.ProjectID = 2007;

INSERT INTO Budget (BudgetID, ProjectID, TotalBudget, UsedBudget)
SELECT BudgetID.nextval, TOTAL_EXPENSES.ProjectID, 3000000 , TOTAL_EXPENSES.Total_cost
FROM TOTAL_EXPENSES
WHERE TOTAL_EXPENSES.ProjectID = 2008;

INSERT INTO Budget (BudgetID, ProjectID, TotalBudget, UsedBudget)
SELECT BudgetID.nextval, TOTAL_EXPENSES.ProjectID, 2450000 , TOTAL_EXPENSES.Total_cost
FROM TOTAL_EXPENSES
WHERE TOTAL_EXPENSES.ProjectID = 2009;

create unique index Budget$ProjectID_TotalBudget on Budget(ProjectID, TotalBudget);
