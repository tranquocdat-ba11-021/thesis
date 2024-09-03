-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Sep 03, 2024 at 03:53 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `testing`
--

-- --------------------------------------------------------

--
-- Table structure for table `appointments`
--

CREATE TABLE `appointments` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `pet_id` int DEFAULT NULL,
  `service` varchar(255) NOT NULL,
  `appointment_date` date NOT NULL,
  `appointment_start_time` time DEFAULT NULL,
  `appointment_end_time` time DEFAULT NULL,
  `additional_info` text,
  `status` varchar(50) DEFAULT 'pending',
  `doctor_id` int DEFAULT NULL,
  `appointment_time` time DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `appointments`
--

INSERT INTO `appointments` (`id`, `user_id`, `pet_id`, `service`, `appointment_date`, `appointment_start_time`, `appointment_end_time`, `additional_info`, `status`, `doctor_id`, `appointment_time`) VALUES
(109, 1, 1, '15', '2024-08-01', '00:00:00', '00:00:00', '', 'confirmed', NULL, '00:00:00'),
(121, 1, 1, '10', '2024-07-26', '00:00:00', '00:00:00', '', 'confirmed', 2, '00:00:00'),
(125, 1, 1, '10', '2024-08-06', '00:00:00', '00:00:00', '', 'confirmed', 2, '00:00:00'),
(126, 1, 1, '10', '2024-08-06', '00:00:00', '00:00:00', '', 'completed', 2, '00:00:00'),
(127, 1, 1, '10', '2024-08-14', '00:00:00', '00:00:00', '', 'completed', 2, '00:00:00'),
(128, 1, 1, '15', '2024-08-16', '00:00:00', '00:00:00', '', 'pending', NULL, '00:00:00'),
(129, 1, 1, '15', '2024-08-16', '00:00:00', '00:00:00', '', 'pending', NULL, '00:00:00'),
(130, 1, 1, '15', '2024-08-16', '00:00:00', '00:00:00', '', 'pending', NULL, '00:00:00'),
(131, 1, 1, '14', '2024-08-24', '00:00:00', '00:00:00', '', 'pending', NULL, '00:00:00'),
(133, 1, 1, '15', '2024-08-28', '00:00:00', '00:00:00', '', 'confirmed', NULL, '00:00:00'),
(134, 1, 1, '10', '2024-08-28', '00:00:00', '00:00:00', 'hgfhgfhg', 'confirmed', 2, '00:00:00'),
(139, 1, 1, '9', '2024-09-02', '17:25:00', '18:25:00', '', 'confirmed', 1, '00:00:00'),
(140, 1, 1, '14', '2024-09-03', NULL, NULL, '', 'waiting', NULL, '10:00:00'),
(141, 1, 1, '9', '2024-09-03', '09:50:00', '10:50:00', '', 'confirmed', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `calendar`
--

CREATE TABLE `calendar` (
  `id` int NOT NULL,
  `doctor_id` int NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `calendar`
--

INSERT INTO `calendar` (`id`, `doctor_id`, `date`, `start_time`, `end_time`) VALUES
(15, 1, '2024-09-02', '17:25:00', '18:25:00'),
(16, 1, '2024-09-02', '07:35:00', '08:35:00'),
(17, 1, '2024-09-03', '09:50:00', '10:50:00'),
(18, 1, '2024-09-03', '09:51:00', '10:52:00');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`) VALUES
(1, 'lifestyle'),
(4, 'takeCare'),
(5, 'Shop');

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `id` int NOT NULL,
  `post_id` int NOT NULL,
  `user_id` int NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `parent_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `comments`
--

INSERT INTO `comments` (`id`, `post_id`, `user_id`, `content`, `created_at`, `parent_id`) VALUES
(29, 31, 1, 'hi', '2024-07-29 04:38:53', 0),
(34, 28, 1, 'alo', '2024-07-29 07:25:31', 0),
(35, 28, 1, 'hay', '2024-07-29 07:25:36', 34),
(37, 31, 1, 'hoi', '2024-08-01 03:35:02', 0),
(38, 31, 1, 'fgcgh', '2024-08-01 03:35:54', 37),
(39, 31, 1, '123', '2024-08-01 03:36:06', 38),
(41, 20, 1, 'hi', '2024-08-19 07:00:26', 0),
(42, 31, 1, 'jhfhj', '2024-08-27 10:12:35', 29);

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `id_doctor` int NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name_doctor` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email_doctor` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `phone_doctor` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `address_doctor` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `image_doctor` varchar(255) NOT NULL,
  `intro_doctor` text NOT NULL,
  `facebook_link` varchar(255) NOT NULL,
  `instagram_link` varchar(255) NOT NULL,
  `twitter_link` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `services_doctor` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`id_doctor`, `username`, `password`, `name_doctor`, `email_doctor`, `phone_doctor`, `address_doctor`, `image_doctor`, `intro_doctor`, `facebook_link`, `instagram_link`, `twitter_link`, `created_at`, `services_doctor`) VALUES
(1, 'phat', '$2y$10$xMPUNjH5j2KMS3mL4QfuJOekG/ZTH7lOmHRWkmNtJ8Njyw7jKOrmG', 'thành phát', 'a@gmai.com', '1234444', 'vn', '1725130073_66d36559dfd27.jpg', 'csc', 'https://www.facebook.com/profile.php?id=100006883964237', 'https://www.instagram.com/_dat0408._/', 'https://x.com/?lang=en', '2024-08-31 18:47:53', 9),
(2, 'hoang', '$2y$10$yDk1LWjs1uOg9gsETwJ9w.x0ThjbQuCaVuo2bFVFH5nQcCHaNRSfW', 'hoang', 'hoang@gmail.com', '01293901293', 'vn', '1725289290_66d5d34a5e87e.jpg', '', 'https://www.facebook.com/profile.php?id=100006883964237', 'https://www.instagram.com/_dat0408._/', 'https://x.com/?lang=en', '2024-09-02 15:01:30', 21);

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int NOT NULL,
  `appointment_id` int NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` enum('offline','online') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `payment_status` enum('pending','completed','failed') DEFAULT 'pending',
  `payment_date` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`id`, `appointment_id`, `amount`, `payment_method`, `payment_status`, `payment_date`) VALUES
(10, 127, '200.00', 'offline', 'completed', '2024-08-13 08:15:10'),
(11, 128, '10000.00', 'online', 'pending', '2024-08-15 07:07:24'),
(12, 129, '10000.00', 'online', 'pending', '2024-08-15 07:17:07'),
(13, 130, '10000.00', 'online', 'pending', '2024-08-15 07:42:39'),
(14, 131, '0.00', 'online', 'pending', '2024-08-07 18:35:54'),
(16, 133, '10000.00', 'offline', 'pending', '2024-08-27 10:18:13'),
(17, 134, '0.00', 'offline', 'pending', '2024-08-27 10:19:32'),
(22, 139, '0.00', 'offline', 'completed', '2024-09-02 12:08:32'),
(23, 140, '0.00', 'offline', 'pending', '2024-09-02 16:15:35'),
(24, 141, '0.00', 'offline', 'pending', '2024-09-03 02:56:33');

-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE `posts` (
  `id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `summary_content` varchar(255) NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `date` date NOT NULL,
  `category_id` int DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `posts`
--

INSERT INTO `posts` (`id`, `title`, `content`, `summary_content`, `image_url`, `date`, `category_id`) VALUES
(20, 'Cat Asks – Doctor Answers: Feline Panleukopenia', '<blockquote>\r\n<p><strong>Feline panleukopenia (FPV) is an infectious disease that weakens the immune system, leaving cats anemic and vulnerable to infections. Because it can be easily transmitted from cat to cat, it is one of the most common infectious diseases in cats.</strong></p>\r\n</blockquote>\r\n\r\n<h2 style=\"text-align:justify\"><span style=\"font-size:var(--gpc-single-h2-fs)\"><span style=\"color:#414141\"><span style=\"font-family:Dosis,sans-serif\"><span style=\"background-color:#ffffff\">1. What is feline panleukopenia?</span></span></span></span></h2>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">The term &ldquo;leukopenia&rdquo; refers to a decrease in the number of all white blood cells in the body. White blood cells play an important role in immunity and are essential in protecting against infection and disease. In severe cases of leukopenia, the white blood cell count can drop from a normal range of several thousand per milliliter of blood to just a few hundred, leaving the cat vulnerable to serious infections.</span></span></span></span></p>\r\n\r\n<h2 style=\"text-align:justify\"><span style=\"font-size:var(--gpc-single-h2-fs)\"><span style=\"color:#414141\"><span style=\"font-family:Dosis,sans-serif\"><span style=\"background-color:#ffffff\">2. Causes of feline leukemia</span></span></span></span></h2>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">The panleukopenia virus is present in all excretions, especially the feces, of infected cats. Cats become infected with the virus through direct contact with another infected cat or through these excretions.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">Not only that, the panleukopenia virus is very durable in the environment (&nbsp;<a href=\"https://www.merck-animal-health-usa.com/condition/feline-panleukopenia\" rel=\"noopener nofollow\" style=\"box-sizing:border-box; text-decoration:underline; color:var(--ast-global-color-0); transition:all 0.2s linear 0s\" target=\"_blank\">can survive at room temperature for up to 1 year</a>&nbsp;), so cats can also transmit the virus through drinking water, food, beds, cages, toilets, combs, shoes, clothes or any object that carries the virus from infected cats.</span></span></span></span></p>\r\n', 'Feline panleukopenia (FPV) is an infectious disease that weakens ', '1717987328_6666680060029.jpg', '2024-05-20', 5),
(28, 'General examination prices for dogs and cats and other common questions', '<h2 style=\"text-align:justify\"><span style=\"font-size:var(--gpc-single-h2-fs)\"><span style=\"color:#414141\"><span style=\"font-family:Dosis,sans-serif\"><span style=\"background-color:#ffffff\">1. What is a general health check for dogs and cats?</span></span></span></span></h2>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">A general health checkup for dogs and cats is a routine comprehensive medical examination, usually performed once or twice a year on a pet that appears to be healthy, as opposed to a checkup when the pet is sick. The focus of a regular general health checkup for dogs and cats is to maintain optimal health, promptly detect potential problems or diseases for timely medical intervention.</span></span></span></span></p>\r\n\r\n<h2 style=\"text-align:justify\"><span style=\"font-size:var(--gpc-single-h2-fs)\"><span style=\"color:#414141\"><span style=\"font-family:Dosis,sans-serif\"><span style=\"background-color:#ffffff\">2. What are the benefits of a general examination of dogs and cats?</span></span></span></span></h2>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">Many pet owners think that if their pet is not sick, they do not need to see a veterinarian. However, regular checkups are an important part of preventative care for your pet. This is because animals are very good at hiding illnesses or potential chronic problems. This is part of their inherent survival instinct. Checkups help detect problems before they become serious health problems for your pet. Early detection of any health problems will help ensure timely treatment and the best possible outcome.</span></span></span></span></p>\r\n', 'One of the best ways to ensure your pet gets the care it needs is to take ', '1717991987_66667a3302934.jpg', '2024-05-21', NULL),
(29, 'Are regular health check-ups for dogs and cats necessary?', '<h2 style=\"text-align:justify\"><span style=\"font-size:var(--gpc-single-h2-fs)\"><span style=\"color:#414141\"><span style=\"font-family:Dosis,sans-serif\"><span style=\"background-color:#ffffff\">1. What are the benefits of regular health check-ups for dogs and cats?</span></span></span></span></h2>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">Regular health check-ups for dogs and cats will give pets and owners the best chance to prevent, detect and treat diseases that may occur now and in the future.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">Regular health checks allow your veterinarian to detect small signs, such as changes in breathing, heart rate, discharge from the eyes, nose, etc., and even small bumps hidden under the fur. These signs can help detect early health problems in dogs and cats, including: Liver and kidney dysfunction, nutritional metabolism disorders, internal and external parasites, diseases of the skin, fur, eyes, nose, mouth, etc.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<img alt=\"\" src=\"/ckfinder/userfiles/images/444479390_1049747560125608_6732602701280836484_n(1).jpg\" style=\"height:300px; width:300px\" /></span></span></span></span></p>\r\n\r\n<p style=\"text-align:justify\">&nbsp; &nbsp;&nbsp;</p>\r\n\r\n<h2 style=\"text-align:justify\"><span style=\"font-size:var(--gpc-single-h2-fs)\"><span style=\"color:#414141\"><span style=\"font-family:Dosis,sans-serif\"><span style=\"background-color:#ffffff\">2. Health check for elderly dogs and cats</span></span></span></span></h2>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">Our pets age about 7 years faster than we do. No matter how well cared for, older dogs and cats are susceptible to aging-related problems, including certain heart, liver, kidney, urinary, diabetes, bone and joint, vision, and hearing problems. So at what age are dogs and cats considered old?</span></span></span></span></p>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">Cats are generally considered seniors after the age of 10. However, dogs do not have a common age of maturity because they vary in size. Larger breeds tend to have shorter lifespans than smaller breeds. For a variety of reasons, experts consider dogs to be seniors when they reach the last 25% of their breed&#39;s estimated lifespan. If classified by weight, this means:</span></span></span></span></p>\r\n\r\n<ul style=\"margin-left:24px\">\r\n	<li>Small breed dogs (under 10kg): After 8 &ndash; 11 years old are considered old</li>\r\n	<li>Medium breed (10kg &ndash; 22.5kg): After 8 &ndash; 10 years old is considered old</li>\r\n	<li>Large breed (22.5kg to 40kg): After 8 &ndash; 9 years old is considered old</li>\r\n	<li>Giant breed (over 40kg): After 6 &ndash; 7 years old is considered old</li>\r\n</ul>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">You can use this classification to determine whether your dog or cat is in the elderly group or not and give them the necessary regular check-ups.</span></span></span></span></p>\r\n', 'Annual health check-ups for dogs and cats are essential preventive care for all ', '1718003174_6666a5e649ce8.jpg', '2024-05-21', NULL),
(31, 'Cats Ask – Doctors Answer: Calicivirus in Cats', '<h2 style=\"text-align:justify\"><span style=\"font-size:var(--gpc-single-h2-fs)\"><span style=\"color:#414141\"><span style=\"font-family:Dosis,sans-serif\"><span style=\"background-color:#ffffff\">1. What is Calicivirus in cats?</span></span></span></span></h2>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">Calicivirus is a virus that causes upper respiratory infections and dental disease in cats. It infects cats worldwide and can cause disease in cats kept indoors. Although there is no specific treatment for the disease, most cats make a full recovery with supportive care. However, many infected cats remain asymptomatic carriers of the virus for life.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">If your cat appears to have a bad cold but has sores in his mouth or on his nose, there is a good chance he has been infected with FCV.</span></span></span></span></p>\r\n\r\n<h2 style=\"text-align:justify\"><span style=\"font-size:var(--gpc-single-h2-fs)\"><span style=\"color:#414141\"><span style=\"font-family:Dosis,sans-serif\"><span style=\"background-color:#ffffff\">2. Causes of Calicivirus infection in cats</span></span></span></span></h2>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">Calicivirus is highly contagious and mutates rapidly. Infected cats can shed the virus in saliva or secretions from the nose and eyes. If an infected cat sneezes, virus particles can be sprayed several meters into the air.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">The virus can survive for up to a week in a contaminated environment (and possibly longer in cool, moist places). Susceptible cats can become infected through direct contact with an infected cat or through contact with objects contaminated with infectious secretions.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">Although any cat can become infected with FCV, symptoms tend to be more severe in kittens. Kittens born to FCV-carrying mothers will also be infected.</span></span></span></span></p>\r\n', 'Upper respiratory problems are quite common in cats ', '1718003205_6666a605b954c.png', '2024-06-06', NULL),
(32, 'Sen asks - Doctor answers: Canine Distemper', '<h2 style=\"text-align:justify\"><span style=\"font-size:var(--gpc-single-h2-fs)\"><span style=\"color:#414141\"><span style=\"font-family:Dosis,sans-serif\"><span style=\"background-color:#ffffff\">1. What is Canine Distemper?</span></span></span></span></h2>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">Canine distemper, also known as canine distemper, is caused by a virus that infects the gastrointestinal tract, respiratory tract, and central nervous system. The virus initially replicates in the lymphoid tissue of the respiratory tract, attacking lymphocytes, leading to infection of all lymphoid tissues. This is followed by infection of the epithelium of the respiratory tract, digestive tract, urogenital tract, central nervous system, and optic nerve.</span></span></span></span></p>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">Canine distemper has a very high mortality rate. Dogs that survive often suffer permanent, irreversible damage to their nervous systems.</span></span></span></span></p>\r\n\r\n<h2 style=\"text-align:justify\"><span style=\"font-size:var(--gpc-single-h2-fs)\"><span style=\"color:#414141\"><span style=\"font-family:Dosis,sans-serif\"><span style=\"background-color:#ffffff\">2. Causes of Dogs Being Infected with Distemper</span></span></span></span></h2>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">Dogs are usually infected with Distemper through contact with airborne droplets and particles containing the virus from infected dogs (coughing, sneezing, drooling, barking) or wild animals. The virus can also be transmitted through food and water containers. Infected dogs can shed the virus for months and mother dogs can pass the virus to their puppies through the placenta.</span></span></span></span></p>\r\n', 'Distemper is one of the most serious diseases your dog can get.', '1718003217_6666a611c4c4c.jpg', '2024-06-06', NULL),
(33, 'Sen asked – The doctor answered: Kennel cough', '<h2 style=\"text-align:justify\"><span style=\"font-size:var(--gpc-single-h2-fs)\"><span style=\"color:#414141\"><span style=\"font-family:Dosis,sans-serif\"><span style=\"background-color:#ffffff\">1. Causes of Dogs Being Infected with Distemper</span></span></span></span></h2>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">Dogs are usually infected with Distemper through contact with airborne droplets and particles containing the virus from infected dogs (coughing, sneezing, drooling, barking) or wild animals. The virus can also be transmitted through food and water containers. Infected dogs can shed the virus for months and mother dogs can pass the virus to their puppies through the placenta.</span></span></span></span></p>\r\n\r\n<h2 style=\"text-align:justify\"><span style=\"font-size:var(--gpc-single-h2-fs)\"><span style=\"color:#414141\"><span style=\"font-family:Dosis,sans-serif\"><span style=\"background-color:#ffffff\">2. Symptoms of Dogs with Distemper</span></span></span></span></h2>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">Dogs with Distemper often show the following clinical signs:</span></span></span></span></p>\r\n\r\n<ul style=\"margin-left:24px\">\r\n	<li>Systemic signs: Fever, apathy, anorexia</li>\r\n	<li>Respiratory signs: Watery eyes, runny nose, cough, pneumonia</li>\r\n	<li>Gastrointestinal signs: Diarrhea, vomiting</li>\r\n	<li>This is followed by neurological signs: muscle twitching, ataxia (staggering gait), head tilt, and paralysis.</li>\r\n</ul>\r\n\r\n<p style=\"text-align:justify\"><span style=\"font-size:16px\"><span style=\"color:#414141\"><span style=\"font-family:Mulish,sans-serif\"><span style=\"background-color:#ffffff\">As with all infectious diseases, clinical signs can vary. Many diseases cause diarrhea and vomiting. Some cause neurological and respiratory signs. But scabies is one of the few diseases that causes all of these problems at the same time.</span></span></span></span></p>\r\n\r\n<p>&nbsp;</p>\r\n', 'test', '1718010423_6666c23730b7a.jpg', '2024-06-10', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `post_categories`
--

CREATE TABLE `post_categories` (
  `post_id` int NOT NULL,
  `category_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `post_categories`
--

INSERT INTO `post_categories` (`post_id`, `category_id`) VALUES
(20, 1),
(28, 1),
(31, 1),
(20, 4),
(28, 4),
(29, 4),
(32, 4),
(20, 5),
(28, 5),
(33, 5);

-- --------------------------------------------------------

--
-- Table structure for table `post_tags`
--

CREATE TABLE `post_tags` (
  `post_id` int NOT NULL,
  `tag_id` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `post_tags`
--

INSERT INTO `post_tags` (`post_id`, `tag_id`) VALUES
(20, 5),
(28, 5),
(29, 5),
(33, 5),
(20, 6),
(28, 6),
(29, 6),
(20, 7),
(28, 7),
(31, 7),
(20, 8),
(29, 8),
(32, 8),
(20, 9);

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int NOT NULL,
  `appointment_id` int NOT NULL,
  `service_id` int NOT NULL,
  `user_id` int NOT NULL,
  `user_name` varchar(255) NOT NULL,
  `rating` int NOT NULL,
  `comment` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP
) ;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`id`, `appointment_id`, `service_id`, `user_id`, `user_name`, `rating`, `comment`, `created_at`) VALUES
(22, 109, 15, 1, 'dattran', 1, '', '2024-08-02 09:58:40'),
(23, 109, 15, 1, 'dattran', 3, '', '2024-08-02 10:00:27'),
(24, 109, 15, 1, 'dattran', 4, 'alo', '2024-08-02 10:15:41'),
(25, 121, 10, 1, 'dattran', 4, '', '2024-08-02 10:22:55'),
(26, 121, 10, 1, 'dattran', 4, 'hi', '2024-08-02 10:46:56'),
(27, 121, 10, 1, 'dattran', 4, 'alo', '2024-08-02 10:54:17'),
(28, 109, 15, 1, 'dattran', 4, 'hi', '2024-08-02 11:10:34'),
(29, 121, 10, 1, 'dattran', 3, 'hello', '2024-08-02 11:10:46'),
(30, 129, 15, 1, 'dattran', 5, '', '2024-08-19 14:21:28'),
(31, 127, 10, 1, 'dattran', 4, '', '2024-08-19 14:25:06'),
(32, 128, 15, 1, 'dattran', 4, 'hay', '2024-08-19 14:25:24'),
(33, 130, 15, 1, 'dattran', 3, '', '2024-08-19 14:25:40');

-- --------------------------------------------------------

--
-- Table structure for table `registered_users`
--

CREATE TABLE `registered_users` (
  `id` int NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `username` varchar(100) NOT NULL,
  `image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(15) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` int NOT NULL DEFAULT '1',
  `resettoken` varchar(255) DEFAULT NULL,
  `resettokenexpired` date DEFAULT NULL,
  `verification_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  `is_verified` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `registered_users`
--

INSERT INTO `registered_users` (`id`, `full_name`, `username`, `image_url`, `email`, `phone`, `password`, `role`, `resettoken`, `resettokenexpired`, `verification_code`, `is_verified`) VALUES
(1, 'dattran', 'dattran', 'about.jpg', 'datt18776@gmail.com', '0921831311', '$2y$10$ThqycI.BVoOAPj8fKMAbaePGuk6GZjd5ORHzb7MYzcZ8r.oJQ7tK6', 1, NULL, NULL, 'fecdcb04f5e944bffc47f1959a2fef9d', 1),
(2, '123', 'admin', '1719201359_6678ee4fb6be5.jpg', 'dattq.ba11-021@st.usth.edu.vn', '091231231', '$2y$10$U.JDHpHOdF/bzixX2avJWupgnrMG4/W/BxaeccySDhQYvd2cmZ1PW', 0, NULL, NULL, 'cd4370ae1b424931b4cd65bf8a43dbc7', 1),
(4, 'hieu', 'hieu', '1724917233_66d025f16c331.jpg', 'zduchieuz@gmail.com', '12321321321321', '$2y$10$8.u56e3umX.NSWu0vyI9feprZaPWNqwIHfP1DjvhwZnML56fo7nXS', 1, NULL, NULL, 'f0871e8b46dcfb7ccfd2ffe04dc5f362', 1),
(10, 'tiến', 'tiến cl', '1724919643_66d02f5b91706.jpg', 'alo@gmail.com', '0971622398', '$2y$10$Hy5sDtgz.Revc9ysodbKG.mgXp9a8tZmSQcbtpv/1C/Jr58al6ryy', 2, NULL, NULL, NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `services`
--

CREATE TABLE `services` (
  `id_service` int NOT NULL,
  `name_service` varchar(255) NOT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  `type` int DEFAULT NULL,
  `type_name` varchar(255) DEFAULT NULL,
  `price` int DEFAULT NULL,
  `description` text,
  `title_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `services`
--

INSERT INTO `services` (`id_service`, `name_service`, `image_url`, `type`, `type_name`, `price`, `description`, `title_content`) VALUES
(9, 'examination', '1718611497_666fee29699d7.jpg', 1, 'examination', 0, '<p>123</p>\r\n', ''),
(14, 'bathing service', '1718611477_666fee15d9c95.jpg', 2, 'Services', 100000, '<p>hay lắm</p>\r\n', 's'),
(15, 'hair trimming service', '1718592885_666fa5756b6ca.jpg', 2, 'Services', 10000, '<p>hay lắm m&aacute; ơi</p>\r\n', 'dịch vụ chất lượng'),
(17, 'Testing service', '1721638607_669e1ecf38d3f.jpg', 2, 'Services', 10000, '<p>22</p>\r\n', 'k co gi'),
(19, 'Departure', '1724053443_66c2f7c3b92a4.jpg', 2, 'Services', 111, '', 'test 2'),
(20, 'Eye', '1725334496_66d683e0893a9.jpg', 1, 'Khám bệnh', 0, '', ''),
(21, 'skin', '1725289133_66d5d2ad82113.jpg', 1, 'examination', NULL, '', ''),
(22, 'leg', '1725289149_66d5d2bd768d4.jpg', 1, 'examination', NULL, '', '');

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` int NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`) VALUES
(14, 'about_section_image_main', './image/kisspng-logo-dog-pet-cat-cute-cat-5aa41e0bbf9735.4106239115207050357848.png'),
(15, 'milestone_count1', '456'),
(16, 'milestone_description1', 'happy'),
(17, 'milestone_count2', '123'),
(18, 'milestone_description2', 'happy'),
(19, 'milestone_count3', '890'),
(20, 'milestone_description3', 'happy'),
(21, 'milestone_count4', '1000'),
(22, 'milestone_description4', 'happy'),
(115, 'navbar_phone', '+84 971622399'),
(116, 'navbar_email', 'datt18776@gmail.com'),
(117, 'navbar_location', '40B Dong Quan-Cau Giay'),
(118, 'navbar_logo', '../uploads/logo/h3.png'),
(121, 'navbar_facebook', 'https://www.facebook.com/YourPage'),
(122, 'navbar_instagram', 'https://www.instagram.com/YourPage'),
(123, 'navbar_twitter', 'https://www.twitter.com/YourPage');

-- --------------------------------------------------------

--
-- Table structure for table `slides`
--

CREATE TABLE `slides` (
  `id` int NOT NULL,
  `image` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `sub_title` varchar(255) NOT NULL,
  `button_text` varchar(255) NOT NULL,
  `link` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `slides`
--

INSERT INTO `slides` (`id`, `image`, `title`, `sub_title`, `button_text`, `link`) VALUES
(1, 'h2.jpg', 'hello', '5-Step pet massage service for only20$', 'Get start ', 'https://www.youtube.com/watch?v=CPJYGL0XkC4&list=RD_gtAMcncE7Q&index=4'),
(2, 'jonatan-bustos-P1Ku27zZJDs-unsplash.jpg', 'hello', 'hello 2', 'la sao?', 'https://www.youtube.com/watch?v=CPJYGL0XkC4&list=RD_gtAMcncE7Q&index=4');

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` int NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `name`) VALUES
(5, 'Tips'),
(6, 'DOG'),
(7, 'CAT'),
(8, 'DOCTOR'),
(9, 'CAT'),
(10, 'cho dat');

-- --------------------------------------------------------

--
-- Table structure for table `user_pets`
--

CREATE TABLE `user_pets` (
  `id` int NOT NULL,
  `user_id` int NOT NULL,
  `pet_name` varchar(100) NOT NULL,
  `pet_type` enum('dog','cat') NOT NULL,
  `pet_gender` enum('male','female') NOT NULL,
  `pet_age` int DEFAULT NULL,
  `pet_description` text,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `user_pets`
--

INSERT INTO `user_pets` (`id`, `user_id`, `pet_name`, `pet_type`, `pet_gender`, `pet_age`, `pet_description`, `created_at`) VALUES
(1, 1, 'bông', 'dog', 'male', 10, 'đẹp, có vêt ', '2024-06-24 10:09:18'),
(7, 4, 'bông', 'dog', 'female', 24, 'none', '2024-07-09 03:22:40');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `appointments`
--
ALTER TABLE `appointments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `pet_id` (`pet_id`);

--
-- Indexes for table `calendar`
--
ALTER TABLE `calendar`
  ADD PRIMARY KEY (`id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `post_id` (`post_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`id_doctor`),
  ADD KEY `doctor_service` (`services_doctor`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointment_id` (`appointment_id`);

--
-- Indexes for table `posts`
--
ALTER TABLE `posts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `post_categories`
--
ALTER TABLE `post_categories`
  ADD PRIMARY KEY (`post_id`,`category_id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD PRIMARY KEY (`post_id`,`tag_id`),
  ADD KEY `tag_id` (`tag_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `appointment_id` (`appointment_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `registered_users`
--
ALTER TABLE `registered_users`
  ADD PRIMARY KEY (`id`) USING BTREE,
  ADD UNIQUE KEY `username` (`username`) USING BTREE,
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`) USING BTREE;

--
-- Indexes for table `services`
--
ALTER TABLE `services`
  ADD PRIMARY KEY (`id_service`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `section_key_unique` (`key`);

--
-- Indexes for table `slides`
--
ALTER TABLE `slides`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_pets`
--
ALTER TABLE `user_pets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `appointments`
--
ALTER TABLE `appointments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=142;

--
-- AUTO_INCREMENT for table `calendar`
--
ALTER TABLE `calendar`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `id_doctor` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `posts`
--
ALTER TABLE `posts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `registered_users`
--
ALTER TABLE `registered_users`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `services`
--
ALTER TABLE `services`
  MODIFY `id_service` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=254;

--
-- AUTO_INCREMENT for table `slides`
--
ALTER TABLE `slides`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `user_pets`
--
ALTER TABLE `user_pets`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `appointments`
--
ALTER TABLE `appointments`
  ADD CONSTRAINT `appointments_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `registered_users` (`id`),
  ADD CONSTRAINT `appointments_ibfk_2` FOREIGN KEY (`pet_id`) REFERENCES `user_pets` (`id`);

--
-- Constraints for table `calendar`
--
ALTER TABLE `calendar`
  ADD CONSTRAINT `calendar_ibfk_1` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`id_doctor`);

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`),
  ADD CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `registered_users` (`id`);

--
-- Constraints for table `doctor`
--
ALTER TABLE `doctor`
  ADD CONSTRAINT `doctor_service` FOREIGN KEY (`services_doctor`) REFERENCES `services` (`id_service`) ON DELETE RESTRICT ON UPDATE RESTRICT;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`);

--
-- Constraints for table `posts`
--
ALTER TABLE `posts`
  ADD CONSTRAINT `posts_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`);

--
-- Constraints for table `post_categories`
--
ALTER TABLE `post_categories`
  ADD CONSTRAINT `post_categories_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_categories_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `post_tags`
--
ALTER TABLE `post_tags`
  ADD CONSTRAINT `post_tags_ibfk_1` FOREIGN KEY (`post_id`) REFERENCES `posts` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_tags_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`appointment_id`) REFERENCES `appointments` (`id`),
  ADD CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `registered_users` (`id`);

--
-- Constraints for table `user_pets`
--
ALTER TABLE `user_pets`
  ADD CONSTRAINT `user_pets_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `registered_users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
