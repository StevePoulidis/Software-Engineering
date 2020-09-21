-- MySQL Script generated by MySQL Workbench
-- Thu Jan 10 23:26:26 2019
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema projectDB
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `projectDB` ;

-- -----------------------------------------------------
-- Schema projectDB
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `projectDB` DEFAULT CHARACTER SET utf8 ;
SHOW WARNINGS;
USE `projectDB` ;

-- -----------------------------------------------------
-- Table `projectDB`.`Πακέτα`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projectDB`.`Πακέτα` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `projectDB`.`Πακέτα` (
  `Φροντιστήρια_id` INT NOT NULL,
  `field` ENUM('Ανθρωπιστικής', 'Θετικής', 'Υγείας', 'Οικονομίας και Πληροφορικής') NOT NULL,
  `price` SMALLINT UNSIGNED NOT NULL,
  `success_rate` INT NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `street_number` SMALLINT NOT NULL,
  `description` MEDIUMTEXT NULL,
  CONSTRAINT `fk_Μάθηματα_Φροντιστήρια`
    FOREIGN KEY (`Φροντιστήρια_id`)
    REFERENCES `projectDB`.`Φροντιστήρια` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE INDEX `fk_Μάθηματα_Φροντιστήρια_idx` ON `projectDB`.`Πακέτα` (`Φροντιστήρια_id` ASC) VISIBLE;

SHOW WARNINGS;

-- -----------------------------------------------------
-- Table `projectDB`.`Φροντιστήρια`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `projectDB`.`Φροντιστήρια` ;

SHOW WARNINGS;
CREATE TABLE IF NOT EXISTS `projectDB`.`Φροντιστήρια` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `description` VARCHAR(100) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;

SHOW WARNINGS;
CREATE UNIQUE INDEX `name_UNIQUE` ON `projectDB`.`Φροντιστήρια` (`name` ASC) VISIBLE;

SHOW WARNINGS;
CREATE UNIQUE INDEX `username_UNIQUE` ON `projectDB`.`Φροντιστήρια` (`username` ASC) VISIBLE;

SHOW WARNINGS;
CREATE UNIQUE INDEX `id_UNIQUE` ON `projectDB`.`Φροντιστήρια` (`id` ASC) VISIBLE;

SHOW WARNINGS;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


-- -----------------------------------------------------
-- Data for table `projectDB`.`Φροντιστήρια`
-- -----------------------------------------------------
START TRANSACTION;
USE `projectDB`;
INSERT INTO `projectDB`.`Φροντιστήρια` (`name`, `username`, `password`, `description`) VALUES ('Φροντ0', 'fr0', 'fr0', 'Περ0');
INSERT INTO `projectDB`.`Φροντιστήρια` (`name`, `username`, `password`, `description`) VALUES ('Φροντ1', 'fr1', 'fr1', 'Περ1');
INSERT INTO `projectDB`.`Φροντιστήρια` (`name`, `username`, `password`, `description`) VALUES ('Φροντ2', 'fr2', 'fr2', 'Περ2');
INSERT INTO `projectDB`.`Φροντιστήρια` (`name`, `username`, `password`, `description`) VALUES ('Φροντ3', 'fr3', 'fr3', 'Περ3');
INSERT INTO `projectDB`.`Φροντιστήρια` (`name`, `username`, `password`, `description`) VALUES ('Φροντ4', 'fr4', 'fr4', 'Περ4');

COMMIT;
