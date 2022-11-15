import 'package:flutter/material.dart';

import 'pages/cadastrar_tarefa.dart';
import 'pages/register_page/register_page.dart';
import 'pages/home/home_page.dart';
import 'pages/login_page/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OT - Organizador de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/login': (_) => const LoginPage(),
        '/cadastrar_tarefa': (_) => const CadastrarTarefa(),
        '/home': (_) => const HomePage(),
        '/cadastro_user': (_) => const RegisterPage(),
      },
      home: const LoginPage(),
    );
  }
}
