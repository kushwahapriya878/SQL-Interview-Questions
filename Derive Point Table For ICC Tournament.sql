use sql_interview_questions;

/* Derive Point Table For ICC Tournament */

create table icc_world_cup(
team_1 varchar(20),
team_2 varchar(20),
winner varchar(20));

INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;

select x.team, count(x.team) as match_played,
       sum(x.win_flag) as match_won,
       count(x.team) - sum(x.win_flag) as match_host_from
from       
(select team_1 as team,
       case when team_1 =winner then 1 else 0 end as win_flag
from icc_world_cup
union all
select team_2 as team,
       case when team_2 = winner then 1 else 0 end as win_flag
from icc_world_cup )x 
group by x.team
order by 2 desc, 3 desc, 4 desc;
       