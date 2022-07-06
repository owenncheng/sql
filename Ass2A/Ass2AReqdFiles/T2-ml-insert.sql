--****PLEASE ENTER YOUR DETAILS BELOW****
--T2-ml-insert.sql

--Student ID: 32353391
--Student Name: Cheng Ho Wang
--Tutorial No: 01

/* Comments for your marker:




*/

-- 2 (a) Load the BOOK_COPY, LOAN and RESERVE tables with your own
-- test data following the data requirements expressed in the brief

--10 values into book_copy

INSERT INTO book_copy VALUES (
    10,
    4,
    20.90,
    'Y',
    '005.74 D691D'
);

INSERT INTO book_copy VALUES (
    11,
    6,
    22.93,
    'N',
    '005.756 G476F'
);

INSERT INTO book_copy VALUES (
    12,
    8,
    19.76,
    'Y',
    '112.6 S874D'
);

INSERT INTO book_copy VALUES (
    10,
    10,
    20.48,
    'Y',
    '005.74 D691D'
);

INSERT INTO book_copy VALUES (
    10,
    9,
    17.76,
    'N',
    '005.74 D691D'
);

INSERT INTO book_copy VALUES (
    11,
    1,
    18.09,
    'Y',
    '112.6 S874D'
);

INSERT INTO book_copy VALUES (
    12,
    7,
    19.76,
    'N',
    '823.914 H219A'
);

INSERT INTO book_copy VALUES (
    10,
    5,
    15.76,
    'Y',
    '005.432 L761P'
);

INSERT INTO book_copy VALUES (
    13,
    2,
    12.76,
    'N',
    '112.6 S874D'
);

INSERT INTO book_copy VALUES (
    10,
    3,
    16.99,
    'Y',
    '005.432 L761P'
);


--insert value to loan
INSERT INTO loan VALUES (
    10,
    3,
    TO_DATE('2023/6/1 14:35:37', 'YYYY/MM/DD hh24:mi:ss'),
    TO_DATE('2021/6/15', 'YYYY/MM/DD'),
    TO_DATE('2021/6/18', 'YYYY/MM/DD'),
    1
);

INSERT INTO loan VALUES (
    11,
    6,
    TO_DATE('2021/6/7 15:08:43', 'YYYY/MM/DD hh24:mi:ss'),
    TO_DATE('2021/6/21', 'YYYY/MM/DD'),
    TO_DATE('2021/6/18', 'YYYY/MM/DD'),
    2
);

INSERT INTO loan VALUES (
    12,
    7,
    TO_DATE('2021/6/15 09:25:16', 'YYYY/MM/DD hh24:mi:ss'),
    TO_DATE('2021/6/29', 'YYYY/MM/DD'),
    TO_DATE('2021/6/28', 'YYYY/MM/DD'),
    3
);

INSERT INTO loan VALUES (
    10,
    5,
    TO_DATE('2021/7/1 08:55:16', 'YYYY/MM/DD hh24:mi:ss'),
    TO_DATE('2021/7/15', 'YYYY/MM/DD'),
    TO_DATE('2021/7/14', 'YYYY/MM/DD'),
    1
);

INSERT INTO loan VALUES (
    10,
    9,
    TO_DATE('2021/7/4 11:05:28', 'YYYY/MM/DD hh24:mi:ss'),
    TO_DATE('2021/7/18', 'YYYY/MM/DD'),
    TO_DATE('2021/7/16', 'YYYY/MM/DD'),
    4
);

INSERT INTO loan VALUES (
    12,
    7,
    TO_DATE('2021/7/16 12:08:38', 'YYYY/MM/DD hh24:mi:ss'),
    TO_DATE('2021/7/30', 'YYYY/MM/DD'),
    TO_DATE('2021/7/28', 'YYYY/MM/DD'),
    2
);

INSERT INTO loan VALUES (
    13,
    2,
    TO_DATE('2021/7/28 12:45:18', 'YYYY/MM/DD hh24:mi:ss'),
    TO_DATE('2021/8/11', 'YYYY/MM/DD'),
    TO_DATE('2021/8/10', 'YYYY/MM/DD'),
    2
);

INSERT INTO loan VALUES (
    11,
    6,
    TO_DATE('2021/8/17 16:37:50', 'YYYY/MM/DD hh24:mi:ss'),
    TO_DATE('2021/8/31', 'YYYY/MM/DD'),
    TO_DATE('2021/8/29', 'YYYY/MM/DD'),
    3
);

INSERT INTO loan VALUES (
    12,
    8,
    TO_DATE('2021/8/20 15:25:18', 'YYYY/MM/DD hh24:mi:ss'),
    TO_DATE('2021/9/03', 'YYYY/MM/DD'),
    TO_DATE('2021/9/01', 'YYYY/MM/DD'),
    1
);

INSERT INTO loan VALUES (
    10,
    9,
    TO_DATE('2021/9/13 13:48:18', 'YYYY/MM/DD hh24:mi:ss'),
    TO_DATE('2021/9/27', 'YYYY/MM/DD'),
    null,
    2
);

--insert reserve
INSERT INTO reserve VALUES (
    55,
    10,
    9,
    TO_date('2021/9/11 12:19:48', 'YYYY/MM/DD hh24:mi:ss'),
    2
);

INSERT INTO reserve VALUES (
    75,
    11,
    6,
    TO_date('2021/9/12 15:53:30', 'YYYY/MM/DD hh24:mi:ss'),
    4
);
commit;
