CREATE TABLE IF NOT EXISTS `scalabilitymetric` (
  `MetricID` int(11) NOT NULL AUTO_INCREMENT,
  `isDefault` tinyint(1) NOT NULL DEFAULT '0',
  `Name` varchar(50) NOT NULL,
  `Statistic` varchar(15) NOT NULL,
  `Description` varchar(1024) NOT NULL,
  `Equation` varchar(1024) NOT NULL,
  `Type` varchar(25) NOT NULL DEFAULT 'User Defined',
  PRIMARY KEY (`MetricID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=43 ;


INSERT INTO `scalabilitymetric` (`MetricID`, `isDefault`, `Name`, `Statistic`, `Description`, `Equation`, `Type`) VALUES
(1, 0, 'CPUUtilization', 'Average', 'Percentage of allocated EC2 compute units that are currently in use.', 'System Defined', 'System Defined'),
(2, 0, 'CPUUtilization', 'Maximum', 'Percentage of allocated EC2 compute units that are currently in use.', 'System Defined', 'System Defined'),
(3, 0, 'CPUUtilization', 'Minimum', 'Percentage of allocated EC2 compute units that are currently in use.', 'System Defined', 'System Defined'),
(4, 0, 'CPUUtilization', 'Sum', 'Percentage of allocated EC2 compute units that are currently in use.', 'System Defined', 'System Defined'),
(5, 0, 'CPUUtilization', 'SampleCount', 'Percentage of allocated EC2 compute units that are currently in use.', 'System Defined', 'System Defined'),
(6, 0, 'DiskReadOps', 'Average', 'Completed read operations from all ephemeral disks available.', 'System Defined', 'System Defined'),
(7, 0, 'DiskReadOps', 'Maximum', 'Completed read operations from all ephemeral disks available.', 'System Defined', 'System Defined'),
(8, 0, 'DiskReadOps', 'Minimum', 'Completed read operations from all ephemeral disks available.', 'System Defined', 'System Defined'),
(9, 0, 'DiskReadOps', 'Sum', 'Completed read operations from all ephemeral disks available.', 'System Defined', 'System Defined'),
(10, 0, 'DiskReadOps', 'SampleCount', 'Completed read operations from all ephemeral disks available.', 'System Defined', 'System Defined'),
(11, 0, 'DiskWriteOps', 'Average', 'Completed write operations to all ephemeral disks available.', 'System Defined', 'System Defined'),
(12, 0, 'DiskWriteOps', 'Maximum', 'Completed write operations to all ephemeral disks available.', 'System Defined', 'System Defined'),
(13, 0, 'DiskWriteOps', 'Minimum', 'Completed write operations to all ephemeral disks available.', 'System Defined', 'System Defined'),
(14, 0, 'DiskWriteOps', 'Sum', 'Completed write operations to all ephemeral disks available.', 'System Defined', 'System Defined'),
(15, 0, 'DiskWriteOps', 'SampleCount', 'Completed write operations to all ephemeral disks available.', 'System Defined', 'System Defined'),
(16, 0, 'DiskReadBytes', 'Average', 'Bytes read from all ephemeral disks available to the instance.', 'System Defined', 'System Defined'),
(17, 0, 'DiskReadBytes', 'Maximum', 'Bytes read from all ephemeral disks available to the instance.', 'System Defined', 'System Defined'),
(18, 0, 'DiskReadBytes', 'Minimum', 'Bytes read from all ephemeral disks available to the instance.', 'System Defined', 'System Defined'),
(19, 0, 'DiskReadBytes', 'Sum', 'Bytes read from all ephemeral disks available to the instance.', 'System Defined', 'System Defined'),
(20, 0, 'DiskReadBytes', 'SampleCount', 'Bytes read from all ephemeral disks available to the instance.', 'System Defined', 'System Defined'),
(21, 0, 'DiskWriteBytes', 'Average', 'Bytes written  from all ephemeral disks available to the instance.', 'System Defined', 'System Defined'),
(22, 0, 'DiskWriteBytes', 'Maximum', 'Bytes written  from all ephemeral disks available to the instance.', 'System Defined', 'System Defined'),
(23, 0, 'DiskWriteBytes', 'Minimum', 'Bytes written  from all ephemeral disks available to the instance.', 'System Defined', 'System Defined'),
(24, 0, 'DiskWriteBytes', 'Sum', 'Bytes written  from all ephemeral disks available to the instance.', 'System Defined', 'System Defined'),
(25, 0, 'DiskWriteBytes', 'SampleCount', 'Bytes written  from all ephemeral disks available to the instance.', 'System Defined', 'System Defined'),
(26, 0, 'NetworkIn', 'Average', 'Number of bytes received on all network interfaces by the instance.', 'System Defined', 'System Defined'),
(27, 0, 'NetworkIn', 'Maximum', 'Number of bytes received on all network interfaces by the instance.', 'System Defined', 'System Defined'),
(28, 0, 'NetworkIn', 'Minimum', 'Number of bytes received on all network interfaces by the instance.', 'System Defined', 'System Defined'),
(29, 0, 'NetworkIn', 'Sum', 'Number of bytes received on all network interfaces by the instance.', 'System Defined', 'System Defined'),
(30, 0, 'NetworkIn', 'SampleCount', 'Number of bytes received on all network interfaces by the instance.', 'System Defined', 'System Defined'),
(31, 0, 'NetworkOut', 'Average', 'Number of bytes sent out  on all network interfaces by the instance.', 'System Defined', 'System Defined'),
(32, 0, 'NetworkOut', 'Maximum', 'Number of bytes sent out  on all network interfaces by the instance.', 'System Defined', 'System Defined'),
(33, 0, 'NetworkOut', 'Minimum', 'Number of bytes sent out  on all network interfaces by the instance.', 'System Defined', 'System Defined'),
(34, 0, 'NetworkOut', 'Sum', 'Number of bytes sent out  on all network interfaces by the instance.', 'System Defined', 'System Defined'),
(35, 0, 'NetworkOut', 'SampleCount', 'Number of bytes sent out  on all network interfaces by the instance.', 'System Defined', 'System Defined'),
(36, 0, 'CRAM', 'None', 'Computing Resource Allocation Meter. Measures System Resources Allocation.', 'Based on a Model', 'Model Defined'),
(37, 0, 'CRUM', 'None', 'Computing Resource Utilization Meter. Measures System Resources Utilization.', 'Based on a Model', 'Model Defined'),
(39, 0, 'Reliability', 'None', 'System performance', '1 * NetworkOut : Maximum - 1 * NetworkIn : Maximum', 'User Defined'),
(40, 0, 'Availability', 'None', 'Checking system resources', '1 * CPUUtilization : Maximum / 1 * CPUUtilization : Minimum', 'User Defined'),
(41, 0, 'Throughput', 'None', '', '1 * Reliability : None / 1 * NetworkIn : Average', 'User Defined'),
(42, 0, 'ResourceUtilization', 'None', 'System resource', '1 * DiskReadOps : Sum + 1 * DiskWriteOps : Sum', 'User Defined'),
(43, 0, 'SPM', 'None', 'System Performance Meter', 'Based on a Model', 'Model Defined');

CREATE TABLE IF NOT EXISTS `scalabilitymodel` (
  `ModelID` int(11) NOT NULL AUTO_INCREMENT,
  `isDefault` tinyint(1) NOT NULL DEFAULT '0',
  `Name` varchar(50) NOT NULL,
  `Description` varchar(1024) NOT NULL,
  `NumMetrics` int(11) NOT NULL,
  `Type` varchar(25) NOT NULL DEFAULT 'User Defined',
  `Status` varchar(10) NOT NULL DEFAULT '(Stopped)',
  `Value` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ModelID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

INSERT INTO `scalabilitymodel` (`ModelID`, `isDefault`, `Name`, `Description`, `NumMetrics`, `Type`, `Status`, `Value`) VALUES
(1, 1, 'CRAM', 'Computing Resource Allocation Meter. Measures System Resources Allocation.', 5, 'System Defined', '(stopped)', 0),
(2, 0, 'CRUM', 'Computing Resource Utilization Meter. Measures System Resources Utilization.', 5, 'System Defined', '(running)', 0),
(3, 0, 'SPM', 'System Performance Meter', 4, 'User Defined', '(stopped)', 0);

CREATE TABLE IF NOT EXISTS `scalabilitymodelmetric` (
  `ModelID` int(11) NOT NULL,
  `MetricID` int(11) NOT NULL,
  `ModelMetric` tinyint(1) NOT NULL DEFAULT '0',
  FOREIGN KEY (`ModelID`) REFERENCES `scalabilitymodel`(`ModelID`) ON DELETE CASCADE,
  FOREIGN KEY (`MetricID`) REFERENCES `scalabilitymetric`(`MetricID`) );

INSERT INTO `scalabilitymodelmetric` (`ModelID`, `MetricID`, `ModelMetric`) VALUES
(1, 2, 0),
(1, 17, 0),
(1, 22, 0),
(1, 27, 0),
(1, 32, 0),
(1, 36, 1),
(2, 1, 0),
(2, 16, 0),
(2, 21, 0),
(2, 26, 0),
(2, 31, 0),
(2, 37, 1),
(3, 39, 0),
(3, 40, 0),
(3, 41, 0),
(3, 42, 0),
(3, 43, 1);

CREATE TABLE IF NOT EXISTS `scalabilitymodeldata` (
  `ModelID` int(11) NOT NULL,
  `CollectedTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `MetricID` int(11) NOT NULL,
  `Data` double(15,5) NOT NULL,
  FOREIGN KEY (`ModelID`) REFERENCES `scalabilitymodel` (`ModelID`) ON DELETE CASCADE,
  FOREIGN KEY (`MetricID`) REFERENCES `scalabilitymetric` (`MetricID`)
);

INSERT INTO `scalabilitymodeldata` (`ModelID`, `CollectedTime`, `MetricID`, `Data`) VALUES
(2, '2011-11-15 19:16:18', 1, 30.00000),
(2, '2011-11-15 19:16:18', 16, 50.00000),
(2, '2011-11-15 19:16:18', 21, 75.00000),
(2, '2011-11-15 19:16:18', 26, 119.00000),
(2, '2011-11-15 19:16:18', 31, 63.00000),
(2, '2011-11-15 19:16:18', 37, 128.00000),
(2, '2011-11-15 19:20:18', 1, 54.00000),
(2, '2011-11-15 19:20:18', 16, 60.00000),
(2, '2011-11-15 19:20:18', 21, 90.00000),
(2, '2011-11-15 19:20:18', 26, 153.00000),
(2, '2011-11-15 19:20:18', 31, 77.00000),
(2, '2011-11-15 19:20:18', 37, 166.00000),
(2, '2011-11-15 19:25:18', 1, 73.00000),
(2, '2011-11-15 19:25:18', 16, 70.00000),
(2, '2011-11-15 19:25:18', 21, 105.00000),
(2, '2011-11-15 19:25:18', 26, 235.00000),
(2, '2011-11-15 19:25:18', 31, 106.00000),
(2, '2011-11-15 19:25:18', 37, 225.00000);