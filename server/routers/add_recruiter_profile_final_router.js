const router=require("express").Router();
const RecruiterProfileFinalController=require("../controller/add_recruiter_profile_final_controller");




router.post('/getRecruiterProfileFinal',RecruiterProfileFinalController.getRecruiterProfile);

module.exports=router;







