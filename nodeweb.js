var path = require('path')
var express = require("express");
var app = express();


//Static web path
var webPath = path.join(__dirname,'../web');
console.log("Web path: " + webPath);
app.use(express.static(webPath));


//If not found, must be last line
app.use(function(req, res) {
  res.status(404).send({url: req.originalUrl + ' not found'});
});


//Setup port
port = process.env.PORT || 3001;
app.listen(port, () => {
 console.log("Server running on port " + port);
});