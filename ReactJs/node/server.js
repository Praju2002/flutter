// const hhtp =require('http');

// hhtp.createServer(function (req,res){
//     res.write('hello world');
//     console.log('serevre is running on port 0000');
//     res.send("server is running on port 0000")
//     res.end();
// }).listen(8080);

// const express=require('express');
// const app=express();
// const port=8000;

// app.get('/',(req,res)=>{
//     res.send('hello world');
// })
// app.get('/user',(req,res)=>{
//     res.send('hello user');
// })

// app.post('/routing',(req,res)=>{
//     console.log(req.body);
//     console.log(req.query);
//     res.send("postreq");
// })
// app.listen(port,()=>{
//     console.log(`server is running on port ${port}`);
// })

// user postlogin postregister getuser delete updateuser
const express = require("express");
const app = express();
const port = 8000;
const bodyParser = require("body-parser");
app.use(bodyParser.urlencoded({ extended: false }));

const mongodbConnection = require("./mongodb.config");
mongodbConnection();

app.use(bodyParser.json());

const userRoutes = require("./routes/user_routes");
app.use("/user", userRoutes);

const loginRoutes = require("./routes/user_routes");
app.use("/login", loginRoutes);

app.listen(port, () => {
  console.log(`server is running on port ${port}`);
});

// app.post("/post", (req, res) => {
//   const requestBody = req.body;
//   res.json({ message: "Post request successful", data: requestBody });
// });

// app.put("/put/:id", (req, res) => {
//   const requestId = req.params.id;
//   const requestBody = req.body;
//   res.json({
//     message: `Put request for ID ${requestId} successful`,
//     data: requestBody,
//   });
// });

// app.patch("/patch/:id", (req, res) => {
//   const requestId = req.params.id;
//   const requestBody = req.body;
//   res.json({
//     message: `Patch request for ID ${requestId} successful`,
//     data: requestBody,
//   });
// });

// app.listen(port, () => {
//   console.log(`server is running on port ${port}`);
// });
