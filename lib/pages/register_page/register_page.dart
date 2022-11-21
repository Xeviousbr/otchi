import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String user = '';
  String pass = '';
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
              "Faça seu cadastro",
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(
              height: 35,
            ),
            TextField(
              onChanged: (text) {
                user = text;
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
                pass = text;
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
<<<<<<< HEAD
                onPressed: () {},
=======
                onPressed: () {
                  AuthService.cadastraUser(user, pass).then((cadastrou) {
                    if (cadastrou) {
                      Navigator.of(context).pushNamed('/login');
                    } else {
                      debugPrint("cadastro invalido");
                    }
                  });
                },
>>>>>>> 268848af6ef905be092aa986e1f4224046e49703
                child: Text(
                  "Cadastrar",
                  style: theme.textTheme.bodyLarge,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
