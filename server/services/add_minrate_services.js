const MinRateModel=require("../model/add_minrate_model");


class  MinRateServices{

//  static async createMinRate(userId, minrate)
//  {
//     const createMinRate=new  MinRateModel({userId, minrate});
//     return await createMinRate.save();
//  }

static async createMinRate(userId, minrate) {
  const existingMinRate = await MinRateModel.findOne({ userId });
  if (existingMinRate) {
    existingMinRate.minrate = minrate;
    return await existingMinRate.save();
  } else {
    const newMinRate = new MinRateModel({ userId, minrate });
    return await newMinRate.save();
  }
}


}

module.exports= MinRateServices;