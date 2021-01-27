import pyodbc

##CHANGE THE VALUES WITH THE EMOJIS ♫å♫å♫å♫å♫å♫å♫å♫å♫å♫å
ConnectionString = (r'DRIVER=SQL Server;SERVER=♫å♫å♫å♫å♫å♫å♫å♫å♫å♫å;DATABASE=♫å♫å♫å♫å♫å♫å♫å♫å♫å♫å;TRUSTED_CONNECTION=TRUE;')
sfCSV    = "X:/sf.csv"   #<= The location of your CSV
SFUpdate = (r"EXEC [dbo].[InsertFirstLastNameCSV] @PathToCSV = '%s';" % (sfCSV))

def dbRetrieveData(sql):
    strConnection = pyodbc.connect(ConnectionString)
    cursor = strConnection.cursor()
    cursor.execute(sql)

    columns = [column[0] for column in cursor.description]
    totalcolumns = len(columns)
    rows = [row for row in cursor.fetchall()]
    totalrows = len(rows)

    cursor.commit()

    return totalcolumns, totalrows, columns, rows

def dbExec(s):
    strConnection = pyodbc.connect(ConnectionString)
    cursor = strConnection.cursor()
    cursor.execute(s)
    cursor.commit()

    msg = "%s records updated." %(cursor.rowcount)
    strConnection.close()

    return msg

dbExec(SFUpdate)