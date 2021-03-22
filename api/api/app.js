const express = require('express');
const app = express();

const local_port = process.env.LOCAL_PORT;
const dist_port = process.env.DIST_PORT;

const bodyParser = require('body-parser');
const jsonParser = bodyParser.json();

const index_routes = require("./routes/index_routes");

const DBClient = require('./utils/DBClient');

app.use("/", index_routes);
app.use(async(req,res,next)=>{
  return res.status(400).json({
    "type": "error",
    "error": 400,
    "message": `BAD REQUEST`
  });
});

app.use(async(req,res,next)=>{
  return res.status(405).json({
    "type": "error",
    "error": 405,
    "message": `METHOD NOT ALLOWED`
  });
});

app.use(async(err, req,res,next)=>{
  return res.status(500).json({
    "type": "error",
    "error": 500,
    "message": `Il s'est passé ça : ${err.message}`
  });
})

app.listen(local_port, () => {
  console.log(`LBS Command API listening at http://localhost:${local_port} (Dist port : ${dist_port})`)
});