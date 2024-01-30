const express = require("express");
const router = express.Router();
const {
  userRegister,
  userLogin,
  userGet,
  userDelete,
  userUpdate,
} = require("../controllers/user_controllers");

router.post("/register", userRegister);

router.post("/login", userLogin);

router.get("/", userGet);

router.delete("/", userDelete);

router.put("/", userUpdate);

module.exports = router;
