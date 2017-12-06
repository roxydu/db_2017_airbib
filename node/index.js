'use strict'
// loading mysql module
const mysql = require('mysql');

// loading http module for tcp data transmission
const https = require('https');
const fs = require('fs');

const options = {
  key: fs.readFileSync('certificate/thomas-key.pem'),
  cert: fs.readFileSync('certificate/thomas-cert.pem')
};

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
https.createServer(options, (req, res) => {
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
    var key_arr = key.split('&');
    console.log(key_arr);
    var selector = key_arr[0];
    var variable_one = key_arr[1] ? key_arr[1] : null;
    var variable_two = key_arr[2] ? key_arr[2] : null;
    var result = '';
    //TODO: form your query here
    if(selector === 'A') {
        if(variable_one === 'wifi' ||
                variable_one === 'parking' ||
                variable_one === 'kitchen' ||
                variable_one === 'pet_friendly' ||
                variable_one === 'washer' ||
                variable_one === 'dryer') {
            result = 'Select stars From Reviews R, givenTo GT \
                    where R.reviewID=GT.reviewID and GT.HouseID in \
                    (Select h.HouseID From House h, Amenities a \
                        Where h.houseId=a.houseID and a.' + variable_one + '=' + variable_two + ')';
        } else {
            result = 'Select stars From Reviews R, givenTo GT \
                    where R.reviewID=GT.reviewID and GT.HouseID in \
                    (Select h.HouseID From House h, Amenities a \
                        Where h.houseId=a.houseID and a.wifi=False)';
        }
    } else if(selector === 'B') {
        if(variable_one === 'wifi' ||
                variable_one === 'parking' ||
                variable_one === 'kitchen' ||
                variable_one === 'pet_friendly' ||
                variable_one === 'washer' ||
                variable_one === 'dryer') {
            result = 'Select Reservation.checkInDate \
                From Reservation,receives,Host \
                where Host.hostID=receives.hostID \
                and Reservation.reservationID=receives.reservationID \
                and Host.hostID in \
                (Select distinct a.hostID \
                From House h, Amenities a \
                where h.hostID=a.hostId \
                and h.houseAddress like "%Iowa City%" \
                and h.houseID in \
                (Select H1.HouseID \
                From House H1, Amenities A \
                Where H1.HouseID=A.HouseID \
                and A.' + variable_one + '=False))';
        } else {
            result = 'Select Reservation.checkInDate \
                From Reservation,receives,Host \
                where Host.hostID=receives.hostID \
                and Reservation.reservationID=receives.reservationID \
                and Host.hostID in \
                (Select distinct a.hostID \
                From House h, Amenities a \
                where h.hostID=a.hostId \
                and h.houseAddress like "%Iowa City%" \
                and h.houseID in \
                (Select H1.HouseID \
                From House H1, Amenities A \
                Where H1.HouseID=A.HouseID \
                and A.wifi=False))';
        }
    } else if(selector === 'C') {
        result = 'Select Reservation.billAmount, Host.hostName \
            From Host, Reservation, receives \
            Where Host.HostID=receives.HostID \
            and Reservation.reservationID=receives.reservationID \
            and Host.HostID in \
            (Select Host.HostId \
            From Host,hostedBy \
            Where Host.HostID=hostedBy.HostID \
            and hostedBy.houseID in \
            (Select House.houseID \
            From House, hostedBy \
            Where House.houseId=hostedBy.houseId \
            and House.houseAddress like \'%Iowa City%\'\
            ))';
    } else {
        console.error('wrong selector');
    }

    // no error handling for now
    callback(null, result);
}
