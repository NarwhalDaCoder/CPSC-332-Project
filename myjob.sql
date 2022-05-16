-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema myjob
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `myjob` ;

-- -----------------------------------------------------
-- Schema myjob
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `myjob` DEFAULT CHARACTER SET utf8 ;
USE `myjob` ;

-- -----------------------------------------------------
-- Table `myjob`.`EducationLevels`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`EducationLevels` (
  `EducationID` INT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`EducationID`),
  UNIQUE INDEX `EducationID_UNIQUE` (`EducationID` ASC),
  UNIQUE INDEX `Title_UNIQUE` (`Title` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`UserAccount`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`UserAccount` (
  `UserID` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Phone` VARCHAR(45) NOT NULL,
  `Password` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`UserID`),
  UNIQUE INDEX `UserID_UNIQUE` (`UserID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`Employer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`Employer` (
  `EmployerID` INT NOT NULL,
  `EmployerName` VARCHAR(45) NOT NULL,
  `EmployerPhone` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`EmployerID`),
  UNIQUE INDEX `EmployerID_UNIQUE` (`EmployerID` ASC),
  CONSTRAINT `fk_Employer_UserAccount1`
    FOREIGN KEY (`EmployerID`)
    REFERENCES `myjob`.`UserAccount` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`BenefitsOffered`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`BenefitsOffered` (
  `BenefitID` INT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`BenefitID`),
  UNIQUE INDEX `BenefitID_UNIQUE` (`BenefitID` ASC),
  UNIQUE INDEX `Title_UNIQUE` (`Title` ASC))
ENGINE = InnoDB
INSERT_METHOD = FIRST;


-- -----------------------------------------------------
-- Table `myjob`.`JobTypes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`JobTypes` (
  `JobTypeID` INT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`JobTypeID`),
  UNIQUE INDEX `JobTypeID_UNIQUE` (`JobTypeID` ASC),
  UNIQUE INDEX `Title_UNIQUE` (`Title` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`ExperienceRequired`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`ExperienceRequired` (
  `ExpReqID` INT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ExpReqID`),
  UNIQUE INDEX `ExpReqID_UNIQUE` (`ExpReqID` ASC),
  UNIQUE INDEX `Title_UNIQUE` (`Title` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`SalaryRange`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`SalaryRange` (
  `SalaryID` INT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`SalaryID`),
  UNIQUE INDEX `Title_UNIQUE` (`Title` ASC),
  UNIQUE INDEX `SalaryID_UNIQUE` (`SalaryID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`JobPosts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`JobPosts` (
  `JobPostID` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(45) NOT NULL,
  `Description` TINYTEXT NOT NULL,
  `Responsibilities` TINYTEXT NOT NULL,
  `Qualifications` TINYTEXT NOT NULL,
  `DatePosted` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `Deadline` DATE NOT NULL,
  `ContactDetails` TINYTEXT NOT NULL,
  `EducationID` INT NOT NULL,
  `JobTypeID` INT NOT NULL,
  `ExpReqID` INT NOT NULL,
  `SalaryID` INT NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`JobPostID`),
  INDEX `fk_JobPosts_EducationLevels1_idx` (`EducationID` ASC),
  INDEX `fk_JobPosts_JobTypes1_idx` (`JobTypeID` ASC),
  INDEX `fk_JobPosts_ExperienceRequired1_idx` (`ExpReqID` ASC),
  INDEX `fk_JobPosts_SalaryRange1_idx` (`SalaryID` ASC),
  CONSTRAINT `fk_JobPosts_EducationLevels1`
    FOREIGN KEY (`EducationID`)
    REFERENCES `myjob`.`EducationLevels` (`EducationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_JobPosts_JobTypes1`
    FOREIGN KEY (`JobTypeID`)
    REFERENCES `myjob`.`JobTypes` (`JobTypeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_JobPosts_ExperienceRequired1`
    FOREIGN KEY (`ExpReqID`)
    REFERENCES `myjob`.`ExperienceRequired` (`ExpReqID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_JobPosts_SalaryRange1`
    FOREIGN KEY (`SalaryID`)
    REFERENCES `myjob`.`SalaryRange` (`SalaryID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`JobBenefits`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`JobBenefits` (
  `BenefitID` INT NOT NULL,
  `JobPostID` INT NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `fk_JobBenefits_BenefitsOffered1_idx` (`BenefitID` ASC),
  INDEX `fk_JobBenefits_JobPosts1_idx` (`JobPostID` ASC),
  CONSTRAINT `fk_JobBenefits_BenefitsOffered1`
    FOREIGN KEY (`BenefitID`)
    REFERENCES `myjob`.`BenefitsOffered` (`BenefitID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_JobBenefits_JobPosts1`
    FOREIGN KEY (`JobPostID`)
    REFERENCES `myjob`.`JobPosts` (`JobPostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`City`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`City` (
  `CityID` INT NOT NULL AUTO_INCREMENT,
  `CityName` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`CityID`),
  UNIQUE INDEX `CityID_UNIQUE` (`CityID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`ZipCodes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`ZipCodes` (
  `ZipCode` INT NOT NULL,
  `CityID` INT NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ZipCode`),
  INDEX `fk_ZipCodes_ZipCodes_copy11_idx` (`CityID` ASC),
  UNIQUE INDEX `ZipCode_UNIQUE` (`ZipCode` ASC),
  CONSTRAINT `fk_ZipCodes_ZipCodes_copy11`
    FOREIGN KEY (`CityID`)
    REFERENCES `myjob`.`City` (`CityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`Address`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`Address` (
  `AddressID` INT NOT NULL AUTO_INCREMENT,
  `StreetAddress` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`AddressID`),
  UNIQUE INDEX `AddressID_UNIQUE` (`AddressID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`Employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`Employee` (
  `EmployeeID` INT NOT NULL,
  `EducationID` INT NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`EmployeeID`),
  INDEX `fk_Employee_EducationLevels1_idx` (`EducationID` ASC),
  CONSTRAINT `fk_Employee_EducationLevels1`
    FOREIGN KEY (`EducationID`)
    REFERENCES `myjob`.`EducationLevels` (`EducationID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Employee_UserAccount1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `myjob`.`UserAccount` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`ApplicationStatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`ApplicationStatus` (
  `AppStatusID` INT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`AppStatusID`),
  UNIQUE INDEX `AppStatusID_UNIQUE` (`AppStatusID` ASC),
  UNIQUE INDEX `Title_UNIQUE` (`Title` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`AppliedPosts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`AppliedPosts` (
  `JobPostID` INT NOT NULL,
  `EmployeeID` INT NOT NULL,
  `AppStatusID` INT NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `fk_AppliedPosts_JobPosts1_idx` (`JobPostID` ASC),
  INDEX `fk_AppliedPosts_Employee1_idx` (`EmployeeID` ASC),
  INDEX `fk_AppliedPosts_ApplicationStatus1_idx` (`AppStatusID` ASC),
  PRIMARY KEY (`JobPostID`, `EmployeeID`),
  CONSTRAINT `fk_AppliedPosts_JobPosts1`
    FOREIGN KEY (`JobPostID`)
    REFERENCES `myjob`.`JobPosts` (`JobPostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppliedPosts_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `myjob`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_AppliedPosts_ApplicationStatus1`
    FOREIGN KEY (`AppStatusID`)
    REFERENCES `myjob`.`ApplicationStatus` (`AppStatusID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`Roles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`Roles` (
  `RoleID` INT NOT NULL,
  `Title` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`RoleID`),
  UNIQUE INDEX `RoleID_UNIQUE` (`RoleID` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`EmployerPosts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`EmployerPosts` (
  `EmployerID` INT NOT NULL,
  `JobPostID` INT NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `fk_EmployerPosts_Employer1_idx` (`EmployerID` ASC),
  CONSTRAINT `fk_EmployerPosts_Employer1`
    FOREIGN KEY (`EmployerID`)
    REFERENCES `myjob`.`Employer` (`EmployerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EmployerPosts_JobPosts1`
    FOREIGN KEY (`JobPostID`)
    REFERENCES `myjob`.`JobPosts` (`JobPostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`SavedPosts`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`SavedPosts` (
  `EmployeeID` INT NOT NULL,
  `JobPostID` INT NOT NULL,
  `TimeStamp` DATETIME NOT NULL,
  INDEX `fk_SavedPosts_Employee1_idx` (`EmployeeID` ASC),
  INDEX `fk_SavedPosts_JobPosts1_idx` (`JobPostID` ASC),
  CONSTRAINT `fk_SavedPosts_Employee1`
    FOREIGN KEY (`EmployeeID`)
    REFERENCES `myjob`.`Employee` (`EmployeeID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SavedPosts_JobPosts1`
    FOREIGN KEY (`JobPostID`)
    REFERENCES `myjob`.`JobPosts` (`JobPostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`UserEmail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`UserEmail` (
  `UserID` INT NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `fk_Email_UserAccount1_idx` (`UserID` ASC),
  UNIQUE INDEX `UserAccount_UserID_UNIQUE` (`UserID` ASC),
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC),
  PRIMARY KEY (`UserID`),
  CONSTRAINT `fk_Email_UserAccount1`
    FOREIGN KEY (`UserID`)
    REFERENCES `myjob`.`UserAccount` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`State`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`State` (
  `StateID` INT NOT NULL,
  `StateName` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`StateID`),
  UNIQUE INDEX `StateID_UNIQUE` (`StateID` ASC),
  UNIQUE INDEX `StateName_UNIQUE` (`StateName` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`EmployerEmail`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`EmployerEmail` (
  `EmployerID` INT NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `fk_Employer_copy1_Employer1_idx` (`EmployerID` ASC),
  PRIMARY KEY (`EmployerID`),
  UNIQUE INDEX `EmployerEmail_UNIQUE` (`Email` ASC),
  UNIQUE INDEX `EmployerID_UNIQUE` (`EmployerID` ASC),
  CONSTRAINT `fk_Employer_copy1_Employer1`
    FOREIGN KEY (`EmployerID`)
    REFERENCES `myjob`.`Employer` (`EmployerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`AddressToJobPost`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`AddressToJobPost` (
  `AddressID` INT NOT NULL,
  `JobPostID` INT NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `fk_table1_Address1_idx` (`AddressID` ASC),
  INDEX `fk_table1_JobPosts1_idx` (`JobPostID` ASC),
  PRIMARY KEY (`JobPostID`),
  CONSTRAINT `fk_table1_Address1`
    FOREIGN KEY (`AddressID`)
    REFERENCES `myjob`.`Address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_table1_JobPosts1`
    FOREIGN KEY (`JobPostID`)
    REFERENCES `myjob`.`JobPosts` (`JobPostID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`EmployerToAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`EmployerToAddress` (
  `EmployerID` INT NOT NULL,
  `AddressID` INT NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `fk_EmployerPosts_Employer1_idx` (`EmployerID` ASC),
  INDEX `fk_EmployerPosts_copy1_Address1_idx` (`AddressID` ASC),
  CONSTRAINT `fk_EmployerPosts_Employer10`
    FOREIGN KEY (`EmployerID`)
    REFERENCES `myjob`.`Employer` (`EmployerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_EmployerPosts_copy1_Address1`
    FOREIGN KEY (`AddressID`)
    REFERENCES `myjob`.`Address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`RoleToEmployerUser`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`RoleToEmployerUser` (
  `EmployerID` INT NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `RoleID` INT NOT NULL,
  INDEX `fk_Roles_has_UserAccount_Roles1_idx` (`RoleID` ASC),
  INDEX `fk_RoleToEmployerUser_Employer1_idx` (`EmployerID` ASC),
  PRIMARY KEY (`EmployerID`),
  CONSTRAINT `fk_Roles_has_UserAccount_Roles1`
    FOREIGN KEY (`RoleID`)
    REFERENCES `myjob`.`Roles` (`RoleID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RoleToEmployerUser_Employer1`
    FOREIGN KEY (`EmployerID`)
    REFERENCES `myjob`.`Employer` (`EmployerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`ZipCodeToAddress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`ZipCodeToAddress` (
  `ZipCode` INT NOT NULL,
  `AddressID` INT NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`AddressID`),
  INDEX `fk_ZipCodes_has_Address_Address1_idx` (`AddressID` ASC),
  INDEX `fk_ZipCodes_has_Address_ZipCodes1_idx` (`ZipCode` ASC),
  CONSTRAINT `fk_ZipCodes_has_Address_ZipCodes1`
    FOREIGN KEY (`ZipCode`)
    REFERENCES `myjob`.`ZipCodes` (`ZipCode`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ZipCodes_has_Address_Address1`
    FOREIGN KEY (`AddressID`)
    REFERENCES `myjob`.`Address` (`AddressID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `myjob`.`CityToState`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`CityToState` (
  `CityID` INT NOT NULL,
  `StateID` INT NOT NULL,
  `TimeStamp` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  INDEX `fk_City_has_State_State1_idx` (`StateID` ASC),
  INDEX `fk_City_has_State_City1_idx` (`CityID` ASC),
  PRIMARY KEY (`CityID`),
  CONSTRAINT `fk_City_has_State_City1`
    FOREIGN KEY (`CityID`)
    REFERENCES `myjob`.`City` (`CityID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_City_has_State_State1`
    FOREIGN KEY (`StateID`)
    REFERENCES `myjob`.`State` (`StateID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `myjob` ;

-- -----------------------------------------------------
-- Placeholder table for view `myjob`.`Employ3`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`Employ3` (`EmployerName` INT, `Email` INT);

-- -----------------------------------------------------
-- Placeholder table for view `myjob`.`Employee1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`Employee1` (`FirstName` INT, `LastName` INT, `Email` INT);

-- -----------------------------------------------------
-- Placeholder table for view `myjob`.`BothRoles`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myjob`.`BothRoles` (`UserID` INT, `FirstName` INT, `LastName` INT);

-- -----------------------------------------------------
-- View `myjob`.`Employ3`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `myjob`.`Employ3`;
USE `myjob`;
CREATE  OR REPLACE VIEW `Employ3` AS
select 
     EmployerName,
     (Select Email From EmployerEmail Where Employer.EmployerID = EmployerEmail.EmployerID) as Email
 from
     Employer
 where 
     EmployerID in (
        select 
            EmployerID               
        from 
            employerposts
        group by 
            EmployerID 
        having 
            count(1) >3
     );

-- -----------------------------------------------------
-- View `myjob`.`Employee1`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `myjob`.`Employee1`;
USE `myjob`;
CREATE  OR REPLACE VIEW `Employee1` AS
select 
     FirstName,LastName,
     (Select Email From userEmail Where Employee.EmployeeID = userEmail.UserID) as Email
 from
     Employee join useraccount on EmployeeID = UserID
 where 
     EmployeeID in (
        select 
            EmployeeID               
        from 
            appliedposts
        group by 
            EmployeeID 
        having 
            count(1) >1
     );

-- -----------------------------------------------------
-- View `myjob`.`BothRoles`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `myjob`.`BothRoles`;
USE `myjob`;
CREATE  OR REPLACE VIEW `BothRoles` AS
Select UserID,FirstName,LastName 
FROM UserAccount Join Employee ON UserID = EmployeeID 
WHERE EXISTS (SELECT * FROM Employer WHERE EmployeeID = EmployerID);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `myjob`.`EducationLevels`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`EducationLevels` (`EducationID`, `Title`, `TimeStamp`) VALUES (1, 'No Education Required', DEFAULT);
INSERT INTO `myjob`.`EducationLevels` (`EducationID`, `Title`, `TimeStamp`) VALUES (2, 'High School Degree', DEFAULT);
INSERT INTO `myjob`.`EducationLevels` (`EducationID`, `Title`, `TimeStamp`) VALUES (3, 'Associate’s Degree', DEFAULT);
INSERT INTO `myjob`.`EducationLevels` (`EducationID`, `Title`, `TimeStamp`) VALUES (4, 'Bachelor’s Degree', DEFAULT);
INSERT INTO `myjob`.`EducationLevels` (`EducationID`, `Title`, `TimeStamp`) VALUES (5, 'Master’s Degree', DEFAULT);
INSERT INTO `myjob`.`EducationLevels` (`EducationID`, `Title`, `TimeStamp`) VALUES (6, 'Doctoral Degree', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`UserAccount`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (1, 'Helen', 'Merry', '1053881625', '939z488a9C3Lf6', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (2, 'Wyatt', 'Lack', '4286165506', 'KlDxj55WJd3', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (3, 'Johnette', 'Huckfield', '1904905096', '2U50x3g6b993GFs7', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (4, 'Damon', 'Kellington', '1191700473', 'j642F2Z73d28tKa2', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (5, 'Karel', 'Bessent', '7357635893', '586u7UARSR39DXh1', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (6, 'Hedvige', 'Balmforth', '4833212225', 'jOrH64iiKq9', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (7, 'Chelsey', 'Asals', '7776281579', '7p9b34eNMr7', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (8, 'Roi', 'Kirby', '5604738850', '33u9yD809b63otKz7', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (9, 'Mervin', 'Abreheart', '4211366509', '4L1ZGT516URQEpLZm6', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (10, 'Ewart', 'Scottrell', '2982093767', '24H06f7g01A1T0HMi7', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (11, 'Anselma', 'Franzonetti', '3855077476', 'dK1154f4xs379X6Yy6', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (12, 'Kendra', 'Tapscott', '2111092976', 'Ixu5fwO3e7Cn3', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (13, 'Latrina', 'Copnall', '3464703514', '49Zh3WxQK73Vd8', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (14, 'Ellette', 'Hobbert', '3944221533', 'Z8z2E0fjjOq97Bi5', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (15, 'Sapphira', 'Westoll', '2535406116', 'sIjie7jZo84Vf2', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (16, 'Nicol', 'Corcut', '3658676642', '509qHB3V0tX2EIw1', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (17, 'Pat', 'Cloke', '9349264732', 'H3ljPxBsqSTDm9', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (18, 'Horatius', 'Giraudo', '4441351092', 'eG5713dyOn0', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (19, 'Valentin', 'Molloy', '4854373316', '660S04kTv96Kc3', DEFAULT);
INSERT INTO `myjob`.`UserAccount` (`UserID`, `FirstName`, `LastName`, `Phone`, `Password`, `TimeStamp`) VALUES (20, 'Ainslie', 'Gohn', '9764128285', 'SYKt73vyJn1', '');

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`Employer`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`Employer` (`EmployerID`, `EmployerName`, `EmployerPhone`, `TimeStamp`) VALUES (16, 'Noogle', '7896541231', DEFAULT);
INSERT INTO `myjob`.`Employer` (`EmployerID`, `EmployerName`, `EmployerPhone`, `TimeStamp`) VALUES (17, 'Zahoo!', '1234567899', DEFAULT);
INSERT INTO `myjob`.`Employer` (`EmployerID`, `EmployerName`, `EmployerPhone`, `TimeStamp`) VALUES (18, 'Pear', '6548793124', DEFAULT);
INSERT INTO `myjob`.`Employer` (`EmployerID`, `EmployerName`, `EmployerPhone`, `TimeStamp`) VALUES (19, 'Edison', '6453791283', DEFAULT);
INSERT INTO `myjob`.`Employer` (`EmployerID`, `EmployerName`, `EmployerPhone`, `TimeStamp`) VALUES (20, 'Chirper', '6342157984', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`BenefitsOffered`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`BenefitsOffered` (`BenefitID`, `Title`, `TimeStamp`) VALUES (1, 'Health Insurance', DEFAULT);
INSERT INTO `myjob`.`BenefitsOffered` (`BenefitID`, `Title`, `TimeStamp`) VALUES (2, 'Vision Insurance', DEFAULT);
INSERT INTO `myjob`.`BenefitsOffered` (`BenefitID`, `Title`, `TimeStamp`) VALUES (3, 'Dental Insurance', DEFAULT);
INSERT INTO `myjob`.`BenefitsOffered` (`BenefitID`, `Title`, `TimeStamp`) VALUES (4, 'Life Insurance', DEFAULT);
INSERT INTO `myjob`.`BenefitsOffered` (`BenefitID`, `Title`, `TimeStamp`) VALUES (5, 'Pension', DEFAULT);
INSERT INTO `myjob`.`BenefitsOffered` (`BenefitID`, `Title`, `TimeStamp`) VALUES (6, '401(k)', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`JobTypes`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`JobTypes` (`JobTypeID`, `Title`, `TimeStamp`) VALUES (1, 'Full-Time', DEFAULT);
INSERT INTO `myjob`.`JobTypes` (`JobTypeID`, `Title`, `TimeStamp`) VALUES (2, 'Part-Time', DEFAULT);
INSERT INTO `myjob`.`JobTypes` (`JobTypeID`, `Title`, `TimeStamp`) VALUES (3, 'Contract', DEFAULT);
INSERT INTO `myjob`.`JobTypes` (`JobTypeID`, `Title`, `TimeStamp`) VALUES (4, 'Temporary', DEFAULT);
INSERT INTO `myjob`.`JobTypes` (`JobTypeID`, `Title`, `TimeStamp`) VALUES (5, 'Internship', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`ExperienceRequired`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`ExperienceRequired` (`ExpReqID`, `Title`, `TimeStamp`) VALUES (1, 'entry level', DEFAULT);
INSERT INTO `myjob`.`ExperienceRequired` (`ExpReqID`, `Title`, `TimeStamp`) VALUES (2, 'mid-level', DEFAULT);
INSERT INTO `myjob`.`ExperienceRequired` (`ExpReqID`, `Title`, `TimeStamp`) VALUES (3, 'senor level', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`SalaryRange`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`SalaryRange` (`SalaryID`, `Title`, `TimeStamp`) VALUES (1, '$35,000+', DEFAULT);
INSERT INTO `myjob`.`SalaryRange` (`SalaryID`, `Title`, `TimeStamp`) VALUES (2, '$40,000+', DEFAULT);
INSERT INTO `myjob`.`SalaryRange` (`SalaryID`, `Title`, `TimeStamp`) VALUES (3, '$50,000+', DEFAULT);
INSERT INTO `myjob`.`SalaryRange` (`SalaryID`, `Title`, `TimeStamp`) VALUES (4, '$70,000+', DEFAULT);
INSERT INTO `myjob`.`SalaryRange` (`SalaryID`, `Title`, `TimeStamp`) VALUES (5, '$100,000+', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`JobPosts`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`JobPosts` (`JobPostID`, `Title`, `Description`, `Responsibilities`, `Qualifications`, `DatePosted`, `Deadline`, `ContactDetails`, `EducationID`, `JobTypeID`, `ExpReqID`, `SalaryID`, `TimeStamp`) VALUES (1, 'Work At Noogle', 'You get to work at noogle and sleep in a noog pod', 'You need to make sure the mantis men don\'t cause an revloution', 'Be Good at handling mantis men', '2022-05-16 23:59:59', '2022-05-22', 'Contact us by submitting a form at Noogle.com/carrers', 1, 5, 1, 5, DEFAULT);
INSERT INTO `myjob`.`JobPosts` (`JobPostID`, `Title`, `Description`, `Responsibilities`, `Qualifications`, `DatePosted`, `Deadline`, `ContactDetails`, `EducationID`, `JobTypeID`, `ExpReqID`, `SalaryID`, `TimeStamp`) VALUES (2, 'Experience Zahoo', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla eu blandit tortor.', 'Nullam accumsan quis nisl et pharetra.', 'Curabitur nulla odio, cursus at vehicula vel, varius in urna. Quisque ligula velit, tincidunt nec nisi nec, fringilla porttitor nulla.', '2022-05-16 23:59:59', '2022-05-22', 'email us at zahoo@yahoo.com for setting up more interview details', 2, 4, 2, 4, DEFAULT);
INSERT INTO `myjob`.`JobPosts` (`JobPostID`, `Title`, `Description`, `Responsibilities`, `Qualifications`, `DatePosted`, `Deadline`, `ContactDetails`, `EducationID`, `JobTypeID`, `ExpReqID`, `SalaryID`, `TimeStamp`) VALUES (3, 'Looking For Accountant', 'Do math get payed', 'You need to bring your own calculator we cant afford them', 'Be able to add 1 + 1 indefintely', '2022-05-16 23:59:59', '2022-05-22', 'You\'ll know how to find us.', 3, 3, 3, 3, DEFAULT);
INSERT INTO `myjob`.`JobPosts` (`JobPostID`, `Title`, `Description`, `Responsibilities`, `Qualifications`, `DatePosted`, `Deadline`, `ContactDetails`, `EducationID`, `JobTypeID`, `ExpReqID`, `SalaryID`, `TimeStamp`) VALUES (4, 'Influencer Needed', 'Be at the front of instagram fame', 'You need to post a hot #Relatable post every second', 'Understand the Schrodigner Equation.Necessary for predcting the wavefunction of the universe to determeine the #hotest post', '2022-05-16 23:59:59', '2022-05-22', 'Send us the freshest snap of your resume to @edison.snap', 4, 2, 2, 2, DEFAULT);
INSERT INTO `myjob`.`JobPosts` (`JobPostID`, `Title`, `Description`, `Responsibilities`, `Qualifications`, `DatePosted`, `Deadline`, `ContactDetails`, `EducationID`, `JobTypeID`, `ExpReqID`, `SalaryID`, `TimeStamp`) VALUES (5, 'Employee \"Needed\"', 'I ran out of ideas for description', 'You are responsible for your own health', 'Able to lift 50 pounds', '2022-05-16 23:59:59', '2022-05-01', 'Leave a note with an secure phone number written at 1341 Sunnybrook ln by the train station', 5, 1, 1, 1, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`JobBenefits`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`JobBenefits` (`BenefitID`, `JobPostID`, `TimeStamp`) VALUES (1, 1, DEFAULT);
INSERT INTO `myjob`.`JobBenefits` (`BenefitID`, `JobPostID`, `TimeStamp`) VALUES (2, 2, DEFAULT);
INSERT INTO `myjob`.`JobBenefits` (`BenefitID`, `JobPostID`, `TimeStamp`) VALUES (3, 3, DEFAULT);
INSERT INTO `myjob`.`JobBenefits` (`BenefitID`, `JobPostID`, `TimeStamp`) VALUES (4, 4, DEFAULT);
INSERT INTO `myjob`.`JobBenefits` (`BenefitID`, `JobPostID`, `TimeStamp`) VALUES (5, 5, DEFAULT);
INSERT INTO `myjob`.`JobBenefits` (`BenefitID`, `JobPostID`, `TimeStamp`) VALUES (6, 1, DEFAULT);
INSERT INTO `myjob`.`JobBenefits` (`BenefitID`, `JobPostID`, `TimeStamp`) VALUES (1, 2, DEFAULT);
INSERT INTO `myjob`.`JobBenefits` (`BenefitID`, `JobPostID`, `TimeStamp`) VALUES (2, 3, DEFAULT);
INSERT INTO `myjob`.`JobBenefits` (`BenefitID`, `JobPostID`, `TimeStamp`) VALUES (3, 4, DEFAULT);
INSERT INTO `myjob`.`JobBenefits` (`BenefitID`, `JobPostID`, `TimeStamp`) VALUES (4, 5, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`City`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`City` (`CityID`, `CityName`, `TimeStamp`) VALUES (1, 'Saint Paul', DEFAULT);
INSERT INTO `myjob`.`City` (`CityID`, `CityName`, `TimeStamp`) VALUES (2, 'Young America', DEFAULT);
INSERT INTO `myjob`.`City` (`CityID`, `CityName`, `TimeStamp`) VALUES (3, 'Pittsburgh', DEFAULT);
INSERT INTO `myjob`.`City` (`CityID`, `CityName`, `TimeStamp`) VALUES (4, 'San Jose', DEFAULT);
INSERT INTO `myjob`.`City` (`CityID`, `CityName`, `TimeStamp`) VALUES (5, 'Syracuse', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`ZipCodes`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`ZipCodes` (`ZipCode`, `CityID`, `TimeStamp`) VALUES (55108, 1, DEFAULT);
INSERT INTO `myjob`.`ZipCodes` (`ZipCode`, `CityID`, `TimeStamp`) VALUES (55573, 2, DEFAULT);
INSERT INTO `myjob`.`ZipCodes` (`ZipCode`, `CityID`, `TimeStamp`) VALUES (15261, 3, DEFAULT);
INSERT INTO `myjob`.`ZipCodes` (`ZipCode`, `CityID`, `TimeStamp`) VALUES (95160, 4, DEFAULT);
INSERT INTO `myjob`.`ZipCodes` (`ZipCode`, `CityID`, `TimeStamp`) VALUES (13210, 5, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`Address`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`Address` (`AddressID`, `StreetAddress`, `TimeStamp`) VALUES (1, '587 Florence Lane', DEFAULT);
INSERT INTO `myjob`.`Address` (`AddressID`, `StreetAddress`, `TimeStamp`) VALUES (2, '64 Raven Terrace', DEFAULT);
INSERT INTO `myjob`.`Address` (`AddressID`, `StreetAddress`, `TimeStamp`) VALUES (3, '3 Cody Lane', DEFAULT);
INSERT INTO `myjob`.`Address` (`AddressID`, `StreetAddress`, `TimeStamp`) VALUES (4, '8 Merchant Center', DEFAULT);
INSERT INTO `myjob`.`Address` (`AddressID`, `StreetAddress`, `TimeStamp`) VALUES (5, '0 Hansons Place', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`Employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`Employee` (`EmployeeID`, `EducationID`, `TimeStamp`) VALUES (1, 1, DEFAULT);
INSERT INTO `myjob`.`Employee` (`EmployeeID`, `EducationID`, `TimeStamp`) VALUES (2, 2, DEFAULT);
INSERT INTO `myjob`.`Employee` (`EmployeeID`, `EducationID`, `TimeStamp`) VALUES (3, 3, DEFAULT);
INSERT INTO `myjob`.`Employee` (`EmployeeID`, `EducationID`, `TimeStamp`) VALUES (4, 4, DEFAULT);
INSERT INTO `myjob`.`Employee` (`EmployeeID`, `EducationID`, `TimeStamp`) VALUES (5, 5, DEFAULT);
INSERT INTO `myjob`.`Employee` (`EmployeeID`, `EducationID`, `TimeStamp`) VALUES (6, 6, DEFAULT);
INSERT INTO `myjob`.`Employee` (`EmployeeID`, `EducationID`, `TimeStamp`) VALUES (7, 5, DEFAULT);
INSERT INTO `myjob`.`Employee` (`EmployeeID`, `EducationID`, `TimeStamp`) VALUES (8, 4, DEFAULT);
INSERT INTO `myjob`.`Employee` (`EmployeeID`, `EducationID`, `TimeStamp`) VALUES (9, 3, DEFAULT);
INSERT INTO `myjob`.`Employee` (`EmployeeID`, `EducationID`, `TimeStamp`) VALUES (10, 2, DEFAULT);
INSERT INTO `myjob`.`Employee` (`EmployeeID`, `EducationID`, `TimeStamp`) VALUES (11, 1, DEFAULT);
INSERT INTO `myjob`.`Employee` (`EmployeeID`, `EducationID`, `TimeStamp`) VALUES (12, 2, DEFAULT);
INSERT INTO `myjob`.`Employee` (`EmployeeID`, `EducationID`, `TimeStamp`) VALUES (13, 3, DEFAULT);
INSERT INTO `myjob`.`Employee` (`EmployeeID`, `EducationID`, `TimeStamp`) VALUES (14, 4, DEFAULT);
INSERT INTO `myjob`.`Employee` (`EmployeeID`, `EducationID`, `TimeStamp`) VALUES (15, 5, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`ApplicationStatus`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`ApplicationStatus` (`AppStatusID`, `Title`, `TimeStamp`) VALUES (1, 'Applied', DEFAULT);
INSERT INTO `myjob`.`ApplicationStatus` (`AppStatusID`, `Title`, `TimeStamp`) VALUES (2, 'Rejected', DEFAULT);
INSERT INTO `myjob`.`ApplicationStatus` (`AppStatusID`, `Title`, `TimeStamp`) VALUES (3, 'Interviewed', DEFAULT);
INSERT INTO `myjob`.`ApplicationStatus` (`AppStatusID`, `Title`, `TimeStamp`) VALUES (4, 'Accepted', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`AppliedPosts`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`AppliedPosts` (`JobPostID`, `EmployeeID`, `AppStatusID`, `TimeStamp`) VALUES (1, 1, 1, DEFAULT);
INSERT INTO `myjob`.`AppliedPosts` (`JobPostID`, `EmployeeID`, `AppStatusID`, `TimeStamp`) VALUES (2, 2, 2, DEFAULT);
INSERT INTO `myjob`.`AppliedPosts` (`JobPostID`, `EmployeeID`, `AppStatusID`, `TimeStamp`) VALUES (3, 3, 3, DEFAULT);
INSERT INTO `myjob`.`AppliedPosts` (`JobPostID`, `EmployeeID`, `AppStatusID`, `TimeStamp`) VALUES (4, 4, 4, DEFAULT);
INSERT INTO `myjob`.`AppliedPosts` (`JobPostID`, `EmployeeID`, `AppStatusID`, `TimeStamp`) VALUES (5, 5, 1, DEFAULT);
INSERT INTO `myjob`.`AppliedPosts` (`JobPostID`, `EmployeeID`, `AppStatusID`, `TimeStamp`) VALUES (1, 6, 2, DEFAULT);
INSERT INTO `myjob`.`AppliedPosts` (`JobPostID`, `EmployeeID`, `AppStatusID`, `TimeStamp`) VALUES (2, 7, 3, DEFAULT);
INSERT INTO `myjob`.`AppliedPosts` (`JobPostID`, `EmployeeID`, `AppStatusID`, `TimeStamp`) VALUES (3, 8, 4, DEFAULT);
INSERT INTO `myjob`.`AppliedPosts` (`JobPostID`, `EmployeeID`, `AppStatusID`, `TimeStamp`) VALUES (4, 9, 1, DEFAULT);
INSERT INTO `myjob`.`AppliedPosts` (`JobPostID`, `EmployeeID`, `AppStatusID`, `TimeStamp`) VALUES (5, 10, 2, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`Roles`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`Roles` (`RoleID`, `Title`, `TimeStamp`) VALUES (1, 'Owner', DEFAULT);
INSERT INTO `myjob`.`Roles` (`RoleID`, `Title`, `TimeStamp`) VALUES (2, 'CEO', DEFAULT);
INSERT INTO `myjob`.`Roles` (`RoleID`, `Title`, `TimeStamp`) VALUES (3, 'Assistant or Manager', DEFAULT);
INSERT INTO `myjob`.`Roles` (`RoleID`, `Title`, `TimeStamp`) VALUES (4, 'Human Resources Generalists', DEFAULT);
INSERT INTO `myjob`.`Roles` (`RoleID`, `Title`, `TimeStamp`) VALUES (5, 'Hiring Manager', DEFAULT);
INSERT INTO `myjob`.`Roles` (`RoleID`, `Title`, `TimeStamp`) VALUES (6, 'Recruiter', DEFAULT);
INSERT INTO `myjob`.`Roles` (`RoleID`, `Title`, `TimeStamp`) VALUES (7, 'Other', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`EmployerPosts`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`EmployerPosts` (`EmployerID`, `JobPostID`, `TimeStamp`) VALUES (16, 1, DEFAULT);
INSERT INTO `myjob`.`EmployerPosts` (`EmployerID`, `JobPostID`, `TimeStamp`) VALUES (17, 2, DEFAULT);
INSERT INTO `myjob`.`EmployerPosts` (`EmployerID`, `JobPostID`, `TimeStamp`) VALUES (18, 3, DEFAULT);
INSERT INTO `myjob`.`EmployerPosts` (`EmployerID`, `JobPostID`, `TimeStamp`) VALUES (19, 4, DEFAULT);
INSERT INTO `myjob`.`EmployerPosts` (`EmployerID`, `JobPostID`, `TimeStamp`) VALUES (20, 5, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`UserEmail`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (1, 'hmerry0@theatlantic.com', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (2, 'wlack1@wp.com', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (3, 'jhuckfield2@senate.gov', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (4, 'dkellington3@printfriendly.com', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (5, 'kbessent4@state.tx.us', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (6, 'hbalmforth5@ask.com', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (7, 'casals6@un.org', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (8, 'rkirby7@wikia.com', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (9, 'mabreheart8@forbes.com', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (10, 'escottrell9@home.pl', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (11, 'afranzonettia@house.gov', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (12, 'ktapscottb@dailymail.co.uk', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (13, 'lcopnallc@bloglines.com', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (14, 'ehobbertd@mashable.com', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (15, 'swestolle@miibeian.gov.cn', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (16, 'ncorcutf@sakura.ne.jp', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (17, 'pclokeg@fastcompany.com', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (18, 'hgiraudoh@who.int', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (19, 'vmolloyi@google.de', DEFAULT);
INSERT INTO `myjob`.`UserEmail` (`UserID`, `Email`, `TimeStamp`) VALUES (20, 'agohnj@shutterfly.com', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`State`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (1, 'Alabama', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (2, 'Alaska', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (3, 'Arizona', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (4, 'Arkansas', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (5, 'California', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (6, 'Colorado', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (7, 'Connecticut', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (8, 'Delaware', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (9, 'Florida', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (10, 'Georgia', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (11, 'Hawaii', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (12, 'Idaho', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (13, 'Illinois', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (14, 'Indiana', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (15, 'Iowa', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (16, 'Kansas', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (17, 'Kentucky', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (18, 'Louisiana', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (19, 'Maine', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (20, 'Maryland', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (21, 'Massachusetts', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (22, 'Michigan', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (23, 'Minnesota', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (24, 'Mississippi', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (25, 'Missouri', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (26, 'Montana', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (27, 'Nebraska', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (28, 'Nevada', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (29, 'New Hampshire', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (30, 'New Jersey', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (31, 'New Mexico', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (32, 'New York', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (33, 'North Carolina', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (34, 'North Dakota', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (35, 'Ohio', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (36, 'Oklahoma', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (37, 'Oregon', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (38, 'Pennsylvania', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (39, 'Rhode Island', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (40, 'South Carolina', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (41, 'South Dakota', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (42, 'Tennessee', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (43, 'Texas', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (44, 'Utah', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (45, 'Vermont', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (46, 'Virginia', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (47, 'Washington', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (48, 'West Virginia', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (49, 'Wisconsin', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (50, 'Wyoming', DEFAULT);
INSERT INTO `myjob`.`State` (`StateID`, `StateName`, `TimeStamp`) VALUES (51, 'District Of Columbia', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`EmployerEmail`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`EmployerEmail` (`EmployerID`, `Email`, `TimeStamp`) VALUES (16, 'noogler@google.com', DEFAULT);
INSERT INTO `myjob`.`EmployerEmail` (`EmployerID`, `Email`, `TimeStamp`) VALUES (17, 'zahoo@yahoo.com', DEFAULT);
INSERT INTO `myjob`.`EmployerEmail` (`EmployerID`, `Email`, `TimeStamp`) VALUES (18, 'pear@apple.com', DEFAULT);
INSERT INTO `myjob`.`EmployerEmail` (`EmployerID`, `Email`, `TimeStamp`) VALUES (19, 'edison@tesla.com', DEFAULT);
INSERT INTO `myjob`.`EmployerEmail` (`EmployerID`, `Email`, `TimeStamp`) VALUES (20, 'chirp@twitter.com', DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`AddressToJobPost`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`AddressToJobPost` (`AddressID`, `JobPostID`, `TimeStamp`) VALUES (1, 1, DEFAULT);
INSERT INTO `myjob`.`AddressToJobPost` (`AddressID`, `JobPostID`, `TimeStamp`) VALUES (2, 2, DEFAULT);
INSERT INTO `myjob`.`AddressToJobPost` (`AddressID`, `JobPostID`, `TimeStamp`) VALUES (3, 3, DEFAULT);
INSERT INTO `myjob`.`AddressToJobPost` (`AddressID`, `JobPostID`, `TimeStamp`) VALUES (4, 4, DEFAULT);
INSERT INTO `myjob`.`AddressToJobPost` (`AddressID`, `JobPostID`, `TimeStamp`) VALUES (5, 5, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`EmployerToAddress`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`EmployerToAddress` (`EmployerID`, `AddressID`, `TimeStamp`) VALUES (16, 1, DEFAULT);
INSERT INTO `myjob`.`EmployerToAddress` (`EmployerID`, `AddressID`, `TimeStamp`) VALUES (17, 2, DEFAULT);
INSERT INTO `myjob`.`EmployerToAddress` (`EmployerID`, `AddressID`, `TimeStamp`) VALUES (18, 3, DEFAULT);
INSERT INTO `myjob`.`EmployerToAddress` (`EmployerID`, `AddressID`, `TimeStamp`) VALUES (19, 4, DEFAULT);
INSERT INTO `myjob`.`EmployerToAddress` (`EmployerID`, `AddressID`, `TimeStamp`) VALUES (20, 5, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`RoleToEmployerUser`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`RoleToEmployerUser` (`EmployerID`, `TimeStamp`, `RoleID`) VALUES (16, DEFAULT, 1);
INSERT INTO `myjob`.`RoleToEmployerUser` (`EmployerID`, `TimeStamp`, `RoleID`) VALUES (17, DEFAULT, 2);
INSERT INTO `myjob`.`RoleToEmployerUser` (`EmployerID`, `TimeStamp`, `RoleID`) VALUES (18, DEFAULT, 3);
INSERT INTO `myjob`.`RoleToEmployerUser` (`EmployerID`, `TimeStamp`, `RoleID`) VALUES (19, DEFAULT, 4);
INSERT INTO `myjob`.`RoleToEmployerUser` (`EmployerID`, `TimeStamp`, `RoleID`) VALUES (20, DEFAULT, 5);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`ZipCodeToAddress`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`ZipCodeToAddress` (`ZipCode`, `AddressID`, `TimeStamp`) VALUES (55108, 1, DEFAULT);
INSERT INTO `myjob`.`ZipCodeToAddress` (`ZipCode`, `AddressID`, `TimeStamp`) VALUES (55573, 2, DEFAULT);
INSERT INTO `myjob`.`ZipCodeToAddress` (`ZipCode`, `AddressID`, `TimeStamp`) VALUES (15261, 3, DEFAULT);
INSERT INTO `myjob`.`ZipCodeToAddress` (`ZipCode`, `AddressID`, `TimeStamp`) VALUES (95160, 4, DEFAULT);
INSERT INTO `myjob`.`ZipCodeToAddress` (`ZipCode`, `AddressID`, `TimeStamp`) VALUES (13210, 5, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `myjob`.`CityToState`
-- -----------------------------------------------------
START TRANSACTION;
USE `myjob`;
INSERT INTO `myjob`.`CityToState` (`CityID`, `StateID`, `TimeStamp`) VALUES (1, 23, DEFAULT);
INSERT INTO `myjob`.`CityToState` (`CityID`, `StateID`, `TimeStamp`) VALUES (2, 23, DEFAULT);
INSERT INTO `myjob`.`CityToState` (`CityID`, `StateID`, `TimeStamp`) VALUES (3, 38, DEFAULT);
INSERT INTO `myjob`.`CityToState` (`CityID`, `StateID`, `TimeStamp`) VALUES (4, 5, DEFAULT);
INSERT INTO `myjob`.`CityToState` (`CityID`, `StateID`, `TimeStamp`) VALUES (5, 32, DEFAULT);

COMMIT;

