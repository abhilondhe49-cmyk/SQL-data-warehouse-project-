/*
=======================================================================
Create Database and schemas
=======================================================================

Script Purpose:
				this script creates a new database named 'Datawarehouse' after checking if it already exits.
				if the database exits, it is dropped and recreated. Additionally, the script sets up three schemas within the database"
				'bronze' , 'silver', 'gold'

WARNING: 
		Running this sript will drop the entire 'Datawarehouse' database if it exits .
		All data in the database will be permenently deleated. Proceed with caution and 
		ensure you have proper backups before running this script.
*/
USE master
GO

-- dROP AND RECREATE THE 'Datwarehouse' database
IF EXISTS(SELECT 1 FROM sys.databases WHERE name = 'Datawarehouse')
BEGIN
	ALTER DATABASE Datawarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE
	DROP DATABASE Datawarehouse
END
GO

--Create the 'Datawarehouse' database
CREATE DATABASE Datawarehouse
GO
USE Datawarehouse
GO

CREATE SCHEMA bronze
GO

CREATE SCHEMA silver
GO

CREATE SCHEMA gold
GO



