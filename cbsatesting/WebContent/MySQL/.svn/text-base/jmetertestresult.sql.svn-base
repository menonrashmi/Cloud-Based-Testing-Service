/**
 * missing foreign keys for now
 */

CREATE TABLE IF NOT EXISTS `jmeterresult` (
  `TestResultID` int(11) NOT NULL AUTO_INCREMENT,
  `UserID` int(11) NOT NULL DEFAULT '1',
  `TimeStamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `RequestTime` int(11) NOT NULL,
  `TestLabel` varchar(100) NOT NULL,
  `DataType` varchar(45) NOT NULL DEFAULT 'text',
  `ThreadName` varchar(50) NOT NULL,
  `ReturnCode` varchar(10) NOT NULL,
  `Byte` int(11) NOT NULL,
  KEY `TestResultID` (`TestResultID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1;

ALTER TABLE jmeterresult
ADD FOREIGN KEY (`UserID`) REFERENCES `UserAccount` (`UserID`);
