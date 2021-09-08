PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS question_likes;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS users;



CREATE TABLE users (
    id INTEGER PRIMARY KEY,
    fname TEXT NOT NULL,
    lname TEXT NOT NULL
);

CREATE TABLE questions (
    id INTEGER PRIMARY KEY,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    author_id INTEGER NOT NULL,

    FOREIGN KEY (author_id) REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,

  FOREIGN KEY (question_id) REFERENCES questions(id),
  FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE replies (
    id INTEGER PRIMARY KEY,
    question_id INTEGER NOT NULL,
    parent_reply_id INTEGER,
    user_id INTEGER NOT NULL,
    body TEXT NOT NULL,

    FOREIGN KEY (question_id) REFERENCES questions(id),
    FOREIGN KEY (parent_reply_id) REFERENCES replies(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE question_likes (
    id INTEGER PRIMARY KEY,
    user_id INTEGER NOT NULL,
    question_id INTEGER NOT NULL,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (question_id) REFERENCES questions(id)
);


INSERT INTO
    users (fname, lname)
VALUES
    ('Maria', 'Vaghani'),
    ('Elliot', 'Wilson'),
    ('Cathy', 'Jung'),
    ('Raz', 'Efron');

INSERT INTO
    questions (title, body, author_id)
VALUES
    ('What is your favorite color?', 'Can you please tell me what your favorite color is?', 1),
    ('How old are you?', 'Please tell me how old you are', 2),
    ('Who am I?', 'I don''t know my user_id. Can you tell me?', 4);

INSERT INTO
    question_follows (question_id, user_id)
VALUES
    (1,1),
    (1,2),
    (1,3),
    (2,2),
    (2,4),
    (3,1),
    (3,4);


INSERT INTO
    replies (question_id, parent_reply_id, user_id, body)
VALUES
    (1, NULL, 2, 'Green lol'),
    (1, 1, 1, 'You are sooo wrong'),
    (1,2,2, 'I do not think so'),
    (2, NULL, 3, '103, how about you?');


INSERT INTO
    question_likes (user_id, question_id)
VALUES
    (1,1),
    (2,1),
    (4,3),
    (1,3);



