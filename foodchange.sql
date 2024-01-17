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







