def report_temp():
    """
    =======================================================================
    Function:       report_temp()
    Purpose:        generate a report
    Parameter(s):   -None-
    Return:         generated report
    =======================================================================
    """
    # format screen
    # --------------
    now = datetime.datetime.now()
    print(Fore.GREEN + now.strftime("%Y-%m-%d %H:%M:%S").rjust(80))
    print(("foodinv").rjust(80))
    print("-----------------------".rjust(80))
    print(Style.RESET_ALL)
    print('')
    print(Fore.GREEN + rep_name)
    print(Fore.GREEN + '-------------------')
    print(Style.RESET_ALL)

    # display report on screen
    # ------------------------
    mysql_select_query = rep_query
    cursor = CONNECTION.cursor(buffered = True)
    cursor.execute(mysql_select_query)    
    mytable = from_db_cursor(cursor)
    mytable.align = "l"
    print(mytable)
    print('')

    # send report to browser
    # -----------------------
    printRep = input(Fore.YELLOW + 'To send this report to the browser '
                    'for printing or saving enter b or B, otherwise press '
                    'enter to return: ')
    print(Style.RESET_ALL)
    if printRep == "b" or printRep == "B":

        # generate data for report
        # ------------------------
        mysql_search_query = rep_query
        cursor = CONNECTION.cursor(buffered = True)
        cursor.execute(mysql_search_query)
        mytable1 = pd.read_sql(rep_query, CONNECTION)
        pd.set_option('display.expand_frame_repr', False)
        mytable2 = build_table(mytable1,
                             'grey_light',
                             font_size = 'small',
                             font_family = 'Open Sans, courier',
                             text_align = 'left ')
        
        # generate html content
        # ---------------------
        html_content = f"<html> \
                        <head> <h2> FOODINV Records Report - All Records\
                        </h2> \
                        <h3> <script>\
                        var timestamp = Date.now();\
                        var d = new Date(timestamp);\
                        document.write(d);\
                        </script>\
                        </h3>\
                        </head> \
                        <body> {mytable2} \
                        </body> \
                        </html>"
        with open('/data/share/foodinv/report/'+rep_name+'report_all_records.html', "w") \
            as html_file:
            html_file.write(html_content)
            print("Created")
        time.sleep(2)

        # display in browser
        # ------------------
        webbrowser.get(using='lynx').open \
            ("/data/share/foodinv/report/"+rep_name+"report_all_records.html")
        print('')
        print("You may also access your report from the Reports Directory")
        print('')
        wait = input("Press ENTER to return") 
