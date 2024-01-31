import mysql from 'mysql2';
import dotenv from 'dotenv';
dotenv.config();


const pool = mysql
.createPool({
    host : process.env.MYSQL_HOST,
    user : process.env.USER,
    password : process.env.PASSWORD,
    database : process.env.DATABASE,
})
.promise();

export async function getTodosById(id){
    const [rows] = await pool.query(
    `
SELECT todos.*, 
shared_todos.shared_with_id FROM todos LEFT JOIN shared_todos 
ON todos.id = shared_todos.todo_id WHERE todos.user_id = ? 
OR shared_todos.shared_with_id = ?
    
    `, [id , id]);

    return rows;
}

export async function getTodo(id){
    const [rows] = await pool.query(`SELECT * FROM todos WHERE id = ?`, [id]);
    return rows[0];
};

export async function getSharedTodoById(id){
   const [rows] = await pool.query(`Select * from shared_todos WHERE todo_id = ?`, [id]);
   return rows[0];
};

export async function getUserById(id){
   const [rows] = await pool.query(`Select * from users WHERE id = ?`, [id]);
   return rows[0];
};

export async function getUserByEmail(email){
   const [rows] = await pool.query(`Select * from users WHERE email = ? `, [ email ]);
  
   return rows[0];
};

export async function createTodo(user_id , title){

   const [result] = await pool.query(`
      INSERT INTO todos (user_id , title)
      VALUES ( ? , ? )
   `, [user_id , title]);

   const todoId = result.insertId;
   return getTodo(todoId);
};

export async function deleteTodo(id){
    
   const [result] = await pool.query(`
        DELETE FROM todos WHERE id = ?
   `, [id]);

   
   return result;
};

export async function toggleCompleted(id , value){
   const newValue = value === true ? "TRUE" : "FALSE";
   const [result] = await pool.query(`
   UPDATE todos
   SET completed = ${newValue}
   WHERE id = ?
   `, [id]);

   //const todoId = result.insertId;
   //return getTodo[todoId];

   return result;
};

export async function shareTodo(todo_id , user_id , shared_with_id){
  const [result] = await pool.query(
    `
    INSERT INTO shared_todos (todo_id , user_id , shared_with_id)
    VALUES (? , ? , ?)

    `,
    [todo_id , user_id , shared_with_id]
  );

  return result.insertId;
}






