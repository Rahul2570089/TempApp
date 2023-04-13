const RequestSendModel=require("../model/request_send_model");


class  RequestSendServices{

static async createRequestSend(userId,id,name) {
  const existingRequestSend = await RequestSendModel.findOne({ userId });

    const newRequestSend = new RequestSendModel({ userId,id,name});
    return await newRequestSend.save();

}


}

module.exports= RequestSendServices;