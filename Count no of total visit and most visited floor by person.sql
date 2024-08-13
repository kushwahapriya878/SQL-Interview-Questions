use sql_interview_questions;

/* Count no of total visit and most visited floor by person */

create table entries(
name varchar(30),
address varchar(50),
email varchar(50),
floor int,
resources varchar(10));

insert into entries(name, address, email, floor, resources)
values
('A','Bangalore','A@gmail.com',1,'CPU'),
('A','Bangalore','A1@gmail.com',1,'CPU'),
('A','Bangalore','A2@gmail.com',2,'DESKTOP'),
('B','Bangalore','B@gmail.com',2,'DESKTOP'),
('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
('B','Bangalore','B2@gmail.com',1,'MONITOR');

with visit_count as (
select name, `floor`, count(*) as visit_count
from entries
group by name, `floor`),

total_visit as (
select name, sum(visit_count) as total_visit
from visit_count
group by name),

most_visited_floor as (select name, `floor`, visit_count
from visit_count
where (name,visit_count) in (select name, max(visit_count) from visit_count group by name))

select tv.name, tv.total_visit, mvf.`floor` as most_visited_floor
from total_visit tv 
join most_visited_floor mvf on tv.name = mvf.name
