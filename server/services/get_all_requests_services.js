const RequestSendModel=require("../model/request_send_model");
const NewJobPostModel=require("../model/add_new_job_post");
const UserModel=require('../model/user_model');


//class GetAllRequestsServices{
////  static async getJobMatchingSeeker(userId)
////    {
////       const jobMatchingSeeker=await JobMatchingSeekerModel.find({userId});
////       return jobMatchingSeeker;
////    }
//static async getAllRequests(userId) {
//  const NewJobPost = await NewJobPostModel.find({ userId });
//  if (!NewJobPostModel) {
//    throw new Error('NewJobPostModel not found');
//  }
//  const ids = NewJobPost.map(jobPost =>jobPost._id);
//const findId = await RequestSendModel.find({ id: { $in: ids } });
////
////
//const Userids = findId.map(jobPost =>jobPost.userId);
//const UserName = await UserModel.find({ _id:{$in:Userids} });
////
////  const findId = await RequestSendModel.find({ id: { $in: ids } });
//return {findId,UserName} ;
//}
//}


class GetAllRequestsServices{
//  static async getJobMatchingSeeker(userId)
//    {
//       const jobMatchingSeeker=await JobMatchingSeekerModel.find({userId});
//       return jobMatchingSeeker;
//    }
static async getAllRequests(userId) {
  const NewJobPost = await NewJobPostModel.find({ userId });
    const ids = NewJobPost.map(jobPost =>jobPost._id);

    const findId = await RequestSendModel.find({ id: { $in: ids } });

    const userIds = findId.map(request => request.userId);
    const users = await UserModel.find({ _id: { $in: userIds } });

    const results = findId.map(request => {
      const user = users.find(user => user._id.toString() === request.userId.toString());
      return {
        findId: request,
        userName: user ? user.name : null
      };
    });

    return { success: results };



//return {findId,UserName} ;
}
}









module.exports=GetAllRequestsServices;


