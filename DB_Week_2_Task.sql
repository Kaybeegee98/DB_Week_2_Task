IF OBJECT_ID('dbo.PLAYERREGISTRATION', 'U') IS NOT NULL
    DROP TABLE dbo.PLAYERREGISTRATION

IF OBJECT_ID('dbo.TEAMENTRY', 'U') IS NOT NULL
    DROP TABLE dbo.TEAMENTRY

IF OBJECT_ID('dbo.PLAYER', 'U') IS NOT NULL
    DROP TABLE dbo.PLAYER

IF OBJECT_ID('dbo.SEASON', 'U') IS NOT NULL
    DROP TABLE dbo.SEASON

IF OBJECT_ID('dbo.CLUB', 'U') IS NOT NULL
    DROP TABLE dbo.CLUB


CREATE TABLE PLAYER (
    PlayerID   INT,
    Fname      NVARCHAR(100) NOT NULL,
    Lname      NVARCHAR(100) NOT NULL,
    Phone      NVARCHAR(100),
    CONSTRAINT PK_PLAYER PRIMARY KEY (PlayerID)
);

CREATE TABLE SEASON (
    SeasonYear  INT,
    SeasonName  NVARCHAR(6)
    CONSTRAINT PK_SEASON PRIMARY KEY (SeasonYear, SeasonName),
    CONSTRAINT CK_SEASONNAME CHECK (SeasonName IN ('WINTER', 'SUMMER'))
);

CREATE TABLE CLUB (
    ClubName    NVARCHAR(100),
    ContactName NVARCHAR(100),
    CONSTRAINT PK_CLUB PRIMARY KEY (ClubName)
);

CREATE TABLE TEAMENTRY (
    ClubName    NVARCHAR(100),
    SeasonYear  INT,
    SeasonName  NVARCHAR(6),
    AgeGroup    NVARCHAR(3),
    TeamNumber  INT,
    Constraint PK_TEAMENTRY PRIMARY KEY (ClubName, SeasonYear, SeasonName, AgeGroup, TeamNumber),
    CONSTRAINT FK_TEAMENTRY_CLUB FOREIGN KEY (ClubName) REFERENCES CLUB(ClubName),
    CONSTRAINT FK_TEAMENTRY_SEASON FOREIGN KEY (SeasonYear, SeasonName) REFERENCES SEASON(SeasonYear, SeasonName)
);

CREATE TABLE PLAYERREGISTRATION (
    PlayerID    INT,
    ClubName    NVARCHAR(100),
    SeasonYear  INT,
    SeasonName  NVARCHAR(6),
    AgeGroup    NVARCHAR(3),
    TeamNumber  INT,
    DataRegistered  DATE,
    CONSTRAINT PK_PLAYERREGISTRATION PRIMARY KEY (PlayerID, ClubName, SeasonYear, SeasonName, AgeGroup, TeamNumber),
    CONSTRAINT FK_PLAYERREGISTRATION_PLAYER FOREIGN KEY (PlayerID) REFERENCES PLAYER(PlayerID),
    CONSTRAINT FK_PLAYERREGISTRATION_TEAMENTRY FOREIGN KEY (ClubName, SeasonYear, SeasonName, AgeGroup, TeamNumber) REFERENCES TEAMENTRY(Clubname, SeasonYear, SeasonName, AgeGroup, TeamNumber)
);



INSERT INTO CLUB (ClubName, ContactName)
VALUES
    ('Mt Martha Basketball Club', 'Bob Jane'),
    ('Sunnyhill Hockey Club', 'Jerry Springer'),
    ('Eastside Rugby Club', 'Joey Tribiani'),
    ('Nerville Wrestlemania Club', 'Hulk Hogan');

INSERT INTO SEASON (SeasonYear, SeasonName)
VALUES
    (2018, 'Winter'),
    (2018, 'Summer'),
    (2019, 'Winter'),
    (2019, 'Summer');

INSERT INTO TEAMENTRY (ClubName, SeasonYear, SeasonName, AgeGroup, TeamNumber)
VALUES
    ('Mt Martha Basketball Club', 2018, 'Summer', 'U14', 1),
    ('Sunnyhill Hockey Club', 2018, 'Winter', 'U18', 2),
    ('Eastside Rugby Club', 2018, 'Winter', 'U14', 3),
    ('Nerville Wrestlemania Club', 2019, 'Summer', 'U18', 4);

INSERT INTO PLAYER (PlayerID, Fname, Lname, Phone)
VALUES
    (10002, 'John', 'Howard', 5552345),
    (10003, 'Julia', 'Gillard', 5553456),
    (10004, 'The', 'Rock', 5554567),
    (10005, 'Wayne', 'Grezsky', 5555678);

INSERT INTO PLAYERREGISTRATION (PlayerID, ClubName, SeasonYear, SeasonName, AgeGroup, TeamNumber, DataRegistered)
VALUES
    (10003, 'Mt Martha Basketball Club', 2018, 'Summer', 'U14', 1, '20180110'),
    (10004, 'Nerville Wrestlemania Club', 2019, 'Summer', 'U18', 4, '20190110'),
    (10005, 'Sunnyhill Hockey Club', 2018, 'Winter', 'U18', 2, '20180610'),
    (10002, 'Eastside Rugby Club', 2018, 'Winter', 'U14', 3, '20180610');
