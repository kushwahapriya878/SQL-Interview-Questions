/*find users who accessed Amazon Music and upgraded to Prime membership within the first 30 days of signing up */

use sql_interview_questions;

create table users(
user_id int,
name varchar(50),
join_date date);

insert into users(user_id, name, join_date)
values
(1, 'Jon', '2020-02-14'),
(2, 'Jane',  '2020-02-15'), 
(3, 'Jill',  '2020-02-16'), 
(4, 'Josh',  '2020-02-17'), 
(5, 'Jean',  '2020-02-18'), 
(6, 'Justin',  '2020-02-19'),
(7, 'Jeremy',  '2020-02-20');

create table events(
user_id int,
type varchar(10),
access_date date);

insert into events(user_id, type, access_date) 
values
(1, 'Pay', '2020-03-01'), 
(2, 'Music', '2020-03-02'), 
(2, 'P', '2020-03-12'),
(3, 'Music', '2020-03-20'), 
(4, 'Music', '2020-03-15'), 
(1, 'P', '2020-03-16'), 
(3, 'P', '2020-03-22');

select * from users;
select * from events;

SELECT u.user_id, u.name
FROM users u
JOIN events e1 ON u.user_id = e1.user_id AND e1.type = 'Music'
JOIN events e2 ON u.user_id = e2.user_id AND e2.type = 'P'
WHERE e1.access_date <= DATE_ADD(u.join_date, INTERVAL 30 DAY)
AND e2.access_date <= DATE_ADD(u.join_date, INTERVAL 30 DAY);
