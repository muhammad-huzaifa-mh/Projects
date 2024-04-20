/* Q1: Who is the senior most employee based on job title? */

select first_name,last_name,title 
from employee
order by levels DESC
limit 1

/* Q2: Which countries have the most Invoices? */

Select COUNT(*) , billing_country
from invoice
group by billing_country

/* Q3: What are top 3 values of total invoice? */

Select total
from invoice
order by total desc 
limit 3

/* Q4: Which city has the best customers? We would like to throw a promotional Music Festival in the city we made the most money. 
Write a query that returns one city that has the highest sum of invoice totals. 
Return both the city name & sum of all invoice totals */

select sum(total) as Total, billing_city
from invoice
group by billing_city
order by Total Desc

/* Q5: Who is the best customer? The customer who has spent the most money will be declared the best customer. 
Write a query that returns the person who has spent the most money.*/

SELECT 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name, 
    SUM(invoice.total) AS total_spending 
FROM 
    customer 
JOIN 
    invoice ON customer.customer_id = invoice.customer_id 
GROUP BY 
    customer.customer_id, 
    customer.first_name, 
    customer.last_name 
ORDER BY 
    total_spending DESC 
LIMIT 1;

/* Q6: Write query to return the email, first name, last name, & Genre of all Rock Music listeners. 
Return your list ordered alphabetically by email starting with A. */

SELECT DISTINCT email AS Email,first_name AS FirstName, last_name AS LastName, genre.name AS Name
FROM customer
JOIN invoice ON invoice.customer_id = customer.customer_id
JOIN invoice_line ON invoice_line.invoice_id = invoice.invoice_id
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name LIKE 'Rock'
ORDER BY email;

/* Q7: Return all the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */

SELECT name,milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track )
ORDER BY milliseconds DESC;
