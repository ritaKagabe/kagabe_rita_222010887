-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 18, 2024 at 09:59 PM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 7.4.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `e_claiming_project_management_system`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `DeleteClaimDocument` (IN `p_claim_letter_id` INT)   BEGIN
    DELETE FROM CLAIMDOCUMENT
    WHERE
        claim_letter_id = p_claim_letter_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `DisplayAllData` ()   BEGIN
    
    SELECT * FROM student;

    
    SELECT * FROM staff;

    
    SELECT * FROM claims;

    
    SELECT * FROM notification;

    
    SELECT * FROM claimdocument;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllInformation` ()   BEGIN
    SELECT
        s.student_id,
        s.names AS student_names,
        s.emails AS student_emails,
        c.claim_id,
        c.claim_type,
        c.submission_date,
        c.resolution_date,
        st.staff_id,
        st.names AS staff_names,
        st.position,
        n.notification_id,
        n.recipient,
        n.message,
        n.sent_date,
        cd.claim_letter_id
    FROM
        student AS s
    LEFT JOIN
        claims AS c ON s.student_id = c.student_id
    LEFT JOIN
        staff AS st ON c.claim_id = st.claim_id
    LEFT JOIN
        notification AS n ON c.claim_id = n.claim_id
    LEFT JOIN
        claimdocument AS cd ON s.student_id = cd.student_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllmyInformation` ()   BEGIN
    SELECT
        s.student_id,
        s.names AS student_names,
        s.email AS student_email,
        c.claim_id,
        c.claim_type,
        c.submission_date,
        c.resolution_date,
        st.staff_id,
        st.names AS staff_names,
        st.postion,
        n.notification_id,
        n.recipient,
        n.message,
        n.sent_date,
        cd.claim_letter_id
    FROM
        student AS s
    LEFT JOIN
        claims AS c ON s.student_id = c.student_id
    LEFT JOIN
        staff AS st ON c.claim_id = st.claim_id
    LEFT JOIN
        notification AS n ON c.claim_id = n.claim_id
    LEFT JOIN
        claimdocument AS cd ON s.student_id = cd.student_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertClaim` (IN `in_claim_id` INT, IN `in_claim_type` VARCHAR(255), IN `in_submission_date` DATE, IN `in_resolution_date` DATE, IN `in_student_id` INT)   BEGIN
    INSERT INTO claims (claim_id, claim_type, submission_date, resolution_date, student_id)
    VALUES (in_claim_id, in_claim_type, in_submission_date, in_resolution_date, in_student_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertClaimDocument` (IN `p_student_id` INT, IN `p_claim_letter_id` INT)   BEGIN
    INSERT INTO CLAIMDOCUMENT (student_id, claim_letter_id)
    VALUES (p_student_id, p_claim_letter_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertinStaff` (IN `in_staff_id` INT, IN `in_names` VARCHAR(255), IN `in_postion` VARCHAR(255), IN `in_claim_id` INT)   BEGIN
    INSERT INTO staff (staff_id, names, postion, claim_id)
    VALUES (in_staff_id, in_names, in_postion, in_claim_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertNotification` (IN `p_recipient` VARCHAR(255), IN `p_message` TEXT, IN `p_sent_date` DATETIME, IN `p_claim_id` INT)   BEGIN
    INSERT INTO NOTIFICATION (recipient, message, sent_date, claim_id)
    VALUES (p_recipient, p_message, p_sent_date, p_claim_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertStaff` (IN `in_staff_id` INT, IN `in_names` VARCHAR(255), IN `in_position` VARCHAR(255), IN `in_claim_id` INT)   BEGIN
    INSERT INTO staff (staff_id, names, position, claim_id)
    VALUES (in_staff_id, in_names, in_position, in_claim_id);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertStudent` (IN `in_student_id` INT, IN `in_names` VARCHAR(255), IN `in_email` VARCHAR(255))   BEGIN
    INSERT INTO student (student_id, names, email)
    VALUES (in_student_id, in_names, in_email);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateClaimInfo` (IN `p_claim_id` INT, IN `p_new_claim_type` VARCHAR(255), IN `p_new_submission_date` DATE, IN `p_new_resolution_date` DATE)   BEGIN
    UPDATE claims
    SET
        claim_type = p_new_claim_type,
        submission_date = p_new_submission_date,
        resolution_date = p_new_resolution_date
    WHERE
        claim_id = p_claim_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateinStaffInfo` (IN `staff_id_param` INT, IN `new_names` VARCHAR(255), IN `new_postion` VARCHAR(255))   BEGIN
    
    UPDATE staff
    SET
        names = new_names,
        postion = new_postion
    WHERE staff_id = staff_id_param;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdatesStaffInfo` (IN `staff_id_param` INT, IN `new_names` VARCHAR(255), IN `new_postion` VARCHAR(255))   BEGIN
    
    UPDATE staff
    SET
        names = new_names,
        postion = new_postion
    WHERE staff_id = staff_id_param;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateStaffInfo` (IN `staff_id_param` INT, IN `new_names` VARCHAR(255), IN `new_position` VARCHAR(255))   BEGIN
    
    UPDATE staff
    SET
        names = new_names,
        position = new_postion
    WHERE staff_id = staff_id_param;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateStudentInfo` (IN `p_student_id` INT, IN `p_new_names` VARCHAR(255), IN `p_new_email` VARCHAR(255))   BEGIN
    UPDATE student
    SET
        names = p_new_names,
        email = p_new_email
    WHERE
        student_id = p_student_id;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `alldataview`
-- (See below for the actual view)
--
CREATE TABLE `alldataview` (
`student_id` int(11)
,`student_names` varchar(100)
,`student_email` varchar(100)
,`staff_id` int(11)
,`staff_names` varchar(100)
,`postion` varchar(100)
,`claim_id` int(11)
,`claim_type` varchar(100)
,`submission_date` date
,`resolution_date` date
,`notification_id` int(11)
,`recipient` varchar(100)
,`message` varchar(100)
,`sent_date` date
,`claim_letter_id` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `allinformationview`
-- (See below for the actual view)
--
CREATE TABLE `allinformationview` (
`student_id` int(11)
,`student_names` varchar(100)
,`student_email` varchar(100)
,`claim_id` int(11)
,`claim_type` varchar(100)
,`submission_date` date
,`resolution_date` date
,`staff_id` int(11)
,`staff_names` varchar(100)
,`postion` varchar(100)
,`notification_id` int(11)
,`recipient` varchar(100)
,`message` varchar(100)
,`sent_date` date
,`claim_letter_id` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `claimdocument`
--

CREATE TABLE `claimdocument` (
  `claim_letter_id` int(11) NOT NULL,
  `student_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `claimdocument`
--

INSERT INTO `claimdocument` (`claim_letter_id`, `student_id`) VALUES
(1, 1),
(2, 2),
(7, 3),
(4, 4),
(5, 5),
(6, 6),
(8, 7);

-- --------------------------------------------------------

--
-- Table structure for table `claims`
--

CREATE TABLE `claims` (
  `claim_id` int(11) NOT NULL,
  `claim_type` varchar(100) DEFAULT NULL,
  `submission_date` date DEFAULT NULL,
  `resolution_date` date DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `claims`
--

INSERT INTO `claims` (`claim_id`, `claim_type`, `submission_date`, `resolution_date`, `student_id`) VALUES
(1, 'marks_claim', '2023-09-03', '2023-09-10', 1),
(2, 'registration_claim', '2023-08-25', '2023-09-05', 2),
(3, 'marks_claim', '2023-08-20', '2023-09-02', 3),
(4, 'studying_claim', '2023-08-15', '2023-08-30', 4),
(5, 'registration_claim', '2023-08-10', '2023-08-28', 5),
(6, 'marks_claim', '2023-08-05', '2023-08-25', 6),
(7, 'registration_claim', '2023-09-02', '2023-09-10', 6),
(10, 'studying_claim', '2023-08-05', '2023-09-15', 7),
(36, 'marks Claim', '2024-02-16', NULL, 1);

--
-- Triggers `claims`
--
DELIMITER $$
CREATE TRIGGER `AfterClaimInsert` AFTER INSERT ON `claims` FOR EACH ROW BEGIN
    INSERT INTO claim_log (claim_id, claim_type, submission_date, resolution_date, student_id)
    VALUES (NEW.claim_id, NEW.claim_type, NEW.submission_date, NEW.resolution_date, NEW.student_id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `claimtypeavgresolution`
-- (See below for the actual view)
--
CREATE TABLE `claimtypeavgresolution` (
`claim_type` varchar(100)
,`avg_resolution_time` decimal(10,4)
);

-- --------------------------------------------------------

--
-- Table structure for table `claim_log`
--

CREATE TABLE `claim_log` (
  `claim_id` int(11) NOT NULL DEFAULT 0,
  `claim_type` varchar(100) DEFAULT NULL,
  `submission_date` date DEFAULT NULL,
  `resolution_date` date DEFAULT NULL,
  `student_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `claim_log`
--

INSERT INTO `claim_log` (`claim_id`, `claim_type`, `submission_date`, `resolution_date`, `student_id`) VALUES
(1, 'marks_claim', '2023-09-03', '2023-09-10', 1),
(2, 'registration_claim', '2023-08-25', '2023-09-05', 2),
(3, 'marks_claim', '2023-08-20', '2023-09-02', 3),
(4, 'studying_claim', '2023-08-15', '2023-08-30', 4),
(5, 'registration_claim', '2023-08-10', '2023-08-28', 5),
(6, 'marks_claim', '2023-08-05', '2023-08-25', 6),
(7, 'registration_claim', '2023-09-02', '2023-09-10', 6),
(10, 'studying_claim', '2023-08-05', '2023-09-15', 7),
(36, 'marks Claim', '2024-02-16', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `feedback_id` int(11) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `Student_id` int(11) DEFAULT NULL,
  `response` varchar(255) DEFAULT NULL,
  `claim_id` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Stand-in structure for view `insertclaimdocumentview`
-- (See below for the actual view)
--
CREATE TABLE `insertclaimdocumentview` (
`claim_letter_id` int(11)
,`student_id` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insertclaimsview`
-- (See below for the actual view)
--
CREATE TABLE `insertclaimsview` (
`claim_id` int(11)
,`claim_type` varchar(100)
,`submission_date` date
,`resolution_date` date
,`student_id` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insertnotificationview`
-- (See below for the actual view)
--
CREATE TABLE `insertnotificationview` (
`notification_id` int(11)
,`recipient` varchar(100)
,`message` varchar(100)
,`sent_date` date
,`claim_id` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `insertstaffview`
-- (See below for the actual view)
--
CREATE TABLE `insertstaffview` (
`staff_id` int(11)
,`names` varchar(100)
,`postion` varchar(100)
,`claim_id` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `notification_id` int(11) NOT NULL,
  `recipient` varchar(100) DEFAULT NULL,
  `message` varchar(100) DEFAULT NULL,
  `sent_date` date DEFAULT NULL,
  `claim_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `notification`
--

INSERT INTO `notification` (`notification_id`, `recipient`, `message`, `sent_date`, `claim_id`) VALUES
(1, 'Joe Mahoro', 'claim accepted', '2023-09-03', 1),
(2, 'Jane Rukundo', 'Reminder: Submit your supporting documents.', '2023-09-04', 2),
(4, 'Sarah Butera', 'Claim status updated: Rejected.', '2023-09-06', 4),
(5, 'David Mahoro', 'Your claim has been processed.', '2023-09-07', 5),
(6, 'Emily Kagabo', 'New claim submitted.', '2023-09-08', 6),
(7, 'Kamali ole', 'claim denied', '2023-08-04', 1),
(9, 'Goldie Amata ', 'New claim submitted.', '2023-09-05', 7),
(11, 'jack', 'New staff member added', '2024-01-15', 5),
(12, '26', '0', '2024-01-15', 5);

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `staff_id` int(11) NOT NULL,
  `names` varchar(100) DEFAULT NULL,
  `postion` varchar(100) DEFAULT NULL,
  `claim_id` int(11) DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`staff_id`, `names`, `postion`, `claim_id`, `password`) VALUES
(1, 'Teta Nice', 'secretary', 5, NULL),
(13, 'Joe Mahoro', 'Speaker', 1, NULL),
(14, 'Jane Rukundo', 'Vice_guild', 2, NULL),
(16, 'Sarah Butera', 'Secretary', 4, NULL),
(17, 'David Mahoro', 'Assistant', 5, NULL),
(18, 'Emily Kagabo', 'Guild president', 6, NULL),
(24, 'Deo Agaba', 'Dean of studies', 10, NULL),
(26, 'jack', 'dean', 5, '12345');

--
-- Triggers `staff`
--
DELIMITER $$
CREATE TRIGGER `AfterStaffInsert` AFTER INSERT ON `staff` FOR EACH ROW BEGIN
    INSERT INTO notification (recipient, message, sent_date, claim_id)
    VALUES (NEW.names, 'New staff member added', NOW(), NEW.claim_id);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `staff_insert_notification` AFTER INSERT ON `staff` FOR EACH ROW BEGIN
    
    INSERT INTO notification (recipient, message, sent_date, claim_id)
    VALUES (NEW.staff_id, 'New staff member added: ' || NEW.names || ' - ' || NEW.postion, NOW(), NEW.claim_id);
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `staffdelete` AFTER DELETE ON `staff` FOR EACH ROW Begin
Insert into stafflog (staff_id,action,timestramp)
Values (16 ,'staff_deleted',now());
End
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `staffupdate` AFTER UPDATE ON `staff` FOR EACH ROW Begin
Insert into stafflog (staff_id,action,timestramp)
Values (2,'staff_updated',now());
End
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `staffupdate2` AFTER UPDATE ON `staff` FOR EACH ROW Begin
Insert into stafflog (staff_id,action,timestramp)
Values (1,'current_staff_member',now());
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `stafflog`
--

CREATE TABLE `stafflog` (
  `Log_id` int(11) NOT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `Action` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `stafflog`
--

INSERT INTO `stafflog` (`Log_id`, `staff_id`, `Action`) VALUES
(1, 1, 'new staffmember'),
(2, 16, 'changed position');

-- --------------------------------------------------------

--
-- Stand-in structure for view `staffwithspecificclaim`
-- (See below for the actual view)
--
CREATE TABLE `staffwithspecificclaim` (
`staff_id` int(11)
,`names` varchar(100)
,`postion` varchar(100)
,`claim_id` int(11)
);

-- --------------------------------------------------------

--
-- Table structure for table `student`
--

CREATE TABLE `student` (
  `student_id` int(11) NOT NULL,
  `names` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `student`
--

INSERT INTO `student` (`student_id`, `names`, `email`) VALUES
(1, 'uwacu_divine', 'uwacudivine@gmail.com'),
(2, 'gisa_denis', 'gisadenis@gmail.com'),
(3, 'mugisha_deborah', 'mugishadebby@gmail.com'),
(4, 'umwali_sonia', 'umwalisonia@gmail.com'),
(5, 'Shyaka Chriss', 'shyakachriss@gmail.com'),
(6, 'gisubizo_louange', 'gisubizolouange@gmail.com'),
(7, 'John_kabaka', 'johnkabaka@gmail.com'),
(8, 'karabo_dede', 'karabodede@gmail.com');

--
-- Triggers `student`
--
DELIMITER $$
CREATE TRIGGER `after_student_update` AFTER UPDATE ON `student` FOR EACH ROW BEGIN
    
    IF NEW.names <> OLD.names THEN
        
        INSERT INTO audit_log (action, table_name, student_id, old_names, new_names, email)
        VALUES ('UPDATE', 'student', 8 , karabo_dede, Keza_Peace , NEW.email);
    END IF;
    
    
    IF NEW.email <> OLD.email THEN
        
        INSERT INTO audit_log (action, table_name, student_id, names, old_email, new_email)
        VALUES ('UPDATE', 'student',8, NEW.names , karabodede , kezapeace);
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `after_the_student_update` AFTER UPDATE ON `student` FOR EACH ROW BEGIN
    
    IF NEW.email != OLD.email THEN
        
        INSERT INTO claims (claim_type, submission_date, resolution_date, student_id)
        VALUES ('Email Update', NOW(), NULL, NEW.student_id);
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `studentdelete` AFTER DELETE ON `student` FOR EACH ROW Begin
insert into studentlog (student_id,action,timestramp)
Values (1,'student_deleted',now());
End
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `studentdelete1` AFTER DELETE ON `student` FOR EACH ROW Begin
Insert into studentlog (student_id,action,timestramp)
Values (old.student_id,'student_deleted',now());
End
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `studentdelete2` AFTER DELETE ON `student` FOR EACH ROW Begin
Insert into studentlog (student_id,action,timestramp)
Values (1,'student_deleted',now());
End
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `studentupdate` AFTER UPDATE ON `student` FOR EACH ROW Begin
Insert into studentlog (student_id,action,timestramp)
Values (9,'student_updated', today);
End
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `studentupdate1` AFTER UPDATE ON `student` FOR EACH ROW Begin
Insert into studentlog (student_id,action,timestramp)
Values (new.student_id,'student_updated',now());
End
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `studentupdate2` AFTER UPDATE ON `student` FOR EACH ROW Begin
Insert into studentlog (student_id,action,timestramp)
Values (7,'student_updated',now());
End
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `studentupdate3` AFTER UPDATE ON `student` FOR EACH ROW Begin
Insert into studentlog (student_id,action,timestramp)
Values (7,'student_updated','today');
End
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Stand-in structure for view `studentinfo`
-- (See below for the actual view)
--
CREATE TABLE `studentinfo` (
`student_id` int(11)
,`names` varchar(100)
,`email` varchar(100)
);

-- --------------------------------------------------------

--
-- Table structure for table `studentlog`
--

CREATE TABLE `studentlog` (
  `Log_id` int(11) NOT NULL,
  `Action` varchar(20) DEFAULT NULL,
  `Trimestramp` varchar(10) DEFAULT NULL,
  `Student_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `studentlog`
--

INSERT INTO `studentlog` (`Log_id`, `Action`, `Trimestramp`, `Student_id`) VALUES
(4, 'new_student', 'today', NULL),
(5, 'changed', 'july', NULL),
(6, 'changed', 'today', NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `updatenotificationview`
-- (See below for the actual view)
--
CREATE TABLE `updatenotificationview` (
`notification_id` int(11)
,`recipient` varchar(100)
,`message` varchar(100)
,`sent_date` date
,`claim_id` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `updatestaffview`
-- (See below for the actual view)
--
CREATE TABLE `updatestaffview` (
`staff_id` int(11)
,`names` varchar(100)
,`postion` varchar(100)
,`claim_id` int(11)
);

-- --------------------------------------------------------

--
-- Structure for view `alldataview`
--
DROP TABLE IF EXISTS `alldataview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `alldataview`  AS SELECT `s`.`student_id` AS `student_id`, `s`.`names` AS `student_names`, `s`.`email` AS `student_email`, `st`.`staff_id` AS `staff_id`, `st`.`names` AS `staff_names`, `st`.`postion` AS `postion`, `c`.`claim_id` AS `claim_id`, `c`.`claim_type` AS `claim_type`, `c`.`submission_date` AS `submission_date`, `c`.`resolution_date` AS `resolution_date`, `n`.`notification_id` AS `notification_id`, `n`.`recipient` AS `recipient`, `n`.`message` AS `message`, `n`.`sent_date` AS `sent_date`, `cd`.`claim_letter_id` AS `claim_letter_id` FROM ((((`student` `s` join `staff` `st` on(`s`.`student_id` = `st`.`claim_id`)) join `claims` `c` on(`s`.`student_id` = `c`.`student_id`)) join `notification` `n` on(`c`.`claim_id` = `n`.`claim_id`)) join `claimdocument` `cd` on(`s`.`student_id` = `cd`.`student_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `allinformationview`
--
DROP TABLE IF EXISTS `allinformationview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `allinformationview`  AS SELECT `s`.`student_id` AS `student_id`, `s`.`names` AS `student_names`, `s`.`email` AS `student_email`, `c`.`claim_id` AS `claim_id`, `c`.`claim_type` AS `claim_type`, `c`.`submission_date` AS `submission_date`, `c`.`resolution_date` AS `resolution_date`, `st`.`staff_id` AS `staff_id`, `st`.`names` AS `staff_names`, `st`.`postion` AS `postion`, `n`.`notification_id` AS `notification_id`, `n`.`recipient` AS `recipient`, `n`.`message` AS `message`, `n`.`sent_date` AS `sent_date`, `cd`.`claim_letter_id` AS `claim_letter_id` FROM ((((`student` `s` left join `claims` `c` on(`s`.`student_id` = `c`.`student_id`)) left join `staff` `st` on(`c`.`claim_id` = `st`.`claim_id`)) left join `notification` `n` on(`c`.`claim_id` = `n`.`claim_id`)) left join `claimdocument` `cd` on(`s`.`student_id` = `cd`.`student_id`))  ;

-- --------------------------------------------------------

--
-- Structure for view `claimtypeavgresolution`
--
DROP TABLE IF EXISTS `claimtypeavgresolution`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `claimtypeavgresolution`  AS SELECT `claims`.`claim_type` AS `claim_type`, avg(to_days(`claims`.`resolution_date`) - to_days(`claims`.`submission_date`)) AS `avg_resolution_time` FROM `claims` GROUP BY `claims`.`claim_type``claim_type`  ;

-- --------------------------------------------------------

--
-- Structure for view `insertclaimdocumentview`
--
DROP TABLE IF EXISTS `insertclaimdocumentview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `insertclaimdocumentview`  AS SELECT `claimdocument`.`claim_letter_id` AS `claim_letter_id`, `claimdocument`.`student_id` AS `student_id` FROM `claimdocument``claimdocument`  ;

-- --------------------------------------------------------

--
-- Structure for view `insertclaimsview`
--
DROP TABLE IF EXISTS `insertclaimsview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `insertclaimsview`  AS SELECT `claims`.`claim_id` AS `claim_id`, `claims`.`claim_type` AS `claim_type`, `claims`.`submission_date` AS `submission_date`, `claims`.`resolution_date` AS `resolution_date`, `claims`.`student_id` AS `student_id` FROM `claims``claims`  ;

-- --------------------------------------------------------

--
-- Structure for view `insertnotificationview`
--
DROP TABLE IF EXISTS `insertnotificationview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `insertnotificationview`  AS SELECT `notification`.`notification_id` AS `notification_id`, `notification`.`recipient` AS `recipient`, `notification`.`message` AS `message`, `notification`.`sent_date` AS `sent_date`, `notification`.`claim_id` AS `claim_id` FROM `notification``notification`  ;

-- --------------------------------------------------------

--
-- Structure for view `insertstaffview`
--
DROP TABLE IF EXISTS `insertstaffview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `insertstaffview`  AS SELECT `staff`.`staff_id` AS `staff_id`, `staff`.`names` AS `names`, `staff`.`postion` AS `postion`, `staff`.`claim_id` AS `claim_id` FROM `staff``staff`  ;

-- --------------------------------------------------------

--
-- Structure for view `staffwithspecificclaim`
--
DROP TABLE IF EXISTS `staffwithspecificclaim`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `staffwithspecificclaim`  AS SELECT `staff`.`staff_id` AS `staff_id`, `staff`.`names` AS `names`, `staff`.`postion` AS `postion`, `staff`.`claim_id` AS `claim_id` FROM `staff` WHERE `staff`.`claim_id` in (select `claims`.`claim_id` from `claims` where `claims`.`claim_type` = 'Marks_claim')  ;

-- --------------------------------------------------------

--
-- Structure for view `studentinfo`
--
DROP TABLE IF EXISTS `studentinfo`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `studentinfo`  AS SELECT `student`.`student_id` AS `student_id`, `student`.`names` AS `names`, `student`.`email` AS `email` FROM `student``student`  ;

-- --------------------------------------------------------

--
-- Structure for view `updatenotificationview`
--
DROP TABLE IF EXISTS `updatenotificationview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `updatenotificationview`  AS SELECT `notification`.`notification_id` AS `notification_id`, `notification`.`recipient` AS `recipient`, `notification`.`message` AS `message`, `notification`.`sent_date` AS `sent_date`, `notification`.`claim_id` AS `claim_id` FROM `notification``notification`  ;

-- --------------------------------------------------------

--
-- Structure for view `updatestaffview`
--
DROP TABLE IF EXISTS `updatestaffview`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `updatestaffview`  AS SELECT `staff`.`staff_id` AS `staff_id`, `staff`.`names` AS `names`, `staff`.`postion` AS `postion`, `staff`.`claim_id` AS `claim_id` FROM `staff``staff`  ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `claimdocument`
--
ALTER TABLE `claimdocument`
  ADD PRIMARY KEY (`claim_letter_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `claims`
--
ALTER TABLE `claims`
  ADD PRIMARY KEY (`claim_id`),
  ADD KEY `student_id` (`student_id`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`feedback_id`),
  ADD KEY `staff_id` (`staff_id`),
  ADD KEY `Student_id` (`Student_id`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notification_id`),
  ADD KEY `claim_id` (`claim_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD KEY `claim_id` (`claim_id`);

--
-- Indexes for table `stafflog`
--
ALTER TABLE `stafflog`
  ADD PRIMARY KEY (`Log_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`student_id`);

--
-- Indexes for table `studentlog`
--
ALTER TABLE `studentlog`
  ADD PRIMARY KEY (`Log_id`),
  ADD KEY `Student_id` (`Student_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `claimdocument`
--
ALTER TABLE `claimdocument`
  MODIFY `claim_letter_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `claims`
--
ALTER TABLE `claims`
  MODIFY `claim_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `feedback_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `notification_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `stafflog`
--
ALTER TABLE `stafflog`
  MODIFY `Log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `student`
--
ALTER TABLE `student`
  MODIFY `student_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `studentlog`
--
ALTER TABLE `studentlog`
  MODIFY `Log_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `claimdocument`
--
ALTER TABLE `claimdocument`
  ADD CONSTRAINT `claimdocument_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`);

--
-- Constraints for table `claims`
--
ALTER TABLE `claims`
  ADD CONSTRAINT `claims_ibfk_1` FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`);

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`),
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`Student_id`) REFERENCES `student` (`student_id`);

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`claim_id`) REFERENCES `claims` (`claim_id`);

--
-- Constraints for table `staff`
--
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`claim_id`) REFERENCES `claims` (`claim_id`);

--
-- Constraints for table `stafflog`
--
ALTER TABLE `stafflog`
  ADD CONSTRAINT `stafflog_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

--
-- Constraints for table `studentlog`
--
ALTER TABLE `studentlog`
  ADD CONSTRAINT `studentlog_ibfk_1` FOREIGN KEY (`Student_id`) REFERENCES `student` (`student_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
