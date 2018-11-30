-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 30, 2018 at 12:20 PM
-- Server version: 5.6.41
-- PHP Version: 7.2.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gurpreet_jobposting`
--

DELIMITER $$
--
-- Functions
--
CREATE DEFINER=`gurpreet`@`localhost` FUNCTION `get_distance_in_miles_between_geo_locations` (`geo1_latitude` DECIMAL(10,6), `geo1_longitude` DECIMAL(10,6), `geo2_latitude` DECIMAL(10,6), `geo2_longitude` DECIMAL(10,6)) RETURNS DECIMAL(10,3) BEGIN
return ((ACOS(SIN(geo1_latitude * PI() / 180) * SIN(geo2_latitude * PI() / 180) + COS(geo1_latitude * PI() / 180) * COS(geo2_latitude * PI() / 180) * COS((geo1_longitude - geo2_longitude) * PI() / 180)) * 180 / PI()) * 60 * 1.1515);
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1 ROW_FORMAT=COMPACT;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `status`, `created`) VALUES
(1, 'Driver', 1, '2018-10-10 11:00:43'),
(2, 'Carpenter', 1, '2018-10-10 11:16:04'),
(3, 'Painter', 1, '2018-10-10 11:19:09'),
(4, 'Welder', 1, '2018-10-10 11:31:23'),
(5, 'Technician', 1, '2018-10-10 11:32:01');

-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE `countries` (
  `country_id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `iso_code_2` varchar(2) NOT NULL,
  `iso_code_3` varchar(3) NOT NULL,
  `address_format` text NOT NULL,
  `postcode_required` tinyint(1) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`country_id`, `name`, `iso_code_2`, `iso_code_3`, `address_format`, `postcode_required`, `status`) VALUES
(1, 'Afghanistan', 'AF', 'AFG', '', 0, 1),
(2, 'Albania', 'AL', 'ALB', '', 0, 1),
(3, 'Algeria', 'DZ', 'DZA', '', 0, 1),
(4, 'American Samoa', 'AS', 'ASM', '', 0, 1),
(5, 'Andorra', 'AD', 'AND', '', 0, 1),
(6, 'Angola', 'AO', 'AGO', '', 0, 1),
(7, 'Anguilla', 'AI', 'AIA', '', 0, 1),
(8, 'Antarctica', 'AQ', 'ATA', '', 0, 1),
(9, 'Antigua and Barbuda', 'AG', 'ATG', '', 0, 1),
(10, 'Argentina', 'AR', 'ARG', '', 0, 1),
(11, 'Armenia', 'AM', 'ARM', '', 0, 1),
(12, 'Aruba', 'AW', 'ABW', '', 0, 1),
(13, 'Australia', 'AU', 'AUS', '', 0, 1),
(14, 'Austria', 'AT', 'AUT', '', 0, 1),
(15, 'Azerbaijan', 'AZ', 'AZE', '', 0, 1),
(16, 'Bahamas', 'BS', 'BHS', '', 0, 1),
(17, 'Bahrain', 'BH', 'BHR', '', 0, 1),
(18, 'Bangladesh', 'BD', 'BGD', '', 0, 1),
(19, 'Barbados', 'BB', 'BRB', '', 0, 1),
(20, 'Belarus', 'BY', 'BLR', '', 0, 1),
(21, 'Belgium', 'BE', 'BEL', '{firstname} {lastname}\r\n{company}\r\n{address_1}\r\n{address_2}\r\n{postcode} {city}\r\n{country}', 0, 1),
(22, 'Belize', 'BZ', 'BLZ', '', 0, 1),
(23, 'Benin', 'BJ', 'BEN', '', 0, 1),
(24, 'Bermuda', 'BM', 'BMU', '', 0, 1),
(25, 'Bhutan', 'BT', 'BTN', '', 0, 1),
(26, 'Bolivia', 'BO', 'BOL', '', 0, 1),
(27, 'Bosnia and Herzegovina', 'BA', 'BIH', '', 0, 1),
(28, 'Botswana', 'BW', 'BWA', '', 0, 1),
(29, 'Bouvet Island', 'BV', 'BVT', '', 0, 1),
(30, 'Brazil', 'BR', 'BRA', '', 0, 1),
(31, 'British Indian Ocean Territory', 'IO', 'IOT', '', 0, 1),
(32, 'Brunei Darussalam', 'BN', 'BRN', '', 0, 1),
(33, 'Bulgaria', 'BG', 'BGR', '', 0, 1),
(34, 'Burkina Faso', 'BF', 'BFA', '', 0, 1),
(35, 'Burundi', 'BI', 'BDI', '', 0, 1),
(36, 'Cambodia', 'KH', 'KHM', '', 0, 1),
(37, 'Cameroon', 'CM', 'CMR', '', 0, 1),
(38, 'Canada', 'CA', 'CAN', '', 0, 1),
(39, 'Cape Verde', 'CV', 'CPV', '', 0, 1),
(40, 'Cayman Islands', 'KY', 'CYM', '', 0, 1),
(41, 'Central African Republic', 'CF', 'CAF', '', 0, 1),
(42, 'Chad', 'TD', 'TCD', '', 0, 1),
(43, 'Chile', 'CL', 'CHL', '', 0, 1),
(44, 'China', 'CN', 'CHN', '', 0, 1),
(45, 'Christmas Island', 'CX', 'CXR', '', 0, 1),
(46, 'Cocos (Keeling) Islands', 'CC', 'CCK', '', 0, 1),
(47, 'Colombia', 'CO', 'COL', '', 0, 1),
(48, 'Comoros', 'KM', 'COM', '', 0, 1),
(49, 'Congo', 'CG', 'COG', '', 0, 1),
(50, 'Cook Islands', 'CK', 'COK', '', 0, 1),
(51, 'Costa Rica', 'CR', 'CRI', '', 0, 1),
(52, 'Cote D\'Ivoire', 'CI', 'CIV', '', 0, 1),
(53, 'Croatia', 'HR', 'HRV', '', 0, 1),
(54, 'Cuba', 'CU', 'CUB', '', 0, 1),
(55, 'Cyprus', 'CY', 'CYP', '', 0, 1),
(56, 'Czech Republic', 'CZ', 'CZE', '', 0, 1),
(57, 'Denmark', 'DK', 'DNK', '', 0, 1),
(58, 'Djibouti', 'DJ', 'DJI', '', 0, 1),
(59, 'Dominica', 'DM', 'DMA', '', 0, 1),
(60, 'Dominican Republic', 'DO', 'DOM', '', 0, 1),
(61, 'East Timor', 'TL', 'TLS', '', 0, 1),
(62, 'Ecuador', 'EC', 'ECU', '', 0, 1),
(63, 'Egypt', 'EG', 'EGY', '', 0, 1),
(64, 'El Salvador', 'SV', 'SLV', '', 0, 1),
(65, 'Equatorial Guinea', 'GQ', 'GNQ', '', 0, 1),
(66, 'Eritrea', 'ER', 'ERI', '', 0, 1),
(67, 'Estonia', 'EE', 'EST', '', 0, 1),
(68, 'Ethiopia', 'ET', 'ETH', '', 0, 1),
(69, 'Falkland Islands (Malvinas)', 'FK', 'FLK', '', 0, 1),
(70, 'Faroe Islands', 'FO', 'FRO', '', 0, 1),
(71, 'Fiji', 'FJ', 'FJI', '', 0, 1),
(72, 'Finland', 'FI', 'FIN', '', 0, 1),
(74, 'France, Metropolitan', 'FR', 'FRA', '{firstname} {lastname}\r\n{company}\r\n{address_1}\r\n{address_2}\r\n{postcode} {city}\r\n{country}', 1, 1),
(75, 'French Guiana', 'GF', 'GUF', '', 0, 1),
(76, 'French Polynesia', 'PF', 'PYF', '', 0, 1),
(77, 'French Southern Territories', 'TF', 'ATF', '', 0, 1),
(78, 'Gabon', 'GA', 'GAB', '', 0, 1),
(79, 'Gambia', 'GM', 'GMB', '', 0, 1),
(80, 'Georgia', 'GE', 'GEO', '', 0, 1),
(81, 'Germany', 'DE', 'DEU', '{company}\r\n{firstname} {lastname}\r\n{address_1}\r\n{address_2}\r\n{postcode} {city}\r\n{country}', 1, 1),
(82, 'Ghana', 'GH', 'GHA', '', 0, 1),
(83, 'Gibraltar', 'GI', 'GIB', '', 0, 1),
(84, 'Greece', 'GR', 'GRC', '', 0, 1),
(85, 'Greenland', 'GL', 'GRL', '', 0, 1),
(86, 'Grenada', 'GD', 'GRD', '', 0, 1),
(87, 'Guadeloupe', 'GP', 'GLP', '', 0, 1),
(88, 'Guam', 'GU', 'GUM', '', 0, 1),
(89, 'Guatemala', 'GT', 'GTM', '', 0, 1),
(90, 'Guinea', 'GN', 'GIN', '', 0, 1),
(91, 'Guinea-Bissau', 'GW', 'GNB', '', 0, 1),
(92, 'Guyana', 'GY', 'GUY', '', 0, 1),
(93, 'Haiti', 'HT', 'HTI', '', 0, 1),
(94, 'Heard and Mc Donald Islands', 'HM', 'HMD', '', 0, 1),
(95, 'Honduras', 'HN', 'HND', '', 0, 1),
(96, 'Hong Kong', 'HK', 'HKG', '', 0, 1),
(97, 'Hungary', 'HU', 'HUN', '', 0, 1),
(98, 'Iceland', 'IS', 'ISL', '', 0, 1),
(99, 'India', 'IN', 'IND', '', 0, 1),
(100, 'Indonesia', 'ID', 'IDN', '', 0, 1),
(101, 'Iran (Islamic Republic of)', 'IR', 'IRN', '', 0, 1),
(102, 'Iraq', 'IQ', 'IRQ', '', 0, 1),
(103, 'Ireland', 'IE', 'IRL', '', 0, 1),
(104, 'Israel', 'IL', 'ISR', '', 0, 1),
(105, 'Italy', 'IT', 'ITA', '', 0, 1),
(106, 'Jamaica', 'JM', 'JAM', '', 0, 1),
(107, 'Japan', 'JP', 'JPN', '', 0, 1),
(108, 'Jordan', 'JO', 'JOR', '', 0, 1),
(109, 'Kazakhstan', 'KZ', 'KAZ', '', 0, 1),
(110, 'Kenya', 'KE', 'KEN', '', 0, 1),
(111, 'Kiribati', 'KI', 'KIR', '', 0, 1),
(112, 'North Korea', 'KP', 'PRK', '', 0, 1),
(113, 'South Korea', 'KR', 'KOR', '', 0, 1),
(114, 'Kuwait', 'KW', 'KWT', '', 0, 1),
(115, 'Kyrgyzstan', 'KG', 'KGZ', '', 0, 1),
(116, 'Lao People\'s Democratic Republic', 'LA', 'LAO', '', 0, 1),
(117, 'Latvia', 'LV', 'LVA', '', 0, 1),
(118, 'Lebanon', 'LB', 'LBN', '', 0, 1),
(119, 'Lesotho', 'LS', 'LSO', '', 0, 1),
(120, 'Liberia', 'LR', 'LBR', '', 0, 1),
(121, 'Libyan Arab Jamahiriya', 'LY', 'LBY', '', 0, 1),
(122, 'Liechtenstein', 'LI', 'LIE', '', 0, 1),
(123, 'Lithuania', 'LT', 'LTU', '', 0, 1),
(124, 'Luxembourg', 'LU', 'LUX', '', 0, 1),
(125, 'Macau', 'MO', 'MAC', '', 0, 1),
(126, 'FYROM', 'MK', 'MKD', '', 0, 1),
(127, 'Madagascar', 'MG', 'MDG', '', 0, 1),
(128, 'Malawi', 'MW', 'MWI', '', 0, 1),
(129, 'Malaysia', 'MY', 'MYS', '', 0, 1),
(130, 'Maldives', 'MV', 'MDV', '', 0, 1),
(131, 'Mali', 'ML', 'MLI', '', 0, 1),
(132, 'Malta', 'MT', 'MLT', '', 0, 1),
(133, 'Marshall Islands', 'MH', 'MHL', '', 0, 1),
(134, 'Martinique', 'MQ', 'MTQ', '', 0, 1),
(135, 'Mauritania', 'MR', 'MRT', '', 0, 1),
(136, 'Mauritius', 'MU', 'MUS', '', 0, 1),
(137, 'Mayotte', 'YT', 'MYT', '', 0, 1),
(138, 'Mexico', 'MX', 'MEX', '', 0, 1),
(139, 'Micronesia, Federated States of', 'FM', 'FSM', '', 0, 1),
(140, 'Moldova, Republic of', 'MD', 'MDA', '', 0, 1),
(141, 'Monaco', 'MC', 'MCO', '', 0, 1),
(142, 'Mongolia', 'MN', 'MNG', '', 0, 1),
(143, 'Montserrat', 'MS', 'MSR', '', 0, 1),
(144, 'Morocco', 'MA', 'MAR', '', 0, 1),
(145, 'Mozambique', 'MZ', 'MOZ', '', 0, 1),
(146, 'Myanmar', 'MM', 'MMR', '', 0, 1),
(147, 'Namibia', 'NA', 'NAM', '', 0, 1),
(148, 'Nauru', 'NR', 'NRU', '', 0, 1),
(149, 'Nepal', 'NP', 'NPL', '', 0, 1),
(150, 'Netherlands', 'NL', 'NLD', '', 0, 1),
(151, 'Netherlands Antilles', 'AN', 'ANT', '', 0, 1),
(152, 'New Caledonia', 'NC', 'NCL', '', 0, 1),
(153, 'New Zealand', 'NZ', 'NZL', '', 0, 1),
(154, 'Nicaragua', 'NI', 'NIC', '', 0, 1),
(155, 'Niger', 'NE', 'NER', '', 0, 1),
(156, 'Nigeria', 'NG', 'NGA', '', 0, 1),
(157, 'Niue', 'NU', 'NIU', '', 0, 1),
(158, 'Norfolk Island', 'NF', 'NFK', '', 0, 1),
(159, 'Northern Mariana Islands', 'MP', 'MNP', '', 0, 1),
(160, 'Norway', 'NO', 'NOR', '', 0, 1),
(161, 'Oman', 'OM', 'OMN', '', 0, 1),
(162, 'Pakistan', 'PK', 'PAK', '', 0, 1),
(163, 'Palau', 'PW', 'PLW', '', 0, 1),
(164, 'Panama', 'PA', 'PAN', '', 0, 1),
(165, 'Papua New Guinea', 'PG', 'PNG', '', 0, 1),
(166, 'Paraguay', 'PY', 'PRY', '', 0, 1),
(167, 'Peru', 'PE', 'PER', '', 0, 1),
(168, 'Philippines', 'PH', 'PHL', '', 0, 1),
(169, 'Pitcairn', 'PN', 'PCN', '', 0, 1),
(170, 'Poland', 'PL', 'POL', '', 0, 1),
(171, 'Portugal', 'PT', 'PRT', '', 0, 1),
(172, 'Puerto Rico', 'PR', 'PRI', '', 0, 1),
(173, 'Qatar', 'QA', 'QAT', '', 0, 1),
(174, 'Reunion', 'RE', 'REU', '', 0, 1),
(175, 'Romania', 'RO', 'ROM', '', 0, 1),
(176, 'Russian Federation', 'RU', 'RUS', '', 0, 1),
(177, 'Rwanda', 'RW', 'RWA', '', 0, 1),
(178, 'Saint Kitts and Nevis', 'KN', 'KNA', '', 0, 1),
(179, 'Saint Lucia', 'LC', 'LCA', '', 0, 1),
(180, 'Saint Vincent and the Grenadines', 'VC', 'VCT', '', 0, 1),
(181, 'Samoa', 'WS', 'WSM', '', 0, 1),
(182, 'San Marino', 'SM', 'SMR', '', 0, 1),
(183, 'Sao Tome and Principe', 'ST', 'STP', '', 0, 1),
(184, 'Saudi Arabia', 'SA', 'SAU', '', 0, 1),
(185, 'Senegal', 'SN', 'SEN', '', 0, 1),
(186, 'Seychelles', 'SC', 'SYC', '', 0, 1),
(187, 'Sierra Leone', 'SL', 'SLE', '', 0, 1),
(188, 'Singapore', 'SG', 'SGP', '', 0, 1),
(189, 'Slovak Republic', 'SK', 'SVK', '{firstname} {lastname}\r\n{company}\r\n{address_1}\r\n{address_2}\r\n{city} {postcode}\r\n{zone}\r\n{country}', 0, 1),
(190, 'Slovenia', 'SI', 'SVN', '', 0, 1),
(191, 'Solomon Islands', 'SB', 'SLB', '', 0, 1),
(192, 'Somalia', 'SO', 'SOM', '', 0, 1),
(193, 'South Africa', 'ZA', 'ZAF', '', 0, 1),
(194, 'South Georgia &amp; South Sandwich Islands', 'GS', 'SGS', '', 0, 1),
(195, 'Spain', 'ES', 'ESP', '', 0, 1),
(196, 'Sri Lanka', 'LK', 'LKA', '', 0, 1),
(197, 'St. Helena', 'SH', 'SHN', '', 0, 1),
(198, 'St. Pierre and Miquelon', 'PM', 'SPM', '', 0, 1),
(199, 'Sudan', 'SD', 'SDN', '', 0, 1),
(200, 'Suriname', 'SR', 'SUR', '', 0, 1),
(201, 'Svalbard and Jan Mayen Islands', 'SJ', 'SJM', '', 0, 1),
(202, 'Swaziland', 'SZ', 'SWZ', '', 0, 1),
(203, 'Sweden', 'SE', 'SWE', '{company}\r\n{firstname} {lastname}\r\n{address_1}\r\n{address_2}\r\n{postcode} {city}\r\n{country}', 1, 1),
(204, 'Switzerland', 'CH', 'CHE', '', 0, 1),
(205, 'Syrian Arab Republic', 'SY', 'SYR', '', 0, 1),
(206, 'Taiwan', 'TW', 'TWN', '', 0, 1),
(207, 'Tajikistan', 'TJ', 'TJK', '', 0, 1),
(208, 'Tanzania, United Republic of', 'TZ', 'TZA', '', 0, 1),
(209, 'Thailand', 'TH', 'THA', '', 0, 1),
(210, 'Togo', 'TG', 'TGO', '', 0, 1),
(211, 'Tokelau', 'TK', 'TKL', '', 0, 1),
(212, 'Tonga', 'TO', 'TON', '', 0, 1),
(213, 'Trinidad and Tobago', 'TT', 'TTO', '', 0, 1),
(214, 'Tunisia', 'TN', 'TUN', '', 0, 1),
(215, 'Turkey', 'TR', 'TUR', '', 0, 1),
(216, 'Turkmenistan', 'TM', 'TKM', '', 0, 1),
(217, 'Turks and Caicos Islands', 'TC', 'TCA', '', 0, 1),
(218, 'Tuvalu', 'TV', 'TUV', '', 0, 1),
(219, 'Uganda', 'UG', 'UGA', '', 0, 1),
(220, 'Ukraine', 'UA', 'UKR', '', 0, 1),
(221, 'United Arab Emirates', 'AE', 'ARE', '', 0, 1),
(222, 'United Kingdom', 'GB', 'GBR', '', 1, 1),
(223, 'United States', 'US', 'USA', '{firstname} {lastname}\r\n{company}\r\n{address_1}\r\n{address_2}\r\n{city}, {zone} {postcode}\r\n{country}', 0, 1),
(224, 'United States Minor Outlying Islands', 'UM', 'UMI', '', 0, 1),
(225, 'Uruguay', 'UY', 'URY', '', 0, 1),
(226, 'Uzbekistan', 'UZ', 'UZB', '', 0, 1),
(227, 'Vanuatu', 'VU', 'VUT', '', 0, 1),
(228, 'Vatican City State (Holy See)', 'VA', 'VAT', '', 0, 1),
(229, 'Venezuela', 'VE', 'VEN', '', 0, 1),
(230, 'Viet Nam', 'VN', 'VNM', '', 0, 1),
(231, 'Virgin Islands (British)', 'VG', 'VGB', '', 0, 1),
(232, 'Virgin Islands (U.S.)', 'VI', 'VIR', '', 0, 1),
(233, 'Wallis and Futuna Islands', 'WF', 'WLF', '', 0, 1),
(234, 'Western Sahara', 'EH', 'ESH', '', 0, 1),
(235, 'Yemen', 'YE', 'YEM', '', 0, 1),
(237, 'Democratic Republic of Congo', 'CD', 'COD', '', 0, 1),
(238, 'Zambia', 'ZM', 'ZMB', '', 0, 1),
(239, 'Zimbabwe', 'ZW', 'ZWE', '', 0, 1),
(242, 'Montenegro', 'ME', 'MNE', '', 0, 1),
(243, 'Serbia', 'RS', 'SRB', '', 0, 1),
(244, 'Aaland Islands', 'AX', 'ALA', '', 0, 1),
(245, 'Bonaire, Sint Eustatius and Saba', 'BQ', 'BES', '', 0, 1),
(246, 'Curacao', 'CW', 'CUW', '', 0, 1),
(247, 'Palestinian Territory, Occupied', 'PS', 'PSE', '', 0, 1),
(248, 'South Sudan', 'SS', 'SSD', '', 0, 1),
(249, 'St. Barthelemy', 'BL', 'BLM', '', 0, 1),
(250, 'St. Martin (French part)', 'MF', 'MAF', '', 0, 1),
(251, 'Canary Islands', 'IC', 'ICA', '', 0, 1),
(252, 'Ascension Island (British)', 'AC', 'ASC', '', 0, 1),
(253, 'Kosovo, Republic of', 'XK', 'UNK', '', 0, 1),
(254, 'Isle of Man', 'IM', 'IMN', '', 0, 1),
(255, 'Tristan da Cunha', 'TA', 'SHN', '', 0, 1),
(256, 'Guernsey', 'GG', 'GGY', '', 0, 1),
(257, 'Jersey', 'JE', 'JEY', '', 0, 1);

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int(11) NOT NULL,
  `key` varchar(250) NOT NULL,
  `value` varchar(1000) DEFAULT NULL,
  `type` varchar(50) NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `type`, `created`, `modified`) VALUES
(1, 'admin_contact_number', '123456789', '', '2017-03-11 08:19:16', '2017-12-11 14:21:39'),
(2, 'admin_contact_mail', 'kuldeepjha@avainfotech.com', '', '2017-03-11 08:19:16', '2017-03-11 08:19:16'),
(3, 'address', '123, Street Name, City, United States', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00'),
(7, 'admin_contact_name', 'kuldeep kumar', '', '0000-00-00 00:00:00', '0000-00-00 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `staticpages`
--

CREATE TABLE `staticpages` (
  `id` int(11) NOT NULL,
  `position` varchar(100) DEFAULT NULL,
  `title` varchar(355) DEFAULT NULL,
  `content` text,
  `faq_category` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT '1',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staticpages`
--

INSERT INTO `staticpages` (`id`, `position`, `title`, `content`, `faq_category`, `status`, `created`, `modified`) VALUES
(4, 'privacy-policy', 'Privacy Policy', '<p>dfgsgdfsg</p>\r\n<p>fasdfasdf</p>', NULL, 1, '2017-08-17 08:22:56', '2018-08-20 11:51:02'),
(6, 'faq', 'Can I refill my gift card or add value to it throughs the app?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">Not yet. Maybe in a future release, but for now, you can&rsquo;t. Sorry &lsquo;bout that.</span></p>', 4, 1, '2017-12-11 09:27:54', '2018-08-09 17:26:39'),
(12, 'support-contact', 'Support & Contact', '<p style=\"text-align: justify;\">adfadsfasdfasdf</p>\r\n<p style=\"text-align: justify;\">&nbsp;</p>', NULL, 1, '2017-08-17 08:22:56', '2018-08-20 11:51:11'),
(13, 'faq', 'What features come with the Premium version of the app?', '<section class=\"wrapper-full section grey-bkg\">\r\n<div class=\"container\">\r\n<div class=\"contain\">\r\n<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">The Premium version of the app includes these additional features:</span></p>\r\n<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">Card data backup on our secure servers. If you ever lose a card or lose your phone, your card data will be restored when you log in to the app the next time.</span><br style=\"box-sizing: border-box; color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\" /><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">Eliminate banner advertising. Use the app ad-free when you upgrade to the Premium version.</span><br style=\"box-sizing: border-box; color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\" /><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">Card sharing. Share your card with a friend or spouse or relative and share the love.</span><br style=\"box-sizing: border-box; color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\" /><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">Card donation. Choose from one of our partner charities to donate an entire card or just the balance and pay it forward a bit. The world will be a better place for your&nbsp;</span></p>\r\n</div>\r\n</div>\r\n</section>', 3, 1, '2017-12-11 09:27:54', '2018-08-09 17:21:15'),
(14, 'faq', 'How do I add a gift card?', '<section class=\"wrapper-full section grey-bkg\">\r\n<div class=\"container\">\r\n<div class=\"contain\">\r\n<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">You can add a card in two ways:</span></p>\r\n<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">Scan the card with your phone&rsquo;s camera. Some of the details will automatically populate the fields. Anything that does not populate can be entered manually with your phone&rsquo;s keyboard.<br style=\"box-sizing: border-box;\" />Enter all the card information manually using your keyboard.<br style=\"box-sizing: border-box;\" />Just go to the home screen and click the Add New Card button to begin.</span></p>\r\n</div>\r\n</div>\r\n</section>', 2, 1, '2017-12-11 09:27:54', '2018-08-09 17:13:00'),
(15, 'faq', 'What’s the deal with the notification voices?', '<p>Fun. That&rsquo;s all, we&rsquo;re just having a little fun. If you leave the default voice checked, your phone&rsquo;s default speaking voice will be used to notify you that you have a card nearby. But, if you&rsquo;re feeling a little frisky - or Southern or British or whatever - choose the voice that fits your style and have a little fun with it.</p>', 1, 1, '2018-08-09 15:53:01', '2018-08-09 17:09:02'),
(16, 'faq', 'Are my cards stored somewhere in case I lose them or accidentally delete them?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">Yes and no. Yes, if you have the Premium version of the app. The premium version of the app stores your card data on a backup server for safe keeping.</span><br style=\"box-sizing: border-box; color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\" /><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">The standard version of the app stores your card data on your phone, so if your phone is lost or stolen or broken, you may lose your cards unless you keep the physical card somewhere.</span></p>', 2, 1, '2018-08-09 17:12:21', '2018-08-09 17:12:21'),
(17, 'faq', 'Is there any charge to use my gift cards?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">Absolutely not, not by the app at least. We don&rsquo;t take a percentage of the sale or assess any kind of fee for using your gift card. The full value of the gift card is yours to</span></p>', 2, 1, '2018-08-09 17:13:42', '2018-08-09 17:13:42'),
(18, 'faq', 'Should I delete my gift card from the app after I use the whole value?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">That&rsquo;s up to you, but we recommend you do. It will make it easier to see what cards you have if you delete the empty ones.</span></p>', 2, 1, '2018-08-09 17:14:00', '2018-08-09 17:14:00'),
(19, 'faq', 'Can I refill my gift card or add value to it through the app?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">Not yet. Maybe in a future release, but for now, you can&rsquo;t. Sorry &lsquo;bout that.</span></p>', 2, 1, '2018-08-09 17:14:21', '2018-08-09 17:14:21'),
(20, 'faq', 'Does the app automatically update my balance when I use a gift card?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">We wish it did, but nope, not yet. The app will remind you to enter the amount you spent when it thinks you used a gift card. When you enter the amount you spent, the app will deduct that amount from the previous balance and store a new balance. So, as long as you enter the amount spent as you spend it, the app will track your balance for you.</span></p>', 2, 1, '2018-08-09 17:14:47', '2018-08-09 17:14:47'),
(21, 'faq', 'How much does the Premium version of the app cost?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">The Premium version of the app costs just $4.99 per year and has an auto-renewal feature to make your life a little easier.</span></p>', 3, 1, '2018-08-09 17:21:42', '2018-08-09 17:21:42'),
(22, 'faq', ' What’s the deal with the notification voices?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">Fun. That&rsquo;s all, we&rsquo;re just having a little fun. If you leave the default voice checked, your phone&rsquo;s default speaking voice will be used to notify you that you have a card nearby. But, if you&rsquo;re feeling a little frisky - or Southern or British or whatever - choose the voice that fits your style and have a little fun with it.</span></p>', 3, 1, '2018-08-09 17:22:07', '2018-08-09 17:22:07'),
(23, 'faq', 'How much do the notification voices cost?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">Each notification voice is a one-time charge of $0.99.</span></p>', 3, 1, '2018-08-09 17:22:32', '2018-08-09 17:22:32'),
(24, 'faq', 'What happens if I buy two or three or more notification voices?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">If you buy multiple notification voices you can either use all of them and they will be used by the app at random, or you can choose the single voice you want to use by checking only that box on the Notification Voice screen.</span></p>', 3, 1, '2018-08-09 17:22:55', '2018-08-09 17:22:55'),
(25, 'faq', 'How do I pay for the Premium version or the voices?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">&nbsp;Your iTunes account or Google Play Store account will be charged for all in-app purchases.</span></p>', 3, 1, '2018-08-09 17:23:59', '2018-08-09 17:23:59'),
(26, 'faq', ' Is there any charge to use my gift cards?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">&nbsp;Absolutely not, not by the app at least. We don&rsquo;t take a percentage of the sale or assess any kind of fee for using your gift card. The full value of the gift card is yours to&nbsp;</span></p>', 3, 1, '2018-08-09 17:24:22', '2018-08-09 17:24:22'),
(27, 'faq', 'Does the app automatically update my balance when I  use a gift card?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">&nbsp;We wish it did, but nope, not yet. The app will remind you to enter the amount you spent when it thinks you used a gift card. When you enter the amount you spent, the app will deduct that amount from the previous balance and store a new balance. So, as long as you enter the amount spent as you spend it, the app will track your balance for you.</span></p>', 4, 1, '2018-08-09 17:27:29', '2018-08-09 17:27:29'),
(28, 'faq', 'Can I buy a gift card on the app?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">Nope. That isn&rsquo;t our gig. We aren&rsquo;t here to sell you anything, just to remind you to use what you already have.</span></p>', 4, 1, '2018-08-09 17:28:00', '2018-08-09 17:28:00'),
(29, 'faq', ' If I put my gift card into the app, can my spouse/friend/free-loading Uncle use it too?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">Yes! And that can happen in two ways. Either you can just give the card to him/her to use (be sure to update the balance in the app after it has been used), or you can share the card with them via the app (Premium service is required for this feature).</span></p>', 1, 1, '2018-08-09 17:28:17', '2018-08-09 17:28:17'),
(30, 'faq', 'I am not sure I am ever going to get around to using this card...is there anything I can do with it?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">Why yes, yes there is. You could donate your card to a charity. Just click on the card you want to donate, and chose &ldquo;Donate My Card&rdquo; from the list of card functions. From there just follow the prompts on the screen, and &ldquo;poof!&rdquo; you did something good!</span></p>', 4, 1, '2018-08-09 17:28:37', '2018-08-09 17:28:37'),
(31, 'faq', 'Someone told me that they donated a gift card to my charity - how do we use it?', '<p><span style=\"color: #333333; font-family: \'Source Sans Pro\', \'Helvetica Neue\', Helvetica, Arial, sans-serif; font-size: 14px;\">Your charity will receive and email with a link to the app. Once your designated representative has downloaded the app, the gift card should appear in your card list. Happy spending!</span></p>', 4, 1, '2018-08-09 17:28:54', '2018-08-09 17:28:54'),
(32, 'faq', 'Where do the socks that get lost in the wash go?', '<p>Mars. Really, we know. When you visit one day you will see that Mars is totally covered by socks.</p>', 1, 1, '2018-08-09 17:30:44', '2018-08-09 17:30:44'),
(33, 'faq', 'Can I get my charity listed as a donation option?', '<p>We would be happy to check your charity out and determine if it is eligible. Just email <a href=\"mailto:charity@flabow.com\" target=\"_blank\">charity@flabow.com</a> with the details and we&rsquo;ll take a look.</p>', 1, 1, '2018-08-09 17:31:00', '2018-08-09 17:31:00'),
(34, 'faq', 'What is the meaning of life?', '<p>We don&rsquo;t know, but if you find out, please email us at <a href=\"mailto:meaningoflife@flabow.com\" target=\"_blank\">meaningoflife@flabow.com</a> and share your knowledge.</p>', 1, 1, '2018-08-09 17:31:13', '2018-08-09 17:31:13'),
(35, 'faq', ' I would like to suggest a feature for Flabow, how can I do that?', '<p>&nbsp;We are always working to improve your Flabow experience. Please email your suggestion to <a href=\"mailto:thenextgreatfeature@flabow.com\" target=\"_blank\">thenextgreatfeature@flabow.com</a></p>', 1, 1, '2018-08-09 17:31:30', '2018-08-09 17:31:30');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `role` varchar(355) DEFAULT NULL,
  `name` varchar(355) DEFAULT NULL,
  `email` varchar(355) DEFAULT NULL,
  `phone` varchar(355) DEFAULT NULL,
  `password` varchar(355) DEFAULT NULL,
  `image` varchar(1000) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `latitude` varchar(355) DEFAULT NULL,
  `longitude` varchar(355) DEFAULT NULL,
  `city` varchar(355) DEFAULT NULL,
  `state` varchar(355) DEFAULT NULL,
  `tokenhash` text,
  `device_token` text,
  `status` int(2) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `role`, `name`, `email`, `phone`, `password`, `image`, `address`, `latitude`, `longitude`, `city`, `state`, `tokenhash`, `device_token`, `status`, `created`, `modified`) VALUES
(1, 'admin', 'Kuldeep', 'kuldeepjha@avainfotech.com', '111-111-1111', '$2y$10$m.ybo75HqBroub3PqDBCUuyVu4Gug4V24RTc8nE.JlRXLQh1.cy3q', '1539947015dummy-pic.jpg', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, '2018-08-10 10:34:53', '2018-10-19 12:27:19'),
(37, 'user', 'Rupak', NULL, '9815993122', '$2y$10$NA8ha/lVGCnLLGmyjQ/17OF1ohWqmM6dIl7IlUGD10y0yZNWL5Hc.', '154029669116200720315bcf0ff3271f6.png', '', '', '', 'undefined', 'undefined', '5360', 'fXcIxyxVlMQ:APA91bE9PVWICCj2lipw4TlUcphsyiRTKzJthFlvu-J-tEGx29pg6yB13FDn5VowJ0lUWqywDTtYGwsZoNT05NpZSyZe8UkiN7evfBrCmlPa3tQnIgaLZp7KPa9g6nDWtx15vUiCjMyM', 1, '2018-10-18 09:50:18', '2018-11-12 14:00:01'),
(41, 'user', 'Prateek', NULL, '7009870205', '$2y$10$NA8ha/lVGCnLLGmyjQ/17OF1ohWqmM6dIl7IlUGD10y0yZNWL5Hc.', '15402920894946007895bcefdf99a988.png', 'Govt Office, 27A, Sector 27, Chandigarh, 160019, India', '30.7279327', '76.80113570000003', '', 'undefined', '3089', 'd4sszs-1-1E:APA91bH0vCOSikALKR_Btoyb9CqdshT68-XtVYZ6aVVIS_vkTBUo56FIbKLTFs0-tQQojuiZkT-Izr_YwIvyKmVyZlcjb2ZeZ5N8UI9basmZqaQXxJXOQ3Gu7EFHpSYVfDb7Ct7fzoAa', 1, '2018-10-23 06:25:15', '2018-11-13 05:32:57'),
(42, 'user', 'Rudy ', NULL, '8328676673', '$2y$10$9KhPXqlbppzQ8sxKcJCcHudaje2daOMeJicgwV/ytjKs7QKEuGp9m', '154040359111428713505bd0b18794434.png', '2001 Sunset Ln, Austin, TX 78704, USA', '30.2412896', '-97.74599920000003', 'undefined', 'undefined', '80412fa194764ff8ef1ca1ae7be73ce4', 'cNo5ThL6BuA:APA91bFfnJNrMm7Vk4NNf_UyfrCLupqa42Xv6Uj-u_wcTJs3Ggo7DRTAiBy4Jj9KCcx5YUdX3BTa-hdhHpk3ng88A5cClhdX7mbEgNPfgb1DKOD4XXF7rI5FAgTYpaJTjxxcYLmlpf5M', 1, '2018-10-24 13:07:40', '2018-11-13 00:42:40');

-- --------------------------------------------------------

--
-- Table structure for table `userskills`
--

CREATE TABLE `userskills` (
  `id` int(11) NOT NULL,
  `cat_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `userskills`
--

INSERT INTO `userskills` (`id`, `cat_id`, `user_id`) VALUES
(41, 5, 32),
(40, 4, 32),
(3, 3, 35),
(4, 4, 35),
(5, 5, 35),
(14, 3, 36),
(13, 2, 36),
(12, 1, 36),
(15, 4, 36),
(39, 3, 32),
(38, 2, 32),
(320, 3, 41),
(335, 3, 37),
(71, 4, 39),
(70, 3, 39),
(69, 2, 39),
(308, 5, 42),
(110, 3, 40),
(109, 2, 40),
(108, 1, 40),
(307, 4, 42),
(306, 3, 42),
(305, 2, 42),
(304, 1, 42),
(319, 2, 41),
(318, 1, 41),
(334, 2, 37),
(333, 1, 37);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `countries`
--
ALTER TABLE `countries`
  ADD PRIMARY KEY (`country_id`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `staticpages`
--
ALTER TABLE `staticpages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `userskills`
--
ALTER TABLE `userskills`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `countries`
--
ALTER TABLE `countries`
  MODIFY `country_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=258;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `staticpages`
--
ALTER TABLE `staticpages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `userskills`
--
ALTER TABLE `userskills`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=336;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
