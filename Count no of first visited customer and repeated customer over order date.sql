use sql_interview_questions;

/* Count no of first visited customer and repeated customer over order date */

create table customer_orders(
order_id int,
cust_id int,
order_date date,
order_amt int);
 
 insert into customer_orders(order_id, cust_id, order_date, order_amt)
 values
 (1,100,cast('2022-01-01' as date),2000),
(2,200,cast('2022-01-01' as date),2500),
(3,300,cast('2022-01-01' as date),2100),
(4,100,cast('2022-01-02' as date),2000),
(5,400,cast('2022-01-02' as date),2200),
(6,500,cast('2022-01-02' as date),2700),
(7,100,cast('2022-01-03' as date),3000),
(8,400,cast('2022-01-03' as date),1000),
(9,600,cast('2022-01-03' as date),3000) ;


with firstOrder as (
select cust_id,
       min(order_date) as first_order
from customer_orders
group by cust_id)

select c.order_date,
       count(distinct case when f.first_order=c.order_date then c.cust_id end) as first_visited_cust,
       count(distinct case when f.first_order <c.order_date then c.cust_id end) as repeated_cust  
from firstOrder f
join customer_orders c 
on f.cust_id = c.cust_id
group by c.order_date;
         