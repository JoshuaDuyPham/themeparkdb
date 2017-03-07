# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: localhost (MySQL 5.7.17)
# Database: Theme_park_Management
# Generation Time: 2017-03-03 18:42:53 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table Customer
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Customer`;

CREATE TABLE `Customer` (
  `pass_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `ticket_type` enum('Season','Single','Half_Season') NOT NULL DEFAULT 'Single',
  `price` decimal(3,2) NOT NULL,
  `age_group` enum('Adult','Child') NOT NULL DEFAULT 'Adult',
  `street_address` text,
  `city` text,
  `state` text,
  `zip_code` text,
  PRIMARY KEY (`pass_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table Customer_Plays_Games
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Customer_Plays_Games`;

CREATE TABLE `Customer_Plays_Games` (
  `game_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `number_of_customers` int(11) unsigned NOT NULL,
  `time_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `e_on_duty` int(11) unsigned NOT NULL,
  PRIMARY KEY (`game_id`),
  KEY `e_on_duty` (`e_on_duty`),
  CONSTRAINT `customer_plays_games_ibfk_1` FOREIGN KEY (`game_id`) REFERENCES `Game` (`model_id`),
  CONSTRAINT `customer_plays_games_ibfk_2` FOREIGN KEY (`e_on_duty`) REFERENCES `Employee` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table Customer_Rides
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Customer_Rides`;

CREATE TABLE `Customer_Rides` (
  `ride_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `attendant_on_duty` int(11) unsigned NOT NULL,
  `num_of_customers` int(11) unsigned NOT NULL,
  `time_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ride_id`),
  KEY `attendant_on_duty` (`attendant_on_duty`),
  CONSTRAINT `customer_rides_ibfk_1` FOREIGN KEY (`ride_id`) REFERENCES `Ride` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `customer_rides_ibfk_2` FOREIGN KEY (`attendant_on_duty`) REFERENCES `Employee` (`ssn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table Employee
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Employee`;

CREATE TABLE `Employee` (
  `wage` decimal(11,0) unsigned NOT NULL,
  `ssn` int(9) unsigned NOT NULL,
  `phone number` smallint(12) DEFAULT NULL,
  `position` enum('attendant','maintanence','sales','server','manager') NOT NULL DEFAULT 'attendant',
  `work_hours` int(10) unsigned zerofill NOT NULL,
  `address` text NOT NULL,
  `date_of_birth` date NOT NULL,
  `first_name` text NOT NULL,
  `last_name` text NOT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  PRIMARY KEY (`ssn`),
  UNIQUE KEY `position` (`position`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table Game
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Game`;

CREATE TABLE `Game` (
  `model_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `prize` enum('Large','Medium','Small') DEFAULT NULL,
  `price` decimal(2,2) unsigned NOT NULL,
  `manufacturer` text,
  `maintenance_date` datetime DEFAULT NULL,
  `operational` tinyint(1) NOT NULL,
  `name` text NOT NULL,
  `capacity` int(3) unsigned NOT NULL,
  `employee` int(11) unsigned NOT NULL,
  PRIMARY KEY (`model_id`),
  KEY `employee` (`employee`),
  CONSTRAINT `game_ibfk_1` FOREIGN KEY (`employee`) REFERENCES `Employee` (`ssn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table Kiosk
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Kiosk`;

CREATE TABLE `Kiosk` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `service_type` enum('Food','Gift','Ticket') NOT NULL DEFAULT 'Ticket',
  `Aemployee` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Aemployee` (`Aemployee`),
  CONSTRAINT `kiosk_ibfk_1` FOREIGN KEY (`Aemployee`) REFERENCES `Employee` (`ssn`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table Partonize
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Partonize`;

CREATE TABLE `Partonize` (
  `kiosk_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `customer_id` int(11) NOT NULL,
  PRIMARY KEY (`kiosk_id`),
  UNIQUE KEY `customer_id` (`customer_id`),
  CONSTRAINT `kiosk_info` FOREIGN KEY (`kiosk_id`) REFERENCES `Kiosk` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table Ride
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Ride`;

CREATE TABLE `Ride` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `admission_price` decimal(2,2) unsigned NOT NULL,
  `capacity` int(4) unsigned NOT NULL,
  `date_built` date NOT NULL,
  `maintenance_date` date DEFAULT NULL,
  `operational` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table Works_On
# ------------------------------------------------------------

DROP TABLE IF EXISTS `Works_On`;

CREATE TABLE `Works_On` (
  `employee_id` int(9) unsigned NOT NULL,
  `ride_id` int(11) unsigned NOT NULL,
  `E_Position` enum('attendant','maintanence','sales','server','manager') NOT NULL DEFAULT 'attendant',
  PRIMARY KEY (`employee_id`),
  KEY `ride_id` (`ride_id`),
  KEY `E_Position` (`E_Position`),
  CONSTRAINT `employee_ssn` FOREIGN KEY (`employee_id`) REFERENCES `Employee` (`ssn`),
  CONSTRAINT `model_number` FOREIGN KEY (`ride_id`) REFERENCES `Ride` (`id`),
  CONSTRAINT `works_on_ibfk_1` FOREIGN KEY (`E_Position`) REFERENCES `Employee` (`position`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;




/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
