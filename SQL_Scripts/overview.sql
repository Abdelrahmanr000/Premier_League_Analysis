-- overview
-- Top 10 Scorers
SELECT TOP 10
	Player , SUM(Gls) AS TotalGoals
FROM 
	DimPlayer AS DP
JOIN
	FactPlayerPerformance AS FPP ON FPP.PlayerID = DP.PlayerID
GROUP BY
	Player
ORDER BY
	TotalGoals DESC;


-- Top 10 Stadiums by Attendance
SELECT TOP 10
	Stadium , SUM(Attendance) AS TotalAttendance
FROM 
	DimStadium AS DS
JOIN
	FactMatch AS FM ON FM.StadiumID = DS.StadiumID
GROUP BY
	Stadium
ORDER BY
	TotalAttendance DESC;


-- Total Goals By Weeks
SELECT 
	[Week] , SUM(HTG + ATG) AS TotalGoals
FROM 
	DimDate AS Dd
JOIN
	FactMatch AS FM ON FM.Date = DD.Date
GROUP BY
	[Week]
ORDER BY
	TotalGoals DESC;



-- Top 10 Assisters
SELECT TOP 10
	Player , SUM(Ast) AS TotalAssists
FROM 
	DimPlayer AS DP
JOIN
	FactPlayerPerformance AS FPP ON FPP.PlayerID = DP.PlayerID
GROUP BY
	Player
ORDER BY
	TotalAssists DESC;


-- Total Goals
SELECT SUM(Gls) AS TotalGoals FROM FactPlayerPerformance;


-- Total Assists
SELECT SUM(Ast) AS TotalAssists FROM FactPlayerPerformance;


-- Total Attendance
SELECT SUM(Attendance) AS TotalAttendance FROM FactMatch;


-- non-penalties XG
SELECT ROUND(SUM(npxG) , 1) AS np_penalties_xg FROM FactPlayerPerformance;
