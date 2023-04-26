# ConstructionDB

ConstructionDB is a database designed to manage various aspects of construction projects, including project details, contractors, managers, workers, and inspections. The database helps streamline the management of construction projects by providing a centralized system to store and access project-related data.

The following files are associated with the ConstructionDB:

- **initConstruction**: This file is responsible for loading table data into the Oracle database. It contains the necessary SQL commands to create tables, define their structure, and insert initial data. This file is crucial for setting up the database and ensuring the appropriate structure is in place.

- **dropFile**: This file contains SQL commands to drop tables from the database. It is helpful when you need to remove tables, reset the database, or perform other maintenance tasks that require deleting existing table structures.

- **sqlRun**: This file is a collection of practice SQL queries specifically designed for Oracle databases. It serves as a reference for users to learn and practice SQL queries, allowing them to interact with the ConstructionDB effectively and extract valuable insights.

- **plSQL**: This file contains various PL/SQL elements, such as procedures, triggers, functions, objects, packages, and exception handling. These elements are crucial for implementing advanced database functionality, optimizing performance, and handling complex business logic within the database.

## Main Tables

- **CONSTRUCTION_PROJECTS**: Stores essential details of each construction project, such as the project name, start date, duration, and the associated contractor.
- **CONTRACTORS**: Contains information about contractors, including their name, contact details, and company information.
- **MANAGERS**: Keeps track of project managers, including their name, contact information, and years of experience.
- **WORKERS**: Maintains records of workers involved in construction projects, including their name, contact details, wage per hour, grade, and associated manager and project.
- **PROJECT_LOCATION_DATA**: Stores project location data, such as street address, city, state, worker count, and the associated manager.


These tables are interconnected through foreign key relationships to provide comprehensive insights into construction projects, enabling efficient project management and decision-making. ConstructionDB aims to simplify the complexities of construction project management while improving collaboration and communication among team members.
