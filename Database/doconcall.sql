-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 20, 2019 at 07:41 PM
-- Server version: 10.1.38-MariaDB
-- PHP Version: 7.3.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `doconcall`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctor_details`
--

CREATE TABLE `doctor_details` (
  `DID` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `password_hash` varchar(256) DEFAULT NULL,
  `salt` varchar(256) DEFAULT NULL,
  `contact1` varchar(255) DEFAULT NULL,
  `contact2` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `work_experience` int(11) DEFAULT NULL,
  `specialization_id` varchar(255) DEFAULT NULL,
  `designation_show` text,
  `price` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `email_id_optional` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `doctor_on_call_transaction`
--

CREATE TABLE `doctor_on_call_transaction` (
  `reference_id` varchar(255) DEFAULT NULL,
  `booking_id` varchar(255) DEFAULT NULL,
  `transaction_id` varchar(255) NOT NULL,
  `payment_request_id` varchar(255) DEFAULT NULL,
  `payment_status` varchar(255) NOT NULL,
  `payment_date` date DEFAULT NULL,
  `payment_time` time DEFAULT NULL,
  `payment_release_status` varchar(255) NOT NULL,
  `payment_request_date` date DEFAULT NULL,
  `payment_request_time` time DEFAULT NULL,
  `payment_request_info` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `doc_on_call_bookings`
--

CREATE TABLE `doc_on_call_bookings` (
  `booking_id` varchar(255) NOT NULL,
  `DID` varchar(255) DEFAULT NULL,
  `UID` varchar(255) DEFAULT NULL,
  `LID` varchar(255) DEFAULT NULL,
  `booking_date` date DEFAULT NULL,
  `booking_time` time DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `service_start_time` time DEFAULT NULL,
  `service_start_date` date DEFAULT NULL,
  `service_end_date` date DEFAULT NULL,
  `service_end_time` time DEFAULT NULL,
  `feedback_user` text,
  `feedback_doctor` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_address`
--

CREATE TABLE `user_address` (
  `LID` varchar(255) NOT NULL,
  `UID` varchar(255) DEFAULT NULL,
  `street_name` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `pincode` int(11) DEFAULT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `logitude` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

CREATE TABLE `user_details` (
  `UID` varchar(255) NOT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email_id` varchar(250) NOT NULL,
  `contact` bigint(11) DEFAULT NULL,
  `condition_acceptance` varchar(255) DEFAULT NULL,
  `blood_group` varchar(5) DEFAULT NULL,
  `Question_1` varchar(255) DEFAULT NULL,
  `Question_2` varchar(255) DEFAULT NULL,
  `Question_3` varchar(255) DEFAULT NULL,
  `Question_4` varchar(255) DEFAULT NULL,
  `user_status` varchar(50) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `password_hash` varchar(256) DEFAULT NULL,
  `salt` varchar(256) DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_details`
--

INSERT INTO `user_details` (`UID`, `first_name`, `last_name`, `email_id`, `contact`, `condition_acceptance`, `blood_group`, `Question_1`, `Question_2`, `Question_3`, `Question_4`, `user_status`, `dob`, `password_hash`, `salt`, `gender`) VALUES
('u2019', 'Rajarshee', 'Basu', 'b517031@iiit-bh.ac.in', 918240624256, 'yes', 'o', 'yes', 'yes', 'yes', 'yes', 'Active', '2000-02-18', '$2y$10$XjHMeSbnz8G6ktrRvnREO.eLgJxgoWSGzL2/2kvVLAf3EivI.GZaa', '91eb8d428b2c803b1b6436dab2e302ae50ca68dfad65c02cfb0c248f5255d983', 'male');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctor_details`
--
ALTER TABLE `doctor_details`
  ADD PRIMARY KEY (`DID`),
  ADD UNIQUE KEY `contact1` (`contact1`),
  ADD UNIQUE KEY `contact2` (`contact2`),
  ADD KEY `specialization_id` (`specialization_id`);

--
-- Indexes for table `doctor_on_call_transaction`
--
ALTER TABLE `doctor_on_call_transaction`
  ADD UNIQUE KEY `transaction_id` (`transaction_id`),
  ADD KEY `doctor_on_call_transaction_FK` (`booking_id`);

--
-- Indexes for table `doc_on_call_bookings`
--
ALTER TABLE `doc_on_call_bookings`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `DID` (`DID`),
  ADD KEY `UID` (`UID`),
  ADD KEY `LID` (`LID`);

--
-- Indexes for table `user_address`
--
ALTER TABLE `user_address`
  ADD PRIMARY KEY (`LID`),
  ADD KEY `UID` (`UID`);

--
-- Indexes for table `user_details`
--
ALTER TABLE `user_details`
  ADD PRIMARY KEY (`UID`,`email_id`),
  ADD UNIQUE KEY `contact` (`contact`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `doctor_on_call_transaction`
--
ALTER TABLE `doctor_on_call_transaction`
  ADD CONSTRAINT `doctor_on_call_transaction_FK` FOREIGN KEY (`booking_id`) REFERENCES `doc_on_call_bookings` (`booking_id`);

--
-- Constraints for table `doc_on_call_bookings`
--
ALTER TABLE `doc_on_call_bookings`
  ADD CONSTRAINT `doc_on_call_bookings_ibfk_1` FOREIGN KEY (`DID`) REFERENCES `doctor_details` (`DID`),
  ADD CONSTRAINT `doc_on_call_bookings_ibfk_2` FOREIGN KEY (`UID`) REFERENCES `user_details` (`UID`),
  ADD CONSTRAINT `doc_on_call_bookings_ibfk_3` FOREIGN KEY (`LID`) REFERENCES `user_address` (`LID`);

--
-- Constraints for table `user_address`
--
ALTER TABLE `user_address`
  ADD CONSTRAINT `user_address_ibfk_1` FOREIGN KEY (`UID`) REFERENCES `user_details` (`UID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
