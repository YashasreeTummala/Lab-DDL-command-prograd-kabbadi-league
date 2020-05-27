--DDL COMMANDS
--CREATING MULTIPLE TABLES INCLUDING RELATIONSHIP

create table city
(id NUMBER(11), 
name varchar(50) NOT NULL,
CONSTRAINT city_pk PRIMARY KEY(id));

create table referee
(id NUMBER(11), 
name varchar(50) NOT NULL,
CONSTRAINT referee_pk PRIMARY KEY(id));

create table innings
(id NUMBER(11), 
innings_number int NOT NULL,
CONSTRAINT innings_pk PRIMARY KEY(id));

create table extra_type
(id NUMBER(11), 
name varchar(50) NOT NULL,
CONSTRAINT extra_type_pk PRIMARY KEY(id));

create table skill
(id NUMBER(11), 
name varchar(50) NOT NULL,
CONSTRAINT skill_pk PRIMARY KEY(id));

create table team
(id NUMBER(11), 
name varchar(50) NOT NULL,
coach varchar(50) NOT NULL,
home_city NUMBER(11) NOT NULL,
captain NUMBER(11) NOT NULL,
CONSTRAINT team_pk PRIMARY KEY(id),
CONSTRAINT team_fk FOREIGN KEY (home_city) REFERENCES city(id));

create table player
(id NUMBER(11), 
name varchar(50) NOT NULL ,
country varchar(50) NOT NULL,
skill_id NUMBER(11) NOT NULL,
team_id NUMBER(11) NOT NULL,
CONSTRAINT player_pk PRIMARY KEY(id),
CONSTRAINT player_fk1 FOREIGN KEY (skill_id) REFERENCES skill(id),
CONSTRAINT player_fk2 FOREIGN KEY (team_id) REFERENCES team(id));

create table venue
(id NUMBER(11) NOT NULL, 
stadium_name varchar(50) NOT NULL,
city_id NUMBER(11),
CONSTRAINT venue_pk PRIMARY KEY(id),
CONSTRAINT venue_fk FOREIGN KEY (city_id) REFERENCES city(id));

create table event
(id NUMBER(11),
innings_id NUMBER(11) NOT NULL,
event_no NUMBER(11) NOT NULL,
raider_id NUMBER(11) NOT NULL,
raider_points NUMBER(11) NOT NULL,
defending_points NUMBER(11) NOT NULL,
clock_in_seconds NUMBER(11) NOT NULL,
team_one_score NUMBER(11) NOT NULL,
team_two_score NUMBER(11) NOT NULL,
CONSTRAINT event_pk PRIMARY KEY(id),
CONSTRAINT event_fk1 FOREIGN KEY (innings_id) REFERENCES innings(id),
CONSTRAINT event_fk2 FOREIGN KEY (raider_id) REFERENCES player(id));

create table extra_event
(id NUMBER(11), 
event_id NUMBER(11) NOT NULL,
extra_type_id NUMBER(11) NOT NULL,
points NUMBER(11) NOT NULL,
scoring_team_id NUMBER(11) NOT NULL,
CONSTRAINT extra_event_pk PRIMARY KEY(id),
CONSTRAINT extra_event_fk1 FOREIGN KEY (event_id) REFERENCES event(id),
CONSTRAINT extra_event_fk2 FOREIGN KEY (extra_type_id) REFERENCES extra_type(id),
CONSTRAINT extra_event_fk3 FOREIGN KEY (scoring_team_id) REFERENCES team(id));

create table outcome
(id INT, 
status varchar(100) NOT NULL,
winner_team_id NUMBER(11),
score NUMBER(11),
player_of_match NUMBER(11),
CONSTRAINT outcome_pk PRIMARY KEY(id),
CONSTRAINT outcome_fk1 FOREIGN KEY (winner_team_id) REFERENCES team(id),
CONSTRAINT outcome_fk2 FOREIGN KEY (player_of_match) REFERENCES player(id));

create table game
(id INT,
game_date DATE NOT NULL,
team_id_1 NUMBER(11) NOT NULL,
team_id_2 NUMBER(11) NOT NULL,
venue_id NUMBER(11) NOT NULL,
outcome_id NUMBER(11) NOT NULL,
referee_id_1 NUMBER(11) NOT NULL,
referee_id_2 NUMBER(11) NOT NULL,
first_innings_id NUMBER(11) NOT NULL,
second_innings_id NUMBER(11) NOT NULL,
CONSTRAINT game_pk PRIMARY KEY(id),
CONSTRAINT game_fk1 FOREIGN KEY (team_id_1) REFERENCES team(id),
CONSTRAINT game_fk2 FOREIGN KEY (team_id_2) REFERENCES team(id),
CONSTRAINT game_fk3 FOREIGN KEY (venue_id) REFERENCES venue(id),
CONSTRAINT game_fk4 FOREIGN KEY (outcome_id) REFERENCES outcome(id),
CONSTRAINT game_fk5 FOREIGN KEY (referee_id_1) REFERENCES referee(id),
CONSTRAINT game_fk6 FOREIGN KEY (referee_id_2) REFERENCES referee(id),
CONSTRAINT game_fk7 FOREIGN KEY (first_innings_id) REFERENCES innings(id),
CONSTRAINT game_fk8 FOREIGN KEY (second_innings_id) REFERENCES innings(id));

-- DELETING TABLES BY EXCLUDING ALL DEPENDENCIES

alter table team
drop column home_city;

alter table venue
drop column city_id;

drop table city;

alter table event
drop column innings_id;

alter table game
drop column first_innings_id;

alter table game
drop column second_innings_id;

drop table innings;

alter table player
drop column skill_id;

drop table skill;

alter table extra_event
drop column extra_type_id;

drop table extra_type;
