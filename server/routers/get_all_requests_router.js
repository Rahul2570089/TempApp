const router=require("express").Router();
const GetAllRequestsController=require("../controller/get_all_requests_controller");




router.post('/getAllRequests', GetAllRequestsController.createGetAllRequestsController);

module.exports=router;