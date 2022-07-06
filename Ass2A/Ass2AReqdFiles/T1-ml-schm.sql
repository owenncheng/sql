--****PLEASE ENTER YOUR DETAILS BELOW****
--T1-ml-schm.sql

--Student ID: 32353391
--Student Name: Cheng Ho Wang
--Tutorial No: 01

/* Comments for your marker:




*/

-- 1.1 Add Create table statments for the Missing TABLES below
-- Ensure all column comments, and constraints (other than FK's)
-- are included. FK constraints are to be added at the end of this script

-- BOOK_COPY


create table book_copy(
branch_code number(2) not null,
bc_id number(6) not null,
bc_purchase_price number(7,2) not null,
bc_counter_reserve char(1) not null,
book_call_no varchar2(20) not null
);

ALTER TABLE book_copy ADD CONSTRAINT book_copy_pk PRIMARY KEY (branch_code, bc_id);

COMMENT ON COLUMN book_copy.bc_id IS
    'Book copy id unique within the branch which owns this book copy';

COMMENT ON COLUMN book_copy.bc_purchase_price IS
    'Purchase price for this copy';
    
COMMENT ON COLUMN book_copy.bc_counter_reserve IS
    'Flag to indicate if on Counter Reserve or not (Y/N)';
    
-- LOAN
create table loan(
branch_code number(2) not null,
bc_id number(6) not null,
loan_date_time TIMESTAMP(3) not null,
loan_due_date date not null,
loan_actual_return_date date,
bor_no number(6) not null
);

alter table loan add constraint loan_pk primary key (branch_code, bc_id, loan_date_time);

COMMENT ON COLUMN loan.loan_date_time IS
    'Date and time loan taken out';
    
COMMENT ON COLUMN loan.loan_due_date IS
    'Date loan due (no time is assigned)';
    
COMMENT ON COLUMN loan.loan_actual_return_date IS
    'Actual date loan returned (no time is assigned)';
    
-- RESERVE
create table reserve(
reserve_id number(6) not null,
branch_code number(2) not null,
bc_id number(6) not null,
reserve_date_time_placed TIMESTAMP(3) not null,
bor_no number(6) not null
);

alter table reserve add constraint reserve_pk primary key (reserve_id);

alter table reserve add constraint reserve_branch_code_qu unique (branch_code, bc_id, reserve_date_time_placed);


COMMENT ON COLUMN reserve.reserve_id IS
    'Reservation number (unique across all branches)';

COMMENT ON COLUMN reserve.reserve_date_time_placed IS
    'Date and time reserve was placed';


-- Add all missing FK Constraints below here

ALTER TABLE book_copy
    ADD CONSTRAINT bc_branch_code FOREIGN KEY (branch_code)
        REFERENCES branch ( branch_code ) on delete cascade;
        
ALTER TABLE book_copy
    ADD CONSTRAINT bc_book_call FOREIGN KEY (book_call_no)
        REFERENCES book_detail ( book_call_no) on delete cascade;

ALTER TABLE loan
    ADD CONSTRAINT loan_branch_code_fk FOREIGN KEY (branch_code, bc_id)
        REFERENCES book_copy ( branch_code, bc_id) on delete cascade;

ALTER TABLE loan
    ADD CONSTRAINT loan_bor_no_fk FOREIGN KEY (bor_no)
        REFERENCES borrower (bor_no) on delete cascade;
        
ALTER TABLE reserve
    ADD CONSTRAINT reserve_branch_code_fk FOREIGN KEY (branch_code, bc_id)
        REFERENCES book_copy (branch_code, bc_id) on delete cascade;
        
ALTER TABLE reserve
    ADD CONSTRAINT reserve_bor_no_fk FOREIGN KEY (bor_no)
        REFERENCES borrower (bor_no) on delete cascade;
        
commit;