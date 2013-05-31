/**
 * Database name is amazon_instance under that this is the table.
 */

CREATE TABLE  `amazon_instance`.`instance` (
  `instance_id` int(15) NOT NULL AUTO_INCREMENT,
  `Os` varchar(45) NOT NULL DEFAULT '1',
  `Ram` varchar(45) NOT NULL DEFAULT '0',
  `Storage` varchar(45) NOT NULL,
  `Amazon_instance_id` varchar(45) NOT NULL,
  `Start_date` varchar(45) NOT NULL,
  `Instance_Type` varchar(50) NOT NULL,
  `Stop_date` varchar(50) NOT NULL,
`Total_hours` int(11) NOT NULL,
  `taas_instance_id` varchar(45) NOT NULL,
`current_state` varchar(45) NOT NULL,
`Fk_tools_id` int(11) NOT NULL,
`fk_contract_id` date NOT NULL,
`signed_by` varchar(45) NOT NULL,
`date_signed` date NOT NULL,
`client_name` varchar(45) NOT NULL,
`fk_user_id` int(45) NOT NULL,
    PRIMARY KEY (`instance_id`) ,
  INDEX `instance_id` (`instance_id` ASC) 
) 