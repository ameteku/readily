const fs = require('fs');
const key = fs.readFileSync('./key.pem');
const cert = fs.readFileSync('./cert.pem');

const bodyParser = require('body-parser');

const config = require('../db/db-config');
const user = require("../db/user-model").User
const clientDB = require("../db/db").db;

var db;

const express = require('express');
var http = require('http');
const https = require('https');
const app = express();

var cors = require('cors');
const e = require('express');
app.use(cors());

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get('/', (req, res) => {
    res.send('Hello World!')
})


app.post('/signup', async (req, res) => {

    if (req.body == null) {
        res.json({})
    } else {
        var username = req.body.username
        console.log(username)
        var password = req.body.password;
        console.log(password)
        var firstName = req.body.firstName
        var lastName = req.body.lastName
        var classIds = req.body.classIds

        var proceed = await doesUserExistAndAddNewUserInDatabase(firstName, lastName, classIds, username, password)
        console.log(proceed)

        if (proceed == false) {
            res.json({})
        } else {
            res.json(proceed)
        }
    }

})


async function doesUserExistAndAddNewUserInDatabase(firstName, lastName, classIds, username, password) {
    //find username in database
    var cursorFile = await db.collection('users').find({
        "email": username
    });
    const list1 = await cursorFile.toArray()

    if (list1.length >= 1) {
        return false    //user already exists
    } else {
        db.collection("users").insertOne({
            "pk": "semting",
            "firstName": firstName,
            "lastName": lastName,
            "classIds": classIds,
            "email": username,
            "password": password,

        });
        return { "message": true }
    }
}

app.post('/signin', async (req, res) => {
    console.log("Body is");
    console.table(req.body);

    // get the username and password

    if (req.body == null) {
        res.json({})
    } else {
        var username = req.body.username
        console.log(username)
        var password = req.body.password;
        console.log(password)

        var proceed = await doesUserExistAndPassCorrectInDatabase(username, password)
        console.log(proceed)

        if (proceed == false) {
            res.json({})
        } else {
            res.json(proceed)
        }
    }
})

async function doesUserExistAndPassCorrectInDatabase(username, password) {
    //find username in database
    var cursorFile = await db.collection('users').find({
        "email": username
    });
    const list1 = await cursorFile.toArray()

    if (list1.length >= 1) {
        if (list1[0]['password'] == password) {
            return list1[0];
        }
        return false;
    } else {
        return false;
    }
}


async function createClass(classId, title, permissions, topics) {
    //find username in database
    var cursorFile = await db.collection('classes').find({
        "classId": classId
    });
    const list1 = await cursorFile.toArray()

    if (list1.length >= 1) {
        return false    //class already exists
    } else {
        await db.collection("classes").insertOne({
            "pk": "classes",
            "id": classId,
            "title": title,
            "permissions": permissions,
            "topics": topics
        });
        return true;
    }
};

async function getClass(classId) {
    var cursorFile = await db.collection('classes').find({
        "classId": classId
    });
    const list1 = await cursorFile.toArray();

    return list1[0]
};


async function getMultipleClasses(classIds) {
    var classDocs = await db.collection("classes").find({ "id": { $in: classIds } });
    const classDocList = await classDocs.toArray();

    return classDocList;
}

app.post("/create-class", async (req, res) => {
    if (req.body == null) {
        res.json({});
    }

    const classId = 1;
    const title = req.body.title;
    const permission = req.body.permissions;
    const topics = req.body.topics;

    var result = await createClass(classId, title, permission, topics);

    res.json({ "result": result });
});

app.post("/get-classes", async (req, res) => {
    if (req.body == null) {
        res.json({});
    }

    const classIds = JSON.parse(req.body.classIds);
    if (classIds != null)

       {
           console.log(typeof(classIds));
        var result = await getMultipleClasses(classIds);
        res.json(result);
       }
       else {
           res.json({});
       }

    


})

// updateClassPermission() {};
async function updateClassPermission(classId, permissions) {
    await db.collection('classes').updateOne({
        "classId" : classId
    },
    {
        $set: {"permissions": permissions}

});
};


// createTopic() {};




// createUser() {};

// signInUser () {};

// updateUser() {};

// getNotes() {};

// linkVideo() {};


// deleteNote() {};

// addNotes() {};

// toggleNotePrivacy() {};


app.listen(3000, async () => {
    db = (await clientDB.connect(config.endpoint).catch((e) => {
        console.log(`Error connecting to db:${e}`)
        throw `cannot connect to db ${e}`
    })).db("readily")

    if (db != null)
        console.log("sometin! db success")

    // var cursorFile = await db.collection('users').find({
    //     "email" : "mike@gmail.com"
    // });
    // const list1 = await cursorFile.toArray()
    // console.log(list1)
    // await db.collection('users').updateOne({
    //         "email" : "mike@gmail.com"
    //     },
    //     {
    //         $set: {"password":"nope"}

    // });
    // const list1 = await cursorFile.toArray()
    // console.log(list1)


});
