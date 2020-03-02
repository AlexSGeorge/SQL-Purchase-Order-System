set echo off
set feedback off
set verify off
set heading on

spool d:suppliermonthly.txt

prompt ***** SUPPLIER MONTHLY REPORT *****

prompt

column snum heading 'Supplier|Number' format a2

column sname heading 'Suppliers|Name' format a25

column odate heading 'Order|Month' format a15

column count(pnum) heading 'No of|Orders' format 999

column sum(oqty) heading 'Total|Units' format $99,999.99

column sum(oamount) heading 'Total|Amount' format $99,999.99

Select orders.snum, suppliers.sname, to_char(odate, 'mm/yyyy') odate, count(pnum), sum(oqty), sum(oamount)
from orders, suppliers
where orders.snum=suppliers.snum
group by to_char(odate, 'mm/yyyy'), orders.snum, suppliers.sname;

spool off