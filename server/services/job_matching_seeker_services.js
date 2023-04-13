const JobMatchingSeekerModel=require("../model/add_job");
const NewJobPostModel=require("../model/add_new_job_post");
class JobMatchingSeekerServices{


//  static async getJobMatchingSeeker(userId)
//    {
//       const jobMatchingSeeker=await JobMatchingSeekerModel.find({userId});
//       return jobMatchingSeeker;
//    }

static async getJobMatchingSeeker(userId) {
  const jobMatchingSeeker = await JobMatchingSeekerModel.findOne({ userId });

  if (!jobMatchingSeeker) {
    throw new Error('JobMatchingSeeker not found');
  }

  const agriculture = jobMatchingSeeker.agriculture || [];
  const retail = jobMatchingSeeker.retail || [];
  const hospitality = jobMatchingSeeker.hospitality || [];
  const clerical = jobMatchingSeeker.clerical || [];

  const result = [];

  for (const value of agriculture) {
    result.push(value);
  }

  for (const value of retail) {
    result.push(value);
  }

  for (const value of hospitality) {
    result.push(value);
  }

  for (const value of clerical) {
    result.push(value);
  }
const newJobPosts = await NewJobPostModel.find({ type: { $in: result } });

    return newJobPosts;
//  return result;
}



}

module.exports=JobMatchingSeekerServices;


