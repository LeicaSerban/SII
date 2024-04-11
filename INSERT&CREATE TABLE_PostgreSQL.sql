DROP TABLE Player

CREATE TABLE Player (
	id_player INT,
	shirt_number INT,
	transfer_value INT,
	name_player VARCHAR(255),
	position_played VARCHAR(255),
	id_team INT)

INSERT INTO Player (id_player, shirt_number, transfer_value, name_player, position_played, id_team)
VALUES 
	(1, 1, 43000,'Asaftei', 'Portar', 1),
	(2, 10, 85000 , 'Miorniuc', 'Fundas', 1),
	(3, 90, 57000, 'Ghenea', 'Atacant', 1),
	(4, 1, 59000, 'Gherasim', 'Portar', 2),
	(5, 18, 98000, 'Mutu', 'Fundas', 2),
	(6, 91, 44000, 'Neamtu', 'Atacant', 2),
	(7, 1, 61000,'Gica', 'Portar', 3),
	(8, 15, 131000, 'Rusu', 'Fundas', 3),
	(9, 88, 77000, 'Zaharia', 'Atacant', 3),
	(10, 1, 47000, 'Popescu', 'Portar', 4),
	(11, 22, 88000, 'Ionescu', 'Fundas', 4),
	(12, 40, 65000, 'Stan', 'Atacant', 4),
	(13, 1, 36000,'Dumitrescu', 'Portar', 5),
	(14, 20, 74000, 'Stoica', 'Fundas', 5),
	(15, 45, 52000, 'Vasilescu', 'Atacant', 5),
	(16, 1, 98000, 'Dima', 'Portar', 6),
	(17, 19, 41000, 'Dragomir', 'Fundas', 6),
	(18, 99, 71000, 'Gheorghe', 'Atacant', 6);
	