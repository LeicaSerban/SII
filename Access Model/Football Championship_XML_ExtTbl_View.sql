CREATE OR REPLACE DIRECTORY ext_file_ds AS 'C:\Users\Iustinel\Desktop\Master\Anul 2 semestrul 2\Sisteme de Integrare Informationala\Proiect_Football Championship';
GRANT ALL ON DIRECTORY ext_file_ds TO PUBLIC;

SELECT * FROM all_directories;
SELECT * FROM all_directories WHERE directory_name='EXT_FILE_DS';

CREATE OR REPLACE VIEW countries_view AS
select x.countryName, x.countryPopulation
    from XMLTABLE(
        '/countries/country'
        passing xmltype(
            bfilename('EXT_FILE_DS', 'Country_Stadiums_FootballApplication.xml')
            , nls_charset_id('AL32UTF8')
        )
        columns 
              countryName           varchar2(20) path 'countryName'
            , countryPopulation     integer      path 'countryPopulation'
        ) x;
        
SELECT * FROM countries_view;

CREATE OR REPLACE VIEW stadiums_view AS
select x.idStadium, x.nameStadium, x.capacity, x.city
    from xmltable(
        '/countries/country/stadiums/stadium'
        passing xmltype(
            bfilename('EXT_FILE_DS', 'Country_Stadiums_FootballApplication.xml')
            , nls_charset_id('AL32UTF8')
        )
        columns 
              idStadium        integer        path 'idStadium'
            , nameStadium      varchar2(20)   path 'nameStadium'
            , capacity         integer        path 'capacity'
            , city             varchar2(20)   path 'city'
        ) x;
        
SELECT * FROM stadiums_view;

CREATE OR REPLACE VIEW countries_stadiums_all_view AS
WITH
  countries_data AS (
    select xt.*
    from XMLTABLE(
        '/countries/country'
        passing XMLTYPE(
              bfilename('EXT_FILE_DS', 'Country_Stadiums_FootballApplication.xml')
            , nls_charset_id('AL32UTF8')
        )
        columns 
              countryName           varchar2(20) path 'countryName'
            , countryPopulation     integer      path 'countryPopulation'
            , stadiums              XMLTYPE      path 'stadiums'
        ) xt
  ),
  stadiums_data AS (
    SELECT 
        dd.countryName, dd.countryPopulation,
        xt2.idStadium, xt2.nameStadium, xt2.capacity, xt2.city
    FROM   countries_data dd,
           XMLTABLE('/stadiums/stadium'
             PASSING dd.stadiums
             COLUMNS 
              idStadium        integer        path 'idStadium'
            , nameStadium      varchar2(20)   path 'nameStadium'
            , capacity         integer        path 'capacity'
            , city             varchar2(20)   path 'city'
            ) xt2
  )
SELECT * FROM stadiums_data;
---
SELECT * FROM countries_stadiums_all_view;

