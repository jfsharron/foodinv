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


name = "jonas"

mss = f"name: {name}"

print(mss)