use sql_interview_questions;

/* find total number of messages exchanged between two person */

create table subscriber(
sms_date date,
sender varchar(20),
receiver varchar(20),
sms_no int);
insert into subscriber(sms_date, sender, receiver, sms_no)
values
('2020-4-1', 'Avinash', 'Vibhor',10),
('2020-4-1', 'Vibhor', 'Avinash',20),
('2020-4-1', 'Avinash', 'Pawan',30),
('2020-4-1', 'Pawan', 'Avinash',20),
('2020-4-1', 'Vibhor', 'Pawan',5),
('2020-4-1', 'Pawan', 'Vibhor',8),
('2020-4-1', 'Vibhor', 'Deepak',50);

select* from subscriber;

select least(sender, receiver) as person1,
       greatest(sender, receiver) as person2,
       sum(sms_no) as total_sms
from subscriber
group by least(sender, receiver), greatest(sender, receiver);       