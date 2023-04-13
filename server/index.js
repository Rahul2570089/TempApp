const app=require('./app');
const db=require('./config/db');
const UserModel=require("./model/user_model");
const TodoModel=require("./model/todo_model");
const ProfileModel=require("./model/profile_model");
const ProfessionModel=require("./model/add_profession");
const MinRateModel=require("./model/add_minrate_model");
const JobModel=require("./model/add_job");
const JobTypeModel=require("./model/add_job_type");
const RecruiterProfileModel=require("./model/add_recruiter_profile");
const NewJobPostModel=require("./model/add_new_job_post");
const RequestSendModel=require("./model/request_send_model");
const ReviewModel=require("./model/add_review");
const port=3000;

app.get('/',(req,res)=>{
   res.send("Hello World!!!");
}
);

app.listen(port,()=>{
console.log(`Server is running on Port http://localhost:${port}`);
});

