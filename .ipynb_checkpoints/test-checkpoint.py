import mysql.connector
import pytest
from decimal import Decimal

@pytest.fixture
def mysql_connection():
    # Establish a connection to MySQL database (IMPORTANT: EDIT THE HOST, USER, AND PASSWORD AS PER YOUR CREDENTIALS...)
    connection = mysql.connector.connect(
        host='localhost', # edit according to how you set up MySQL
        database='social_media_db',
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
    assert rows == [('sunset_lover', 400), ('sky_wanderer', 350), ('neon_ninja', 250), ('starlight_dancer', 200), ('zen_master', 150)]
    
def test2(mysql_connection):
    cursor = mysql_connection.cursor()
    cursor.execute(open('2.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    assert rows == [('sunset_lover',)]
    
def test3(mysql_connection):
    cursor = mysql_connection.cursor()
    cursor.execute(open('3.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    assert rows == [('starlight_dancer', 120, 450)]
    
def test4(mysql_connection):
    cursor = mysql_connection.cursor()
    cursor.execute(open('4.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    assert rows == [(2,)]

def test5(mysql_connection):
    cursor = mysql_connection.cursor()
    cursor.execute(open('5.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    assert rows == [('Female', 1250), ('Male', 1200), ('Other', 600)]
    
def test6(mysql_connection):
    cursor = mysql_connection.cursor()
    cursor.execute(open('6.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    assert rows == [(645,)]

def test7(mysql_connection):
    cursor = mysql_connection.cursor()
    cursor.execute(open('7.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    assert rows == [(Decimal('600'),), (Decimal('900'),), (Decimal('800'),)]
    
def test8(mysql_connection):
    cursor = mysql_connection.cursor()
    cursor.execute(open('8.sql', 'r').read())
    rows = cursor.fetchall()
    cursor.close()
    assert rows == [('sky_wanderer', 900), ('sunset_lover', 800), ('neon_ninja', 600)]
