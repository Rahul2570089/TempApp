

const RequestSendServices=require("../services/request_send_services");


exports.createRequestSend=async (req,res,next)=>{
try{
const {userId,id,name}=req.body;

let requestsend=await RequestSendServices.createRequestSend(userId,id,name);

res.json({status:true,success:requestsend});
}catch(err)
{
   next(err);
}
}