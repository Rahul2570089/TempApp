const mongoose=require("mongoose");
const db=require("../config/db");
const UserModel=require("../model/user_model");
const { Schema }=mongoose;

const RequestSendSchema=new Schema({
   userId:{
    type:Schema.Types.ObjectId,
    ref:UserModel.modelName
   },
  id:String,
  name:String,
});

const RequestSendModel=db.model('requestsend',RequestSendSchema);

module.exports=RequestSendModel;