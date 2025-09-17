CREATE PROC sp_showTitleAndAuthor
AS
BEGIN
SELECT "Authors Last Name"=au_lname FROM authors where au_id in 
(select au_id from titleauthor where title_id='BU1032')
END

EXEC sp_showTitleAndAuthor


SELECT "Authors Last Name"=au_lname FROM authors where au_id in 
(select au_id from titleauthor where title_id='BU1032')