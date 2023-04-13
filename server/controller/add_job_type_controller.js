const JobServices=require("../services/add_job_type_services");


exports.createJobType=async (req,res,next)=>{
try{
const {userId,type}=req.body;

let JobType=await JobServices.createJobType(userId,type);

res.json({status:true,success:JobType});
}catch(err)
{
   next(err);
}
}