const ProfileServices = require('../services/profile_services');


exports.createProfile = async (req, res) => {
  const userId = req.body.userId;
  const type = req.params.type;
  const data = req.body;
  try {
    const profile = await ProfileServices.createProfile(userId, type, data);
    res.status(200).json({
      status: true,
      success: profile
    });
  } catch (error) {
    res.status(500).json({
      status: false,
      error: error.message
    });
  }
};