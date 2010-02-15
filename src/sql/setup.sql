--
-- Database: `ServerStats`
--

-- --------------------------------------------------------

--
-- Table structure for table `Accounts`
--

CREATE TABLE IF NOT EXISTS `Accounts` (
  `a_id` int(11) NOT NULL AUTO_INCREMENT,
  `u_id` int(11) NOT NULL COMMENT 'This is the primary user',
  `at_id` int(11) NOT NULL,
  `a_status` int(11) NOT NULL,
  PRIMARY KEY (`a_id`),
  KEY `u_id` (`u_id`),
  KEY `at_id` (`at_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds the account data';



-- --------------------------------------------------------

--
-- Table structure for table `Account_types`
--

CREATE TABLE IF NOT EXISTS `Account_types` (
  `at_id` int(11) NOT NULL AUTO_INCREMENT,
  `at_name` varchar(200) NOT NULL,
  `at_price` decimal(8,2) NOT NULL,
  `at_start` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `at_end` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `at_rollover` int(11) NOT NULL COMMENT 'This will be the account type this one rolls over to once it expires',
  PRIMARY KEY (`at_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Holds the account types';



-- --------------------------------------------------------

--
-- Table structure for table `Account_users`
--

CREATE TABLE IF NOT EXISTS `Account_users` (
  `a_id` int(11) NOT NULL,
  `u_id` int(11) NOT NULL,
  KEY `a_id` (`a_id`),
  KEY `u_id` (`u_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;





-- --------------------------------------------------------

--
-- Table structure for table `Keys`
--

CREATE TABLE IF NOT EXISTS `Keys` (
  `k_id` int(11) NOT NULL AUTO_INCREMENT,
  `k_name` char(10) NOT NULL,
  `s_id` int(11) NOT NULL,
  PRIMARY KEY (`k_id`),
  KEY `s_id` (`s_id`),
  KEY `k_name` (`k_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- --------------------------------------------------------

--
-- Table structure for table `Results`
--

CREATE TABLE IF NOT EXISTS `Results` (
  `r_id` int(11) NOT NULL,
  `s_id` int(11) NOT NULL,
  `r_value` float NOT NULL,
  `k_id` int(11) NOT NULL,
  `r_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`r_id`),
  KEY `k_id` (`k_id`),
  KEY `s_id` (`s_id`),
  KEY `r_timestamp` (`r_timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- --------------------------------------------------------

--
-- Table structure for table `Servers`
--

CREATE TABLE IF NOT EXISTS `Servers` (
  `s_id` int(11) NOT NULL AUTO_INCREMENT,
  `s_name` varchar(100) NOT NULL,
  `a_id` int(11) NOT NULL,
  `s_ip` char(11) NOT NULL,
  `s_key` char(10) NOT NULL,
  PRIMARY KEY (`s_id`),
  KEY `a_id` (`a_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE IF NOT EXISTS `Users` (
  `u_id` int(11) NOT NULL AUTO_INCREMENT,
  `u_email` varchar(200) NOT NULL,
  `u_password` char(40) NOT NULL,
  `u_type` enum('admin','normal') NOT NULL,
  `u_logins` int(11) UNSIGNED NOT NULL DEFAULT '0',
  `u_lastlogin` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `u_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`u_id`),
  UNIQUE KEY `u_email` (`u_email`),
  KEY `u_type` (`u_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



-- --------------------------------------------------------

--
-- FOREIGN KEYS, CONSTRAINTS, VIEWS, PROCEDURES
--

ALTER TABLE `Account_users` 
ADD CONSTRAINT FK_account_users_u_id 
FOREIGN KEY (`u_id`) REFERENCES `Users`(`u_id`) 
ON UPDATE CASCADE
ON DELETE CASCADE;

ALTER TABLE `Account_users` 
ADD CONSTRAINT FK_account_users_a_id 
FOREIGN KEY (`a_id`) REFERENCES `Accounts`(`a_id`) 
ON UPDATE CASCADE
ON DELETE CASCADE;


