import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ot/pages/login/login_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email = '';
  String password = '';
  bool isPasswordVisible = true;
  final bloc = LoginBloc();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      body: BlocBuilder<LoginBloc, LoginState>(
        bloc: bloc,
        builder: (context, LoginState state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Faça seu login",
                  style: theme.textTheme.titleMedium,
                  textAlign: TextAlign.center,
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
                    labelText: "Email:",
                    suffixIcon: Icon(Icons.email),
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
                      onPressed: () => setState(
                          () => isPasswordVisible = !isPasswordVisible),
                    ),
                    labelText: "Senha:",
                    border: const OutlineInputBorder(),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    padding: const EdgeInsets.all(15),
                  ),
                  onPressed: () {
                    bloc.add(TryToLoginEvent(email, password));
                  },
                  child: state is LoginLoadingState
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Text(
                          "Login",
                          style: theme.textTheme.bodyLarge,
                        ),
                ),
                const SizedBox(
                  height: 20,
                ),
                OutlinedButton(
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
                    style: theme.textTheme.bodyLarge
                        ?.copyWith(color: Colors.black),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
