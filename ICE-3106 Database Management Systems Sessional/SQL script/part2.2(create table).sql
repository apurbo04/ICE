create table CustomerAndSuppliers2
(
cusl_id CHAR(6) primary key check (cusl_id LIKE '[CS][0-9][0-9][0-9][0-9][0-9]'),
cusl_fname CHAR(15) NOT NULL,
cusl_lname VARCHAR(15),
cusl_address TEXT,
cusl_telno CHAR(12) check (cusl_telno like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
cusl_city CHAR(12) DEFAULT 'Rajshahi',
sales_amnt MONEY CHECK(sales_amnt>=0),
proc_amnt MONEY CHECK(proc_amnt>=0)
)

-- inserting data:
insert CustomerAndSuppliers2
(cusl_id,cusl_fname,cusl_lname,cusl_address,cusl_telno,cusl_city,sales_amnt,proc_amnt)
values('C00248','Apurbo','Sharma','Bogura','017987870337','Dhaka',280,200);
insert CustomerAndSuppliers2
(cusl_id,cusl_fname,cusl_lname,cusl_address,cusl_telno,cusl_city,sales_amnt,proc_amnt)
values('C00249','Mithun','Sharma','Bogura','017987870337','Dhaka',280,200);
insert CustomerAndSuppliers2
(cusl_id,cusl_fname,cusl_lname,cusl_address,cusl_telno,cusl_city,sales_amnt,proc_amnt)
values('C00228','Apurbo','Sharma','Bogura','017987870337','Dhaka',280,200);
insert CustomerAndSuppliers2
(cusl_id,cusl_fname,cusl_lname,cusl_address,cusl_telno,cusl_city,sales_amnt,proc_amnt)
values('C00148','Apurbo','Sharma','Bogura','017987870337','Dhaka',280,200);
insert CustomerAndSuppliers2
(cusl_id,cusl_fname,cusl_lname,cusl_address,cusl_telno,cusl_city,sales_amnt,proc_amnt)
values('C00238','Apurbo','Sharma','Bogura','017987870337','Dhaka',288,200);

select * from CustomerAndSuppliers2

