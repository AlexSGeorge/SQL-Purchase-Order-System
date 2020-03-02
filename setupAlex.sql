set echo on

spool d:setupAlex.txt

 /* Drop Tables */

drop table Orders;

drop table unitprice;

drop table products;

drop table suppliers;

drop table counter;

 /* Create Tables */

create table suppliers (
	snum varchar2(2),
	sname varchar2(20),
	sadress varchar2(15),
	scity varchar2(15),
	sstate varchar2(15),
	szip char(5),
	sphone char(10),
	primary key (snum));

create table products (
	pnum varchar2(2),
	pname varchar2(20),
	pqty varchar2(5),
	primary key (pnum));

create table unitprice (
	snum varchar2(2),
	pnum varchar2(2),
	unitprice number(6,2),
	amountdue varchar2(5),
	torder varchar2(5),
	primary key (snum,pnum),
	constraint suppliersfk foreign key (snum) references suppliers(snum),
	constraint productsfk1 foreign key (pnum) references products(pnum));

create table orders (
	onum varchar2(10),
	odate date,
	ostatus varchar2(6),
	pnum varchar2(2),
	snum varchar2(2),
	oqty number(6,2),
	unitprice number(6,2),
	oamount varchar2(15),
	sdate date,
	sqty varchar2(5),
	rqty varchar2(5),
	samount varchar2(15),
	primary key (onum),
	constraint suppliersfk2 foreign key (snum) references suppliers(snum),
	constraint productsk foreign key (pnum) references products(pnum));

create table counter ( 
	maxNum number(4));

insert into counter values (1000);
	

commit;

	
 /* Insert Suppliers Values */

insert into suppliers values ('S1','Staples','123 Main st.','San Jose','CA','95070','4088210001');

insert into suppliers values ('S2','Office Depo','120 Union dr.','Campbell','CA','98003','4088210002');

insert into suppliers values ('S3','Dunder-Mifflin','223 Polard ave.','Los Gatos','CA','98051','4088210003');

insert into suppliers values ('S4','PaperCo','13500 Quito rd.','Saratoga','CA','95070','4088210004');

insert into suppliers values ('S5','Office Supplies','100 Beach dr.','Santa Cruz','CA','90002','4088210005');

insert into suppliers values ('S6','BuyLarge','560 West dr.','Morgan Hill','CA','98002','4088210006');

 /* Insert Product Values */

insert into products values ('P1','Paper','10');

insert into products values ('P2','Pen','10');

insert into products values ('P3','tape','10');

insert into products values ('P4','folder','10');	

insert into products values ('P5','pencil','10');

insert into products values ('P6','staples','10');

 /* UnitPrice Values */


 	/* Suppliers1 */

insert into unitprice values ('S1','P1','1.0', null, null);

insert into unitprice values ('S1','P2','2.0', null, null);

insert into unitprice values ('S1','P3','3.0', null, null);

insert into unitprice values ('S1','P4','4.0', null, null);

insert into unitprice values ('S1','P5','5.0', null, null);

insert into unitprice values ('S1','P6','6.0', null, null);

 	/* Suppliers2 */

insert into unitprice values ('S2','P1','1.1', null, null);

insert into unitprice values ('S2','P2','2.1', null, null);

insert into unitprice values ('S2','P3','3.1', null, null);

insert into unitprice values ('S2','P4','4.1', null, null);

insert into unitprice values ('S2','P5','5.1', null, null);

insert into unitprice values ('S2','P6','6.1', null, null);

 	/* Suppliers3 */

insert into unitprice values ('S3','P1','1.2', null, null);

insert into unitprice values ('S3','P2','2.2', null, null);

insert into unitprice values ('S3','P3','3.2', null, null);

insert into unitprice values ('S3','P4','4.2', null, null);

insert into unitprice values ('S3','P5','5.2', null, null);

insert into unitprice values ('S3','P6','6.2', null, null);

	 /* Suppliers4 */

insert into unitprice values ('S4','P1','1.3', null, null);

insert into unitprice values ('S4','P2','2.3', null, null);

insert into unitprice values ('S4','P3','3.3', null, null);

insert into unitprice values ('S4','P4','4.3', null, null);

insert into unitprice values ('S4','P5','5.3', null, null);

insert into unitprice values ('S4','P6','6.3', null, null);

 	/* Suppliers5 */

insert into unitprice values ('S5','P1','1.4', null, null);

insert into unitprice values ('S5','P2','2.4', null, null);

insert into unitprice values ('S5','P3','3.4', null, null);

insert into unitprice values ('S5','P4','4.4', null, null);

insert into unitprice values ('S5','P5','5.4', null, null);

insert into unitprice values ('S5','P6','6.4', null, null);

 	/* Suppliers6 */

insert into unitprice values ('S6','P1','1.5', null, null);

insert into unitprice values ('S6','P2','2.5', null, null);

insert into unitprice values ('S6','P3','3.5', null, null);

insert into unitprice values ('S6','P4','4.5', null, null);

insert into unitprice values ('S6','P5','5.5', null, null);

insert into unitprice values ('S6','P6','6.5', null, null);

     /*  Orders  */

insert into orders values ('1000','1-may-18','open','P1','S1',10, 1.0,'10','2-may-18','10','9','10.00');


insert into orders values ('1001','4-may-2018' ,'open','P1','S2',10, 1.1,'10','5-may-2018','10','9','11.00');


insert into orders values ('1002','6-may-18','open','P1','S3',10, 1.2,'10','7-may-18','10','9','12.00');


insert into orders values ('1003','8-may-18','open','P1','S4',10, 1.3,'10','9-may-18','10','9','13.00');


insert into orders values ('1004','10-may-18' ,'open','P1','S5',10, 1.4,'10','11-may-18','10','9','14.00');


insert into orders values ('1005','12-may-18','closed','P1','S6',10, 1.5,'10','12-may-18','10','10','15.00');






 /* Describe Tables */

describe suppliers;
describe products;
describe unitprice;
describe orders; 
describe counter;

 /* Select Tables */

select * from suppliers;
select * from products;
select * from unitprice;
select * from orders;
select * from counter;


spool off