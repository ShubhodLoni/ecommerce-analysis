#basic metrics
SELECT * FROM ecommerce_project.ecommerce_sales_analytics_5000 Limit 10;
rename table ecommerce_project.ecommerce_sales_analytics_5000 to sales;

#revenue analysis
select round(sum(revenue),2) as total_revenue from sales;

#total orders
select count(distinct order_id) as total_orders from sales;

#total customers
select count(distinct customer_id) as total_customers from sales;

#revenue by region
select region ,round(sum(revenue),2) as revenue from sales 
group by region 
order by revenue desc;

#payment method usage
select payment_method, count(*) as total_orders from sales
group by payment_method 
order by total_orders desc;

#average customer rating
select round(avg(customer_rating),2) as avg_rating from sales;

#top 5 customers
select customer_id ,round(sum(revenue),2) as spending from sales
group by customer_id
order by spending desc
limit 5;

#customer ranking
select customer_id ,sum(revenue) as spending , rank() over (order by sum(revenue) desc) as rank_position from sales
group by customer_id;

#time analysis
select date_format(order_date, '%Y-%m') as month, round(sum(revenue),2) as revenue from sales
group by month
order by month;
#above query was giving months column as null so fixed using update and alter
alter table sales add column order_date_fixed date;
update sales set order_date_fixed=str_to_date(order_date, '%m/%d/%Y');
set SQL_SAFE_UPDATES=0;
update sales set order_date_fixed=str_to_date(order_date, '%m/%d/%Y');
#now verifying
select order_date, order_date_fixed from sales limit 10;
#again after fixing this run the above main query
