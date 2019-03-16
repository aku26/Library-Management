DROP TABLE IF EXISTS `AUTHORS`;

CREATE TABLE `AUTHORS` (
  `Author_id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Author_id`)
);

DROP TABLE IF EXISTS `BOOK`;

CREATE TABLE `BOOK` (
  `Isbn` varchar(255) NOT NULL,
  `Title` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Isbn`)
);

DROP TABLE IF EXISTS `BOOK_AUTHORS`;

CREATE TABLE `BOOK_AUTHORS` (
  `Isbn` varchar(255) NOT NULL,
  `Author_id` int(11) NOT NULL,
  KEY `FKcl0o2bsfdykikgxn7gebxs3l2` (`Author_id`),
  KEY `FKb1y730ser6ks65ob4xgvuwus2` (`Isbn`),
  CONSTRAINT `FKb1y730ser6ks65ob4xgvuwus2` FOREIGN KEY (`Isbn`) REFERENCES `BOOK` (`Isbn`),
  CONSTRAINT `FKcl0o2bsfdykikgxn7gebxs3l2` FOREIGN KEY (`Author_id`) REFERENCES `AUTHORS` (`Author_id`)
);

DROP TABLE IF EXISTS `BOOK_LOANS`;

CREATE TABLE `BOOK_LOANS` (
  `Loan_id` int(11) NOT NULL AUTO_INCREMENT,
  `Date_in` datetime(6) DEFAULT NULL,
  `Date_out` datetime(6) DEFAULT NULL,
  `Due_Date` datetime(6) DEFAULT NULL,
  `Isbn` varchar(255) DEFAULT NULL,
  `Card_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`Loan_id`),
  KEY `FK975d9fvalynmejkjjhmoa5co7` (`Isbn`),
  KEY `FKq4xp83w4sku8sgswvek7h72ce` (`Card_id`),
  CONSTRAINT `FK975d9fvalynmejkjjhmoa5co7` FOREIGN KEY (`Isbn`) REFERENCES `BOOK` (`Isbn`),
  CONSTRAINT `FKq4xp83w4sku8sgswvek7h72ce` FOREIGN KEY (`Card_id`) REFERENCES `BORROWER` (`Card_id`)
);

DROP TABLE IF EXISTS `BORROWER`;

CREATE TABLE `BORROWER` (
  `Card_id` int(11) NOT NULL AUTO_INCREMENT,
  `Address` varchar(255) DEFAULT NULL,
  `Bname` varchar(255) DEFAULT NULL,
  `Phone` varchar(255) DEFAULT NULL,
  `Ssn` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`Card_id`),
  UNIQUE KEY `UK_85t1ftdn84tu6dhjdk4vp0wdx` (`Ssn`)
);

DROP TABLE IF EXISTS `FINES`;

CREATE TABLE `FINES` (
  `Fine_amt` double DEFAULT NULL,
  `Paid` bit(1) DEFAULT NULL,
  `Loan_id` int(11) NOT NULL,
  PRIMARY KEY (`Loan_id`),
  CONSTRAINT `FK470ybpk5cg9ddr7aka4f5xs0j` FOREIGN KEY (`Loan_id`) REFERENCES `BOOK_LOANS` (`Loan_id`)
);