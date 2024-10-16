# Creación de la database
CREATE DATABASE IF NOT EXISTS ramaderes2;
#DROP DATABASE ramaderes2;
USE ramaderes2;

# Creo la estructura de la tabla aimportar
CREATE TABLE IF NOT EXISTS explotacions(
	marca_oficial VARCHAR(15),
	codi_rega VARCHAR(30),
    estat_explot VARCHAR(10),
    data_canvi_estat VARCHAR(20),
    nom_explot VARCHAR(255),
    direccio VARCHAR(255),
    codi_postal VARCHAR(10),
    servei_territorial VARCHAR(255),
    provincia VARCHAR(50),
    comarca VARCHAR(50),
    municipi VARCHAR(50),
    coor_x VARCHAR(20),
    coor_y VARCHAR(20),
    latitud VARCHAR(255),
    longitud VARCHAR(255),
    tipus VARCHAR(255),
    especie VARCHAR(255),
    subespecie VARCHAR(255),
    tipus_subexp VARCHAR(255),
    estat_subexp VARCHAR(255),
    data_canvi_estat_subexp VARCHAR(255),
    integradora VARCHAR(255),
    nom_ads VARCHAR(255), 
    classif_zootecnica VARCHAR(255),
    data_class_zoo VARCHAR(255),
    forma_de_cria VARCHAR(255),
    autoconsum VARCHAR(255),
    sistema_productiu VARCHAR(255),
    criteri_de_sostenibilitat VARCHAR(255),
    petita_capacitat VARCHAR(255),
    capacitat_productiva VARCHAR(255),
    codi_zootecnic VARCHAR(255),
    capacitat_ponedores INT,
    capacitat_femelles INT,
    capacitat_altres_femelles INT,
    capacitat_mascles INT,
    capacitat_cria INT,
    capacitat_animals_menos_1_any INT,
    capacitat_reposicio INT,
    capacitat_braves_mayor_24 INT,
    capacitat_animals_mayor_1_any_i_menor_2_anys INT,
    capacitat_engreix INT,
    capacitat_recria INT,
    capacitat_transicio INT,
    capacitat_estants INT,
    capacitat_transhumants INT,
    capacitat_an_mayor_6m_no_repr INT,
    capacitat_ous INT,
    cap_total_animals INT,
    total_ponedores INT,
    total_URM INT,
    total_Nitrogen INT,
    data_act_capacitat VARCHAR(255)
);


# Importo los datos del archiv csv
LOAD DATA LOCAL INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ramaderes.csv'
INTO TABLE explotacions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES;

#TRUNCATE explotacions;
#DROP TABLE explotacions;
SELECT * FROM explotacions;
DESCRIBE explotacions;

# Paso a minúsculas
UPDATE explotacions
SET 
    marca_oficial = LOWER(marca_oficial),
    codi_rega = LOWER(codi_rega),
    estat_explot = LOWER(estat_explot),
	nom_explot = LOWER(nom_explot),
	direccio = LOWER(direccio),
	codi_postal = LOWER(codi_postal),
	servei_territorial= LOWER(servei_territorial),
    provincia = LOWER(provincia),
    comarca = LOWER(comarca),
    municipi = LOWER(municipi),
	tipus = LOWER(tipus),
	especie = LOWER(especie),
	subespecie = LOWER(subespecie),
	tipus_subexp = LOWER(tipus_subexp),
	estat_subexp = LOWER(estat_subexp),
	integradora = LOWER(integradora),
	nom_ads = LOWER(nom_ads),
	classif_zootecnica = LOWER(classif_zootecnica),
	forma_de_cria = LOWER(forma_de_cria),
	sistema_productiu = LOWER(sistema_productiu),
	criteri_de_sostenibilitat = LOWER(criteri_de_sostenibilitat);


# me da error. hay que habilitar el local_infile =1 (ON).
SHOW VARIABLES LIKE 'local_infile';
SET GLOBAL local_infile = 1;
SELECT * FROM explotacions;


#Voy a separar los datos en diferentes tablas. Primero creo las tablas de DIMENTSIONES.

# 1) tabla de los datos de las explotaciones
CREATE TABLE IF NOT EXISTS dades_explotacions AS
SELECT DISTINCT codi_rega, marca_oficial, nom_explot, direccio, codi_postal, 
				servei_territorial, provincia, comarca, municipi, 
                coor_x, coor_y, latitud, longitud
FROM explotacions;
# DROP TABLE dades_explotacions;
# 1.0) Compruebo como ha quedado la tabla
SELECT * FROM dades_explotacions;
# 1.1) me queda crear la primary key. Primero miro que campo va a ser clave primario 
SELECT count(DISTINCT marca_oficial), count(DISTINCT codi_rega), count(*)
FROM dades_explotacions;
ALTER TABLE dades_explotacions MODIFY COLUMN codi_rega VARCHAR(30) PRIMARY KEY;
# 1.2) comprobar que se ha creado la primary key
DESCRIBE dades_explotacions;

# SET foreign_key_checks = 0;
SELECT comarca, coor_x, coor_y
FROM dades_explotacions;
DESCRIBE dades_explotacions;

# 1.3) Al ver que las coordenadas no son correctas. No ha cargado los ceros de la derecha.
# elimino el punto decimal
UPDATE dades_explotacions
SET coor_x = REPLACE(coor_x, '.', '');

# añadimos primero los ceros que faltan.
UPDATE dades_explotacions
SET coor_x = RPAD(coor_x, 8, '0')
WHERE LENGTH(coor_x) < 8;

# la coordenada x ha de tener 7dígitos a la izquierda y 1dígito a la derecha del separador decimal.
UPDATE dades_explotacions
SET coor_x= CONCAT(LEFT(coor_x, LENGTH(coor_x) -1), '.', RIGHT(coor_x, 1))
WHERE coor_x REGEXP '^[0-9]+$';

ALTER TABLE dades_explotacions MODIFY COLUMN coor_x DECIMAL(10,1);

# 1.4) Ahora haremos el mismo proceso para la coordenada y.Debemos tener (8dig , 1dig)

# añadimos primero los ceros que faltan.
UPDATE dades_explotacions
SET coor_y = RPAD(coor_y, 9, '0')
WHERE LENGTH(coor_y) < 9;

# la coordenada y ha de tener 8dígitos a la izquierda y 1dígito a la derecha del separador decimal.
UPDATE dades_explotacions
SET coor_y= CONCAT(LEFT(coor_y, LENGTH(coor_y) -1), '.', RIGHT(coor_y, 1))
WHERE coor_y REGEXP '^[0-9]+$';

# ALTER TABLE dades_explotacions MODIFY COLUMN coor_y DECIMAL(9,1);

# 2) tabla condición explotación integrada. Creo la segunda tabla de dimensiones.
CREATE TABLE IF NOT EXISTS integrada AS
SELECT DISTINCT integradora
FROM explotacions;

# 2.1) Creo el ID de esta tabla que será la primary Key
ALTER TABLE integrada ADD COLUMN ID_integrada INT auto_increment PRIMARY KEY;
# 2.2) Compruebo los cambios
SELECT * FROM integrada;
# 2.3) doy valores a los campos en blanco
#UPDATE `ramaderes`.`integrada` SET `integradora` = 'NA' WHERE (`ID_integrada` = '1');
# 2.4) Comprueba que Se ha creado la primary key
DESCRIBE integrada;

# 3) Creo la tabla de dimensiones con los datos de asociaciones sanitarias
CREATE TABLE ass_sanitat AS
SELECT DISTINCT nom_ads
FROM explotacions;

# 3.1) Creo el ID de esta tabla que será la primary Key
ALTER TABLE ass_sanitat ADD COLUMN ID_sanitat INT auto_increment PRIMARY KEY;
# 3.2) Compruebo los cambios
SELECT * FROM ass_sanitat;
# 3.3) doy valores a los campos en blanco
# UPDATE ass_sanitat SET nom_ads = 'NA' WHERE ID_sanitat = 1;
# 3.4) Comprueba que Se ha creado la primary key
DESCRIBE ass_sanitat;

#4) creo una nueva tabla de tipos_explotacion. CUARTA TABLA DE DIMENSIONES
CREATE TABLE IF NOT EXISTS tipus_explotacio AS
SELECT marca_oficial,
	codi_rega,
    estat_explot,
    data_canvi_estat,
    tipus,
    especie,
    subespecie,
    tipus_subexp,
    estat_subexp,
    data_canvi_estat_subexp,
	classif_zootecnica,
    data_class_zoo,
    forma_de_cria,
    autoconsum,
    sistema_productiu,
    criteri_de_sostenibilitat,
    codi_zootecnic,
    data_act_capacitat
FROM explotacions;

# 4.1) Compruebo como ha quedado la tabla
SELECT * FROM tipus_explotacio;
# 4.2) Creo la PRIMARY KEY de esta tabla
ALTER TABLE tipus_explotacio ADD COLUMN ID_tipus_explotacio INT auto_increment PRIMARY KEY;
# 4.3) compruebo que se ha realizado el cambio
DESCRIBE tipus_explotacio;

# 5) Creo la tabla de HECHOS, que se llama produccio.
CREATE TABLE IF NOT EXISTS produccio AS
SELECT marca_oficial, codi_rega,
	integradora,
	nom_ads, 
    especie,
    subespecie,
	petita_capacitat,
    capacitat_productiva,
    capacitat_ponedores, 
    capacitat_femelles,
    capacitat_altres_femelles,
    capacitat_mascles,
    capacitat_cria,
    capacitat_animals_menos_1_any,
    capacitat_reposicio,
    capacitat_braves_mayor_24,
    capacitat_animals_mayor_1_any_i_menor_2_anys,
    capacitat_engreix,
    capacitat_recria,
    capacitat_transicio,
    capacitat_estants,
    capacitat_transhumants,
    capacitat_an_mayor_6m_no_repr,
    capacitat_ous,
    cap_total_animals,
    total_ponedores,
    total_URM,
    total_Nitrogen
FROM explotacions;
#DROP TABLE produccio;
#DESCRIBE produccio;

# 5.1) modifico los datos en la tabla de hechos
CREATE TABLE IF NOT EXISTS produccio2 AS
SELECT produccio.marca_oficial, produccio.codi_rega,
	ID_tipus_explotacio,
	integradora,
	nom_ads, 
    produccio.especie,
    produccio.subespecie,
	petita_capacitat,
    capacitat_productiva,
    capacitat_ponedores, 
    capacitat_femelles,
    capacitat_altres_femelles,
    capacitat_mascles,
    capacitat_cria,
    capacitat_animals_menos_1_any,
    capacitat_reposicio,
    capacitat_braves_mayor_24,
    capacitat_animals_mayor_1_any_i_menor_2_anys,
    capacitat_engreix,
    capacitat_recria,
    capacitat_transicio,
    capacitat_estants,
    capacitat_transhumants,
    capacitat_an_mayor_6m_no_repr,
    capacitat_ous,
    cap_total_animals,
    total_ponedores,
    total_URM,
    total_Nitrogen
FROM produccio 
JOIN tipus_explotacio
ON tipus_explotacio.codi_rega = produccio.codi_rega
WHERE tipus_explotacio.especie = produccio.especie 
		and  tipus_explotacio.subespecie = produccio.subespecie;

DROP TABLE produccio;
RENAME TABLE produccio2 to produccio;
SHOW TABLES;

# 5.2) modifico los datos en la tabla de hechos. cambio el nombre de los campos que seran claves foráneas.
UPDATE produccio
JOIN integrada ON integrada.integradora = produccio.integradora
SET produccio.integradora = integrada.ID_integrada;

# 5.3) modifico los datos en la tabla de hechos
UPDATE produccio
JOIN ass_sanitat ON ass_sanitat.nom_ads = produccio.nom_ads
SET produccio.nom_ads = ass_sanitat.ID_sanitat;


# 5.3) Cambio los nombres de los campos que seran clave foránea
SELECT * FROM produccio;
ALTER TABLE produccio RENAME COLUMN codi_rega to codi_rega_id;
ALTER TABLE produccio RENAME COLUMN integradora to integrada_id;
ALTER TABLE produccio RENAME COLUMN nom_ads to sanitat_id;
ALTER TABLE produccio DROP COLUMN especie;
ALTER TABLE produccio DROP COLUMN subespecie;
ALTER TABLE produccio DROP COLUMN marca_oficial;

ALTER TABLE produccio RENAME COLUMN ID_tipus_explotacio to tipus_explotacio_id;

ALTER TABLE produccio ADD COLUMN ID int auto_increment PRIMARY KEY;
DESCRIBE produccio;

ALTER TABLE produccio
ADD CONSTRAINT FOREIGN KEY (codi_rega_id) REFERENCES dades_explotacions(codi_rega);

ALTER TABLE produccio
ADD CONSTRAINT FOREIGN KEY (tipus_explotacio_id) REFERENCES tipus_explotacio(ID_tipus_explotacio);

ALTER TABLE produccio
MODIFY COLUMN sanitat_id INT;
ALTER TABLE produccio
ADD CONSTRAINT FOREIGN KEY (sanitat_id) REFERENCES ass_sanitat(ID_sanitat);

ALTER TABLE produccio
MODIFY COLUMN integrada_id INT;
ALTER TABLE produccio
ADD CONSTRAINT FOREIGN KEY (integrada_id) REFERENCES integrada(ID_integrada);
DESCRIBE produccio;

# cambiar al tipo de dato correcto (fechas)
# sustituir los valores en blanco

SHOW TABLES;

# busco los valores nulos y los sustituyo
UPDATE tipus_explotacio
SET subespecie = 'NoAplica'
WHERE subespecie = '';

SELECT * FROM tipus_explotacio;
SELECT subespecie FROM tipus_explotacio;
SELECT classif_zootecnica FROM tipus_explotacio;
SELECT forma_de_cria FROM tipus_explotacio;

UPDATE tipus_explotacio
SET classif_zootecnica = 'NoAplica'
WHERE classif_zootecnica = '';

UPDATE tipus_explotacio
SET forma_de_cria = 'NoAplica'
WHERE forma_de_cria = '';

UPDATE tipus_explotacio
SET autoconsum = 'NoAplica'
WHERE autoconsum = '';

UPDATE tipus_explotacio
SET sistema_productiu = 'NoAplica'
WHERE sistema_productiu = '';

UPDATE tipus_explotacio
SET criteri_de_sostenibilitat = 'NoAplica'
WHERE criteri_de_sostenibilitat = '';

UPDATE tipus_explotacio
SET codi_zootecnic = 'NoAplica'
WHERE codi_zootecnic = '';

# busco los valores nulos 
SHOW TABLES;
SELECT * FROM ass_sanitat;
UPDATE ass_sanitat
SET nom_ads = 'NoAplica'
WHERE nom_ads = '';

SELECT * FROM integrada;
UPDATE integrada
SET integradora = 'NoAplica'
WHERE integradora = '';

SELECT * FROM produccio;
UPDATE produccio
SET capacitat_productiva = 'NoAplica'
WHERE capacitat_productiva = '';

# cambiar al tipo de dato correcto (fechas)
SHOW TABLES;
SELECT * FROM produccio;
SELECT * FROM tipus_explotacio;

#data_canvi_estat_subexp
#data_class_zoo
#data_act_capacitat
DESCRIBE tipus_explotacio;
SELECT * FROM tipus_explotacio;

# modificación columna de fecha: 'data_canvi_estat'
UPDATE tipus_explotacio
SET data_canvi_estat = STR_TO_DATE(data_canvi_estat, '%d/%m/%Y');
ALTER TABLE tipus_explotacio MODIFY COLUMN data_canvi_estat date;

# modificación columna de fecha: 'data_canvi_estat_subexp'
UPDATE tipus_explotacio 
SET data_canvi_estat_subexp = NULL 
WHERE data_canvi_estat_subexp = '';

UPDATE tipus_explotacio
SET data_canvi_estat_subexp = STR_TO_DATE(data_canvi_estat_subexp, '%Y/%m/%d')
WHERE data_canvi_estat_subexp IS NOT NULL;
ALTER TABLE tipus_explotacio MODIFY COLUMN data_canvi_estat_subexp date;

# modificación columna de fecha: data_class_zoo
UPDATE tipus_explotacio 
SET data_class_zoo = NULL 
WHERE data_class_zoo = '';

UPDATE tipus_explotacio
SET data_class_zoo = STR_TO_DATE(data_class_zoo, '%d/%m/%Y')
WHERE data_class_zoo IS NOT NULL;
ALTER TABLE tipus_explotacio MODIFY COLUMN data_canvi_estat_subexp date;

# modificación columna de fecha: data_act_capacitat
UPDATE tipus_explotacio 
SET data_act_capacitat = NULL 
WHERE data_act_capacitat = '';

UPDATE tipus_explotacio
SET data_act_capacitat = STR_TO_DATE(data_act_capacitat, '%d/%m/%Y')
WHERE data_act_capacitat IS NOT NULL;
ALTER TABLE tipus_explotacio MODIFY COLUMN data_act_capacitat date;

# Quiero cambiar los datos de los campos con valor NoAplica a Altres de 
# los gráficos que represento en el dashboarb para que quede mejor
USE ramaderes2;

UPDATE tipus_explotacio
SET sistema_productiu = 'Altres'
WHERE sistema_productiu = 'NoAplica';

UPDATE tipus_explotacio
SET criteri_de_sostenibilitat = 'Altres'
WHERE criteri_de_sostenibilitat = 'NoAplica';

UPDATE tipus_explotacio
SET subespecie = 'Altres'
WHERE subespecie = 'NoAplica';

SELECT DISTINCT subespecie FROM tipus_explotacio;


# Selección de especies: mar y rio

SELECT DISTINCT especie, forma_de_cria FROM tipus_explotacio;
SELECT * FROM tipus_explotacio;
SELECT * FROM explotacions;
SELECT * FROM dades_explotacions;
SELECT * FROM ass_sanitat;
DESCRIBE tipus_explotacio;





