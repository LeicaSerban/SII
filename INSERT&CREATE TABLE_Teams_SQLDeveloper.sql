CREATE TABLE Teams (
    id_Team NUMBER NOT NULL,
    id_home_team NUMBER,
    id_away_team NUMBER,
    name_team VARCHAR (20),
    value_team NUMBER
);

INSERT INTO Teams (id_Team, id_home_team, id_away_team, name_team, value_team)
VALUES (1, 1, 2, 'Real Maravilla', 120000);
INSERT INTO Teams (id_Team, id_home_team, id_away_team, name_team, value_team)
VALUES (2, 2, 3, 'Barcelona Estrellas', 160000);
INSERT INTO Teams (id_Team, id_home_team, id_away_team, name_team, value_team)
VALUES (3, 3, 4, 'Olympique Lumiere', 200000);
INSERT INTO Teams (id_Team, id_home_team, id_away_team, name_team, value_team)
VALUES (4, 4, 5, 'Paris Eclatant', 240000);
INSERT INTO Teams (id_Team, id_home_team, id_away_team, name_team, value_team)
VALUES (5, 5, 6, 'Juventus Stella', 280000);
INSERT INTO Teams (id_Team, id_home_team, id_away_team, name_team, value_team)
VALUES (6, 6, 7, 'Milan Vittoria', 260000);