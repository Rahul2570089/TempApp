const ProfessionServices=require("../services/add_profession_services");


exports.createProfession=async (req,res,next)=>{
try{
const {userId,profession}=req.body;

let Profession=await ProfessionServices.createProfession(userId,profession);

res.json({status:true,success:Profession});
}catch(err)
{
   next(err);
}
}