const NewJobPostServices=require("../services/add_new_job_post_services");


exports.createNewJobPost=async (req,res,next)=>{
try{
const {userId,type,lat,long,date,time,price}=req.body;

let newJob=await NewJobPostServices.createNewJobPost(userId,type,lat,long,date,time,price);

res.json({status:true,success:newJob});
}catch(err)
{
   next(err);
}
}


exports.getNewJobPost=async (req,res,next)=>{
try{
const {userId}=req.body;

let newJob=await NewJobPostServices.getNewJobPost(userId);

res.json({status:true,success:newJob});
}catch(err)
{
   next(err);
}
}

exports.deleteNewJobPost=async (req,res,next)=>{
try{
const {id}=req.body;

let deleted=await NewJobPostServices.deleteNewJobPost(id);

res.json({status:true,success:deleted});
}catch(err)
{
   next(err);
}
}