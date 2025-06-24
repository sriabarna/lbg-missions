use testdb;

create table tasks
(id int auto_increment primary key,
task varchar(50));

insert into tasks (task)
values ('One'), ('Two'), ('Three');

select *
from tasks;
