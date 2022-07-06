/*****PLEASE ENTER YOUR DETAILS BELOW*****/
/*T2-ml-dm.sql*/

/*Student ID: 32353391*/
/*Student Name: Cheng Ho Wang*/
/*Tutorial No: 01*/

/* Comments for your marker:



*/

/* 2 (b) (i)*/

INSERT ALL INTO book_detail (
    book_call_no,
    book_title,
    book_classification,
    book_no_pages,
    book_pub_year,
    book_edition
) VALUES (
    '005.74 C824C',
    'Database Systems: Design, Implementation, and Management',
    'R',
    793,
    TO_DATE('2019', 'YYYY'),
    '13'
) INTO book_copy (
    branch_code,
    bc_id,
    bc_purchase_price,
    bc_counter_reserve,
    book_call_no
) VALUES (
    (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395413120'
    ),
    (
        SELECT
            MAX(bc_id) + 1
        FROM
            book_copy
        WHERE
            branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395413120'
            )
    ),
    120,
    'N',
    '005.74 C824C'
) INTO book_copy (
    branch_code,
    bc_id,
    bc_purchase_price,
    bc_counter_reserve,
    book_call_no
) VALUES (
    (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395601655'
    ),
    (
        SELECT
            MAX(bc_id) + 1
        FROM
            book_copy
        WHERE
            branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395601655'
            )
    ),
    120,
    'N',
    '005.74 C824C'
) INTO book_copy (
    branch_code,
    bc_id,
    bc_purchase_price,
    bc_counter_reserve,
    book_call_no
) VALUES (
    (
        SELECT
            branch_code
        FROM
            branch
        WHERE
            branch_contact_no = '0395461253'
    ),
    (
        SELECT
            MAX(bc_id) + 1
        FROM
            book_copy
        WHERE
            branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395461253'
            )
    ),
    120,
    'N',
    '005.74 C824C'
) SELECT
      *
  FROM
      dual;

COMMIT;

/* 2 (b) (ii)*/
DROP SEQUENCE borrower_seq;

DROP SEQUENCE reserve_seq;

CREATE SEQUENCE borrower_seq INCREMENT BY 1 START WITH 100;

CREATE SEQUENCE reserve_seq INCREMENT BY 1 START WITH 100;


/* 2 (b) (iii)*/

INSERT INTO borrower (
    bor_no,
    bor_fname,
    bor_lname,
    bor_street,
    bor_suburb,
    bor_postcode,
    branch_code
) VALUES (
    borrower_seq.NEXTVAL,
    'Ada',
    'Lovelace',
    '1st street',
    'St kilda',
    3000,
    10
);

COMMIT;

INSERT INTO reserve (
    reserve_id,
    branch_code,
    bc_id,
    reserve_date_time_placed,
    bor_no
) VALUES (
    reserve_seq.NEXTVAL,
    (
        SELECT
            branch_code
        FROM
            borrower
        WHERE
                bor_fname = 'Ada'
            AND bor_lname = 'Lovelace'
    ),
    (
        SELECT
            bc_id
        FROM
            book_copy
        WHERE
                book_call_no = '005.74 C824C'
            AND branch_code = (
                SELECT
                    branch_code
                FROM
                    borrower
                WHERE
                    bor_fname = 'Ada'
            )
    ),
    TO_DATE('2021/9/14 15:30:00', 'YYYY/MM/DD hh24:mi:ss'),
    (
        SELECT
            bor_no
        FROM
            borrower
        WHERE
                bor_fname = 'Ada'
            AND bor_lname = 'Lovelace'
    )
);

COMMIT;

/* 2 (b) (iv)*/

INSERT ALL INTO loan (
    branch_code,
    bc_id,
    loan_date_time,
    loan_due_date,
    loan_actual_return_date,
    bor_no
) VALUES (
    (
        SELECT
            branch_code
        FROM
            reserve
        WHERE
                bor_no = (
                    SELECT
                        bor_no
                    FROM
                        borrower
                    WHERE
                            bor_fname = 'Ada'
                        AND bor_lname = 'Lovelace'
                )
            AND bc_id = (
                SELECT
                    bc_id
                FROM
                    book_copy
                WHERE
                        book_call_no = '005.74 C824C'
                    AND branch_code = (
                        SELECT
                            branch_code
                        FROM
                            branch
                        WHERE
                            branch_contact_no = '0395413120'
                    )
            )
    ),
    (
        SELECT
            bc_id
        FROM
            reserve
        WHERE
                bor_no = (
                    SELECT
                        bor_no
                    FROM
                        borrower
                    WHERE
                            bor_fname = 'Ada'
                        AND bor_lname = 'Lovelace'
                )
            AND branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395413120'
            )
    ),
    to_date((
        SELECT
            to_char(trunc(reserve_date_time_placed, 'dd') + 7)
        FROM
            reserve
        WHERE
                branch_code =(
                    SELECT
                        branch_code
                    FROM
                        branch
                    WHERE
                        branch_contact_no = '0395413120'
                )
            AND bor_no =(
                SELECT
                    bor_no
                FROM
                    borrower
                WHERE
                        bor_fname = 'Ada'
                    AND bor_lname = 'Lovelace'
            )
            AND bc_id =(
                SELECT
                    bc_id
                FROM
                    book_copy
                WHERE
                        book_call_no = '005.74 C824C'
                    AND branch_code =(
                        SELECT
                            branch_code
                        FROM
                            branch
                        WHERE
                            branch_contact_no = '0395413120'
                    )
            )
    )
            || '12:30:00',
            'YYYY/MM/DD hh24:mi:ss'),
    (
        SELECT
            trunc(reserve_date_time_placed, 'dd') + 21
        FROM
            reserve
        WHERE
                branch_code = (
                    SELECT
                        branch_code
                    FROM
                        branch
                    WHERE
                        branch_contact_no = '0395413120'
                )
            AND bor_no = (
                SELECT
                    bor_no
                FROM
                    borrower
                WHERE
                        bor_fname = 'Ada'
                    AND bor_lname = 'Lovelace'
            )
            AND bc_id = (
                SELECT
                    bc_id
                FROM
                    book_copy
                WHERE
                        book_call_no = '005.74 C824C'
                    AND branch_code = (
                        SELECT
                            branch_code
                        FROM
                            branch
                        WHERE
                            branch_contact_no = '0395413120'
                    )
            )
    ),
    NULL,
    (
        SELECT
            bor_no
        FROM
            borrower
        WHERE
                bor_fname = 'Ada'
            AND bor_lname = 'Lovelace'
    )
) SELECT
      *
  FROM
      dual;

COMMIT;

DELETE FROM reserve
WHERE
        branch_code = (
            SELECT
                branch_code
            FROM
                branch
            WHERE
                branch_contact_no = '0395413120'
        )
    AND bc_id = (
        SELECT
            bc_id
        FROM
            book_copy
        WHERE
                book_call_no = '005.74 C824C'
            AND branch_code = (
                SELECT
                    branch_code
                FROM
                    branch
                WHERE
                    branch_contact_no = '0395413120'
            )
    )
    AND bor_no = (
        SELECT
            bor_no
        FROM
            borrower
        WHERE
                bor_fname = 'Ada'
            AND bor_lname = 'Lovelace'
    );

COMMIT;