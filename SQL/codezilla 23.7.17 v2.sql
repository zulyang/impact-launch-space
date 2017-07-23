-- phpMyAdmin SQL Dump
-- version 4.6.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 23, 2017 at 04:25 AM
-- Server version: 5.7.14
-- PHP Version: 5.6.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `codezilla`
--

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `username` varchar(30) NOT NULL,
  `password` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `keep_me_signed_in` tinyint(1) NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `user_type` varchar(15) NOT NULL,
  `login_attempts` int(1) NOT NULL,
  `user_role` varchar(250) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `password`, `email`, `keep_me_signed_in`, `enabled`, `user_type`, `login_attempts`, `user_role`) VALUES
('edwardfoo', '$2a$10$RGsvOPac2R66zS4bcwfeweTnA3dvH/hxabyB1Ma26ksdLn69QXn2m', 'helloiamedwardfoo@gmail.com', 0, 1, 'organization', 0, 'USER'),
('edward', '$2a$10$dNmHxjUt4UNZTeWcOhAsCulfO5IpCUOchCM0yGTY3OK5QhAV0lFEa', 'edward.foo.2015@sis.smu.edu.sg', 0, 1, 'individual', 0, 'USER'),
('edwardo', '$2a$10$BnZqkXW/G1vW3NfmfUpp9uTcmsNoar8O9e5upumkd//LYNVL.pS8i', 'edwardian157@gmail.com', 0, 1, 'organization', 0, 'USER'),
('zul', '$2a$10$3AbTcpN/nBNpb5fTXCQeReoT/rUmE/6A7ld14euQP/3RdD5vPZCvm', 'zulyang94@gmail.com', 0, 1, 'individual', 0, 'USER'),
('ed123!', '$2a$10$0RZQkRQQI9UyLU8M2kPal.rBiBWCFq4.BnYW8zw/EmTqKs1sFx476', 'edwardfoo@kpmg.com.sg', 0, 1, 'individual', 0, 'USER'),
('nigel', '$2a$10$37oL0FTS8PMM9fIN3Jp1g.ih0HIUnEgFu2g6KOrvPfYR3T7hFoIUO', 'nigelsmk@gmail.com', 0, 1, 'individual', 0, 'USER'),
('xiaowei', '$2a$10$s59j7xWvlT.MleKS7EhWWev0pHuSypX45qcG1yFfxezVjRRmB16WC', 'xiaowei.koh.2015@sis.smu.edu.sg', 0, 1, 'individual', 0, 'USER');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
