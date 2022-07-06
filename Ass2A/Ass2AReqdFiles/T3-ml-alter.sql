/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*T3-ml-alter.sql*/

/*Student ID: 32353391*/
/*Student Name: Cheng Ho Wang*/
/*Tutorial No: 01*/

/* Comments for your marker:



*/

/* 3 (a)*/
ALTER TABLE book_copy ADD condition CHAR(1);

ALTER TABLE book_copy
    ADD CONSTRAINT bk_condition_chk CHECK ( condition IN ( 'G', 'L', 'D' ) );

UPDATE book_copy
SET
    condition = 'G';

COMMENT ON COLUMN book_copy.condition IS
    'Condition of the book copy - (G)ood, (L)ost or (D)amaged. ';

UPDATE book_copy
SET
    condition = 'L'
WHERE
        book_call_no = '005.74 C824C'
    AND branch_code = (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395601655'
    );

/* 3 (b)*/
ALTER TABLE loan ADD return_branch NUMBER(2);

UPDATE loan
SET
    return_branch = branch_code;

COMMENT ON COLUMN loan.return_branch IS
    'Branch that the borrower return the book to. ';

/* 3 (c)*/
ALTER TABLE branch ADD man2_id NUMBER(2);

COMMENT ON COLUMN branch.man2_id IS
    'ID of second manager for large branch. ';

ALTER TABLE manager ADD collection_manage CHAR(1);

ALTER TABLE manager
    ADD CONSTRAINT collection_chk CHECK ( collection_manage IN ( 'F', 'R' ) );

COMMENT ON COLUMN manager.collection_manage IS
    'Collection that a manager manage - (R)eference or (F)iction ';

UPDATE manager
SET
    collection_manage = 'R'
WHERE
    man_id = 10;

UPDATE manager
SET
    collection_manage = 'F'
WHERE
    man_id = 12;

UPDATE branch
SET
    man2_id = 12
WHERE
    branch_contact_no = '0395413120';

COMMIT;