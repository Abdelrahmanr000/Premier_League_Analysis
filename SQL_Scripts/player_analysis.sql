-- Player Analysis
-- Top Players Have Contributions
SELECT
	Player , 
	SUM(Ast + Gls) AS total_contributions 
FROM 
	FactPlayerPerformance AS FPP
JOIN
	DimPlayer AS DP ON DP.PlayerID = FPP.PlayerID
GROUP BY
	DP.Player
ORDER BY
	total_contributions DESC;


-- Top Players Have Progressive Carries
SELECT
	Player , SUM(PrgC) AS total_progressive_carries
FROM 
	DimPlayer AS DP
JOIN
	FactPlayerPerformance AS FPP ON DP.PlayerID = FPP.PlayerID
GROUP BY
	DP.Player
ORDER BY
	total_progressive_carries DESC;


-- Top Players Have Progressive Passes
SELECT 
	Player , SUM(Prgp) AS total_progressive_passes
FROM 
	DimPlayer AS DP
JOIN
	FactPlayerPerformance AS FPP ON DP.PlayerID = FPP.PlayerID
GROUP BY
	DP.Player
ORDER BY
	total_progressive_passes DESC;


-- Top Players Have Non-Penalty xG
SELECT
	Player , ROUND(SUM(npxG) , 1) AS non_penalties_xg
FROM 
	DimPlayer AS DP
JOIN
	FactPlayerPerformance AS FPP ON DP.PlayerID = FPP.PlayerID
GROUP BY
	Player
ORDER BY
	non_penalties_xg DESC;


-- Top Players Waste Goals
SELECT
    DP.Player,
    ROUND(SUM(FPP.xG) , 1) AS Total_xG,
    SUM(FPP.Gls) AS Total_Goals,
    ROUND(SUM(FPP.xG) ,	1) - SUM(FPP.Gls) AS Missed_Chances
FROM 
    DimPlayer AS DP
JOIN 
    FactPlayerPerformance AS FPP ON DP.PlayerID = FPP.PlayerID
GROUP BY 
    DP.Player
ORDER BY 
    Missed_Chances DESC;


-- Top Players Exploited Chances
SELECT
    DP.Player,
    SUM(FPP.Gls) AS Total_Goals,
    ROUND(SUM(FPP.xG) , 1) AS Total_xG,
    SUM(FPP.Gls) - ROUND(SUM(FPP.xG) , 1) AS Exploited_Chances
FROM 
    DimPlayer AS DP
JOIN 
    FactPlayerPerformance AS FPP ON DP.PlayerID = FPP.PlayerID
GROUP BY 
    DP.Player
ORDER BY 
    Exploited_Chances DESC;



-- Total Foreign Players
SELECT COUNT(*) AS total_foreign_players FROM DimPlayer
WHERE Nation <> 'ENG';


-- Total Players Under 20
SELECT COUNT(*) AS total_players_under20 FROM DimPlayer
WHERE Age < 20;


-- Total Players Above 30
SELECT COUNT(*) AS total_players_above30 FROM DimPlayer
WHERE Age > 30;


-- Total Progressive Runs by Players
SELECT SUM(PrgR) AS total_progressive_runs FROM FactPlayerPerformance;
