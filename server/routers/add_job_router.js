const router=require("express").Router();
const JobController=require("../controller/add_job_controller");




router.post('/storeJob',JobController.createJob);

module.exports=router;