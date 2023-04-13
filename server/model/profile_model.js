


const mongoose=require("mongoose");
const db=require("../config/db");
const UserModel=require("../model/user_model");
const { Schema }=mongoose;

const profileSchema=new Schema({
   userId:{
    type:Schema.Types.ObjectId,
    ref:UserModel.modelName
   },
//  name:String,
//  profession:String,
//  DOB:String,
//  phone:String,
//  address:String,

profession:{
type:String,
default:'',
},

rate:{
type:String,
default:'',
},

lat:{
type:String,
default:'',
},

long:{
 type:String,
 default:'',
 },

 lablehours:{
 type:String,
 default:'',
 }

//  img:{
//   type:String,
//   default:""
//  }
});

const ProfileModel=db.model('profile',profileSchema);

module.exports=ProfileModel;