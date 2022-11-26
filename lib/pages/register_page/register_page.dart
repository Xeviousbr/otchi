import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ot/pages/register_page/resgister_bloc.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isPasswordVisible = true;
  String email = '';
  String password = '';
  final bloc = ResgisterBloc();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 241, 241),
      body: BlocListener(
        bloc: bloc,
        listener: (_, state) {
          if (state is RegisterSucceedState) {
            Navigator.of(context).pop();
          }
        },
        child: BlocBuilder<ResgisterBloc, RegisterState>(
          bloc: bloc,
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(
                        "Faça seu cadastro",
                        style: theme.textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  TextField(
                    onChanged: (text) {
                      setState(() {
                        email = text;
                      });
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
                        setState(() {
                          password = text;
                        });
                      },
                      style: theme.textTheme.bodyMedium,
                      obscureText: isPasswordVisible,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: isPasswordVisible ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
                          onPressed: () => setState(() => isPasswordVisible = !isPasswordVisible),
                        ),
                        labelText: "Senha:",
                        border: const OutlineInputBorder(),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(15),
                    ),
                    onPressed: () {
                      bloc.add(TryToRegisterEvent(email, password));
                    },
                    child: state is RegisterLoadingState
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            "Cadastrar",
                            style: theme.textTheme.bodyLarge,
                          ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      padding: const EdgeInsets.all(15),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      "Cancelar",
                      style: theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
