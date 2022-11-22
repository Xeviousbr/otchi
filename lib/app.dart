import 'package:flutter/material.dart';
import 'package:ot/services/auth_service.dart';

import 'components/theme.dart';
import 'pages/cadastrar_tarefa.dart';

import 'pages/register_page/register_page.dart';
import 'pages/home/home_page.dart';
import 'pages/login_page/login_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OT - Organizador de Tarefas',
      theme: theme(),
      routes: {
        '/cadastrar_tarefa': (_) => const CadastrarTarefa(),
        '/cadastro_user': (_) => const RegisterPage(),
      },
      home: StreamBuilder<bool>(
        stream: AuthService.estaLogado(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return snapshot.data! ? const HomePage() : const LoginPage();
        },
      ),
    );
  }
}