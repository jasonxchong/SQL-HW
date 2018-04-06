--1A
select first_name, last_name 
from sakila.actor

--1B
select concat(first_name,' ',last_name) as actor_name
from sakila.actor

--2A
select actor_id, first_name, last_name
from sakila.actor where first_name = 'joe'

--2B
select first_name, last_name
from sakila.actor where last_name like '%Gen%'

--2C
select last_name, first_name
from sakila.actor where last_name like '%li%'

--2D
select country_id, country
from sakila.country where country in ('Afghanistan', 'Bangladesh', 'China')

--3A
alter table sakila.actor ADD middle_name Varchar(20);

--3B
alter table actor modify middle_name BLOB;

--3C
alter table actor drop middle_name;

--4A
select last_name, count(last_name)
from sakila.actor
group by last_name

--4B
select last_name, count(*)
from sakila.actor
group by last_name
having count(*) > 1
	
--4C
update sakila.actor
set first_name = 'Harpo'
where actor_id = 172

--select first_name, last_name
--from sakila.actor where actor_id = 172

--4D
update sakila.actor set first_name = 
	case 
        when first_name = "HARPO"
			then "GROUCHO"
		else "MUCHO GROUCHO"
	end
where actor_id = 172



--5A
SHOW COLUMNS from sakila.address
SHOW CREATE TABLE sakila.address


--6A
select first_name, last_name, address
from sakila.staff as a
left join sakila.address as b on a.address_id=b.address_id

--6B
select first_name, last_name, sum(amount) as total
from sakila.staff as a
join sakila.payment as b on a.staff_id=b.staff_id
where payment_date between '2005-08-01' and '2005-08-31'
group by first_name, last_name

--6C
select title, count(actor_id) as actors
from sakila.film as a
inner join sakila.film_actor as b on a.film_id=b.film_id
group by title

--6D
select title, count(inventory_id) as counts
from sakila.film as a
left join sakila.inventory as b on a.film_id=b.film_id
where title = 'Hunchback Impossible'

--6E
select last_name, first_name, sum(amount) as total
from sakila.customer as a 
left join sakila.payment as b on a.customer_id=b.customer_id
group by last_name, first_name

--7A
select title from sakila.film
where language_id IN
	(select language_id from sakila.language where name = "English")
		AND (title LIKE "K%") OR (title LIKE "Q%")

--7B
select first_name, last_name from sakila.actor where actor_id IN
	(select actor_id from sakila.film_actor where film_id IN
		(select film_id from sakila.film where title = "Alone Trip"))

--7C
select first_name, last_name, country, email	
from sakila.customer as a 
left join sakila.country as b on a.last_update=b.last_update
where b.country = 'Canada'

--7D
select a.title, c.name
from sakila.film as a 
left join sakila.film_category as b on a.film_id=b.film_id
left join sakila.category as c on b.category_id=c.category_id
where c.name = 'family'

--7E
select a.title, count(a.title) as counts
from sakila.film as a 
left join sakila.inventory as b on a.film_id=b.film_id
left join sakila.rental as c on b.inventory_id=c.inventory_id
group by a.title
order by counts desc

--7F
select a.store_id, sum(b.amount) as sales
from sakila.staff as a
left join sakila.payment as b on a.staff_id=b.staff_id	
group by a.store_id

--7G
select a.store_id, c.city, d.country
from sakila.store as a
left join sakila.address as b on a.address_id=b.address_id
left join sakila.city as c on b.city_id=c.city_id
left join sakila.country as d on c.country_id=d.country_id

--7H
select a.name, sum(e.amount) as gross
from sakila.category as a
left join sakila.film_category as b on a.category_id=b.category_id
left join sakila.inventory as c on b.film_id=c.film_id
left join sakila.rental as d on c.inventory_id=d.inventory_id
left join sakila.payment as e on d.rental_id=e.rental_id
group by a.name
order by gross desc
limit 5

--8A
Create view sakila.top_5 as 
select a.name, sum(e.amount) as gross
from sakila.category as a
left join sakila.film_category as b on a.category_id=b.category_id
left join sakila.inventory as c on b.film_id=c.film_id
left join sakila.rental as d on c.inventory_id=d.inventory_id
left join sakila.payment as e on d.rental_id=e.rental_id
group by a.name
order by gross desc
limit 5

--8B
select * from sakila.top_5

--8C 
drop view sakila.top_5