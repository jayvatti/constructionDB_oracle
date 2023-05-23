CREATE OR REPLACE VIEW UPCOMING_INSPECTIONS AS --#4
SELECT CP.ProjectID, CP.ProjectName, 
to_char(INSPECTIONDATE,'FMMonth FMDD, FMYYYY') as InspectionDate, 
INSPECTIONTYPE, InspectorName,
TRUNC(INSPECTIONDATE) - TRUNC(SYSDATE) as "Days Until Inspection" --#6
FROM INSPECTIONS I
INNER JOIN PROJECT_LOCATION_DATA PL ON I.LocationID = PL.LocationID
INNER JOIN CONSTRUCTION_PROJECTS CP ON PL.Project = CP.ProjectID
WHERE INSPECTIONDATE > SYSDATE
with read only;

Select * from upcoming_inspections;

Select * from workers;

savepoint Workers;
--deleting workers who did not put effort to participate in training and have an F in their Grade
DELETE FROM WORKERS
WHERE WORKERID IN (SELECT WORKERID FROM WORKERS WHERE GRADE = 'F' AND WORKERID NOT IN (SELECT WORKERID FROM TRAINING));

-- the above query has changed in the number of workers
-- to update the number of workers 
UPDATE PROJECT_LOCATION_DATA --#14
SET WORKERCOUNT = (SELECT COUNT(*) as WORKERCOUNT
                   FROM WORKERS 
                   WHERE PROJECT = PROJECT_LOCATION_DATA.Project 
                   GROUP BY PROJECT)



CREATE OR REPLACE VIEW SUMMARY AS -- #4
SELECT CP.ProjectID, CP.ProjectName as "Project Name", 
PL.StreetAddress || ', ' || PL.CITY || ', ' || PL.STATE as Address, 
M.FirstName || ' ' || M.LastName as Manager,
C.FirstName || ' ' || C.LastName as Contractor,
to_char(CP.Startdate, 'FMMonth FMDD, FMYYYY') as "Start Date",
to_char(ADD_MONTHS(CP.StartDate, to_number(SUBSTR(CP.DURATION, 1, INSTR(CP.DURATION, ' ') - 1))), --#5 -- #7
'FMMonth FMDD, FMYYYY') as "Estimated End Date",
A.Type as Type,
DECODE(PL.WORKERCOUNT,NULL,'NOT IN PROGRESS',PL.WORKERCOUNT) as "Worker Count" --#8
FROM CONSTRUCTION_PROJECTS CP, PROJECT_LOCATION_DATA PL, Managers M, Contractors C, Architecture A
WHERE CP.ProjectID = PL.Project AND PL.Manager = M.ManagerID 
AND CP.Contractor = C.ContractorID AND CP.ProjectID = A.ProjectID
with read only;

Select * from summary;
-- to see suppliers that send large quantites to re-order stuff with good cost_per_unit


-- partition by is used to divide the data into groups. 
-- It is used to divide the data into groups and then perform the aggregate function on each group.
CREATE OR REPLACE VIEW SUPPLIER_REPORT AS -- #4
SELECT MATERIAL, SUPPLIER, COST_PER_UNIT
FROM (
  SELECT material, supplier, cost/quantity AS cost_per_unit,
         ROW_NUMBER() OVER (PARTITION BY material ORDER BY cost/quantity) AS RN
  FROM (
      SELECT supplier, material, SUM(quantity) AS QUANTITY, SUM(TotalCost) AS COST -- #6
        FROM PURCHASE_ORDERS
        GROUP BY supplier, material
        HAVING SUM(quantity) > 1000 -- #9
  )
)
WHERE RN = 1; -- partition by material. Only the first row of each group is selected.

Select * from supplier_report;


CREATE OR REPLACE VIEW TRAINING_UPDATE AS
SELECT WORKERID, TRAININGID, DESCRIPTION
FROM TRAINING;

savepoint create TRAINING_UPDATE_SP; --#12

INSERT INTO TRAINING_UPDATE (WORKERID, TRAININGID, DESCRIPTION) -- #13
SELECT WORKERID, TRAININGID.NEXTVAL, 'Basic Training Needed'
FROM WORKERS
WHERE GRADE IN ('C', 'F')
AND WORKERID NOT IN (SELECT WORKERID FROM TRAINING_UPDATE); --#10

SELECT * FROM TRAINING_UPDATE;

select * from training;


UPDATE TRAINING
SET TRAININGDATE = TO_DATE('03-15-2023','MM-DD-YYYY'),  --#7
    TRAININGTYPE = 'Basic Training'
WHERE DESCRIPTION LIKE 'Basic%';

--to remove training updates that are no longer relevant or that have been superseded by more recent updates.
DELETE FROM TRAINING_UPDATE WHERE DESCRIPTION LIKE 'Basic%'; -- #12

rollback to TRAINING_UPDATE_SP;


-------------

-- JOIN and WHERE

SELECT a.ArchitectName, a.Type, Decode(cp.ProjectName, NULL, 'N\A',cp.PROJECTNAME), Decode(a.PROJECTID, NULL, 'N\A',a.PROJECTID)
FROM ARCHITECTURE a
INNER JOIN CONSTRUCTION_PROJECTS cp ON cp.ProjectID = a.ProjectID;


SELECT a.ArchitectName, a.Type, 
       DECODE((SELECT cp.ProjectName FROM Construction_Projects cp WHERE cp.ProjectID = a.ProjectID), NULL, 'N/A', (SELECT cp.ProjectName FROM Construction_Projects cp WHERE cp.ProjectID = a.ProjectID)),
       DECODE(a.ProjectID, NULL, 'N/A', a.ProjectID)
FROM Architecture a
WHERE a.ProjectID IN (SELECT cp.ProjectID FROM Construction_Projects cp);

-------------

SELECT Material, SUM(quantity) as TotalQuantity, projectID 
FROM PURCHASE_ORDERS 
GROUP BY Material, projectID
ORDER BY projectID;

-- rollup for the quantity of material
SELECT Material, SUM(quantity) as TotalQuantity, projectID 
FROM PURCHASE_ORDERS 
GROUP BY ROLLUP(Material, projectID)
ORDER BY projectID;

--rollup for the quantity of total material for each project
SELECT Material, SUM(quantity) as TotalQuantity, projectID 
FROM PURCHASE_ORDERS 
GROUP BY ROLLUP(projectID, material)
ORDER BY projectID;

-- cube for both quantity of material for the entire construction management and quantity of total material for each project
SELECT Material, SUM(quantity) as TotalQuantity, projectID 
FROM PURCHASE_ORDERS 
GROUP BY CUBE(projectID, material)
ORDER BY projectID;

-- GROUPING -- 1 if the column's value is generated by ROLL UP
SELECT DECODE(GROUPING(Material),1,'All Materials',Material) as Materials, SUM(quantity) as TotalQuantity,
DECODE(GROUPING(projectID), 1, 'All Projects', ProjectID) as Project FROM PURCHASE_ORDERS 
GROUP BY CUBE(projectID, material)
ORDER BY projectID;








COMMIT;
