
-- PROJECT_COSTS table : to store the average project labor cost per hour and the standard deviation in wage for each project
CREATE TABLE PROJECT_COSTS(
    PROJECT_COST_ID NUMBER(4) PRIMARY KEY,
    PROJECTID NUMBER(4),
    PJ_WAGE_PER_HOUR NUMBER(10,5),
    STDEV_IN_WAGE NUMBER(10,5),
    CONSTRAINT FK_PJCOSTS_CONSTRUCTION FOREIGN KEY (PROJECTID) REFERENCES CONSTRUCTION_PROJECTS(PROJECTID)
);
create sequence PROJECT_COST_SQ increment by 1 start with 1000;

DROP SEQUENCE PROJECT_COST_SQ ;
TRUNCATE TABLE PROJECT_COSTS; -- delete all rows from the table

-- PURPOSE: To calculate the average project labor cost per hour  and the standard deviation in wage for each project
-- #1 , #2, #3 , #4, #7
CREATE OR REPLACE PROCEDURE PROJECT_COST_PROCEDURE AS 
    project_id CONSTRUCTION_PROJECTS.ProjectID%TYPE;
    project_wage_per_hour  NUMBER(8,3);
    avg_project_wage NUMBER(8,3);
    deviation_in_wage  NUMBER(8,3);
    CURSOR projectID_cursor IS SELECT ProjectID FROM CONSTRUCTION_PROJECTS;
    project_iter projectID_cursor%ROWTYPE;

    -- #4 exception
    EXCEPTION_MISSING_OR_INCONSISTENT_DATA EXCEPTION; -- user defined exception

BEGIN
    FOR project_iter IN projectID_cursor -- a cursor 
    LOOP
        project_id := project_iter.ProjectID;

        BEGIN
            -- calculating average wage per hour and standard deviation in wage for each project
            SELECT AVG(WagePerHour), STDDEV(WagePerHour) INTO avg_project_wage, deviation_in_wage
            FROM WORKERS
            WHERE Project = project_id;

            -- #4
            IF avg_project_wage IS NULL OR deviation_in_wage IS NULL THEN
                RAISE EXCEPTION_MISSING_OR_INCONSISTENT_DATA;
            END IF;

            -- calculating average wage per hour for each project
            SELECT (SUM(WorkerCount)*avg_project_wage) INTO project_wage_per_hour
            FROM PROJECT_LOCATION_DATA pl
            WHERE pl.Project = project_id;

            DBMS_Output.Put_Line(project_id || ' ' || project_wage_per_hour || ' ' || deviation_in_wage); -- debugging 

            -- Using MERGE statement to insert or update the 'project ID', 'project_wage_per_hour', and 'deviation_in_wage' in the PROJECT_COSTS table
            MERGE INTO PROJECT_COSTS pc
            USING (SELECT project_id AS p_id, project_wage_per_hour AS p_wage_per_hour, deviation_in_wage AS p_deviation FROM DUAL) new_data
            ON (pc.ProjectID = new_data.p_id)
            WHEN MATCHED THEN
                UPDATE SET pc.PJ_WAGE_PER_HOUR = new_data.p_wage_per_hour, pc.STDEV_IN_WAGE = new_data.p_deviation
            WHEN NOT MATCHED THEN
                INSERT (PROJECT_COST_ID, ProjectID, PJ_WAGE_PER_HOUR, STDEV_IN_WAGE)
                VALUES (PROJECT_COST_SQ.NEXTVAL, new_data.p_id, new_data.p_wage_per_hour, new_data.p_deviation);

        EXCEPTION -- user defined exception
            WHEN EXCEPTION_MISSING_OR_INCONSISTENT_DATA THEN
                DBMS_Output.Put_Line('Missing or inconsistent data for ProjectID ' || project_id || '. Skipping this project.');
            END;  -- handling inside the loop so that the procedure can continue to run for other projects
    END LOOP;
    EXCEPTION -- system defined exception
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR: ' || SQLCODE || ' ' || SQLERRM);
            RAISE;
END;

EXECUTE PROJECT_COST_PROCEDURE;


SELECT * FROM PROJECT_COSTS;

-- #2 #3, #4, #7
-- using a CURSOR to UPDATE
-- PURPOSE : To update the WorkerCount column in the PROJECT_LOCATION_DATA table for each project manually
CREATE OR REPLACE PROCEDURE UPDATE_WORKER_COUNT AS 
  project_id NUMBER;
  worker_count NUMBER;
  CURSOR update_workers IS
    SELECT Project, COUNT(WorkerID) AS WorkerCount
    FROM WORKERS
    GROUP BY Project; -- grouping by project to get the count of workers for each project
  update_val update_workers%ROWTYPE;

BEGIN
  -- creating a cursor to retrieve the ProjectID and count of workers from the WORKERS table for each project
  OPEN update_workers;
  LOOP
    BEGIN
      FETCH update_workers INTO update_val; -- fetching the values from the cursor
      EXIT WHEN update_workers%NOTFOUND;
      project_id := update_val.Project;
      worker_count := update_val.WorkerCount;
      
      -- updating the WorkerCount column in the PROJECT_LOCATION_DATA table for the corresponding project
      UPDATE PROJECT_LOCATION_DATA SET WorkerCount = worker_count WHERE Project = project_id;

      -- if no rows found to update
      IF SQL%ROWCOUNT = 0 THEN
        RAISE NO_DATA_FOUND;
      END IF;

    --exception handling -- system defined exception
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
        DBMS_Output.Put_Line('No data found for ProjectID ' || project_id || '. Skipping this project.');
    END; -- handling inside the loop so that the procedure can continue to run for other projects
  END LOOP;
  CLOSE update_workers; -- closing the cursor
END UPDATE_WORKER_COUNT;

EXECUTE UPDATE_WORKER_COUNT;

--TEST
INSERT INTO WORKERS (WorkerID, FirstName, LastName, Email, PhoneNumber, WAGEPERHOUR, Grade, Role, Project, Manager) VALUES 
(WorkerID.NEXTVAL, 'Adam', 'Smith', 'adam.smith@gmail.com', '416-123-4567', 20, 'A', 'Mason', 2000, 1000);

SELECT * FROM PROJECT_LOCATION_DATA;

-----
-- PURPOSE : To auto-update the WorkerCount column in the PROJECT_LOCATION_DATA table for each project
--#2, #4, #5
CREATE OR REPLACE TRIGGER PROJECT_LOCATION_DATA_WorkerCountUpdate
AFTER INSERT OR DELETE OR UPDATE ON WORKERS
FOR EACH ROW
    -- using a row level trigger
BEGIN
  IF INSERTING THEN
  -- updating the workerCount = workerCount + 1 in the Project_Location_data if a new row is inserted to the Workers Table
    UPDATE PROJECT_LOCATION_DATA
    SET WorkerCount = WorkerCount + 1
    WHERE Project = :NEW.Project;
    
    
  ELSIF DELETING THEN
  -- updating the workerCount = workerCount - 1 in the Project_Location_data if a new row is inserted to the Workers Table
    UPDATE PROJECT_LOCATION_DATA
    SET WorkerCount = WorkerCount - 1
    WHERE Project = :OLD.Project;

  ELSIF UPDATING THEN
  -- updating the worker count = workerCount - 1 at Project = :OLD.Project 
  -- updating the worker count = workerCount + 1 at Project = :NEW.Project 
    IF :OLD.Project != :NEW.Project THEN
      UPDATE PROJECT_LOCATION_DATA
      SET WorkerCount = WorkerCount - 1
      WHERE Project = :OLD.Project;

      UPDATE PROJECT_LOCATION_DATA
      SET WorkerCount = WorkerCount + 1
      WHERE Project = :NEW.Project;
    END IF;
  END IF;
EXCEPTION -- system defined exception
  WHEN OTHERS THEN
    RAISE;   
END PROJECT_LOCATION_DATA_WorkerCountUpdate;

-- #2, #4, #5 
-- PURPOSE: To auto-update the used_budget column in the BUDGET table for each project
CREATE OR REPLACE TRIGGER update_used_budget_expenses
  AFTER UPDATE ON EXPENSES
  FOR EACH ROW
DECLARE
  labor_difference NUMBER(10) := 0;
  materials_difference NUMBER(10) := 0;
  permits_difference NUMBER(10) := 0;
  marketing_difference NUMBER(10) := 0;
  misc_difference NUMBER(10) := 0;
BEGIN
-- dynamic updating based on the SET clause in the UPDATE statement
  IF UPDATING('LABOR') THEN
    labor_difference := :NEW.LABOR - :OLD.LABOR;
  END IF;

  IF UPDATING('MATERIALS') THEN
    materials_difference := :NEW.MATERIALS - :OLD.MATERIALS;
  END IF;

  IF UPDATING('PERMITS') THEN
    permits_difference := :NEW.PERMITS - :OLD.PERMITS;
  END IF;

  IF UPDATING('MARKETING') THEN
    marketing_difference := :NEW.MARKETING - :OLD.MARKETING;
  END IF;

  IF UPDATING('MISC') THEN
    misc_difference := :NEW.MISC - :OLD.MISC;
  END IF;

-- updating the used_budget column in the BUDGET table for the corresponding project
  UPDATE BUDGET
  SET USEDBUDGET = USEDBUDGET + labor_difference + materials_difference + permits_difference + marketing_difference + misc_difference
  WHERE PROJECTID = :NEW.PROJECTID;
EXCEPTION -- system defined exception
  WHEN OTHERS THEN 
    RAISE;
END update_used_budget_expenses;

SELECT * FROM EXPENSES;

SELECT * FROM BUDGET;


--TEST
UPDATE EXPENSES
    SET MISC = 1,
    MARKETING = 1
    WHERE PROJECTID = 2009;

--#2, #4, #6
-- PURPOSE: A function to calculate the updated wage of a worker based on their grade (WORKERS table)
CREATE OR REPLACE FUNCTION calculate_updated_wage (worker_id IN WORKERS.WorkerID%TYPE) 
RETURN WORKERS.WagePerHour%TYPE IS
updated_wage WORKERS.WagePerHour%TYPE;
worker_grade WORKERS.Grade%TYPE;
BEGIN
  -- selecting the grade of the worker
  SELECT Grade INTO worker_grade FROM WORKERS WHERE WorkerID = worker_id;

  -- calculating the updated wage based on the grade
  -- if the grade is not A, B, or C, the wage is not updated
  SELECT WagePerHour * (
    CASE worker_grade
      WHEN 'A' THEN 1.10
      WHEN 'B' THEN 1.05
      WHEN 'C' THEN 1.02
      ELSE 1
    END
  ) INTO updated_wage
  FROM WORKERS
  WHERE WorkerID = worker_id;

  RETURN updated_wage;
EXCEPTION -- system defined exception
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Worker not found');
  WHEN OTHERS THEN
    RAISE;
END calculate_updated_wage;

--#4, #7
-- PURPOSE: A procedure to update the wage of all workers in the WORKERS table
CREATE OR REPLACE PROCEDURE UPDATE_WORKER_WAGES AS
  CURSOR cursor_workers IS
    SELECT WorkerID FROM WORKERS;

  worker_id WORKERS.WorkerID%TYPE;
  updated_wage WORKERS.WagePerHour%TYPE;
  r_worker cursor_workers%ROWTYPE;
BEGIN
  FOR r_worker IN cursor_workers LOOP -- looping through the cursor
    worker_id := r_worker.WorkerID;

    updated_wage := calculate_updated_wage(worker_id);

    -- updating the worker's wage in the database
    UPDATE WORKERS
    SET WagePerHour = updated_wage
    WHERE WorkerID = worker_id;

    DBMS_OUTPUT.PUT_LINE('Worker ID: ' || worker_id || ', updated wage: ' || updated_wage);
  END LOOP;
EXCEPTION -- system defined exception
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;

EXECUTE UPDATE_WORKER_WAGES;

SELECT * FROM WORKERS;


-- #4, #6, #9
-- PURPOSE: A function to calculate the total expenses of a project (uses an object type)

CREATE TYPE return_array IS VARRAY(4) OF NUMBER; -- creating a VARRAY (OBJECT) to return multiple values 

CREATE OR REPLACE FUNCTION total_expenses_function (
  p_project_id IN CONSTRUCTION_PROJECTS.ProjectID%TYPE
) RETURN return_array AS
  costs return_array := return_array(); -- initializing the VARRAY (OBJECT)
BEGIN
  costs.extend(4); -- extending the VARRAY (OBJECT) to hold 4 values

  -- wage per hour * 8 hours * 5 days * 4 weeks * months  = labor_costs
  SELECT SUM(WagePerHour * (to_number(REGEXP_SUBSTR(cp.DURATION, '\d+')) * 4 * 8 * 5)) INTO costs(1)
  FROM WORKERS w, CONSTRUCTION_PROJECTS cp
  WHERE w.PROJECT = p_project_id AND cp.PROJECTID = p_project_id;

  -- selecting the sum of the costs from each table
  SELECT SUM(COST) INTO costs(2)
  FROM MARKETING
  WHERE PROJECTID = p_project_id;

  SELECT SUM(COST) INTO costs(3)
  FROM PERMITS
  WHERE PROJECTID = p_project_id;

  SELECT SUM(TOTALCOST) INTO costs(4)
  FROM PURCHASE_ORDERS
  WHERE PROJECTID = p_project_id;

  RETURN costs; -- returning the VARRAY
EXCEPTION -- system defined exception
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20002, 'Project not found or no workers assigned');
  WHEN OTHERS THEN
    RAISE;
END total_expenses_function;

/* debugging 
DECLARE 
expense_array return_array;
BEGIN
    FOR cu IN (SELECT * from CONSTRUCTION_PROJECTS)
    LOOP
        expense_array := total_expenses_function(cu.projectid);
        DBMS_OUTPUT.PUT_LINE(cu.projectid);
        FOR i IN 1..expense_array.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE('Expense ' || i || ': ' || expense_array(i));
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    END LOOP;
END;
*/

SELECT * FROM CONSTRUCTION_PROJECTS;
-- #4, #7, #3
CREATE OR REPLACE PROCEDURE update_expense_table AS
BEGIN
  DECLARE
    expense_array return_array;
    CURSOR project_cursor IS SELECT ProjectID FROM CONSTRUCTION_PROJECTS;
    project_record CONSTRUCTION_PROJECTS%ROWTYPE;
    project_exists NUMBER;
  BEGIN
    FOR project_record IN project_cursor LOOP
      SELECT COUNT(*) INTO project_exists FROM PROJECT_COSTS WHERE PROJECTID = project_record.ProjectID;
      IF project_exists = 0 THEN 
          CONTINUE;
      END IF;

      expense_array := total_expenses_function(project_record.ProjectID);


      UPDATE EXPENSES
      SET LABOR = expense_array(1),
          MARKETING = expense_array(2),
          PERMITS = expense_array(3),
          MATERIALS = expense_array(4)
      WHERE PROJECTID = project_record.ProjectID;
    END LOOP;
  EXCEPTION -- system defined exception
    WHEN OTHERS THEN
      RAISE;
  END;
END update_expense_table;


EXECUTE update_expense_table;

SELECT * FROM EXPENSES;


-- #7 Package and package body
-- PURPOSE: A package to calculate the updated wage of a worker based on their grade (WORKERS table)
CREATE OR REPLACE PACKAGE worker_wages_package AS 
    FUNCTION calculate_updated_wage (worker_id IN WORKERS.WorkerID%TYPE) RETURN WORKERS.WagePerHour%TYPE;
    PROCEDURE update_worker_wages;
END worker_wages_package; -- package specification


-- package body
CREATE OR REPLACE PACKAGE BODY worker_wages_package AS

FUNCTION calculate_updated_wage (worker_id IN WORKERS.WorkerID%TYPE) 
RETURN WORKERS.WagePerHour%TYPE IS
updated_wage WORKERS.WagePerHour%TYPE;
worker_grade WORKERS.Grade%TYPE;
BEGIN
  SELECT Grade INTO worker_grade FROM WORKERS WHERE WorkerID = worker_id;

  SELECT WagePerHour * (
    CASE worker_grade
      WHEN 'A' THEN 1.10
      WHEN 'B' THEN 1.05
      WHEN 'C' THEN 1.02
      ELSE 1
    END
  ) INTO updated_wage
  FROM WORKERS
  WHERE WorkerID = worker_id;

  RETURN updated_wage;
EXCEPTION -- system defined exception
  WHEN NO_DATA_FOUND THEN
    RAISE_APPLICATION_ERROR(-20001, 'Worker not found');
  WHEN OTHERS THEN
    RAISE;
END calculate_updated_wage;

PROCEDURE UPDATE_WORKER_WAGES AS
  CURSOR cursor_workers IS
    SELECT WorkerID FROM WORKERS;

  worker_id WORKERS.WorkerID%TYPE;
  updated_wage WORKERS.WagePerHour%TYPE;
  r_worker cursor_workers%ROWTYPE;
BEGIN
  FOR r_worker IN cursor_workers LOOP
    worker_id := r_worker.WorkerID;

    updated_wage := calculate_updated_wage(worker_id);

    -- updating the worker's wage in the database
    UPDATE WORKERS
    SET WagePerHour = updated_wage
    WHERE WorkerID = worker_id;

    DBMS_OUTPUT.PUT_LINE('Worker ID: ' || worker_id || ', updated wage: ' || updated_wage);
  END LOOP;
EXCEPTION -- system defined exception
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
END worker_wages_package;

-- executing the package
EXECUTE worker_wages_package.UPDATE_WORKER_WAGES;

SELECT * FROM WORKERS;

SELECT * FROM USER_ERRORS;

-- #8 Objects 

-- creating a type for the PERSON object
CREATE TYPE PERSON AS OBJECT(
    FIRSTNAME VARCHAR2(32),
    LASTNAME VARCHAR(32),
    EMAIL VARCHAR2(128),
    PHONENUMBER VARCHAR(12)
);


-- creating a type for the MANAGERS_TY object to insert into the MANAGERS table
CREATE OR REPLACE VIEW MANAGERS_TY(ManagerID, Person, YearsOfExperience) AS 
select ManagerID,
	PERSON(FIRSTNAME, LASTNAME, EMAIL, PHONENUMBER), YearsOfExperience
from Managers;

-- creating a type for the WORKERS_TY object to insert into the WORKERS table
CREATE OR REPLACE VIEW WORKERS_TY(WorkerID, Person, WagePerHour, Grade, Role, Project, Manager) AS 
select WorkerID,
	PERSON(FIRSTNAME, LASTNAME, EMAIL, PHONENUMBER), WagePerHour, Grade, Role, Project, Manager 
from Workers;

--granting privileges (select, insert) to the public only on the MANAGERS_TY and WORKERS_TY views but not on the underlying tables
GRANT SELECT, INSERT ON MANAGERS_TY TO PUBLIC;
GRANT SELECT, INSERT ON WORKERS_TY TO PUBLIC;

-- remove privileges from the underlying tables
REVOKE SELECT, INSERT ON MANAGERS FROM PUBLIC;
REVOKE SELECT, INSERT ON WORKERS FROM PUBLIC;

-- inserting data into the MANAGERS_TY view
INSERT INTO MANAGERS_TY VALUES
(ManagerID.NEXTVAL, PERSON('John', 'Smith', 'john.smith@gmail.com', '123-456-7890'), 5);



