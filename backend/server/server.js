const fs = require('fs');
const key = fs.readFileSync('./key.pem');
const cert = fs.readFileSync('./cert.pem');

const bodyParser = require('body-parser');

const config = require('../db/db-config');
const clientDB = require("../db/db").db;

var db;

const express = require('express');
var http = require('http');
const https = require('https');
const app = express();

var cors = require('cors');
app.use(cors());

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true}));

app.get('/', (req, res) => {
  res.send('Hello World!')
})

app.post('/signup', async (req, res) => {

    if (req.body) {
        console.log("Body is");
        console.table(req.body);

        var body = JSON.parse(req.body)
        var username = body.username
        var password = body.password;
        
        db.collection("users").insertOne({"pk" : "semting", "username" : username, "password" : password});
    }
    
    db.collection("users").insertOne({"pk" : "semting", "Sometinh" : "somethingelse"});

    res.send("Inserted data data")
})

app.post('/signin', async (req, res) => {
    console.log("Body is");
    console.table(req.body);
    console.log(await  db.collection("/users").find({"id":"AndersenFamily"}))

    // get the username and password
    //var body = JSON.parse(req.body)
    //var username = body.username
   // var password = body.password;

    //have

    res.send("Gotten data")
})

function checkIfUserExistsInDatabase(username){
    //find username in database

    //if username is found, return true

    //else return false
}

function checkPassword(username, password) {
    //check if password for username is correct

    //return true if username found

    //return false if not
}

app.get('/signup', (req, res) => {
    res.send('Sign up page')
})

app.get('/homepage', (req, res) => {
    res.send('Sign up page')
})

// createClass() {};

// updateClassPermission() {};

// createTopic() {};

// getClass() {};


// createUser() {};

// signInUser () {};

// updateUser() {};

// getNotes() {};

// linkVideo() {};


// deleteNote() {};

// addNotes() {};

// toggleNotePrivacy() {};


app.listen(3000, async ()=> {
    db = (await clientDB.connect(config.endpoint).catch((e)=> {
        console.log(`Error connecting to db:${e}`)
        throw `cannot connect to db ${e}`
    })).db("readily")
    
    if(db != null)
    console.log("sometin! db success")

    var test = (db.collection("users"))
    console.log(test);
    

});
