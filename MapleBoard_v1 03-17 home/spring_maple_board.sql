CREATE DATABASE maple_board DEFAULT CHARACTER SET UTF8MB4;
drop database mapleboard;
use maple_board;

select * from ocidData ;
select * from basicData ;
select * from statData;
select * from hyperStat;
select * from propensity;
select * from ability;
select * from itemEquip;
select * from android;
select equip_data from itemEquip where character_name='순두부찌게';

select count(*) from statData where character_name='왜남캐안되요';

select stat_name from statData where character_name='왜남캐안되요';

drop table basicData;
drop table ocidData;
drop table statData;
drop table hyperStat;
drop table propensity;
drop table ability;
drop table itemEquip;
insert into ocidData (ocid) values ('287d12a05e89c0013e54692b795ccefd24');
select ocid from basicData where character_name='순두부찌게';

CREATE TABLE ocidData(
`no` int PRIMARY KEY AUTO_INCREMENT,
`ocid` VARCHAR(255) unique,
`character_name` VARCHAR(255)
);

CREATE TABLE basicData (
    `no` INT PRIMARY KEY AUTO_INCREMENT,
    `date` VARCHAR(255),
    `character_name` VARCHAR(255) unique,
    `world_name` VARCHAR(255),
    `character_gender` VARCHAR(255),
    `character_class` VARCHAR(255),
    `character_class_level` VARCHAR(255),
    `character_level` INT,
    `character_exp` BIGINT,
    `character_exp_rate` VARCHAR(255),
    `character_guild_name` VARCHAR(255),
    `character_image` TEXT
);

CREATE TABLE statData(
	`no` INT PRIMARY KEY AUTO_INCREMENT,
    `date` VARCHAR(255),
    `character_name` VARCHAR(255),
    `remain_ap` int,
    `stat_name` TEXT,
    `stat_value` TEXT
);

CREATE TABLE hyperStat(
	`no` INT PRIMARY KEY AUTO_INCREMENT,
    `date` VARCHAR(255),
    `character_class` VARCHAR(255),
    `character_name` VARCHAR(255),
    `use_preset_no` VARCHAR(255),
    `use_available_hyper_stat` int,
    `hyper_stat_preset_no` int,
    `hyper_stat_preset_1_remain_point` int,
    `hyper_stat_preset_2_remain_point` int,
    `hyper_stat_preset_3_remain_point` int,
    `stat_type` text,
    `stat_point` int,
    `stat_level` int,
    `stat_increase` text
);

CREATE TABLE propensity(
	`no` INT PRIMARY KEY AUTO_INCREMENT,
    `date` VARCHAR(255),
    `character_name` VARCHAR(255),
    `charisma_level` int,
    `sensibility_level` int,
    `insight_level` int,
    `willingness_level` int,
    `handicraft_level` int,
    `charm_level` int
);

CREATE TABLE ability(
	`no` INT PRIMARY KEY AUTO_INCREMENT,
    `date` VARCHAR(255),
    `character_name` VARCHAR(255),
    `remain_fame` int,
    `preset_no` int,
    `ability_preset_appoint_no` varchar(255),
    `ability_preset_no` VARCHAR(255),
    `ability_preset_value` VARCHAR(255),
    `ability_preset_grade` VARCHAR(255)
);
create table itemEquip(
	`no` INT PRIMARY KEY AUTO_INCREMENT,
    `date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `character_name` VARCHAR(255),
    `json_data` MEDIUMTEXT
);
create table android(
	`no` INT PRIMARY KEY AUTO_INCREMENT,
    `date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `character_name` VARCHAR(255),
    `json_data` MEDIUMTEXT
);

select * from statData where character_name=('왜남캐안되요');
select * from hyperStat where character_name='왜남캐안되요' and hyper_stat_preset_no='1';