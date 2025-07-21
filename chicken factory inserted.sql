-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema chickens_factory
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `chickens_factory` ;

-- -----------------------------------------------------
-- Schema chickens_factory
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `chickens_factory` DEFAULT CHARACTER SET utf8 ;
USE `chickens_factory` ;

-- -----------------------------------------------------
-- Table `chickens_factory`.`owner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`owner` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`owner` (
  `O_ssn` CHAR(5) NOT NULL,
  `Fname` VARCHAR(10) NULL,
  PRIMARY KEY (`O_ssn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chickens_factory`.`Supervison`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Supervison` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Supervison` (
  `S_ssn` CHAR(5) NOT NULL,
  `type` VARCHAR(45) NULL,
  `O_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`S_ssn`),
  CONSTRAINT `fk_Supervison_owner1`
    FOREIGN KEY (`O_ssn`)
    REFERENCES `chickens_factory`.`owner` (`O_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Supervison_Employee1`
    FOREIGN KEY (`S_ssn`)
    REFERENCES `chickens_factory`.`Employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Supervison_owner1_idx` ON `chickens_factory`.`Supervison` (`O_ssn` ASC);

CREATE INDEX `fk_Supervison_Employee1_idx` ON `chickens_factory`.`Supervison` (`S_ssn` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`accountant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`accountant` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`accountant` (
  `A_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`A_ssn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chickens_factory`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Employee` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Employee` (
  `ssn` CHAR(5) NOT NULL,
  `Fname` VARCHAR(10) NULL,
  `Minit` CHAR NULL,
  `Lname` VARCHAR(10) NULL,
  `Sex` CHAR NULL,
  `salary` DOUBLE NULL,
  `start_date` DATE NULL,
  `num_of_varation` INT NULL,
  `Supervison_S_ssn` CHAR(5) NOT NULL,
  `accountant_A_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`ssn`),
  CONSTRAINT `fk_Employee_Supervison1`
    FOREIGN KEY (`Supervison_S_ssn`)
    REFERENCES `chickens_factory`.`Supervison` (`S_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_accountant1`
    FOREIGN KEY (`accountant_A_ssn`)
    REFERENCES `chickens_factory`.`accountant` (`A_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Employee_Supervison1_idx` ON `chickens_factory`.`Employee` (`Supervison_S_ssn` ASC);

CREATE INDEX `fk_Employee_accountant1_idx` ON `chickens_factory`.`Employee` (`accountant_A_ssn` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`phone` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`phone` (
  `num_of_phone` INT NOT NULL,
  `ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`num_of_phone`, `ssn`),
  CONSTRAINT `fk_phone_Employee1`
    FOREIGN KEY (`ssn`)
    REFERENCES `chickens_factory`.`Employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_phone_Employee1_idx` ON `chickens_factory`.`phone` (`ssn` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`Driver`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Driver` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Driver` (
  `D_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`D_ssn`),
  CONSTRAINT `fk_Driver_Employee1`
    FOREIGN KEY (`D_ssn`)
    REFERENCES `chickens_factory`.`Employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Driver_Employee1_idx` ON `chickens_factory`.`Driver` (`D_ssn` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`Car`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Car` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Car` (
  `Car_num` CHAR(3) NOT NULL,
  `Model` VARCHAR(15) NULL,
  `Date_end_licence` DATE NULL,
  `D_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`Car_num`),
  CONSTRAINT `fk_Car_Driver1`
    FOREIGN KEY (`D_ssn`)
    REFERENCES `chickens_factory`.`Driver` (`D_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Car_Driver1_idx` ON `chickens_factory`.`Car` (`D_ssn` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`pay`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`pay` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`pay` (
  `A_ssn` CHAR(5) NOT NULL,
  `D_ssn` CHAR(5) NOT NULL,
  `Cash` DOUBLE NULL,
  `Date_of_paying` DATE NULL,
  `amount_of_product` DOUBLE NULL,
  PRIMARY KEY (`A_ssn`, `D_ssn`),
  CONSTRAINT `fk_Driver_has_accountant_Driver1`
    FOREIGN KEY (`D_ssn`)
    REFERENCES `chickens_factory`.`Driver` (`D_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Driver_has_accountant_accountant1`
    FOREIGN KEY (`A_ssn`)
    REFERENCES `chickens_factory`.`accountant` (`A_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Driver_has_accountant_accountant1_idx` ON `chickens_factory`.`pay` (`A_ssn` ASC);

CREATE INDEX `fk_Driver_has_accountant_Driver1_idx` ON `chickens_factory`.`pay` (`D_ssn` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`Emp_machine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Emp_machine` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Emp_machine` (
  `M_ssn` CHAR(5) NOT NULL,
  `Type` VARCHAR(15) NULL,
  PRIMARY KEY (`M_ssn`),
  CONSTRAINT `fk_Emp_machine_Employee1`
    FOREIGN KEY (`M_ssn`)
    REFERENCES `chickens_factory`.`Employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Emp_machine_Employee1_idx` ON `chickens_factory`.`Emp_machine` (`M_ssn` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`Emp_cracking_machine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Emp_cracking_machine` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Emp_cracking_machine` (
  `C_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`C_ssn`),
  CONSTRAINT `fk_Emp_cracking_machine_Emp_machine1`
    FOREIGN KEY (`C_ssn`)
    REFERENCES `chickens_factory`.`Emp_machine` (`M_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Emp_cracking_machine_Emp_machine1_idx` ON `chickens_factory`.`Emp_cracking_machine` (`C_ssn` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`Emp_packing_machine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Emp_packing_machine` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Emp_packing_machine` (
  `P_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`P_ssn`),
  CONSTRAINT `fk_Emp_packing_machine_Emp_machine1`
    FOREIGN KEY (`P_ssn`)
    REFERENCES `chickens_factory`.`Emp_machine` (`M_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Emp_packing_machine_Emp_machine1_idx` ON `chickens_factory`.`Emp_packing_machine` (`P_ssn` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`Machine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Machine` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Machine` (
  `M_id` CHAR(3) NOT NULL,
  `HP` CHAR(5) NULL,
  `Model` VARCHAR(15) NULL,
  PRIMARY KEY (`M_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chickens_factory`.`Cracking_machine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Cracking_machine` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Cracking_machine` (
  `C_id` CHAR(3) NOT NULL,
  PRIMARY KEY (`C_id`),
  CONSTRAINT `fk_Cracking_machine_Machine1`
    FOREIGN KEY (`C_id`)
    REFERENCES `chickens_factory`.`Machine` (`M_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Cracking_machine_Machine1_idx` ON `chickens_factory`.`Cracking_machine` (`C_id` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`Packing_machine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Packing_machine` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Packing_machine` (
  `P_id` CHAR(3) NOT NULL,
  `amount` VARCHAR(15) NULL,
  `C_id` CHAR(3) NOT NULL,
  PRIMARY KEY (`P_id`),
  CONSTRAINT `fk_table1_Machine1`
    FOREIGN KEY (`P_id`)
    REFERENCES `chickens_factory`.`Machine` (`M_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Packing_machine_Cracking_machine1`
    FOREIGN KEY (`C_id`)
    REFERENCES `chickens_factory`.`Cracking_machine` (`C_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_table1_Machine1_idx` ON `chickens_factory`.`Packing_machine` (`P_id` ASC);

CREATE INDEX `fk_Packing_machine_Cracking_machine1_idx` ON `chickens_factory`.`Packing_machine` (`C_id` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`Cracking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Cracking` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Cracking` (
  `C_id` CHAR(3) NOT NULL,
  `C_ssn` CHAR(5) NOT NULL,
  `Hours_of_working` DOUBLE NULL,
  `Date_of_working` DATE NULL,
  PRIMARY KEY (`C_id`, `C_ssn`),
  CONSTRAINT `fk_Cracking_machine_has_Emp_cracking_machine_Cracking_machine1`
    FOREIGN KEY (`C_id`)
    REFERENCES `chickens_factory`.`Cracking_machine` (`C_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cracking_machine_has_Emp_cracking_machine_Emp_cracking_mac1`
    FOREIGN KEY (`C_ssn`)
    REFERENCES `chickens_factory`.`Emp_cracking_machine` (`C_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Cracking_machine_has_Emp_cracking_machine_Emp_cracking_m_idx` ON `chickens_factory`.`Cracking` (`C_ssn` ASC);

CREATE INDEX `fk_Cracking_machine_has_Emp_cracking_machine_Cracking_machi_idx` ON `chickens_factory`.`Cracking` (`C_id` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`Packing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Packing` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Packing` (
  `P_id` CHAR(3) NOT NULL,
  `P_ssn` CHAR(5) NOT NULL,
  `Hours_of_working` DOUBLE NULL,
  `Date_of_working` DATE NULL,
  PRIMARY KEY (`P_id`, `P_ssn`),
  CONSTRAINT `fk_Packing_machine_has_Emp_packing_machine_Packing_machine1`
    FOREIGN KEY (`P_id`)
    REFERENCES `chickens_factory`.`Packing_machine` (`P_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Packing_machine_has_Emp_packing_machine_Emp_packing_machine1`
    FOREIGN KEY (`P_ssn`)
    REFERENCES `chickens_factory`.`Emp_packing_machine` (`P_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Packing_machine_has_Emp_packing_machine_Emp_packing_mach_idx` ON `chickens_factory`.`Packing` (`P_ssn` ASC);

CREATE INDEX `fk_Packing_machine_has_Emp_packing_machine_Packing_machine1_idx` ON `chickens_factory`.`Packing` (`P_id` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`Fridge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Fridge` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Fridge` (
  `F_id` CHAR(3) NOT NULL,
  `HP` CHAR(5) NULL,
  PRIMARY KEY (`F_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chickens_factory`.`Short_fridge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Short_fridge` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Short_fridge` (
  `Sh_id` CHAR(3) NOT NULL,
  `Amount` DOUBLE NULL,
  PRIMARY KEY (`Sh_id`),
  CONSTRAINT `fk_Short_fridge_Fridge1`
    FOREIGN KEY (`Sh_id`)
    REFERENCES `chickens_factory`.`Fridge` (`F_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Short_fridge_Fridge1_idx` ON `chickens_factory`.`Short_fridge` (`Sh_id` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`Avg_fridge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Avg_fridge` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Avg_fridge` (
  `Avg_id` CHAR(3) NOT NULL,
  `Amount` DOUBLE NULL,
  PRIMARY KEY (`Avg_id`),
  CONSTRAINT `fk_Avg_fridge_Fridge1`
    FOREIGN KEY (`Avg_id`)
    REFERENCES `chickens_factory`.`Fridge` (`F_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Avg_fridge_Fridge1_idx` ON `chickens_factory`.`Avg_fridge` (`Avg_id` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`Long_fridge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Long_fridge` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Long_fridge` (
  `Long_id` CHAR(3) NOT NULL,
  `Amount` DOUBLE NULL,
  PRIMARY KEY (`Long_id`),
  CONSTRAINT `fk_Long_Fridge1`
    FOREIGN KEY (`Long_id`)
    REFERENCES `chickens_factory`.`Fridge` (`F_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Long_Fridge1_idx` ON `chickens_factory`.`Long_fridge` (`Long_id` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`Emp_avg_fridge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Emp_avg_fridge` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Emp_avg_fridge` (
  `Avg_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`Avg_ssn`),
  CONSTRAINT `fk_Emp_avg_fridge_Employee1`
    FOREIGN KEY (`Avg_ssn`)
    REFERENCES `chickens_factory`.`Employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Emp_avg_fridge_Employee1_idx` ON `chickens_factory`.`Emp_avg_fridge` (`Avg_ssn` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`Avg_work`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Avg_work` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Avg_work` (
  `Avg_id` CHAR(3) NOT NULL,
  `Avg_ssn` CHAR(5) NOT NULL,
  `Hours_of_working` DOUBLE NULL,
  `Date_of_working` DATE NULL,
  PRIMARY KEY (`Avg_id`, `Avg_ssn`),
  CONSTRAINT `fk_Avg_fridge_has_Emp_avg_fridge_Avg_fridge1`
    FOREIGN KEY (`Avg_id`)
    REFERENCES `chickens_factory`.`Avg_fridge` (`Avg_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Avg_fridge_has_Emp_avg_fridge_Emp_avg_fridge1`
    FOREIGN KEY (`Avg_ssn`)
    REFERENCES `chickens_factory`.`Emp_avg_fridge` (`Avg_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Avg_fridge_has_Emp_avg_fridge_Emp_avg_fridge1_idx` ON `chickens_factory`.`Avg_work` (`Avg_ssn` ASC);

CREATE INDEX `fk_Avg_fridge_has_Emp_avg_fridge_Avg_fridge1_idx` ON `chickens_factory`.`Avg_work` (`Avg_id` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`Intrnal_trans`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`Intrnal_trans` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`Intrnal_trans` (
  `I_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`I_ssn`),
  CONSTRAINT `fk_Intrnal_trans_Employee1`
    FOREIGN KEY (`I_ssn`)
    REFERENCES `chickens_factory`.`Employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Intrnal_trans_Employee1_idx` ON `chickens_factory`.`Intrnal_trans` (`I_ssn` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`car_to_avg`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`car_to_avg` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`car_to_avg` (
  `Avg_id` CHAR(3) NOT NULL,
  `Car_num` CHAR(3) NOT NULL,
  `I_ssn` CHAR(5) NOT NULL,
  `date_of_working` DATE NULL,
  `hours_of_working` DOUBLE NULL,
  `amount` DOUBLE NULL,
  CONSTRAINT `fk_car_to_avg_Avg_fridge1`
    FOREIGN KEY (`Avg_id`)
    REFERENCES `chickens_factory`.`Avg_fridge` (`Avg_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_car_to_avg_Car1`
    FOREIGN KEY (`Car_num`)
    REFERENCES `chickens_factory`.`Car` (`Car_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_car_to_avg_Intrnal_trans1`
    FOREIGN KEY (`I_ssn`)
    REFERENCES `chickens_factory`.`Intrnal_trans` (`I_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_car_to_avg_Avg_fridge1_idx` ON `chickens_factory`.`car_to_avg` (`Avg_id` ASC);

CREATE INDEX `fk_car_to_avg_Car1_idx` ON `chickens_factory`.`car_to_avg` (`Car_num` ASC);

CREATE INDEX `fk_car_to_avg_Intrnal_trans1_idx` ON `chickens_factory`.`car_to_avg` (`I_ssn` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`avg_to_cracking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`avg_to_cracking` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`avg_to_cracking` (
  `Avg_id` CHAR(3) NOT NULL,
  `C_id` CHAR(3) NOT NULL,
  `I_ssn` CHAR(5) NOT NULL,
  `date_of_working` DATE NULL,
  `hours_of_working` DOUBLE NULL,
  `amount` DOUBLE NULL,
  CONSTRAINT `fk_avg_to_cracking_Intrnal_trans1`
    FOREIGN KEY (`I_ssn`)
    REFERENCES `chickens_factory`.`Intrnal_trans` (`I_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avg_to_cracking_Avg_fridge1`
    FOREIGN KEY (`Avg_id`)
    REFERENCES `chickens_factory`.`Avg_fridge` (`Avg_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avg_to_cracking_Cracking_machine1`
    FOREIGN KEY (`C_id`)
    REFERENCES `chickens_factory`.`Cracking_machine` (`C_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_avg_to_cracking_Intrnal_trans1_idx` ON `chickens_factory`.`avg_to_cracking` (`I_ssn` ASC);

CREATE INDEX `fk_avg_to_cracking_Avg_fridge1_idx` ON `chickens_factory`.`avg_to_cracking` (`Avg_id` ASC);

CREATE INDEX `fk_avg_to_cracking_Cracking_machine1_idx` ON `chickens_factory`.`avg_to_cracking` (`C_id` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`packing_to_short`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`packing_to_short` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`packing_to_short` (
  `Sh_id` CHAR(3) NOT NULL,
  `P_id` CHAR(3) NOT NULL,
  `I_ssn` CHAR(5) NOT NULL,
  `date_of_working` DATE NULL,
  `hours_of_working` DOUBLE NULL,
  `amount` DOUBLE NULL,
  CONSTRAINT `fk_packing_to_short_Intrnal_trans1`
    FOREIGN KEY (`I_ssn`)
    REFERENCES `chickens_factory`.`Intrnal_trans` (`I_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_packing_to_short_Packing_machine1`
    FOREIGN KEY (`P_id`)
    REFERENCES `chickens_factory`.`Packing_machine` (`P_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_packing_to_short_Short_fridge1`
    FOREIGN KEY (`Sh_id`)
    REFERENCES `chickens_factory`.`Short_fridge` (`Sh_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_packing_to_short_Intrnal_trans1_idx` ON `chickens_factory`.`packing_to_short` (`I_ssn` ASC);

CREATE INDEX `fk_packing_to_short_Packing_machine1_idx` ON `chickens_factory`.`packing_to_short` (`P_id` ASC);

CREATE INDEX `fk_packing_to_short_Short_fridge1_idx` ON `chickens_factory`.`packing_to_short` (`Sh_id` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`short_to_long`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`short_to_long` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`short_to_long` (
  `Long_id` CHAR(3) NOT NULL,
  `Sh_id` CHAR(3) NOT NULL,
  `I_ssn` CHAR(5) NOT NULL,
  `date_of_working` DATE NULL,
  `hours_of_working` DOUBLE NULL,
  `amount` DOUBLE NULL,
  CONSTRAINT `fk_short_to_long_Intrnal_trans1`
    FOREIGN KEY (`I_ssn`)
    REFERENCES `chickens_factory`.`Intrnal_trans` (`I_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_short_to_long_Short_fridge1`
    FOREIGN KEY (`Sh_id`)
    REFERENCES `chickens_factory`.`Short_fridge` (`Sh_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_short_to_long_Long_fridge1`
    FOREIGN KEY (`Long_id`)
    REFERENCES `chickens_factory`.`Long_fridge` (`Long_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_short_to_long_Intrnal_trans1_idx` ON `chickens_factory`.`short_to_long` (`I_ssn` ASC);

CREATE INDEX `fk_short_to_long_Short_fridge1_idx` ON `chickens_factory`.`short_to_long` (`Sh_id` ASC);

CREATE INDEX `fk_short_to_long_Long_fridge1_idx` ON `chickens_factory`.`short_to_long` (`Long_id` ASC);


-- -----------------------------------------------------
-- Table `chickens_factory`.`long_to_car`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chickens_factory`.`long_to_car` ;

CREATE TABLE IF NOT EXISTS `chickens_factory`.`long_to_car` (
  `Long_id` CHAR(3) NOT NULL,
  `Car_num` CHAR(3) NOT NULL,
  `I_ssn` CHAR(5) NOT NULL,
  `date_of_working` DATE NULL,
  `hours_of_working` DOUBLE NULL,
  `amount` DOUBLE NULL,
  CONSTRAINT `fk_long_to_car_Intrnal_trans1`
    FOREIGN KEY (`I_ssn`)
    REFERENCES `chickens_factory`.`Intrnal_trans` (`I_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_long_to_car_Long_fridge1`
    FOREIGN KEY (`Long_id`)
    REFERENCES `chickens_factory`.`Long_fridge` (`Long_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_long_to_car_Car1`
    FOREIGN KEY (`Car_num`)
    REFERENCES `chickens_factory`.`Car` (`Car_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_long_to_car_Intrnal_trans1_idx` ON `chickens_factory`.`long_to_car` (`I_ssn` ASC);

CREATE INDEX `fk_long_to_car_Long_fridge1_idx` ON `chickens_factory`.`long_to_car` (`Long_id` ASC);

CREATE INDEX `fk_long_to_car_Car1_idx` ON `chickens_factory`.`long_to_car` (`Car_num` ASC);


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`owner`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`owner` (`O_ssn`, `Fname`) VALUES ('4040', 'mohamed');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Supervison`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Supervison` (`S_ssn`, `type`, `O_ssn`) VALUES ('9876', 'fridge', '4040');
INSERT INTO `chickens_factory`.`Supervison` (`S_ssn`, `type`, `O_ssn`) VALUES ('5551', 'internal transfer', '4040');
INSERT INTO `chickens_factory`.`Supervison` (`S_ssn`, `type`, `O_ssn`) VALUES ('9998', 'machine cracking', '4040');
INSERT INTO `chickens_factory`.`Supervison` (`S_ssn`, `type`, `O_ssn`) VALUES ('3334', 'accounting', '4040');
INSERT INTO `chickens_factory`.`Supervison` (`S_ssn`, `type`, `O_ssn`) VALUES ('6667', 'driver', '4040');
INSERT INTO `chickens_factory`.`Supervison` (`S_ssn`, `type`, `O_ssn`) VALUES ('1234', 'machine packing', '4040');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`accountant`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`accountant` (`A_ssn`) VALUES ('6661');
INSERT INTO `chickens_factory`.`accountant` (`A_ssn`) VALUES ('3339');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('1234', 'john', 'A', 'Doe', 'M', 6000, '2023-01-01', 3, 'null', '6661');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('9876', 'jane', 'B', 'Smith', 'F', 7500, '2023-02-15', 2, 'null', '6661');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('5551', 'Robert', 'C', 'johnson', 'M', 8000, '2023-03-10', 1, 'null', '6661');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('9998', 'sarah', 'D', 'williams', 'F', 7000, '2023-04-05', 2, 'null', '6661');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('3334', 'Michael', 'E', 'Davis', 'M', 9000, '2023-05-20', 3, 'null', '6661');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('6667', 'emily', 'F', 'Brown', 'F', 6500, '2023-06-15', 1, 'null', '6661');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('1112', 'david', 'G', 'miller', 'M', 7000, '2023-07-01', 2, '6667', '6661');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('4445', 'olivia', 'H', 'wilson', 'F', 8500, '2023-08-10', 1, '6667', '6661');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('8889', 'ethan', 'I', 'anderson', 'M', 9500, '2023-09-25', 3, '6667', '6661');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('7776', 'Ava', 'J', 'Taylor', 'F', 7200, '2023-10-15', 2, '6667', '6661');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('2223', 'daniel', 'K', 'white', 'M', 7800, '2023-11-01', 1, '6667', '6661');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('6661', 'sophia', 'L', 'Hall', 'F', 6800, '2023-12-05', 3, '3334', 'null');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('3339', 'matthew', 'M', 'turner', 'M', 9200, '2021-01-20', 2, '3334', 'null');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('8881', 'amelia', 'N', 'evans', 'F', 8200, '2019-02-15', 1, '5551', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('1115', 'benjamin', 'O', 'lee', 'M', 8800, '2020-03-10', 3, '9876', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('9014', 'Taylor', 'X', 'thompson', 'F', 7500, '2020-05-22', 3, '9876', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('0125', 'samuel', 'Y', 'hall', 'M', 8000, '2021-09-05', 1, '9876', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('1236', 'kayla', 'Z', 'davis', 'F', 7000, '2022-08-03', 1, '9876', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('2347', 'Felix', 'A', 'walker', 'M', 6000, '2023-07-11', 2, '9876', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('3458', 'madison', 'B', 'adams', 'F', 5500, '2022-11-22', 3, '5551', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('4569', 'justin', 'C', 'nelson', 'M', 6500, '2020-07-14', 1, '9998', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('5670', 'margon', 'D', 'baker', 'F', 7600, '2021-09-22', 2, '9998', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('6782', 'zachary', 'E', 'morris', 'M', 8000, '2020-04-13', 2, '9998', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('7893', 'haley', 'F', 'simmons', 'F', 7000, '2021-08-23', 2, '9998', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('8904', 'jordan', 'G', 'wright', 'M', 6000, '2023-01-20', 3, '9998', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('9015', 'natalie', 'H', 'turner', 'F', 5500, '2020-07-25', 2, '1234', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('0126', 'ryan', 'I', 'phillips', 'M', 6500, '2021-03-21', 1, '1234', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('1237', 'allison', 'J', 'martinez', 'F', 7800, '2022-08-20', 2, '1234', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('2348', 'Eric', 'K', 'scott', 'M', 8000, '2019-07-28', 3, '1234', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('3459', 'brooke', 'L', 'wood', 'F', 7900, '2020-05-23', 1, '1234', '6661');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('5673', 'Hannah', 'H', 'Perry', 'F', 7500, '2020-06-20', 4, '5551', '6661');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('6785', 'Jordan', 'R', 'Rogers', 'M', 8000, '2022-01-14', 2, '5551', '6661');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('4571', 'Brandon', 'F', 'Kennedy', 'M', 7950, '2021-09-19', 4, '5551', '6661');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('6789', 'Ivy', 'J', 'Baker', 'F', 8000, '2022-09-23', 4, '5551', '3339');
INSERT INTO `chickens_factory`.`Employee` (`ssn`, `Fname`, `Minit`, `Lname`, `Sex`, `salary`, `start_date`, `num_of_varation`, `Supervison_S_ssn`, `accountant_A_ssn`) VALUES ('1098', 'Quincy', 'M', 'Fisher', 'M', 7000, '2021-04-23', 3, '5551', '3339');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`phone`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01156942100, '1234');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01059936100, '9876');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01055889999, '5551');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01255669900, '9998');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01159336699, '3334');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01056669999, '6667');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01122233666, '1112');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01122222555, '4445');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01111111567, '8889');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01122448963, '7776');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01145789856, '2223');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01056321478, '6661');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01155223336, '3339');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01059663311, '8881');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01155669991, '1115');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01122336665, '9014');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01123366641, '0125');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01123654789, '1236');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01233669555, '2347');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01122222336, '3458');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01255556698, '4569');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01233666789, '5670');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01111156987, '6782');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01236695872, '7893');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01010102323, '8904');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01112366658, '9015');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01122345669, '0126');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01111212121, '1237');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01115252588, '2348');
INSERT INTO `chickens_factory`.`phone` (`num_of_phone`, `ssn`) VALUES (01112356666, '3459');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Driver`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Driver` (`D_ssn`) VALUES ('1112');
INSERT INTO `chickens_factory`.`Driver` (`D_ssn`) VALUES ('4445');
INSERT INTO `chickens_factory`.`Driver` (`D_ssn`) VALUES ('8889');
INSERT INTO `chickens_factory`.`Driver` (`D_ssn`) VALUES ('7776');
INSERT INTO `chickens_factory`.`Driver` (`D_ssn`) VALUES ('2223');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Car`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Car` (`Car_num`, `Model`, `Date_end_licence`, `D_ssn`) VALUES ('557', 'Chevrolet 2015', '2024-01-01', '1112');
INSERT INTO `chickens_factory`.`Car` (`Car_num`, `Model`, `Date_end_licence`, `D_ssn`) VALUES ('639', 'Toyota 2010', '2025-03-02', '4445');
INSERT INTO `chickens_factory`.`Car` (`Car_num`, `Model`, `Date_end_licence`, `D_ssn`) VALUES ('223', 'Toyota 2020', '2026-06-02', '8889');
INSERT INTO `chickens_factory`.`Car` (`Car_num`, `Model`, `Date_end_licence`, `D_ssn`) VALUES ('221', 'Chevrolet 2000', '2030-02-02', '7776');
INSERT INTO `chickens_factory`.`Car` (`Car_num`, `Model`, `Date_end_licence`, `D_ssn`) VALUES ('001', 'Chevrolet 2010', '2023-12-22', '2223');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`pay`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`pay` (`A_ssn`, `D_ssn`, `Cash`, `Date_of_paying`, `amount_of_product`) VALUES ('6661', '1112', 16000, '2023-10-15', 200);
INSERT INTO `chickens_factory`.`pay` (`A_ssn`, `D_ssn`, `Cash`, `Date_of_paying`, `amount_of_product`) VALUES ('6661', '4445', 30000, '2023-11-21', 300);
INSERT INTO `chickens_factory`.`pay` (`A_ssn`, `D_ssn`, `Cash`, `Date_of_paying`, `amount_of_product`) VALUES ('6661', '8889', 35000, '2023-09-20', 350);
INSERT INTO `chickens_factory`.`pay` (`A_ssn`, `D_ssn`, `Cash`, `Date_of_paying`, `amount_of_product`) VALUES ('3339', '7776', 60000, '2023-05-20', 400);
INSERT INTO `chickens_factory`.`pay` (`A_ssn`, `D_ssn`, `Cash`, `Date_of_paying`, `amount_of_product`) VALUES ('3339', '2223', 90000, '2023-09-29', 600);

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Emp_machine`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Emp_machine` (`M_ssn`, `Type`) VALUES ('4569', 'cracking');
INSERT INTO `chickens_factory`.`Emp_machine` (`M_ssn`, `Type`) VALUES ('5670', 'cracking');
INSERT INTO `chickens_factory`.`Emp_machine` (`M_ssn`, `Type`) VALUES ('6782', 'cracking');
INSERT INTO `chickens_factory`.`Emp_machine` (`M_ssn`, `Type`) VALUES ('7893', 'cracking');
INSERT INTO `chickens_factory`.`Emp_machine` (`M_ssn`, `Type`) VALUES ('8904', 'cracking');
INSERT INTO `chickens_factory`.`Emp_machine` (`M_ssn`, `Type`) VALUES ('9015', 'packing');
INSERT INTO `chickens_factory`.`Emp_machine` (`M_ssn`, `Type`) VALUES ('0126', 'packing');
INSERT INTO `chickens_factory`.`Emp_machine` (`M_ssn`, `Type`) VALUES ('1237', 'packing');
INSERT INTO `chickens_factory`.`Emp_machine` (`M_ssn`, `Type`) VALUES ('2348', 'packing');
INSERT INTO `chickens_factory`.`Emp_machine` (`M_ssn`, `Type`) VALUES ('3459', 'packing');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Emp_cracking_machine`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Emp_cracking_machine` (`C_ssn`) VALUES ('4569');
INSERT INTO `chickens_factory`.`Emp_cracking_machine` (`C_ssn`) VALUES ('5670');
INSERT INTO `chickens_factory`.`Emp_cracking_machine` (`C_ssn`) VALUES ('6782');
INSERT INTO `chickens_factory`.`Emp_cracking_machine` (`C_ssn`) VALUES ('7893');
INSERT INTO `chickens_factory`.`Emp_cracking_machine` (`C_ssn`) VALUES ('8904');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Emp_packing_machine`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Emp_packing_machine` (`P_ssn`) VALUES ('9015');
INSERT INTO `chickens_factory`.`Emp_packing_machine` (`P_ssn`) VALUES ('0126');
INSERT INTO `chickens_factory`.`Emp_packing_machine` (`P_ssn`) VALUES ('1237');
INSERT INTO `chickens_factory`.`Emp_packing_machine` (`P_ssn`) VALUES ('2348');
INSERT INTO `chickens_factory`.`Emp_packing_machine` (`P_ssn`) VALUES ('3459');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Machine`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Machine` (`M_id`, `HP`, `Model`) VALUES ('EER', '10000', 'QuantumQuery');
INSERT INTO `chickens_factory`.`Machine` (`M_id`, `HP`, `Model`) VALUES ('RER', '15000', 'Cybersync');
INSERT INTO `chickens_factory`.`Machine` (`M_id`, `HP`, `Model`) VALUES ('LOL', '27000', 'DataDynamo');
INSERT INTO `chickens_factory`.`Machine` (`M_id`, `HP`, `Model`) VALUES ('POP', '14000', 'NexusForge');
INSERT INTO `chickens_factory`.`Machine` (`M_id`, `HP`, `Model`) VALUES ('CHA', '16000', 'ByteBlaze');
INSERT INTO `chickens_factory`.`Machine` (`M_id`, `HP`, `Model`) VALUES ('b', '20000', 'EchoValut');
INSERT INTO `chickens_factory`.`Machine` (`M_id`, `HP`, `Model`) VALUES ('TYT', '30000', 'InfinitronDB');
INSERT INTO `chickens_factory`.`Machine` (`M_id`, `HP`, `Model`) VALUES ('TYP', '24000', 'CatalystCore');
INSERT INTO `chickens_factory`.`Machine` (`M_id`, `HP`, `Model`) VALUES ('WEE', '11000', 'QuantumNexus');
INSERT INTO `chickens_factory`.`Machine` (`M_id`, `HP`, `Model`) VALUES ('VVV', '19000', 'DynamoSphere');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Cracking_machine`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Cracking_machine` (`C_id`) VALUES ('EER');
INSERT INTO `chickens_factory`.`Cracking_machine` (`C_id`) VALUES ('RER');
INSERT INTO `chickens_factory`.`Cracking_machine` (`C_id`) VALUES ('LOL');
INSERT INTO `chickens_factory`.`Cracking_machine` (`C_id`) VALUES ('POP');
INSERT INTO `chickens_factory`.`Cracking_machine` (`C_id`) VALUES ('CHA');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Packing_machine`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Packing_machine` (`P_id`, `amount`, `C_id`) VALUES ('ZXZ', '10000', 'EER');
INSERT INTO `chickens_factory`.`Packing_machine` (`P_id`, `amount`, `C_id`) VALUES ('TYT', '15000', 'CHA');
INSERT INTO `chickens_factory`.`Packing_machine` (`P_id`, `amount`, `C_id`) VALUES ('TYP', '5000', 'RER');
INSERT INTO `chickens_factory`.`Packing_machine` (`P_id`, `amount`, `C_id`) VALUES ('WEE', '20000', 'POP');
INSERT INTO `chickens_factory`.`Packing_machine` (`P_id`, `amount`, `C_id`) VALUES ('VVV', '7000', 'LOL');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Cracking`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Cracking` (`C_id`, `C_ssn`, `Hours_of_working`, `Date_of_working`) VALUES ('CHA', '8904', 5, '2023-04-17');
INSERT INTO `chickens_factory`.`Cracking` (`C_id`, `C_ssn`, `Hours_of_working`, `Date_of_working`) VALUES ('POP', '7893', 7, '2023-05-09');
INSERT INTO `chickens_factory`.`Cracking` (`C_id`, `C_ssn`, `Hours_of_working`, `Date_of_working`) VALUES ('LOL', '4569', 3, '2023-09-11');
INSERT INTO `chickens_factory`.`Cracking` (`C_id`, `C_ssn`, `Hours_of_working`, `Date_of_working`) VALUES ('EER', '5670', 9, '2023-12-12');
INSERT INTO `chickens_factory`.`Cracking` (`C_id`, `C_ssn`, `Hours_of_working`, `Date_of_working`) VALUES ('RER', '6782', 2, '2023-01-01');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Packing`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Packing` (`P_id`, `P_ssn`, `Hours_of_working`, `Date_of_working`) VALUES ('ZXZ', '9015', 6, '2023-09-06');
INSERT INTO `chickens_factory`.`Packing` (`P_id`, `P_ssn`, `Hours_of_working`, `Date_of_working`) VALUES ('TYP', '3459', 3, '2023-04-09');
INSERT INTO `chickens_factory`.`Packing` (`P_id`, `P_ssn`, `Hours_of_working`, `Date_of_working`) VALUES ('VVV', '0126', 10, '2023-12-04');
INSERT INTO `chickens_factory`.`Packing` (`P_id`, `P_ssn`, `Hours_of_working`, `Date_of_working`) VALUES ('TYT', '2348', 5, '2023-03-22');
INSERT INTO `chickens_factory`.`Packing` (`P_id`, `P_ssn`, `Hours_of_working`, `Date_of_working`) VALUES ('WEE', '1237', 4, '2023-01-12');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Fridge`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Fridge` (`F_id`, `HP`) VALUES ('AQ2', '10000');
INSERT INTO `chickens_factory`.`Fridge` (`F_id`, `HP`) VALUES ('MS1', '12121');
INSERT INTO `chickens_factory`.`Fridge` (`F_id`, `HP`) VALUES ('AA2', '26541');
INSERT INTO `chickens_factory`.`Fridge` (`F_id`, `HP`) VALUES ('SS2', '98412');
INSERT INTO `chickens_factory`.`Fridge` (`F_id`, `HP`) VALUES ('ZA1', '56121');
INSERT INTO `chickens_factory`.`Fridge` (`F_id`, `HP`) VALUES ('QW2', '40000');
INSERT INTO `chickens_factory`.`Fridge` (`F_id`, `HP`) VALUES ('BB3', '45000');
INSERT INTO `chickens_factory`.`Fridge` (`F_id`, `HP`) VALUES ('WW3', '12000');
INSERT INTO `chickens_factory`.`Fridge` (`F_id`, `HP`) VALUES ('ZZ1', '21765');
INSERT INTO `chickens_factory`.`Fridge` (`F_id`, `HP`) VALUES ('JK1', '54321');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Short_fridge`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Short_fridge` (`Sh_id`, `Amount`) VALUES ('QW2', 1000);
INSERT INTO `chickens_factory`.`Short_fridge` (`Sh_id`, `Amount`) VALUES ('BB3', 2000);
INSERT INTO `chickens_factory`.`Short_fridge` (`Sh_id`, `Amount`) VALUES ('WW3', 4000);
INSERT INTO `chickens_factory`.`Short_fridge` (`Sh_id`, `Amount`) VALUES ('ZZ1', 3000);
INSERT INTO `chickens_factory`.`Short_fridge` (`Sh_id`, `Amount`) VALUES ('JK1', 1500);

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Avg_fridge`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Avg_fridge` (`Avg_id`, `Amount`) VALUES ('AQ2', 20000);
INSERT INTO `chickens_factory`.`Avg_fridge` (`Avg_id`, `Amount`) VALUES ('MS1', 30000);
INSERT INTO `chickens_factory`.`Avg_fridge` (`Avg_id`, `Amount`) VALUES ('AA2', 19000);
INSERT INTO `chickens_factory`.`Avg_fridge` (`Avg_id`, `Amount`) VALUES ('SS2', 10000);
INSERT INTO `chickens_factory`.`Avg_fridge` (`Avg_id`, `Amount`) VALUES ('ZA1', 6000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Long_fridge`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Long_fridge` (`Long_id`, `Amount`) VALUES ('MM1', 20000);
INSERT INTO `chickens_factory`.`Long_fridge` (`Long_id`, `Amount`) VALUES ('YU4', 50000);
INSERT INTO `chickens_factory`.`Long_fridge` (`Long_id`, `Amount`) VALUES ('CH2', 30000);
INSERT INTO `chickens_factory`.`Long_fridge` (`Long_id`, `Amount`) VALUES ('MO3', 12000);
INSERT INTO `chickens_factory`.`Long_fridge` (`Long_id`, `Amount`) VALUES ('SA2', 40500);

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Emp_avg_fridge`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Emp_avg_fridge` (`Avg_ssn`) VALUES ('1115');
INSERT INTO `chickens_factory`.`Emp_avg_fridge` (`Avg_ssn`) VALUES ('9014');
INSERT INTO `chickens_factory`.`Emp_avg_fridge` (`Avg_ssn`) VALUES ('0125');
INSERT INTO `chickens_factory`.`Emp_avg_fridge` (`Avg_ssn`) VALUES ('1236');
INSERT INTO `chickens_factory`.`Emp_avg_fridge` (`Avg_ssn`) VALUES ('2347');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Avg_work`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Avg_work` (`Avg_id`, `Avg_ssn`, `Hours_of_working`, `Date_of_working`) VALUES ('AQ2', '0125', 12, '2023-09-11');
INSERT INTO `chickens_factory`.`Avg_work` (`Avg_id`, `Avg_ssn`, `Hours_of_working`, `Date_of_working`) VALUES ('MS1', '1236', 9, '2023-04-17');
INSERT INTO `chickens_factory`.`Avg_work` (`Avg_id`, `Avg_ssn`, `Hours_of_working`, `Date_of_working`) VALUES ('AA2', '2347', 11, '2023-01-03');
INSERT INTO `chickens_factory`.`Avg_work` (`Avg_id`, `Avg_ssn`, `Hours_of_working`, `Date_of_working`) VALUES ('SS2', '1115', 10, '2023-10-12');
INSERT INTO `chickens_factory`.`Avg_work` (`Avg_id`, `Avg_ssn`, `Hours_of_working`, `Date_of_working`) VALUES ('ZA1', '9014', 8, '2023-07-11');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`Intrnal_trans`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`Intrnal_trans` (`I_ssn`) VALUES ('8881');
INSERT INTO `chickens_factory`.`Intrnal_trans` (`I_ssn`) VALUES ('3458');
INSERT INTO `chickens_factory`.`Intrnal_trans` (`I_ssn`) VALUES ('5673');
INSERT INTO `chickens_factory`.`Intrnal_trans` (`I_ssn`) VALUES ('6785');
INSERT INTO `chickens_factory`.`Intrnal_trans` (`I_ssn`) VALUES ('4571');
INSERT INTO `chickens_factory`.`Intrnal_trans` (`I_ssn`) VALUES ('6789');
INSERT INTO `chickens_factory`.`Intrnal_trans` (`I_ssn`) VALUES ('1098');

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`car_to_avg`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`car_to_avg` (`Avg_id`, `Car_num`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('AQ2', '557', '8881', '2023-04-14', 4, 4000);
INSERT INTO `chickens_factory`.`car_to_avg` (`Avg_id`, `Car_num`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('ZA1', '221', '1098', '2023-05-09', 7, 6000);
INSERT INTO `chickens_factory`.`car_to_avg` (`Avg_id`, `Car_num`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('AA2', '001', '5673', '2022-08-11', 5, 5000);
INSERT INTO `chickens_factory`.`car_to_avg` (`Avg_id`, `Car_num`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('SS2', '223', '3458', '2023-09-22', 3, 2000);
INSERT INTO `chickens_factory`.`car_to_avg` (`Avg_id`, `Car_num`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('MS1', '639', '6789', '2023-01-01', 9, 8000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`avg_to_cracking`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`avg_to_cracking` (`Avg_id`, `C_id`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('AQ2', 'EER', '8881', '2023-08-09', 4, 10000);
INSERT INTO `chickens_factory`.`avg_to_cracking` (`Avg_id`, `C_id`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('ZA1', 'CHA', '1098', '2023-04-17', 9, 15000);
INSERT INTO `chickens_factory`.`avg_to_cracking` (`Avg_id`, `C_id`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('MS1', 'POP', '6789', '2023-07-07', 1, 1000);
INSERT INTO `chickens_factory`.`avg_to_cracking` (`Avg_id`, `C_id`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('AA2', 'RER', '3458', '2023-01-15', 3, 4000);
INSERT INTO `chickens_factory`.`avg_to_cracking` (`Avg_id`, `C_id`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('SS2', 'LOL', '4571', '2023-03-23', 6, 7000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`packing_to_short`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`packing_to_short` (`Sh_id`, `P_id`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('ZZ1', 'TYT', '8881', '2023-04-17', 4, 3000);
INSERT INTO `chickens_factory`.`packing_to_short` (`Sh_id`, `P_id`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('JK1', 'TYP', '4571', '2023-05-06', 2, 1000);
INSERT INTO `chickens_factory`.`packing_to_short` (`Sh_id`, `P_id`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('WW3', 'VVV', '1098', '2023-11-12', 6, 5000);
INSERT INTO `chickens_factory`.`packing_to_short` (`Sh_id`, `P_id`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('BB3', 'WEE', '6785', '2023-09-11', 9, 10000);
INSERT INTO `chickens_factory`.`packing_to_short` (`Sh_id`, `P_id`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('QW2', 'ZXZ', '3458', '2023-01-12', 3, 4000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`short_to_long`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`short_to_long` (`Long_id`, `Sh_id`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('YU4', 'QW2', '1098', '2023-09-11', 5, 5000);
INSERT INTO `chickens_factory`.`short_to_long` (`Long_id`, `Sh_id`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('SA2', 'JK1', '3458', '2023-08-01', 1, 1000);
INSERT INTO `chickens_factory`.`short_to_long` (`Long_id`, `Sh_id`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('CH2', 'ZZ1', '6789', '2023-11-09', 4, 4000);
INSERT INTO `chickens_factory`.`short_to_long` (`Long_id`, `Sh_id`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('MO3', 'BB3', '8881', '2023-01-04', 9, 10000);
INSERT INTO `chickens_factory`.`short_to_long` (`Long_id`, `Sh_id`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('MM1', 'WW3', '4571', '2023-04-17', 6, 7000);

COMMIT;


-- -----------------------------------------------------
-- Data for table `chickens_factory`.`long_to_car`
-- -----------------------------------------------------
START TRANSACTION;
USE `chickens_factory`;
INSERT INTO `chickens_factory`.`long_to_car` (`Long_id`, `Car_num`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('MM1', '557', '1098', '2023-08-08', 2, 2000);
INSERT INTO `chickens_factory`.`long_to_car` (`Long_id`, `Car_num`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('SA2', '001', '5673', '2023-09-11', 5, 6000);
INSERT INTO `chickens_factory`.`long_to_car` (`Long_id`, `Car_num`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('YU4', '639', '4571', '2023-04-17', 8, 10000);
INSERT INTO `chickens_factory`.`long_to_car` (`Long_id`, `Car_num`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('MO3', '223', '8881', '2023-05-09', 3, 3000);
INSERT INTO `chickens_factory`.`long_to_car` (`Long_id`, `Car_num`, `I_ssn`, `date_of_working`, `hours_of_working`, `amount`) VALUES ('CH2', '221', '6789', '2023-11-12', 1, 1000);

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
