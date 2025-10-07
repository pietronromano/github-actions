// ADD THIS PART TO YOUR CODE
const CosmosClient = require('@azure/cosmos').CosmosClient;

const config = require('./config')

const endpoint = config.endpoint;
const key = config.key;

const client = new CosmosClient({ endpoint, key });

const HttpStatusCodes = { NOTFOUND: 404 };

const databaseId = config.database.id;
const containerId = config.container.id;
const partitionKey = { kind: "Hash", paths: ["/Country"] };


var andersen = {
    id: 'Anderson.1',
    Country: 'USA',
    lastName: 'Andersen',
    parents: [
      {
        firstName: 'Thomas'
      },
      {
        firstName: 'Mary Kay'
      }
    ],
    children: [
      {
        firstName: 'Henriette Thaulow',
        gender: 'female',
        grade: 5,
        pets: [
          {
            givenName: 'Fluffy'
          }
        ]
      }
    ],
    address: {
      state: 'WA',
      county: 'King',
      city: 'Seattle'
    }
  }

exports.insert = function(req,res) {
    createFamilyItem(andersen);
};

  /**
* Create family item
*/
async function createFamilyItem(itemBody) {
    const { item } = await client.database(databaseId).container(containerId).items.upsert(itemBody);
    console.log(`Created family item with id:\n${itemBody.id}\n`);
 };

 exports.retrieve = function(req, res) {
  console.log('cosmosController.retrieve not implemented');
};



exports.get = function(req, res) {
  console.log('cosmosController.get not implemented');

};


exports.delete = function(req, res) {
  console.log('cosmosController.delete not implemented');
};


exports.delete = function(req, res) {
  console.log('cosmosController.delete not implemented');

};