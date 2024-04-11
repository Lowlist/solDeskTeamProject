CREATE DATABASE weather_service DEFAULT CHARACTER SET UTF8MB4;
use weather_service;

insert into asos_table (standard_name,json_data) values ('asos','asdads');

select *from asos_table;
select *from living_table;
select *from short_table;


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