const mongoose = require("mongoose");
// mongoose.connect('mongodb+srv://praju:praju5541@cluster0.ulllouu.mongodb.net/?retryWrites=true&w=majority').then((result)=>{
//  console.log("database connected");
// }
// ).catch((err)=>{
//     console.log(err);
// })
async function mongodbConnection() {
  try {
    await mongoose.connect(
      "mongodb+srv://praju:praju5541@cluster0.ulllouu.mongodb.net/?retryWrites=true&w=majority"
    );
  } catch (error) {
    console.log(error);
  }
}
module.exports = mongodbConnection;
