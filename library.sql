-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 21, 2021 at 01:04 PM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library`
--

-- --------------------------------------------------------

--
-- Table structure for table `book`
--

CREATE TABLE `book` (
  `ISBN` int(11) NOT NULL,
  `Title` varchar(50) DEFAULT NULL,
  `Author` varchar(50) DEFAULT NULL,
  `Area_Of_Subject` varchar(50) DEFAULT NULL,
  `Added_By_SSN` int(11) DEFAULT NULL,
  `Added_On` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `book`
--

INSERT INTO `book` (`ISBN`, `Title`, `Author`, `Area_Of_Subject`, `Added_By_SSN`, `Added_On`) VALUES
(45467777, 'The Crow', 'A N Other', 'A story about crows and more crows...', 1, '2021-11-09'),
(373728283, 'The Last Man', 'The Man', 'A man was left back and he was the last man', 1, '2021-11-02'),
(748493939, 'The Witcher', 'Some Guy', 'Alot of creepy stuff', 1, '2021-11-08');

-- --------------------------------------------------------

--
-- Table structure for table `borrow`
--

CREATE TABLE `borrow` (
  `id` int(11) NOT NULL,
  `Member_SSN` int(11) NOT NULL,
  `Book_ISBN` int(11) NOT NULL,
  `Issued_By_SSN` int(11) NOT NULL,
  `Issue_Date` date NOT NULL,
  `Grace_Period` int(11) DEFAULT NULL,
  `Date_Of_Returrn` date DEFAULT NULL,
  `Returned_Or_Not` varchar(20) DEFAULT NULL,
  `Returned_By_SSN` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `borrow`
--

INSERT INTO `borrow` (`id`, `Member_SSN`, `Book_ISBN`, `Issued_By_SSN`, `Issue_Date`, `Grace_Period`, `Date_Of_Returrn`, `Returned_Or_Not`, `Returned_By_SSN`) VALUES
(1, 2, 45467777, 3, '2021-11-08', 5, '2021-11-11', 'True', 2),
(2, 2, 748493939, 3, '2021-11-09', 4, '2021-11-14', 'True', 3),
(3, 1, 45467777, 1, '2021-11-23', 8, '2021-11-26', 'True', 3);

-- --------------------------------------------------------

--
-- Table structure for table `cannot_lend`
--

CREATE TABLE `cannot_lend` (
  `Book_ISBN` int(11) NOT NULL,
  `Type` varchar(250) DEFAULT NULL,
  `Total_Count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `can_lend`
--

CREATE TABLE `can_lend` (
  `Book_ISBN` int(11) NOT NULL,
  `Borrowed_Count` int(11) DEFAULT NULL,
  `Available_Count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `general_member`
--

CREATE TABLE `general_member` (
  `Member_SSN` int(11) NOT NULL,
  `House_Address` varchar(300) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `librarian`
--

CREATE TABLE `librarian` (
  `SSN` int(11) NOT NULL,
  `name` varchar(60) DEFAULT NULL,
  `Phone_Number` varchar(15) DEFAULT NULL,
  `Designation` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `librarian`
--

INSERT INTO `librarian` (`SSN`, `name`, `Phone_Number`, `Designation`) VALUES
(1, 'Hillary Clinton', '+16272889919', 'Mrs'),
(2, 'Yellow Juice', '+1223444455', 'Mrs'),
(3, 'Nandalal Bose', '+21111111111', 'Mr');

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `SSN` int(11) NOT NULL,
  `Campus_Addr` varchar(300) DEFAULT NULL,
  `Phone_Number` varchar(15) DEFAULT NULL,
  `CardCreated_By_SSN` int(11) DEFAULT NULL,
  `Card_Number` int(11) DEFAULT NULL,
  `Name_On_Card` varchar(300) DEFAULT NULL,
  `Date_Of_Issue` date DEFAULT NULL,
  `Date_Of_Expiry` date DEFAULT NULL,
  `Added_On` date DEFAULT NULL,
  `Added_By_SSN` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`SSN`, `Campus_Addr`, `Phone_Number`, `CardCreated_By_SSN`, `Card_Number`, `Name_On_Card`, `Date_Of_Issue`, `Date_Of_Expiry`, `Added_On`, `Added_By_SSN`) VALUES
(1, '149 Turbo', '+23329999292929', 2, 2147483647, 'Mk Terry', '2021-11-04', '2022-01-27', '2021-09-30', 1),
(2, '67 Hill', '+1311318999', 2, 21212323, 'John F K', '2021-11-05', '2021-12-08', '2021-11-05', 1);

-- --------------------------------------------------------

--
-- Table structure for table `professor_member`
--

CREATE TABLE `professor_member` (
  `Member_SSN` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `remark`
--

CREATE TABLE `remark` (
  `Member_SSN` int(11) NOT NULL,
  `Issued_By_SSN` int(11) DEFAULT NULL,
  `Issue_Date` date NOT NULL,
  `Message` varchar(400) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `to_acquire`
--

CREATE TABLE `to_acquire` (
  `Book_ISBN` int(11) NOT NULL,
  `Reason` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `within_library`
--

CREATE TABLE `within_library` (
  `Book_ISBN` int(11) NOT NULL,
  `Book_Description` varchar(1500) DEFAULT NULL,
  `Binding` varchar(250) DEFAULT NULL,
  `Edition` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `book`
--
ALTER TABLE `book`
  ADD PRIMARY KEY (`ISBN`),
  ADD KEY `Added_By_SSN` (`Added_By_SSN`);

--
-- Indexes for table `borrow`
--
ALTER TABLE `borrow`
  ADD PRIMARY KEY (`id`),
  ADD KEY `Member_SSN` (`Member_SSN`),
  ADD KEY `Book_ISBN` (`Book_ISBN`),
  ADD KEY `Issued_By_SSN` (`Issued_By_SSN`),
  ADD KEY `Returned_By_SSN` (`Returned_By_SSN`);

--
-- Indexes for table `cannot_lend`
--
ALTER TABLE `cannot_lend`
  ADD PRIMARY KEY (`Book_ISBN`);

--
-- Indexes for table `can_lend`
--
ALTER TABLE `can_lend`
  ADD PRIMARY KEY (`Book_ISBN`);

--
-- Indexes for table `general_member`
--
ALTER TABLE `general_member`
  ADD PRIMARY KEY (`Member_SSN`);

--
-- Indexes for table `librarian`
--
ALTER TABLE `librarian`
  ADD PRIMARY KEY (`SSN`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`SSN`),
  ADD KEY `CardCreated_By_SSN` (`CardCreated_By_SSN`),
  ADD KEY `Added_By_SSN` (`Added_By_SSN`);

--
-- Indexes for table `professor_member`
--
ALTER TABLE `professor_member`
  ADD PRIMARY KEY (`Member_SSN`);

--
-- Indexes for table `remark`
--
ALTER TABLE `remark`
  ADD PRIMARY KEY (`Member_SSN`,`Issue_Date`),
  ADD KEY `Issued_By_SSN` (`Issued_By_SSN`);

--
-- Indexes for table `to_acquire`
--
ALTER TABLE `to_acquire`
  ADD PRIMARY KEY (`Book_ISBN`);

--
-- Indexes for table `within_library`
--
ALTER TABLE `within_library`
  ADD PRIMARY KEY (`Book_ISBN`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `borrow`
--
ALTER TABLE `borrow`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `librarian`
--
ALTER TABLE `librarian`
  MODIFY `SSN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `SSN` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `book`
--
ALTER TABLE `book`
  ADD CONSTRAINT `book_ibfk_1` FOREIGN KEY (`Added_By_SSN`) REFERENCES `librarian` (`SSN`);

--
-- Constraints for table `borrow`
--
ALTER TABLE `borrow`
  ADD CONSTRAINT `borrow_ibfk_1` FOREIGN KEY (`Member_SSN`) REFERENCES `members` (`SSN`),
  ADD CONSTRAINT `borrow_ibfk_2` FOREIGN KEY (`Book_ISBN`) REFERENCES `book` (`ISBN`),
  ADD CONSTRAINT `borrow_ibfk_3` FOREIGN KEY (`Issued_By_SSN`) REFERENCES `librarian` (`SSN`),
  ADD CONSTRAINT `borrow_ibfk_4` FOREIGN KEY (`Returned_By_SSN`) REFERENCES `librarian` (`SSN`);

--
-- Constraints for table `cannot_lend`
--
ALTER TABLE `cannot_lend`
  ADD CONSTRAINT `cannot_lend_ibfk_1` FOREIGN KEY (`Book_ISBN`) REFERENCES `within_library` (`Book_ISBN`);

--
-- Constraints for table `can_lend`
--
ALTER TABLE `can_lend`
  ADD CONSTRAINT `can_lend_ibfk_1` FOREIGN KEY (`Book_ISBN`) REFERENCES `within_library` (`Book_ISBN`);

--
-- Constraints for table `general_member`
--
ALTER TABLE `general_member`
  ADD CONSTRAINT `general_member_ibfk_1` FOREIGN KEY (`Member_SSN`) REFERENCES `members` (`SSN`);

--
-- Constraints for table `members`
--
ALTER TABLE `members`
  ADD CONSTRAINT `members_ibfk_1` FOREIGN KEY (`CardCreated_By_SSN`) REFERENCES `librarian` (`SSN`),
  ADD CONSTRAINT `members_ibfk_2` FOREIGN KEY (`Added_By_SSN`) REFERENCES `librarian` (`SSN`);

--
-- Constraints for table `professor_member`
--
ALTER TABLE `professor_member`
  ADD CONSTRAINT `professor_member_ibfk_1` FOREIGN KEY (`Member_SSN`) REFERENCES `members` (`SSN`);

--
-- Constraints for table `remark`
--
ALTER TABLE `remark`
  ADD CONSTRAINT `remark_ibfk_1` FOREIGN KEY (`Member_SSN`) REFERENCES `members` (`SSN`),
  ADD CONSTRAINT `remark_ibfk_2` FOREIGN KEY (`Issued_By_SSN`) REFERENCES `librarian` (`SSN`);

--
-- Constraints for table `to_acquire`
--
ALTER TABLE `to_acquire`
  ADD CONSTRAINT `to_acquire_ibfk_1` FOREIGN KEY (`Book_ISBN`) REFERENCES `book` (`ISBN`);

--
-- Constraints for table `within_library`
--
ALTER TABLE `within_library`
  ADD CONSTRAINT `within_library_ibfk_1` FOREIGN KEY (`Book_ISBN`) REFERENCES `book` (`ISBN`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
