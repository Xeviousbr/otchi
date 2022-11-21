import 'package:flutter/material.dart';
import 'package:ot/services/auth_service.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    String user = '';
    String pass = '';

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Faça seu cadastro",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 35,
            ),
            TextField(
              onChanged: (text) {
                user = text;
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
                pass = text;
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
                padding: const EdgeInsets.all(15),
              ),
              onPressed: () {
                // todo: validar email
                AuthService.cadastraUser(user, pass).then((cadastrou) {
                  if (cadastrou) {
                    Navigator.of(context).pushNamed('/login');
                  } else {
                    debugPrint("cadastro invalido");
                  }
                });
              },
              child: const Text(
                "Cadastrar",
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            )
          ],
        ),
      ),
    );
  }
}
