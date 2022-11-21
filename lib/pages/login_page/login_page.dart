import 'package:flutter/material.dart';
import 'package:ot/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                /* backgroundColor: Color(0xFF33b1d0),
                  textStyle: TextStyle(
                    fontSize: 20,
                  ),*/
                padding: const EdgeInsets.all(15),
              ),
              onPressed: () {
                AuthService.login(email, password).then((logou) {
                  setState(() {
                    if (logou) {
                      Navigator.of(context).pushNamed('/home');
                    } else {
                      debugPrint("login invalido");
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                });
              },
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                /* backgroundColor: Color(0xFF33b1d0),
                  textStyle: TextStyle(
                    fontSize: 20,
                  ),*/
                padding: const EdgeInsets.all(15),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed('/cadastro_user');
              },
              child: const Text(
                "Cadastre-se",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }

  final snackBar = const SnackBar(
      content: Text("Usuário ou senha incorretos", textAlign: TextAlign.center), backgroundColor: Colors.redAccent);
}
