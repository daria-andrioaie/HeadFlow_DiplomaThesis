const userService = require("../service/user.service");

const signUp = async (req, res) => {
  try {
    const user = await userService.signUp(req.body);
    res.status(200).send({ user });
  } catch (error) {
    console.log(error.message);
    res.status(404).send({ success: false, message: error.message });
  }
};

const login = async (req, res) => {
  try {
    const user = await userService.login(req.body);
    res.status(200).send({ user });
  } catch (error) {
    console.log(error.message);
    res.status(404).send({ success: false, message: error.message });
  }
};

const socialSignIn = async (req, res) => {
  try {
    const { socialToken } = req.body;
    const { token, user } = await userService.socialSignIn(socialToken);
  
    res.status(200).send({ success: true, token: token, user: user });
  } catch (error) {
    console.log(error.message)
    res.status(404).send({ success: false, message: error.message });
  }
}

const logout = async (req, res) => {
  const bearerHeader = req.headers['authorization'];
  if(typeof bearerHeader === 'undefined') {
    res.status(404).send({ success: false, message: "No token was provided." });
  }

  const token = bearerHeader.split(" ")[1];
  if (!token) {
    res.status(200).send({ success: false, message: "No token was provided." });
  }

  try {
    const message = await userService.logout(token);
    res.status(200).send({ success: true, message: message });
  } catch (error) {
    console.log(error.message);
    res.status(404).send({ success: false, message: error.message });
  }
};

const checkToken = async (req, res) => {
  const bearerHeader = req.headers['authorization'];
  if(typeof bearerHeader === 'undefined') {
    res.status(404).send({ success: false, message: "No token was provided." });
  }

  const token = bearerHeader.split(" ")[1];
  if (!token) {
    res.status(404).send({ success: false, message: "No token was provided." });
  }

  try {
    const { success, message }  = await userService.checkToken(token);
    res.status(200).send({ success: success, message: message });
  } catch (error) {
    console.log(error.message);
    res.status(404).send({ success: false, message: error.message });
  }
};

module.exports = {
  signUp,
  login,
  socialSignIn,
  logout,
  checkToken,
};
