-- Creating database and tables
/*
create database coffee_shop;

drop table if exists city;
drop table if exists  customers;
drop table if exists products;
drop table if exists sales;

-- Creating city table

create table city
(
city_id	int primary key,
city_name	varchar (10),
population	int,
estimated_rent	int,
city_rank int
);

-- Creating customers table

create table customers
(
customer_id int primary key,	
customer_name	varchar (25),
city_id int,
constraint fk_city foreign key (city_id) references city(city_id) 
);

-- Creating products table

create table products
(
product_id int primary key,
product_name varchar(50),
price float
);

-- Creating the sales table

create table sales
(
sale_id	int primary key,
sale_date	date,
product_id	int,
customer_id	int,
total	float,
rating float,
constraint fk_products foreign key (product_id) references products(product_id),
constraint fk_customers foreign key (customer_id) references customers(customer_id) 
);
*/


-- Coffee shop data analysis

-- Q1. Coffee consumer count
-- How many people in each city consume coffee, given that 25% of of the population does

select
city_name,
population,
city_rank,
round((population * 0.25)/1000000,2) as coffee_consumers_in_millions
from
city
order by coffee_consumers_in_millions desc;

-- Q2. Total revenue from coffee sales
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?

select 
sum(total) as total_revenue
from sales
where year(sale_date) = 2023 and quarter(sale_date) = 4;

-- Total revenue per city in last quarter of 2023
select 
ci.city_name,
sum(s.total) as total_revenue
from sales as s
join customers as c
on s.customer_id = c.customer_id
join city as ci
on ci.city_id = c.city_id
where year(s.sale_date) = 2023 and quarter(s.sale_date) = 4
group by ci.city_name
order by total_revenue desc;


-- Q3. Sales count for each product
-- How many units of each product have been sold?

select 
p.product_name,
count(s.sale_id) as product_sold
from products as p
left join sales as s
on s.product_id = p.product_id 
group by p.product_name
order by product_sold desc;

-- Q4. Average sales amount per city
-- What is the average sales amount per customer in each city?

select c.city_name,
sum(s.total) as total_sale_amount,
count(distinct cs.customer_id) as total_customers,
round((sum(s.total)) / (count(distinct cs.customer_id)),2) as sale_amount_per_customer
from sales as s
join customers as cs
on s.customer_id = cs.customer_id
join city  as c
on c.city_id = cs.city_id
group by c.city_name
order by sale_amount_per_customer desc;

-- Q5. City population and coffee consumers
-- Provide a list of cities along with their population and estimated coffee consumers
with city_table as
(
select 
city_name,
round(((population * 0.25)/1000000),2) as coffee_consumers_in_millions
from city
),
customers_table as
(
select 
c.city_name,
count(distinct cs.customer_id) as customers_per_city
from city c
join customers cs
on cs.city_id = c.city_id
group by c.city_name
)

select 
ct.city_name,
ct.coffee_consumers_in_millions,
cst.customers_per_city
from city_table ct
join customers_table cst
on ct.city_name = cst.city_name
order by cst.customers_per_city desc;

-- Q6. Top selling products by city
-- What are the top 3 selling product in each city based on sales volume?
select *
from
(select 
c.city_name,
p.product_name,
count(s.sale_id) as total_units_sold,
dense_rank() over(partition by c.city_name order by count(s.sale_id) desc) as ranking 
from products p
join sales s
on s.product_id = p.product_id
join customers cx
on s.customer_id = cx.customer_id
join city c
on c.city_id = cx.city_id
group by c.city_name, p.product_name
order by c.city_name, count(s.sale_id) desc
) as table1
where ranking <= 3;

-- Q7. Customer segmentation by city
-- How many unique customers are present in each city who purchased a product?

select 
c.city_name,
count(distinct s.customer_id) as customer,
count(s.sale_id) as products_purchased
from city c
join customers cx
on c.city_id = cx.city_id
join sales s
on s.customer_id = cx.customer_id
join products p
on s.product_id = p.product_id
where s.product_id <= 14	
group by c.city_name
order by c.city_name;
-- order by products_purchased desc;

-- Q8. Average sale vs rent
-- Average sale per customer vs average rent per customer

with sale_table
as
(
select c.city_name,
sum(s.total) as total_sale_amount,
count(distinct cs.customer_id) as total_customers,
round((sum(s.total)) / (count(distinct cs.customer_id)),2) as sale_amount_per_customer
from sales as s
join customers as cs
on s.customer_id = cs.customer_id
join city  as c
on c.city_id = cs.city_id
group by c.city_name
order by sale_amount_per_customer desc
),
rent_table
as
(
select city_name,
estimated_rent
from city 
)

select 
st.city_name,
rt.estimated_rent,
st.total_customers,
st.sale_amount_per_customer,
round((rt.estimated_rent/st.total_customers),2) as average_rent_per_customer
from sale_table st
join rent_table rt
on st.city_name = rt.city_name
order by st.sale_amount_per_customer desc, round((rt.estimated_rent/st.total_customers),2);

-- Q9. Monthly sales growth
-- Calculate the percentage growth (or decline) in sales over different time periods (monthly) per city

 with current_month_sale
 as
 (
select 
c.city_name,
month(s.sale_date) as month,
year(s.sale_date) as year, 
sum(s.total) as total_sales
from sales as s
join customers cx
on s.customer_id = cx.customer_id
join city c
on c.city_id = cx.city_id
group by c.city_name, month, year
order by c.city_name, year, month
),

last_month_sale
as
(select 
city_name,
month,
year,
total_sales as current_month_sale,
lag(total_sales, 1) over (partition by city_name order by year, month) as previous_month_sale
from current_month_sale
)

select 
city_name,
month,
year,
current_month_sale,
previous_month_sale,
round((current_month_sale - previous_month_sale)/previous_month_sale*100,2) as monthly_growth_rate
from last_month_sale
where previous_month_sale is not null;

-- Q10. Market potential analysis
-- Identify top 3 cities based on highest sales

with sale_table
as
(
select c.city_name,
sum(s.total) as total_sale_amount,
count(distinct cs.customer_id) as total_customers,
round((sum(s.total)) / (count(distinct cs.customer_id)),2) as sale_amount_per_customer
from sales as s
join customers as cs
on s.customer_id = cs.customer_id
join city  as c
on c.city_id = cs.city_id
group by c.city_name
order by sale_amount_per_customer desc
),
rent_table
as
(
select city_name,
estimated_rent,
round((population*0.25)/1000000,2) as coffee_consumers_in_millions
from city 
)

select 
st.city_name,
total_sale_amount,
rt.estimated_rent as total_rent,
st.total_customers,
coffee_consumers_in_millions,
st.sale_amount_per_customer,
round((rt.estimated_rent/st.total_customers),2) as average_rent_per_customer
from sale_table st
join rent_table rt
on st.city_name = rt.city_name
order by total_sale_amount desc, total_rent, total_customers desc;

/*
Recommendations for expansion (3 new coffee stores in India's top three major cities):

Recommendation 1:

City: Pune
Reasons: 
		1. Highest sales among all other cities (1258290)
		2. Highest sale amount per customer (22479)
		3. Very low rent (15300) and average rent amount per customer (294.23)

Recommendation 2:
 
City: Delhi
Reasons:
		1. Very high customer count
        2. Highest coffee consumers in the country (specific marketing opportunity)
        3. Comparatively low rent per customer

Recommendation 3:
City: Jaipur
Reasons: 
		1. Highest number of customers in the country
        2. Lowest average rent per customer in the country
        3. Steady average sale per customer


*/
