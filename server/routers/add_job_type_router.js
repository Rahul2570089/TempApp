const router=require("express").Router();
const JobTypeController=require("../controller/add_job_type_controller");




router.post('/storeJobType',JobTypeController.createJobType);

module.exports=router;