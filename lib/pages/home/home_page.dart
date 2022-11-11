import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/tar_lista.dart';
import '../../services/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> with TickerProviderStateMixin {
  List<TarLista> tarefas = [];
  bool _isPlay = false;
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    super.initState();
    API.listaTarefas().then((items) {
      setState(() {
        tarefas = items.toList();
      });
    });
  }

  //dispose para o botão de play
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            const Spacer(),
            ElevatedButton(
              onPressed: () async {
                bool logOut = await logout();
                if (logOut) {
                  if (!mounted) return;
                  Navigator.of(context).pushNamed('/login');
                }
              },
              child: const Text('Deslogar'),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('OT - Organizador de Tarefas'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/cadastrar_tarefa');
        },
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView(
              children: tarefas.map(
                (tarefa) {
                  return Card(
                    child: ListTile(
                      leading: GestureDetector(
                        onTap: () {
                          if (_isPlay == false) {
                            _controller.forward();
                            _isPlay = true;
                          } else {
                            _controller.reverse();
                            _isPlay = false;
                          }
                        },
                        child: AnimatedIcon(
                          icon: AnimatedIcons.play_pause,
                          progress: _controller,
                          color: Colors.blue,
                        ),
                      ),
                      title: Text(tarefa.nome),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                debugPrint("editar tarefa ");
                              },
                              icon: const Icon(Icons.edit)),
                          IconButton(
                              onPressed: () {}, icon: const Icon(Icons.delete)),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> logout() async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    await prefer.clear();
    return true;
  }
}
