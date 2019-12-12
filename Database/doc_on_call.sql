-- phpMyAdmin SQL Dump
-- version 4.8.5
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Dec 12, 2019 at 04:21 PM
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
-- Database: `app`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctor_details`
--

CREATE TABLE `doctor_details` (
  `DID` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email_id` varchar(255) NOT NULL,
  `contact1` varchar(255) NOT NULL,
  `contact2` varchar(255) DEFAULT NULL,
  `dob` date NOT NULL,
  `work_experience` int(11) NOT NULL,
  `specialization_id` varchar(255) NOT NULL,
  `designation_show` text NOT NULL,
  `price` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `gender` varchar(20) NOT NULL,
  `email_id_optional` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `doctor_details`
--

INSERT INTO `doctor_details` (`DID`, `first_name`, `last_name`, `email_id`, `contact1`, `contact2`, `dob`, `work_experience`, `specialization_id`, `designation_show`, `price`, `rating`, `gender`, `email_id_optional`) VALUES
('2019DR0001', 'Bishnu Prasad', 'Patro', 'bishnu@gmail.com', '1234567890', '1234567890', '2019-08-05', 5, 'SPTY000001', 'MBBS MS ORTHOPEDIC', 2000, 5, 'M', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `doctor_on_call_transaction`
--

CREATE TABLE `doctor_on_call_transaction` (
  `reference_id` varchar(255) DEFAULT NULL,
  `booking_id` varchar(255) DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
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
  `booking_date` date NOT NULL,
  `booking_time` time NOT NULL,
  `amount` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
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
  `UID` varchar(255) NOT NULL,
  `street_name` varchar(255) NOT NULL,
  `city` varchar(255) NOT NULL,
  `state` varchar(255) NOT NULL,
  `pincode` int(11) NOT NULL,
  `latitude` varchar(255) DEFAULT NULL,
  `logitude` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_details`
--

CREATE TABLE `user_details` (
  `UID` varchar(255) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `email_id` text NOT NULL,
  `contact` bigint(11) NOT NULL,
  `condition_acceptance` varchar(255) NOT NULL,
  `blood_group` varchar(5) NOT NULL,
  `Question_1` varchar(255) NOT NULL,
  `Question_2` varchar(255) NOT NULL,
  `Question_3` varchar(255) NOT NULL,
  `Question_4` varchar(255) NOT NULL,
  `user_status` varchar(50) NOT NULL,
  `dob` date NOT NULL,
  `gender` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_details`
--

INSERT INTO `user_details` (`UID`, `first_name`, `last_name`, `email_id`, `contact`, `condition_acceptance`, `blood_group`, `Question_1`, `Question_2`, `Question_3`, `Question_4`, `user_status`, `dob`, `gender`) VALUES
('2019US1', 'Kaushik', 'Subudhi', 'kkaushiksubudhi@gmail.com', 9040888404, 'accepted', 'O+', 'yes', 'yes', 'yes', 'yes', 'active', '1995-12-22', 'Male');

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
  ADD PRIMARY KEY (`UID`,`email_id`(255)),
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
