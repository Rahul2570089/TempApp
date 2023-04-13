const RecruiterProfileFinalServices=require("../services/add_recruiter_profile_final_services");

exports.getRecruiterProfile=async (req,res,next)=>{
try{
  const {userId}=req.body;

  let recruiterprofile=await RecruiterProfileFinalServices.getRecruiterProfileData(userId);

  res.json({status:true,success:recruiterprofile});
}catch(error){
  next(error);
}
}