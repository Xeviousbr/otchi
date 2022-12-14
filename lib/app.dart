import 'package:flutter/material.dart';
import 'package:ot/services/auth_service.dart';

import 'components/theme.dart';
import 'models/tarefa.dart';
import 'pages/cadastrar_tarefa.dart';

import 'pages/login/login_page.dart';
import 'pages/register_page/register_page.dart';
import 'pages/home/home_page.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OT - Organizador de Tarefas',
      theme: theme(),
      routes: {
        '/home_page': (_) => const HomePage(),
        '/cadastrar_tarefa': (_) => const CadastrarTarefa(),
        '/editar_tarefa': (context) {
          final tarefa = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?)?['tarefa'] as Tarefa?;
          return CadastrarTarefa(tarefa: tarefa);
        },
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
