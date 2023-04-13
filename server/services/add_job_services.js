const JobModel=require("../model/add_job");

class  JobServices{

  static async createJob(userId, agriculture, retail, hospitality, clerical) {
//    const existingJob = await JobModel.findOne({ userId });
//    if (existingJob) {
//      if (agriculture) {
//        existingJob.agriculture = agriculture;
//      }
//      if (retail) {
//        existingJob.retail = retail;
//      }
//      if (hospitality) {
//        existingJob.hospitality = hospitality;
//      }
//      if (clerical) {
//        existingJob.clerical = clerical;
//      }
//      return await existingJob.save();
//    } else {
      const newJob = new JobModel({ userId, agriculture, retail, hospitality, clerical });
      return await newJob.save();
//    }
  }
}

module.exports= JobServices;
