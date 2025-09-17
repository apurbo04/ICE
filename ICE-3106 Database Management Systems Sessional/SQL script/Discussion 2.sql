select * from authors

select * from titleauthor

select au_lname, title_id 
from authors join titleauthor 
on authors.au_id = titleauthor.au_id



select * from titleview
select * from titles
select * from authors
select * from titleauthor
select * from publishers


/* task 1.1 */
select au_fname,au_lname, title 
from authors 
JOIN  titleauthor 
on authors.au_id = titleauthor.au_id
JOIN titles 
on titleauthor.title_id = titles.title_id


/* task 1.2 */
select pub_name,au_fname,au_lname,title
from authors
join titleauthor
on authors.au_id = titleauthor.au_id
join titles
on titles.title_id = titleauthor.title_id
join publishers
on publishers.pub_id = titles.pub_id
