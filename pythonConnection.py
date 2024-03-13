import mysql.connector
from mysql.connector import Error

# When true, the program is closed
exit = False

# Setting up database connection
try:
  mydb = mysql.connector.connect(
    host="localhost",
    # Fill with user and password from your own local MySQL server !!
    user=" ",     
    password=" "  
  )
  print(mydb)
  if mydb.is_connected():
        db_Info = mydb.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        mycursor = mydb.cursor()
        mycursor.execute("USE employment_agency") # chooses database to be used
        mycursor.execute("SHOW DATABASES")
        record = mycursor.fetchall()
        print("You're connected to database(s): ", record)

except Error as e:
    print("Error while connecting to MySQL", e)
    exit=True

# Variable for main program execution
options = ['Open View', 'Add record', 'Exit']

# Function to print after a SELECT statement has been executed
def cursorToTable():
  myresult = mycursor.fetchall()
  print("\n")
  table = []
  for row in myresult:
    rowPrint=""
    for x in row:
      rowPrint+=f"{str(x)}, "
    rowList = rowPrint.split(", ")
    table.append(rowList)

  return table

# Function menu to choose view to print in console
def openView():
  views = ["FullTimeJobs","AppsPerJob","AppsWithCertifs","MarchMayJobs"]
  print("=========================================")
  print("Choose a view:")
  for i in range(len(views)):
        print(f"{i+1}. {views[i]}")
  print("=========================================")
    
  userAnswer = input("Enter choice: ")
  match userAnswer:
    case "1":
      mycursor.execute("SELECT * FROM FulltimeJobs")
      table = cursorToTable()
      # Prints column names in specified format
      print('| {:^30} | {:^65} | {:^9} | {:^27} | {:^20} | {:^11} | {:^15} |'.format(*mycursor.column_names))
      print('\n')
      # Prints each record in specified format
      for row in table:
        print('| {:>30} | {:>65} | {:>9} | {:>27} | {:>20} | {:>11} | {:>15} |'.format(*row))
      print('\n')

    case "2":
      mycursor.execute("SELECT * FROM AppsPerJob")
      table = cursorToTable()
      # Prints column names in specified format
      print('| {:^10} | {:^27} | {:^30} | {:^10} | {:^9} | {:^11} | {:^15} | {:^20} | {:^15} |'.format(*mycursor.column_names))
      print('\n')
      # Prints each record in specified format
      for row in table:
        print('| {:>10} | {:>27} | {:>30} | {:>10} | {:>9} | {:>11} | {:>15} | {:>20} | {:>15} |'.format(*row))
      print('\n')

    case "3":
      mycursor.execute("SELECT * FROM AppsWithCertifs")
      table = cursorToTable()
      # Prints column names in specified format
      print('| {:^13} | {:^11} | {:^11} | {:^26} | {:^5} | {:^10} | {:^14} | {:^20} | {:^9} | {:^27} | {:^21} |'.format(*mycursor.column_names))
      print('\n')
      # Prints each record in specified format
      for row in table:
        print('| {:>13} | {:>11} | {:>11} | {:>26} | {:>5} | {:>10} | {:>14} | {:>20} | {:>9} | {:>27} | {:>21} |'.format(*row))
      print('\n')

    case "4":
      mycursor.execute("SELECT * FROM MarchMayJobs")
      table = cursorToTable() 
      # Prints column names in specified format
      print('| {:^30} | {:^65} | {:^9} | {:^25} | {:^10} | {:^15} | {:^15} | {:^7} | {:^20} |'.format(*mycursor.column_names))
      print('\n')
      # Prints each record in specified format
      for row in table:
        print('| {:>30} | {:>65} | {:>9} | {:>25} | {:>10} | {:>15} | {:>15} | {:>7} | {:>20} |'.format(*row))
      print('\n')

    case _:
      print("\nNo view was chosen. Returning to main menu... \n")
      
# Prompts user to type values to add a record to the table specified in the argument
def addRecord(tableName):
  mycursor.execute(f"DESCRIBE `{tableName}`")
  result = mycursor.fetchall()
  userInsert = []
  mySql_insert_query = f"INSERT INTO `{tableName}` ("

  # IgnoreFirst ensures that certain tables skip the first (id) attribute while Position-JobTag and UniqueCertificate tables dont
  ignoreFirst = False
  if(tableName != "Position-JobTag" and tableName != "UniqueCertificate"):
    ignoreFirst = True

  # Asks for user input for each column (except auto incremented id where applies)
  for i in range(ignoreFirst,len(result)):
    userInput = input(f"Insert a value of type {result[i][1]} for {result[i][0]}: ")
    userInsert.append(userInput)

  # Adds appropiate column names to mySql_insert_query
  for i in range(ignoreFirst,len(result)):
    if(i < len(result)-1):
      mySql_insert_query+=f"{result[i][0]}, "
    else:
      mySql_insert_query+=f"{result[i][0]}"

  # Adds appropiate amount of placeholders to mySql_insert_query
  mySql_insert_query+=") VALUES ("
  for i in range(ignoreFirst,len(result)):
    if(i < len(result)-1):
      mySql_insert_query+="%s, "
    else:
      mySql_insert_query+="%s)"

  # mySql_inser_query now has the following format:
  # INSERT INTO TableName (attr1, attr2, attr3 ...) VALUES ( %s, %s, %s)

  try:
    mycursor.execute(mySql_insert_query, userInsert)  # Finally INSERT statement is sent to execute on database
    mydb.commit()
    print("\nInsertion complete!\n")
  except mysql.connector.Error as error:
    print("\nFailed to insert into MySQL table {}\n".format(error)) # If there is an error while executing, the error will print in console
    


def recordMenu():
  entities = ["Applicant","Application","Certificatioin","Employer","JobTag","Position","Position-JobTag","UniqueCertificate"]
  print("=========================================")
  print("Choose a table:")
  for i in range(len(entities)):
        print(f"{i+1}. {entities[i]}")
  print("=========================================")
    
  userAnswer = input("Enter choice: ")
  match userAnswer:
    case "1":
      addRecord(entities[0])
    case "2":
      addRecord(entities[1])
    case "3":
      addRecord(entities[2])
    case "4":
      addRecord(entities[3])
    case "5":
      addRecord(entities[4])
    case "6":
      addRecord(entities[5])
    case "7":
      addRecord(entities[6])
    case "8":
      addRecord(entities[7])
    case _:
      print("\nNo table was chosen\n")

# Main program
while(not exit):
    print("=========================================")
    print("Employment Agency Database System (EADS)")
    for i in range(len(options)):
        print(f"{i+1}. {options[i]}")
    print("=========================================")
    
    userAnswer = input("Enter choice: ")

    match userAnswer:
      case "1":
        openView()
      case "2":
        recordMenu()
      case "3":
        print("Goodbye.")
        exit = True
        mycursor.close()
        mydb.close()
      case _:
        print("\nNo choice was selected...\n")