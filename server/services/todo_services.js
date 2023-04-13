const TodoModel=require("../model/todo_model");


class TodoServices{

  static async createTodo(userId,title,desc)
  {
     const createTodo=new TodoModel({userId,title,desc});
     return await createTodo.save();
  }

}

module.exports=TodoServices;