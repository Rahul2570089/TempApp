const AddReviewServices=require("../services/add_review_services");

exports.createAddReviewController=async (req,res,next)=>{
try{
  const {rId,userId,review}=req.body;

  let Review=await AddReviewServices.addReviewData(rId,userId,review);

  res.json({status:true,success:Review});
}catch(error){
  next(error);
}
}


