const express = require("express");
const bodyParser = require("body-parser");
const {
  userRegister,
  userLogin,
  userGet,
  userDelete,
  userUpdate,
} = require("./controllers/user_controllers");

const app = express();
const port = 8000;

app.use(bodyParser.json());

app.post("/register", userRegister);
app.post("/login", userLogin);
app.get("/users", userGet);
app.delete("/user/:id", userDelete);
app.put("/user/:id", userUpdate);

app.listen(port, () => {
  console.log(`Server is running on port ${port}`);
});
