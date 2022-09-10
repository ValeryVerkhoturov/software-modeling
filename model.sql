
/* Drop Tables */

DROP TABLE IF EXISTS COLLCTION_DESCRIPTION;
DROP TABLE IF EXISTS COLLECTION_OBJECT;
DROP TABLE IF EXISTS COLLECTION_GROUP;
DROP TABLE IF EXISTS COLLECTION_ORIGIN_DOCUEMENTS;
DROP TABLE IF EXISTS COLLECTION_STORAGE_CONDITIONS;
DROP TABLE IF EXISTS ZOO_COLLECTION;
DROP TABLE IF EXISTS CLASSIFIER_APPOINTMENT;
DROP TABLE IF EXISTS CLASSIFIER_COLLECTION_DESCRIPTION;
DROP TABLE IF EXISTS CLASSIFIER_FIAS;
DROP TABLE IF EXISTS CLASSIFIER_OWNERSHIP_TYPE;
DROP TABLE IF EXISTS CLASSIFIER_STORAGE_CONDITIONS;




/* Create Tables */

-- К-р назначения коллекции
CREATE TABLE CLASSIFIER_APPOINTMENT
(
	-- Код назначения собственности : Назначение. Пр.: научное, культурно-просветительное, учебно-воспитательное и др.
	-- 
	APPOINTMENT_ID int NOT NULL,
	-- Наименование : Назначение. Пр.: научное, культурно-просветительное, учебно-воспитательное и др.
	-- 
	NAME varchar(100) NOT NULL,
	PRIMARY KEY (APPOINTMENT_ID)
) WITHOUT OIDS;


-- К-р описания коллекции
CREATE TABLE CLASSIFIER_COLLECTION_DESCRIPTION
(
	-- Код описания коллекции : Суррогатный ключ
	-- 
	-- живые организмы, чучела, яйца, раковины, сухие и влажные препараты и др.
	COLLECTION_DESCRIPTION_CLASSIFIER_ID int NOT NULL,
	-- Наименование описания коллекции : живые организмы, чучела, яйца, раковины, сухие и влажные препараты и др.
	NAME varchar(50) NOT NULL,
	PRIMARY KEY (COLLECTION_DESCRIPTION_CLASSIFIER_ID)
) WITHOUT OIDS;


-- Классификатор ФИАС
CREATE TABLE CLASSIFIER_FIAS
(
	-- Код ФИАС : Код адреса в Федеральной информационной адресной системе
	FIAS_ID char(36) NOT NULL,
	-- Адрес : Наименование адреса в Федеральной информационной адресной системе
	FULL_ADDRESS varchar(100) NOT NULL,
	PRIMARY KEY (FIAS_ID)
) WITHOUT OIDS;


-- К-р форм собственности
CREATE TABLE CLASSIFIER_OWNERSHIP_TYPE
(
	-- Код форм собственности : Постановление Госстандарта России от 30.03.1999 N 97 (ред. от 16.10.2012) "О принятии и введении в действие Общероссийских классификаторов" (вместе с "ОК 027-99. Общероссийский классификатор форм собственности") (дата введения 01.01.2000)
	-- 
	-- 2 цифры
	-- 
	-- https://www.consultant.ru/document/cons_doc_LAW_26587/7a1b896f20475ca2f74d020bb3662a469f7ab994/
	ID smallint NOT NULL,
	-- Наименование форм собственнсти : Постановление Госстандарта России от 30.03.1999 N 97 (ред. от 16.10.2012) "О принятии и введении в действие Общероссийских классификаторов" (вместе с "ОК 027-99. Общероссийский классификатор форм собственности") (дата введения 01.01.2000)
	-- 
	-- https://www.consultant.ru/document/cons_doc_LAW_26587/7a1b896f20475ca2f74d020bb3662a469f7ab994/
	Name varchar(100) NOT NULL,
	PRIMARY KEY (ID)
) WITHOUT OIDS;


-- К-р условий хранения
CREATE TABLE CLASSIFIER_STORAGE_CONDITIONS
(
	-- Код условия хранения коллекции : Суррогатный ключ
	STORAGE_CONDITION_ID int NOT NULL,
	-- Наименование условия хранения : https://www.garant.ru/hotlaw/federal/1158312/
	NAME varchar(100) NOT NULL,
	PRIMARY KEY (STORAGE_CONDITION_ID)
) WITHOUT OIDS;


-- COLLCTION_DESCRIPTION
CREATE TABLE COLLCTION_DESCRIPTION
(
	-- Код описания коллекции : Описание коллекции (живые организмы, чучела, яйца, раковины, сухие и влажные препараты и др.)
	ID_COLLECTION_DESCRIPTION int NOT NULL,
	-- Код описания коллекции : Суррогатный ключ
	-- 
	-- живые организмы, чучела, яйца, раковины, сухие и влажные препараты и др.
	COLLECTION_DESCRIPTION_CLASSIFIER_ID int NOT NULL,
	-- Код зоологической коллекции : Код зоологической коллекции
	ZOO_COLLECTION_ID int NOT NULL,
	PRIMARY KEY (ID_COLLECTION_DESCRIPTION)
) WITHOUT OIDS;


-- COLLECTION_GROUP
CREATE TABLE COLLECTION_GROUP
(
	-- Код группы коллекции : Суррогатный ключ
	COLLECTION_GROUP_ID int NOT NULL,
	-- Код зоологической коллекции : Код зоологической коллекции
	ZOO_COLLECTION_ID int NOT NULL,
	-- Наименование группы коллекции : Название группы
	NAME varchar(50) NOT NULL,
	PRIMARY KEY (COLLECTION_GROUP_ID)
) WITHOUT OIDS;


-- Объект коллекции
CREATE TABLE COLLECTION_OBJECT
(
	-- Код объекта коллекции : Суррогатный ключ
	COLLECTION_OBJECT_ID int NOT NULL,
	-- Код зоологической коллекции : Код зоологической коллекции
	ZOO_COLLECTION_ID int NOT NULL,
	-- Код группы коллекции : Суррогатный ключ
	COLLECTION_GROUP_ID int NOT NULL,
	-- Наименование объекта коллекции : Номенклатура объекта
	NAME varchar(50) NOT NULL,
	-- Является уникальным объктом : Занесен в Красную Книгу РФ?
	IS_UNIQUE_OBJECT boolean NOT NULL,
	-- Дата внесения объекта в зоологическую колекцию : Для отслеживания изменений (оборота) коллекции
	DATE_FROM date NOT NULL,
	-- Дата исключения объекта из зоологической коллекции : Для отслеживания изменений (оборота) коллекции
	DATE_TO date,
	PRIMARY KEY (COLLECTION_OBJECT_ID),
	UNIQUE (COLLECTION_OBJECT_ID, ZOO_COLLECTION_ID, COLLECTION_GROUP_ID)
) WITHOUT OIDS;


-- Документы о происхождениии коллекции
CREATE TABLE COLLECTION_ORIGIN_DOCUEMENTS
(
	-- Код документа : Происхождение коллекции (документы, подтверждающие законность владения, распоряжения, сбора коллекции).
	COLLECTION_ORIGIN_DOCUMENT_ID int NOT NULL,
	-- Код зоологической коллекции : Код зоологической коллекции
	ZOO_COLLECTION_ID int NOT NULL,
	-- Ссылка на документ о происхождении коллекции : Ссылка на внешний ресурс
	COLLECTION_ORIGIN_DOCUMENT_URL varchar(100) NOT NULL,
	PRIMARY KEY (COLLECTION_ORIGIN_DOCUMENT_ID)
) WITHOUT OIDS;


-- Условия хранения коллекции
CREATE TABLE COLLECTION_STORAGE_CONDITIONS
(
	-- Код условия хранения коллекции : Суррогатный ключ
	COLLECTION_STORAGE_CONDITION_ID int NOT NULL,
	-- Код зоологической коллекции : Код зоологической коллекции
	ZOO_COLLECTION_ID int NOT NULL,
	-- Код условия хранения коллекции : Суррогатный ключ
	STORAGE_CONDITION_ID int NOT NULL,
	PRIMARY KEY (COLLECTION_STORAGE_CONDITION_ID)
) WITHOUT OIDS;


-- Зоологическая коллекция
CREATE TABLE ZOO_COLLECTION
(
	-- Код зоологической коллекции : Код зоологической коллекции
	ZOO_COLLECTION_ID int NOT NULL,
	-- Номер государственной регистрации : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875
	GOV_REGISTRATION_NUMBER int NOT NULL UNIQUE,
	-- Дата регистрации : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875
	REGISTRATION_DATE date NOT NULL,
	-- Наименование коллекции : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875
	COLLECTION_NAME varchar(100) NOT NULL,
	-- Фамилия владельца : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875
	OWNER_LAST_NAME varchar(30) NOT NULL,
	-- Имя владельца : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875
	OWNER_FIRST_NAME varchar(30) NOT NULL,
	-- Отчество владельца : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875
	OWNER_MIDDLE_NAME varchar(30),
	-- Код ФИАС владельца : Код адреса в Федеральной информационной адресной системе
	OWNER_FIAS_ID char(36) NOT NULL,
	-- Код ФИАС зоологической коллекции : Код адреса в Федеральной информационной адресной системе
	ZOO_COLLECTION_FIAS_ID char(36) NOT NULL,
	-- Код форм собственности : Постановление Госстандарта России от 30.03.1999 N 97 (ред. от 16.10.2012) "О принятии и введении в действие Общероссийских классификаторов" (вместе с "ОК 027-99. Общероссийский классификатор форм собственности") (дата введения 01.01.2000)
	-- 
	-- 2 цифры
	-- 
	-- https://www.consultant.ru/document/cons_doc_LAW_26587/7a1b896f20475ca2f74d020bb3662a469f7ab994/
	OWNERSHIP_TYPE_ID smallint NOT NULL,
	-- Код назначения собственности : Назначение. Пр.: научное, культурно-просветительное, учебно-воспитательное и др.
	-- 
	APPOINTMENT_ID int NOT NULL,
	-- Год основания коллекции : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875
	YEAR_OF_COLLECTION_FOUNDATION int NOT NULL,
	-- Номер перерегистрации : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875
	NUMBER_OF_REREGISTRATION int DEFAULT 0 NOT NULL,
	-- Код заключения экспертной группы по зоологическим коллекциям : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875
	OPINION_ID_OF_THE_EXPERT_GROUP_OF_ZOOLOGICAL_COLLECTION int NOT NULL UNIQUE,
	-- Фамилия выдавшего свидетельство о внесении колеекции в реестр : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875
	LAST_NAME_OF_PERSON_ISSUED_THE_CERTIFICATE_OF_ENTRY_IN_THE_REGISTER varchar(30) NOT NULL,
	-- Имя выдавшего свидетельство о внесении колеекции в реестр : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875
	FIRST_NAME_OF_PERSON_ISSUED_THE_CERTIFICATE_OF_ENTRY_IN_THE_REGISTER varchar(30) NOT NULL,
	-- Отчество выдавшего свидетельство о внесении колеекции в реестр : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875
	MIDDLE_NAME_OF_PERSON_ISSUED_THE_CERTIFICATE_OF_ENTRY_IN_THE_REGISTER varchar(30),
	-- Код ОКПРТР выдавшего свидетельство о внесении колеекции в реестр : 5 цифр 
	-- Общероссийский классификатор профессий рабочих, должностей служащих и тарифных разрядов
	OKPRTR_ID_OF_PERSON_ISSUED_THE_CERTIFICATE_OF_ENTRY_IN_THE_REGISTER int NOT NULL,
	-- Номер свидетельства о внесении коллекции в реестр : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875
	NUMBER_OF_THE_CERTIFICATE_OF_ENTRY_IN_THE_REGISTER int NOT NULL UNIQUE,
	PRIMARY KEY (ZOO_COLLECTION_ID)
) WITHOUT OIDS;



/* Create Foreign Keys */

ALTER TABLE ZOO_COLLECTION
	ADD FOREIGN KEY (APPOINTMENT_ID)
	REFERENCES CLASSIFIER_APPOINTMENT (APPOINTMENT_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE COLLCTION_DESCRIPTION
	ADD FOREIGN KEY (COLLECTION_DESCRIPTION_CLASSIFIER_ID)
	REFERENCES CLASSIFIER_COLLECTION_DESCRIPTION (COLLECTION_DESCRIPTION_CLASSIFIER_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ZOO_COLLECTION
	ADD FOREIGN KEY (ZOO_COLLECTION_FIAS_ID)
	REFERENCES CLASSIFIER_FIAS (FIAS_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ZOO_COLLECTION
	ADD FOREIGN KEY (OWNER_FIAS_ID)
	REFERENCES CLASSIFIER_FIAS (FIAS_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE ZOO_COLLECTION
	ADD FOREIGN KEY (OWNERSHIP_TYPE_ID)
	REFERENCES CLASSIFIER_OWNERSHIP_TYPE (ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE COLLECTION_STORAGE_CONDITIONS
	ADD FOREIGN KEY (STORAGE_CONDITION_ID)
	REFERENCES CLASSIFIER_STORAGE_CONDITIONS (STORAGE_CONDITION_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE COLLECTION_OBJECT
	ADD FOREIGN KEY (COLLECTION_GROUP_ID)
	REFERENCES COLLECTION_GROUP (COLLECTION_GROUP_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE COLLCTION_DESCRIPTION
	ADD FOREIGN KEY (ZOO_COLLECTION_ID)
	REFERENCES ZOO_COLLECTION (ZOO_COLLECTION_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE COLLECTION_GROUP
	ADD FOREIGN KEY (ZOO_COLLECTION_ID)
	REFERENCES ZOO_COLLECTION (ZOO_COLLECTION_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE COLLECTION_OBJECT
	ADD FOREIGN KEY (ZOO_COLLECTION_ID)
	REFERENCES ZOO_COLLECTION (ZOO_COLLECTION_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE COLLECTION_ORIGIN_DOCUEMENTS
	ADD FOREIGN KEY (ZOO_COLLECTION_ID)
	REFERENCES ZOO_COLLECTION (ZOO_COLLECTION_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;


ALTER TABLE COLLECTION_STORAGE_CONDITIONS
	ADD FOREIGN KEY (ZOO_COLLECTION_ID)
	REFERENCES ZOO_COLLECTION (ZOO_COLLECTION_ID)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;



/* Comments */

COMMENT ON TABLE CLASSIFIER_APPOINTMENT IS 'К-р назначения коллекции';
COMMENT ON COLUMN CLASSIFIER_APPOINTMENT.APPOINTMENT_ID IS 'Код назначения собственности : Назначение. Пр.: научное, культурно-просветительное, учебно-воспитательное и др.
';
COMMENT ON COLUMN CLASSIFIER_APPOINTMENT.NAME IS 'Наименование : Назначение. Пр.: научное, культурно-просветительное, учебно-воспитательное и др.
';
COMMENT ON TABLE CLASSIFIER_COLLECTION_DESCRIPTION IS 'К-р описания коллекции';
COMMENT ON COLUMN CLASSIFIER_COLLECTION_DESCRIPTION.COLLECTION_DESCRIPTION_CLASSIFIER_ID IS 'Код описания коллекции : Суррогатный ключ

живые организмы, чучела, яйца, раковины, сухие и влажные препараты и др.';
COMMENT ON COLUMN CLASSIFIER_COLLECTION_DESCRIPTION.NAME IS 'Наименование описания коллекции : живые организмы, чучела, яйца, раковины, сухие и влажные препараты и др.';
COMMENT ON TABLE CLASSIFIER_FIAS IS 'Классификатор ФИАС';
COMMENT ON COLUMN CLASSIFIER_FIAS.FIAS_ID IS 'Код ФИАС : Код адреса в Федеральной информационной адресной системе';
COMMENT ON COLUMN CLASSIFIER_FIAS.FULL_ADDRESS IS 'Адрес : Наименование адреса в Федеральной информационной адресной системе';
COMMENT ON TABLE CLASSIFIER_OWNERSHIP_TYPE IS 'К-р форм собственности';
COMMENT ON COLUMN CLASSIFIER_OWNERSHIP_TYPE.ID IS 'Код форм собственности : Постановление Госстандарта России от 30.03.1999 N 97 (ред. от 16.10.2012) "О принятии и введении в действие Общероссийских классификаторов" (вместе с "ОК 027-99. Общероссийский классификатор форм собственности") (дата введения 01.01.2000)

2 цифры

https://www.consultant.ru/document/cons_doc_LAW_26587/7a1b896f20475ca2f74d020bb3662a469f7ab994/';
COMMENT ON COLUMN CLASSIFIER_OWNERSHIP_TYPE.Name IS 'Наименование форм собственнсти : Постановление Госстандарта России от 30.03.1999 N 97 (ред. от 16.10.2012) "О принятии и введении в действие Общероссийских классификаторов" (вместе с "ОК 027-99. Общероссийский классификатор форм собственности") (дата введения 01.01.2000)

https://www.consultant.ru/document/cons_doc_LAW_26587/7a1b896f20475ca2f74d020bb3662a469f7ab994/';
COMMENT ON TABLE CLASSIFIER_STORAGE_CONDITIONS IS 'К-р условий хранения';
COMMENT ON COLUMN CLASSIFIER_STORAGE_CONDITIONS.STORAGE_CONDITION_ID IS 'Код условия хранения коллекции : Суррогатный ключ';
COMMENT ON COLUMN CLASSIFIER_STORAGE_CONDITIONS.NAME IS 'Наименование условия хранения : https://www.garant.ru/hotlaw/federal/1158312/';
COMMENT ON TABLE COLLCTION_DESCRIPTION IS 'COLLCTION_DESCRIPTION';
COMMENT ON COLUMN COLLCTION_DESCRIPTION.ID_COLLECTION_DESCRIPTION IS 'Код описания коллекции : Описание коллекции (живые организмы, чучела, яйца, раковины, сухие и влажные препараты и др.)';
COMMENT ON COLUMN COLLCTION_DESCRIPTION.COLLECTION_DESCRIPTION_CLASSIFIER_ID IS 'Код описания коллекции : Суррогатный ключ

живые организмы, чучела, яйца, раковины, сухие и влажные препараты и др.';
COMMENT ON COLUMN COLLCTION_DESCRIPTION.ZOO_COLLECTION_ID IS 'Код зоологической коллекции : Код зоологической коллекции';
COMMENT ON TABLE COLLECTION_GROUP IS 'COLLECTION_GROUP';
COMMENT ON COLUMN COLLECTION_GROUP.COLLECTION_GROUP_ID IS 'Код группы коллекции : Суррогатный ключ';
COMMENT ON COLUMN COLLECTION_GROUP.ZOO_COLLECTION_ID IS 'Код зоологической коллекции : Код зоологической коллекции';
COMMENT ON COLUMN COLLECTION_GROUP.NAME IS 'Наименование группы коллекции : Название группы';
COMMENT ON TABLE COLLECTION_OBJECT IS 'Объект коллекции';
COMMENT ON COLUMN COLLECTION_OBJECT.COLLECTION_OBJECT_ID IS 'Код объекта коллекции : Суррогатный ключ';
COMMENT ON COLUMN COLLECTION_OBJECT.ZOO_COLLECTION_ID IS 'Код зоологической коллекции : Код зоологической коллекции';
COMMENT ON COLUMN COLLECTION_OBJECT.COLLECTION_GROUP_ID IS 'Код группы коллекции : Суррогатный ключ';
COMMENT ON COLUMN COLLECTION_OBJECT.NAME IS 'Наименование объекта коллекции : Номенклатура объекта';
COMMENT ON COLUMN COLLECTION_OBJECT.IS_UNIQUE_OBJECT IS 'Является уникальным объктом : Занесен в Красную Книгу РФ?';
COMMENT ON COLUMN COLLECTION_OBJECT.DATE_FROM IS 'Дата внесения объекта в зоологическую колекцию : Для отслеживания изменений (оборота) коллекции';
COMMENT ON COLUMN COLLECTION_OBJECT.DATE_TO IS 'Дата исключения объекта из зоологической коллекции : Для отслеживания изменений (оборота) коллекции';
COMMENT ON TABLE COLLECTION_ORIGIN_DOCUEMENTS IS 'Документы о происхождениии коллекции';
COMMENT ON COLUMN COLLECTION_ORIGIN_DOCUEMENTS.COLLECTION_ORIGIN_DOCUMENT_ID IS 'Код документа : Происхождение коллекции (документы, подтверждающие законность владения, распоряжения, сбора коллекции).';
COMMENT ON COLUMN COLLECTION_ORIGIN_DOCUEMENTS.ZOO_COLLECTION_ID IS 'Код зоологической коллекции : Код зоологической коллекции';
COMMENT ON COLUMN COLLECTION_ORIGIN_DOCUEMENTS.COLLECTION_ORIGIN_DOCUMENT_URL IS 'Ссылка на документ о происхождении коллекции : Ссылка на внешний ресурс';
COMMENT ON TABLE COLLECTION_STORAGE_CONDITIONS IS 'Условия хранения коллекции';
COMMENT ON COLUMN COLLECTION_STORAGE_CONDITIONS.COLLECTION_STORAGE_CONDITION_ID IS 'Код условия хранения коллекции : Суррогатный ключ';
COMMENT ON COLUMN COLLECTION_STORAGE_CONDITIONS.ZOO_COLLECTION_ID IS 'Код зоологической коллекции : Код зоологической коллекции';
COMMENT ON COLUMN COLLECTION_STORAGE_CONDITIONS.STORAGE_CONDITION_ID IS 'Код условия хранения коллекции : Суррогатный ключ';
COMMENT ON TABLE ZOO_COLLECTION IS 'Зоологическая коллекция';
COMMENT ON COLUMN ZOO_COLLECTION.ZOO_COLLECTION_ID IS 'Код зоологической коллекции : Код зоологической коллекции';
COMMENT ON COLUMN ZOO_COLLECTION.GOV_REGISTRATION_NUMBER IS 'Номер государственной регистрации : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875';
COMMENT ON COLUMN ZOO_COLLECTION.REGISTRATION_DATE IS 'Дата регистрации : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875';
COMMENT ON COLUMN ZOO_COLLECTION.COLLECTION_NAME IS 'Наименование коллекции : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875';
COMMENT ON COLUMN ZOO_COLLECTION.OWNER_LAST_NAME IS 'Фамилия владельца : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875';
COMMENT ON COLUMN ZOO_COLLECTION.OWNER_FIRST_NAME IS 'Имя владельца : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875';
COMMENT ON COLUMN ZOO_COLLECTION.OWNER_MIDDLE_NAME IS 'Отчество владельца : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875';
COMMENT ON COLUMN ZOO_COLLECTION.OWNER_FIAS_ID IS 'Код ФИАС владельца : Код адреса в Федеральной информационной адресной системе';
COMMENT ON COLUMN ZOO_COLLECTION.ZOO_COLLECTION_FIAS_ID IS 'Код ФИАС зоологической коллекции : Код адреса в Федеральной информационной адресной системе';
COMMENT ON COLUMN ZOO_COLLECTION.OWNERSHIP_TYPE_ID IS 'Код форм собственности : Постановление Госстандарта России от 30.03.1999 N 97 (ред. от 16.10.2012) "О принятии и введении в действие Общероссийских классификаторов" (вместе с "ОК 027-99. Общероссийский классификатор форм собственности") (дата введения 01.01.2000)

2 цифры

https://www.consultant.ru/document/cons_doc_LAW_26587/7a1b896f20475ca2f74d020bb3662a469f7ab994/';
COMMENT ON COLUMN ZOO_COLLECTION.APPOINTMENT_ID IS 'Код назначения собственности : Назначение. Пр.: научное, культурно-просветительное, учебно-воспитательное и др.
';
COMMENT ON COLUMN ZOO_COLLECTION.YEAR_OF_COLLECTION_FOUNDATION IS 'Год основания коллекции : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875';
COMMENT ON COLUMN ZOO_COLLECTION.NUMBER_OF_REREGISTRATION IS 'Номер перерегистрации : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875';
COMMENT ON COLUMN ZOO_COLLECTION.OPINION_ID_OF_THE_EXPERT_GROUP_OF_ZOOLOGICAL_COLLECTION IS 'Код заключения экспертной группы по зоологическим коллекциям : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875';
COMMENT ON COLUMN ZOO_COLLECTION.LAST_NAME_OF_PERSON_ISSUED_THE_CERTIFICATE_OF_ENTRY_IN_THE_REGISTER IS 'Фамилия выдавшего свидетельство о внесении колеекции в реестр : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875';
COMMENT ON COLUMN ZOO_COLLECTION.FIRST_NAME_OF_PERSON_ISSUED_THE_CERTIFICATE_OF_ENTRY_IN_THE_REGISTER IS 'Имя выдавшего свидетельство о внесении колеекции в реестр : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875';
COMMENT ON COLUMN ZOO_COLLECTION.MIDDLE_NAME_OF_PERSON_ISSUED_THE_CERTIFICATE_OF_ENTRY_IN_THE_REGISTER IS 'Отчество выдавшего свидетельство о внесении колеекции в реестр : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875';
COMMENT ON COLUMN ZOO_COLLECTION.OKPRTR_ID_OF_PERSON_ISSUED_THE_CERTIFICATE_OF_ENTRY_IN_THE_REGISTER IS 'Код ОКПРТР выдавшего свидетельство о внесении колеекции в реестр : 5 цифр 
Общероссийский классификатор профессий рабочих, должностей служащих и тарифных разрядов';
COMMENT ON COLUMN ZOO_COLLECTION.NUMBER_OF_THE_CERTIFICATE_OF_ENTRY_IN_THE_REGISTER IS 'Номер свидетельства о внесении коллекции в реестр : Требуется согласно форме реестра зоологических коллекций, поставленных на государственный учет https://docs.cntd.ru/document/58812875';



