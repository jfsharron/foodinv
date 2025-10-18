<u>03/15/2025 Commit 1e29e2e</u>

* added changestes 25-37 to changelog
* added report table to db and converted reporting functions to query that table
* added report_temp2 function to format data from query to generate report
* add report_temp function to generate report
* added reports to report table
* removed previous function with hard coded queries to     generate rports

<u>03/22/2025 Commit 1e29e2ef</u>

* added fim1 module to transition queries to (dry) storage
* created functionality to store report queries in table, currently testing but will change report table structures in next commit
* eliminated rep_temp2 (desundant and not needed)
* created new (test) report table




<u>03/24/2025 Commit 635d579</u>

* need to DROP testrep table
* created fim1 module to (dry) store queries
* cleaned report coding from last commit
* removed test table and added report table
* corrected code and databeases bugs created during new report implamentation

<u>in progress</u>

* add function to slect report from list
* add all records, instock report
* select * from inv where discard=0 order by type, sub_type, date_packaged;
