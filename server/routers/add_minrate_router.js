const router=require("express").Router();
const MinRateController=require("../controller/add_minrate_controller");




router.post('/storeMinRate',MinRateController.createMinRate);

module.exports=router;