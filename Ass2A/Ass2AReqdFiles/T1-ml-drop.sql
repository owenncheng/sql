--****PLEASE ENTER YOUR DETAILS BELOW****
--T1-ml-drop.sql

--Student ID: 32353391
--Student Name: Cheng Ho Wang
--Tutorial No: 01


/* Comments for your marker:




*/

-- 1.2 Add Drop table statements for ALL table below (not just those created
-- in this script)use ONLY
--      DROP TABLE tblname PURGE
-- syntax DO NOT use CASCADE CONSTRAINTS


drop table loan purge;
drop table reserve purge;
drop table borrower purge;
drop table book_copy purge;
drop table book_detail purge;
drop table branch purge;
drop table manager purge;

commit;