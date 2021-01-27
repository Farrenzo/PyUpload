# PyUpload
Upload a CSV file using a stored procedure.

In your MS-SQL instance, create a table with the following convention:
[schema].[tablename]

Edit line 56 in sp.sql file with your table name. Run sp.sql file in ms-sql.

`pip install pyodbc` if you haven't already.

in dbUpload.py, lines 4 & 5 are obviously wrong, make sure the connection string is correct.
Make sure the location of the test file is correct. It's ready to run.
