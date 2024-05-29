--Dimensions: Championships-Game-Team

CREATE OR REPLACE VIEW OLAP_DIM_CAMPS_GAMES_TEAMS AS
SELECT DISTINCT
    c.id_championship as championship_id, c.name_championship as championship_name,
    g.id_game as game_id, g.city_game as city_game,
    t.id_team as team_id, t.name_team as team_name
FROM championships c
    INNER JOIN games g ON c.id_championship = g.id_championship
    INNER JOIN teams t ON g.id_home_team = t.id_home_team
    INNER JOIN countries_stadiums_all_view CS ON upper(g.stadium_game) = upper(CS.namestadium)
    INNER JOIN players_teams pt ON t.id_team = pt.id_team
;
    
    
    SELECT * FROM OLAP_DIM_CAMPS_GAMES_TEAMS;

---------------------------------------------------------------------------------------
--PIVOT: Championships and games

SELECT * FROM (
    SELECT DISTINCT Name_Championship, id_game
        FROM Championships c
           INNER JOIN Games g
           ON c.id_championship = g.id_championship
) V
PIVOT (
    COUNT(id_game)
    FOR Name_Championship IN (
    'Championship of Spain' AS "Championship of Spain",
    'Championship of Italy' AS "Championship of Italy",
    'Championship of France' AS "Championship of France"))
ORDER BY 1;

------ CONSOLIDATION VIEW -----------------------------------------------------
DROP VIEW OLAP_TOTAL_POSITION_VALUE;

CREATE OR REPLACE VIEW OLAP_TOTAL_POSITION_VALUE AS
SELECT c.name_championship, pv.position_played  
    , SUM (TRANSFER_VALUE) AS TRANSFER_AMOUNT
FROM championships c 
    INNER JOIN GAMES g 
        ON c.ID_CHAMPIONSHIP = g.ID_CHAMPIONSHIP
    INNER JOIN PLAYERS_VIEW pv
        ON g.ID_HOME_TEAM = pv.ID_TEAM
GROUP BY c.name_championship, pv.position_played
;
SELECT * FROM OLAP_TOTAL_POSITION_VALUE
ORDER BY POSITION_PLAYED, TRANSFER_AMOUNT ASC;

--putem vedea cat valoreaza fiecare pozitie a jucatorilor din cadrul unui campionat (de ex. care portari sunt mai scumpi in functie de campionat)

--Hierarchical Dimension Champ Name->city_championship->id_game
CREATE OR REPLACE VIEW Championship_StadiumGames_view AS
SELECT c.id_championship,Name_championship, city_championship, stadium_game, id_game
FROM Championships c
    INNER JOIN Games g ON c.id_championship = g.id_championship;
    
    SELECT * FROM Championship_StadiumGames_view
    ORDER BY 1;

SELECT 
    Name_championship || ' -> ' || City_championship || ' -> ' || id_game AS hierarchical_path,
    City_championship AS scbp,
    ID_game,
    LEVEL AS hlevel,
    CONNECT_BY_ISLEAF AS last_level
FROM 
    Championship_StadiumGames_view
START WITH 
    Name_championship IS NOT NULL
CONNECT BY 
    PRIOR ID_game = ID_game - 1;


----------------------------------------------------------------------

--Analytical view
CREATE OR REPLACE VIEW OLAP_VIEW_VALUE_PLAYER_TEAMS AS
SELECT 
  CASE
    WHEN GROUPING(Name_player) = 1 THEN 'TOTAL ' || Name_team
    ELSE Name_player END AS Name_player,
  CASE 
    WHEN GROUPING(Name_player) = 1 THEN ''
    WHEN GROUPING(Name_team) = 1 THEN 'Subtotal in echipa ' || Name_team
    ELSE Name_team END AS Name_team, 
  SUM(NVL(Transfer_value, 0)) as Transfer_value    
FROM players_teams
GROUP BY CUBE (Name_player, Name_team)
ORDER BY Name_player, Name_team;

SELECT * FROM OLAP_VIEW_VALUE_PLAYER_TEAMS
ORDER BY TRANSFER_VALUE, NAME_TEAM;

SELECT  NAME_TEAM, SUM(TRANSFER_VALUE)
FROM OLAP_VIEW_VALUE_PLAYER_TEAMS
WHERE NAME_TEAM NOT LIKE 'Subtotal%'
GROUP BY NAME_TEAM;


----------------------------------------------------------------------
CREATE OR REPLACE VIEW players_teams AS 
SELECT ID_Player, SHIRT_NUMBER, TRANSFER_Value, NAME_PLAYER, POSITION_PLAYED, P.ID_Team, NAME_TEAM, VALUE_TEAM FROM Players_VIEW P
INNER JOIN Teams T ON P.ID_Team = T.ID_Team;
 

-------------------------------Tables to review---------------------------------------
    SELECT * FROM championships; -- joined
    SELECT * FROM countries_stadiums_all_view; -- joined
    SELECT * FROM players_teams ORDER BY 6;
    SELECT * FROM games ORDER BY 2; -- joined
    SELECT * FROM players_view;
    SELECT * FROM teams;
        