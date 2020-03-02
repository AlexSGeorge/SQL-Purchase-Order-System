set echo off
set feedback off
set verify off
set heading off

spool t:aging.txt

prompt ***** AGING REPORT *****

select 'Today''s Date: ', sysdate from dual;

prompt

accept vNumday prompt 'Please enter number of days to query: ';

prompt

column Ord_Num heading 'Order|Number' format a15

column Ord_Date heading 'Order|Date' format date

column Ord_Status heading 'Order|Status' format a15

column orders.PNum heading 'Product|Num' format a15

column PName heading 'Product|Description' format a15

column Ord_Qty heading 'Order|Qty' format a15

column Unit_Price heading 'Unit|Price' format '$999.99' 

column Ord_Amt heading 'Order|Amount' format '$999.99'

column DaysOpen heading 'Days|Open' format '9999'

set heading on

Select Ord_num, 
to_char(Ord_Date,'mm/dd/yyyy') as Ord_date, 
Ord_Status, 
Orders.Pnum,
Products.Pname,
Ord_Qty,
Orders.Unit_Price,
Ord_Amt,
trunc(sysdate)-trunc(Ord_date+1) as DaysOpen
from Orders, Products
where orders.PNum=products.PNum
and ord_status = 'OPEN'
and trunc(sysdate)-trunc(Ord_date)>='&vnumday'
order by DaysOpen DESC, orders.PNum, products.PName;

commit;

spool off;
