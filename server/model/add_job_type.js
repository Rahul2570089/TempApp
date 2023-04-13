
const mongoose=require("mongoose");
const db=require("../config/db");
const UserModel=require("../model/user_model");
const { Schema }=mongoose;

const JobTypeSchema=new Schema({
   userId:{
    type:Schema.Types.ObjectId,
    ref:UserModel.modelName
   },
      type: {
        type: [String],
        validate: {
          validator: function(v) {
                             return v.length <= 2 && v.every(val => ['recruiter', 'freelancer'].includes(val));
                           },
          message: "The job type array can have at most two elements"
        }
      }

});

const JobTypeModel=db.model('jobtype',JobTypeSchema);

module.exports=JobTypeModel;