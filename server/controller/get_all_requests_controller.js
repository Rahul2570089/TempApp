const GetAllRequestsServices=require("../services/get_all_requests_services");


exports.createGetAllRequestsController=async (req,res,next)=>{
try{
const {userId}=req.body;

let allrequests=await GetAllRequestsServices.getAllRequests(userId);

res.json({status:true,success:allrequests});
}catch(err)
{
   next(err);
}
}