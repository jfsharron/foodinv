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

--changeset jfs:18
--04/27/2024 add mussel to seafood_sub table
INSERT INTO seafood_sub(type) VALUES ('mussel');

--changeset jfs:19
--09/21/2024 add cheese to other_sub table
INSERT INTO other_sub(type) VALUES ('cheese');

--changeset jfs:20
--10/07/2024 add fowl to type table, add fowl_sub table, add cornish hen to 
--fowl_sub table, add bacon to pork_sub table, add fish-seabass to seafood_sub
--table
INSERT INTO type(type, type_prefix) VALUES ('fowl', 'fo');

CREATE TABLE IF NOT EXISTS `foodinv`.`fowl_sub` (
    `fowl_sub_id` INT NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(15) NOT NULL,
    PRIMARY KEY (`fowl_sub_id`));

INSERT INTO fowl_sub(type) VALUES ('cornish hen');   

INSERT INTO pork_sub(type) VALUES ('bacon');  

INSERT INTO seafood_sub(type) VALUES ('fish-seabass');  

--changeset jfs:21
--11/29/2024 add butter to other_sub table
INSERT INTO other_sub(type) VALUES ('butter');

--changeset jfs:22
--041/05/2025 add fish-salmon to seafood_sub table
INSERT INTO seafood_sub(type) VALUES ('fish-salmon');

--changeset jfs:23
--01/11/2025 add meal to other_sub table
INSERT INTO other_sub(type) VALUES ('meal');

--changeset jfs:24
--02/09/2025 add ox-tail to beef_sub table
INSERT INTO beef_sub(type) VALUES ('ox-tail');

--changeset jfs:25
--02/21/2025 add loin and tenderloin to pork_sub table
INSERT INTO pork_sub(type) VALUES ('loin');
INSERT INTO pork_sub(type) VALUES ('tenderloin');

--changeset jfs:26
--02/22/2025 create table report
CREATE TABLE IF NOT EXISTS `foodinv`.`report` (
    `report_id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(10),
    `description` VARCHAR(75),
    `query` VARCHAR(200),
    `notes` VARCHAR(200),
    `date_create` DATE,
    `date_mod` DATE,
    PRIMARY KEY (`report_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

--changeset jfs:27
--02/23/2025 add sample data to report table
INSERT INTO report (name, description, query, notes, date_create, date_mod) 
VALUES (
    '12345', 
    'in-stock records',
    'SELECT * FROM inv WHERE discard = 0 ORDER BY type, sub_type, date_packaged',
    '',
    '2025-02-23',
    '2025-02-23')

--changeset jfs:28
--03/10/2025 add index report to table report
INSERT INTO report (name, description, query, notes, date_create, date_mod) 
VALUES (
    -- name
    '12344', 
    -- description
    'discard_bad_list',
    --query
    'print(bad_list)',
    -- notes
    'only valid for current session',
    -- date_create
    '2025-03-10',
    -- date_mod
    '2025-03-10')    

--changeset jfs:29
--03/10/2025 liquibase test
INSERT INTO report (name, description, query, notes, date_create, date_mod) 
VALUES (
    -- name
    'test', 
    -- description
    'test',
    --query
    'test',
    -- notes
    '',
    -- date_create
    '2025-03-10',
    -- date_mod
    '2025-03-10')  

--changeset jfs:30
--03/14/2025 create table badlist
CREATE TABLE IF NOT EXISTS `foodinv`.`badlist` (
    `badlist_id` INT NOT NULL AUTO_INCREMENT,
    `value` VARCHAR(10),
    `correction_made` TINYINT(1),
    `date_create` DATE,
    `date_mod` DATE,
    PRIMARY KEY (`badlist_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;  

--changeset jfs:31
--03/14/2025 modify discart_bad_list reopet query
UPDATE report SET query = 'SELECT *FROM bad_list' WHERE report_id = 4

--changeset jfs:32
--03/14/2025 correction for sql syntax error in changeset 31
UPDATE report SET query = 'SELECT * FROM bad_list' WHERE report_id = 4

--changeset jfs:33
--03/14/2025 correction for wrong tablename in changeset(s) 31 and 32
UPDATE report SET query = 'SELECT * FROM badlist' WHERE report_id = 4

--changeset jfs:34
--03/14/2025 add all records report
INSERT INTO report (name, description, query, notes, date_create, date_mod) 
VALUES (
    -- name
    '12346', 
    -- description
    'entire inventory report including discard',
    --query
    'SELECT * FROM inv',
    -- notes
    '',
    -- date_create
    '2025-03-14',
    -- date_mod
    '2025-03-14')  

--changeset jfs:35
--03/14/2025 remove notes from report 12344
UPDATE report SET notes = '' WHERE report_id = 4

--changeset jfs:36
--03/14/2025 add order by to report 12346 remove notes from report 12344
UPDATE report SET query = 'SELECT * FROM inv ORDER BY type, sub_type, 
                           date_packaged' WHERE report_id = 5

--changeset jfs:37
--03/14/2025 acorrection to changeset 36
UPDATE report SET query = 'SELECT * FROM inv ORDER BY type, sub_type,'
                           'date_packaged' WHERE report_id = 5

--changeset jfs:38
--03/23/2025 drop report table to replace with new version
DROP TABLE report

--changeset jfs:39
--03/23/2025 recreate report table
CREATE TABLE IF NOT EXISTS `foodinv`.`report` (
    `report_id` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(10),
    `description` VARCHAR(75),
    `query` VARCHAR(200),
    `notes` VARCHAR(200),
    `date_create` DATE,
    `date_mod` DATE,
	`creator` VARCHAR(75),
	`args_req` TINYINT(1),
	`args` VARCHAR(100),
    PRIMARY KEY (`report_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;

--changeset jfs:40
--03/23/2025 add default reports to report
INSERT INTO report (name, description, query, notes, date_create, date_mod, creator, args_req, args) 
VALUES (
    -- name
    '11111', 
    -- description
    'All Records',
    --query
    'SELECT * FROM inv',
    -- notes
    '',
    -- date_create
    '2025-03-23',
    -- date_mod
    '2025-03-23',
    -- creator
    '',
    -- arg_req
    '0',
    -- args
    '')  

--changeset jfs:41
--03/23/2025 add default reports to report
INSERT INTO report (name, description, query, notes, date_create, date_mod, creator, args_req, args) 
VALUES (
    -- name
    '123456', 
    -- description
    'Filtered - type, discard status',
    --query
    'SELECT * FROM inv WHERE (type = {} AND discard = {})',
    -- notes
    '',
    -- date_create
    '2025-03-23',
    -- date_mod
    '2025-03-23',
    -- creator
    '',
    -- arg_req
    '1',
    -- args
    'type, discard')  

--changeset jfs:42
--03/23/2025 add default reports to report
INSERT INTO report (name, description, query, notes, date_create, date_mod, creator, args_req, args) 
VALUES (
    -- name
    '123457', 
    -- description
    'Filtered - type, discard status, pieces',
    --query
    'SELECT * FROM inv WHERE (type = {} AND discard = {} AND sub_type = {} AND'
     'pieces = {})',
    -- notes
    '',
    -- date_create
    '2025-03-23',
    -- date_mod
    '2025-03-23',
    -- creator
    '',
    -- arg_req
    '1',
    -- args
    'type, discard') 

--changeset jfs:43
--03/23/2025 correct syntax error in changeset 42
UPDATE report SET query = 'SELECT * FROM inv WHERE (type = {} '
    'AND discard = {} AND sub_type = {} AND '
    'pieces = {})'

--changeset jfs:44
--03/23/2025 correct syntax error in changeset 43 (missing WHERE statement)
UPDATE report SET query = 'SELECT * FROM inv'
WHERE report_id = 1

--changeset jfs:45
--03/23/2025 correct syntax error in changeset 43 (missing WHERE statement)
UPDATE report SET query = 'SELECT * FROM inv WHERE (type = {} AND discard = {})'
WHERE report_id = 2

--changeset jfs:46
--03/23/2025 correct error in changeset 42 (incorrect description)
UPDATE report SET description = 'Filtered - type, discard, status, sub_type, pieces'
WHERE report_id = 3

--changeset jfs:47
--03/24/2025 correct error in report 123457 - missing "pieces" and "sub_type"args
UPDATE report SET args = 'type, discard, sub_type, pieces'
WHERE report_id = 3

--changeset jfs:48
--03/24/2025 correct error in changeset 42 and 46 (incorrect description)
UPDATE report SET description = 'Filtered - type, discard status, sub_type, pieces'
WHERE report_id = 3