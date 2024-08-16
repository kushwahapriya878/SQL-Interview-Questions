use sql_interview_questions;

/* Data Analyst Take Home Assignment by A Startup */

create table activity (
user_id int,
event_name varchar(20),
event_date date,
country varchar(20));

insert into activity(user_id, event_name, event_date, country)
values
(1,'app-installed','2022-01-01','India')
,(1,'app-purchase','2022-01-02','India')
,(2,'app-installed','2022-01-01','USA')
,(3,'app-installed','2022-01-01','USA')
,(3,'app-purchase','2022-01-03','USA')
,(4,'app-installed','2022-01-03','India')
,(4,'app-purchase','2022-01-03','India')
,(5,'app-installed','2022-01-03','SL')
,(5,'app-purchase','2022-01-03','SL')
,(6,'app-installed','2022-01-04','Pakistan')
,(6,'app-purchase','2022-01-04','Pakistan');

select * from activity;
/* count of user per day */

select event_date, count(*) as user_count
from activity
group by 1 
order by event_date;

/* count of app_installed and app_purchaes each day */

select event_date,
       sum(case when event_name='app-installed' then 1 else 0 end) as count_of_app_installed,
       sum(case when event_name='app-purchase' then 1 else 0 end) as count_of_app_purchase
from activity
group by 1
order by 1; 

/* count of app_installed and app_purchaes for each country */

select country,
       sum(case when event_name='app-installed' then 1 else 0 end) as total_app_installed,
       sum(case when event_name='app-purchase' then 1 else 0 end) as total_app_purchase
from activity
group by 1
order by 1; 

/* finding the users who installed_app & purchase_app at same day */

with app_installed_day as (
select user_id, min(date_format(event_date, '%d')) as app_installed
from activity
where event_name='app-installed'
group by user_id
),
app_purchase_day as (
select user_id, max(date_format(event_date, '%d')) as app_purchase
from activity
where event_name='app-purchase'
group by user_id
)
select apd.user_id 
from app_purchase_day apd 
join app_installed_day aid
on apd.user_id = aid.user_id and aid.app_installed= apd.app_purchase
 
