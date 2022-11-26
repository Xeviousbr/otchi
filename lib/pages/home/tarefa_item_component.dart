import 'package:flutter/material.dart';
import 'package:ot/models/tarefa.dart';
import 'package:ot/services/api.dart';

class TarefaItemComponent extends StatefulWidget {
  const TarefaItemComponent({Key? key, required this.tarefa}) : super(key: key);
  final Tarefa tarefa;

  @override
  State<TarefaItemComponent> createState() => _TarefaItemComponentState();
}

class _TarefaItemComponentState extends State<TarefaItemComponent> with TickerProviderStateMixin {
  late AnimationController _controller;
  bool _isPlay = false;

  @override
  void initState() {
    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    if (widget.tarefa.acao.emAndamento) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        _controller.forward();
        _isPlay = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: ListTile(
        leading: GestureDetector(
          onTap: () async {
            await API.acaoTarefa(widget.tarefa, !_isPlay);
            if (_isPlay) {
              _controller.reverse();
              _isPlay = false;
            } else {
              _controller.forward();
              _isPlay = true;
            }
          },
          child: AnimatedIcon(
            icon: AnimatedIcons.play_pause,
            progress: _controller,
            color: const Color(0xff5F8D4E),
          ),
        ),
        title: Text(
          widget.tarefa.nome,
          style: theme.textTheme.bodyMedium,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/cadastrar_tarefa', arguments: {'id': widget.tarefa.id});
                },
                icon: const Icon(Icons.edit)),
            IconButton(
              color: const Color(0xffAC0D0D),
              onPressed: () {
                API.deleta(widget.tarefa.id);
              },
              icon: const Icon(Icons.delete),
            ),
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
