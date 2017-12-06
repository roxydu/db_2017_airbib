'use strict'
// loading mysql module
const mysql = require('mysql');

// loading http module for tcp data transmission
const http = require('http');

// initialize mysql database object
var connection = mysql.createConnection({
  host: 'db-sys-airbnb.c7jx0v6pormd.us-east-1.rds.amazonaws.com',
  user: 'airbnbisbad',
  password: 'weareawesome',
  port: '3306',
  database : 'airbnb'
});

/* try connecting to the database, it is highly optional since it doesn't really
 * matter in runtime. An error will get thrown each time if the connection fails
 * anywhere in the code. However, I will check it at the beginning anyways.
 */
connection.connect(function(err) {
    if (err) {
        console.error('error connecting: ' + err.stack);
        return;
    }
    console.log("connected");
});

// after making sure the database is working, then create server from the socket
// and start listening on port 4000
http.createServer((req, res) => {
    res.writeHead(200, {'Content-Type': 'text/plain'});

    loadDataAsync(req.url.split('?')[1], (err, data) => {
        if(req.url.split('?')[2]) {
            var callback = req.url.split('?')[2];
            if(err) console.error('error pulling data: ' + err.stack);
            else {
                console.log('requested data');
                res.end(callback + '(' + JSON.stringify(data) + ')');
                console.log('data sent');
            }
        }
        else res.end('no callback function name requested.');
    });
}).listen(4000);

// this function forms the query and, of course, the query formation procedure
// could be done in a separate function.
var loadDataAsync = (key, callback) => {
    queryFormation(key, (err, data) => {
        connection.query(data, (err, result) => {
            if (err)  callback(err, null);
            else callback(null, result);
        });
    });
}

// this function forms the query from user input
var queryFormation = (key, callback) => {
    //TODO: form your query here

    // MAGIC HAPPENS HERE

    // mock query
    var result = "SELECT * FROM `Amenity`";

    // no error handling for now
    callback(null, result);
}
