CREATE TABLE branch (
  branchNo CHAR(5) PRIMARY KEY,
  street VARCHAR(35),
  city VARCHAR(10),
  postcode VARCHAR(10)
);

INSERT INTO branch
  (branchNo, street, city, postcode)
VALUES
  ('B005', '22 Deer Rd', 'London', 'SW1 4EH'),
  ('B007', '16 Argyll St', 'Aberdeen', 'AB2 3SU'),
  ('B003', '163 Main St', 'Glasgow', 'G11 9QX'),
  ('B004', '32 Manse Rd', 'Bristol', 'BS99 1NZ'),
  ('B002', '56 Clover Dr', 'London', 'NW10 6EU');

CREATE TABLE staff (
  staffNo CHAR(5) PRIMARY KEY,
  fName VARCHAR(10),
  lName VARCHAR(10),
  position VARCHAR(10),
  sex CHAR(1),
  dob DATE,
  salary INT,
  branchNo CHAR(5),
  FOREIGN KEY (branchNo) REFERENCES branch(branchNo) ON DELETE SET NULL
);

INSERT INTO staff
  (staffNo, fName, lName, position, sex, dob, salary, branchNo)
VALUES
  ('SL21', 'John', 'White', 'Manager', 'M', '1965-10-01', 30000, 'B005'),
  ('SG37', 'Ann', 'Beech', 'Assistant', 'F', '1980-11-10', 12000, 'B003'),
  ('SG14', 'David', 'Ford', 'Supervisor', 'M', '1978-03-24', 18000, 'B003'),
  ('SA9', 'Mary', 'Howe', 'Assistant', 'F', '1990-02-19', 9000, 'B007'),
  ('SG5', 'Susan', 'Brand', 'Manager', 'F', '1960-06-03', 24000, 'B003'),
  ('SL41', 'Julie', 'Lee', 'Assistant', 'F', '1985-06-13', 9000, 'B005');

CREATE TABLE privateOwner (
  ownerNo CHAR(5) PRIMARY KEY,
  fName VARCHAR(10),
  lName VARCHAR(10),
  address VARCHAR(50),
  telNo CHAR(15),
  email VARCHAR(50),
  password VARCHAR(40)
);

INSERT INTO privateOwner
  (ownerNo, fName, lName, address, telNo, email)
VALUES
  ('CO46', 'Joe', 'Keogh', '2 Fergus Dr. Aberdeen AB2 ', '01224-861212', 'jkeogh@lhh.com'),
  ('CO87', 'Carol', 'Farrel', '6 Achray St. Glasgow G32 9DX', '0141-357-7419', 'cfarrel@gmail.com'),
  ('CO40', 'Tina', 'Murphy', '63 Well St. Glasgow G42', '0141-943-1728', 'tinam@hotmail.com'),
  ('CO93', 'Tony', 'Shaw', '12 Park Pl. Glasgow G4 0QR', '0141-225-7025', 'tony.shaw@ark.com');

CREATE TABLE propertyForRent (
  propertyNo CHAR(5) PRIMARY KEY,
  street VARCHAR(35),
  city VARCHAR(10),
  postcode VARCHAR(10),
  type VARCHAR(10),
  rooms SMALLINT,
  rent INT,
  ownerNo CHAR(5) NOT NULL,
  staffNo CHAR(5),
  branchNo CHAR(5),
  FOREIGN KEY (ownerNo) REFERENCES privateOwner(ownerNo) ON DELETE CASCADE,
  FOREIGN KEY (staffNo) REFERENCES staff(staffNo) ON DELETE SET NULL,
  FOREIGN KEY (branchNo) REFERENCES branch(branchNo) ON DELETE SET NULL
);

INSERT INTO propertyForRent
  (propertyNo, street, city, postcode, type, rooms, rent, ownerNo, staffNo, branchNo)
VALUES
  ('PA14', '16 Holhead', 'Aberdeen', 'AB7 5SU', 'House',6,650, 'CO46', 'SA9', 'B007'),
  ('PL94', '6 Argyll St', 'London', 'NW2', 'Flat',4,400, 'CO87', 'SL41', 'B005'),
  ('PG4', '6 Lawrence St', 'Glasgow', 'G11 9QX', 'Flat',3,350, 'CO40', NULL, 'B003'),
  ('PG36', '2 Manor Rd', 'Glasgow', 'G32 4QX', 'Flat',3,375, 'CO93', 'SG37', 'B003'),
  ('PG21', '18 Dale Rd', 'Glasgow', 'G12', 'House',5,600, 'CO87', 'SG37', 'B003'),
  ('PG16', '5 Novar Dr', 'Glasgow', 'G12 9AX', 'Flat',4,450, 'CO93', 'SG14', 'B003');

CREATE TABLE client (
  clientNo CHAR(5) PRIMARY KEY,
  fName VARCHAR(10),
  lName VARCHAR(10),
  telNo CHAR(15),
  prefType VARCHAR(10),
  maxRent INT,
  email VARCHAR(50)
);

INSERT INTO client
  (clientNo, fName, lName, telNo, prefType, maxRent, email)
VALUES
  ('CR76', 'John', 'Kay', '0171-774-5632', 'Flat', 425, 'john.kay@gmail.com'),
  ('CR56', 'Aline', 'Steward', '0141-848-1825', 'Flat', 350, 'astewart@hotmail.com'),
  ('CR74', 'Mike', 'Ritchie', '01475-943-1728', 'House', 750, 'mritchie@yahoo.co.uk'),
  ('CR62', 'Mary', 'Tregear', '01224-196720', 'Flat', 600, 'maryt@hotmail.co.uk');

CREATE TABLE viewing(
  clientNo CHAR(5) NOT NULL,
  propertyNo CHAR(5) NOT NULL,
  viewDate DATE,
  comment VARCHAR(15),
  PRIMARY KEY (clientNo, propertyNo),
  FOREIGN KEY (clientNo) REFERENCES client(clientNo) ON DELETE CASCADE,
  FOREIGN KEY (propertyNo) REFERENCES propertyForRent(propertyNo) ON DELETE CASCADE
);

INSERT INTO viewing
  (clientNo, propertyNo, viewDate, comment)
VALUES
  ('CR56', 'PA14', '2015-05-24', 'too small'),
  ('CR76', 'PG4', '2015-04-20', 'too remote'),
  ('CR56', 'PG4', '2015-05-26', ''),
  ('CR62', 'PA14', '2015-05-14', 'no dining room'),
  ('CR56', 'PG36', '2015-04-28', '');

CREATE TABLE registration (
  clientNo CHAR(5) NOT NULL,
  branchNo CHAR(5) NOT NULL,
  staffNo CHAR(5) NOT NULL,
  dateJoined DATE,
  FOREIGN KEY (clientNo) REFERENCES client(clientNo) ON DELETE CASCADE,
  FOREIGN KEY (branchNo) REFERENCES branch(branchNo) ON DELETE CASCADE,
  FOREIGN KEY (staffNo) REFERENCES staff(staffNo) ON DELETE CASCADE
);

INSERT INTO registration
  (clientNo, branchNo, staffNo, dateJoined)
VALUES
  ('CR76', 'B005', 'SL41', '2015-01-13'),
  ('CR56', 'B003', 'SG37', '2014-04-13'),
  ('CR74', 'B003', 'SG37', '2013-11-16'),
  ('CR62', 'B007', 'SA9', '2014-03-07');
