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
