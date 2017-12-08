DROP DATABASE IF EXISTS airbnb;
CREATE DATABASE airbnb;
USE airbnb;

# create tables 

DROP TABLE IF EXISTS Host;
create table Host (
	hostID INT NOT NULL,
	hostName VARCHAR(32),
	hostPhoneNo VARCHAR(32),
	hostEmail VARCHAR(32),
    hostBankName VARCHAR(32),
    hostBankAccountNo VARCHAR(32),
	PRIMARY KEY(hostID)
);

DROP TABLE IF EXISTS House;
create table House (
	hostID INT NOT NULL,
	houseID INT NOT NULL,
	houseAddress VARCHAR(100),
	houseRate FLOAT,
    maxOccupancy INT,
	PRIMARY KEY (hostID, houseID),
    FOREIGN KEY (hostID) REFERENCES Host(hostID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Amenities;
create table Amenities (
	hostID INT NOT NULL,
	houseID INT NOT NULL,
    wifi BOOLEAN DEFAULT 0,
    parking BOOLEAN DEFAULT 0,
    kitchen BOOLEAN DEFAULT 0,
    pet_friendly BOOLEAN DEFAULT 0,
    washer BOOLEAN DEFAULT 0,
    dryer BOOLEAN DEFAULT 0,
	PRIMARY KEY (hostID,houseID),
	FOREIGN KEY (hostID,houseID) REFERENCES House(hostID,houseID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS Guest;
create table Guest (
	guestID INT NOT NULL,
    guestName VARCHAR(32),
    guestPhoneNo VARCHAR(32),
    guestEmail VARCHAR(32),
	PRIMARY KEY (guestID)
);

DROP TABLE IF EXISTS Reservation;
create table Reservation (
	reservationID INT NOT NULL,
    numberGuests INT,
    checkInDate DATE,
    checkOutDate DATE,
    isCanceled BOOLEAN DEFAULT 0,
    billDate DATE,
    billAmount FLOAT,
	PRIMARY KEY (reservationID)
);

DROP TABLE IF EXISTS Reviews;
create table Reviews (
	reviewID INT NOT NULL,
	stars INT,
    comments VARCHAR(100),
	PRIMARY KEY (reviewID)
);

DROP TABLE IF EXISTS madeNpaidBy;
create table madeNpaidBy (
	guestID INT NOT NULL,
    reservationID INT NOT NULL,
    CCNumber CHAR(16),
    nameOnCard VARCHAR(32),
    ccExpDate DATE,
	PRIMARY KEY (guestID, reservationID),
    FOREIGN KEY (guestID) REFERENCES Guest(guestID) ON DELETE CASCADE,
	FOREIGN KEY (reservationID) REFERENCES Reservation(reservationID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS views;
create table views (
	guestID INT,
	hostID INT,
    houseID INT,
	PRIMARY KEY (guestID,hostID,houseID),
	FOREIGN KEY (guestID) REFERENCES Guest(guestID) ON DELETE CASCADE,
	FOREIGN KEY (hostID,houseID) REFERENCES House(hostID,houseID) ON DELETE CASCADE
);


DROP TABLE IF EXISTS hostedBy;
create table hostedBy (
	hostID INT,
    houseID INT,
	PRIMARY KEY (hostID,houseID),
	FOREIGN KEY (hostID,houseID) REFERENCES House(hostID,houseID) ON DELETE CASCADE
);


DROP TABLE IF EXISTS receives;
create table receives (
	reservationID INT,
    hostID INT,
	PRIMARY KEY (reservationID,hostID),
	FOREIGN KEY (reservationID) REFERENCES Reservation(reservationID) ON DELETE CASCADE,
    FOREIGN KEY (hostID) REFERENCES Host(hostID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS givenTo;
create table givenTo (
	hostID INT,
    houseID INT,
    reviewID INT,
	PRIMARY KEY (hostID,houseID,reviewID),
    FOREIGN KEY (hostID,houseID) REFERENCES House(hostID,houseID) ON DELETE CASCADE,
    FOREIGN KEY (reviewID) REFERENCES Reviews(reviewID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS givenBy;
create table givenBy (
	guestID INT,
    reviewID INT,
	PRIMARY KEY (guestID,reviewID),
    FOREIGN KEY (guestID) REFERENCES Guest(guestID) ON DELETE CASCADE,
    FOREIGN KEY (reviewID) REFERENCES Reviews(reviewID) ON DELETE CASCADE
);

DROP TABLE IF EXISTS linkAll;
create table linkAll (
	reservationID INT,
    hostID INT,
    houseID INT,
    guestID INT,
    reviewID INT,
	PRIMARY KEY (reservationID),
	FOREIGN KEY (reservationID) REFERENCES Reservation(reservationID)
);


# insert values

INSERT INTO `airbnb`.`Host` (`hostID`, `hostName`, `hostPhoneNo`, `hostEmail`, `hostBankName`, `hostBankAccountNo`) 
VALUES ('1', 'Thomas Han', '13195940568', 'thosdfshan@gmail.com', 'U.S. Bank', '1435083051341234'),
('2', 'Shahaed Hasan', '13194540348', 'thomaasdfan@gmail.com', 'Wells Fargo', '1435083051345674'),
('3', 'Paul Taufalele', '13195943523', 'thosdfhomashan@gmail.com', 'MidWest One', '1435083034565424'),
('4', 'John Mauk', '13195934458', 'thomashanthasdfan@gmail.com', 'Bank of America', '1435083026835424'),
('5', 'Emily McGee', '13195945493', 'thoasdfan@gmail.com', 'Chase', '1732083051345424');

INSERT INTO `airbnb`.`House` (`hostID`, `houseID`, `houseAddress`, `houseRate`, `maxOccupancy`) 
VALUES ('1', '1', '404 S. Hello World St., Iowa City, IA 52242', '40', '5'),
('1', '2', '123 S. Hello World St., Iowa City, IA 52242', '33', '6'),
('1', '3', '456 S. Hello World St., Iowa City, IA 52240', '175', '12'),
('3', '4', '23 S. Hello World St., Iowa City, IA 52244', '267', '12'),
('4', '5', '12 S. Hello World St., Iowa City, IA 52243', '167', '5'),
('2', '6', '563 S. Hello World St., Iowa City, IA 52240', '35', '2'),
('2', '7', '856 S. Hello World St., Iowa City, IA 52246', '15', '1'),
('3', '8', '428 S. Hello World St., Iowa City, IA 52244', '23', '2'),
('5', '9', '404 S. Hello World St., Iowa City, IA 52241', '234', '10'),
('4', '10', '41 S. Hello World St., Iowa City, IA 52240', '124', '2');

INSERT INTO `airbnb`.`Amenities` (`hostID`, `houseID`, `wifi`, `parking`, `kitchen`, `pet_friendly`, `washer`, `dryer`)
VALUES ('1', '1', '1', '0', '1', '1', '0', '1'),
('1', '2', '0', '1', '1', '0', '1', '0'),
('1', '3', '0', '1', '0', '0', '1', '0'),
('2', '6', '0', '0', '0', '0', '0', '1'),
('2', '7', '0', '0', '1', '0', '0', '0'),
('3', '4', '1', '0', '0', '1', '1', '0'),
('3', '8', '1', '0', '1', '0', '0', '1'),
('4', '5', '1', '0', '1', '1', '0', '1'),
('4', '10', '1', '0', '1', '1', '0', '1'),
('5', '9', '1', '0', '1', '1', '0', '1');

INSERT INTO `airbnb`.`Guest` (`guestID`, `guestName`, `guestPhoneNo`, `guestEmail`)
VALUES ('1', 'Aaron', '13191233452', 'asdf@gmail.com'),
('2', 'Kate', '13191231234', 'asdf@gmail.com'),
('3', 'Adam', '13191231235', 'asdasdff@gmail.com'),
('4', 'Aaron', '13191234321', 'adsfdf@gmail.com'),
('5', 'Xavier', '13191231237', 'asasfdasddf@gmail.com'),
('6', 'Gabby', '13191236532', 'asdrewef@gmail.com'),
('7', 'Steve', '13191236723', 'asddfsf@gmail.com');

INSERT INTO `airbnb`.`Reservation` (`reservationID`, `numberGuests`, `checkInDate`, `checkOutDate`, `isCanceled`, `billDate`, `billAmount`)
VALUES ('1', '3', '2017-12-01', '2017-12-03', '0', '2017-12-03', '40'),
('2', '23', '2017-12-01', '2017-12-03', '0', '2017-12-03', '234'),
('3', '23', '2017-12-02', '2017-12-03', '0', '2017-12-03', '123'),
('4', '5', '2017-11-01', '2017-11-03', '0', '2017-11-03', '434'),
('5', '12', '2017-02-01', '2017-02-03', '1', '2017-02-03', '123'),
('6', '8', '2017-02-03', '2017-02-05', '0', '2017-02-03', '45'),
('7', '2', '2017-01-01', '2017-01-03', '0', '2017-01-03', '34'),
('8', '4', '2017-01-01', '2017-01-03', '0', '2017-01-03', '1234'),
('9', '6', '2017-02-10', '2017-02-13', '0', '2017-02-13', '432'),
('10', '12', '2017-02-23', '2017-02-25', '0', '2017-02-25', '234'),
('11', '5', '2017-02-15', '2017-02-18', '0', '2017-02-18', '345');

INSERT INTO `airbnb`.`Reviews` (`reviewID`, `stars`, `comments`)
VALUES ('1', '4', 'It was good.'),
('2', '3', 'It was good.'),
('3', '4', 'It was good.'),
('4', '5', 'It was good.'),
('5', '1', 'It was bad.'),
('6', '4', 'It was good.'),
('7', '5', 'It was good.'),
('8', '2', 'It was bad.'),
('9', '3', 'It was good.'),
('10', '3', 'It was bad.'),
('11', '2', 'It was bad.');

INSERT INTO `airbnb`.`madeNpaidBy` (`guestID`,`reservationID`, `CCNumber`, `nameOnCard`, `ccExpDate`)
VALUES ('1','1', '319', 'Thomas', '2021-12-01'),
('2', '2', '319', 'Thomas', '2021-12-01'),
('3','3', '169', 'Google', '2022-12-01'),
('4','4',  '132', 'Siri', '2021-02-01'),
('5','5', '234', 'Amazon', '2021-03-01'),
('6','6',   '245', 'Abby', '2021-05-01'),
('7', '7', '725', 'Aaron', '2021-12-01'),
('1', '8', '567', 'Xavier', '2021-02-01'),
('2', '9','319', 'Steve', '2024-02-02'),
('3','10',  '435', 'Adam', '2019-05-01'),
('4', '11', '123', 'Aaron', '2032-04-01');

INSERT INTO `airbnb`.`views` (`guestID`, `hostID`, `houseID`)
VALUES ('1', '1', '1'),
('2', '1', '2'),
('3', '1', '3'),
('4', '3', '4'),
('5', '4', '5'),
('6', '2', '6'),
('7', '2', '7'),
('3', '3', '8'),
('4', '5', '9'),
('6', '4', '10'),
('2', '3', '4');

INSERT INTO airbnb.hostedBy (hostID, houseID) SELECT hostID, houseID FROM House;

INSERT INTO `airbnb`.`receives` (`reservationID`, `hostID`)
VALUES ('1', '1'),
('2', '4'),
('3', '5'),
('4', '2'),
('5', '3'),
('6', '1'),
('7', '1'),
('8', '4'),
('9', '2'),
('10', '4'),
('11', '2');

INSERT INTO `airbnb`.`givenTo` (`hostID`, `houseID`, `reviewID`)
VALUES ('1', '1', '1'),
('1', '2', '2'),
('1', '3', '3'),
('3', '4', '4'),
('4', '5', '5'),
('2', '6', '6'),
('2', '7', '7'),
('3', '8', '8'),
('5', '9', '9'),
('4', '10', '10'),
('1', '3', '11');

INSERT INTO `airbnb`.`givenBy` (`guestID`, `reviewID`) 
VALUES ('1', '1'),
('1', '2'),
('7', '3'),
('3', '4'),
('4', '5'),
('2', '6'),
('6', '7'),
('7', '8'),
('1', '9'),
('2', '10'),
('5', '11');

INSERT INTO `airbnb`.`linkAll` (`reservationID`, `hostID`, `houseID`, `guestID`, `reviewID`)
VALUES ('1', '1', '1', '1', '1'),
('2', '1', '2', '2', '2'),
('3', '1', '3', '4', '3'),
('4', '3', '4', '3', '4'),
('5', '4', '5', '6', '5'),
('6', '2', '6', '5', '6'),
('7', '2', '7', '7', '7'),
('8', '3', '8', '3', '8'),
('9', '5', '9', '2', '9'),
('10', '4', '10', '4', '10'),
('11', '1', '3', '2', '11');

# queries
Select stars From Reviews R, givenTo GT
where R.reviewID=GT.reviewID and GT.HouseID in
(Select h.HouseID From House h, Amenities a 
Where h.houseId=a.houseID and a.wifi=False);

Select distinct month(Reservation.checkInDate), year(Reservation.checkInDate)
From Reservation,receives,Host
where Host.hostID=receives.hostID
and Reservation.reservationID=receives.reservationID
and Host.hostID in
(Select distinct a.hostID
From House h, Amenities a
where h.hostID=a.hostId
and h.houseAddress like "%Iowa City%"
and h.houseID in
(Select H1.HouseID
From House H1, Amenities A
Where H1.HouseID=A.HouseID
and A.wifi=False));

Select Host.hostName, Sum(Reservation.billAmount) 
From Host, Reservation, receives
Where Host.HostID=receives.HostID
and Reservation.reservationID=receives.reservationID
and Host.HostID in
(Select Host.HostId
From Host,hostedBy
Where Host.HostID=hostedBy.HostID
and hostedBy.houseID in
(Select House.houseID
From House, hostedBy
Where House.houseId=hostedBy.houseId
and House.houseAddress like '%Iowa City%'
))
group by Host.hostName