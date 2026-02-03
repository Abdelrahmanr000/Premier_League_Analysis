CREATE DATABASE PL;
GO
USE PL;
GO

ALTER TABLE FactMatch
ADD CONSTRAINT FK_FactMatch_HomeTeam FOREIGN KEY (HomeTeamID) REFERENCES DimTeam(TeamID);

ALTER TABLE FactMatch
ADD CONSTRAINT FK_FactMatch_AwayTeam FOREIGN KEY (AwayTeamID) REFERENCES DimTeam(TeamID);

ALTER TABLE FactMatch
ADD CONSTRAINT FK_FactMatch_Stadium FOREIGN KEY (StadiumID) REFERENCES DimStadium(StadiumID);

ALTER TABLE DimDate
ADD CONSTRAINT PK_DimDate_Date PRIMARY KEY (Date);

ALTER TABLE FactMatch
ADD CONSTRAINT FK_FactMatch_Date FOREIGN KEY (Date) REFERENCES DimDate(Date);

ALTER TABLE FactPlayerPerformance
ADD CONSTRAINT FK_FactPlayerPerformance_Player FOREIGN KEY (PlayerID) REFERENCES DimPlayer(PlayerID);

ALTER TABLE FactPlayerPerformance
ADD CONSTRAINT FK_FactPlayerPerformance_Team FOREIGN KEY (TeamID) REFERENCES DimTeam(TeamID);

EXEC sp_fkeys @fktable_name = 'FactMatch';
