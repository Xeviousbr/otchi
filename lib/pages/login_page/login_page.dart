import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Faça seu login",
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(
              height: 35,
            ),
            TextField(
              onChanged: (text) {
                email = text;
              },
              style: theme.textTheme.bodyMedium,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.email),
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
              style: theme.textTheme.bodyMedium,
              obscureText: isPasswordVisible,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: isPasswordVisible
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () =>
                      setState(() => isPasswordVisible = !isPasswordVisible),
                ),
                labelText: "Senha:",
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(15),
                ),
                onPressed: () {},
                child: Text(
                  "Login",
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
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
                  Navigator.of(context).pushNamed('/cadastro_user');
                },
                child: Text(
                  "Cadastre-se",
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  final snackBar = const SnackBar(
      content: Text("Usuário ou senha incorretos", textAlign: TextAlign.center),
      backgroundColor: Colors.redAccent);
}
