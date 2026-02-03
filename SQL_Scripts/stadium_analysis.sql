-- Stadium Analysis
-- Top Stadiums Have XG
SELECT
	Stadium , ROUND(SUM(HXG + AXG) , 1) AS total_xg
FROM
	DimStadium AS DS
JOIN
	FactMatch AS FM ON FM.StadiumID = DS.StadiumID
GROUP BY
	Stadium
ORDER BY
	total_xg DESC;


-- Top Stadiums Have AVG Attendance
SELECT
	Stadium , SUM(Attendance) AS total_attendance
FROM
	DimStadium AS DS
JOIN
	FactMatch AS FM ON FM.StadiumID = DS.StadiumID
GROUP BY
	Stadium
ORDER BY
	total_attendance DESC;


-- Top Teams Have AVG HTG
SELECT
	Team , SUM(HTG) AS home_team_goals
FROM
	DimTeam AS DT
JOIN
	FactMatch AS FM ON FM.HomeTeamID = DT.TeamID
GROUP BY
	Team
ORDER BY
	home_team_goals DESC;




-- Weeks by Total Attendance
SELECT
	[Week] , SUM(Attendance) AS total_attendance
FROM
	DimDate AS DD
JOIN
	FactMatch AS FM ON FM.Date = DD.Date
GROUP BY
	[Week]
ORDER BY
	total_attendance DESC;


-- Total HTG
SELECT SUM(HTG) AS home_team_goals FROM FactMatch;

-- Total ATG
SELECT SUM(ATG) AS away_team_goals FROM FactMatch;

-- Total Attendance
SELECT SUM(Attendance) AS total_attendance FROM FactMatch;

-- Total HTG
SELECT ROUND(SUM(HXG + AXG) , 1) AS total_xg FROM FactMatch;
