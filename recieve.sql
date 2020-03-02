spool e:recieve.txt
set heading off
set feedback off
set echo off 
set verify off

spool d:recieve.txt

prompt ****** R E C I E V E   O R D E R ******
prompt
	select 'Today''s Date:', sysdate
	from dual;
prompt
	accept vonum prompt 'Please enter the Purchase Order number:';
prompt
	select 'Order Number:', onum
	from orders
	where onum ='&vonum';
	
	select 'Item Number:', pnum
	from orders
	where onum ='&vonum';

		select 'Item Description:', pname 
		from products, orders
		where products.pnum =orders.pnum and onum ='&vonum';

column snum format a20

	select 'Supplier Number' snum
	from orders
	where onum ='&vonum';

	select 'Supplier Name:', sname
	from suppliers, orders
	where suppliers.snum =orders.snum and onum='&vonum';


	select 'Date Ordered:', odate
	from orders
	where onum ='&vonum';

	select 'Todays''s date:', sysdate
	from dual;

		
	select 'Quantity Ordered:', rtrim(oqty)
	from orders
	where onum ='&vonum';

	select 'Unit Price', '$'||unitprice
	from orders
	where onum ='&vonum';

column oamount format $99999.99


	select 'Amount Ordered:', (orders.unitprice*sqty) torder
	from orders, unitprice
	where onum='&vonum'
	and unitprice.pnum=orders.pnum
	and unitprice.snum=orders.snum;
	
prompt

accept vrqty prompt 'Enter the Quantity Recieved:';


update orders set sdate = sysdate where onum = &vonum;
update orders set rqty = &vrqty where onum = &vonum;

column amountdue format $99999.99 

	select 'Amount Due:', (&vrqty*orders.unitprice) amountdue
	from orders, unitprice
	where onum='&vonum'
	and unitprice.pnum=orders.pnum
	and unitprice.snum=orders.snum;

update products set pqty = (pqty+'&vrqty')
	where (pnum=(select pnum
	from orders 
	where onum='&vonum'));

	select 'Inventory Level:', pqty
	from products, orders
	where onum="&vonum
	and products.pnum=orders.pnum

commit;
prompt

prompt *****************************************************************


update orders set ostatus='Close'
	where onum='&vonum';

prompt Order is now ---> closed

	select 'Date Closed:', sdate
	from orders
	where onum ='&vonum';
commit;	
	
spool off
	