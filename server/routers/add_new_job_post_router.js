const router=require("express").Router();
const NewJobPostController=require("../controller/add_new_job_post_controller");




router.post('/storeNewJobPost',NewJobPostController.createNewJobPost);
router.post('/getNewJobPost',NewJobPostController.getNewJobPost);
router.post('/deleteNewJobPost',NewJobPostController.deleteNewJobPost);
module.exports=router;