use sql_interview_questions;

/* For each store find the missing quarter */

create table stores(
store varchar(20),
quarter varchar(20),
amount int);

insert into stores( store, quarter, amount)
values
('S1', 'Q1', 200),
('S1', 'Q2', 300),
('S1', 'Q4', 400),
('S2', 'Q1', 500),
('S2', 'Q3', 600),
('S2', 'Q4', 700),
('S3', 'Q1', 800),
('S3', 'Q2', 750),
('S3', 'Q3', 900);

select * from stores;

with t1 as(
select *, right(quarter, 1) as num_quarter
from stores)

select store, 10- sum(num_quarter) as missing_qtr
from t1
group by store

