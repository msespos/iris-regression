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

select "Basic_statistics:";
select count(*) from irises;
select max(petal_length) from irises;
select min(petal_length) from irises;
select max(petal_width) from irises;
select min(petal_width) from irises;
select * from irises where petal_length = 6.9;
select * from irises where petal_length in (select max(petal_length) from irises);
select * from irises order by petal_length * petal_width desc limit 10;
select species, count(*) from irises group by species;

select "Normalization:";
select species from irises group by species;
create table varieties ( id integer primary key, name varchar(25) );
insert into varieties(name) select distinct species from irises;
alter table irises add column variety_id int;
update irises set variety_id = 1 where species = 'virginica';
update irises set variety_id = ( select id from varieties where varieties.name = irises.species );
create table tmp_irises as select sepal_length, sepal_width, petal_length, petal_width, variety_id from irises;
drop table irises;
create table irises as select sepal_length, sepal_width, petal_length, petal_width, variety_id from tmp_irises;
select name, count(id) from varieties inner join irises on irises.variety_id = varieties.id where petal_length <= 5.0 group by name;

select "Duplicates";
select count ( distinct a.rowid ) from irises a inner join irises b on a.rowid != b.rowid and a.petal_length = b.petal_length;
select count ( distinct a.rowid ) from irises a inner join irises b on a.rowid != b.rowid and a.petal_length = b.petal_length and a.petal_width = b.petal_width;
select count ( distinct a.rowid ) from irises a inner join irises b on a.rowid != b.rowid and a.petal_length = b.petal_length and a.petal_width = b.petal_width and a.sepal_length = b.sepal_length and a.sepal_width = b.sepal_width;
select petal_width, petal_length, count ( petal_width ) from irises group by petal_length, petal_length order by count ( petal_width ) desc limit 1;

select "All_done";