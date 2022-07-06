/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/* cgh_queries.sql*/

/*Student ID: 32353391*/
/*Student Name: Cheng Ho Wang*/
/*Tutorial No: 01*/

/* Comments for your marker:

*/

/*
    Q1
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon*/
/* (;) at the end of this answer*/
SELECT
    t1.doctor_title,
    t1.doctor_fname,
    t1.doctor_lname,
    t1.doctor_phone
FROM
    cgh.doctor               t1
    FULL OUTER JOIN cgh.doctor_speciality    ts
    ON ts.doctor_id = t1.doctor_id
WHERE
    spec_code = (
        SELECT
            spec_code
        FROM
            cgh.speciality
        WHERE
            lower(spec_description) = lower('ORTHOPEDIC SURGERY')
    )
ORDER BY
    t1.doctor_lname,
    t1.doctor_fname;

/*
    Q2
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/

SELECT
    ti.item_code,
    ti.item_description,
    ti.item_stock,
    cos.cc_title
FROM
    cgh.item          ti
    FULL OUTER JOIN cgh.costcentre    cos
    ON ti.cc_code = cos.cc_code
WHERE
        ti.item_stock >= 50
    AND lower(ti.item_description) LIKE '%disposable%'
ORDER BY
    ti.item_code;

/*
    Q3
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/

SELECT
    pat.patient_id,
    ltrim(pat.patient_fname
          || ' '
          || pat.patient_lname)      AS "Patient Name",
    to_char(adm.adm_date_time, 'DD-MM-YY HH24:MI:SS'),
    ltrim(doc.doctor_title
          || ' '
          || doc.doctor_fname
          || ' '
          || doc.doctor_lname)       AS "Doctor Name"
FROM
    cgh.patient      pat
    FULL OUTER JOIN cgh.admission    adm
    ON pat.patient_id = adm.patient_id
    FULL OUTER JOIN cgh.doctor       doc
    ON adm.doctor_id = doc.doctor_id
WHERE
        adm.adm_date_time >= TO_DATE('11-09-21 10', 'DD-MM-YY HH24')
    AND adm.adm_date_time <= TO_DATE('14-09-21 18', 'DD-MM-YY HH24')
ORDER BY
    adm.adm_date_time;

/*
    Q4
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/

SELECT
    proc_code,
    proc_name,
    proc_description,
    to_char(proc_std_cost, 'L99999.99') AS proc_std_cost
FROM
    cgh.procedure
WHERE
    proc_std_cost < (
        SELECT
            AVG(proc_std_cost)
        FROM
            cgh.procedure
    )
ORDER BY
    proc_std_cost DESC;

/*
    Q5
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/

SELECT
    pat.patient_id,
    pat.patient_fname,
    pat.patient_lname,
    pat.patient_dob,
    COUNT(adm.patient_id) AS "Number of Admissions"
FROM
    cgh.patient      pat
    FULL OUTER JOIN cgh.admission    adm
    ON pat.patient_id = adm.patient_id
GROUP BY
    pat.patient_id,
    pat.patient_fname,
    pat.patient_lname,
    pat.patient_dob
HAVING
    COUNT(adm.patient_id) > 2
ORDER BY
    COUNT(adm.patient_id) DESC,
    pat.patient_dob;

/*
    Q6
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/

SELECT
    adm.adm_no,
    pat.patient_id,
    pat.patient_fname,
    pat.patient_lname,
    ( to_char(adm.adm_discharge - adm.adm_date_time, 99) )
    || 'days'
    || to_char(round(mod((adm.adm_discharge - adm.adm_date_time), 1) * 24, 1), '99.9')
    || 'hrs' AS "Length of Stay"
FROM
    cgh.admission    adm
    FULL OUTER JOIN cgh.patient      pat
    ON adm.patient_id = pat.patient_id
WHERE
    adm.adm_discharge IS NOT NULL
    AND ( adm.adm_discharge - adm.adm_date_time ) > (
        SELECT
            AVG(adm_discharge - adm_date_time)
        FROM
            cgh.admission
        WHERE
            adm_discharge IS NOT NULL
    )
ORDER BY
    adm.adm_no;

/*
    Q7
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/

SELECT
    proc.proc_code,
    proc.proc_name,
    proc.proc_description,
    proc.proc_time,
    proc.proc_std_cost,
    to_char(round(AVG(admprc.adprc_pat_cost) - proc.proc_std_cost, 1),
            'S999.99') AS "Procedure Price Differential"
FROM
    cgh.procedure    proc
    RIGHT OUTER JOIN cgh.adm_prc      admprc
    ON proc.proc_code = admprc.proc_code
GROUP BY
    proc.proc_code,
    proc.proc_name,
    proc.proc_description,
    proc.proc_time,
    proc.proc_std_cost
ORDER BY
    proc.proc_code;

/*
    Q8
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/
SELECT
    proc.proc_code,
    proc.proc_name,
    nvl(it.item_code, '---')                               AS item_code,
    nvl(it.item_description, '---')                        AS item_sedescription,
    nvl(to_char(MAX(itt.it_qty_used)), '---')              AS "maximum quantity"
FROM
    cgh.procedure         proc
    LEFT OUTER JOIN cgh.adm_prc           admprc
    ON proc.proc_code = admprc.proc_code
    LEFT OUTER JOIN cgh.item_treatment    itt
    ON admprc.adprc_no = itt.adprc_no
    LEFT OUTER JOIN cgh.item              it
    ON itt.item_code = it.item_code
GROUP BY
    it.item_code,
    proc.proc_code,
    proc.proc_name,
    it.item_description
ORDER BY
    proc.proc_name,
    it.item_code;

/*
    Q9
*/
/* PLEASE PLACE REQUIRED SQL STATEMENT FOR THIS PART HERE*/
/* ENSURE that your query is formatted and has a semicolon (;)*/
/* at the end of this answer*/

SELECT
    admprc.adprc_no,
    admprc.proc_code,
    admprc.adm_no,
    adm.patient_id,
    to_char(admprc.adprc_date_time, 'DD-MM-YYYYY HH24:MI:SS')        AS adprc_date_time,
    ( admprc.adprc_pat_cost + admprc.adprc_items_cost )              AS "Total Cost"
FROM
    cgh.adm_prc      admprc
    LEFT OUTER JOIN cgh.admission    adm
    ON admprc.adm_no = adm.adm_no
WHERE
    ( admprc.adprc_pat_cost + admprc.adprc_items_cost ) = (
        SELECT DISTINCT
            ( adprc_pat_cost )
        FROM
            cgh.adm_prc ad1
        WHERE
            (
                SELECT
                    COUNT(DISTINCT(adprc_pat_cost + adprc_items_cost))
                FROM
                    cgh.adm_prc ad2
                WHERE
                    ( ad2.adprc_pat_cost + ad2.adprc_items_cost ) > ( ad1.adprc_pat_cost +
                    ad1.adprc_items_cost )
            ) = 8
    )
ORDER BY
    adm.adm_no;