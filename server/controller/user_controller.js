const UserService = require("../services/user_services");

exports.register = async (req, res, next) => {
  try {
    const { name, email, password } = req.body;
    const userExists = await UserService.checkUser(email);

    if (userExists) {
      // Display message in snackbar
      return res.status(400).json({ status: false, error: "User with the same email id already exists" });
    }
    const successReq = await UserService.registerUser(name, email, password);

    res.json({ status: true, success: "User Registered Successfully" });
  } catch (err) {
    throw err;
  }

}

exports.login = async (req, res, next) => {
  try {
    const { email, password } = req.body;
    const user = await UserService.checkUser(email);
    if (!user) {
      return res.status(401).json({ status: false, message: "User does not exist" });
      //throw new Error("User does not exist");
    }

    const isMatch = await user.comparePassword(password);
    if (isMatch == false) {
      return res.status(401).json({ status: false, message: "Password Invalid" });
      //  throw new Error("Password Invalid");
    }
    let tokenData = { _id: user._id, email: user.email };
    const token = await UserService.generateToken(tokenData, "secretKey", "1h");
    res.status(200).json({ status: true, token: token });
  } catch (err) {
    return res.status(401).json({ status: false, message: "Token expired" });
  }

}