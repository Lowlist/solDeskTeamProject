CREATE DATABASE weather_service DEFAULT CHARACTER SET UTF8MB4;
use weather_service;

insert into asos_table (standard_name,json_data) values ('asos','asdads');

select *from asos_table;
select *from living_table;
select *from medium_table;
select Count(*) from asos_table where standard_name='asos' and date like '%2024-03-29%';
drop table asos_table;
drop table living_table;
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