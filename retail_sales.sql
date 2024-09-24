CREATE DATABASE retail_sales_roject1;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);


select * from retail_sales;


Record Count: Determine the total number of records in the dataset.

select  count(*)
	from retail_sales

Customer Count: Find out how many unique customers are in the dataset.

select 
		count(
		distinct(customer_id)
		)
from  retail_sales
	
Category Count: Identify all unique product categories in the dataset.

select 
	distinct(category)
	from retail_sales

Null Value Check: Check for any null values in the dataset and delete records with missing data.

select *
	from retail_sales
where
	sale_date is null or sale_time is null or customer_id is null or
	gender is null or age is null or category is null or quantity is null or 
	price_per_unit is null or cogs is null;
delete from retail_sales
where

sale_date is null or sale_time is null or customer_id is null or
	gender is null or age is null or category is null or quantity is null or 
	price_per_unit is null or cogs is null;

drop table retail_sales

select *
	from retail_sales



Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
	

Write a SQL query to retrieve all transactions where the category is 'Clothing' and
the quantity sold is more than 4 in the month of Nov-2022:

SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4


Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1

Write a SQL query to find the average age of customers
who purchased items from the 'Beauty' category.:

select 
	avg(age)as avg_age
from  retail_sales
where category ='Beauty'


SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'


Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select * 
	from retail_sales
	where 
		total_sale >1000

	
find the total number of transactions (transaction_id) made by each gender in each category.:

select 
		category,
		gender,
		count(*)
from retail_sales
group by category, gender
order by category



 calculate the average sale for each month. Find out best selling month in each year

	SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1


	 find the top 5 customers based on the highest total sales 

select 
		customer_id,
		sum(total_sale) as total_sales
from retail_sales
group by 1
order by  2 desc
limit  5


 find the number of unique customers who purchased items from each category.:

select 
		category,
		count(
			distinct(customer_id)
		)
from retail_sales
group by 1


create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):


with A
	as(
	select *,
	case 
		when extract (hour from sale_time)<12 then 'Morining'
		when extract (hour from sale_time) between 12  and  17 then 'Afternoon'
		else 'Evening'
	end as shift
	from retail_sales

	)
	select 
		shift,
		count(*)as total_orders
	from A
	group by shift




-- can check the git for details




