DROP TABLE Championships;

CREATE TABLE Championships (
    id_Championship   NUMBER NOT NULL,
    name_Championship VARCHAR (200),
    id_Location       NUMBER,
    city_Championship VARCHAR (200),
    stadium_Location  NUMBER
);

INSERT INTO Championships (id_Championship, name_Championship, id_Location, city_Championship, stadium_Location)
VALUES (1, 'Championship of Spain', 1, 'Barcelona', 1);
INSERT INTO Championships (id_Championship, name_Championship, id_Location, city_Championship, stadium_Location)
VALUES (1, 'Championship of Spain', 2, 'Madrid', 2);
INSERT INTO Championships (id_Championship, name_Championship, id_Location, city_Championship, stadium_Location)
VALUES (2, 'Championship of France', 3, 'Paris', 4);
INSERT INTO Championships (id_Championship, name_Championship, id_Location, city_Championship, stadium_Location)
VALUES (2, 'Championship of France', 4, 'Lyon', 6);
INSERT INTO Championships (id_Championship, name_Championship, id_Location, city_Championship, stadium_Location)
VALUES (3, 'Championship of Italy', 5, 'Rome', 8);
INSERT INTO Championships (id_Championship, name_Championship, id_Location, city_Championship, stadium_Location)    
VALUES (3, 'Championship of Italy', 6, 'Bari', 9);

SELECT * FROM Championships;