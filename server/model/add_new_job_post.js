const mongoose=require("mongoose");
const db=require("../config/db");
const UserModel=require("../model/user_model");
const { Schema }=mongoose;

const newJobPostSchema=new Schema({
   userId:{
    type:Schema.Types.ObjectId,
    ref:UserModel.modelName
   },
  type:String,
  lat:String,
  long:String,
  date:String,
  time:String,
  price:String
});

const NewJobPostModel=db.model('newjobpost',newJobPostSchema);

module.exports=NewJobPostModel;