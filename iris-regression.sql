drop table if exists irises;
drop table if exists varieties;
drop table if exists tmp_irises;

create table irises (
  sepal_length decimal(2, 1),
  sepal_width decimal(2, 1),
  petal_length decimal(2, 1),
  petal_width decimal(2, 1),
  species varchar(25)
);

.mode csv
.import -skip 1 iris.csv irises

select "basic_statistics:";
select count(*) from irises;
select max(petal_length) from irises;
select min(petal_length) from irises;
select max(petal_width) from irises;
select min(petal_width) from irises;
select * from irises where petal_length = 6.9;
select * from irises where petal_length in (select max(petal_length) from irises);
select * from irises order by petal_length * petal_width desc limit 10;
select species, count(*) from irises group by species;

select "all_done";