var XMLHttpRequest = require("xmlhttprequest").XMLHttpRequest;
//rend une chaine qui permet d'affectuer une requete "where" avec un tableau de parametre [colonne, operation, valeur].
function queryFilter(args){
    let where = "";
    args.forEach((elem) => {
        where += "this." + elem[0] + elem[1] + "'" + elem[2] + "'";
        if(elem !== args[args.length - 1]) where += " && ";
    });
    return where;
}

function rand() {
    return Math.random().toString(36).substr(2); // remove `0.`
};

function token() {
    return rand() + rand(); // to make it longer
};

/**
 * envoie une requête XHR dans une promesse
 * @param url : url ou route de l'API
 * @param success : callback
 * @return promise
 */
async function sendXhrPromise(url) {
    return new Promise( function (resolve, reject){
        let xhr = new XMLHttpRequest();
        xhr.onreadystatechange = function(response) {
            if (this.readyState === 4) {
                resolve(this.responseText);
            }
        };
        xhr.open('GET', url);
        xhr.send();
    });
}

module.exports = {queryFilter, token, sendXhrPromise};