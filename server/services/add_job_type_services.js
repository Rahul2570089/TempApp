const JobTypeModel=require("../model/add_job_type");


class  JobTypeServices{

static async createJobType(userId, type) {
  const existingJobType = await JobTypeModel.findOne({ userId });
  if (existingJobType) {
    existingJobType.type = type;
    return await existingJobType.save();
  } else {
    const newJobType = new JobTypeModel({ userId, type });
    return await newJobType.save();
  }
}


}

module.exports= JobTypeServices;