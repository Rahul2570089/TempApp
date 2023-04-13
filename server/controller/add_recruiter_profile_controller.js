const RecruiterProfileServices=require("../services/add_recruiter_profile_services");


exports.createRecruiterProfile=async (req,res,next)=>{
try{
const {userId,name,description,contact,address}=req.body;

let RecruiterProfile=await RecruiterProfileServices.createRecruiterProfile(userId,name,description,contact,address);

res.json({status:true,success:RecruiterProfile});
}catch(err)
{
   next(err);
}
}