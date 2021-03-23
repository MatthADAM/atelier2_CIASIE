const express = require('express');
const router = express.Router();
const DBClient = require('../utils/DBClient');
var bodyParser = require('body-parser')
var jsonParser = bodyParser.json()
router.get('/user', async (req, res, next) => {
    let user = [];
    try {
        let query = `SELECT * FROM user`;
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            user.push({
                "login": item.login,
                "password": item.password,
                "Name": item.displayName
            })
        });
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(user);
});
router.get('/user/:login', async (req, res, next) => {
    let user = [];
    let login = req.params.login;
    try {
        let query = `SELECT * FROM user WHERE login='${login}'`;
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            user.push({
                "login": item.login,
                "password": item.password,
                "Name": item.displayName
            })
        });
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(user);
});
router.get('/event', async (req, res, next) => {
    let event = [];
    try {
        let query = `SELECT * FROM event`;
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            event.push({
                "id": item.id,
                "owner": item.owner,
                "adress": item.adress,
                "postCode": item.postCode,
                "public": item.public,
                "date": item.date,
                "token": item.token,
            })
        });
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(event);
});
router.get('/event/:id', async (req, res, next) => {
    let event = [];
    let id = req.params.id;
    try {
        let query = `SELECT * FROM event WHERE id='${id}'`;
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            event.push({
                "id": item.id,
                "owner": item.owner,
                "adress": item.adress,
                "postCode": item.postCode,
                "public": item.public,
                "date": item.date,
                "token": item.token,
            })
        });
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(event);
});

router.get('/event/owner/:owner', async (req, res, next) => {
    let event = [];
    let owner = req.params.owner;
    try {
        let query = `SELECT * FROM event WHERE owner='${owner}'`;
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            event.push({
                "id": item.id,
                "owner": item.owner,
                "adress": item.adress,
                "postCode": item.postCode,
                "public": item.public,
                "date": item.date,
                "token": item.token,
            })
        });
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(event);
});
router.get('/invitation', async (req, res, next) => {
    let invitation = [];
    try {
        let query = `SELECT * FROM invitation`;
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            invitation.push({
                "event": item.event,
                "user": item.user,
                "status": item.status
            })
        });
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(invitation);
});

router.get('/invitation/:event', async (req, res, next) => {
    let invitation = [];
    let event = req.params.event;
    try {
        let query = `SELECT * FROM invitation  WHERE event='${event}'`;
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            invitation.push({
                "event": item.event,
                "user": item.user,
                "status": item.status
            })
        });
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(invitation);
});
router.get('/invitation/user/:user', async (req, res, next) => {
    let invitation = [];
    let user = req.params.user;
    try {
        let query = `SELECT * FROM invitation  WHERE user='${user}'`;
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            invitation.push({
                "event": item.event,
                "user": item.user,
                "status": item.status
            })
        });
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(invitation);
});
router.get('/media', async (req, res, next) => {
    let media = [];
    try {
        let query = `SELECT * FROM media`;
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            media.push({
                "id": item.id,
                "owner": item.owner,
                "url": item.url,
                "type": item.type,
            })
        });
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(media);
});

router.get('/media/:id', async (req, res, next) => {
    let media = [];
    let id = req.params.id;
    try {
        let query = `SELECT * FROM media WHERE id='${id}'`;
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            media.push({
                "id": item.id,
                "owner": item.owner,
                "url": item.url,
                "type": item.type,
            })
        });
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(media);
});

router.get('/media/owner/:owner', async (req, res, next) => {
    let media = [];
    let owner = req.params.owner;
    try {
        let query = `SELECT * FROM media WHERE owner='${owner}'`;
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            media.push({
                "id": item.id,
                "owner": item.owner,
                "url": item.url,
                "type": item.type,
            })
        });
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(media);
});
router.get('/comment', async (req, res, next) => {
    let comment = [];
    try {
        let query = `SELECT * FROM comment`;
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            comment.push({
                "id": item.id,
                "content": item.content,
                "owner": item.owner,
                "date": item.date,
                "event": item.event,
            })
        });
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(comment);
});

router.get('/comment/:id', async (req, res, next) => {
    let comment = [];
    let id = req.params.id;
    try {
        let query = `SELECT * FROM comment WHERE id='${id}'`;
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            comment.push({
                "id": item.id,
                "content": item.content,
                "owner": item.owner,
                "date": item.date,
                "event": item.event,
            })
        });
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(comment);
});
router.get('/comment/owner/:owner', async (req, res, next) => {
    let comment = [];
    let owner = req.params.owner;
    try {
        let query = `SELECT * FROM comment WHERE owner='${owner}'`;
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            comment.push({
                "id": item.id,
                "content": item.content,
                "owner": item.owner,
                "date": item.date,
                "event": item.event,
            })
        });
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(comment);
});
router.get('/comment/event/:event', async (req, res, next) => {
    let comment = [];
    let event = req.params.event;
    try {
        let query = `SELECT * FROM comment WHERE event='${event}'`;
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            comment.push({
                "id": item.id,
                "content": item.content,
                "owner": item.owner,
                "date": item.date,
                "event": item.event,
            })
        });
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(comment);
});

router.post("/inscription", jsonParser, async(req, res)=> {
    let login = req.body.login
    let name = req.body.displayName
    let pwd = req.body.pwd
    let sql = `INSERT INTO user (login,password,displayName) VALUES ('${login}','${pwd}', '${name}')`;
    try {
        await DBClient.query(sql);
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
})


module.exports = router;