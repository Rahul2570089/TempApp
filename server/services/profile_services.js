
const ProfileModel=require("../model/profile_model");


class ProfileServices{

//  static async createProfile(userId,name,profession,DOB,phone,address)
//  {
//     const createProfile=new ProfileModel({userId,name,profession,DOB,phone,address});
//     return await createProfile.save();
//  }

static async createProfile(userId, type, data) {
  let fieldToUpdate;
  switch (type) {
    case 'profession':
      fieldToUpdate = 'profession';
      break;
    case 'rate':
      fieldToUpdate = 'rate';
      break;

    case 'lat':
          fieldToUpdate = 'lat';
          break;
     case 'long':
              fieldToUpdate = 'long';
              break;
     case 'lablehours':
                   fieldToUpdate = 'lablehours';
                   break;
     default:
      throw new Error('Invalid field');
  }

  const updateField = { [fieldToUpdate]: data[fieldToUpdate] };
  const existingProfile = await ProfileModel.findOne({ userId });

  if (!existingProfile) {
    // User profile does not exist, create a new one
    const newProfile = new ProfileModel({
      userId,
      ...updateField
    });
    return await newProfile.save();
  } else {
    // User profile exists, update the specified field
    existingProfile[fieldToUpdate] = data[fieldToUpdate];
    return await existingProfile.save();
  }
}
}
module.exports=ProfileServices;







