CREATE PROCEDURE [dbo].[InsertFirstLastNameCSV]
	@PathToCSV nvarchar(100)
AS
BEGIN
    SET NOCOUNT ON;
    /** Create temporary table **/
    DROP TABLE IF EXISTS #Temp;
    CREATE TABLE #Temp
    	(
    		[xID] [nvarchar](50) NULL,
    		[First_Name] [nvarchar](50) NULL,
    		[Last_Name] [nvarchar](50) NULL,
    		[DoB] [date] NULL,
    	)
    /** INSERT INTO #Temp the CSV Data **/
    DECLARE @BulkInsertStatement varchar(max)
    SET @BulkInsertStatement = 'BULK INSERT #Temp FROM ''' + @PathToCSV + '''
    WITH
    (
        FORMAT = ''CSV'', 
        FIELDQUOTE = ''"'',
        FIRSTROW = 2,
        FIELDTERMINATOR = '','',  --CSV field delimiter
        ROWTERMINATOR = ''\n'',   --Use to shift the control to next row
        TABLOCK,
    	KEEPNULLS
    )'
    EXEC (@BulkInsertStatement)
    /** Delete duplicates from temporary table **/
	WITH CTE1 AS
    (
	    SELECT
			[xID],
            [First_Name],
            [Last_Name],
            [DoB],
	        ROW_NUMBER()
            OVER
            (
	            PARTITION BY
			        [xID],
                    [First_Name],
                    [Last_Name],
                    [DoB]
	            ORDER BY
					[xID],
                    [First_Name],
                    [Last_Name],
                    [DoB]
	        ) row_num
	     FROM #Temp
	) DELETE FROM CTE1 WHERE row_num > 1;
    /** Start counting rows to see your progress**/
    SET NOCOUNT OFF;
    /** Insert into your table the pertinent Data **/
    INSERT INTO [schema].[YourTableName]
    (
        [xID],
    	[First_Name],
    	[Last_Name],
    	[DoB],
    ) SELECT * FROM #Temp;
    DROP TABLE #Temp;
END