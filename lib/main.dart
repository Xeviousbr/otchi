import 'package:flutter/material.dart';
import 'package:ot/cadastrar_tarefa.dart';
import 'package:ot/home_page.dart';
import 'package:ot/login_page/login_page.dart';

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
      },
      home: const LoginPage(),
    );
  }
}
