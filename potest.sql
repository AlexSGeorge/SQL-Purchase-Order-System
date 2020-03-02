set echo off
set feedback off
set verify off
set heading off

spool d:potest.txt

prompt ***** O P E N    O R D E R *****
prompt
prompt
	select 'Today''s Date:', sysdate
	from dual;
prompt
accept vpnum prompt 'Enter the Item Number: ';

	select 'Item Decription:', initcap(pname) 
	from products
	where pnum ='&vpnum';

	select 'The Current Inventory Level:', pqty
	from products
	where pnum ='&vpnum';

select 'Please select from one from one of the following suppliers: ', suppliers.snum, sname, scity, sstate, unitprice
	from suppliers, unitprice
	where pnum='&vpnum' and suppliers.snum=unitprice.snum
	and suppliers.snum =unitprice.snum;
	
		column scity heading 'Location' format a60

set heading off
prompt 
accept vsnum prompt 'Enter the Supplier Number: ';
	
	select 'Suppliers Name:', sname
	from suppliers
	where snum='&vsnum';

	select 'Address:', sadress
	from suppliers
	where snum='&vsnum';


	select '	'||initcap(scity)||', '||upper(sstate), szip
	from suppliers
	where snum ='&vsnum';

	select 'City, State Zip:', initcap(scity)||','||upper(sstate), szip
	from suppliers
	where snum= '&vsnum';

	select 'Phone:', '('||substr(sphone,1,3)||')'||substr(sphone,4,3)||'-'||substr(sphone,7,4)
	from suppliers
	where snum ='&vsnum';



prompt
accept voqty prompt 'Enter Quantity Order:';

	select 'Unit Price:', '$'||unitprice
	from unitprice
	where snum ='&vsnum' and pnum ='&vpnum';


insert into orders(onum,odate,ostatus,pnum,snum,oqty,unitprice,oamount)
select maxNum, sysdate,'open','&vpnum','&vsnum','&voqty',unitprice,unitprice*&voqty
from unitprice, counter
where pnum='&vpnum' and snum='&vsnum';



	column oamount format $9,999.99


	select 'Amount Ordered:', (orders.unitprice*sqty) torder
	from orders, unitprice
	where onum='&vonum'
	and unitprice.pnum=orders.pnum
	and unitprice.snum=orders.snum;
	


	select '***** Order Status ', ostatus
	from orders
	where onum='&vonum';
prompt

	select  '***** Purchase Order number is ----->', onum
	from orders
	where onum='&vonum';

update counter set maxNum = maxNum + 1;

commit;

spool off
