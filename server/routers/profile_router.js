


const router=require("express").Router();
const ProfileController=require("../controller/profile_controller");




router.post('/storeProfile/:type',ProfileController.createProfile);

module.exports=router;