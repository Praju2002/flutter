function authenticate(req, res) {
  const userEmail = "abc@gmail.com";
  const userPassword = "11124";
  const { email, password } = req.body;
  const requestBody = req.body;
  console.log(req.body);
  // if (userEmail === email && userPassword == password) {
  //   return res.send("login succesful!!");
  // } else {
  //   return res.status(400).send("invalid email or password");
  // }

  if (userEmail !== email || userPassword !== password) {
    return res.status(400).json({
      message: "invalid email or password",
    });
  }
  res.status(200).send({
    message: "login succesful",
    data: requestBody,
  });
}
module.exports = {
  authenticate,
};
