const router=require("express").Router();
const JobMatchingSeekerController=require("../controller/job_matching_seeker_controller");




router.post('/getJobMatchingSeeker',JobMatchingSeekerController.getJobMatchingSeeker);

module.exports=router;