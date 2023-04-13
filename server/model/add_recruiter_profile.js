

const mongoose=require("mongoose");
const db=require("../config/db");
const UserModel=require("../model/user_model");
const { Schema }=mongoose;

const RecruiterProfileSchema=new Schema({
   userId:{
    type:Schema.Types.ObjectId,
    ref:UserModel.modelName
   },
  name:String,
  description:String,
  contact:String,
  address:String,
});

const RecruiterProfileModel=db.model('recruiterprofile',RecruiterProfileSchema);

module.exports=RecruiterProfileModel;