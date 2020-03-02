set echo off
set feedback off
set verify off
set heading off

spool d:agingalex.txt

prompt ***** AGING REPORT *****

select 'Today''s Date: ', sysdate from dual;

accept vnumday prompt 'Please Enter number of days to query:';
prompt

set heading on 

column onum heading 'PO|Numb' format a20

column ostatus heading 'PO|Stat' format a10

column pnum heading 'Prod|Num' format a20

column pname heading 'Product|Discription' format a50

column oqty heading 'Order|Qty' format '$9999.99'

column unitprice heading 'Unit|Price' format '$9999.99'

column oamount heading 'Order|Amount' format '9999.99'

column snum heading 'SNUM' format a6

column sname heading 'SNAME' format a6

column odate heading 'Days|Open' format a6


select orders.onum, 
orders.ostatus,
orders.odate,
orders.pnum,         
products.pname, 
orders.oqty, 
orders.unitprice, 
orders.oamount, 
orders.snum,
suppliers.sname,
trunc(sysdate)-trunc(odate) as DaysOpen
from orders, products, suppliers
where orders.pnum=products.pnum 
and orders.snum=suppliers.snum
and orders.ostatus = 'OPEN'
and (trunc(sysdate)-trunc(odate))>='&vnumday'
order by DaysOpen desc;

commit;

spool off