set echo off
set feedback off
set verify off

spool	t:shortship.txt

prompt ****** SHORT SHIP REPORT ******

prompt


column PNum heading 'Prod|No' format a10

column PName heading 'Prod|Name' format a20

column shortship heading 'Shortship|Qty' format 99999

column shortshiptotal heading 'ShortShip|Amount' format $9999.99


select p.PNum, PName, shortship, sum(shortship*p.unit_price) shortshiptotal
from (select PNum, sum(ord_qty - ship_qty) as shortship, unit_price
		from orders
		group by PNum, unit_price) p, products
where p.PNum=products.PNum
group by p.PNum, PName, shortship
order by p.PNum;

spool off