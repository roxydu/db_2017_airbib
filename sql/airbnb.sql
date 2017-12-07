DROP DATABASE IF EXISTS `ships`;
CREATE DATABASE `ships`;
USE `ships`;

DROP TABLE IF EXISTS `Class`;
create table `Class` (
	`class` VARCHAR(20),
	`type` VARCHAR(2),
	`country` VARCHAR(30),
	`numGuns` TINYINT,
    `bore` TINYINT,
    `displacement` SMALLINT UNSIGNED,
	PRIMARY KEY(`class`)
);

DROP TABLE IF EXISTS `Ships`;
create table `Ships` (
	`name` VARCHAR(20),
	`class` VARCHAR(20),
	`launched` VARCHAR(4),
	PRIMARY KEY (`name`),
    FOREIGN KEY (`class`) REFERENCES `Class`(`class`) ON DELETE CASCADE
);

DROP TABLE IF EXISTS `Battles`;
CREATE TABLE `Battles` (
	`name`VARCHAR(30),
    `date` DATE,
    PRIMARY KEY (`name`, `date`)
);

DROP TABLE IF EXISTS `Outcomes`;
CREATE TABLE `` (
	`ship` VARCHAR(30),
    `battle` VARCHAR(30),
    `result` VARCHAR(10),
    PRIMARY KEY (`ship`)
);