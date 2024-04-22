CREATE DATABASE weather_service DEFAULT CHARACTER SET UTF8MB4;
use weather_service;

insert into asos_table (standard_name,json_data) values ('asos','asdads');

select *from asos_table;
select *from living_table;
select *from short_table;
select *from short_weather;
select *from medium_table;
SELECT DISTINCT json_data
FROM short_table
WHERE json_data REGEXP '"resultCode":"00"'
  AND standard_name = 'short58/74'
  AND date LIKE '%2024-04-16%';
select distinct json_data from short_table where standard_name= "short58/74" and date like "%2024-04-16%";
select category from short_weather where fcstDate="20240415" and area = "서울";
select Count(*) from asos_table where standard_name='asos' and date like '%2024-03-29%';
drop table asos_table;
drop table living_table;
drop table short_table;
drop table short_weather;
create table asos_table(
	`no` INT PRIMARY KEY AUTO_INCREMENT,
    `date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `standard_name` VARCHAR(255),
    `json_data` MEDIUMTEXT
);

create table living_table(
	`no` INT PRIMARY KEY AUTO_INCREMENT,
    `date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`standard_name` VARCHAR(255),
    `json_data` MEDIUMTEXT
);

create table medium_table(
	`no` INT PRIMARY KEY AUTO_INCREMENT,
    `date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`standard_name` VARCHAR(255),
    `json_data` MEDIUMTEXT
);

create table short_table(
	`no` INT PRIMARY KEY AUTO_INCREMENT,
    `date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`standard_name` VARCHAR(255),
    `json_data` MEDIUMTEXT
);

create table dust_table(
	`no` INT PRIMARY KEY AUTO_INCREMENT,
    `date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	`standard_name` VARCHAR(255),
    `json_data` MEDIUMTEXT
);
create table short_weather ( 
   seq int primary key auto_increment, 
    baseDate varchar(20),
   category varchar(10),
   fcstDate varchar(20),
    fcstTime varchar(20),
   fcstValue varchar(20),
   nx int,
   ny int,
    updated int,
    area varchar(10)
);