-- student id: 32353391
-- student name: Cheng Ho Wang

-- Generated by Oracle SQL Developer Data Modeler 20.4.0.374.0801
--   at:        2021-09-16 21:58:05 HKT
--   site:      Oracle Database 12c
--   type:      Oracle Database 12c

-- Capture run of script in file called mm_schema_output.txt
set echo on
SPOOL mm_schema_output.txt


DROP TABLE assessment CASCADE CONSTRAINTS;

DROP TABLE attendance CASCADE CONSTRAINTS;

DROP TABLE centre CASCADE CONSTRAINTS;

DROP TABLE class CASCADE CONSTRAINTS;

DROP TABLE class_staff CASCADE CONSTRAINTS;

DROP TABLE class_type CASCADE CONSTRAINTS;

DROP TABLE facility CASCADE CONSTRAINTS;

DROP TABLE member CASCADE CONSTRAINTS;

DROP TABLE "Session" CASCADE CONSTRAINTS;

DROP TABLE sessionv1 CASCADE CONSTRAINTS;

DROP TABLE staff CASCADE CONSTRAINTS;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE assessment (
    date_of_assessment  DATE NOT NULL,
    weight              NUMBER(3) NOT NULL,
    blood_pressure      NUMBER(3) NOT NULL,
    vo2max              NUMBER(3) NOT NULL,
    member_no           NUMBER(10) NOT NULL,
    staff_id            NUMBER(10) NOT NULL
);

COMMENT ON COLUMN assessment.date_of_assessment IS
    'date that complete the assessment';

COMMENT ON COLUMN assessment.weight IS
    'weight of member';

COMMENT ON COLUMN assessment.blood_pressure IS
    'blood pressure of member';

COMMENT ON COLUMN assessment.vo2max IS
    'Vo2Max of member';

COMMENT ON COLUMN assessment.member_no IS
    'member number';

COMMENT ON COLUMN assessment.staff_id IS
    'unique id of staff';

ALTER TABLE assessment
    ADD CONSTRAINT assessment_pk PRIMARY KEY ( member_no,
                                               staff_id,
                                               date_of_assessment );

CREATE TABLE attendance (
    payment_date    DATE NOT NULL,
    class_no        NUMBER(10) NOT NULL,
    facility_rm_no  NUMBER(10) NOT NULL,
    centre_id       NUMBER(7) NOT NULL,
    member_no       NUMBER(10) NOT NULL,
    payment_no      NUMBER(4) NOT NULL,
    centre_id1      NUMBER(7) NOT NULL,
    total_attend    NUMBER(3) NOT NULL
);

COMMENT ON COLUMN attendance.payment_date IS
    'date of payment';

COMMENT ON COLUMN attendance.class_no IS
    'unique class number to identify class';

COMMENT ON COLUMN attendance.facility_rm_no IS
    'the room number of the facility in each centre';

COMMENT ON COLUMN attendance.centre_id IS
    'unique id to identify centre';

COMMENT ON COLUMN attendance.member_no IS
    'member number';

COMMENT ON COLUMN attendance.payment_no IS
    'id for the payment(surrogate key)';

COMMENT ON COLUMN attendance.centre_id1 IS
    'unique id to identify centre';

COMMENT ON COLUMN attendance.total_attend IS
    'numbe of session member attend';

CREATE UNIQUE INDEX payment__idx ON
    attendance (
        class_no
    ASC,
        facility_rm_no
    ASC,
        centre_id
    ASC );

ALTER TABLE attendance
    ADD CONSTRAINT payment_pk PRIMARY KEY ( payment_date,
                                            member_no,
                                            class_no,
                                            facility_rm_no,
                                            centre_id );

ALTER TABLE attendance
    ADD CONSTRAINT payment_nk UNIQUE ( payment_date,
                                       class_no,
                                       facility_rm_no,
                                       centre_id,
                                       member_no );

CREATE TABLE centre (
    centre_id        NUMBER(7) NOT NULL,
    centre_name      VARCHAR2(50) NOT NULL,
    centre_street    VARCHAR2(50) NOT NULL,
    centre_town      VARCHAR2(50) NOT NULL,
    cenntre_pc       CHAR(10) NOT NULL,
    centre_phone_no  CHAR(10) NOT NULL,
    staff_id         NUMBER(10) NOT NULL
);

COMMENT ON COLUMN centre.centre_id IS
    'unique id to identify centre';

COMMENT ON COLUMN centre.centre_name IS
    'name of the creter';

COMMENT ON COLUMN centre.centre_street IS
    'address of the centre - street';

COMMENT ON COLUMN centre.centre_town IS
    'address of the centre - town';

COMMENT ON COLUMN centre.cenntre_pc IS
    'address of the centre - postcode';

COMMENT ON COLUMN centre.centre_phone_no IS
    'phone number of the centre';

COMMENT ON COLUMN centre.staff_id IS
    'unique id of staff';

CREATE UNIQUE INDEX centre__idx ON
    centre (
        staff_id
    ASC );

ALTER TABLE centre ADD CONSTRAINT centre_pk PRIMARY KEY ( centre_id );

CREATE TABLE class (
    class_no              NUMBER(10) NOT NULL,
    class_type            VARCHAR2(50) NOT NULL,
    class_desc            VARCHAR2(50) NOT NULL,
    class_dur             VARCHAR2(50) NOT NULL,
    class_start_datetime  DATE NOT NULL,
    class_max_no          NUMBER(3) NOT NULL,
    class_no_of_session   NUMBER(3) NOT NULL,
    class_cost            NUMBER(8, 2) NOT NULL,
    facility_rm_no        NUMBER(10) NOT NULL,
    centre_id             NUMBER(7) NOT NULL,
    class_restri          VARCHAR2(50),
    class_type_id         VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN class.class_no IS
    'unique class number to identify class';

COMMENT ON COLUMN class.class_type IS
    'class type';

COMMENT ON COLUMN class.class_desc IS
    'class description';

COMMENT ON COLUMN class.class_dur IS
    'class duration';

COMMENT ON COLUMN class.class_max_no IS
    'maximum number of people in a class ';

COMMENT ON COLUMN class.class_no_of_session IS
    'number of session of each class';

COMMENT ON COLUMN class.class_cost IS
    'class cost';

COMMENT ON COLUMN class.facility_rm_no IS
    'the room number of the facility in each centre';

COMMENT ON COLUMN class.centre_id IS
    'unique id to identify centre';

COMMENT ON COLUMN class.class_restri IS
    'class restriction that for example the gender restriction';

COMMENT ON COLUMN class.class_type_id IS
    'class type id';

ALTER TABLE class
    ADD CONSTRAINT class_pk PRIMARY KEY ( class_no,
                                          facility_rm_no,
                                          centre_id );

CREATE TABLE class_staff (
    staff_id        NUMBER(10) NOT NULL,
    class_no        NUMBER(10) NOT NULL,
    facility_rm_no  NUMBER(10) NOT NULL,
    centre_id       NUMBER(7) NOT NULL,
    centre_id1      NUMBER(7) NOT NULL,
    class_leader    VARCHAR2(50) NOT NULL,
    first_aid_cert  VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN class_staff.staff_id IS
    'unique id of staff';

COMMENT ON COLUMN class_staff.class_no IS
    'unique class number to identify class';

COMMENT ON COLUMN class_staff.facility_rm_no IS
    'the room number of the facility in each centre';

COMMENT ON COLUMN class_staff.centre_id IS
    'unique id to identify centre';

COMMENT ON COLUMN class_staff.centre_id1 IS
    'unique id to identify centre';

COMMENT ON COLUMN class_staff.class_leader IS
    'class leader';

COMMENT ON COLUMN class_staff.first_aid_cert IS
    'first aid certificate of the staff';

ALTER TABLE class_staff
    ADD CONSTRAINT class_staff_pk PRIMARY KEY ( staff_id,
                                                class_no,
                                                centre_id1 );

CREATE TABLE class_type (
    class_type_id    VARCHAR2(50) NOT NULL,
    class_type_name  VARCHAR2(50)
);

COMMENT ON COLUMN class_type.class_type_id IS
    'class type id';

COMMENT ON COLUMN class_type.class_type_name IS
    'class type name';

ALTER TABLE class_type ADD CONSTRAINT class_type_pk PRIMARY KEY ( class_type_id );

CREATE TABLE facility (
    facility_rm_no  NUMBER(10) NOT NULL,
    facility_name   VARCHAR2(50) NOT NULL,
    facility_desc   VARCHAR2(50) NOT NULL,
    facility_cap    NUMBER(7) NOT NULL,
    centre_id       NUMBER(7) NOT NULL
);

COMMENT ON COLUMN facility.facility_rm_no IS
    'the room number of the facility in each centre';

COMMENT ON COLUMN facility.facility_name IS
    'facility name';

COMMENT ON COLUMN facility.facility_desc IS
    'facility description';

COMMENT ON COLUMN facility.facility_cap IS
    'capacity of the facility';

COMMENT ON COLUMN facility.centre_id IS
    'unique id to identify centre';

ALTER TABLE facility ADD CONSTRAINT facility_pk PRIMARY KEY ( facility_rm_no,
                                                              centre_id );

CREATE TABLE member (
    member_no           NUMBER(10) NOT NULL,
    member_first_name   VARCHAR2(50),
    member_street       VARCHAR2(50) NOT NULL,
    member_town         VARCHAR2(50) NOT NULL,
    member_pc           CHAR(10) NOT NULL,
    member_phone_no     CHAR(10) NOT NULL,
    member_date_joined  DATE NOT NULL,
    member_no_refer     NUMBER(10),
    centre_id           NUMBER(7) NOT NULL,
    member_last_name    VARCHAR2(50) NOT NULL,
    payment_date        DATE,
    total_attend        NUMBER(3)
);

COMMENT ON COLUMN member.member_no IS
    'member number';

COMMENT ON COLUMN member.member_first_name IS
    'member first name';

COMMENT ON COLUMN member.member_street IS
    'address of the centre - street';

COMMENT ON COLUMN member.member_town IS
    'address of the centre - town';

COMMENT ON COLUMN member.member_pc IS
    'address of the centre - postcode';

COMMENT ON COLUMN member.member_phone_no IS
    'member phone number';

COMMENT ON COLUMN member.member_date_joined IS
    'member join date';

COMMENT ON COLUMN member.member_no_refer IS
    'member number';

COMMENT ON COLUMN member.centre_id IS
    'unique id to identify centre';

COMMENT ON COLUMN member.member_last_name IS
    'member last name';

COMMENT ON COLUMN member.payment_date IS
    'date of making payment';

COMMENT ON COLUMN member.total_attend IS
    'number of session attend';

ALTER TABLE member ADD CONSTRAINT member_pk PRIMARY KEY ( member_no );

CREATE TABLE "Session" (
    session_date  DATE NOT NULL,
    member_no     NUMBER(10) NOT NULL
);

COMMENT ON COLUMN "Session".session_date IS
    'Date of each session of class';

COMMENT ON COLUMN "Session".member_no IS
    'member number';

ALTER TABLE "Session" ADD CONSTRAINT session_pk PRIMARY KEY ( session_date,
                                                              member_no );

CREATE TABLE sessionv1 (
    session_date    DATE NOT NULL,
    session_attend  VARCHAR2(50) NOT NULL,
    class_no        NUMBER(10) NOT NULL,
    centre_id       NUMBER NOT NULL,
    member_no       NUMBER(10) NOT NULL,
    session_id      NUMBER(3) NOT NULL,
    class_no        NUMBER NOT NULL,
    centre_id       NUMBER NOT NULL,
    payment_date    DATE NOT NULL,
    facility_rm_no  NUMBER(10) NOT NULL,
    centre_id1      NUMBER(7) NOT NULL
);

COMMENT ON COLUMN sessionv1.session_date IS
    'session date';

COMMENT ON COLUMN sessionv1.session_attend IS
    'whether the member attend the session';

COMMENT ON COLUMN sessionv1.class_no IS
    'unique class number to identify class';

COMMENT ON COLUMN sessionv1.centre_id IS
    'unique id to identify centre';

COMMENT ON COLUMN sessionv1.member_no IS
    'member number';

COMMENT ON COLUMN sessionv1.session_id IS
    'id to identify session (surrogate key)';

COMMENT ON COLUMN sessionv1.class_no IS
    'unique class number to identify class';

COMMENT ON COLUMN sessionv1.centre_id IS
    'unique id to identify centre';

ALTER TABLE sessionv1 ADD CONSTRAINT session_pkv1 PRIMARY KEY ( session_id );

ALTER TABLE sessionv1
    ADD CONSTRAINT session_nk UNIQUE ( session_date,
                                       member_no,
                                       class_no,
                                       centre_id );

CREATE TABLE staff (
    staff_id           NUMBER(10) NOT NULL,
    staff_first_name   VARCHAR2(50),
    staff_last_name    VARCHAR2(50) NOT NULL,
    staff_phone_no     CHAR(20) NOT NULL,
    staff_date_joined  DATE NOT NULL,
    staff_role         VARCHAR2(50) NOT NULL,
    class_no           CHAR(10),
    class_leader       VARCHAR2(50),
    first_aid_cert     VARCHAR2(50) NOT NULL,
    centre_id          NUMBER(7) NOT NULL
);

COMMENT ON COLUMN staff.staff_id IS
    'unique id of staff';

COMMENT ON COLUMN staff.staff_first_name IS
    'staff first name';

COMMENT ON COLUMN staff.staff_last_name IS
    'staff last name';

COMMENT ON COLUMN staff.staff_phone_no IS
    'staff phone number';

COMMENT ON COLUMN staff.staff_date_joined IS
    'date that the staff join';

COMMENT ON COLUMN staff.staff_role IS
    'staff role';

COMMENT ON COLUMN staff.class_no IS
    'class number that the staff teach';

COMMENT ON COLUMN staff.class_leader IS
    'class leader';

COMMENT ON COLUMN staff.first_aid_cert IS
    'first aid certificate of the staff';

COMMENT ON COLUMN staff.centre_id IS
    'unique id to identify centre';

ALTER TABLE staff ADD CONSTRAINT staff_pk PRIMARY KEY ( staff_id );

ALTER TABLE sessionv1
    ADD CONSTRAINT attend_session FOREIGN KEY ( payment_date,
                                                member_no,
                                                class_no,
                                                facility_rm_no,
                                                centre_id1 )
        REFERENCES attendance ( payment_date,
                                member_no,
                                class_no,
                                facility_rm_no,
                                centre_id );

ALTER TABLE member
    ADD CONSTRAINT centre_member FOREIGN KEY ( centre_id )
        REFERENCES centre ( centre_id );

ALTER TABLE staff
    ADD CONSTRAINT centre_staff FOREIGN KEY ( centre_id )
        REFERENCES centre ( centre_id );

ALTER TABLE class
    ADD CONSTRAINT class_classtype FOREIGN KEY ( class_type_id )
        REFERENCES class_type ( class_type_id );

ALTER TABLE class_staff
    ADD CONSTRAINT class_cs FOREIGN KEY ( class_no,
                                          facility_rm_no,
                                          centre_id )
        REFERENCES class ( class_no,
                           facility_rm_no,
                           centre_id );

ALTER TABLE class
    ADD CONSTRAINT class_facility FOREIGN KEY ( facility_rm_no,
                                                centre_id )
        REFERENCES facility ( facility_rm_no,
                              centre_id );

ALTER TABLE attendance
    ADD CONSTRAINT class_payment FOREIGN KEY ( class_no,
                                               facility_rm_no,
                                               centre_id )
        REFERENCES class ( class_no,
                           facility_rm_no,
                           centre_id );

ALTER TABLE facility
    ADD CONSTRAINT crentre_facility FOREIGN KEY ( centre_id )
        REFERENCES centre ( centre_id );

ALTER TABLE assessment
    ADD CONSTRAINT member_assessment FOREIGN KEY ( member_no )
        REFERENCES member ( member_no );

ALTER TABLE member
    ADD CONSTRAINT member_memberrefer FOREIGN KEY ( member_no_refer )
        REFERENCES member ( member_no );

ALTER TABLE attendance
    ADD CONSTRAINT member_payment FOREIGN KEY ( member_no )
        REFERENCES member ( member_no );

ALTER TABLE "Session"
    ADD CONSTRAINT member_session FOREIGN KEY ( member_no )
        REFERENCES member ( member_no );

ALTER TABLE assessment
    ADD CONSTRAINT staff_assessment FOREIGN KEY ( staff_id )
        REFERENCES staff ( staff_id );

ALTER TABLE centre
    ADD CONSTRAINT staff_centre FOREIGN KEY ( staff_id )
        REFERENCES staff ( staff_id );

ALTER TABLE class_staff
    ADD CONSTRAINT staff_cs FOREIGN KEY ( staff_id )
        REFERENCES staff ( staff_id );

SPOOL off 
set echo off

-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                            11
-- CREATE INDEX                             2
-- ALTER TABLE                             28
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- TSDP POLICY                              0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
