;-- Hammer sql file
CREATE DATABASE IF NOT EXISTS Hammer DEFAULT CHARACTER SET utf8;
USE Hammer;
;-- Company table
CREATE TABLE IF NOT EXISTS Company(
ID INT NOT NULL AUTO_INCREMENT,
Name VARCHAR(255) NOT NULL,
Remark VARCHAR(1024),
PRIMARY KEY (ID)
)
;-- IP table
CREATE TABLE IF NOT EXISTS IP(
ID INT NOT NULL AUTO_INCREMENT,
Addr VARCHAR(16) NOT NULL,
Comp_ID INT NOT NULL,
PRIMARY KEY (ID),
FOREIGN KEY (Comp_ID) REFERENCES Company(ID)
)
;-- Host table
CREATE TABLE IF NOT EXISTS Host(
ID INT NOT NULL AUTO_INCREMENT,
Value VARCHAR(255) NOT NULL,
Comp_ID INT NOT NULL,
IP_ID INT,
PRIMARY KEY (ID),
FOREIGN KEY (Comp_ID) REFERENCES Company(ID),
FOREIGN KEY (IP_ID) REFERENCES IP(ID)
)
;-- Port table
CREATE TABLE IF NOT EXISTS PORT(
ID INT NOT NULL AUTO_INCREMENT,
Value INT NOT NULL,
IP_ID INT NOT NULL,
PRIMARY KEY (ID),
FOREIGN KEY (IP_ID) REFERENCES IP(ID)
)
;-- Proxy interfaces
CREATE TABLE IF NOT EXISTS Proxy(
ID INT NOT NULL AUTO_INCREMENT,
IP_Addr VARCHAR(16) NOT NULL,
Port INT NOT NULL,
Http_Type VARCHAR(6) NOT NULL,
Address VARCHAR(1024) NOT NULL,
Time INT NOT NULL,
PRIMARY KEY(ID),
UNIQUE KEY UnURL(IP_Addr,Port,Http_Type)
)
;-- Plugin table
CREATE TABLE IF NOT EXISTS Plugin(
ID INT NOT NULL AUTO_INCREMENT,
Name VARCHAR(128) NOT NULL,
Type VARCHAR(64) NOT null,
Author VARCHAR (32) NOT NULL,
Time VARCHAR(11),
Version VARCHAR(8),
Web VARCHAR(128),
Description VARCHAR(512),
Code VARCHAR(20480) NOT NULL,
PRIMARY KEY(ID),
UNIQUE KEY UnName(Name)
)
;-- Scan table
CREATE TABLE IF NOT EXISTS Scan(
ID INT NOT NULL AUTO_INCREMENT,
Url VARCHAR(128) NOT null,
Start_Time INT,
End_Time INT,
-- Parent_ID INT,
Arguments VARCHAR(1024) NOT NULL,
Level INT DEFAULT 0,
User_ID INT NOT NULL,
PRIMARY KEY(ID)
)
;-- Scan Result table
CREATE TABLE IF NOT EXISTS Vuln(
ID INT NOT NULL AUTO_INCREMENT,
Scan_ID INT,
IP_URL VARCHAR(256);
Plugin_ID INT,
Vuln_Info VARCHAR(2048),
Level INT DEFAULT 0,
PRIMARY KEY(ID),
FOREIGN KEY(Plugin_ID) REFERENCES Plugin(ID)
)
;-- User table
CREATE TABLE IF NOT EXISTS User(
ID INT NOT NULL AUTO_INCREMENT,
Name VARCHAR(32) NOT NULL,
Password VARCHAR(32) NOT NULL,
Is_Admin BOOLEAN DEFAULT 0,
Token VARCHAR(64),
PRIMARY KEY(ID)
)

;-- 
INSERT INTO User(Name,Password,Is_Admin) VALUES('admin','7e50507f61f9f3a6d1ce4249819f97ef','1');