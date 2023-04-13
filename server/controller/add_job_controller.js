

const JobServices=require("../services/add_job_services");


exports.createJob=async (req,res,next)=>{
try{
const {userId,agriculture,retail,hospitality,clerical}=req.body;

let Jobs=await JobServices.createJob(userId,agriculture,retail,hospitality,clerical);

res.json({status:true,success:Jobs});
}catch(err)
{
   next(err);
}
}