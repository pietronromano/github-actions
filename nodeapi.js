var path = require('path')
var express = require("express");
var app = express();
var cors = require('cors');

//NOTE: this line is needed in order to received the request body
//requests need this header: xhttp.setRequestHeader('Content-Type', 'application/json; charset=utf-8');
app.use(express.json())

//SEE //https://stackoverflow.com/questions/57640113/cors-it-does-not-have-http-ok-status
//removed several kinds of CORS errors
app.use(cors());


//Specific controllers
var inmemoryCustomers = require('./controllers/inmemory/inmemoryCustomerController');
var cosmosCustomers = require('./controllers/cosmos/cosmosCustomerController');

//Get dbOption: the first command line argument: node nodeapi dbOption
const dbOption = process.argv[2];
console.log("dbOption: " + dbOption);

//Setup controllers according to db option
const customers = inmemoryCustomers; //default,  have to initialize const anyway
if (dbOption == "cosmos") {
  customers = cosmosCustomers;
}


//  Routes
app.get('/customers',(req, res, next) => {
    customers.retrieve(req,res);
  });

//id available in params object: req.params.id
app.get('/customers/:id',(req, res, next) => {
    customers.get(req,res);
  });

//Insert
 app.post('/customers',(req, res, next) => {
    customers.insert(req,res);
  });

//Update
 app.put('/customers',(req, res, next) => {
    customers.update(req,res);
  });

//Delete
 app.delete('/customers',(req, res, next) => {
    customers.delete(req,res);
  });


//If not found, must be last line
app.use(function(req, res) {
  res.status(404).send({url: req.originalUrl + ' not found'});
});


//Setup port
port = process.env.PORT || 3000;
app.listen(port, () => {
 console.log("Server running on port " + port);
});