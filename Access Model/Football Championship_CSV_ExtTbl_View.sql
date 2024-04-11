CREATE OR REPLACE DIRECTORY ext_file_ds AS 'C:\Users\Iustinel\Desktop\Master\Anul 2 semestrul 2\Sisteme de Integrare Informationala\Proiect_Football Championship';
GRANT ALL ON DIRECTORY ext_file_ds TO PUBLIC;

SELECT * FROM all_directories;

DROP TABLE Games;
CREATE TABLE Games (
  id_game           NUMBER,
  id_championship   NUMBER,
  id_home_team      NUMBER,
  id_away_team      NUMBER,
  city_game         VARCHAR2(200),
  stadium_game      VARCHAR2(200)
)
ORGANIZATION EXTERNAL (
  TYPE ORACLE_LOADER
  DEFAULT DIRECTORY ext_file_ds
  ACCESS PARAMETERS (
    RECORDS DELIMITED BY NEWLINE SKIP 1
    FIELDS TERMINATED BY ','
    MISSING FIELD VALUES ARE NULL
  )
  LOCATION ('Games_FootballApplication.csv')
)
REJECT LIMIT UNLIMITED;

SELECT * FROM Games;