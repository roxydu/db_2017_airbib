DROP DATABASE IF EXISTS airbnb;
CREATE DATABASE airbnb;
USE airbnb;

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
    isPaid BOOLEAN DEFAULT 0,
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
	paymentID INT NOT NULL,
	paymentMethod VARCHAR(32),
    CCNumber CHAR(16),
    nameOnCard VARCHAR(32),
    ccExpDate DATE,
	PRIMARY KEY (paymentID)
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
    paymentID INT,
	PRIMARY KEY (reservationID),
	FOREIGN KEY (reservationID) REFERENCES Reservation(reservationID)
);