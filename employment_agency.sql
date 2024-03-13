-- -----------------------------------------------------
-- Database employment_agency
-- -----------------------------------------------------
DROP DATABASE IF EXISTS `employment_agency`;
CREATE DATABASE `employment_agency`;
USE `employment_agency`; -- This line clarifies that the tables created in following lines belong to this database

-- -----------------------------------------------------
-- Table `Employer`
-- -----------------------------------------------------

CREATE TABLE `Employer` (
  `idEmployer` INT NOT NULL AUTO_INCREMENT,
  `EmployerName` VARCHAR(255) NOT NULL,
  `EmpPhoneNum` VARCHAR(15) NOT NULL,
  `EmpEmail` VARCHAR(255) NOT NULL,
  `EmpDescription` VARCHAR(255) NULL,
  `EmpWebsite` VARCHAR(255) NULL,
  PRIMARY KEY (`idEmployer`),
  INDEX (`idEmployer`)
);

-- -----------------------------------------------------
-- Table `Applicant`
-- -----------------------------------------------------

CREATE TABLE `Applicant` (
  `idApplicant` INT NOT NULL AUTO_INCREMENT,
  `FirstName` VARCHAR(255) NOT NULL,
  `LastName` VARCHAR(255) NOT NULL,
  `DOB` DATE NOT NULL,
  `City` VARCHAR(255) NOT NULL,
  `PhoneNumber` VARCHAR(15) NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  `CV` BLOB NULL,
  PRIMARY KEY (`idApplicant`),
  INDEX (`idApplicant`)
);


-- -----------------------------------------------------
-- Table `Position`
-- -----------------------------------------------------
CREATE TABLE `Position` (
  `idPosition` INT NOT NULL AUTO_INCREMENT,
  `JobTitle` VARCHAR(255) NOT NULL,
  `JobDescription` VARCHAR(512) NOT NULL,
  `Pay` DECIMAL(9,2) NOT NULL,
  `idCompany` INT NOT NULL,
  `PostDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Location` VARCHAR(255) NULL,
  `Modality` ENUM('Online', 'Hybrid', 'In-person') NOT NULL,
  `CloseDate` DATE NOT NULL,
  `IsOpen` BOOLEAN NOT NULL,
  `ContractType` VARCHAR(80) NOT NULL,
  PRIMARY KEY (`idPosition`),
  INDEX (`idPosition`),
  INDEX (`idCompany`),
  FOREIGN KEY (`idCompany`) REFERENCES `Employer`(`idEmployer`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- -----------------------------------------------------
-- Table `Application`
-- -----------------------------------------------------
CREATE TABLE `Application` (
  `idApplication` INT NOT NULL AUTO_INCREMENT,
  `idApplicant` INT NOT NULL,
  `idPosition` INT NOT NULL,
  `ApplicationDate` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Attachment` BLOB NULL,
  `AppStatus` ENUM('Applied', 'Accepted', 'Rejected') NOT NULL,
  PRIMARY KEY (`idApplication`),
  INDEX (`idApplication`),
  INDEX (`idApplicant`),
  INDEX (`idPosition`),
  FOREIGN KEY (`idApplicant`) REFERENCES `Applicant` (`idApplicant`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (`idPosition`) REFERENCES `Position` (`idPosition`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table `JobTag`
-- -----------------------------------------------------
CREATE TABLE `JobTag` (
  `idJobTag` INT NOT NULL AUTO_INCREMENT,
  `TagName` VARCHAR(255) NOT NULL,
  `TagDescription` VARCHAR(512) NULL,
  PRIMARY KEY (`idJobTag`),
  INDEX (`idJobTag`)
);

-- -----------------------------------------------------
-- Table `Position-JobTag` (Junction table)
-- -----------------------------------------------------
CREATE TABLE `Position-JobTag` (
  `idJobTag` INT NOT NULL,
  `idPosition` INT NOT NULL,
  PRIMARY KEY (`idJobTag`, `idPosition`),
  INDEX (`idJobTag`),
  INDEX (`idPosition`),
  FOREIGN KEY (`idPosition`) REFERENCES `Position` (`idPosition`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (`idJobTag`) REFERENCES `JobTag` (`idJobTag`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);


-- -----------------------------------------------------
-- Table `Certification`
-- -----------------------------------------------------
CREATE TABLE `Certification` (
  `idCertification` INT NOT NULL AUTO_INCREMENT,
  `Title` VARCHAR(255) NOT NULL,
  `Provider` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`idCertification`),
  INDEX (`idCertification`)
);

-- -----------------------------------------------------
-- Table `UniqueCertificate`
-- -----------------------------------------------------
CREATE TABLE `UniqueCertificate` (
  `idCertification` INT NOT NULL,
  `idApplicant` INT NOT NULL,
  `UniqueCertifNo` VARCHAR(10) NOT NULL,
  `CertifDate` DATE NOT NULL,
  PRIMARY KEY (`UniqueCertifNo`),
  INDEX (`UniqueCertifNo`),
  INDEX (`idCertification`),
  INDEX (`idApplicant`),
  FOREIGN KEY (`idCertification`) REFERENCES `Certification` (`idCertification`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  FOREIGN KEY (`idApplicant`) REFERENCES `Applicant` (`idApplicant`)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

-- Inserting Applicant records
INSERT INTO `Applicant`
	(FirstName, LastName, DOB, City, PhoneNumber, Email) 
VALUES
	('Sebastian', 'Jones', '2003-01-01', 'Belfast', '7554897865','sebastian@gmail.com'),
    ('John', 'Smith', '1990-05-15', 'London', '7456789012', 'john05@gmail.com'),
	('Emily', 'Johnson', '1985-09-20', 'Manchester', '7445678901', 'emily20johnson@hotmail.com'),
	('Michael', 'Davis', '1992-03-10', 'Dublin', '7712345678', 'michaeldavis@outlook.com'),
	('Sarah', 'Williams', '1988-11-25', 'Glasgow', '7556789012', 'sarahw@gmail.com'),
	('David', 'Brown', '1995-07-03', 'Belfast', '7723456789', 'davidb@hotmail.com'),
	('Jessica', 'Martinez', '1990-02-18', 'Edinburgh', '7567890123', 'jessica90@gmail.com'),
	('Matthew', 'Taylor', '1987-06-30', 'Cardiff', '7434567890', 'matthew.t@outlook.com'),
	('Amanda', 'Garcia', '1993-09-12', 'Liverpool', '7401234567', 'agarcia@hotmail.com'),
	('Daniel', 'Rodriguez', '1989-04-05', 'Dublin', '7789012345', 'daniel0405@gmail.com'),
	('Ashley', 'Lopez', '1991-08-22', 'Birmingham', '7467890123', 'ashley.lopez22@icloud.com'),
	('Christopher', 'Martinez', '1986-12-07', 'Manchester', '7456789012', 'c.martinez@outlook.com'),
	('Jennifer', 'Hernandez', '1994-01-14', 'Glasgow', '7578901234', 'jennifer.h@gmail.com'),
	('James', 'Gonzalez', '1983-10-29', 'Cardiff', '7445678901', 'james2910@hotmail.com'),
	('Elizabeth', 'Perez', '1990-05-15', 'Edinburgh', '7512345678', 'elizabeth15@gmail.com'),
	('Ryan', 'Sanchez', '1988-09-20', 'Liverpool', '7401234567', 'rsanchez09@hotmail.com'),
	('Megan', 'Torres', '1995-03-10', 'Belfast', '7723456789', 'megant03@gmail.com'),
	('Kevin', 'Rivera', '1992-11-25', 'Birmingham', '7467890123', 'k.rivera@hotmail.com'),
	('Lauren', 'Evans', '1987-07-03', 'London', '7456789012', 'lauren.e07@icloud.com'),
	('Justin', 'Morales', '1993-02-18', 'Manchester', '7456789012', 'justin.morales@outlook.com'),
	('Samantha', 'Reyes', '1989-06-30', 'Dublin', '7712345678', 'samantha1989@gmail.com'),
	('Brandon', 'Lee', '1985-09-12', 'Cardiff', '7445678901', 'brandonlee@hotmail.com'),
	('Nicole', 'Nguyen', '1991-07-03', 'Edinburgh', '7512345678', 'nicolenguyen@gmail.com'),
	('Tyler', 'Chen', '1990-11-25', 'Liverpool', '7401234567', 'tylerchen@hotmail.com'),
	('Kayla', 'Wong', '1994-05-15', 'Belfast', '7723456789', 'kayla.wong@gmail.com'),
	('Alexander', 'Kim', '1988-03-10', 'Birmingham', '7467890123', 'alexander88@hotmail.com'),
	('Hannah', 'Tran', '1995-08-22', 'London', '7456789012', 'hannah2208@gmail.com'),
	('Andrew', 'Wu', '1986-12-07', 'Manchester', '7456789012', 'andrew234@outlook.com'),
	('Taylor', 'Chang', '1993-01-14', 'Glasgow', '7578901234', 't14chang@hotmail.com'),
	('Victoria', 'Cheng', '1983-10-29', 'Cardiff', '7445678901', 'victoria.cheng@gmail.com'),
	('Robert', 'Wang', '1990-05-15', 'Edinburgh', '7512345678', 'robertwang@hotmail.com'),
    ('Sophia', 'Smith', '2002-05-15', 'London', '7456789012', 'sophia05smith@gmail.com'),
	('Oliver', 'Johnson', '2001-09-20', 'Manchester', '7445678901', 'oliver.john20@hotmail.com'),
	('Amelia', 'Davis', '2003-03-10', 'Dublin', '7712345678', 'amelia.d10@outlook.com'),
	('Harry', 'Williams', '2000-11-25', 'Glasgow', '7556789012', 'harrywilliams@gmail.com'),
	('Ava', 'Brown', '2005-07-03', 'Belfast', '7723456789', 'ava2005@hotmail.com'),
	('Noah', 'Martinez', '2004-02-18', 'Edinburgh', '7567890123', 'nmartinez@gmail.com'),
	('Olivia', 'Taylor', '2002-06-30', 'Cardiff', '7434567890', 'otaylor06@outlook.com'),
	('George', 'Garcia', '2003-09-12', 'Liverpool', '7401234567', 'ggarcia1209@hotmail.com'),
	('Isla', 'Rodriguez', '2001-04-05', 'Dublin', '7789012345', 'irodriguez@gmail.com'),
	('Mia', 'Lopez', '2000-08-22', 'Birmingham', '7467890123', 'mia.lopez20@icloud.com'),
	('Leo', 'Martinez', '2005-12-07', 'Manchester', '7456789012', 'leo.mart12@outlook.com'),
	('Poppy', 'Hernandez', '2003-01-14', 'Glasgow', '7578901234', 'poppypoppyh14@gmail.com'),
	('Jacob', 'Gonzalez', '2002-10-29', 'Cardiff', '7445678901', 'jacobgg10@hotmail.com'),
	('Isabella', 'Perez', '2001-05-15', 'Edinburgh', '7512345678', 'isabellaperez01@gmail.com'),
	('Charlie', 'Sanchez', '2000-09-20', 'Liverpool', '7401234567', 'csanchez2000@hotmail.com'),
	('Freya', 'Torres', '2005-03-10', 'Belfast', '7723456789', 'freya0310@gmail.com'),
	('Jacob', 'Rivera', '2004-11-25', 'Birmingham', '7467890123', 'jrivera@hotmail.com'),
	('Ella', 'Evans', '2003-07-03', 'London', '7456789012', 'e03evans@icloud.com'),
	('Archie', 'Morales', '2002-02-18', 'Manchester', '7456789012', 'archie.morales@outlook.com'),
	('Lily', 'Reyes', '2000-06-30', 'Dublin', '7712345678', 'lilyr30@gmail.com');

-- -------------------------------------
-- Inserting Employer records
INSERT INTO `Employer`
	(EmployerName, EmpPhoneNum, EmpEmail, EmpDescription, EmpWebsite) 
VALUES
	('Big Technologies', '2349548981', 'apply@bigtech.com', 'We are a tech company, striving for a big future', 'www.bigtech.com'),
	('Brite Education', '4567890123', 'applications@briteed.co', 'Education provider across UK. Now hiring!', 'www.briteeducation.com'),
	('HealthFirst Meds', '3216540987', 'hiring@healthfirst.com', 'Health comes first', 'www.healthfirstpharma.com'),
	('Sunshine Solar Company', '6543219870', 'application@sunshinesolar.co', 'Solar panel experts', 'www.sunshinesolarsolutions.com'),
	('Technnovations', '9874563210', 'hr@technnovate.com', NULL, 'www.itechnnovate.com'),
	('FutureWave Systems', '6543211870', 'apply@futurewave.co', NULL, 'www.futurewavesystems.com'),
	('InfinityTech', '7896543210', 'applications@infinitytech.com', 'The technological opportunities are Infinite', 'www.infinitytechcorp.com'),
	('Viral Tech', '4567891230', 'hiring@viraltech.co', 'Technology everyone is using', 'www.viraltech.com'),
	('Small Moon Solutions', '3216547890', 'jobs@smallmoon.com', 'We do tech solutions.', 'www.smallmoon.com'),
    ('Sunflower Electronics', '6543219870', 'application@sunflowerel.co', 'Making the hardware of the future', 'www.sunflowerelectronics.com');
    
-- -------------------------------------
-- Inserting Certification records
INSERT INTO `Certification`
	(Title, Provider) 
VALUES
	('Repository Pro Certificate', 'The Git Academy'),
    ('Project Manager Certification', 'Professional Certification Institute'),
	('Network Associate Certificate', 'TechPro Academy'),
	('Solutions Expert Certification', 'CyberGuard Certifications'),
	('Scrum Master Certificate', 'Professional Certification Institute'),
	('AWS Solutions Architect Certificate', 'TechPro Academy'),
	('Information Security Certification', 'CyberGuard Certifications'),
	('Computer Technician Certificate', 'The Certifications Company'),
	('Ethical Hacker Certification', 'CyberGuard Certifications'),
	('Information Systems Auditor Certification', 'The Certifications Company'),
	('Project Management Professional Certificate', 'Professional Certification Institute'),
	('Information Security Manager Certificate', 'CyberGuard Certifications'),
	('Information Privacy Professional Certification', 'Professional Certification Institute'),
	('Financial Analyst Certificate', 'Professional Certification Institute'),
	('Red Hat Engineer Certification', 'The Certifications Company');

-- -------------------------------------
-- Inserting JobTag records
INSERT INTO `JobTag`
	(TagName, TagDescription) 
VALUES
	('Python', 'High-level coding language for fast development'),
    ('Marketing', 'Promotion of products or services'),
	('Finance', 'Management of money and investments'),
	('Accounting', 'Recording, analyzing, and reporting transactions'),
	('Human Resources', 'Management of personnel'),
	('Customer Service', 'Assistance to customers'),
	('Sales', 'Selling goods or services to customers'),
	('Project Management', 'Planning, organizing, and overseeing projects'),
	('Leadership', 'Guiding a team to achieve goals'),
	('Communication Skills', 'Communicating assertively and effectively'),
    ('JavaScript', 'Dynamic scripting language for web development'),
	('SQL', 'Structured Query Language for relational databases'),
	('C++', 'General-purpose programming languag'),
	('PHP', 'Server-side scripting language for web development'),
    ('Git', 'Version control system for tracking changes in code'),
	('HTML5', 'Latest version of HTML'),
	('CSS3', 'Latest version of CSS');
  
-- -------------------------------------
-- Inserting Position records
-- (requires existing employer)
INSERT INTO `Position`
	(JobTitle, JobDescription, Pay, idCompany, PostDate, Location, Modality, CloseDate, IsOpen, ContractType) 
VALUES
	('Software Intern','Be a python developer intern!','20000','1','2023-12-12','Belfast','Hybrid','2024-02-18',false,'12-month placement'),
    ('Software Engineer', 'Develop and maintain software applications', 60000, 1, '2024-01-10', 'Dublin', 'Hybrid', '2024-04-15', true, 'Full-time'),
	('Software Engineer', 'Design software for our company', 32000, 7, '2024-01-22', 'London', 'Hybrid', '2024-03-15', true, 'Part-time'),
	('Data Analyst', 'Analyze and interpret data for insights', 35000, 9, '2024-01-15', NULL, 'Online', '2024-03-20', false, 'Part-time'),
	('Cybersecurity Specialist', 'Protect computer systems from cyber threats', 85000, 6, '2023-12-20', 'Newry', 'In-person', '2024-06-10', true, 'Full-time'),
	('Web Developer', 'Design and develop websites and web applications', 70000, 7, '2024-02-25', NULL, 'Online', '2024-06-30', true, 'Project contract'),
    ('Front-end Developer', 'Design and develop websites using frontend technologies', 72000, 1, '2024-02-25', 'Belfast', 'Hybrid', '2024-06-30', true, 'Full-time'),
	('C++ Senior Developer', 'Program and maintain systems running on C++', 72000, 1, '2024-02-25', 'Belfast', 'In-person', '2024-06-30', true, 'Full-time'),
	('Cloud Solutions Architect', 'Design and implement cloud-based solutions', 90000, 5, '2023-11-01', 'Belfast', 'Hybrid', '2024-01-25', false, 'Full-time'),
	('Machine Learning Engineer', 'Develop algorithms and models for machine learning applications', 95000, 6, '2023-10-05', NULL, 'Online', '2024-05-15', true, 'Full-time'),
	('Network Administrator', 'Manage and maintain computer networks', 75000, 7, '2023-12-10', 'London', 'In-person', '2024-05-05', true, 'Full-time'),
	('DevOps Engineer', 'Automate and streamline software development processes', 85000, 8, '2023-12-15', 'London', 'Hybrid', '2024-02-20', false, 'Full-time'),
	('Software Developer Intern', 'Gain hands-on experience in software development', 30000, 9, '2024-01-20', 'Edinburgh', 'Online', '2024-06-15', true, 'Internship'),
    ('Marketing Manager', 'Develop and execute marketing strategies', 65000, 2, '2024-02-15', 'Dublin', 'In-person', '2024-05-20', true, 'Full-time'),
	('Marketing Assistant', 'Assist the team executing marketing strategies', 45000, 2, '2024-02-15', 'Dublin', 'In-person', '2024-05-20', true, 'Part-time'),
	('Graphic Designer', 'Create visual concepts for communication purposes', 55000, 4, '2023-01-20', 'Cardiff', 'Hybrid', '2023-06-10', false, 'Full-time'),
	('HR Assistant', 'Provide administrative support to HR department', 45000, 10, '2024-03-03', 'Manchester', 'Hybrid', '2024-06-30', true, 'Placement'),
    ('Human Resources Manager', 'Manage HR at the company', 65000, 6, '2024-02-02', 'Newry', 'Hybrid', '2024-05-30', true, 'Full-time'),
    ('Education Coordinator', 'Coordinate educational programs and events', 55000, 2, '2023-12-10', 'Bangor', 'In-person', '2024-04-15', true, 'Full-time'),
	('Instructional Designer', 'Develop and design instructional materials', 60000, 2, '2023-11-15', NULL, 'Online', '2024-05-20', true, 'Full-time'),
    ('Assistant Pharmacist', 'Assist pharmacists in dispensing medications', 32000, 3, '2023-12-20', 'Inverness', 'In-person', '2024-06-10', true, 'Part-time'),
	('Clinical Pharmacist', 'Provide direct patient care in clinical settings', 80000, 3, '2024-02-25', 'Belfast', 'In-person', '2024-06-30', true, 'Full-time'),
    ('Solar Panel Installer', 'Install and maintain solar panel systems', 50000, 4, '2024-02-10', 'London', 'In-person', '2024-04-15', true, 'Full-time'),
    ('Solar Design Engineer', 'Design solar panel systems and optimize energy production', 75000, 4, '2024-01-20', 'Liverpool', 'Hybrid', '2024-03-10', false, 'Full-time'),
    ('Electrical Engineer', 'Design and implement circuits for electrical systems', 75000, 10, '2024-01-21', 'Cardiff', 'In-person', '2024-06-15', true, 'Full-time');
    -- -- -- -- --
    

-- -------------------------------------
-- Inserting Application records
-- (requires existing applicants and positions)
INSERT INTO `Application`
	(idApplicant, idPosition, ApplicationDate, Attachment, AppStatus) 
VALUES
	(3,1,'2024-01-01',NULL,'Accepted'),
    (12, 5, '2024-04-05', NULL, 'Applied'),
	(27, 15, '2024-04-10', NULL, 'Applied'),
	(8, 20, '2024-04-15', NULL, 'Applied'),
	(44, 8, '2024-04-20', NULL, 'Applied'),
	(33, 12, '2024-01-25', NULL, 'Applied'),
	(19, 2, '2024-03-30', NULL, 'Applied'),
	(7, 22, '2024-05-05', NULL, 'Applied'),
	(49, 18, '2024-05-10', NULL, 'Applied'),
	(13, 3, '2024-03-15', NULL, 'Rejected'),
	(38, 10, '2024-05-05', NULL, 'Applied'),
	(22, 25, '2024-05-25', NULL, 'Applied'),
	(5, 17, '2024-04-01', NULL, 'Applied'),
	(31, 7, '2024-04-07', NULL, 'Applied'),
	(17, 23, '2024-04-13', NULL, 'Applied'),
	(44, 13, '2024-04-19', NULL, 'Applied'),
	(1, 6, '2024-04-26', NULL, 'Applied'),
	(29, 21, '2024-05-03', NULL, 'Applied'),
	(11, 9, '2023-12-09', NULL, 'Accepted'),
	(36, 4, '2024-02-16', NULL, 'Accepted'),
	(23, 19, '2024-03-22', NULL, 'Applied'),
	(3, 1, '2024-02-03', NULL, 'Applied'),
	(28, 14, '2024-04-08', NULL, 'Applied'),
	(16, 24, '2024-02-14', NULL, 'Rejected'),
	(42, 11, '2024-04-21', NULL, 'Applied'),
    (42, 10, '2024-05-09', NULL, 'Applied'),
	(43, 14, '2024-05-14', NULL, 'Applied'),
	(44, 18, '2024-05-01', NULL, 'Applied'),
	(45, 22, '2024-05-22', NULL, 'Applied'),
	(46, 23, '2024-03-30', NULL, 'Applied'),
	(44, 1, '2024-01-18', NULL, 'Applied'),
	(48, 5, '2024-05-19', NULL, 'Applied'),
	(49, 9, '2023-12-20', NULL, 'Applied'),
	(29, 9, '2023-12-30', NULL, 'Applied'),
	(30, 13, '2024-06-01', NULL, 'Applied'),
	(31, 17, '2024-05-02', NULL, 'Applied'),
	(32, 21, '2024-05-17', NULL, 'Applied'),
	(33, 25, '2024-05-04', NULL, 'Applied'),
	(34, 3, '2024-03-05', NULL, 'Applied'),
	(35, 7, '2024-05-06', NULL, 'Applied'),
	(36, 11, '2024-05-01', NULL, 'Applied'),
	(37, 15, '2024-05-08', NULL, 'Applied'),
	(37, 19, '2024-04-09', NULL, 'Applied'),
	(39, 23, '2024-03-20', NULL, 'Applied'),
	(40, 2, '2024-04-11', NULL, 'Applied'),
	(41, 6, '2024-05-12', NULL, 'Applied'),
	(27, 1, '2024-01-28', NULL, 'Applied'),
	(28, 5, '2024-04-29', NULL, 'Applied');

-- -------------------------------------
-- Inserting Position-JobTag records
-- (requires existing position and jobtag)
INSERT INTO `Position-JobTag`
	(idPosition, idJobTag) 
VALUES
	(1, 1),
	(2, 11),
	(2, 12),
	(3, 1),
	(3,13),
	(3, 11),
	(4, 12),
	(5, 1),
	(6, 16),
	(6, 17),
	(6, 11),
	(7, 16),
	(7, 17),
	(8, 13),
	(8, 8),
	(10, 1),
	(10, 15),
	(11, 14),
	(11, 11),
	(12, 8),
	(13, 1),
	(14, 2),
	(14, 8),
	(15, 2),
	(17, 5),
	(18, 5),
	(18, 9),
	(19, 10),
	(19, 8),
	(20, 10),
	(21, 10),
	(22, 6),
	(22, 10);

-- -------------------------------------
-- Inserting UniqueCertification records
-- (requires existing certification and applicant)
INSERT INTO `UniqueCertificate`
	(idCertification, idApplicant, UniqueCertifNo, CertifDate) 
VALUES
	(1,11,'GC24502XR1','2022-10-31'),
    (6, 21, 'W1X2Y3Z4A5', '2019-10-24'),
	(7, 22, 'B6C7D8E9F0', '2020-05-08'),
	(8, 30, 'G1H2I3J4K5', '2021-09-01'),
	(9, 1, 'L6M7N8O9P0', '2022-02-15'),
	(10, 25, 'Q1R2S3T4U5', '2023-07-11'),
	(11, 21, 'V6W7X8Y9Z0', '2019-11-13'),
	(12, 27, 'A1B2C3D4E5', '2020-02-05'),
	(13, 28, 'F6G7H8I9J0', '2021-06-20'),
	(14, 22, 'K1L2M3N4O5', '2022-10-14'),
	(15, 33, 'P6Q7R8S9T0', '2023-03-09'),
	(1, 31, 'U1V2W3X4Y5', '2019-08-21'),
	(1, 32, 'Z6A7B8C9D0', '2020-01-11'),
	(1, 41, 'E1F2G3H4I5', '2021-05-04'),
	(6, 34, 'J6K7L8M9N0', '2022-09-28'),
	(10, 33, 'O1P2Q3R4S5', '2023-02-21'),
	(6, 36, 'T6U7V8W9X0', '2019-12-15'),
	(7, 37, 'Y1Z2A3B4C5', '2020-03-08'),
	(8, 44, 'D6E7F8G9H0', '2021-07-12'),
	(9, 38, 'I1J2K3L4M5', '2022-11-05'),
	(10, 40, 'N6O7P8Q9R0', '2023-04-01'),
	(11, 50, 'S1T2U3V4W5', '2019-09-14');

-- Important to allow GROUP BY statements that do not include all attributes
SET SESSION sql_mode = (SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));

-- Full-time jobs that are currently open
CREATE VIEW FulltimeJobs AS
SELECT
	JobTitle, 
    JobDescription, 
    Pay, 
    EmployerName, 
    PostDate, 
    Location, 
    CloseDate 
FROM Position LEFT JOIN Employer ON idCompany = idEmployer
WHERE IsOpen = True AND ContractType = "Full-time";


-- Jobs ordered by company, showing amount of applications received per job position
CREATE VIEW AppsPerJob AS
SELECT 
	idCompany,
	EmployerName AS Company,
    JobTitle As JobPosition,
    Position.idPosition,
    Pay,
    Location,
    Modality,
    ContractType,
    COUNT(idApplication) AS Applications
FROM Position 
LEFT JOIN Application ON Application.idPosition = Position.idPosition 
LEFT JOIN Employer ON idCompany = idEmployer
GROUP BY Location, idCompany, Position.idPosition
ORDER BY idCompany, Location;


-- Applications where the applicant has at least one certificate
CREATE VIEW AppsWithCertifs AS
SELECT
	idApplication, 
    FirstName, 
    LastName,
    Email,
    CV,
    Attachment,
    COUNT(UniqueCertifNo) AS Certifications,
	ApplicationDate,
    AppStatus,
    JobTitle,
    EmployerName AS Company
FROM Applicant 
INNER JOIN UniqueCertificate ON Applicant.idApplicant = UniqueCertificate.idApplicant 
LEFT JOIN Certification ON UniqueCertificate.idCertification = Certification.idCertification
INNER JOIN Application ON Applicant.idApplicant = Application.idApplicant
LEFT JOIN Position ON Application.idPosition = Position.idPosition
LEFT JOIN Employer ON Position.idCompany = Employer.idEmployer
GROUP BY Applicant.idApplicant, Application.idApplication
ORDER BY Applicant.idApplicant;

-- Job positions that close between March and May
CREATE VIEW MarchMayJobs AS
SELECT 
	JobTitle, 
    JobDescription, 
    Pay, 
    EmployerName, 
    Location, 
    Modality, 
    CloseDate, 
    IsOpen, 
    ContractType 
FROM Position 
LEFT JOIN Employer ON idCompany = idEmployer
WHERE DATE(CloseDate) BETWEEN '2024-03-01' AND '2024-05-31'
ORDER BY CloseDate ASC;