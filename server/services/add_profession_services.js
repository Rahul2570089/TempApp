const ProfessionModel=require("../model/add_profession");


class ProfessionServices{

  static async createProfession(userId,profession)
  {
     const createProfession=new ProfessionModel({userId,profession});
     return await createProfession.save();
  }

}

module.exports=ProfessionServices;