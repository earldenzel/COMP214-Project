drop sequence user_seq;
drop sequence author_seq;
drop sequence books_seq;
drop sequence genre_seq;
drop sequence friend_seq;
drop sequence log_seq;

create sequence user_seq start with 100 increment by 1;
create sequence author_seq start with 200 increment by 1;
create sequence books_seq start with 300 increment by 1;
create sequence genre_seq start with 400 increment by 1;
create sequence friend_seq start with 500 increment by 1;
create sequence log_seq start with 600 increment by 1;

DROP TABLE project_logs;
DROP TABLE project_books;
DROP TABLE project_genre;
DROP TABLE project_friend;
DROP TABLE project_author;
DROP TABLE project_user;
DROP TABLE project_address;

CREATE TABLE project_address (
	addressID	NUMBER(5),
	unit		NVARCHAR2(10),
	street		NVARCHAR2(30),
	city		NVARCHAR2(30),
	province	CHAR(2),
	postalcode	NVARCHAR2(6),
	country		NVARCHAR2(20),
	CONSTRAINT addr_id_pk PRIMARY KEY (addressID)
);
INSERT INTO project_address
	VALUES (0, NULL, '135 Purvis Crescent', 'Scarborough', 'ON', 'M1B1H8', 'CANADA');
INSERT INTO project_address
	VALUES (1, NULL, '137 Purvis Crescent', 'Scarborough', 'ON', 'M1B1H8', 'CANADA');
INSERT INTO project_address
	VALUES (2, 'A3-17', '930 Progress Ave', 'Scarborough', 'ON',  NULL, 'CANADA');
INSERT INTO project_address
	VALUES (3, NULL, NULL, 'Scarborough', 'ON', NULL, 'CANADA');

CREATE TABLE project_user (
	userID		NUMBER(5),
	username	NVARCHAR2(15) NOT NULL,
	passwd  	NVARCHAR2(15),
	fname		NVARCHAR2(40) NOT NULL,
	lname		NVARCHAR2(40),
	email		NVARCHAR2(40),
	addressID	NUMBER(5),
	CONSTRAINT user_id_pk PRIMARY KEY (userID),
	CONSTRAINT user_id_addr_fk FOREIGN KEY (addressID) REFERENCES project_address (addressID)
);

INSERT INTO project_user
	VALUES (0, 'username','password','All','Perez','earldenzel@gmail.com', 0);
INSERT INTO project_user
	VALUES (1, 'earlperez','password','Earl Denzel','Perez','earldenzel@gmail.com', 1);
INSERT INTO project_user
	VALUES (2, 'siddharthpandya','password','Siddharth','Pandya', NULL, 2);
INSERT INTO project_user
	VALUES (3, 'vishalpatel','password','Vishal','Patel', NULL, 3);
  
CREATE TABLE project_genre (
	genreID		NUMBER(5),
	genrename	NVARCHAR2(20),
	CONSTRAINT gnre_id_pk PRIMARY KEY (genreID)
);
INSERT INTO project_genre 
	VALUES (0, '');
INSERT INTO project_genre 
	VALUES (1, 'Sci-Fi');
INSERT INTO project_genre 
	VALUES (2, 'Informational');
INSERT INTO project_genre 
	VALUES (3, 'Fantasy');

CREATE TABLE project_author (
	authorID	NUMBER(5),
	authorname	NVARCHAR2(50),
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
INSERT INTO project_author
	VALUES (5, 'Bill Nye');
INSERT INTO project_author
  VALUES (6, 'Andy Weir');

CREATE TABLE project_friend (
	friendID	NUMBER(5),
	friendname	NVARCHAR2(40),
	userID		NUMBER(5),
	CONSTRAINT frnd_id_pk PRIMARY KEY (friendID),
	CONSTRAINT frnd_id_user_fk FOREIGN KEY (userID) REFERENCES project_user (userID)
);

INSERT INTO project_friend
	VALUES (0, '', 0);
INSERT INTO project_friend
	VALUES (1, 'TJ', 1);
INSERT INTO project_friend
	VALUES (2, 'Mr. Friendo', 1);
INSERT INTO project_friend
	VALUES (3, 'Pauline', 1);
    
CREATE TABLE project_books (
  bookID  NUMBER(6),
	isbn		NVARCHAR2(20),
	title		NVARCHAR2(50) NOT NULL,
	pagecount	NUMBER(4),
	userID		NUMBER(5),
	friendID	NUMBER(5),
	authorID	NUMBER(5) NOT NULL,
	genreID		NUMBER(5) NOT NULL,
	comments	NVARCHAR2(140),
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
	VALUES (4,'9781850894148', 'The Lord of the Rings: The Fellowship of the Ring', 423, 2, NULL, 5, 2, 'great read');
INSERT INTO project_books
	VALUES (5,'9781427252104', 'Undeniable: Evolution and the Science of Creation', 423, 1, 2, 4, 3, 'great read');
INSERT INTO project_books
	VALUES (6,'9781427252104', 'Bill Bill Bill Bill Bill Save The World!', 423, 1, 3, 4, 2, 'great read');
INSERT INTO project_books
	VALUES (7,'9780091956141', 'The Martian', 369, 3, NULL, 6, 1, 'great read');
INSERT INTO project_books
	VALUES (8,'i wish i knew', 'The Egg', 423, 3, 1, 6, 1, 'great read');
INSERT INTO project_books
	VALUES (9,'unknown', 'Some book by Carl Sagan', 23, 2, NULL, 1, 1, 'great read');
INSERT INTO project_books
	VALUES (10,'unknown', 'Some textbook for Chemistry', 1000, 2, NULL, 4, 2, 'great read');

CREATE TABLE project_logs(
  logID NUMBER(6),
  message NVARCHAR2(140),
  userID NUMBER(5),
  time_done TIMESTAMP,
	CONSTRAINT logs_id_user_fk FOREIGN KEY (userID) REFERENCES project_user (userID)
);

--indexes
create index projectbook_title_index on project_books(title);
create index projectfriend_friendname_index on project_friend(friendname);
create index projectauthor_authorname_index on project_author(authorname);
create index projectgenre_genrename_index on project_genre(genrename);

commit;

--triggers
CREATE OR REPLACE TRIGGER log_deletes
AFTER DELETE ON PROJECT_BOOKS 
FOR EACH ROW 
DECLARE
  lv_message NVARCHAR2(140);
BEGIN
  lv_message := 'Book ' || :old.title || ' was deleted';
  INSERT INTO project_logs (logID, message, userID, time_done) VALUES (log_seq.NEXTVAL, lv_message, :old.userid, SYSDATE);
END;
/
CREATE OR REPLACE TRIGGER log_creates
AFTER INSERT ON PROJECT_BOOKS 
FOR EACH ROW 
DECLARE
  lv_message NVARCHAR2(140);
BEGIN
  lv_message := 'Book ' || :new.title || ' was included';
  INSERT INTO project_logs (logID, message, userID, time_done) VALUES (log_seq.NEXTVAL, lv_message, :new.userid, SYSDATE);
END;
/

--functions
CREATE OR REPLACE FUNCTION friendformat
(p_friendid IN NUMBER)
RETURN NVARCHAR2
IS
  lv_friend NVARCHAR2(20);
BEGIN
  IF p_friendid IS NULL
    THEN RETURN 'no one! (available)';
  ELSE
    BEGIN
    SELECT friendname INTO lv_friend
    FROM project_friend
    WHERE friendid = p_friendid;
    RETURN lv_friend;
    END;
  END IF;
END;
/

CREATE OR REPLACE FUNCTION chk_friend
  (p_chkfriend IN NVARCHAR2)
  RETURN NUMBER
  IS
    lv_friendid NUMBER(4);
BEGIN
  SELECT friendid INTO lv_friendid
  FROM project_friend
  WHERE lower(friendname) = lower(p_chkfriend);
  RETURN lv_friendid;
EXCEPTION WHEN NO_DATA_FOUND THEN
  RETURN -1;
END;
/

CREATE OR REPLACE FUNCTION authorformat
(p_authorid IN NUMBER)
RETURN NVARCHAR2
IS
  lv_author NVARCHAR2(50);
BEGIN
  SELECT authorname INTO lv_author
  FROM project_author
  WHERE authorid = p_authorid;
  RETURN lv_author;
END;
/

CREATE OR REPLACE FUNCTION ownerformat
(p_userid IN NUMBER)
RETURN NVARCHAR2
IS
  lv_user NVARCHAR2(50);
BEGIN
  SELECT fname || ' ' || lname INTO lv_user
  FROM project_user
  WHERE userid = p_userid;
  RETURN lv_user;
END;
/

CREATE OR REPLACE FUNCTION genreformat
(p_genreid IN NUMBER)
RETURN NVARCHAR2
IS
  lv_genre NVARCHAR2(50);
BEGIN
  SELECT genrename INTO lv_genre
  FROM project_genre
  WHERE genreid = p_genreid;
  RETURN lv_genre;
END;
/

CREATE OR REPLACE FUNCTION chk_genre
  (p_chkgenre IN NVARCHAR2)
  RETURN NUMBER
  IS
    lv_genreid NUMBER(4);
BEGIN
  SELECT genreid INTO lv_genreid
  FROM project_genre
  WHERE lower(genrename) = lower(p_chkgenre);
  RETURN lv_genreid;
EXCEPTION WHEN NO_DATA_FOUND THEN
  RETURN -1;
END;
/


CREATE OR REPLACE FUNCTION chk_author
  (p_chkauthor IN NVARCHAR2)
  RETURN NUMBER
  IS
    lv_authorid NUMBER(4);
BEGIN
  SELECT authorid INTO lv_authorid
  FROM project_author
  WHERE lower(authorname) = lower(p_chkauthor);
  RETURN lv_authorid;
EXCEPTION WHEN NO_DATA_FOUND THEN
  RETURN -1;
END;
/

--procedures
CREATE OR REPLACE PROCEDURE add_genre
  (p_newgenre IN NVARCHAR2,
  p_newgenreid OUT NUMBER)
  AS
BEGIN
  INSERT INTO project_genre
  VALUES(genre_seq.NEXTVAL, p_newgenre);
  p_newgenreid := genre_seq.CURRVAL;
END;
/

CREATE OR REPLACE PROCEDURE add_friend
  (p_newfriend IN NVARCHAR2,
  p_newfriendid OUT NUMBER)
  AS
BEGIN
  INSERT INTO project_friend
  VALUES(friend_seq.NEXTVAL, p_newfriend, 1);
  p_newfriendid := friend_seq.CURRVAL;
END;
/

CREATE OR REPLACE PROCEDURE add_author
  (p_newauthor IN NVARCHAR2,
  p_newauthorid OUT NUMBER)
  AS
BEGIN
  INSERT INTO project_author
  VALUES(author_seq.NEXTVAL, p_newauthor);
  p_newauthorid := author_seq.CURRVAL;
END;
/

CREATE OR REPLACE PROCEDURE log_info
(p_search IN NUMBER, v_refcur OUT sys_refcursor)
AS
BEGIN
IF p_search = 0 THEN 
  OPEN v_refcur FOR
  SELECT
    time_done "Time Done",
    message "Message"
  FROM project_logs
  ORDER BY time_done DESC;
ELSE
  OPEN v_refcur FOR
  SELECT
    time_done "Time Done",
    message "Message"
  FROM project_logs
  WHERE userid = p_search
  ORDER BY time_done DESC;
  END IF;
END;
/

CREATE OR REPLACE PROCEDURE common_book_info
(p_search IN NVARCHAR2, v_refcur OUT sys_refcursor)
AS
BEGIN
OPEN v_refcur FOR
SELECT 
  project_books.bookID "#",
  project_books.title "Title", 
  ownerformat(project_books.userid) "Owned by",
  friendformat(project_books.friendid) "Borrowed by",
  project_author.authorname "Author",
  project_genre.genrename "Genre"
  from project_books 
  join project_author on project_books.authorid = project_author.authorid
  join project_genre on project_books.genreid = project_genre.genreid
  where lower(project_books.title) like '%'||p_search||'%'
  or lower(project_author.authorname) like '%'||p_search||'%'
  or lower(project_genre.genrename) like '%'||p_search||'%';
END;
/

CREATE OR REPLACE PROCEDURE book_info
(p_id IN NUMBER, v_refcur OUT sys_refcursor)
AS
BEGIN
OPEN v_refcur FOR
SELECT 
  title "Book Title",
  isbn "ISBN",
  pagecount "Number of Pages",
  ownerformat(userid) "Owned by",
  friendformat(friendid) "Borrowed by",
  authorformat(authorid) "Authored by",
  genreformat(genreid) "Genre"
  from project_books 
  where bookID = p_id;
END;
/

CREATE OR REPLACE PROCEDURE add_new_book
  (p_isbn IN NVARCHAR2,
  p_title IN NVARCHAR2,
  p_pagecount IN NUMBER,
  p_userid IN NUMBER,
  p_friendname IN NVARCHAR2,
  p_authorname IN NVARCHAR2,
  p_genrename IN NVARCHAR2,
  p_comments IN NVARCHAR2)
AS
  lv_friendid NUMBER;
  lv_authorid NUMBER;
  lv_genreid NUMBER;
BEGIN  
  lv_friendid := chk_friend(p_friendname);
  if(lv_friendid = -1) then add_friend(p_friendname,  lv_friendid);
  end if;

  lv_genreid := chk_genre(p_genrename);
  if (lv_genreid = -1) then add_genre(p_genrename, lv_genreid);
  end if;  
  
  lv_authorid := chk_genre(p_authorname);
  if (lv_authorid = -1) then add_author(p_authorname, lv_authorid);
  end if;
  INSERT INTO PROJECT_BOOKS (BOOKID, ISBN, TITLE, PAGECOUNT, USERID, FRIENDID, AUTHORID, GENREID, COMMENTS)
  VALUES (books_seq.NEXTVAL, p_isbn, p_title, p_pagecount, p_userid, lv_friendid, lv_authorid, lv_genreid, p_comments);
END;
/