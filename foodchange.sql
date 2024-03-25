--liquibase formatted sql


--changeset jfs:1
--01/14/2022 create main table
CREATE DATABASE IF NOT EXISTS `foodinv` DEFAULT CHARACTER SET latin1 
COLLATE latin1_swedish_ci;
USE `foodinv`;


CREATE TABLE IF NOT EXISTS `foodinv`.`inv` (
    `inv_id` INT NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(25) NOT NULL,
    `sub_type` VARCHAR(25) NOT NULL,
    `description` VARCHAR(200) NULL DEFAULT NULL,
    `net_weight` FLOAT(5,3) NOT NULL,
    `weight_unit` VARCHAR(10) NOT NULL DEFAULT 'pound',
    `pieces` TINYINT UNSIGNED NOT NULL,
    `date_packaged` DATE NOT NULL,
    `code` VARCHAR(10) NOT NULL,
    `discard` TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (`inv_id`),
    CONSTRAINT code_constraint UNIQUE (`code`))
ENGINE = InnoDB
AUTO_INCREMENT = 3022
DEFAULT CHARACTER SET = utf8mb3;

--changeset jfs:2
--01/14/2022 create weight_unit_sub table 
CREATE TABLE IF NOT EXISTS `foodinv`.`weight_unit_sub` (
    `weight_unit_sub_id` INT NOT NULL AUTO_INCREMENT,
    `weight_unit` VARCHAR(15) NOT NULL DEFAULT 'pounds',
    PRIMARY KEY (`weight_unit_sub_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

--changeset jfs:3
--01/14/2022 insert weight unit values
USE foodinv;
INSERT INTO weight_unit_sub(weight_unit) VALUES ('pounds');
INSERT INTO weight_unit_sub(weight_unit) VALUES ('ounces');
INSERT INTO weight_unit_sub(weight_unit) VALUES ('cups');
INSERT INTO weight_unit_sub(weight_unit) VALUES ('kilograms');
INSERT INTO weight_unit_sub(weight_unit) VALUES ('milliliters');
INSERT INTO weight_unit_sub(weight_unit) VALUES ('liters');
INSERT INTO weight_unit_sub(weight_unit) VALUES ('grams');

--changeset jfs:4
--01/16/2022 create table type and insert intial values
CREATE TABLE IF NOT EXISTS `foodinv`.`type` (
    `type_id` INT NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`type_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

INSERT INTO type(type) VALUES ('chicken');
INSERT INTO type(type) VALUES ('beef');
INSERT INTO type(type) VALUES ('pork');
INSERT INTO type(type) VALUES ('seafood');

--changeset jfs:5
--01/16/2022 create table chicken_sub and insert intial values
CREATE TABLE IF NOT EXISTS `foodinv`.`chicken_sub` (
    `chicken_sub_id` INT NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`chicken_sub_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

INSERT INTO chicken_sub(type) VALUES ('whole');
INSERT INTO chicken_sub(type) VALUES ('thigh');
INSERT INTO chicken_sub(type) VALUES ('leg');
INSERT INTO chicken_sub(type) VALUES ('wing');
INSERT INTO chicken_sub(type) VALUES ('breast');
INSERT INTO chicken_sub(type) VALUES ('party wing');
INSERT INTO chicken_sub(type) VALUES ('tender');
INSERT INTO chicken_sub(type) VALUES ('liver');

--changeset jfs:6
--01/16/2022 create counter and insert intial value
CREATE TABLE IF NOT EXISTS `foodinv`.`xcounter` (
    `counter_id` INT NOT NULL AUTO_INCREMENT,
    `value` INT(11) NOT NULL,
    PRIMARY KEY (`counter_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

INSERT INTO xcounter(value) VALUES (2230);
----01/16/2022 modify table type to include code prefix (moved to changeset 6)
ALTER TABLE type ADD COLUMN type_prefix char(2) AFTER type;

--changeset jfs:7
--01/17/2022 table type code prefix intial values
USE foodinv;

UPDATE type SET type_prefix ='ch' WHERE type_id = 1;
UPDATE type SET type_prefix ='be' WHERE type_id = 2;
UPDATE type SET type_prefix ='po' WHERE type_id = 3;
UPDATE type SET type_prefix ='se' WHERE type_id = 4;

--changeset jfs:8
--01/17/2022 modify table type to set code prefix NOT NULL AND UNIQUE
ALTER TABLE type MODIFY type_prefix CHAR(2) NOT NULL UNIQUE;

--changeset jfs:9
--01/22/2022 modify table xcounter to include field sht_name
ALTER TABLE xcounter ADD COLUMN sht_name VARCHAR(10) AFTER value;

--changeset jfs:10
--01/22/2022 add intial sht_name value to xcounter
UPDATE xcounter SET sht_name = 'ch9999' WHERE counter_id = 1;

--changeset jfs:11
--01/22/2022 alter so sht_name field is NOT NULL
ALTER TABLE xcounter MODIFY sht_name VARCHAR(10) NOT NULL;

--changeset jfs:12
--01/22/2022 alter so sht_name field to correct lenghth
ALTER TABLE xcounter MODIFY sht_name VARCHAR(25) NOT NULL;

--changeset jfs:13
--02/05/2024
--note previous changestes should be date 2024
CREATE TABLE IF NOT EXISTS `foodinv`.`seafood_sub` (
    `seafood_sub_id` INT NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`seafood_sub_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

INSERT INTO seafood_sub(type) VALUES ('clam');
INSERT INTO seafood_sub(type) VALUES ('oyster');
INSERT INTO seafood_sub(type) VALUES ('scallop');
INSERT INTO seafood_sub(type) VALUES ('shrimp');
INSERT INTO seafood_sub(type) VALUES ('crab');
INSERT INTO seafood_sub(type) VALUES ('fish-cod');
INSERT INTO seafood_sub(type) VALUES ('fish-halibut');

--changeset jfs:14
--02/05/2024 add other to type table
INSERT INTO type(type, type_prefix) VALUES ('other', 'ot');

--changeset jfs:15
--02/05/2024 create other_sub table and add intial values in database
CREATE TABLE IF NOT EXISTS `foodinv`.`other_sub` (
    `other_sub_id` INT NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`other_sub_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

INSERT INTO other_sub(type) VALUES ('ground');
INSERT INTO other_sub(type) VALUES ('soup');

--changeset jfs:16
--02/12/2024 create pork_sub table and insert values
CREATE TABLE IF NOT EXISTS `foodinv`.`pork_sub` (
    `pork_sub_id` INT NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`pork_sub_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

INSERT INTO pork_sub(type) VALUES ('ground');
INSERT INTO pork_sub(type) VALUES ('chop');
INSERT INTO pork_sub(type) VALUES ('sausage - loose');
INSERT INTO pork_sub(type) VALUES ('sausage - cased');
INSERT INTO pork_sub(type) VALUES ('steak');
INSERT INTO pork_sub(type) VALUES ('shoulder');
INSERT INTO pork_sub(type) VALUES ('rib');
INSERT INTO pork_sub(type) VALUES ('belly');
INSERT INTO pork_sub(type) VALUES ('neck');
INSERT INTO pork_sub(type) VALUES ('hock');

--changeset jfs:17
--03/24/2024 create beef_sub table and insert values
CREATE TABLE IF NOT EXISTS `foodinv`.`beef_sub` (
    `beef_sub_id` INT NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`beef_sub_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

INSERT INTO beef_sub(type) VALUES ('ground');
INSERT INTO beef_sub(type) VALUES ('brisket');
INSERT INTO beef_sub(type) VALUES ('sausage - loose');
INSERT INTO beef_sub(type) VALUES ('sausage - cased');
INSERT INTO beef_sub(type) VALUES ('steak');
INSERT INTO beef_sub(type) VALUES ('shoulder');
INSERT INTO beef_sub(type) VALUES ('rib');
INSERT INTO beef_sub(type) VALUES ('neck');
INSERT INTO beef_sub(type) VALUES ('tenderloin');

















