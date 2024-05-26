-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema mung_beans_final
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mung_beans_final
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mung_beans_final` DEFAULT CHARACTER SET utf8mb3 ;
USE `mung_beans_final` ;

-- -----------------------------------------------------
-- Table `mung_beans_final`.`admin`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mung_beans_final`.`admin` (
  `idAdmin` INT NOT NULL,
  `Last_name` VARCHAR(45) NULL DEFAULT NULL,
  `First_name` VARCHAR(45) NULL DEFAULT NULL,
  `Password` VARCHAR(45) NULL DEFAULT NULL,
  `Contact_No.` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idAdmin`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mung_beans_final`.`customer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mung_beans_final`.`customer` (
  `id_Customer` INT NOT NULL,
  `Last_name` VARCHAR(255) NULL DEFAULT NULL,
  `First_name` VARCHAR(255) NULL DEFAULT NULL,
  `Contact_No.` VARCHAR(45) NULL DEFAULT NULL,
  `Email` VARCHAR(45) NULL DEFAULT NULL,
  `Location` VARCHAR(45) NULL DEFAULT NULL,
  `Password` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`id_Customer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mung_beans_final`.`supplier`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mung_beans_final`.`supplier` (
  `idSupplier` INT NOT NULL,
  `Last_name` VARCHAR(255) NULL DEFAULT NULL,
  `First_name` VARCHAR(255) NULL DEFAULT NULL,
  `Email` VARCHAR(255) NULL DEFAULT NULL,
  `Contact_No.` INT NULL DEFAULT NULL,
  `Location` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idSupplier`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mung_beans_final`.`product`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mung_beans_final`.`product` (
  `id` INT NOT NULL,
  `product_name` VARCHAR(255) NULL DEFAULT NULL,
  `supplier_id` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `supplierId_idx` (`supplier_id` ASC) VISIBLE,
  CONSTRAINT `supplierId`
    FOREIGN KEY (`supplier_id`)
    REFERENCES `mung_beans_final`.`supplier` (`idSupplier`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mung_beans_final`.`riders_delivery`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mung_beans_final`.`riders_delivery` (
  `id` INT NOT NULL,
  `rider_lastname` VARCHAR(45) NULL DEFAULT NULL,
  `rider_firstname` VARCHAR(255) NULL DEFAULT NULL,
  `rider_email` VARCHAR(255) NULL DEFAULT NULL,
  `rider_password` VARCHAR(255) NULL DEFAULT NULL,
  `rider_location` VARCHAR(255) NULL DEFAULT NULL,
  `rider_contact` INT NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mung_beans_final`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mung_beans_final`.`orders` (
  `Order_ID` INT NOT NULL,
  `Order_Date` VARCHAR(45) NULL DEFAULT NULL,
  `Delivery_Date` VARCHAR(45) NULL DEFAULT NULL,
  `product_id` INT NULL DEFAULT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `quantity` INT NULL DEFAULT NULL,
  `rider_id` INT NULL DEFAULT NULL,
  `order_type` ENUM('wholesaler', 'retailer') NULL DEFAULT NULL,
  PRIMARY KEY (`Order_ID`),
  INDEX `productId_idx` (`product_id` ASC) VISIBLE,
  INDEX `customerId_idx` (`customer_id` ASC) VISIBLE,
  INDEX `riderId_idx` (`rider_id` ASC) VISIBLE,
  CONSTRAINT `customerId`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mung_beans_final`.`customer` (`id_Customer`),
  CONSTRAINT `productId`
    FOREIGN KEY (`product_id`)
    REFERENCES `mung_beans_final`.`product` (`id`),
  CONSTRAINT `riderId`
    FOREIGN KEY (`rider_id`)
    REFERENCES `mung_beans_final`.`riders_delivery` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mung_beans_final`.`costumer_feedback`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mung_beans_final`.`costumer_feedback` (
  `orders_Order_ID` INT NOT NULL,
  `customer_id_Customer` INT NOT NULL,
  PRIMARY KEY (`orders_Order_ID`, `customer_id_Customer`),
  INDEX `fk_orders_has_customer_customer1_idx` (`customer_id_Customer` ASC) VISIBLE,
  INDEX `fk_orders_has_customer_orders1_idx` (`orders_Order_ID` ASC) VISIBLE,
  CONSTRAINT `fk_orders_has_customer_customer1`
    FOREIGN KEY (`customer_id_Customer`)
    REFERENCES `mung_beans_final`.`customer` (`id_Customer`),
  CONSTRAINT `fk_orders_has_customer_orders1`
    FOREIGN KEY (`orders_Order_ID`)
    REFERENCES `mung_beans_final`.`orders` (`Order_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mung_beans_final`.`customer_satisfaction`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mung_beans_final`.`customer_satisfaction` (
  `id` INT NOT NULL,
  `customer_id` INT NULL DEFAULT NULL,
  `rate` ENUM('1', '2', '3', '4', '5') NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `customeId_idx` (`customer_id` ASC) VISIBLE,
  CONSTRAINT `customeId`
    FOREIGN KEY (`customer_id`)
    REFERENCES `mung_beans_final`.`customer` (`id_Customer`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mung_beans_final`.`inventory`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mung_beans_final`.`inventory` (
  `id` INT NOT NULL,
  `Product_id` INT NULL DEFAULT NULL,
  `Quantity` DECIMAL(10,2) NULL DEFAULT NULL,
  `Last_Updated` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `product_id_idx` (`Product_id` ASC) VISIBLE,
  CONSTRAINT `product_id`
    FOREIGN KEY (`Product_id`)
    REFERENCES `mung_beans_final`.`product` (`id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
