set echo off
set feedback off
set verify off
set heading on

spool t:salesreport.txt

prompt ***** SALES REPORT *****

prompt

column PNum heading 'Prod|No' format a15

column PName heading 'Product|Name' format a15

column Ord_Date1 heading 'Order|Month' format a15

column count(orders.PNum) heading 'No of|Orders' format 999

column sum(Ord_Qty) heading 'Total|Units' format 99999

column sum(Ord_Amt) heading 'Total|Amount' format $99,999.99	


select orders.PNum, products.PName, to_char(Ord_Date, 'mm/yyyy') Ord_Date1, count(orders.PNum), sum(Ord_Qty), sum(Ord_Amt)
	from orders, products
	where orders.PNum=products.PNum
	group by to_char(Ord_Date, 'mm/yyyy'), orders.PNum, products.PName;


spool off