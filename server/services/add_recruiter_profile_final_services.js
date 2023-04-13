const RecruiterProfileModel=require("../model/add_recruiter_profile");


class RecruiterProfileFinalServices{

static async getRecruiterProfileData(userId){
const GetRecruiterProfile=await RecruiterProfileModel.find({userId});
return GetRecruiterProfile;
}

}

module.exports=RecruiterProfileFinalServices;