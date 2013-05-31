CREATE  TABLE IF NOT EXISTS `CBSA`.`workflow` (
  `WorkFlowID` INT NOT NULL AUTO_INCREMENT ,
  `project_name` varchar(45) NOT NULL,
  `workflow_name` varchar(45) NOT NULL,
  `TimeStamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `location` VARCHAR(500) NOT NULL ,
  `Remarks` VARCHAR(256) NULL ,
  PRIMARY KEY (`WorkFlowID`) ,
  INDEX `WorkFlowID` (`WorkFlowID` ASC));
