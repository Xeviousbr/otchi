var admin = require("firebase-admin");
var functions = require("firebase-functions");

// Pass the Firebase config directly to initializeApp() to auto-configure
// the Admin Node.js SDK.
// admin.initializeApp(functions.config().firebase);

exports.onCreateUser = functions.auth.user().onCreate((user) => {
    // admin.firestore().collection('users').doc(user.data.uid).set({});
});