-- dis.1(inner join)
select au_lname, title_id FROM authors JOIN titleauthor ON authors.au_id=titleauthor.au_id

-- task.1.1:
select * from titles
select * from authors

SELECT au_fname, au_lname, CONCAT(au_fname, ' ', au_lname) as full_name,
title FROM authors 
JOIN titleauthor ON authors.au_id=titleauthor.au_id 
JOIN titles ON titleauthor.title_id=titles.title_id

-- task.1.2:
SELECT au_fname, au_lname, CONCAT(au_fname, ' ', au_lname) as full_name, title,pub_name FROM authors 
JOIN titleauthor ON authors.au_id=titleauthor.au_id 
JOIN titles ON titleauthor.title_id=titles.title_id 
JOIN publishers ON titles.pub_id=publishers.pub_id

-- dis.2(cartesian product):
select au_lname,authors.city,pub_name,publishers.city 
from authors,publishers

-- task.2.3:
select au_fname,au_lname,pub_name,authors.city
from authors,publishers 
where authors.city = publishers.city

-- dis.3:
select * from titles 
where royalty = (select avg(royalty) from titles)

-- task.3:
SELECT au_fname,au_lname, CONCAT(au_fname, ' ', au_lname) as full_name FROM titles 
JOIN titleauthor on titleauthor.title_id=titles.title_id 
JOIN authors on authors.au_id=titleauthor.au_id 
WHERE royalty in (SELECT max(royalty) FROM titles) 

