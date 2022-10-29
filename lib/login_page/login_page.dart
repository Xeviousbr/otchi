import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ot/cadastrar_tarefa.dart';

import '../api.dart';
import '../main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
    verificarId().then((value) {
      if (value) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MyHomePage(
                  title: 'OT - Organizador de Tarefas',
                )));
      } else {
        // Se não tem não faz nada
      }
    });
  }

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
                    int idUser = (ret["ID"]);
                    if (ret['OK'] == 1) {
                      saveId(idUser);
                      print('LOGIN REALIZADO');

                      // DÉBITO TÉCNICO
                      if (1 == 2) {
                        //

                        print('NÃO TEM TAREFAS CADASTRADAS');
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => CadastrarTarefa()));
                      } else {
                        print('TEM TAREFAS CADASTRADAS');
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

  void saveId(int idUser) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    await prefer.setInt('ID', idUser);
  }

  Future<bool> verificarId() async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    if (prefer.getInt('ID') != null) {
      return true;
    } else {
      return false;
    }
  }
}
