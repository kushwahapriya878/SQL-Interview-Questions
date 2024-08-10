use sql_interview_questions;
/* If a person do a task on a regular basis and the output of the task is either success or fail */

create table tasks(
date_value date,
state varchar(10));

insert into tasks(date_value, state)
values
('2019-01-01','success'),
('2019-01-02','success'),
('2019-01-03','success'),
('2019-01-04','fail'),
('2019-01-05','fail'),
('2019-01-06','success'),
('2022-01-01','success'),
('2022-01-02','success'),
('2022-01-03','fail'),
('2022-01-04','success'),
('2022-01-05','fail'),
('2022-01-06','fail'),
('2022-01-07','fail'),
('2022-01-08','success');

select * from tasks;

with grp_tasks as
(select *, row_number() over(order by date_value) r_num,
row_number() over(partition by state order by date_value) as s_num,
row_number() over(order by date_value)-row_number() over(partition by state order by date_value) as grp
from tasks)

select min(date_value) as start_date,
       max(date_value) as end_date, state as task_result
from grp_tasks
group by grp, state
order by state;       
