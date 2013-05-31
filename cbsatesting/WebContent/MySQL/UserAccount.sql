CREATE TABLE  `CBSA`.`useraccount` (
`UserID` INT AUTO_INCREMENT ,
`FirstName` VARCHAR( 50 ) NOT NULL ,
`LastName` VARCHAR( 50 ) NOT NULL ,
`UserName` VARCHAR( 50 ) NOT NULL ,
`PrimaryEmail` VARCHAR( 50 ) NOT NULL ,
`TimeZone` VARCHAR( 50 ) NOT NULL ,
`AccountType` VARCHAR( 5 ) NOT NULL ,
`Password` VARCHAR( 50 ) NOT NULL ,
PRIMARY KEY (  `UserID` )
);


INSERT INTO  `CBSA`.`UserAccount` (
`UserID` ,
`FirstName` ,
`LastName` ,
`UserName` ,
`PrimaryEmail` ,
`TimeZone` ,
`AccountType` ,
`Password`
)
VALUES (
'1',  'Teja',  'Karra',  'kteja',  'tejaswinikarra@gmail.com',  '(GMT-8:00) Pacific Time',  'Admin',  'user1'
);

INSERT INTO  `CBSA`.`UserAccount` (
`UserID` ,
`FirstName` ,
`LastName` ,
`UserName` ,
`PrimaryEmail` ,
`TimeZone` ,
`AccountType` ,
`Password`
)
VALUES (
'2',  'Ying',  'Zuo',  'zying',  'yzonemail@gmail.com',  '(GMT-8:00) Pacific Time',  'Admin',  'user2'
);

INSERT INTO  `CBSA`.`UserAccount` (
`UserID` ,
`FirstName` ,
`LastName` ,
`UserName` ,
`PrimaryEmail` ,
`TimeZone` ,
`AccountType` ,
`Password`
)
VALUES (
'3',  'Radha',  'Iyer',  'iradha',  'goradhago@gmail.com',  '(GMT-8:00) Pacific Time',  'Admin',  'user3'
);

INSERT INTO  `CBSA`.`UserAccount` (
`UserID` ,
`FirstName` ,
`LastName` ,
`UserName` ,
`PrimaryEmail` ,
`TimeZone` ,
`AccountType` ,
`Password`
)
VALUES (
'4',  'UserF4',  'UserL4',  'FL4',  'FL4@CBSA.com',  '(GMT-8:00) Pacific Time',  'user',  'user4'
);

INSERT INTO  `CBSA`.`UserAccount` (
`UserID` ,
`FirstName` ,
`LastName` ,
`UserName` ,
`PrimaryEmail` ,
`TimeZone` ,
`AccountType` ,
`Password`
)
VALUES (
'5',  'UserF5',  'UserL5',  'FL5',  'FL5@CBSA.com',  '(GMT-8:00) Pacific Time',  'user',  'user5'
);

INSERT INTO  `CBSA`.`UserAccount` (
`UserID` ,
`FirstName` ,
`LastName` ,
`UserName` ,
`PrimaryEmail` ,
`TimeZone` ,
`AccountType` ,
`Password`
)
VALUES (
'6',  'UserF6',  'UserL6',  'FL6',  'FL6@CBSA.com',  '(GMT-8:00) Pacific Time',  'user',  'user6'
);