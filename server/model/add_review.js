const mongoose=require("mongoose");
const db=require("../config/db");
const UserModel=require("../model/user_model");
const { Schema }=mongoose;

const AddReviewSchema=new Schema({
  rId:String,
 userId:String,
 review:String,
});

const AddReviewModel=db.model('review',AddReviewSchema);

module.exports=AddReviewModel;