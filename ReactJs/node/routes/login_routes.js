const express=require("express");
const router=express.Router();
const{authenticate}=require("../controllers/login.controllers");
router.post("/",authenticate)
module.exports=router;