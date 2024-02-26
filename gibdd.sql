drop database gibdd;
CREATE DATABASE IF NOT EXISTS gibdd;

USE gibdd;


CREATE TABLE IF NOT EXISTS Driver
(
    Id         INT AUTO_INCREMENT PRIMARY KEY,
    Surname   VARCHAR(45) NOT NULL,
    Name   VARCHAR(45) NOT NULL,
    LastName    VARCHAR(45) NOT NULL,
    PhoneNumber VARCHAR(25) NOT NULL UNIQUE,
    DateOfBirth DATE NOT NULL
);

CREATE TABLE IF NOT EXISTS Brand
(
    Id  INT AUTO_INCREMENT PRIMARY KEY,
    Name  VARCHAR(25) NOT NULL
);

CREATE TABLE IF NOT EXISTS Model
(
    Id  INT AUTO_INCREMENT PRIMARY KEY,
    Name  VARCHAR(45) NOT NULL,
    DateOfIssue YEAR NOT NULL,
    Id_Brand INT NOT NULL,
    FOREIGN KEY (Id_Brand) REFERENCES Brand(Id)
);

CREATE TABLE IF NOT EXISTS Car
(
    Id  INT AUTO_INCREMENT PRIMARY KEY,
    Id_Model INT NOT NULL,
    FOREIGN KEY (Id_Model) REFERENCES Model(Id)
);

CREATE TABLE IF NOT EXISTS Registration_car
(
    Id  INT AUTO_INCREMENT PRIMARY KEY,
    RegistrationNumber VARCHAR(15) NOT NULL,
    Id_Driver INT NOT NULL,
    Id_Car INT NOT NULL,
    FOREIGN KEY (Id_Driver) REFERENCES Driver(Id) ,
    FOREIGN KEY (Id_Car) REFERENCES  Car(Id)
);

CREATE TABLE IF NOT EXISTS TypesOfViolations
(
    Id  INT AUTO_INCREMENT PRIMARY KEY,
    Name  VARCHAR(245) NOT NULL,
    FineAmount INT NOT NULL
);

CREATE TABLE IF NOT EXISTS Employee
(
    Id         INT AUTO_INCREMENT PRIMARY KEY,
    FirstName   VARCHAR(25) NOT NULL,
    LastName    VARCHAR(45) NOT NULL,
    Rank_soldier VARCHAR(45) NOT NULL
);

CREATE TABLE IF NOT EXISTS Violation
(
    Id  INT AUTO_INCREMENT PRIMARY KEY,
    Id_TOV INT NOT NULL,
    Id_Register INT NOT NULL,
    Id_Employee INT NOT NULL,
    Date DATE NOT NULL,
    Status BOOL NOT NULL,
    FOREIGN KEY (Id_TOV) REFERENCES TypesOfViolations(Id),
    FOREIGN KEY (Id_Register) REFERENCES Registration_car(Id),
    FOREIGN KEY (Id_Employee) REFERENCES Employee(Id)
);



CREATE VIEW CarRegistrationView AS
SELECT
    Registration_car.RegistrationNumber,
    Driver.Surname,
    Driver.Name,
    Brand.Name AS Brand,
    Model.Name AS Model,
    Model.DateOfIssue
FROM
    Registration_car
INNER JOIN
    Driver ON Registration_car.Id_Driver = Driver.Id
INNER JOIN
    Car ON Registration_car.Id_Car = Car.Id
INNER JOIN
    Model ON Car.Id_Model = Model.Id
INNER JOIN
    Brand ON Model.Id_Brand = Brand.Id
WHERE Driver.Surname = 'Селиверстов';




