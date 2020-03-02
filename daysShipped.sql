set echo off
set feedback off
set verify off

spool t:daystoship.txt

prompt ***** AVERAGE DAYS TO SHIP BY WAREHOUSE ******

prompt

column wh heading 'Warehouse' format a20

column avgship heading 'AvgDaystoShip' format 999.99


select t.WH_Num wh, City, State, avgship
	from (select WH_Num, avg(trunc(ship_date) - trunc(ord_date) + 1)  as avgship
			from orders
			group by WH_Num) t, warehouses
	where t.WH_Num=warehouses.WH_Num
	group by t.WH_Num, City, State, avgship
	order by t.WH_Num;

spool off