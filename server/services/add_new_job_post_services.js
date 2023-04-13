const NewJobPostModel=require("../model/add_new_job_post");


class NewJobPostServices{

  static async createNewJobPost(userId,type,lat,long,date,time,price)
  {
     const createNewJobPost=new NewJobPostModel({userId,type,lat,long,date,time,price});
     return await createNewJobPost.save();
  }

  static async getNewJobPost(userId)
    {
       const NewJobPost=await NewJobPostModel.find({userId});
       return NewJobPost;
    }

  static async deleteNewJobPost(id)
    {
       const deleted=await NewJobPostModel.findOneAndDelete({_id:id});
       return deleted;
    }

}

module.exports=NewJobPostServices;