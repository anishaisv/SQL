import pyodbc
import pytest
from decimal import Decimal
from datetime import datetime, date

@pytest.fixture
def sqlserver_connection():
    # Establish a connection to SQL Server database
    connection = pyodbc.connect(
        'DRIVER=ODBC Driver 17 for SQL Server;'
	'SERVER=LAPTOP-4203KDIG;'
	'DATABASE=Sales;'
	'Trusted_Connection=yes;'
    )
    
    yield connection

    connection.close()

def test1(sqlserver_connection):
    cursor = sqlserver_connection.cursor()
    cursor.execute(open('1.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    #print(rows)
    rows = [(name, amount) for (_, name, amount) in rows]
    assert rows == [('John Doe', Decimal('500')), ('Jane Smith', Decimal('500')), ('Bob Johnson', Decimal('240')), ('Alice Brown', Decimal('640')), ('Mary Davis', Decimal('240'))]
    
def test2(sqlserver_connection):
    cursor = sqlserver_connection.cursor()
    cursor.execute(open('2.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    rows = [(name, int(quantity)) for (name, quantity) in rows]
    assert rows == [('Widget A', 40)]
   
def test3(sqlserver_connection):
    cursor = sqlserver_connection.cursor()
    cursor.execute(open('3.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    rows = [(name, amount) for (name, amount) in rows]
    assert rows == [('Widget A', Decimal('800')), ('Widget B', Decimal('330')), ('Widget C', Decimal('640')), ('Widget D', Decimal('350'))]
    
def test4(sqlserver_connection):
    cursor = sqlserver_connection.cursor()
    cursor.execute(open('4.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    rows = [(d.date() if isinstance(d, datetime) else d, count) for (d, count) in rows]
    assert rows == [(date(2023, 12, 1), 1),
        (date(2023, 12, 2), 1),
        (date(2023, 12, 3), 2),
        (date(2023, 12, 5), 1),
        (date(2023, 12, 6), 1),
        (date(2023, 12, 7), 1),
        (date(2023, 12, 8), 1),
        (date(2023, 12, 9), 1),
    ]
def test5(sqlserver_connection):
    cursor = sqlserver_connection.cursor()
    cursor.execute(open('5.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    rows = [(name, amount) for (name, amount) in rows]
    assert rows == [('Alice Brown', Decimal('640')), ('John Doe', Decimal('500')), ('Jane Smith', Decimal('500'))]
