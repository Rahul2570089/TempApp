const router=require("express").Router();
const RequestSendController=require("../controller/request_send_controller");




router.post('/storerequests',RequestSendController.createRequestSend);

module.exports=router;