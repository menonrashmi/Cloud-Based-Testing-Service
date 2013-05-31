-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Nov 14, 2011 at 02:42 AM
-- Server version: 5.5.16
-- PHP Version: 5.3.5

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `cbsa`
--

-- --------------------------------------------------------

--
-- Table structure for table `performancemetric`
--

CREATE TABLE IF NOT EXISTS `performancemetric` (
  `MetricID` int(11) NOT NULL AUTO_INCREMENT,
  `isDefault` tinyint(1) NOT NULL DEFAULT '0',
  `Name` varchar(50) NOT NULL,
  `Statistic` varchar(15) NOT NULL,
  `Description` varchar(1024) NOT NULL,
  `Equation` varchar(1024) NOT NULL,
  `Type` varchar(25) NOT NULL DEFAULT 'Not System Defined',
  PRIMARY KEY (`MetricID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=37 ;

--
-- Dumping data for table `performancemetric`
--

INSERT INTO `performancemetric` (`MetricID`, `isDefault`, `Name`, `Statistic`, `Description`, `Equation`, `Type`) VALUES
(1, 1, 'CPU Utilization', 'Average', 'Measures CPU Utilization', 'System Defined', 'System Defined'),
(2, 1, 'Memory Use', 'Average', 'Measures Memory Usage', 'System Defined', 'System Defined'),
(3, 1, 'Disk Write', 'Average', 'Number of Disk Write Operations', 'System Defined', 'System Defined'),
(4, 0, 'Disk Read', 'Average', 'Number of Disk Read Operations', 'System Defined', 'System Defined'),
(5, 0, 'Network In', 'Average', 'Measures Network In Activity', 'System Defined', 'System Defined'),
(6, 0, 'Network Out', 'Average', 'Measures Network Out Activity', 'System Defined', 'System Defined'),
(7, 0, 'Storage', 'Average', 'Measures Storage Activity', 'System Defined', 'System Defined'),
(8, 0, 'Speed', 'Average', 'Measures Network In Activity', 'System Defined', 'System Defined'),
(9, 0, 'Network I/O', 'None', 'Measures Network I/O', 'NetworkIn + NetworkOut', 'User Defined'),
(10, 0, 'Disk I/O', 'None', 'Number of Disk I/Os', 'DataWrite + DataRead', 'User Defined'),
(12, 0, 'Computing Resource Allocation Meter (CRAM)', 'None', '', 'Based on a Model', 'Model Metric'),
(13, 0, 'Computing Resource Utilization Meter (CRUM)', 'None', '', 'Based on a Model', 'Model Metric'),
(36, 0, 'testing', 'None', 'testing it', 'Based on a Model', 'Model Metric');

-- --------------------------------------------------------

--
-- Table structure for table `performancemodel`
--

CREATE TABLE IF NOT EXISTS `performancemodel` (
  `ModelID` int(11) NOT NULL AUTO_INCREMENT,
  `isDefault` tinyint(1) NOT NULL DEFAULT '0',
  `Name` varchar(50) NOT NULL,
  `Description` varchar(1024) NOT NULL,
  `NumMetrics` int(11) NOT NULL,
  `Type` varchar(25) NOT NULL DEFAULT 'User Defined',
  `Status` varchar(10) NOT NULL DEFAULT '(Stopped)',
  `Value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ModelID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=37 ;

--
-- Dumping data for table `performancemodel`
--

INSERT INTO `performancemodel` (`ModelID`, `isDefault`, `Name`, `Description`, `NumMetrics`, `Type`, `Status`, `Value`) VALUES
(1, 1, 'Computing Resource Allocation Meter (CRAM)', '', 5, 'System Defined', '(stopped)', 0),
(2, 0, 'Computing Resource Utilization Meter (CRUM)', '', 5, 'System Defined', '(stopped)', 0),
(36, 0, 'testing', 'testing it', 3, 'User Defined', '(stopped)', 0);

-- --------------------------------------------------------

--
-- Table structure for table `performancemodelmetric`
--

CREATE TABLE IF NOT EXISTS `performancemodelmetric` (
  `ModelID` int(11) NOT NULL,
  `MetricID` int(11) NOT NULL,
  `ModelMetric` tinyint(1) NOT NULL DEFAULT '0',
  KEY `ModelID` (`ModelID`),
  KEY `MetricID` (`MetricID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `performancemodelmetric`
--

INSERT INTO `performancemodelmetric` (`ModelID`, `MetricID`, `ModelMetric`) VALUES
(1, 1, 0),
(1, 2, 0),
(1, 7, 0),
(1, 9, 0),
(1, 10, 0),
(1, 12, 1),
(2, 1, 0),
(2, 2, 0),
(2, 7, 0),
(2, 9, 0),
(2, 10, 0),
(2, 13, 1),
(36, 1, 0),
(36, 2, 0),
(36, 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `performancmodeldata`
--

CREATE TABLE IF NOT EXISTS `performancmodeldata` (
  `ModelID` int(11) NOT NULL,
  `Time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `MetricID` int(11) NOT NULL,
  `Data` double(10,5) NOT NULL,
  KEY `ModelID` (`ModelID`),
  KEY `MetricID` (`MetricID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `useraccount`
--

CREATE TABLE IF NOT EXISTS `useraccount` (
  `UserID` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(50) NOT NULL,
  `LastName` varchar(50) NOT NULL,
  `UserName` varchar(50) NOT NULL,
  `PrimaryEmail` varchar(50) NOT NULL,
  `TimeZone` varchar(50) NOT NULL,
  `AccountType` varchar(5) NOT NULL,
  `Password` varchar(50) NOT NULL,
  PRIMARY KEY (`UserID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `useraccount`
--

INSERT INTO `useraccount` (`UserID`, `FirstName`, `LastName`, `UserName`, `PrimaryEmail`, `TimeZone`, `AccountType`, `Password`) VALUES
(1, 'Teja', 'Karra', 'kteja', 'tejaswinikarra@gmail.com', '(GMT-8:00) Pacific Time', 'Admin', 'user1'),
(2, 'Ying', 'Zuo', 'zying', 'yzonemail@gmail.com', '(GMT-8:00) Pacific Time', 'Admin', 'user2'),
(3, 'Public', 'Iyer', 'iPublic', 'goPublicgo@gmail.com', '(GMT-8:00) Pacific Time', 'Admin', 'user3'),
(4, 'UserF4', 'UserL4', 'FL4', 'FL4@CBSA.com', '(GMT-8:00) Pacific Time', 'user', 'user4'),
(5, 'UserF5', 'UserL5', 'FL5', 'FL5@CBSA.com', '(GMT-8:00) Pacific Time', 'user', 'user5'),
(6, 'UserF6', 'UserL6', 'FL6', 'FL6@CBSA.com', '(GMT-8:00) Pacific Time', 'user', 'user6');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `performancemodelmetric`
--
ALTER TABLE `performancemodelmetric`
  ADD CONSTRAINT `performancemodelmetric_ibfk_1` FOREIGN KEY (`ModelID`) REFERENCES `performancemodel` (`ModelID`),
  ADD CONSTRAINT `performancemodelmetric_ibfk_2` FOREIGN KEY (`MetricID`) REFERENCES `performancemetric` (`MetricID`);

--
-- Constraints for table `performancmodeldata`
--
ALTER TABLE `performancmodeldata`
  ADD CONSTRAINT `performancmodeldata_ibfk_1` FOREIGN KEY (`ModelID`) REFERENCES `performancemodel` (`ModelID`),
  ADD CONSTRAINT `performancmodeldata_ibfk_2` FOREIGN KEY (`ModelID`) REFERENCES `performancemodel` (`ModelID`),
  ADD CONSTRAINT `performancmodeldata_ibfk_3` FOREIGN KEY (`ModelID`) REFERENCES `performancemodel` (`ModelID`),
  ADD CONSTRAINT `performancmodeldata_ibfk_4` FOREIGN KEY (`ModelID`) REFERENCES `performancemodel` (`ModelID`),
  ADD CONSTRAINT `performancmodeldata_ibfk_5` FOREIGN KEY (`MetricID`) REFERENCES `performancemetric` (`MetricID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
