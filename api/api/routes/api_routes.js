const express = require('express');
const router = express.Router();
const DBClient = require('../utils/DBClient');
var bodyParser = require('body-parser')
var jsonParser = bodyParser.json()
const Utilities = require("../utils/Utilities");
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
router.get('/userAdmin/:login', async (req, res, next) => {
    let user = [];
    let login = req.params.login;
    try {
        let query = `SELECT * FROM userAdmin WHERE login='${login}'`;
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
        if (req.query.public) {
            query += ` WHERE public='1'`
            if (req.query.owner) {
                query += ` and owner <> '${req.query.owner}'`
            }
        }
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            event.push({
                "id": item.id,
                "owner": item.owner,
                "name": item.name,
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
                "name": item.name,
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
                "name": item.name,
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
        if (req.query.event && req.query.user) {
            let event = req.query.event;
            let user = req.query.user
            query += ` WHERE event='${event}' and user='${user}'`
        }
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

router.post("/inscription", jsonParser, async (req, res) => {
    let login = req.body.login
    let name = req.body.displayName
    let pwd = req.body.pwd
    let sql = `INSERT INTO user (login,password,displayName) VALUES ('${login}','${pwd}', '${name}')`;
    try {
        await DBClient.query(sql);
        let query = `SELECT * FROM user WHERE login='${login}'`;
        let user = [];
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            user.push({
                "login": item.login,
                "password": item.password,
                "Name": item.displayName
            })
        })
        return res.json(user);
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
})
router.post("/inscriptionAdmin", jsonParser, async (req, res) => {
    let login = req.body.login
    let name = req.body.displayName
    let pwd = req.body.pwd
    let sql = `INSERT INTO userAdmin (login,password,displayName) VALUES ('${login}','${pwd}', '${name}')`;
    try {
        await DBClient.query(sql);
        let query = `SELECT * FROM userAdmin WHERE login='${login}'`;
        let user = [];
        let found = await DBClient.all(query);
        found.forEach(function (item) {
            user.push({
                "login": item.login,
                "password": item.password,
                "Name": item.displayName
            })
        })
        return res.json(user);
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
})
router.post("/updateUser", jsonParser, async (req, res) => {
    let login = req.body.login
    let AncienLogin = req.body.loginAnc
    let name = req.body.displayName
    let pwd = req.body.pwd
    let sql = `UPDATE user SET login= '${login}',password='${pwd}', displayName='${name}' WHERE login = '${AncienLogin}'`;
    try {
        await DBClient.query(sql);
        let user = [];
        user.push({
            "AncienLogin": AncienLogin,
            "login": login,
            "password": pwd,
            "Name": name
        })
        res.json(user);
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
})

router.post("/addEvent", jsonParser, async (req, res) => {
    let owner = req.body.owner
    let name = req.body.name
    let adress = req.body.adress
    let postCode = req.body.postCode
    let public = req.body.public
    let date = req.body.date;
    let token = Utilities.token()
    let sql = `INSERT INTO event (owner,name,adress,postCode,public,date,token) VALUES ('${owner}','${name}', '${adress}','${postCode}', '${public}', '${date}','${token}')`;
    try {
        await DBClient.query(sql);
        let event = []
        event.push({
            "owner": owner,
            "name": name,
            "adress": adress,
            "postCode": postCode,
            "public": public,
            "date": date,
            "token": token,
        })
        return res.json(event);
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
})
router.post("/addInvitation", jsonParser, async (req, res) => {
    let event = req.body.event
    let user = req.body.user
    let status = 0;
    let sqlTest = `SELECT COUNT(login) AS loginCount FROM user where login ="${user}" `;
    try {
        let verif = await DBClient.query(sqlTest);
        let invitation = []
        if (verif[0].loginCount == 1) {
            let sql = `INSERT INTO invitation (event,user,status) VALUES ('${event}','${user}', '${status}')`;
            try {
                await DBClient.query(sql);
                invitation.push({
                    "event": event,
                    "user": user,
                    "status": status,
                })
            } catch (error) {
                console.error(error);
                throw new Error(error);
            }
        }else{
            invitation.push({
                "Status": "Echec",
                "Message": `${user} inconnu`,
            })
        }
        return res.json(invitation);
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
})
router.post("/addComment", jsonParser, async (req, res) => {
    let content = req.body.content
    let owner = req.body.owner
    let date=new Date()
    let mydate = `${date.getFullYear()}-${(date.getMonth()+1)}-${date.getDate()} ${(date.getHours()+2)}:${date.getMinutes()}:00`;
    let event = req.body.event
    let sql = `INSERT INTO comment (content,owner,date,event) VALUES ('${content}','${owner}', '${mydate}','${event}')`;
    try {
        await DBClient.query(sql);
        let comment = []
        comment.push({
            "content": content,
            "owner": owner,
            "date": mydate,
            "event": event,
        })
        return res.json(comment);
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
})

router.post("/UpdateStatus", jsonParser, async (req, res) => {
    let event = req.body.event
    let user = req.body.user
    let status = req.body.status
    let sql = `UPDATE invitation SET status= '${status}' WHERE event = '${event}' and user ='${user}'`;
    try {
        await DBClient.query(sql);
        let invitation = []
        invitation.push({
            "event": event,
            "user": user,
            "status": status
        })
        return res.json(invitation);
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
})
router.post("/delete/user/:login", jsonParser, async (req, res) => {
    let login = req.params.login;
    let result = [];
    try {
        let query = `DELETE FROM user WHERE login='${login}'`;
        await DBClient.all(query);
        result.push({
            "Status": "Succes",
            "Message": `Suppression de ${login}`,
        })
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(result);
});
router.post("/delete/event/:id", jsonParser, async (req, res) => {
    let id = req.params.id;
    let result = [];
    try {
        let query = `DELETE FROM event WHERE id='${id}'`;
        await DBClient.all(query);
        result.push({
            "Status": "Succes",
            "Message": `Suppression de l'event ${id}`,
        })
    } catch (error) {
        console.error(error);
        throw new Error(error);
    }
    res.json(result);
});

router.post("/delete/invitation/:event", jsonParser, async (req, res) => {
    let result = [];
    if (req.query.user) {
        let user = req.query.user;
        let event = req.params.event;
        let verif;
        try {
            let test = `SELECT * FROM invitation WHERE event='${event}' and user='${user}'`;
            let found = await DBClient.all(test);
            verif = found;
        }
        catch (error) {
            console.error(error);
            throw new Error(error);
        }
        if (verif.length == 1) {
            try {
                let query = `DELETE FROM invitation WHERE event='${event}' and user='${user}'`;
                await DBClient.all(query);
                result.push({
                    "Status": "Succes",
                    "Message": `Suppression de l'invitation de ${user} a l'événement ${event}  `,
                })
            } catch (error) {
                console.error(error);
            }
        }
        else {
            result.push({
                "Status": "Echec",
                "Message": `Utilisateur inconnue`,
            })
        }
    }
    else {
        result.push({
            "Status": "Echec",
            "Message": `Besoin d'un user en query`,
        })
    }
    res.json(result);
});


module.exports = router;