use SQL_Interview_Questions;

/* Customer retention and churn analysis */

create table transactions(
order_id int,
cust_id int,
order_date date,
amt int);

insert into transactions( order_id, cust_id, order_date, amt)
values
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150);

select * from transactions;
update transactions 
set order_date= str_to_date(order_date, '%Y-%m-%d')
/*Identifying repeated customer*/

select cust_id, count(order_id) as total_order
from transactions
group by cust_id
having count(order_id)>1;

/* Calculating customer retention rate*/

with monthly_customer as(
select cust_id, 
       date_format(order_date,"%m") as order_month,
       lag(date_format(order_date,"%m")) over(partition by cust_id order by order_date) pre_month,
       date_format(order_date,"%m")-lag(date_format(order_date,"%m")) over(partition by cust_id order by order_date) as month_diff
 from transactions)
 
 select order_month,
        sum(case when month_diff= 1 then 1 
        when month_diff is null then 0
        end )as  no_of_retention
 from monthly_customer
 group by order_month;
 
 
 /*Customer churn by month*/
 
 WITH monthly_customer AS (
  SELECT cust_id, 
         DATE_FORMAT(order_date, "%m") AS order_month,
         LEAD(DATE_FORMAT(order_date, "%m")) OVER (PARTITION BY cust_id ORDER BY order_date) AS next_month,
         LEAD(DATE_FORMAT(order_date, "%m")) OVER (PARTITION BY cust_id ORDER BY order_date)-DATE_FORMAT(order_date, "%m") AS month_diff
  FROM transactions
)
SELECT order_month,
       SUM(CASE WHEN month_diff > 1 THEN 1 
       when month_diff is null then 1
	   END) AS no_of_churn
FROM monthly_customer
GROUP BY order_month;