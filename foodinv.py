"""
================================================================================
 Program:           foodinv.py
 Software Engineer: Jonas Sharron
 Date:              15-January-2024

 Purpose:   This program will provides a user interface for a MYSQL database
            (foodinv) and generates a csv file to facilitate printing labels. 
================================================================================
"""

import sys
import re
import pandas as pd
import openpyxl
import mysql.connector
from mysql.connector import Error
import functools
import xlsxwriter
import pandas.io.sql as sql
import numpy as np
from numpy import loadtxt
from prettytable import from_db_cursor
from prettytable import PrettyTable
import datetime
#from datetime import datetime
from datetime import date
import os
from termcolor import colored, cprint 
from colorama import Fore, Back, Style 
from tabulate import tabulate
import fpdf
import colorama
from colorama import Fore, Back, Style
import getopt
from reportlab.lib.pagesizes import LETTER
from reportlab.pdfgen.canvas import Canvas
from reportlab.lib.units import inch
import webbrowser
import time
from pretty_html_table import build_table
from sqlalchemy import create_engine
import inquirer


# ==============================================================================
# establish database connection
# ==============================================================================

XUSER       = 'jfsharron'
XWORD       = 'marie151414'
HOST        = '192.168.2.107'
DATABASE    = 'foodinv'
DATAFILE    = '//192.168.2.102/share'

try:
    CONNECTION = mysql.connector.connect(user=XUSER, password=XWORD,
    host=HOST, database=DATABASE)
    if CONNECTION.is_connected():
        db_Info = CONNECTION.get_server_info()
        print("Connected to MySQL Server version ", db_Info)
        global cursor
        cursor = CONNECTION.cursor()
        cursor.execute("select database();")
        record = cursor.fetchone()
        print("You're connected to database: ", record)
except Error as e:
    print("Error while connecting to MySQL", e)

# ==============================================================================
# intialize lists and variables
# ==============================================================================    

type_list = []
weight_unit_list = []
sub_type_list = []



# ==============================================================================
# user functions
# ==============================================================================    

def menu():
    """
    ============================================================================
    Function:       menu()
    Purpose:        entry point to allow user interaction with program
    Parameter(s):   -None-
    Return:         users desired action
    ============================================================================
    """
    os.system('cls')
    # main menu
    #----------
    goAgain = 1

    while goAgain == 1:
        # format screen
        # --------------
        now = datetime.datetime.now()
        print(Fore.GREEN + now.strftime("%Y-%m-%d %H:%M:%S").rjust(80))
        print(("foodinv").rjust(80))
        print("-----------------------".rjust(80))
        print(Style.RESET_ALL)
        print('')
        print(Fore.GREEN + 'MAIN MENU')
        print(Fore.GREEN + '-------------------')
        print(Style.RESET_ALL)
        print('1\tINPUT NEW RECORD')
        print('2\tProgram Functions')
        print('3\tReports')
        print('')
        print('')
        print('')
        print(Fore.RED + '0\tEXIT')
        print(Style.RESET_ALL)
        print('')
        print('')      



        menuOption = input("selection: ")

        if menuOption == '1':
            get_selections()
        elif menuOption == '2':
            programFunctMenu()
        elif menuOption == '3':
            newReport() 
        elif menuOption == '0':    
            goAgain = 0 

        os.system('cls')   

"""
============================================================================
Function:       get_selections()
Purpose:        allows entry of a new record into database
Parameter(s):   -None-
Return:         users desired action
============================================================================
"""
def get_selections():

    current_date    = str(datetime.datetime.now())

    global code_no
    # ==========================================================================
    # get intial code_no
    # ==========================================================================
    mysql_select_query = ("SELECT value FROM xcounter WHERE counter_id = 1")
    cursor = CONNECTION.cursor(buffered = True)
    cursor.execute(mysql_select_query) 
    code_no = cursor.fetchone()
    code_no = str(code_no)
    code_no = code_no.strip(",()'")
    # ==========================================================================


    # ==========================================================================
    # type selection
    # ==========================================================================    
    
    mysql_select_query = ("SELECT type FROM type")

    cursor = CONNECTION.cursor(buffered = True)
    cursor.execute(mysql_select_query)    
    rows = cursor.fetchall()
    for row in rows:
        row = str(row)
        row = row.strip(",()'")
        type_list.append(row)

    print('')
    questions = [
      inquirer.List('ptype',
                    message="What is the type?",
                    choices=type_list,
                    ),
    ]
    answers = inquirer.prompt(questions)
    global ptype 
    ptype = str(answers["ptype"])
    ptype = ptype.strip(",()'")

    # ==========================================================================
    # retrieve type_prefix
    # ==========================================================================
    
    qptype = ("'" + ptype + "'")
    mysql_select_query = ("SELECT type_prefix FROM type WHERE type = " + qptype)

    cursor = CONNECTION.cursor(buffered = True)
    cursor.execute(mysql_select_query) 
    global type_prefix
    type_prefix = cursor.fetchone()
    type_prefix = str(type_prefix)
    type_prefix = type_prefix.strip(",()'")

# ==============================================================================
# sub_type selection
# ==============================================================================

    mysql_select_query = ("SELECT type FROM chicken_sub")

    cursor = CONNECTION.cursor(buffered = True)
    cursor.execute(mysql_select_query)    
    rows = cursor.fetchall()
    for row in rows:
        row = str(row)
        row = row.strip(",()'")
        sub_type_list.append(row)

    questions = [
      inquirer.List('sub_type',
                    message="What is the sub_type?",
                    choices=sub_type_list,
                    ),
    ]
    answers = inquirer.prompt(questions)
    global sub_type 
    sub_type = str(answers["sub_type"])
    sub_type = sub_type.strip(",()'")

    # ==========================================================================
    # enter (optional) description
    # ==========================================================================

    global description
    description = input("enter (optional) description: ")

    # ==========================================================================
    # enter weight 
    # ==========================================================================

    print('')
    global weight
    weight= input("enter net weight: ")
    
    # ==========================================================================
    # weight_unit selection
    # ==========================================================================
    
    mysql_select_query = ("SELECT weight_unit FROM weight_unit_sub")

    cursor = CONNECTION.cursor(buffered = True)
    cursor.execute(mysql_select_query)    
    rows = cursor.fetchall()
    for row in rows:
        row = str(row)
        row = row.strip(",()'")
        weight_unit_list.append(row)

    print('')
    questions = [
      inquirer.List('weight_unit',
                    message="What is the weight unit?",
                    choices=weight_unit_list,
                    ),
    ]
    answers = inquirer.prompt(questions)
    global weight_unit  
    weight_unit = str(answers["weight_unit"])
    weight_unit = weight_unit.strip(",()'")

    # ==========================================================================
    # enter piece count
    # ==========================================================================
    
    global piece
    piece= input("enter number of pieces: ")

    # ==========================================================================
    # enter date 
    # ==========================================================================

    current_date = datetime.date.today()

    global pack_date
    print('')
    pack_date = input("enter date packaged (YYYY-MM-DD) or press enter for" + \
                       " current date: ") or current_date
    pack_date = str(pack_date)
    print('')

    # ==========================================================================
    # calculate code 
    # ==========================================================================

    global qcode
    qcode = (type_prefix + code_no)
    code_no = int(code_no)
    code_no += 1

    # ==========================================================================
    # process selections
    # ==========================================================================

    ver_pro()


"""
============================================================================
Function:       ver_pro()
Purpose:        allows user to verify input and proceed
Parameter(s):   values from get_selections()
Return:         users desired action
============================================================================
"""
def ver_pro():

    print("These are your values, are the correct?")
    print('')
    print("type: " + ptype)
    print("type_prefix: " + type_prefix)
    print("sub_type: " + sub_type)
    print("description: " + description)
    print("weight: " + weight)
    print("weight_unit: " + weight_unit)
    print("pieces: " + piece)
    print("pack_date: " + pack_date)
    print("qcode: " + qcode) 
    print('')  
    print(Fore.YELLOW + "Select 1 to save and return or pree enter")
    print("Select 2 to NOT save and return")
    print("Select 3 to save and go to the main menu")
    print("Select 4 to NOT save and return to the main menu")
    print(Style.RESET_ALL)
    print("")
    verify = input("Selection: ") or 1

    if verify == '1':
        sysParmMenu()
    elif verify == '2':
        get_selections()
    elif verify == '3':
        newReport() 
    elif verify == '4':  
        menu()



    
    
    






# ==============================================================================
#  main entry point for program
#  =============================================================================    

def main():
    """
    ============================================================================
    Function:       main()
    Purpose:        entry point to program
    Parameter(s):   -None-
    Return:         -None-
    ============================================================================
    """
    global CONNECTION

    menu()

    #print('')
    #print('')
    #print('')
    #print("type: " + ptype)
    #print("type_prefix: " + type_prefix)
    #print("sub_type: " + sub_type)
    #print("description: " + description)
    #print("weight: " + weight)
    #print("weight_unit: " + weight_unit)
    #print("pieces: " + piece)
    #print("pack_date: " + pack_date)
    #print("qcode: " + qcode) 
    #print('')
    #print('')   

    print("Closing Database Connection . . .")
    CONNECTION.close()
    print("bye . . .")

if __name__ == "__main__":
    main()

