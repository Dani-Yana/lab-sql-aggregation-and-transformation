/* Challenge 1 
-- 1. You need to use SQL built-in functions to gain insights relating to the duration of movies:
-- 1.1 Determine the shortest and longest movie durations and name the values as max_duration and min_duration.*/
use sakila;
select * from film;
select max(length) as max_duration,min(length) as min_duration from film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
select DATE_FORMAT(SEC_TO_TIME(AVG(length) * 60), '%H:%i') as average_movie_time from film;

/* 2.You need to gain insights related to rental dates:
 2.1 Calculate the number of days that the company has been operating.*/
select DATEDIFF(max(rental_date),min(rental_date)) as days_of_operation from rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
select * from rental;
select rental_date, 
       DATE_FORMAT(rental_date, '%M') AS month, 
       DATE_FORMAT(rental_date, '%W') AS weekday 
from rental
limit 20;

/*  3.You need to ensure that customers can easily access information about the movie collection. To achieve this, retrieve the film titles and their rental duration. 
-- If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order. */
select title, coalesce(rental_duration, 'Not Available') as rental_duration
from film;

/* Challenge 2
1. Next, you need to analyze the films in the collection to gain some more insights. Using the film table, determine:
1.1 The total number of films that have been released. */
select * from film;
select count(film_id) as total_number_of_films_released from film;

/*  1.2 The number of films for each rating.
1.3 The number of films for each rating, sorting the results in descending order of the number of films. This will help you to better understand the popularity of different 
film ratings and adjust purchasing decisions accordingly.*/
select distinct rating, count(title) as count from film
group by rating
order by count desc;

/* Using the film table, determine:
2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. 
This will help identify popular movie lengths for each category.*/
select * from film;
select round(avg(length),2) as average_lenght, rating from film
group by rating
order by average_lenght desc;

-- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films for customers who prefer longer movies.
select round(avg(length),2) as average_lenght, rating from film
group by rating
having avg(length) > 120;



