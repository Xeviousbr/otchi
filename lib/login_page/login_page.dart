import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ot/cadastrar_tarefa.dart';
import '../api.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ot/sharedPreferencePage.dart';

import '../home_page.dart';

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
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Se não tem não faz nada
      }
    });
  }

  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Faça seu login",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 35,
            ),
            TextField(
              onChanged: (text) {
                email = text;
              },
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: "Email:",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (text) {
                password = text;
              },
              obscureText: true,
              decoration: const InputDecoration(
                labelText: "Senha:",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
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
                padding: const EdgeInsets.all(15),
              ),
              onPressed: () {
                API.veLogin(email, password).then((response) {
                  setState(() {
                    var ret = json.decode(response.body);
                    int idUser = (ret["ID"]);
                    if (ret['OK'] == 1) {
                      saveId(idUser);
                      print('LOGIN REALIZADO');
                      // DÉBITO TÉCNICO
                      if (1 == 2) {
                        // DÉBITO TÉCNICO
                        print('NÃO TEM TAREFAS CADASTRADAS');
                        Navigator.of(context).pushNamed('/cadastrar_tarefa');
                      } else {
                        print('TEM TAREFAS CADASTRADAS');
                        Navigator.of(context).pushNamed('/home');
                      }
                    } else {
                      print("login errado");
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  final snackBar = SnackBar(content: Text("Usuário ou senha incorretos", 
  textAlign: TextAlign.center),
   backgroundColor: Colors.redAccent);

  static saveId(int idUser) async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    await prefer.setInt('ID', idUser);
  }

  Future<bool> verificarId() async {
    if (await SharedPrefUtils.readId() != null) {
      return true;
    } else {
      return false;
    }
  }
}
