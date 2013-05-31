CREATE TABLE IF NOT EXISTS `testtool` (
  `ToolID` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(45) NOT NULL,
  `project_desc` varchar(1024) NOT NULL,
  `tool_type` varchar(45) NOT NULL,
  PRIMARY KEY (`ToolID`)
)