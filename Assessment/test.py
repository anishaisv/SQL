import pyodbc
import pytest
from decimal import Decimal

@pytest.fixture
def sqlserver_connection():
    # Establish a connection to SQL Server database
    connection = pyodbc.connect(
        'DRIVER=ODBC Driver 17 for SQL Server;'
	'SERVER=LAPTOP-4203KDIG;'
	'DATABASE=social_media_db;'
	'Trusted_Connection=yes;'
    )
    
    yield connection

    connection.close()

def test1(sqlserver_connection):
    cursor = sqlserver_connection.cursor()
    cursor.execute(open('1.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    #print(rows)  # What you fetched
    #print([[type(col) for col in row] for row in rows])  # Data types correctly
    rows = [(name, int(score)) for (name, score) in rows]
    assert rows == [('sunset_lover', 400), ('sky_wanderer', 350), ('neon_ninja', 250), ('starlight_dancer', 200), ('zen_master', 150)]
    
def test2(sqlserver_connection):
    cursor = sqlserver_connection.cursor()
    cursor.execute(open('2.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()

    rows = [(name.strip(),) for (name,) in rows]  # CLEAN the data

    assert rows == [('sunset_lover',)]

def test3(sqlserver_connection):
    cursor = sqlserver_connection.cursor()
    cursor.execute(open('3.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    rows = [(name.strip(), int(val1), int(val2)) for (name, val1, val2) in rows]

    assert rows == [('starlight_dancer', 120, 450)]

def test4(sqlserver_connection):
    cursor = sqlserver_connection.cursor()
    cursor.execute(open('4.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
   
    rows = [row[0] for row in rows]  # extract the first element
    assert rows == [2]

def test5(sqlserver_connection):
    cursor = sqlserver_connection.cursor()
    cursor.execute(open('5.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()

    # Convert second element (count) to int
    rows = [(gender, int(count)) for (gender, count) in rows]

    assert rows == [('Female', 1250), ('Male', 1200), ('Other', 600)]

def test6(sqlserver_connection):
    cursor = sqlserver_connection.cursor()
    cursor.execute(open('6.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    # Cast the single value to int
    rows = [(int(value),) for (value,) in rows]

    assert rows == [(645,)]

def test7(sqlserver_connection):
    cursor = sqlserver_connection.cursor()
    cursor.execute(open('7.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    rows = [(Decimal(str(val)),) for (val,) in rows]
    assert rows == [(Decimal('600'),), (Decimal('900'),), (Decimal('800'),)]

def test8(sqlserver_connection):
    cursor = sqlserver_connection.cursor()
    cursor.execute(open('8.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    rows = [(str(name).strip(), int(score)) for (name, score) in rows]
    assert rows == [('sky_wanderer', 900), ('sunset_lover', 800), ('neon_ninja', 600)]

