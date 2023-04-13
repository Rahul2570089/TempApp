const MinRateServices=require("../services/add_minrate_services");


exports.createMinRate=async (req,res,next)=>{
try{
const {userId,minrate}=req.body;

let MinRate=await MinRateServices.createMinRate(userId,minrate);

res.json({status:true,success:MinRate});
}catch(err)
{
   next(err);
}
}