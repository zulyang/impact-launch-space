-- phpMyAdmin SQL Dump
-- version 4.5.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Sep 28, 2017 at 07:40 AM
-- Server version: 5.7.11
-- PHP Version: 5.6.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `impactlaunchspace`
--

-- --------------------------------------------------------

--
-- Table structure for table `board_change_log`
--

CREATE TABLE `board_change_log` (
  `id` int(11) NOT NULL,
  `log` text NOT NULL,
  `board_id` int(11) NOT NULL,
  `user` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `card_comment`
--

CREATE TABLE `card_comment` (
  `card_comment_id` int(11) NOT NULL,
  `card_id` int(11) NOT NULL,
  `comment` text NOT NULL,
  `user` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `card_documents`
--

CREATE TABLE `card_documents` (
  `card_id` int(11) NOT NULL,
  `document_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `countries_list`
--

CREATE TABLE `countries_list` (
  `country_code` varchar(2) NOT NULL,
  `country_name` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `countries_list`
--

INSERT INTO `countries_list` (`country_code`, `country_name`) VALUES
('AF', 'Afghanistan'),
('AL', 'Albania'),
('DZ', 'Algeria'),
('DS', 'American Samoa'),
('AD', 'Andorra'),
('AO', 'Angola'),
('AI', 'Anguilla'),
('AQ', 'Antarctica'),
('AG', 'Antigua and Barbuda'),
('AR', 'Argentina'),
('AM', 'Armenia'),
('AW', 'Aruba'),
('AU', 'Australia'),
('AT', 'Austria'),
('AZ', 'Azerbaijan'),
('BS', 'Bahamas'),
('BH', 'Bahrain'),
('BD', 'Bangladesh'),
('BB', 'Barbados'),
('BY', 'Belarus'),
('BE', 'Belgium'),
('BZ', 'Belize'),
('BJ', 'Benin'),
('BM', 'Bermuda'),
('BT', 'Bhutan'),
('BO', 'Bolivia'),
('BA', 'Bosnia and Herzegovina'),
('BW', 'Botswana'),
('BV', 'Bouvet Island'),
('BR', 'Brazil'),
('IO', 'British Indian Ocean Territory'),
('BN', 'Brunei Darussalam'),
('BG', 'Bulgaria'),
('BF', 'Burkina Faso'),
('BI', 'Burundi'),
('KH', 'Cambodia'),
('CM', 'Cameroon'),
('CA', 'Canada'),
('CV', 'Cape Verde'),
('KY', 'Cayman Islands'),
('CF', 'Central African Republic'),
('TD', 'Chad'),
('CL', 'Chile'),
('CN', 'China'),
('CX', 'Christmas Island'),
('CC', 'Cocos (Keeling) Islands'),
('CO', 'Colombia'),
('KM', 'Comoros'),
('CG', 'Congo'),
('CK', 'Cook Islands'),
('CR', 'Costa Rica'),
('HR', 'Croatia (Hrvatska)'),
('CU', 'Cuba'),
('CY', 'Cyprus'),
('CZ', 'Czech Republic'),
('DK', 'Denmark'),
('DJ', 'Djibouti'),
('DM', 'Dominica'),
('DO', 'Dominican Republic'),
('TP', 'East Timor'),
('EC', 'Ecuador'),
('EG', 'Egypt'),
('SV', 'El Salvador'),
('GQ', 'Equatorial Guinea'),
('ER', 'Eritrea'),
('EE', 'Estonia'),
('ET', 'Ethiopia'),
('FK', 'Falkland Islands (Malvinas)'),
('FO', 'Faroe Islands'),
('FJ', 'Fiji'),
('FI', 'Finland'),
('FR', 'France'),
('FX', 'France, Metropolitan'),
('GF', 'French Guiana'),
('PF', 'French Polynesia'),
('TF', 'French Southern Territories'),
('GA', 'Gabon'),
('GM', 'Gambia'),
('GE', 'Georgia'),
('DE', 'Germany'),
('GH', 'Ghana'),
('GI', 'Gibraltar'),
('GR', 'Greece'),
('GL', 'Greenland'),
('GD', 'Grenada'),
('GP', 'Guadeloupe'),
('GU', 'Guam'),
('GT', 'Guatemala'),
('GK', 'Guernsey'),
('GN', 'Guinea'),
('GW', 'Guinea-Bissau'),
('GY', 'Guyana'),
('HT', 'Haiti'),
('HM', 'Heard and Mc Donald Islands'),
('HN', 'Honduras'),
('HK', 'Hong Kong'),
('HU', 'Hungary'),
('IS', 'Iceland'),
('IN', 'India'),
('ID', 'Indonesia'),
('IR', 'Iran (Islamic Republic of)'),
('IQ', 'Iraq'),
('IE', 'Ireland'),
('IM', 'Isle of Man'),
('IL', 'Israel'),
('IT', 'Italy'),
('CI', 'Ivory Coast'),
('JM', 'Jamaica'),
('JP', 'Japan'),
('JE', 'Jersey'),
('JO', 'Jordan'),
('KZ', 'Kazakhstan'),
('KE', 'Kenya'),
('KI', 'Kiribati'),
('KP', 'Korea, Democratic People\'s Republic of'),
('KR', 'Korea, Republic of'),
('XK', 'Kosovo'),
('KW', 'Kuwait'),
('KG', 'Kyrgyzstan'),
('LA', 'Lao People\'s Democratic Republic'),
('LV', 'Latvia'),
('LB', 'Lebanon'),
('LS', 'Lesotho'),
('LR', 'Liberia'),
('LY', 'Libyan Arab Jamahiriya'),
('LI', 'Liechtenstein'),
('LT', 'Lithuania'),
('LU', 'Luxembourg'),
('MO', 'Macau'),
('MK', 'Macedonia'),
('MG', 'Madagascar'),
('MW', 'Malawi'),
('MY', 'Malaysia'),
('MV', 'Maldives'),
('ML', 'Mali'),
('MT', 'Malta'),
('MH', 'Marshall Islands'),
('MQ', 'Martinique'),
('MR', 'Mauritania'),
('MU', 'Mauritius'),
('TY', 'Mayotte'),
('MX', 'Mexico'),
('FM', 'Micronesia, Federated States of'),
('MD', 'Moldova, Republic of'),
('MC', 'Monaco'),
('MN', 'Mongolia'),
('ME', 'Montenegro'),
('MS', 'Montserrat'),
('MA', 'Morocco'),
('MZ', 'Mozambique'),
('MM', 'Myanmar'),
('NA', 'Namibia'),
('NR', 'Nauru'),
('NP', 'Nepal'),
('NL', 'Netherlands'),
('AN', 'Netherlands Antilles'),
('NC', 'New Caledonia'),
('NZ', 'New Zealand'),
('NI', 'Nicaragua'),
('NE', 'Niger'),
('NG', 'Nigeria'),
('NU', 'Niue'),
('NF', 'Norfolk Island'),
('MP', 'Northern Mariana Islands'),
('NO', 'Norway'),
('OM', 'Oman'),
('PK', 'Pakistan'),
('PW', 'Palau'),
('PS', 'Palestine'),
('PA', 'Panama'),
('PG', 'Papua New Guinea'),
('PY', 'Paraguay'),
('PE', 'Peru'),
('PH', 'Philippines'),
('PN', 'Pitcairn'),
('PL', 'Poland'),
('PT', 'Portugal'),
('PR', 'Puerto Rico'),
('QA', 'Qatar'),
('RE', 'Reunion'),
('RO', 'Romania'),
('RU', 'Russian Federation'),
('RW', 'Rwanda'),
('KN', 'Saint Kitts and Nevis'),
('LC', 'Saint Lucia'),
('VC', 'Saint Vincent and the Grenadines'),
('WS', 'Samoa'),
('SM', 'San Marino'),
('ST', 'Sao Tome and Principe'),
('SA', 'Saudi Arabia'),
('SN', 'Senegal'),
('RS', 'Serbia'),
('SC', 'Seychelles'),
('SL', 'Sierra Leone'),
('SG', 'Singapore'),
('SK', 'Slovakia'),
('SI', 'Slovenia'),
('SB', 'Solomon Islands'),
('SO', 'Somalia'),
('ZA', 'South Africa'),
('GS', 'South Georgia South Sandwich Islands'),
('ES', 'Spain'),
('LK', 'Sri Lanka'),
('SH', 'St. Helena'),
('PM', 'St. Pierre and Miquelon'),
('SD', 'Sudan'),
('SR', 'Suriname'),
('SJ', 'Svalbard and Jan Mayen Islands'),
('SZ', 'Swaziland'),
('SE', 'Sweden'),
('CH', 'Switzerland'),
('SY', 'Syrian Arab Republic'),
('TW', 'Taiwan'),
('TJ', 'Tajikistan'),
('TZ', 'Tanzania, United Republic of'),
('TH', 'Thailand'),
('TG', 'Togo'),
('TK', 'Tokelau'),
('TO', 'Tonga'),
('TT', 'Trinidad and Tobago'),
('TN', 'Tunisia'),
('TR', 'Turkey'),
('TM', 'Turkmenistan'),
('TC', 'Turks and Caicos Islands'),
('TV', 'Tuvalu'),
('UG', 'Uganda'),
('UA', 'Ukraine'),
('AE', 'United Arab Emirates'),
('GB', 'United Kingdom'),
('US', 'United States'),
('UM', 'United States minor outlying islands'),
('UY', 'Uruguay'),
('UZ', 'Uzbekistan'),
('VU', 'Vanuatu'),
('VA', 'Vatican City State'),
('VE', 'Venezuela'),
('VN', 'Vietnam'),
('VG', 'Virgin Islands (British)'),
('VI', 'Virgin Islands (U.S.)'),
('WF', 'Wallis and Futuna Islands'),
('EH', 'Western Sahara'),
('YE', 'Yemen'),
('ZR', 'Zaire'),
('ZM', 'Zambia'),
('ZW', 'Zimbabwe');

-- --------------------------------------------------------

--
-- Table structure for table `countries_of_operations`
--

CREATE TABLE `countries_of_operations` (
  `country_name` varchar(100) NOT NULL,
  `username` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `documents_individual`
--

CREATE TABLE `documents_individual` (
  `username` varchar(30) NOT NULL,
  `document` longblob NOT NULL,
  `document_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `documents_project`
--

CREATE TABLE `documents_project` (
  `project_name` varchar(100) NOT NULL,
  `project_proposer` varchar(30) NOT NULL,
  `document` longblob NOT NULL,
  `document_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `individual_accounts`
--

CREATE TABLE `individual_accounts` (
  `username` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `dateOfBirth` date NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `country` varchar(100) NOT NULL,
  `jobTitle` varchar(100) NOT NULL,
  `minimumVolunteerHours` int(3) NOT NULL,
  `maximumVolunteerHours` int(3) NOT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `isPublicProfile` tinyint(1) NOT NULL,
  `profilePicture` longblob,
  `personalBio` text,
  `contactDetails` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `job_sectors_individual`
--

CREATE TABLE `job_sectors_individual` (
  `job_sector` varchar(100) NOT NULL,
  `username` varchar(30) NOT NULL,
  `yearsOfExperience` int(2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `job_sectors_list`
--

CREATE TABLE `job_sectors_list` (
  `job_sector` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `job_sectors_list`
--

INSERT INTO `job_sectors_list` (`job_sector`) VALUES
('Aerospace'),
('Agriculture and fishing'),
('Computer and hardware'),
('Construction'),
('Education'),
('Energy'),
('Entertainment'),
('Financial services'),
('Food'),
('Health care and wellness'),
('Hospitality and leisure'),
('Information'),
('Manufacturing'),
('Mass media'),
('News'),
('Shipping'),
('Software industry'),
('Telecommunications'),
('Transport'),
('Water and utilities');

-- --------------------------------------------------------

--
-- Table structure for table `job_sectors_organization`
--

CREATE TABLE `job_sectors_organization` (
  `job_sector` varchar(100) NOT NULL,
  `username` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `recipient_username` varchar(30) NOT NULL,
  `sender_username` varchar(30) NOT NULL,
  `notification_subject` varchar(255) NOT NULL,
  `notification_message` text NOT NULL,
  `sent_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `isRead` tinyint(1) NOT NULL,
  `notification_type` varchar(30) NOT NULL,
  `copy_type` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `organization_accounts`
--

CREATE TABLE `organization_accounts` (
  `username` varchar(30) NOT NULL,
  `email` varchar(100) NOT NULL,
  `companyName` varchar(255) NOT NULL,
  `needsSupport` tinyint(1) NOT NULL,
  `offeringSupport` tinyint(1) NOT NULL,
  `profilePicture` longblob,
  `companyBio` text,
  `contactDetails` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `preferred_countries`
--

CREATE TABLE `preferred_countries` (
  `country_name` varchar(100) NOT NULL,
  `username` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `preferred_job_sectors`
--

CREATE TABLE `preferred_job_sectors` (
  `job_sector` varchar(100) NOT NULL,
  `username` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `preferred_project_areas`
--

CREATE TABLE `preferred_project_areas` (
  `project_area` varchar(100) NOT NULL,
  `username` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `projects`
--

CREATE TABLE `projects` (
  `project_name` varchar(100) NOT NULL,
  `description` text NOT NULL,
  `purpose` varchar(255) NOT NULL,
  `duration` int(11) NOT NULL,
  `location` varchar(100) NOT NULL,
  `project_proposer` varchar(30) NOT NULL,
  `organization` varchar(100) DEFAULT NULL,
  `isPublic` tinyint(1) NOT NULL,
  `hiddenToOutsiders` tinyint(1) NOT NULL,
  `hiddenToAll` tinyint(1) NOT NULL,
  `project_status` varchar(20) NOT NULL,
  `created_date` timestamp NULL DEFAULT NULL,
  `page_views` int(11) NOT NULL,
  `project_image` longblob,
  `project_video` varchar(100) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `project_areas`
--

CREATE TABLE `project_areas` (
  `project_area` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `project_areas`
--

INSERT INTO `project_areas` (`project_area`) VALUES
('Agriculture'),
('Animal welfare'),
('Arts and culture'),
('Childrens support'),
('Construction'),
('Crowdfunding'),
('Education'),
('Elder care'),
('Environment'),
('Fishing'),
('Forestry'),
('Fundraising'),
('Health'),
('Sports'),
('Technology'),
('Water'),
('Wellbeing'),
('Womens support');

-- --------------------------------------------------------

--
-- Table structure for table `project_ban_list`
--

CREATE TABLE `project_ban_list` (
  `project_name` varchar(100) NOT NULL,
  `banned_username` varchar(100) NOT NULL,
  `project_proposer` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `project_board`
--

CREATE TABLE `project_board` (
  `board_id` int(11) NOT NULL,
  `project_name` varchar(100) NOT NULL,
  `project_proposer` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `project_card`
--

CREATE TABLE `project_card` (
  `card_id` int(11) NOT NULL,
  `board_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` text,
  `owner` varchar(30) NOT NULL,
  `assignee` varchar(30) DEFAULT NULL,
  `date_created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tags` varchar(50) DEFAULT NULL,
  `card_status` varchar(30) NOT NULL,
  `card_order` int(11) NOT NULL,
  `start_date` date DEFAULT NULL,
  `due_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `project_member_list`
--

CREATE TABLE `project_member_list` (
  `project_name` varchar(100) NOT NULL,
  `project_proposer` varchar(30) NOT NULL,
  `project_member_username` varchar(100) NOT NULL,
  `project_role` varchar(100) NOT NULL,
  `joined_timestamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `project_requested_resources`
--

CREATE TABLE `project_requested_resources` (
  `project_name` varchar(100) NOT NULL,
  `resource_category` varchar(100) NOT NULL,
  `resource_name` varchar(100) NOT NULL,
  `request_description` text NOT NULL,
  `project_proposer` varchar(30) NOT NULL,
  `confirmed_offerer` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `project_resource_categories`
--

CREATE TABLE `project_resource_categories` (
  `project_name` varchar(100) NOT NULL,
  `resource_category` varchar(100) NOT NULL,
  `project_proposer` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `project_target_areas`
--

CREATE TABLE `project_target_areas` (
  `project_name` varchar(100) NOT NULL,
  `project_area` varchar(100) NOT NULL,
  `project_proposer` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `project_updates`
--

CREATE TABLE `project_updates` (
  `project_name` varchar(100) NOT NULL,
  `project_proposer` varchar(100) NOT NULL,
  `update_id` int(11) NOT NULL,
  `update_title` longtext NOT NULL,
  `update_contents` longtext NOT NULL,
  `posted_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `project_user_requests`
--

CREATE TABLE `project_user_requests` (
  `project_name` varchar(100) NOT NULL,
  `requested_resource_category` varchar(100) NOT NULL,
  `requested_resource_name` varchar(100) NOT NULL,
  `project_proposer` varchar(100) NOT NULL,
  `resource_offerer` varchar(30) NOT NULL,
  `offered_resource_category` varchar(100) NOT NULL,
  `offered_resource_name` varchar(100) NOT NULL,
  `offered_request_description` varchar(100) NOT NULL,
  `offer_comments` text NOT NULL,
  `request_status` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `remember_me_cookies`
--

CREATE TABLE `remember_me_cookies` (
  `username` varchar(250) NOT NULL,
  `secret` varchar(250) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `reset_tokens`
--

CREATE TABLE `reset_tokens` (
  `reset_code` varchar(100) NOT NULL,
  `username` varchar(30) NOT NULL,
  `expiry_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `skillset_list`
--

CREATE TABLE `skillset_list` (
  `skillset` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `skillset_list`
--

INSERT INTO `skillset_list` (`skillset`) VALUES
('Accounting'),
('Branding'),
('Business Development'),
('Coaching'),
('Communications'),
('Data Analysis'),
('Digital Marketing'),
('Engineering'),
('Entrepreneurship'),
('Finance'),
('Fundraising'),
('Graphic Design'),
('Human Resources'),
('Information Technology'),
('Legal'),
('Management'),
('Marketing'),
('Miscellaneous'),
('Photography & Video'),
('Public Relations'),
('Research'),
('Social Media'),
('Strategy Consulting'),
('Web Design'),
('Web Development'),
('Writing');

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_offered_resources`
--

CREATE TABLE `user_offered_resources` (
  `username` varchar(30) NOT NULL,
  `resource_category` varchar(100) NOT NULL,
  `resource_name` varchar(100) NOT NULL,
  `request_description` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_skills`
--

CREATE TABLE `user_skills` (
  `skillset` varchar(100) NOT NULL,
  `username` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `verification_tokens`
--

CREATE TABLE `verification_tokens` (
  `verification_code` varchar(100) NOT NULL,
  `username` varchar(30) NOT NULL,
  `expiry_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `board_change_log`
--
ALTER TABLE `board_change_log`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `card_comment`
--
ALTER TABLE `card_comment`
  ADD PRIMARY KEY (`card_comment_id`);

--
-- Indexes for table `card_documents`
--
ALTER TABLE `card_documents`
  ADD PRIMARY KEY (`card_id`,`document_name`);

--
-- Indexes for table `countries_list`
--
ALTER TABLE `countries_list`
  ADD PRIMARY KEY (`country_name`);

--
-- Indexes for table `countries_of_operations`
--
ALTER TABLE `countries_of_operations`
  ADD PRIMARY KEY (`country_name`,`username`),
  ADD KEY `countries_of_operations_fk` (`username`);

--
-- Indexes for table `documents_individual`
--
ALTER TABLE `documents_individual`
  ADD PRIMARY KEY (`username`,`document_name`);

--
-- Indexes for table `documents_project`
--
ALTER TABLE `documents_project`
  ADD PRIMARY KEY (`project_name`,`project_proposer`,`document_name`),
  ADD KEY `documents_project_fk2` (`project_name`),
  ADD KEY `documents_project_fk3` (`project_proposer`);

--
-- Indexes for table `individual_accounts`
--
ALTER TABLE `individual_accounts`
  ADD PRIMARY KEY (`username`),
  ADD KEY `individual_accounts_fk2` (`email`);

--
-- Indexes for table `job_sectors_individual`
--
ALTER TABLE `job_sectors_individual`
  ADD PRIMARY KEY (`job_sector`,`username`,`yearsOfExperience`),
  ADD KEY `job_sectors_organization_fk` (`username`);

--
-- Indexes for table `job_sectors_list`
--
ALTER TABLE `job_sectors_list`
  ADD PRIMARY KEY (`job_sector`);

--
-- Indexes for table `job_sectors_organization`
--
ALTER TABLE `job_sectors_organization`
  ADD PRIMARY KEY (`job_sector`,`username`),
  ADD KEY `job_sectors_organization_fk` (`username`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`recipient_username`,`sender_username`,`notification_subject`,`sent_time`,`copy_type`),
  ADD KEY `notifications_fk2` (`sender_username`);

--
-- Indexes for table `organization_accounts`
--
ALTER TABLE `organization_accounts`
  ADD PRIMARY KEY (`username`),
  ADD UNIQUE KEY `companyName` (`companyName`),
  ADD KEY `organization_accounts_fk2` (`email`);

--
-- Indexes for table `preferred_countries`
--
ALTER TABLE `preferred_countries`
  ADD PRIMARY KEY (`country_name`,`username`),
  ADD KEY `preferred_countries_fk` (`country_name`),
  ADD KEY `preferred_countries_fk2` (`username`);

--
-- Indexes for table `preferred_job_sectors`
--
ALTER TABLE `preferred_job_sectors`
  ADD PRIMARY KEY (`job_sector`,`username`),
  ADD KEY `job_sectors_organization_fk` (`username`);

--
-- Indexes for table `preferred_project_areas`
--
ALTER TABLE `preferred_project_areas`
  ADD PRIMARY KEY (`project_area`,`username`),
  ADD KEY `organization_accounts_fk` (`project_area`),
  ADD KEY `organization_accounts_fk2` (`username`);

--
-- Indexes for table `projects`
--
ALTER TABLE `projects`
  ADD PRIMARY KEY (`project_name`,`project_proposer`),
  ADD KEY `projects_fk2` (`project_proposer`),
  ADD KEY `projects_fk3` (`location`);

--
-- Indexes for table `project_areas`
--
ALTER TABLE `project_areas`
  ADD PRIMARY KEY (`project_area`);

--
-- Indexes for table `project_ban_list`
--
ALTER TABLE `project_ban_list`
  ADD PRIMARY KEY (`project_name`,`banned_username`,`project_proposer`),
  ADD KEY `project_ban_list_fk1` (`banned_username`);

--
-- Indexes for table `project_board`
--
ALTER TABLE `project_board`
  ADD PRIMARY KEY (`board_id`);

--
-- Indexes for table `project_card`
--
ALTER TABLE `project_card`
  ADD PRIMARY KEY (`card_id`);

--
-- Indexes for table `project_member_list`
--
ALTER TABLE `project_member_list`
  ADD PRIMARY KEY (`project_name`,`project_proposer`,`project_member_username`),
  ADD KEY `project_member_list_fk2` (`project_proposer`),
  ADD KEY `project_member_list_fk3` (`project_member_username`);

--
-- Indexes for table `project_requested_resources`
--
ALTER TABLE `project_requested_resources`
  ADD PRIMARY KEY (`project_name`,`resource_category`,`resource_name`,`project_proposer`),
  ADD KEY `project_requested_resources_fk2` (`resource_category`);

--
-- Indexes for table `project_resource_categories`
--
ALTER TABLE `project_resource_categories`
  ADD PRIMARY KEY (`project_name`,`resource_category`,`project_proposer`),
  ADD KEY `project_resource_categories_fk2` (`resource_category`);

--
-- Indexes for table `project_target_areas`
--
ALTER TABLE `project_target_areas`
  ADD PRIMARY KEY (`project_name`,`project_area`,`project_proposer`),
  ADD KEY `project_target_areas_fk2` (`project_area`);

--
-- Indexes for table `project_updates`
--
ALTER TABLE `project_updates`
  ADD PRIMARY KEY (`update_id`),
  ADD KEY `project_updates_fk1` (`project_name`),
  ADD KEY `project_updates_fk2` (`project_proposer`);

--
-- Indexes for table `project_user_requests`
--
ALTER TABLE `project_user_requests`
  ADD PRIMARY KEY (`project_name`,`requested_resource_category`,`requested_resource_name`,`project_proposer`,`resource_offerer`,`offered_resource_category`,`offered_resource_name`),
  ADD KEY `project_user_requests_fk2` (`project_proposer`),
  ADD KEY `project_user_requests_fk3` (`requested_resource_category`),
  ADD KEY `project_user_requests_fk4` (`requested_resource_name`),
  ADD KEY `project_user_requests_fk5` (`resource_offerer`),
  ADD KEY `project_user_requests_fk6` (`offered_resource_category`),
  ADD KEY `project_user_requests_fk7` (`offered_resource_name`),
  ADD KEY `project_user_requests_fk8` (`offered_request_description`);

--
-- Indexes for table `reset_tokens`
--
ALTER TABLE `reset_tokens`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `skillset_list`
--
ALTER TABLE `skillset_list`
  ADD PRIMARY KEY (`skillset`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `user_offered_resources`
--
ALTER TABLE `user_offered_resources`
  ADD PRIMARY KEY (`username`,`resource_category`,`resource_name`),
  ADD KEY `user_offered_resources_fk` (`username`),
  ADD KEY `user_offered_resources_fk2` (`resource_category`);

--
-- Indexes for table `user_skills`
--
ALTER TABLE `user_skills`
  ADD PRIMARY KEY (`skillset`,`username`),
  ADD KEY `user_skills_fk` (`username`);

--
-- Indexes for table `verification_tokens`
--
ALTER TABLE `verification_tokens`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `board_change_log`
--
ALTER TABLE `board_change_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=124;
--
-- AUTO_INCREMENT for table `card_comment`
--
ALTER TABLE `card_comment`
  MODIFY `card_comment_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `project_board`
--
ALTER TABLE `project_board`
  MODIFY `board_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `project_card`
--
ALTER TABLE `project_card`
  MODIFY `card_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
--
-- AUTO_INCREMENT for table `project_updates`
--
ALTER TABLE `project_updates`
  MODIFY `update_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
