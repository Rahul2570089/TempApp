const RecruiterProfileModel=require("../model/add_recruiter_profile");


class  RecruiterProfileServices{

static async createRecruiterProfile(userId,name,description,contact,address) {
  const existingRecruiterProfile = await RecruiterProfileModel.findOne({ userId });
  if (existingRecruiterProfile) {
    existingRecruiterProfile.name = name;
     existingRecruiterProfile.description = description;
      existingRecruiterProfile.contact = contact;
       existingRecruiterProfile.address = address;
    return await existingRecruiterProfile.save();
  } else {
    const newRecruiterProfile = new RecruiterProfileModel({ userId,name,description,contact,address });
    return await newRecruiterProfile.save();
  }
}


}

module.exports= RecruiterProfileServices;