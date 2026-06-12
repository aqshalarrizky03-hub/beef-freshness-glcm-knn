-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 12, 2026 at 05:26 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `beef_freshness`
--

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `id` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `prediction` varchar(50) DEFAULT NULL,
  `confidence` float DEFAULT NULL,
  `contrast` float DEFAULT NULL,
  `correlation` float DEFAULT NULL,
  `energy` float DEFAULT NULL,
  `homogeneity` float DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`id`, `filename`, `prediction`, `confidence`, `contrast`, `correlation`, `energy`, `homogeneity`, `created_at`) VALUES
(1, 'SPOILED-30-_JPG_jpg.rf.a2957feb308ecf276a70d18047d615a3.jpg', 'spoiled', 100, 196.617, 0.980057, 0.0653836, 0.271774, '2026-06-12 13:40:22'),
(2, 'SPOILED-755-_JPG_jpg.rf.c99a2ce8780b1ec7943881f7c4115b55.jpg', 'fresh', 60, 144.411, 0.983536, 0.102811, 0.26901, '2026-06-12 13:54:19'),
(3, 'SPOILED-442-_JPG_jpg.rf.61e5c25ebca5f1156dc147cb8aaeecca.jpg', 'spoiled', 100, 191.827, 0.97516, 0.126386, 0.292371, '2026-06-12 14:03:43'),
(4, 'FRESH-72-_JPG_jpg.rf.6c13bbce3e1a093833284f7cad780563.jpg', 'fresh', 60, 106.084, 0.972075, 0.0166806, 0.18227, '2026-06-12 14:04:02'),
(5, 'FRESH-832-_JPG_jpg.rf.07ede91a63fd1d4c1ee8ea030294ce95.jpg', 'spoiled', 60, 131.605, 0.975903, 0.0875702, 0.288604, '2026-06-12 14:04:12'),
(6, 'FRESH-891-_JPG_jpg.rf.f366509342026e0555deaeb4f61c19b1.jpg', 'fresh', 80, 117.994, 0.98661, 0.122166, 0.364962, '2026-06-12 14:04:27'),
(7, 'FRESH-772-_JPG_jpg.rf.c1589ef91f9f8624622c2852accbe835.jpg', 'fresh', 80, 91.2819, 0.964217, 0.0212696, 0.217632, '2026-06-12 14:05:26'),
(8, 'FRESH-44-_JPG_jpg.rf.3c8ebe2ea1a051ce628c2af0d8cdb827.jpg', 'fresh', 60, 54.2705, 0.981039, 0.0887522, 0.384219, '2026-06-12 14:05:37'),
(9, 'FRESH-32-_JPG_jpg.rf.d429a0052ae316a9e7d5175fdab09f10.jpg', 'spoiled', 60, 108.678, 0.97785, 0.109719, 0.332914, '2026-06-12 14:05:50'),
(10, 'FRESH-902-_JPG_jpg.rf.2a0390b6c395d8e6c2bf76aa00716c24.jpg', 'fresh', 100, 124.631, 0.961156, 0.0183254, 0.198862, '2026-06-12 14:06:00'),
(11, 'FRESH-952-_JPG_jpg.rf.5a44c46bf892d50cbaec73b882dd8a0d.jpg', 'spoiled', 60, 132.681, 0.983618, 0.129246, 0.358569, '2026-06-12 14:06:10'),
(12, 'FRESH-758-_JPG_jpg.rf.23f0b827780777444f69899f2842e46e.jpg', 'spoiled', 80, 147.009, 0.974539, 0.0856564, 0.263405, '2026-06-12 14:06:28'),
(13, 'FRESH-631-_JPG_jpg.rf.c60dc684c6855b01d9fb64510ab09e38.jpg', 'fresh', 60, 71.4933, 0.983683, 0.0409896, 0.321292, '2026-06-12 14:06:39'),
(14, 'FRESH-84-_JPG_jpg.rf.1ad0f9df82fa1c95338a13103426450c.jpg', 'fresh', 60, 110.828, 0.964286, 0.0186619, 0.1837, '2026-06-12 14:22:12'),
(15, 'FRESH-118-_JPG_jpg.rf.c3533c5781b7c5e88f6b4f5515b5cad5.jpg', 'spoiled', 60, 159.142, 0.978316, 0.0643852, 0.331856, '2026-06-12 14:22:29'),
(16, 'FRESH-84-_JPG_jpg.rf.1ad0f9df82fa1c95338a13103426450c.jpg', 'fresh', 60, 110.828, 0.964286, 0.0186619, 0.1837, '2026-06-12 14:33:19'),
(17, 'FRESH-681-_JPG_jpg.rf.20e715319666fec69485e30d0ab72d57.jpg', 'fresh', 80, 117.118, 0.980532, 0.083445, 0.319517, '2026-06-12 14:36:33'),
(18, 'FRESH-681-_JPG_jpg.rf.20e715319666fec69485e30d0ab72d57.jpg', 'fresh', 80, 117.118, 0.980532, 0.083445, 0.319517, '2026-06-12 14:38:52'),
(19, 'FRESH-68-_JPG_jpg.rf.92d7e3986898cfa36cba58bd5cfe0609.jpg', 'fresh', 80, 85.3461, 0.983366, 0.0811471, 0.293037, '2026-06-12 14:39:12'),
(20, 'FRESH-397-_JPG_jpg.rf.9267905589849b3748743538e48e4aa3.jpg', 'spoiled', 60, 132.051, 0.97266, 0.0646484, 0.266932, '2026-06-12 14:42:51'),
(21, 'FRESH-84-_JPG_jpg.rf.1ad0f9df82fa1c95338a13103426450c.jpg', 'fresh', 60, 110.828, 0.964286, 0.0186619, 0.1837, '2026-06-12 14:45:09'),
(22, 'FRESH-288-_JPG_jpg.rf.4a656961f92a82e707871ca4ebb9501c.jpg', 'fresh', 60, 133.906, 0.975176, 0.0873456, 0.264922, '2026-06-12 14:49:31'),
(23, 'FRESH-80-_JPG_jpg.rf.057e3724cf323b1cda291848d57ed6f2.jpg', 'fresh', 100, 63.7795, 0.974369, 0.108694, 0.360985, '2026-06-12 14:54:48'),
(24, 'FRESH-542-_JPG_jpg.rf.24dd19c355af314a506376f2e301e5cf.jpg', 'spoiled', 60, 141.68, 0.98143, 0.0833741, 0.25534, '2026-06-12 15:13:30');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
