set echo off
set feedback off
set verify off
set heading on

spool d:suppliermonthlys.txt

prompt * * * * * SUPPLIER MONTHLY Report * * * * *

prompt

column snum heading 'Supplier|Number' format a10

column sname heading 'Supplier|Name' format a15

column odate heading 'Order|Month' format a10

column count(orders.pnum)heading 'No of|Orders' format 999

column sum(oqty) heading 'Total|Units' format 99999

column  sum(oamount) heading 'Total|Amount' format $99,999.99	

select suppliers.snum, sname, to_char(odate, 'mm/yyyy') odate, count(orders.pnum), sum(oqty),sum(oamount) 
	from orders,products,suppliers
	where orders.pnum=products.pnum
	group by suppliers.snum, sname, to_char(odate, 'mm/yyyy'),orders.pnum, products.pname
	order by suppliers.snum;

spool off