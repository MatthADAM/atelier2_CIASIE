const express = require('express');
const app = express();

const local_port = process.env.LOCAL_PORT;
const dist_port = process.env.DIST_PORT;

const bodyParser = require('body-parser');
const jsonParser = bodyParser.json();

const index_routes = require("./routes/index_routes");
const api_routes = require("./routes/api_routes");
const DBClient = require('./utils/DBClient');
const cors = require('cors');

const https = require('https');
const fs = require('fs');

var key = fs.readFileSync(__dirname + '/certs/server.key');
var cert = fs.readFileSync(__dirname + '/certs/server.cert');
var options = {
  key: key,
  cert: cert
};

app.get('/', (req, res) => {
   res.send('Now using https..');
});



app.use(cors());
app.use("/", index_routes);
app.use("/api", api_routes);


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

var server = https.createServer(options, app);
server.listen(local_port, () => {
  console.log("server starting on local_port : " + local_port)
});