------------------------------------------------------------
--        Script Postgre 
------------------------------------------------------------



------------------------------------------------------------
-- Table: LOCATION
------------------------------------------------------------
CREATE TABLE public.LOCATION(
	id_location   SERIAL NOT NULL ,
	latitude      FLOAT  NOT NULL ,
	longitude     FLOAT  NOT NULL  ,
	CONSTRAINT LOCATION_PK PRIMARY KEY (id_location)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: DELIVERER
------------------------------------------------------------
CREATE TABLE public.DELIVERER(
	id_deliverer   SERIAL NOT NULL ,
	name           VARCHAR (100) NOT NULL ,
	firstname      VARCHAR (100) NOT NULL ,
	email          VARCHAR (150) NOT NULL ,
	password       VARCHAR (2000)  NOT NULL ,
	phone          INTEGER  NOT NULL ,
	photo          VARCHAR (2000)  NOT NULL ,
	total          FLOAT  NOT NULL ,
	id_location    INT    ,
	CONSTRAINT DELIVERER_PK PRIMARY KEY (id_deliverer)

	,CONSTRAINT DELIVERER_LOCATION_FK FOREIGN KEY (id_location) REFERENCES public.LOCATION(id_location)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: SENDER
------------------------------------------------------------
CREATE TABLE public.SENDER(
	id_sender   SERIAL NOT NULL ,
	siret       INTEGER  NOT NULL ,
	name        VARCHAR (150) NOT NULL  ,
	CONSTRAINT SENDER_PK PRIMARY KEY (id_sender)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: EMPLOYER
------------------------------------------------------------
CREATE TABLE public.EMPLOYER(
	id_employer   SERIAL NOT NULL ,
	name          VARCHAR (150) NOT NULL ,
	firstname     VARCHAR (150) NOT NULL ,
	phone         INTEGER  NOT NULL ,
	email         VARCHAR (150) NOT NULL ,
	password      VARCHAR (2000)  NOT NULL ,
	photo         VARCHAR (2000)  NOT NULL  ,
	CONSTRAINT EMPLOYER_PK PRIMARY KEY (id_employer)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: DELIVERY
------------------------------------------------------------
CREATE TABLE public.DELIVERY(
	id_delivery   SERIAL NOT NULL ,
	date          DATE  NOT NULL ,
	id_location   INT  NOT NULL  ,
	CONSTRAINT DELIVERY_PK PRIMARY KEY (id_delivery)

	,CONSTRAINT DELIVERY_LOCATION_FK FOREIGN KEY (id_location) REFERENCES public.LOCATION(id_location)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: PACKAGE
------------------------------------------------------------
CREATE TABLE public.PACKAGE(
	id_package    SERIAL NOT NULL ,
	name          VARCHAR (150) NOT NULL ,
	weight        FLOAT  NOT NULL ,
	price         FLOAT  NOT NULL ,
	deadline      DATE  NOT NULL ,
	id_delivery   INT   ,
	id_location   INT   ,
	id_sender     INT    ,
	CONSTRAINT PACKAGE_PK PRIMARY KEY (id_package)

	,CONSTRAINT PACKAGE_DELIVERY_FK FOREIGN KEY (id_delivery) REFERENCES public.DELIVERY(id_delivery)
	,CONSTRAINT PACKAGE_LOCATION0_FK FOREIGN KEY (id_location) REFERENCES public.LOCATION(id_location)
	,CONSTRAINT PACKAGE_SENDER1_FK FOREIGN KEY (id_sender) REFERENCES public.SENDER(id_sender)
)WITHOUT OIDS;


------------------------------------------------------------
-- Table: situate
------------------------------------------------------------
CREATE TABLE public.situate(
	id_location   INT  NOT NULL ,
	id_sender     INT  NOT NULL  ,
	CONSTRAINT situate_PK PRIMARY KEY (id_location,id_sender)

	,CONSTRAINT situate_LOCATION_FK FOREIGN KEY (id_location) REFERENCES public.LOCATION(id_location)
	,CONSTRAINT situate_SENDER0_FK FOREIGN KEY (id_sender) REFERENCES public.SENDER(id_sender)
)WITHOUT OIDS;



