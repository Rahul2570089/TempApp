const router=require("express").Router();
const RecruiterProfileController=require("../controller/add_recruiter_profile_controller");




router.post('/storeRecruiterProfile',RecruiterProfileController.createRecruiterProfile);

module.exports=router;