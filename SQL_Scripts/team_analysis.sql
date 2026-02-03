-- Team Analysis
-- Top Teams Scored Goals?
SELECT 
    t.Team,
    SUM(CASE WHEN t.TeamID = m.HomeTeamID THEN m.HTG ELSE 0 END +
        CASE WHEN t.TeamID = m.AwayTeamID THEN m.ATG ELSE 0 END) AS TotalGoals
FROM 
    DimTeam t
JOIN FactMatch m
    ON t.TeamID = m.HomeTeamID OR t.TeamID = m.AwayTeamID
GROUP BY 
    t.Team
ORDER BY 
    TotalGoals DESC;


-- Top Teams Have AVG Expected Goals?
SELECT 
    t.Team,
    AVG(CASE WHEN t.TeamID = m.HomeTeamID THEN m.HXG ELSE 0 END +
        CASE WHEN t.TeamID = m.AwayTeamID THEN m.AXG ELSE 0 END) AS AvgExpectedGoals
FROM 
    DimTeam t
JOIN FactMatch m
    ON t.TeamID = m.HomeTeamID OR t.TeamID = m.AwayTeamID
GROUP BY 
    t.Team
ORDER BY 
    AvgExpectedGoals DESC;


-- Red / Yellow Cards by Each Team?
SELECT 
    t.Team,
    SUM(p.CrdY) AS TotalYellowCards,
    SUM(p.CrdR) AS TotalRedCards
FROM 
    FactPlayerPerformance p
JOIN 
    DimTeam t ON p.TeamID = t.TeamID
GROUP BY 
    t.Team
ORDER BY 
    TotalRedCards DESC, TotalYellowCards DESC;


-- Which teams have the best goal difference?
SELECT 
    t.Team,
    SUM(CASE WHEN t.TeamID = m.HomeTeamID THEN m.HTG ELSE 0 END +
        CASE WHEN t.TeamID = m.AwayTeamID THEN m.ATG ELSE 0 END) AS GoalsFor,
    SUM(CASE WHEN t.TeamID = m.HomeTeamID THEN m.ATG ELSE 0 END +
        CASE WHEN t.TeamID = m.AwayTeamID THEN m.HTG ELSE 0 END) AS GoalsAgainst,
    SUM(
        (CASE WHEN t.TeamID = m.HomeTeamID THEN m.HTG ELSE 0 END +
         CASE WHEN t.TeamID = m.AwayTeamID THEN m.ATG ELSE 0 END) 
        -
        (CASE WHEN t.TeamID = m.HomeTeamID THEN m.ATG ELSE 0 END +
         CASE WHEN t.TeamID = m.AwayTeamID THEN m.HTG ELSE 0 END)
    ) AS GoalDifference
FROM 
    DimTeam t
JOIN 
    FactMatch m ON t.TeamID = m.HomeTeamID OR t.TeamID = m.AwayTeamID
GROUP BY 
    t.Team
ORDER BY 
    GoalDifference DESC;


-- Goals And XG Per Each Team?
SELECT 
    t.Team,
    SUM(CASE WHEN t.TeamID = m.HomeTeamID THEN m.HTG ELSE 0 END +
        CASE WHEN t.TeamID = m.AwayTeamID THEN m.ATG ELSE 0 END) AS TotalGoals,
    SUM(CASE WHEN t.TeamID = m.HomeTeamID THEN m.HXG ELSE 0 END +
        CASE WHEN t.TeamID = m.AwayTeamID THEN m.AXG ELSE 0 END) AS TotalxG,
    SUM(
        (CASE WHEN t.TeamID = m.HomeTeamID THEN m.HTG ELSE 0 END +
         CASE WHEN t.TeamID = m.AwayTeamID THEN m.ATG ELSE 0 END)
        -
        (CASE WHEN t.TeamID = m.HomeTeamID THEN m.HXG ELSE 0 END +
         CASE WHEN t.TeamID = m.AwayTeamID THEN m.AXG ELSE 0 END)
    ) AS Goal_xG_Diff
FROM 
    DimTeam t
JOIN 
    FactMatch m ON t.TeamID = m.HomeTeamID OR t.TeamID = m.AwayTeamID
GROUP BY 
    t.Team
ORDER BY 
    TotalGoals DESC;

-- AVG XG
SELECT 
    t.Team,
    COUNT(*) AS MatchesPlayed,
    SUM(CASE WHEN t.TeamID = m.HomeTeamID THEN m.HXG ELSE 0 END +
        CASE WHEN t.TeamID = m.AwayTeamID THEN m.AXG ELSE 0 END) AS TotalxG,
    ROUND(
        1.0 * SUM(CASE WHEN t.TeamID = m.HomeTeamID THEN m.HXG ELSE 0 END +
                      CASE WHEN t.TeamID = m.AwayTeamID THEN m.AXG ELSE 0 END)
        / COUNT(*), 2) AS AvgxG_PerMatch
FROM 
    DimTeam t
JOIN 
    FactMatch m ON t.TeamID = m.HomeTeamID OR t.TeamID = m.AwayTeamID
GROUP BY 
    t.Team
ORDER BY 
    AvgxG_PerMatch DESC;


-- Total Red Cards
SELECT 
    SUM(CrdR) AS TotalRedCards
FROM 
    FactPlayerPerformance;


-- Total Yellow Cards
SELECT 
    SUM(CrdY) AS TotalYellowCards
FROM 
    FactPlayerPerformance;


-- Top 10 Teams Waste Goals??
SELECT TOP 10
    t.Team,
    SUM(CASE WHEN t.TeamID = m.HomeTeamID THEN m.HXG ELSE 0 END +
        CASE WHEN t.TeamID = m.AwayTeamID THEN m.AXG ELSE 0 END) AS TotalxG,
    SUM(CASE WHEN t.TeamID = m.HomeTeamID THEN m.HTG ELSE 0 END +
        CASE WHEN t.TeamID = m.AwayTeamID THEN m.ATG ELSE 0 END) AS TotalGoals,
    SUM(
        (CASE WHEN t.TeamID = m.HomeTeamID THEN m.HXG ELSE 0 END +
         CASE WHEN t.TeamID = m.AwayTeamID THEN m.AXG ELSE 0 END)
        -
        (CASE WHEN t.TeamID = m.HomeTeamID THEN m.HTG ELSE 0 END +
         CASE WHEN t.TeamID = m.AwayTeamID THEN m.ATG ELSE 0 END)
    ) AS WastedGoals
FROM 
    DimTeam t
JOIN 
    FactMatch m ON t.TeamID = m.HomeTeamID OR t.TeamID = m.AwayTeamID
GROUP BY 
    t.Team
HAVING 
    SUM(
        (CASE WHEN t.TeamID = m.HomeTeamID THEN m.HXG ELSE 0 END +
         CASE WHEN t.TeamID = m.AwayTeamID THEN m.AXG ELSE 0 END)
        -
        (CASE WHEN t.TeamID = m.HomeTeamID THEN m.HTG ELSE 0 END +
         CASE WHEN t.TeamID = m.AwayTeamID THEN m.ATG ELSE 0 END)
    ) > 0
ORDER BY 
    WastedGoals DESC;
