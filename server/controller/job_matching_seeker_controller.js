const JobMatchingSeekerServices=require("../services/job_matching_seeker_services");



exports.getJobMatchingSeeker=async (req,res,next)=>{
try{
const {userId}=req.body;

let jobMatchingSeeker=await JobMatchingSeekerServices.getJobMatchingSeeker(userId);

res.json({status:true,success:jobMatchingSeeker});
}catch(err)
{
   next(err);
}
}
