const { User } = require("../models/user.model");

async function userRegister(req, res) {
  const { username, email, password } = req.body;

  if (!username || !email || !password) {
    return res.status(400).json({
      error: "Missing required fields",
    });
  }
  try {
    const user = await User.create({ name: username, email, password });
    return res
      .status(200)
      .json({ data: user, message: "User registered successfully" });
  } catch (error) {
    return res
      .status(500)
      .json({ error: error, message: "something went wrong" });
  }
}

async function userLogin(req, res) {
  const { email } = req.body;

  try {
    const user = await User.findOne({ email });

    if (!user) {
      return res.status(400).json({
        message: "Invalid email",
      });
    }

    return res.status(200).json({
      message: "Login successful",
      data: user,
    });
  } catch (error) {
    return res.status(500).json({
      error: error.message,
      message: "Something went wrong",
    });
  }
}

function userGet(req, res) {
  const { username, email, password } = req.body;
  const getuserdata = req.body;
  return res.status(200).json({
    users: getuserdata,
  });
}

function userDelete(req, res) {
  const id = req.params.id;

  return res.status(200).json({ message: `User deleted ${id}` });
}

function userUpdate(req, res) {
  return res.status(200).json({ message: `User updated ${id}` });
}

module.exports = {
  userRegister,
  userLogin,
  userGet,
  userDelete,
  userUpdate,
};
