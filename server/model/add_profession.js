const mongoose=require("mongoose");
const db=require("../config/db");
const UserModel=require("../model/user_model");
const { Schema }=mongoose;

const professionSchema=new Schema({
   userId:{
    type:Schema.Types.ObjectId,
    ref:UserModel.modelName
   },
  profession:String,
});

const ProfessionModel=db.model('profession',professionSchema);

module.exports=ProfessionModel;