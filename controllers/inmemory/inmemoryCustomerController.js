class Customer {
  constructor(id,name) {
    this.id = id;
    this.name = name;
    this.description = this.name + " description";
    this.contractDate = new Date().toISOString();
  }
}
var customers = [];
for (let i = 0; i < 10; i++) {
  customers.push (new Customer(i,'Customer ' + i));
}

function findById(id){
  for (let i = 0; i < customers.length; i++) {
    const customer = customers[i];
    if(id == customer.id){
      return customer;
    }
  } 
}


exports.retrieve = function(req, res) {
    res.send(customers);
};


exports.insert = function(req, res) {
  var customer = req.body;
  customers.push(customer);
  customer.inserted = new Date();
  res.send(customer);
};

//id available in params object: req.params.id
exports.get = function(req, res) {
    const customer = findById(req.params.id);
    res.send(customer);
};


exports.update = function(req, res) {
  var updatedCustomer = req.body;
  for (let i = 0; i < customers.length; i++) {
    if(customers[i].id == updatedCustomer.id){
      customers[i] = updatedCustomer; //have to swap in array
      break;
    }
  } 
  updatedCustomer.updated = new Date();
  res.send(updatedCustomer);
};


exports.delete = function(req, res) {
  var deletedCustomer = req.body;
  for (let i = 0; i < customers.length; i++) {
    if(customers[i].id == deletedCustomer.id){
      customers[i] = deletedCustomer; //have to swap in array
      deletedCustomer.deleted = new Date();
      break;
    }
  } 
  res.send(deletedCustomer);

};
