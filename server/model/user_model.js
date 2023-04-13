const mongoose=require("mongoose");
const bcrypt=require("bcrypt");
const db=require("../config/db");

const {Schema }=mongoose;

const userSchema=new Schema({
   name:{
    type:String,
    required:true,
   },
   email:{
    type:String,
       required:true,
       unique:true,
       validate: {
             validator: function (email) {
               // Regex for email validation
               return /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/.test(email);
             },
             message: "Please enter a valid email address",
           },
   },
   password:{
    type:String,
       required:true,
         validate: {
             validator: function (password) {
               // Password must contain at least 8 characters, including at least one uppercase letter, one lowercase letter, one number, and one special character
               return /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/.test(password);
             },
             message: "Password must contain at least 8 characters, including at least one uppercase letter, one lowercase letter, one number, and one special character",
           },
   }
});

userSchema.pre('save',async function(){
try{
  var user=this;
  const salt=await(bcrypt.genSalt(10));
  const hashpass=await bcrypt.hash(user.password,salt);

  user.password=hashpass;
}catch(err)
{
  throw err;
}
});

userSchema.methods.comparePassword=async function(userPassword)
{
try{
  const isMatch=await bcrypt.compare(userPassword,this.password);
  return isMatch;
}catch(error){
  throw error;
}
}
const UserModel=db.model('user',userSchema);

module.exports=UserModel;