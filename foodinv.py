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
import iquirer




XUSER       = 'jfsharron'
XWORD       = 'marie151414'
HOST        = '192.168.2.107'
DATABASE    = 'foodinv'
DATAFILE    = '//192.168.2.102/share'

#print(USER)

# establish database connection
# =============================
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
        print(("isbn-22 ").rjust(80))
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
            inputNew()
        elif menuOption == '2':
            programFunctMenu()
        elif menuOption == '3':
            newReport() 
        elif menuOption == '0':    
            goAgain = 0 

        os.system('cls')   

"""
============================================================================
Function:       inputNew()
Purpose:        allows entry of a new record into database
Parameter(s):   -None-
Return:         users desired action
============================================================================
"""
def inputNew():
    current_date    = str(datetime.datetime.now())
    questions = [
        inquirer.List()
    ]


    #type            = input("Enter food type (required): ")
    #sub_type        = input("Enter food sub type (required): ")
    #description     = input("Enter description (optional): ")
    #net_weight      = input("Enter net weight (required): ")
    #weight_unit     = input("Enter the weight unit of measure: ") or "pounds"
    #pieces          = input("Enter number of pieces (required): ")
    #date_packaged   = input("Enter date packaged (required): ") or \
    #                        current_date
    #code            = input("Enter code: ")

    print('')
    print('')
    print('')

    print("type: " + type)
    print("sub_type: " + sub_type)
    print("description: " + description)
    print("net_weight: " + net_weight )
    print("weight_unit: " + weight_unit)
    print("pieces: " + pieces)
    print("date_packaged: " + date_packaged)
    print("code: " + code)        








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
    #preProcess()
    #createLists()
    #getInfo()
    #getGenre()
    #exportLists()
    menu()

    print("Closing Database Connection . . .")
    CONNECTION.close()
    print("bye . . .")

if __name__ == "__main__":
    main()

