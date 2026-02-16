---SQL Retail Sales Analysis--P1
CREATE DATABASE Sql_project_p1

---Create Table
Drop table if exists retail_sales;
  CREATE TABLE  retail_sales (
           transactions_id INT PRIMARY KEY,
           sale_date DATE,	
           sale_time TIME,
           customer_id INT,
           gender VARCHAR(15),
           age INT,
           category  VARCHAR(15),
           quantiy  INT,
           price_per_unit FLOAT,
           cogs	FLOAT,
           total_sale FLOAT
)

select * from retail_sales

select count(*) 
 from retail_sales

 select * from retail_sales
 where transactions_id IS NULL

 select * from retail_sales
 where sale_date IS NULL

 select * from retail_sales
 where sale_time IS NULL


 -------DATA CLEANING----
 select * from retail_sales
 where
     transactions_id IS NULL
     OR
     sale_date IS NULL
     OR
     sale_time IS NULL
     OR
     customer_id IS  null
     OR
     gender IS null
     OR
     category IS null
     OR
     quantiy IS null
     OR
     price_per_unit IS null
     OR
     cogs IS null
     OR
     total_sale IS null
    
     DELETE 
     FROM retail_sales
     WHERE 
       transactions_id IS NULL
     OR
     sale_date IS NULL
     OR
     sale_time IS NULL
     OR
     customer_id IS  null
     OR
     gender IS null
     OR
     category IS null
     OR
     quantiy IS null
     OR
     price_per_unit IS null
     OR
     cogs IS null
     OR
     total_sale IS null

     select count(*) 
 from retail_sales

 -------DATA EXPLORATION----

---How many sales we have?
 select count(*)  as total_sale
 from retail_sales

--- How many unique custoemrs we have?
select count( distinct customer_id) as total_customers
from retail_sales

--- which unique categories we have?
select distinct category
from retail_sales

----DATA ANALAYSIS & BUSSINESS KEY PROBLEMS & ANSWERS---

--Q1)  Write a SQL Query to retrive all columns for sales made on '2022-11-05'

select * 
from retail_sales
where sale_date = '2022-11-05';

-- Q2)Write a SQL query to retrive all transcations where the category is'Clothing'
  --and the quantity sold is more than 10 in the month of Nov-2022

  select * 
  from retail_sales
  where category = 'Clothing'
  and
 MONTH(sale_date) = 11 and
  year(sale_date) =  2022
  and quantiy>=4

---Q3) Write  a SQL query to calculate the total sales (total_sale) for each category
select category,
sum(total_sale)  as total_sales
from retail_sales
group by category

---Q4) Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
select  avg(age)
  as avg_age
  from retail_sales
  where category = 'Beauty'

---Q5) Write a Sql query to find all transcations where the total_sale is greater than 1000
select * 
from retail_sales
where total_sale>1000
   
--Q6) Write a Sql Query to find the total number of transactions(transcation_id) made by each gender in each category
   select category,gender,
   count(transactions_id) as totaltransactions
   from retail_sales
   group by category,gender
   order by category

 --Q7) Write a SQL Query to calculate the average sale for each month.find out best selling month in each year
 select * from
 (select year(sale_date) as year,
 month(sale_date) as month,
 avg(total_sale) as avg_sale,
 rank() over(partition by year(sale_date) order by avg(total_sale) desc ) as Rank
 from retail_sales
 group by year(sale_date),
        month(sale_date)
 )t
 where Rank = 1
 --Q8) Write a Sql Query to find the top 5 customers based on the highest total sales
 select  top 5 customer_id,
 sum(total_sale) as total_sales
 from retail_sales
 group by customer_id
 order by total_sales desc

 --Q9) Write a Sql Query to find the number of unique customers who purchased items from each category
 select category,
 count(distinct customer_id) as unique_customer
 from retail_sales
 group by category

--Q10) Write a SQL Query to create each shift and number of orders(Example Morning<=12,Afternoon  between 12 & 17,Evening >17)
select count(*)as total_orders,SHIFT from
    (select *,
    case 
      when datepart(Hour,sale_time) <= 12 THEN 'MORNING'
      WHEN datepart(Hour,sale_time) BETWEEN 12 AND 17 THEN 'AFTERNOON'
     ELSE 'EVENING'
     END AS SHIFT
    from retail_sales)t
     group by SHIFT
    
    --------END OF PROJECT----