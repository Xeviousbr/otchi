import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:ot/models/tarefa.dart';
import 'package:ot/services/api.dart';
import 'package:collection/collection.dart';

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
    final dias = [
      widget.tarefa.diaSemana ? 'Dias de semana' : null,
      widget.tarefa.sabado ? 'Sabados' : null,
      widget.tarefa.domingo ? 'Domingos' : null,
    ].whereType<String>();

    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/editar_tarefa', arguments: {'tarefa': widget.tarefa});
      },
      child: Container(
        padding: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
        width: 165,
        color: Colors.amber[100],
        margin: const EdgeInsets.only(top: 8, left: 8, right: 8, bottom: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    widget.tarefa.nome,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                GestureDetector(
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
                    size: 20,
                    color: const Color(0xff5F8D4E),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              dias.mapIndexed(
                ((index, element) {
                  if (index == 0) {
                    return element;
                  }
                  if (dias.length <= 1) {
                    return element;
                  }
                  if (index == dias.length - 1) {
                    return ' e $element';
                  }
                  return ', $element';
                }),
              ).join(),
              textAlign: TextAlign.end,
              style: TextStyle(fontSize: 13, color: Colors.grey[600]),
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
