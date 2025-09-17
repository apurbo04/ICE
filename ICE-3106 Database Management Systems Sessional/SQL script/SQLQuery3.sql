use pubs;

select* from sysobjects
select name from sysobjects where xtype='U'

select* from authors
select au_id, phone from authors
select phone, au_id from authors

select* from authors where city='Covelo'

select* from authors where au_lname='Green'

select* from titles
select title from titles

select title from titles where ytd_sales>8000

select title from titles where royalty>12 and royalty<24


select phone from authors
select phone from authors order by au_id 

select royalty from titles order by price desc

select price from titles order by price desc




select max(price) from titles
select min(price) from titles
select avg(price) from titles
select sum(price) from titles
select count(price) from titles
select count(phone) from authors


select type, max(price) from titles group by type

select type, avg(price) from titles group by type having avg(price) >15

select type, avg(price) from titles group by type

/* task 5  */ 
select title, price from titles 
where price >= (select avg(price) from titles) 
order by price asc

/* task 6***** important   */ 
select title, avg(price) 
from titles group by title 
having avg(price) > 15

/* task 7 */
SELECT "Name"=SUBSTRING(au_lname,1,3) + '. '+ au_lname, phone FROM authors

select "Name"=SUBSTRING(au_lname,1,2) + '. '+ au_lname from authors