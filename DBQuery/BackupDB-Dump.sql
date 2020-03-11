/*
SQLyog Community v11.4 (64 bit)
MySQL - 5.5.27 : Database - jobster
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`jobster` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `jobster`;

/*Table structure for table `applied_jobs` */

CREATE TABLE `applied_jobs` (
  `VACANCY_ID` int(50) NOT NULL,
  `EMPLOYEE_ID` int(50) NOT NULL,
  KEY `VACANCY_ID` (`VACANCY_ID`),
  KEY `EMPLOYEE_ID` (`EMPLOYEE_ID`),
  CONSTRAINT `applied_jobs_ibfk_1` FOREIGN KEY (`VACANCY_ID`) REFERENCES `vacancy` (`VACANCY_ID`),
  CONSTRAINT `applied_jobs_ibfk_2` FOREIGN KEY (`EMPLOYEE_ID`) REFERENCES `seeker_detail` (`USER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `applied_jobs` */

insert  into `applied_jobs`(`VACANCY_ID`,`EMPLOYEE_ID`) values (5,18);
insert  into `applied_jobs`(`VACANCY_ID`,`EMPLOYEE_ID`) values (1,18);
insert  into `applied_jobs`(`VACANCY_ID`,`EMPLOYEE_ID`) values (3,18);
insert  into `applied_jobs`(`VACANCY_ID`,`EMPLOYEE_ID`) values (4,18);
insert  into `applied_jobs`(`VACANCY_ID`,`EMPLOYEE_ID`) values (3,2);
insert  into `applied_jobs`(`VACANCY_ID`,`EMPLOYEE_ID`) values (7,18);
insert  into `applied_jobs`(`VACANCY_ID`,`EMPLOYEE_ID`) values (7,2);
insert  into `applied_jobs`(`VACANCY_ID`,`EMPLOYEE_ID`) values (10,2);
insert  into `applied_jobs`(`VACANCY_ID`,`EMPLOYEE_ID`) values (6,38);
insert  into `applied_jobs`(`VACANCY_ID`,`EMPLOYEE_ID`) values (7,38);
insert  into `applied_jobs`(`VACANCY_ID`,`EMPLOYEE_ID`) values (8,38);
insert  into `applied_jobs`(`VACANCY_ID`,`EMPLOYEE_ID`) values (3,38);
insert  into `applied_jobs`(`VACANCY_ID`,`EMPLOYEE_ID`) values (10,38);
insert  into `applied_jobs`(`VACANCY_ID`,`EMPLOYEE_ID`) values (5,38);

/*Table structure for table `company_data` */

CREATE TABLE `company_data` (
  `COMPANY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `COMPANY_NAME` varchar(45) NOT NULL,
  PRIMARY KEY (`COMPANY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

/*Data for the table `company_data` */

insert  into `company_data`(`COMPANY_ID`,`COMPANY_NAME`) values (1,'Paxcom');
insert  into `company_data`(`COMPANY_ID`,`COMPANY_NAME`) values (2,'Paypal');
insert  into `company_data`(`COMPANY_ID`,`COMPANY_NAME`) values (3,'Amazon');

/*Table structure for table `recruiter_detail` */

CREATE TABLE `recruiter_detail` (
  `COMPANY_ID` int(11) NOT NULL,
  `USER_ID` int(50) NOT NULL,
  `DESIGNATION` varchar(20) NOT NULL,
  KEY `COMPANY_ID` (`COMPANY_ID`),
  KEY `USER_ID` (`USER_ID`),
  CONSTRAINT `recruiter_detail_ibfk_1` FOREIGN KEY (`COMPANY_ID`) REFERENCES `company_data` (`COMPANY_ID`),
  CONSTRAINT `recruiter_detail_ibfk_2` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `recruiter_detail` */

insert  into `recruiter_detail`(`COMPANY_ID`,`USER_ID`,`DESIGNATION`) values (2,21,'HR');
insert  into `recruiter_detail`(`COMPANY_ID`,`USER_ID`,`DESIGNATION`) values (3,22,'HR');
insert  into `recruiter_detail`(`COMPANY_ID`,`USER_ID`,`DESIGNATION`) values (1,20,'HR');

/*Table structure for table `seeker_detail` */

CREATE TABLE `seeker_detail` (
  `USER_ID` int(50) NOT NULL,
  `LOCATION` varchar(50) NOT NULL,
  `SKILL` varchar(50) NOT NULL,
  `RESUME_URL` varchar(125) NOT NULL,
  `EXPERIENCE` int(11) NOT NULL,
  KEY `USER_ID` (`USER_ID`),
  CONSTRAINT `seeker_detail_ibfk_1` FOREIGN KEY (`USER_ID`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `seeker_detail` */

insert  into `seeker_detail`(`USER_ID`,`LOCATION`,`SKILL`,`RESUME_URL`,`EXPERIENCE`) values (18,'Mohali','Java','https://resume.me',5);
insert  into `seeker_detail`(`USER_ID`,`LOCATION`,`SKILL`,`RESUME_URL`,`EXPERIENCE`) values (19,'Delhi','Python','www.resume.me',10);
insert  into `seeker_detail`(`USER_ID`,`LOCATION`,`SKILL`,`RESUME_URL`,`EXPERIENCE`) values (2,'Mohali','Java','www.ashutoshaneja.github.io',0);
insert  into `seeker_detail`(`USER_ID`,`LOCATION`,`SKILL`,`RESUME_URL`,`EXPERIENCE`) values (23,'Mohali','Python','',0);
insert  into `seeker_detail`(`USER_ID`,`LOCATION`,`SKILL`,`RESUME_URL`,`EXPERIENCE`) values (23,'Mohali','Java','',0);
insert  into `seeker_detail`(`USER_ID`,`LOCATION`,`SKILL`,`RESUME_URL`,`EXPERIENCE`) values (24,'Delhi','Java,Python,Golang','www.resume.me',1);
insert  into `seeker_detail`(`USER_ID`,`LOCATION`,`SKILL`,`RESUME_URL`,`EXPERIENCE`) values (24,'Mohali','Python','a',1);
insert  into `seeker_detail`(`USER_ID`,`LOCATION`,`SKILL`,`RESUME_URL`,`EXPERIENCE`) values (24,'Mohali','Python','',1);
insert  into `seeker_detail`(`USER_ID`,`LOCATION`,`SKILL`,`RESUME_URL`,`EXPERIENCE`) values (32,'Mohali','Golang','cas',0);
insert  into `seeker_detail`(`USER_ID`,`LOCATION`,`SKILL`,`RESUME_URL`,`EXPERIENCE`) values (32,'Mohali','Python,Golang','asds',1);
insert  into `seeker_detail`(`USER_ID`,`LOCATION`,`SKILL`,`RESUME_URL`,`EXPERIENCE`) values (38,'Mohali','Java,Python,Golang,Node.js','iamajay.dev',0);

/*Table structure for table `user` */

CREATE TABLE `user` (
  `user_id` int(50) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `PASSWORD` varchar(60) NOT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=latin1;

/*Data for the table `user` */

insert  into `user`(`user_id`,`username`,`PASSWORD`,`enabled`) values (33,'amar','$2a$10$ljiTjRO2frM/w5wQmqB8.eL94nhUTby59k0frpWgs4E7E5mHAWgXW',1);
insert  into `user`(`user_id`,`username`,`PASSWORD`,`enabled`) values (34,'anubhav','$2a$10$oet/4uLRfgMCPa2R.ru4H.UuLWMiIwPp7Zia8UllUWUiQxg1dOPSO',1);
insert  into `user`(`user_id`,`username`,`PASSWORD`,`enabled`) values (36,'Kirti','$2a$10$56O.nhmZPDECHyjoXzFajeUet4FcSpTfn0Z9n1GWbhDxJ51qyQp8G',1);
insert  into `user`(`user_id`,`username`,`PASSWORD`,`enabled`) values (38,'ajay','$2a$10$EJaZhn9VmiXZW6Lf4EkPe.pqa2IlEjIk7NvVfVQWaSgZW4CQyNgUW',1);

/*Table structure for table `user_role` */

CREATE TABLE `user_role` (
  `user_role_id` int(50) NOT NULL AUTO_INCREMENT,
  `user_id` int(50) NOT NULL,
  `role` varchar(50) NOT NULL,
  PRIMARY KEY (`user_role_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=latin1;

/*Data for the table `user_role` */

insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (1,2,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (2,1,'ROLE_RECRUITER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (3,5,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (4,6,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (5,7,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (6,8,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (7,9,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (8,10,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (9,11,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (10,12,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (11,13,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (12,14,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (13,15,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (14,16,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (15,17,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (16,18,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (17,19,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (18,20,'ROLE_RECRUITER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (19,21,'ROLE_RECRUITER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (20,22,'ROLE_RECRUITER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (21,23,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (22,24,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (23,25,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (24,26,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (25,27,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (26,28,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (27,29,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (28,30,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (29,31,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (30,32,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (31,33,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (32,34,'ROLE_SEEKER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (34,36,'ROLE_RECRUITER');
insert  into `user_role`(`user_role_id`,`user_id`,`role`) values (36,38,'ROLE_SEEKER');

/*Table structure for table `vacancy` */

CREATE TABLE `vacancy` (
  `VACANCY_ID` int(11) NOT NULL AUTO_INCREMENT,
  `RECRUITER_ID` int(50) NOT NULL,
  `COMPANY_ID` int(11) NOT NULL,
  `VACANCY_COUNT` int(11) DEFAULT NULL,
  `LOCATION` varchar(10) NOT NULL,
  `SKILL` varchar(10) NOT NULL,
  `EXPERIENCE` int(11) NOT NULL,
  `STATUS` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`VACANCY_ID`),
  KEY `RECRUITER_ID` (`RECRUITER_ID`),
  KEY `COMPANY_ID` (`COMPANY_ID`),
  CONSTRAINT `vacancy_ibfk_1` FOREIGN KEY (`RECRUITER_ID`) REFERENCES `recruiter_detail` (`USER_ID`),
  CONSTRAINT `vacancy_ibfk_2` FOREIGN KEY (`COMPANY_ID`) REFERENCES `company_data` (`COMPANY_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

/*Data for the table `vacancy` */

insert  into `vacancy`(`VACANCY_ID`,`RECRUITER_ID`,`COMPANY_ID`,`VACANCY_COUNT`,`LOCATION`,`SKILL`,`EXPERIENCE`,`STATUS`) values (1,22,3,7,'Delhi','Java',0,0);
insert  into `vacancy`(`VACANCY_ID`,`RECRUITER_ID`,`COMPANY_ID`,`VACANCY_COUNT`,`LOCATION`,`SKILL`,`EXPERIENCE`,`STATUS`) values (3,21,2,5,'Pune','Java',0,0);
insert  into `vacancy`(`VACANCY_ID`,`RECRUITER_ID`,`COMPANY_ID`,`VACANCY_COUNT`,`LOCATION`,`SKILL`,`EXPERIENCE`,`STATUS`) values (4,22,3,5,'Mohali','Java',0,0);
insert  into `vacancy`(`VACANCY_ID`,`RECRUITER_ID`,`COMPANY_ID`,`VACANCY_COUNT`,`LOCATION`,`SKILL`,`EXPERIENCE`,`STATUS`) values (5,22,3,1,'Noida','Golang',3,0);
insert  into `vacancy`(`VACANCY_ID`,`RECRUITER_ID`,`COMPANY_ID`,`VACANCY_COUNT`,`LOCATION`,`SKILL`,`EXPERIENCE`,`STATUS`) values (6,20,1,7,'Mohali','Node.js',2,0);
insert  into `vacancy`(`VACANCY_ID`,`RECRUITER_ID`,`COMPANY_ID`,`VACANCY_COUNT`,`LOCATION`,`SKILL`,`EXPERIENCE`,`STATUS`) values (7,20,1,12,'Delhi','Java',0,0);
insert  into `vacancy`(`VACANCY_ID`,`RECRUITER_ID`,`COMPANY_ID`,`VACANCY_COUNT`,`LOCATION`,`SKILL`,`EXPERIENCE`,`STATUS`) values (8,20,1,5,'Pune','Python',2,0);
insert  into `vacancy`(`VACANCY_ID`,`RECRUITER_ID`,`COMPANY_ID`,`VACANCY_COUNT`,`LOCATION`,`SKILL`,`EXPERIENCE`,`STATUS`) values (9,22,3,2,'Mumbai','Python',0,0);
insert  into `vacancy`(`VACANCY_ID`,`RECRUITER_ID`,`COMPANY_ID`,`VACANCY_COUNT`,`LOCATION`,`SKILL`,`EXPERIENCE`,`STATUS`) values (10,21,2,6,'Mohali','Java',4,0);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
