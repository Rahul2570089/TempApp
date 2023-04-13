const router=require("express").Router();
const ProfessionController=require("../controller/add_profession_controller");




router.post('/storeProfession',ProfessionController.createProfession);

module.exports=router;