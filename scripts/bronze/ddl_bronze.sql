/*
=================================================================================================================================
DDL script:  Create Bronze Tables
=================================================================================================================================
Script Purpose:
                This script creates tables in the 'bronze' schema, dropping existing tables
                if they already exits.
                Run this sript to re-define the DDL structure of 'bronze' Tables
=================================================================================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN

    DECLARE @start_time DATETIME,
            @end_time DATETIME,
            @batch_start_time DATETIME,
            @batch_end_time DATETIME;

    SET @batch_start_time = GETDATE();

    BEGIN TRY

        PRINT '===================================================================================================================';
        PRINT 'Loading the bronze layer';
        PRINT '===================================================================================================================';

        PRINT 'Loading the crm TABLES';
        PRINT '===================================================================================================================';


        -- ============================================================
        -- CRM: cust_info
        -- ============================================================

        SET @start_time = GETDATE();

        PRINT 'LOADING cust_info table';
        PRINT '======================================================================================================================';

        PRINT 'TRUNCATING cust_info TABLE';
        PRINT '=======================================================================================================================';

        TRUNCATE TABLE bronze.crm_cust_info;

        PRINT '========================================================================================================================';

        BULK INSERT bronze.crm_cust_info
        FROM 'E:\STUDY MATERIAL\PROJECTS\DATA WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_time = GETDATE();

        PRINT '>> LOAD DURATION OF cust_info table : '
            + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR)
            + ' seconds';

        SELECT COUNT(*)
        FROM bronze.crm_cust_info;


        -- ============================================================
        -- CRM: prd_info
        -- ============================================================

        TRUNCATE TABLE bronze.crm_prd_info;

        BULK INSERT bronze.crm_prd_info
        FROM 'E:\STUDY MATERIAL\PROJECTS\DATA WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SELECT COUNT(*)
        FROM bronze.crm_prd_info;


        -- ============================================================
        -- CRM: sales_details
        -- ============================================================

        TRUNCATE TABLE bronze.crm_sales_details;

        BULK INSERT bronze.crm_sales_details
        FROM 'E:\STUDY MATERIAL\PROJECTS\DATA WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SELECT COUNT(*)
        FROM bronze.crm_sales_details;


        PRINT '===================================================================================================================================';
        PRINT 'Loading the erp tables';
        PRINT '=====================================================================================================================================';


        -- ============================================================
        -- ERP: cust_az12
        -- ============================================================

        TRUNCATE TABLE bronze.erp_cust_az12;

        BULK INSERT bronze.erp_cust_az12
        FROM 'E:\STUDY MATERIAL\PROJECTS\DATA WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SELECT COUNT(*)
        FROM bronze.erp_cust_az12;


        -- ============================================================
        -- ERP: loc_a101
        -- ============================================================

        TRUNCATE TABLE bronze.erp_loc_a101;

        BULK INSERT bronze.erp_loc_a101
        FROM 'E:\STUDY MATERIAL\PROJECTS\DATA WAREHOUSE PROJECT\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SELECT COUNT(*)
        FROM bronze.erp_loc_a101;


        -- ============================================================
        -- END OF BATCH
        -- ============================================================

        SET @batch_end_time = GETDATE();

        PRINT '===========================================================================================================================================================';
        PRINT 'THE DURATION FOR LOADING THE ENTIRE DATASET IS : '
            + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR)
            + ' seconds';
        PRINT '===========================================================================================================================================================';


    END TRY


    BEGIN CATCH

        PRINT '=================================================================================================';
        PRINT 'ERROR OCCURRED DURING THE LOADING BRONZE MESSAGE';
        PRINT 'ERROR MESSAGE: ' + ERROR_MESSAGE();
        PRINT '=================================================================================================';

    END CATCH

END
GO


-- Execute the stored procedure
EXEC bronze.load_bronze;
