/* Count the total number of artists */
SELECT 	COUNT(artist_id) AS Total_artist 
FROM artist;

/* Show all genres in the database */
SELECT name AS genre_name
FROM genre;

/* tracks priced above $1.00 */
SELECT name as songs, unit_price
FROM track
WHERE unit_price > 1.00;

/* Show the cheapest track */
SELECT name, unit_price
FROM track 
ORDER BY unit_price
LIMIT 1;

/* List all countries where customers are located */
SELECT DISTINCT country
FROM customer;

/* Senior most employee based on job title */
SELECT * FROM employee;
SELECT * FROM employee
ORDER BY levels DESC
LIMIT 1;

/* Which country have the most Invoices */
SELECT * FROM invoice;
SELECT COUNT(*) AS "Total Count", billing_country
FROM invoice
GROUP BY billing_country
ORDER BY "Total Count" DESC;

/* Top 3 values of total invoice */
SELECT total FROM invoice
ORDER BY total DESC
LIMIT 3;

/* Which city has the best customers. Return both the city name & sum of all invoice 
totals */
SELECT billing_city, SUM(total) AS total_invoice 
FROM invoice
GROUP BY billing_city 
ORDER BY total_invoice DESC
LIMIT 1;

/* The customer who has spent the most money */
SELECT a.customer_id, a.first_name, a.last_name, SUM(b.total) AS total
FROM customer as a
JOIN invoice as b
ON a.customer_id = b.customer_id
GROUP BY a.customer_id
ORDER BY total DESC
LIMIT 1;

/* Query to return the email, first name, last name, & Genre of all Rock Music listeners. 
 list ordered alphabetically by email starting with A. */
SELECT DISTINCT email,first_name, last_name
FROM customer
JOIN invoice ON customer.customer_id = invoice.customer_id
JOIN invoice_line ON invoice.invoice_id = invoice_line.invoice_id
WHERE track_id IN(
	SELECT track_id FROM track
	JOIN genre ON track.genre_id = genre.genre_id
	WHERE genre.name LIKE 'Rock'
)
ORDER BY email;

/* Top Artist name and total track count of the top 10 rock bands. */
SELECT artist.artist_id, artist.name, COUNT(artist.artist_id) AS Number_of_Songs
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE  genre.name LIKE 'Rock'
GROUP BY artist.artist_id
ORDER BY number_of_songs DESC
LIMIT 10;

/* All the track names that have a song length longer than the average song length. 
Return the Name and Milliseconds for each track. Order by the song length with the longest songs listed first. */
SELECT NAME, milliseconds
FROM track
WHERE milliseconds > (
	SELECT AVG(milliseconds) AS avg_track_length
	FROM track )
ORDER BY milliseconds DESC;

/* All Rock songs with their artists */
SELECT track.name AS song_name, artist.name AS artist_name
FROM track
JOIN album ON album.album_id = track.album_id
JOIN artist ON artist.artist_id = album.artist_id
JOIN genre ON genre.genre_id = track.genre_id
WHERE genre.name = 'Rock';

/* Total sales revenue by genre */
SELECT genre.name AS genre_name, SUM(invoice_line.unit_price * invoice_line.quantity) AS total_revenue
FROM invoice_line
JOIN track ON track.track_id = invoice_line.track_id
JOIN genre ON genre.genre_id = track.genre_id
GROUP BY genre.name
ORDER BY total_revenue DESC;

/* Average invoice total by billing country */
SELECT billing_country, AVG(total) AS avg_invoice_total
FROM invoice
GROUP BY billing_country
ORDER BY avg_invoice_total DESC;























