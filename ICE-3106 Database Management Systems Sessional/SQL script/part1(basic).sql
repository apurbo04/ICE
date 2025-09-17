select * from sysobjects

select name from sysobjects where xtype = 'U'

select * from authors

select au_lname,state from authors

select * from authors where state = 'TN'

select * from authors where au_lname = 'White' and state = 'CA'

-- task1:
select * from titles

select * from titles where ytd_sales> 8000

-- task2:
select title from titles where royalty > 11 and royalty < 25

-- dis3:
select * from titles order by PRICE ASC
select * from titles order by PRICE DESC

-- dis4:
select MAX(price) from titles
select MIN(price) from titles
select AVG(price) from titles
select COUNT(price) from titles

-- dis5:
select type,MAX(price) from titles GROUP BY TYPE

-- dis6:
select type,AVG(price) from titles GROUP BY TYPE HAVING AVG(price) > 15

-- task3:

-- dis7:
select "Name" = SUBSTRING(au_fname,1,1)+'.'+au_lname, phone FROM authors
