drop sequence user_seq;
drop sequence author_seq;
drop sequence address_seq;
drop sequence books_seq;
drop sequence genre_seq;
drop sequence friend_seq;

create sequence user_seq start with 100 increment by 1;
create sequence author_seq start with 200 increment by 1;
create sequence address_seq start with 300 increment by 1;
create sequence books_seq start with 400 increment by 1;
create sequence genre_seq start with 500 increment by 1;
create sequence friend_seq start with 600 increment by 1;

DROP PROCEDURE common_book_info;
DROP TABLE project_books;
DROP TABLE project_genre;
DROP TABLE project_friend;
DROP TABLE project_author;
DROP TABLE project_user;
DROP TABLE project_address;

CREATE TABLE project_address (
	addressID	NUMBER(5),
	unit		VARCHAR(10),
	street		VARCHAR(30),
	city		VARCHAR(30),
	province	CHAR(2),
	postalcode	VARCHAR(6),
	country		VARCHAR(20),
	CONSTRAINT addr_id_pk PRIMARY KEY (addressID)
);

INSERT INTO project_address
	VALUES (1, NULL, '137 Purvis Crescent', 'Scarborough', 'ON', 'M1B1H8', 'CANADA');
INSERT INTO project_address
	VALUES (2, 'A3-17', '930 Progress Ave', 'Scarborough', 'ON',  NULL, 'CANADA');
INSERT INTO project_address
	VALUES (3, NULL, NULL, 'Scarborough', 'ON', NULL, 'CANADA');

CREATE TABLE project_user (
	userID		NUMBER(5),
	username	VARCHAR(15) NOT NULL,
	passwd  	VARCHAR(15),
	fname		VARCHAR(40) NOT NULL,
	lname		VARCHAR(40),
	email		VARCHAR(40),
	addressID	NUMBER(5),
	CONSTRAINT user_id_pk PRIMARY KEY (userID),
	CONSTRAINT user_id_addr_fk FOREIGN KEY (addressID) REFERENCES project_address (addressID)
);

INSERT INTO project_user
	VALUES (1, 'earlperez','password','Earl Denzel','Perez','earldenzel@gmail.com', 1);
INSERT INTO project_user
	VALUES (2, 'siddharthpandya','password','Siddharth','Pandya', NULL, 2);
INSERT INTO project_user
	VALUES (3, 'vishalpatel','password','Vishal','Patel', NULL, 3);
  
CREATE TABLE project_genre (
	genreID		NUMBER(5),
	genrename	VARCHAR(20),
	CONSTRAINT gnre_id_pk PRIMARY KEY (genreID)
);

INSERT INTO project_genre 
	VALUES (1, 'Sci-Fi');
INSERT INTO project_genre 
	VALUES (2, 'Informational');
INSERT INTO project_genre 
	VALUES (3, 'Fantasy');

CREATE TABLE project_author (
	authorID	NUMBER(5),
	authorname	VARCHAR(50),
	CONSTRAINT auth_id_pk PRIMARY KEY (authorID)
);

INSERT INTO project_author
	VALUES (1, 'Carl Sagan');
INSERT INTO project_author
	VALUES (2, 'Neil de Grasse Tyson');
INSERT INTO project_author
	VALUES (3, 'George R.R. Martin');
INSERT INTO project_author
	VALUES (4, 'J.R.R. Tolkien');

CREATE TABLE project_friend (
	friendID	NUMBER(5),
	friendname	VARCHAR(40),
	userID		NUMBER(5),
	CONSTRAINT frnd_id_pk PRIMARY KEY (friendID),
	CONSTRAINT frnd_id_user_fk FOREIGN KEY (userID) REFERENCES project_user (userID)
);

INSERT INTO project_friend
	VALUES (1, 'TJ', 1);
INSERT INTO project_friend
	VALUES (2, 'Mr. Friendo', 1);
    
CREATE TABLE project_books (
  bookID  NUMBER(6),
	isbn		VARCHAR(20),
	title		VARCHAR(50) NOT NULL,
	pagecount	NUMBER(4),
	userID		NUMBER(5),
	friendID	NUMBER(5),
	authorID	NUMBER(5) NOT NULL,
	genreID		NUMBER(5) NOT NULL,
	comments	VARCHAR(140),
	CONSTRAINT book_id_pk PRIMARY KEY (bookID),
	CONSTRAINT book_id_user_fk FOREIGN KEY (userID) REFERENCES project_user (userID),
	CONSTRAINT book_id_frnd_fk FOREIGN KEY (friendID) REFERENCES project_friend (friendID),
	CONSTRAINT book_id_auth_fk FOREIGN KEY (authorID) REFERENCES project_author (authorID),
	CONSTRAINT book_id_gnre_fk FOREIGN KEY (genreID) REFERENCES project_genre (genreID)
);

INSERT INTO project_books
	VALUES (1,'9783426607657', 'Contact', 432, 1, 1, 1, 1, NULL);
INSERT INTO project_books
	VALUES (2,'9781538408018', 'Astrophysics for People in a Hurry', 244, 1, NULL, 2, 2, 'comment');
INSERT INTO project_books
	VALUES (3,'9788496422612', 'A Game of Thrones', 694, 1, 2, 3, 3, 'great read');
INSERT INTO project_books
	VALUES (4,'9781850894148', 'The Lord of the Rings: The Fellowship of the Ring', 423, 1, 2, 4, 3, 'great read');

CREATE OR REPLACE PROCEDURE common_book_info
(p_search IN NVARCHAR2, v_refcur OUT sys_refcursor)
AS
BEGIN
OPEN v_refcur FOR
SELECT 
  project_books.title "Title", 
  project_friend.friendname "Friend Name",
  project_author.authorname "Author",
  project_genre.genrename "Genre"
  from project_books 
  left outer join project_friend on project_books.friendid = project_friend.friendid
  join project_author on project_books.authorid = project_author.authorid
  join project_genre on project_books.genreid = project_genre.genreid
  where lower(project_books.title) like '%'||p_search||'%'
  or lower(project_friend.friendname) like '%'||p_search||'%'
  or lower(project_author.authorname) like '%'||p_search||'%'
  or lower(project_genre.genrename) like '%'||p_search||'%';
END;


