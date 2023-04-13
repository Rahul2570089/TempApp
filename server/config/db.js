const mongoose=require("mongoose");

const connection=mongoose.createConnection('mongodb://localhost:27017/newTempApp').on('open',()=>{
 console.log("MongoDB Connected");
}).on("Error",()=>{
  console.log("MongoDB connection error");
});

module.exports=connection;