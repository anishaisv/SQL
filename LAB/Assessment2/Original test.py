import pyodbc
import pytest
from decimal import Decimal
import datetime

@pytest.fixture
def mysql_connection():
    # Establish a connection to MySQL database (IMPORTANT: EDIT THE HOST, USER, AND PASSWORD AS PER YOUR CREDENTIALS...)
    connection = mysql.connector.connect(
        host='localhost', # edit according to how you set up MySQL
        database='sales_db',
        user='root', # edit according to how you set up MySQL
        password='password' # edit according to how you set up MySQL
    )
    
    connection.autocommit = True

    yield connection

    if connection.is_connected():
        connection.close()

def test1(mysql_connection):
    cursor = mysql_connection.cursor()
    cursor.execute(open('1.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    assert rows == [('John Doe', Decimal('500')), ('Jane Smith', Decimal('500')), ('Bob Johnson', Decimal('240')), ('Alice Brown', Decimal('640')), ('Mary Davis', Decimal('240'))]
    
def test2(mysql_connection):
    cursor = mysql_connection.cursor()
    cursor.execute(open('2.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    assert rows == [('Widget A', 40)]
    
def test3(mysql_connection):
    cursor = mysql_connection.cursor()
    cursor.execute(open('3.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    assert rows == [('Widget A', Decimal('800')), ('Widget B', Decimal('330')), ('Widget C', Decimal('640')), ('Widget D', Decimal('350'))]
    
def test4(mysql_connection):
    cursor = mysql_connection.cursor()
    cursor.execute(open('4.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    assert rows == [(datetime.date(2023, 12, 1), 1), 
 (datetime.date(2023, 12, 2), 1), 
 (datetime.date(2023, 12, 3), 2), 
 (datetime.date(2023, 12, 5), 1), 
 (datetime.date(2023, 12, 6), 1), 
 (datetime.date(2023, 12, 7), 1), 
 (datetime.date(2023, 12, 8), 1), 
 (datetime.date(2023, 12, 9), 1)]

def test5(mysql_connection):
    cursor = mysql_connection.cursor()
    cursor.execute(open('5.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    assert rows == [('Alice Brown', Decimal('640')), ('John Doe', Decimal('500')), ('Jane Smith', Decimal('500'))]
