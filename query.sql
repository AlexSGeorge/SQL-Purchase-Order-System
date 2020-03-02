spool e:query.txt
set heading off
set feedback off
set echo off 
set verify off

spool d:query.txt

prompt ****** Q U E R Y   O R D E R ******
prompt
	select 'Today''s Date:', sysdate
	from dual;
prompt
	accept onum prompt 'Please enter the Purchase Order number:';
prompt
prompt
	select 'Purchase Order Number:', onum
	from orders
	where onum ='&vonum';
	
	select 'Item Number:', pnum
	from orders
	where onum ='&vonum';

		select 'Item Description:', pname 
		from products, orders
		where products.pnum =orders.pnum and onum ='&vonum';


	select 'Current Inventory', sqty
	from orders
	where onum ='&vonum';

	select 'Supplier Number', snum
	from orders
	where onum ='&vonum';

	select 'Supplier Name:', sname
	from suppliers, orders
	where suppliers.snum =orders.snum and onum='&vonum';
prompt
prompt

	select 'Date Ordered:', odate
	from orders
	where onum ='&vonum';

	
	select 'Quantity Ordered:', rtrim(sqty)
	from orders
	where onum ='&vonum';


	select 'Date Recieved:', rqty
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

column amountdue format $99999.99 

	select 'Amount Due:', (&vrqty*orders.unitprice) amountdue
	from orders, unitprice
	where onum='&vonum'
	and unitprice.pnum=orders.pnum
	and unitprice.snum=orders.snum;
prompt
prompt

	select 'Date Closed:', sdate
	from orders
	where onum ='&vonum';

update orders set ostatus='Close'
	where onum='&vonum';


	