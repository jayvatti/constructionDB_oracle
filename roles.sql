CREATE USER admin IDENTIFIED BY password;
GRANT DBA TO admin;

CREATE ROLE manager_role;
GRANT CREATE SESSION, CREATE TABLE, CREATE VIEW, CREATE PROCEDURE TO manager_role;


CREATE PROFILE project_manager_profile LIMIT
FAILED_LOGIN_ATTEMPTS 5
PASSWORD_LIFE_TIME 30
PASSWORD_REUSE_MAX 3
PASSWORD_REUSE_TIME UNLIMITED;

CREATE USER JAY IDENTIFIED BY jay_password
PROFILE project_manager_profile;
GRANT CREATE SESSION TO JAY;

CREATE USER CARSON IDENTIFIED BY carson_password
PROFILE project_manager_profile;
GRANT CREATE SESSION TO CARSON;

GRANT manager_role TO JAY;

ALTER USER JAY account unlock; -- when locked


-- DROP
DROP USER JAY;
DROP USER john CASCADE; -- drops all the objects created by the user

-- USER 
GRANT SELECT, UPDATE ON your_table TO CARSON WITH GRANT OPTION WITH HIERARCHY OPTION;
      -- with grant option: allows 'CARSON' to grant these privileges to other users
      -- with hierarchy option: grants these privileges on all subtypes of "your_table".

GRANT UPDATE (column1, column2) ON your_table TO CARSON;

-- DBA
ALTER USER CARSON QUOTA 100M ON USERS;

-- REVOKE
REVOKE CREATE TABLE FROM JAY;
REVOKE CREATE VIEW FROM manager_role;
REVOKE manager_role FROM JAY;


