set echo off
set feedback off
set verify off

spool	d:shortship.txt

prompt ****** SHORT SHIP REPORT ******

prompt

column onum heading 'PO|Numb' format 9999

column ostatus heading 'PO|Status' format a10

column odate heading 'Date|Open' format a10

column pnum heading 'Prod|Num' format 9999

column pname heading 'Prod|Description' format a20

column oqty heading 'Order|Qty' format 9999

column rqty heading 'Recieve|Qty' format 9999

column oqty heading 'Short|qty' format 9999

column snum heading 'SNUM' format a4

column sname heading 'SNAME'format a10


select onum, ostatus, products.pnum, pname, oqty, rqty, oqty-rqty, suppliers.snum, sname 
		from orders, products, suppliers
		where products.pnum=orders.pnum
		and suppliers.snum=orders.snum 
		order by products.pnum;


spool off