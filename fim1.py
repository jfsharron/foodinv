"""
================================================================================
 Program:           fim1.py
 Software Engineer: Jonas Sharron
 Date:              24-March-2025

 Purpose:   module for foodinv.py - contains common queries and formating tools 
================================================================================
"""



# ==============================================================================
# query definitions for reports (rq)
# ==============================================================================

def rq1(para):
  """
  =======================================================================
  Function:     rq1(para)    
  Purpose:      query for Report_Index
  Parameter(s): para
  Return:       ("SELECT * FROM report")
  =======================================================================
  """
  if para == 1:
    return("SELECT * FROM report")
  
def rq2(para, val, rep_name):
  """
  =======================================================================
  Function:     rq2(para, val, rep_name)    
  Purpose:      query to gather variables from report table to use in other
                queries
  Parameter(s): para, val, rep_name
  Return:       ("SELECT " + val + " FROM report WHERE name = " + rep_name)
  =======================================================================
  """
  if para == 1:
    return("SELECT " + val + " FROM report WHERE name = " + rep_name)
  


# ==============================================================================
# # report arguements
# ==============================================================================

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
      count += 1
      argno += 1
    
    val = val + ")"
    return(val)
      


