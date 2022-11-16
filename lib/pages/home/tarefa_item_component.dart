import 'package:flutter/material.dart';
import 'package:ot/models/tar_lista.dart';

class TarefaItemComponent extends StatefulWidget {
  const TarefaItemComponent({Key? key, required this.tarefa}) : super(key: key);
  final TarLista tarefa;

  @override
  State<TarefaItemComponent> createState() => _TarefaItemComponentState();
}

class _TarefaItemComponentState extends State<TarefaItemComponent>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPlay = false;

  @override
  void initState() {
    _controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(widget.tarefa.nome),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  debugPrint("editar tarefa ");
                },
                icon: const Icon(Icons.edit)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.delete)),
          ],
        ),
      ),
    );
  }

  //dispose para o botão de play
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
