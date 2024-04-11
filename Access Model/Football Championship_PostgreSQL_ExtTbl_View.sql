ROLLBACK;
ALTER SESSION CLOSE DATABASE LINK PG;


DROP DATABASE LINK PG;

CREATE DATABASE LINK PG
   CONNECT TO "postgres" IDENTIFIED BY postgres
   USING '(DESCRIPTION =
    (ADDRESS = (PROTOCOL = TCP)(HOST = localhost)(PORT = 1521))
    (CONNECT_DATA =
      (SID = PG)
    )
    (HS = OK)
  )';
    

    ------------------
    
select * from user_db_links;

select 
    "id_player" as id_player,
    "name_player" as name_player,
    "position_played" as position_played,
    "id_team" as id_team
from "player"@PG
 ORDER BY id_player;


CREATE OR REPLACE VIEW players_view AS
select 
     "id_player" as id_player,
    "shirt_number" as shirt_number,
    "transfer_value" as transfer_value,
    "name_player" as name_player,
    "position_played" as position_played,
    "id_team" as id_team
from "player"@PG;

SELECT * FROM players_view ORDER BY id_player;

SELECT * FROM TEAMS;


--DROP TABLE PLAYERS_TEAMS;
CREATE OR REPLACE VIEW PLAYERS_TEAMS AS
select 
    t."ID_TEAM" as id_team,
    t."NAME_TEAM" as name_team,
    -- details
    p.id_player as id_player, 
    p.name_player as name_player,
    p.position_played as position_played
from teams t 
    INNER JOIN players_view p
        ON p.id_team = t.ID_TEAM;
        
SELECT * FROM PLAYERS_TEAMS;