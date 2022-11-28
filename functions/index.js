const functions = require("firebase-functions");

const admin = require("firebase-admin");
admin.initializeApp();

exports.onCreateTarefas = functions.auth.user().onCreate((tarefas) => {
  // return admin.firestore().collection("tarefa").doc(tarefa.uid).set({});
  return admin.firestore().collection('tarefas').doc(tarefas.uid).update(updateData, {tempo: 123})
});
