CREATE  TABLE IF NOT EXISTS `CBSA`.`seleniumresult` (
  `TestResultID` INT NOT NULL AUTO_INCREMENT ,
  `TestProject` VARCHAR(1024) NOT NULL ,
  `UserID` INT NOT NULL DEFAULT 2 ,
  `TimeStamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ,
  `TestURL` VARCHAR(128) NOT NULL ,
  `TestSuite` VARCHAR(1024) NOT NULL ,
  `ResultFile` VARCHAR(1024) NOT NULL ,
  `Success` INT NOT NULL ,
  `Fail` INT NOT NULL ,
  `Remarks` VARCHAR(256) NULL ,
  PRIMARY KEY (`TestResultID`) ,
  INDEX `TestResultID` (`TestResultID` ASC) ,
  CONSTRAINT `UserID`
    FOREIGN KEY (`UserID`)
    REFERENCES `CBSA`.`UserAccount` (`UserID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    

ALTER TABLE `seleniumresult`
ADD FOREIGN KEY (`UserID`) REFERENCES `UserAccount` (`UserID`);