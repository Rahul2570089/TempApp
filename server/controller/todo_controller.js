const TodoServices=require("../services/todo_services");


exports.createTodo=async (req,res,next)=>{
try{
const {userId,title,desc}=req.body;

let todo=await TodoServices.createTodo(userId,title,desc);

res.json({status:true,success:todo});
}catch(err)
{
   next(err);
}
}