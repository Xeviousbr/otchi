var admin = require("firebase-admin");
var functions = require("firebase-functions");

admin.initializeApp(functions.config().firebase);

exports.onCreateUser = functions.auth.user().onCreate((user) => {
    admin.firestore().collection('users').doc(user.data.uid).set({});
});