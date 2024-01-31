CREATE DATABASE todo_app;

USE todo_app;

-- CREATE TABLE users 
-- (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     name VARCHAR(255),
--     email VARCHAR(255) UNIQUE NOT NULL,
--     password VARCHAR(255)
-- );

-- CREATE TABLE todos 
-- (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     title  VARCHAR(255),
--     completed BOOLEAN DEFAULT false,
--     user_id INT NOT NULL,
--     FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
-- );

-- CREATE TABLE shared_todos
-- (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     todo_id INT,
--     user_id INT,
--     shared_with_id INT,
--     FOREIGN KEY (todo_id) REFERENCES todos(id) ON DELETE CASCADE,
--     FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
--     FOREIGN KEY (shared_with_id) REFERENCES users(id) ON DELETE CASCADE
-- );

INSERT INTO users (name , email , password) VALUES ('Pedro' , 'pedro@yahoo.es' , 'firstp@ss123456');
INSERT INTO users (name , email , password) VALUES ('Alberto' , 'enstein@germany.gl' , 'secondp@ss123456');

INSERT INTO todos ( title , user_id) VALUES 
('Take childs at school' , 1), 
('Eating better,  early in morning', 2) , 
('Arriving on Time at meeting room' , 1),
('Buy Bread, for breakfast' , 1 ),
('Take the dog out in the morning' , 1),
('Visit mom , 03/22/2024 ❤️', 2),
('Checking in Dentist 😬' , 2),
('Prepare to travel in Japan ✈️ 🇯🇵' , 1),
("🍲 Cook dinner for family 🍴", 2),
("💻 Work on project presentation 💼", 1),
("📚 Read 30 pages of book 📖", 2);





INSERT INTO shared_todos(todo_id , user_id , shared_with_id) 
Values (6,2,1);

SELECT todos.*, 
shared_todos.shared_with_id FROM todos LEFT JOIN shared_todos 
ON todos.id = shared_todos.todo_id WHERE  todos.user_id = 6 
OR shared_todos.shared_with_id = 2;