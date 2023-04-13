const AddReviewModel=require("../model/add_review");


class AddReviewServices{

  static async addReviewData(rId,userId,review)
  {
     const create=new AddReviewModel({rId,userId,review});
     return await create.save();
  }

}

module.exports=AddReviewServices;



