set echo off
set feedback off
set verify off
set heading off

spool t:shipped.txt

prompt ****** UPDATE SHIPPING *****

prompt

accept vOrd_Num prompt 'Please enter the Order Number: ';

select 'Order Number:', Ord_Num
	from orders
	where Ord_Num='&vOrd_Num';

	select 'Order Date:', Ord_Date
		from orders
		where Ord_Num='&vOrd_Num';

select 'Customer Number:', CNum
	from orders
	where Ord_Num='&vOrd_Num';

	select ''||initcap(LName)||', '||initcap(FName)
		from customers, orders
		where customers.CNum=orders.CNum
		and Ord_Num=&vOrd_Num; 

	select ''||initcap(City)||', '||upper(State), Zip
		from customers, orders
		where customers.CNum=orders.CNum
		and Ord_Num=&vOrd_Num; 

	select 'Phone: ', '('||substr(PHONE,1,3)||')'||substr(PHONE,4,3)||'-'||substr(phone,7,4)
 		from customers, orders
		where customers.CNum=orders.CNum
		and Ord_Num=&vOrd_Num; 

select 'Product Number:', PNum
	from orders
	where Ord_Num=&vOrd_Num;
 
	select '	Product Name:', PName
		from products, orders
		where Ord_Num=&vOrd_Num
		and products.PNum=orders.PNum;

	select '	Unit Price:', '$'||Unit_Price
		from orders
		where Ord_Num=&vOrd_Num;

	select 'Quantity Ordered:', Ord_Qty
		from orders
		where Ord_Num=&vOrd_Num;

	select 'Amount Ordered:', Ord_Amt
		from orders
		where Ord_Num=&vOrd_Num;

select 'Shipping Warehouse:', WH_Num
	from orders
	where Ord_Num=&vOrd_Num;

	select '	',Address
		from warehouses, orders
		where Ord_Num=&vOrd_Num
		and warehouses.WH_Num=orders.WH_Num;

select '	'||initcap(City)||', '||upper(State), Zip
	from warehouses, orders
	where Ord_Num=&vOrd_Num