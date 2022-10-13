// import 'dart:ui';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ot/cadastrar_tarefa.dart';

import '../api.dart';
import '../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  int id = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 241, 241),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Faça seu login",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 35,
            ),
            TextField(
              onChanged: (text) {
                email = text;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: "Email:",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (text) {
                password = text;
              },
              obscureText: true,
              decoration: InputDecoration(
                labelText: "Senha:",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  /* backgroundColor: Color(0xFF33b1d0),
                  textStyle: TextStyle(
                    fontSize: 20,
                  ),*/
                  padding: EdgeInsets.all(15)),
              onPressed: () {
                API.VeLogin(email, password).then((response) {
                  setState(() {
                    var ret = json.decode(response.body);
                    if (ret['OK'] == 1) {
                      if (ret['count'] == 0) {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CadastrarTarefa()));
                      } else {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => MyHomePage(
                                  title: 'OT - Organizador de Tarefas',
                                )));
                      }
                    } else {
                      // AVISAR QUE O LOGIN ESTA ERRADO
                      print('AVISAR QUE O LOGIN ESTA ERRADO');
                    }
                  });
                });
              },
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
