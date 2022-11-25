const functions = require("firebase-functions");

const admin = require("firebase-admin");
admin.initializeApp();

exports.onCreateUser = functions.auth.user().onCreate((user) => {
  return admin.firestore().collection("users").doc(user.uid).set({});
});
