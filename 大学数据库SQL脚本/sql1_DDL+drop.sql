DROP TABLE prereq;
DROP TABLE time_slot;
DROP TABLE advisor;
DROP TABLE takes;
DROP TABLE student;
DROP TABLE teaches;
DROP TABLE section;
DROP TABLE instructor;
DROP TABLE course;
DROP TABLE department;
DROP TABLE classroom;
-- 删除原来可能存在的表
CREATE TABLE classroom ( building VARCHAR ( 15 ), room_number VARCHAR ( 7 ), capacity NUMERIC ( 4, 0 ), PRIMARY KEY ( building, room_number ) );
CREATE TABLE department (
	dept_name VARCHAR ( 20 ),
	building VARCHAR ( 15 ),
	budget NUMERIC ( 12, 2 ) CHECK ( budget > 0 ),
	PRIMARY KEY ( dept_name ) 
);
CREATE TABLE course (
	course_id VARCHAR ( 8 ),
	title VARCHAR ( 50 ),
	dept_name VARCHAR ( 20 ),
	credits NUMERIC ( 2, 0 ) CHECK ( credits > 0 ),
	PRIMARY KEY ( course_id ),
	FOREIGN KEY ( dept_name ) REFERENCES department ON DELETE 
	SET NULL 
	);
CREATE TABLE instructor (
	ID VARCHAR ( 5 ),
	NAME VARCHAR ( 20 ) NOT NULL,
	dept_name VARCHAR ( 20 ),
	salary NUMERIC ( 8, 2 ) CHECK ( salary > 29000 ),
	PRIMARY KEY ( ID ),
	FOREIGN KEY ( dept_name ) REFERENCES department ON DELETE 
	SET NULL 
	);
	-- ON DELETE SET NULL 约束指定，当 department 表中被引用的部门被删除时，instructor 表中的 dept_name 字段将被设置为 NULL。
	-- 重点查看关于该外键的解释和约束的处理
CREATE TABLE section (
	course_id VARCHAR ( 8 ),
	sec_id VARCHAR ( 8 ),
	semester VARCHAR ( 6 ) CHECK (
	semester IN ( 'Fall', 'Winter', 'Spring', 'Summer' )),
	YEAR NUMERIC ( 4, 0 ) CHECK ( YEAR > 1701 AND YEAR < 2100 ),
	building VARCHAR ( 15 ),
	room_number VARCHAR ( 7 ),
	time_slot_id VARCHAR ( 4 ),
	PRIMARY KEY ( course_id, sec_id, semester, YEAR ),
	FOREIGN KEY ( course_id ) REFERENCES course ON DELETE CASCADE,
	FOREIGN KEY ( building, room_number ) REFERENCES classroom ON DELETE 
	SET NULL 
	);
CREATE TABLE teaches (
	ID VARCHAR ( 5 ),
	course_id VARCHAR ( 8 ),
	sec_id VARCHAR ( 8 ),
	semester VARCHAR ( 6 ),
	YEAR NUMERIC ( 4, 0 ),
	PRIMARY KEY ( ID, course_id, sec_id, semester, YEAR ),
	FOREIGN KEY ( course_id, sec_id, semester, YEAR ) REFERENCES section ON DELETE CASCADE,
	FOREIGN KEY ( ID ) REFERENCES instructor ON DELETE CASCADE 
);
CREATE TABLE student (
	ID VARCHAR ( 5 ),
	NAME VARCHAR ( 20 ) NOT NULL,
	dept_name VARCHAR ( 20 ),
	tot_cred NUMERIC ( 3, 0 ) CHECK ( tot_cred >= 0 ),
	PRIMARY KEY ( ID ),
	FOREIGN KEY ( dept_name ) REFERENCES department ON DELETE 
	SET NULL 
	);
CREATE TABLE takes (
	ID VARCHAR ( 5 ),
	course_id VARCHAR ( 8 ),
	sec_id VARCHAR ( 8 ),
	semester VARCHAR ( 6 ),
	YEAR NUMERIC ( 4, 0 ),
	grade VARCHAR ( 2 ),
	PRIMARY KEY ( ID, course_id, sec_id, semester, YEAR ),
	FOREIGN KEY ( course_id, sec_id, semester, YEAR ) REFERENCES section ON DELETE CASCADE,
	FOREIGN KEY ( ID ) REFERENCES student ON DELETE CASCADE 
);
CREATE TABLE advisor (
	s_ID VARCHAR ( 5 ),
	i_ID VARCHAR ( 5 ),
	PRIMARY KEY ( s_ID ),
	FOREIGN KEY ( i_ID ) REFERENCES instructor ( ID ) ON DELETE 
	SET NULL,
	FOREIGN KEY ( s_ID ) REFERENCES student ( ID ) ON DELETE CASCADE 
);
CREATE TABLE time_slot (
	time_slot_id VARCHAR ( 4 ),
	DAY VARCHAR ( 1 ),
	start_hr NUMERIC ( 2 ) CHECK ( start_hr >= 0 AND start_hr < 24 ),
	start_min NUMERIC ( 2 ) CHECK ( start_min >= 0 AND start_min < 60 ),
	end_hr NUMERIC ( 2 ) CHECK ( end_hr >= 0 AND end_hr < 24 ),
	end_min NUMERIC ( 2 ) CHECK ( end_min >= 0 AND end_min < 60 ),
	PRIMARY KEY ( time_slot_id, DAY, start_hr, start_min ) 
);
CREATE TABLE prereq (
	course_id VARCHAR ( 8 ),
	prereq_id VARCHAR ( 8 ),
	PRIMARY KEY ( course_id, prereq_id ),
	FOREIGN KEY ( course_id ) REFERENCES course ON DELETE CASCADE,
FOREIGN KEY ( prereq_id ) REFERENCES course 
);