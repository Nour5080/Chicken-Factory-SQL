-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema chicken_factory
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `chicken_factory` ;

-- -----------------------------------------------------
-- Schema chicken_factory
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `chicken_factory` DEFAULT CHARACTER SET utf8 ;
USE `chicken_factory` ;

-- -----------------------------------------------------
-- Table `chicken_factory`.`owner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`owner` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`owner` (
  `O_ssn` CHAR(5) NOT NULL,
  `Fname` VARCHAR(10) NULL,
  PRIMARY KEY (`O_ssn`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chicken_factory`.`Supervison`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Supervison` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Supervison` (
  `S_ssn` CHAR(5) NOT NULL,
  `type` VARCHAR(45) NULL,
  `O_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`S_ssn`),
  CONSTRAINT `fk_Supervison_owner1`
    FOREIGN KEY (`O_ssn`)
    REFERENCES `chicken_factory`.`owner` (`O_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Supervison_Employee1`
    FOREIGN KEY (`S_ssn`)
    REFERENCES `chicken_factory`.`Employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Supervison_owner1_idx` ON `chicken_factory`.`Supervison` (`O_ssn` ASC);

CREATE INDEX `fk_Supervison_Employee1_idx` ON `chicken_factory`.`Supervison` (`S_ssn` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Employee` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Employee` (
  `ssn` CHAR(5) NOT NULL,
  `Fname` VARCHAR(10) NULL,
  `Mname` VARCHAR(10) NULL,
  `Lname` VARCHAR(10) NULL,
  `Sex` CHAR NULL,
  `salary` DOUBLE NULL,
  `start_date` DATE NULL,
  `num_of_varation` INT NULL,
  `Supervison_S_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`ssn`),
  CONSTRAINT `fk_Employee_Supervison1`
    FOREIGN KEY (`Supervison_S_ssn`)
    REFERENCES `chicken_factory`.`Supervison` (`S_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Employee_Supervison1_idx` ON `chicken_factory`.`Employee` (`Supervison_S_ssn` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`phone`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`phone` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`phone` (
  `num_of_phone` INT NOT NULL,
  `ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`num_of_phone`, `ssn`),
  CONSTRAINT `fk_phone_Employee1`
    FOREIGN KEY (`ssn`)
    REFERENCES `chicken_factory`.`Employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_phone_Employee1_idx` ON `chicken_factory`.`phone` (`ssn` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`accountant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`accountant` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`accountant` (
  `A_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`A_ssn`),
  CONSTRAINT `fk_accountant_Employee1`
    FOREIGN KEY (`A_ssn`)
    REFERENCES `chicken_factory`.`Employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_accountant_Employee1_idx` ON `chicken_factory`.`accountant` (`A_ssn` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Driver`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Driver` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Driver` (
  `D_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`D_ssn`),
  CONSTRAINT `fk_Driver_Employee1`
    FOREIGN KEY (`D_ssn`)
    REFERENCES `chicken_factory`.`Employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Driver_Employee1_idx` ON `chicken_factory`.`Driver` (`D_ssn` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Car`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Car` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Car` (
  `Car_num` CHAR(3) NOT NULL,
  `Model` VARCHAR(15) NULL,
  `Date_end_licence` DATE NULL,
  `D_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`Car_num`),
  CONSTRAINT `fk_Car_Driver1`
    FOREIGN KEY (`D_ssn`)
    REFERENCES `chicken_factory`.`Driver` (`D_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Car_Driver1_idx` ON `chicken_factory`.`Car` (`D_ssn` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`pay`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`pay` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`pay` (
  `A_ssn` CHAR(5) NOT NULL,
  `D_ssn` CHAR(5) NOT NULL,
  `Cash` DOUBLE NULL,
  `Date_of_paying` DATE NULL,
  `amount_of_product` DOUBLE NULL,
  PRIMARY KEY (`A_ssn`, `D_ssn`),
  CONSTRAINT `fk_Driver_has_accountant_Driver1`
    FOREIGN KEY (`D_ssn`)
    REFERENCES `chicken_factory`.`Driver` (`D_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Driver_has_accountant_accountant1`
    FOREIGN KEY (`A_ssn`)
    REFERENCES `chicken_factory`.`accountant` (`A_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Driver_has_accountant_accountant1_idx` ON `chicken_factory`.`pay` (`A_ssn` ASC);

CREATE INDEX `fk_Driver_has_accountant_Driver1_idx` ON `chicken_factory`.`pay` (`D_ssn` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Emp_machine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Emp_machine` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Emp_machine` (
  `M_ssn` CHAR(5) NOT NULL,
  `Type` VARCHAR(15) NULL,
  PRIMARY KEY (`M_ssn`),
  CONSTRAINT `fk_Emp_machine_Employee1`
    FOREIGN KEY (`M_ssn`)
    REFERENCES `chicken_factory`.`Employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Emp_machine_Employee1_idx` ON `chicken_factory`.`Emp_machine` (`M_ssn` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Emp_cracking_machine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Emp_cracking_machine` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Emp_cracking_machine` (
  `C_ssn` CHAR(5) NOT NULL,
  `Type` VARCHAR(15) NULL,
  PRIMARY KEY (`C_ssn`),
  CONSTRAINT `fk_Emp_cracking_machine_Emp_machine1`
    FOREIGN KEY (`C_ssn`)
    REFERENCES `chicken_factory`.`Emp_machine` (`M_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Emp_cracking_machine_Emp_machine1_idx` ON `chicken_factory`.`Emp_cracking_machine` (`C_ssn` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Emp_packing_machine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Emp_packing_machine` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Emp_packing_machine` (
  `P_ssn` CHAR(5) NOT NULL,
  `Type` VARCHAR(15) NULL,
  PRIMARY KEY (`P_ssn`),
  CONSTRAINT `fk_Emp_packing_machine_Emp_machine1`
    FOREIGN KEY (`P_ssn`)
    REFERENCES `chicken_factory`.`Emp_machine` (`M_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Emp_packing_machine_Emp_machine1_idx` ON `chicken_factory`.`Emp_packing_machine` (`P_ssn` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Machine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Machine` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Machine` (
  `M_id` CHAR(3) NOT NULL,
  `HP` CHAR(5) NULL,
  `Model` VARCHAR(15) NULL,
  PRIMARY KEY (`M_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chicken_factory`.`Cracking_machine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Cracking_machine` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Cracking_machine` (
  `C_id` CHAR(3) NOT NULL,
  PRIMARY KEY (`C_id`),
  CONSTRAINT `fk_Cracking_machine_Machine1`
    FOREIGN KEY (`C_id`)
    REFERENCES `chicken_factory`.`Machine` (`M_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Cracking_machine_Machine1_idx` ON `chicken_factory`.`Cracking_machine` (`C_id` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Packing_machine`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Packing_machine` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Packing_machine` (
  `P_id` CHAR(3) NOT NULL,
  `amount` VARCHAR(15) NULL,
  `C_id` CHAR(3) NOT NULL,
  PRIMARY KEY (`P_id`),
  CONSTRAINT `fk_table1_Machine1`
    FOREIGN KEY (`P_id`)
    REFERENCES `chicken_factory`.`Machine` (`M_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Packing_machine_Cracking_machine1`
    FOREIGN KEY (`C_id`)
    REFERENCES `chicken_factory`.`Cracking_machine` (`C_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_table1_Machine1_idx` ON `chicken_factory`.`Packing_machine` (`P_id` ASC);

CREATE INDEX `fk_Packing_machine_Cracking_machine1_idx` ON `chicken_factory`.`Packing_machine` (`C_id` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Cracking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Cracking` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Cracking` (
  `C_id` CHAR(3) NOT NULL,
  `C_ssn` CHAR(5) NOT NULL,
  `Hours_of_working` DOUBLE NULL,
  `Date_of_working` DATE NULL,
  PRIMARY KEY (`C_id`, `C_ssn`),
  CONSTRAINT `fk_Cracking_machine_has_Emp_cracking_machine_Cracking_machine1`
    FOREIGN KEY (`C_id`)
    REFERENCES `chicken_factory`.`Cracking_machine` (`C_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cracking_machine_has_Emp_cracking_machine_Emp_cracking_mac1`
    FOREIGN KEY (`C_ssn`)
    REFERENCES `chicken_factory`.`Emp_cracking_machine` (`C_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Cracking_machine_has_Emp_cracking_machine_Emp_cracking_m_idx` ON `chicken_factory`.`Cracking` (`C_ssn` ASC);

CREATE INDEX `fk_Cracking_machine_has_Emp_cracking_machine_Cracking_machi_idx` ON `chicken_factory`.`Cracking` (`C_id` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Packing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Packing` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Packing` (
  `P_id` CHAR(3) NOT NULL,
  `P_ssn` CHAR(5) NOT NULL,
  `Hours_of_working` DOUBLE NULL,
  `Date_of_working` DATE NULL,
  PRIMARY KEY (`P_id`, `P_ssn`),
  CONSTRAINT `fk_Packing_machine_has_Emp_packing_machine_Packing_machine1`
    FOREIGN KEY (`P_id`)
    REFERENCES `chicken_factory`.`Packing_machine` (`P_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Packing_machine_has_Emp_packing_machine_Emp_packing_machine1`
    FOREIGN KEY (`P_ssn`)
    REFERENCES `chicken_factory`.`Emp_packing_machine` (`P_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Packing_machine_has_Emp_packing_machine_Emp_packing_mach_idx` ON `chicken_factory`.`Packing` (`P_ssn` ASC);

CREATE INDEX `fk_Packing_machine_has_Emp_packing_machine_Packing_machine1_idx` ON `chicken_factory`.`Packing` (`P_id` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Fridge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Fridge` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Fridge` (
  `F_id` CHAR(3) NOT NULL,
  `HP` CHAR(5) NULL,
  PRIMARY KEY (`F_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chicken_factory`.`Short_fridge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Short_fridge` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Short_fridge` (
  `Sh_id` CHAR(3) NOT NULL,
  `Amount` DOUBLE NULL,
  PRIMARY KEY (`Sh_id`),
  CONSTRAINT `fk_Short_fridge_Fridge1`
    FOREIGN KEY (`Sh_id`)
    REFERENCES `chicken_factory`.`Fridge` (`F_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Short_fridge_Fridge1_idx` ON `chicken_factory`.`Short_fridge` (`Sh_id` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Avg_fridge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Avg_fridge` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Avg_fridge` (
  `Avg_id` CHAR(3) NOT NULL,
  `Amount` DOUBLE NULL,
  PRIMARY KEY (`Avg_id`),
  CONSTRAINT `fk_Avg_fridge_Fridge1`
    FOREIGN KEY (`Avg_id`)
    REFERENCES `chicken_factory`.`Fridge` (`F_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Avg_fridge_Fridge1_idx` ON `chicken_factory`.`Avg_fridge` (`Avg_id` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Long_fridge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Long_fridge` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Long_fridge` (
  `Long_id` CHAR(3) NOT NULL,
  `Amount` DOUBLE NULL,
  PRIMARY KEY (`Long_id`),
  CONSTRAINT `fk_Long_Fridge1`
    FOREIGN KEY (`Long_id`)
    REFERENCES `chicken_factory`.`Fridge` (`F_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Long_Fridge1_idx` ON `chicken_factory`.`Long_fridge` (`Long_id` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Emp_avg_fridge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Emp_avg_fridge` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Emp_avg_fridge` (
  `Avg_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`Avg_ssn`),
  CONSTRAINT `fk_Emp_avg_fridge_Employee1`
    FOREIGN KEY (`Avg_ssn`)
    REFERENCES `chicken_factory`.`Employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Emp_avg_fridge_Employee1_idx` ON `chicken_factory`.`Emp_avg_fridge` (`Avg_ssn` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Avg_work`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Avg_work` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Avg_work` (
  `Avg_id` CHAR(3) NOT NULL,
  `Avg_ssn` CHAR(5) NOT NULL,
  `Hours_of_working` DOUBLE NULL,
  `Date_of_working` DATE NULL,
  PRIMARY KEY (`Avg_id`, `Avg_ssn`),
  CONSTRAINT `fk_Avg_fridge_has_Emp_avg_fridge_Avg_fridge1`
    FOREIGN KEY (`Avg_id`)
    REFERENCES `chicken_factory`.`Avg_fridge` (`Avg_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Avg_fridge_has_Emp_avg_fridge_Emp_avg_fridge1`
    FOREIGN KEY (`Avg_ssn`)
    REFERENCES `chicken_factory`.`Emp_avg_fridge` (`Avg_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Avg_fridge_has_Emp_avg_fridge_Emp_avg_fridge1_idx` ON `chicken_factory`.`Avg_work` (`Avg_ssn` ASC);

CREATE INDEX `fk_Avg_fridge_has_Emp_avg_fridge_Avg_fridge1_idx` ON `chicken_factory`.`Avg_work` (`Avg_id` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`Intrnal_trans`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`Intrnal_trans` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`Intrnal_trans` (
  `I_ssn` CHAR(5) NOT NULL,
  PRIMARY KEY (`I_ssn`),
  CONSTRAINT `fk_Intrnal_trans_Employee1`
    FOREIGN KEY (`I_ssn`)
    REFERENCES `chicken_factory`.`Employee` (`ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Intrnal_trans_Employee1_idx` ON `chicken_factory`.`Intrnal_trans` (`I_ssn` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`car_to_avg`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`car_to_avg` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`car_to_avg` (
  `Avg_id` CHAR(3) NOT NULL,
  `Car_num` CHAR(3) NOT NULL,
  `I_ssn` CHAR(5) NOT NULL,
  `date_of_working` DATE NULL,
  `hours_of_working` DOUBLE NULL,
  `amount` DOUBLE NULL,
  CONSTRAINT `fk_car_to_avg_Avg_fridge1`
    FOREIGN KEY (`Avg_id`)
    REFERENCES `chicken_factory`.`Avg_fridge` (`Avg_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_car_to_avg_Car1`
    FOREIGN KEY (`Car_num`)
    REFERENCES `chicken_factory`.`Car` (`Car_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_car_to_avg_Intrnal_trans1`
    FOREIGN KEY (`I_ssn`)
    REFERENCES `chicken_factory`.`Intrnal_trans` (`I_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_car_to_avg_Avg_fridge1_idx` ON `chicken_factory`.`car_to_avg` (`Avg_id` ASC);

CREATE INDEX `fk_car_to_avg_Car1_idx` ON `chicken_factory`.`car_to_avg` (`Car_num` ASC);

CREATE INDEX `fk_car_to_avg_Intrnal_trans1_idx` ON `chicken_factory`.`car_to_avg` (`I_ssn` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`avg_to_cracking`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`avg_to_cracking` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`avg_to_cracking` (
  `date_of_working` DATE NULL,
  `hours_of_working` DOUBLE NULL,
  `amount` DOUBLE NULL,
  `I_ssn` CHAR(5) NOT NULL,
  `Avg_id` CHAR(3) NOT NULL,
  `C_id` CHAR(3) NOT NULL,
  CONSTRAINT `fk_avg_to_cracking_Intrnal_trans1`
    FOREIGN KEY (`I_ssn`)
    REFERENCES `chicken_factory`.`Intrnal_trans` (`I_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avg_to_cracking_Avg_fridge1`
    FOREIGN KEY (`Avg_id`)
    REFERENCES `chicken_factory`.`Avg_fridge` (`Avg_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avg_to_cracking_Cracking_machine1`
    FOREIGN KEY (`C_id`)
    REFERENCES `chicken_factory`.`Cracking_machine` (`C_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_avg_to_cracking_Intrnal_trans1_idx` ON `chicken_factory`.`avg_to_cracking` (`I_ssn` ASC);

CREATE INDEX `fk_avg_to_cracking_Avg_fridge1_idx` ON `chicken_factory`.`avg_to_cracking` (`Avg_id` ASC);

CREATE INDEX `fk_avg_to_cracking_Cracking_machine1_idx` ON `chicken_factory`.`avg_to_cracking` (`C_id` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`packing_to_short`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`packing_to_short` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`packing_to_short` (
  `date_of_working` DATE NULL,
  `hours_of_working` DOUBLE NULL,
  `amount` DOUBLE NULL,
  `I_ssn` CHAR(5) NOT NULL,
  `P_id` CHAR(3) NOT NULL,
  `Sh_id` CHAR(3) NOT NULL,
  CONSTRAINT `fk_packing_to_short_Intrnal_trans1`
    FOREIGN KEY (`I_ssn`)
    REFERENCES `chicken_factory`.`Intrnal_trans` (`I_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_packing_to_short_Packing_machine1`
    FOREIGN KEY (`P_id`)
    REFERENCES `chicken_factory`.`Packing_machine` (`P_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_packing_to_short_Short_fridge1`
    FOREIGN KEY (`Sh_id`)
    REFERENCES `chicken_factory`.`Short_fridge` (`Sh_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_packing_to_short_Intrnal_trans1_idx` ON `chicken_factory`.`packing_to_short` (`I_ssn` ASC);

CREATE INDEX `fk_packing_to_short_Packing_machine1_idx` ON `chicken_factory`.`packing_to_short` (`P_id` ASC);

CREATE INDEX `fk_packing_to_short_Short_fridge1_idx` ON `chicken_factory`.`packing_to_short` (`Sh_id` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`short_to_long`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`short_to_long` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`short_to_long` (
  `date_of_working` DATE NULL,
  `hours_of_working` DOUBLE NULL,
  `amount` DOUBLE NULL,
  `I_ssn` CHAR(5) NOT NULL,
  `Sh_id` CHAR(3) NOT NULL,
  `Long_id` CHAR(3) NOT NULL,
  CONSTRAINT `fk_short_to_long_Intrnal_trans1`
    FOREIGN KEY (`I_ssn`)
    REFERENCES `chicken_factory`.`Intrnal_trans` (`I_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_short_to_long_Short_fridge1`
    FOREIGN KEY (`Sh_id`)
    REFERENCES `chicken_factory`.`Short_fridge` (`Sh_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_short_to_long_Long_fridge1`
    FOREIGN KEY (`Long_id`)
    REFERENCES `chicken_factory`.`Long_fridge` (`Long_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_short_to_long_Intrnal_trans1_idx` ON `chicken_factory`.`short_to_long` (`I_ssn` ASC);

CREATE INDEX `fk_short_to_long_Short_fridge1_idx` ON `chicken_factory`.`short_to_long` (`Sh_id` ASC);

CREATE INDEX `fk_short_to_long_Long_fridge1_idx` ON `chicken_factory`.`short_to_long` (`Long_id` ASC);


-- -----------------------------------------------------
-- Table `chicken_factory`.`long_to_car`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chicken_factory`.`long_to_car` ;

CREATE TABLE IF NOT EXISTS `chicken_factory`.`long_to_car` (
  `date_of_working` DATE NULL,
  `hours_of_working` DOUBLE NULL,
  `amount` DOUBLE NULL,
  `I_ssn` CHAR(5) NOT NULL,
  `Long_id` CHAR(3) NOT NULL,
  `Car_num` CHAR(3) NOT NULL,
  CONSTRAINT `fk_long_to_car_Intrnal_trans1`
    FOREIGN KEY (`I_ssn`)
    REFERENCES `chicken_factory`.`Intrnal_trans` (`I_ssn`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_long_to_car_Long_fridge1`
    FOREIGN KEY (`Long_id`)
    REFERENCES `chicken_factory`.`Long_fridge` (`Long_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_long_to_car_Car1`
    FOREIGN KEY (`Car_num`)
    REFERENCES `chicken_factory`.`Car` (`Car_num`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_long_to_car_Intrnal_trans1_idx` ON `chicken_factory`.`long_to_car` (`I_ssn` ASC);

CREATE INDEX `fk_long_to_car_Long_fridge1_idx` ON `chicken_factory`.`long_to_car` (`Long_id` ASC);

CREATE INDEX `fk_long_to_car_Car1_idx` ON `chicken_factory`.`long_to_car` (`Car_num` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
