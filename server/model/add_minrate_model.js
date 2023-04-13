const mongoose=require("mongoose");
const db=require("../config/db");
const UserModel=require("../model/user_model");
const { Schema }=mongoose;

const MinRateSchema=new Schema({
   userId:{
    type:Schema.Types.ObjectId,
    ref:UserModel.modelName
   },
  minrate:String,
});

const MinRateModel=db.model('minrate',MinRateSchema);

module.exports=MinRateModel;