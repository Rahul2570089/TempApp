const router=require("express").Router();
const AddReviewController=require("../controller/add_review_controller");




router.post('/storeReview', AddReviewController.createAddReviewController);

module.exports=router;