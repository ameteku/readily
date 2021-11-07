const config = require('./db-config.js')
var mongoClient = require("mongodb").MongoClient;
export default db = mongoClient.connect(config.endpoint, function (err, client) {
    return (await client.db('readily').listCollections());
});





