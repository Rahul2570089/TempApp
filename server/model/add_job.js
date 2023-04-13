

const mongoose=require("mongoose");
const db=require("../config/db");
const UserModel=require("../model/user_model");
const { Schema }=mongoose;

const JobSchema=new Schema({
   userId:{
    type:Schema.Types.ObjectId,
    ref:UserModel.modelName
   },
  agriculture:[String],
  retail:[String],
  hospitality:[String],
  clerical:[String],
});

const JobModel=db.model('job',JobSchema);

module.exports=JobModel;