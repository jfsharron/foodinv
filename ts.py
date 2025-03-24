import sys
import re
import pandas as pd
import openpyxl
from openpyxl import load_workbook
from openpyxl import Workbook
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
from copy import copy
import fim1
import fibo
import re

#a = '"cat"'
#a= input("input: ")
#
#a= (f'"{a}"')
#
#print(a)




def rep2(clis):
    """
    =======================================================================
    Function:     rep2(para)
    Purpose:      format arguement list sor reports
    Parameter(s): para - the number of arguements being passed
    Return:       formated string to print arguements
    =======================================================================
    """
  
    val = "x.format(avalue_list[0]"
    
    clis = int(clis)
    count = 0
    argno = 1

    while count < (clis - 1):
      val = val + ", avalue_list[" + str(argno) + "]"
      #val = str(val)
      print(val)
      count += 1
      argno += 1
    
    val = val + ")"
    return(val)



clis = input("enter value: ")
#rep2(clis)

x = rep2(clis)

print("X " + x)