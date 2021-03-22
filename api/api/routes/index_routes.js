const express = require('express');
const router = express.Router();
const DBClient = require('../utils/DBClient');

router.get('/', (req, res) => {
    res.send('Atelier 2 Reunionou')
});

module.exports = router;