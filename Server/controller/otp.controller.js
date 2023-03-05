const otpService = require("../service/otp.service");

const sendOTP = async (req, res) => {
  try {
    const { username, phoneNumber } = req.body;
    const {success, message} = await otpService.sendOTP(username, phoneNumber);
    res.status(200).send({ success, message });
  } catch (error) {
    console.log(error.message);
    res.status(404).send({ success: false, message: error.message });
  }
};

const reSendOTP = async (req, res) => {
  try {
    const { phoneNumber } = req.body;
    const { success, message} = await otpService.reSendOTP(phoneNumber);
    res.status(200).send({ success, message });
  } catch (error) {
    console.log(error.message);
    res.status(404).send({ success: false, message: error.message });
  }
};

const verifyOTP = async (req, res) => {
  try {
    const { phoneNumber, otp } = req.body;
    const token = await otpService.verifyOTP(phoneNumber, otp);
  
    res.status(200).send({ success: true, token: token });
  } catch (error) {
    console.log(error.message)
    res.status(404).send({ success: false, message: error.message });
  }
};

module.exports = {
  sendOTP,
  reSendOTP,
  verifyOTP,
};
