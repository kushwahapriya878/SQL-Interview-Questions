

/* find cities where covid cases are incresing continuously */

create table covid_data(
City varchar(50),
Days date,
Cases int);

insert into covid_data(City, Days, Cases)
values
('DELHI','2022-01-01',100),
('DELHI','2022-01-02',200),
('DELHI','2022-01-03',300),
('MUMBAI','2022-01-01',100),
('MUMBAI','2022-01-02',100),
('MUMBAI','2022-01-03',300),
('CHENNAI','2022-01-01',100),
('CHENNAI','2022-01-02',200),
('CHENNAI','2022-01-03',150),
('BANGALORE','2022-01-01',100),
('BANGALORE','2022-01-02',300),
('BANGALORE','2022-01-03',200),
('BANGALORE','2022-01-04',400);

with t1 as (
select City, Days, Cases,
      lead(Cases) over(partition by City order by Days) as next_day_case
from covid_data ),
t2 as (
select City
from t1
where next_day_case is not null and Cases < next_day_case
group by City
having 
count(*)=(select count(*) -1 from covid_data cd where cd.City=t1.City)#ensuring that the count of such increasing cases is equal to the total days minus one (since each day must have a next day with higher cases for continuous increase
)
select City from t2;

   


    