import 'package:flutter/material.dart';
import 'package:ot/models/tarefa.dart';
import 'package:ot/services/api.dart';
import 'package:collection/collection.dart';

class TarefaItemComponent extends StatefulWidget {
  const TarefaItemComponent({Key? key, required this.tarefa, this.onCancel}) : super(key: key);
  final Tarefa tarefa;
  final void Function()? onCancel;

  @override
  State<TarefaItemComponent> createState() => _TarefaItemComponentState();
}

class _TarefaItemComponentState extends State<TarefaItemComponent> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Tarefa _tarefaAtual;
  bool _isPlay = false;
  bool _isEditing = false;

  @override
  void initState() {
    setState(() {
      _tarefaAtual = widget.tarefa;
      _isEditing = widget.tarefa.rascunho;
    });
    _controller = AnimationController(duration: const Duration(seconds: 1), vsync: this);
    if (widget.tarefa.acao.emAndamento) {
      WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
        _controller.forward();
        _isPlay = true;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_tarefaAtual.rascunho && !_isEditing) {
      return SizedBox.shrink();
    }
    final theme = Theme.of(context);
    final dias = [
      widget.tarefa.diaSemana ? 'Dias de semana' : null,
      widget.tarefa.sabado ? 'Sabados' : null,
      widget.tarefa.domingo ? 'Domingos' : null,
    ].whereType<String>();

    return Container(
      padding: const EdgeInsets.only(top: 8, left: 8, right: 4, bottom: 4),
      width: 165,
      color: Colors.amber[100],
      margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _isEditing
                    ? TextFormField(
                        autofocus: true,
                        enabled: _isEditing,
                        initialValue: _tarefaAtual.nome,
                        style: theme.textTheme.bodyMedium,
                        maxLines: null,
                        decoration: const InputDecoration(border: InputBorder.none),
                        onChanged: (newValue) {
                          setState(() {
                            _tarefaAtual = _tarefaAtual.copyWith(nome: newValue);
                          });
                        },
                      )
                    : Text(_tarefaAtual.nome),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                alignment: Alignment.topRight,
                onPressed: () {
                  setState(() {
                    if (_isEditing && _tarefaAtual.rascunho && widget.onCancel != null) {
                      widget.onCancel!();
                    }
                    _isEditing = !_isEditing;
                  });
                },
                icon: _isEditing ? const Icon(Icons.close, size: 16) : const Icon(Icons.edit, size: 16),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (!_isEditing)
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
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
                Expanded(
                  child: Text(
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
                ),
                const SizedBox(width: 8),
              ],
            ),
          if (_isEditing)
            Column(
              children: [
                const SizedBox(height: 8),
                _buildBottomActions(),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.check,
                        color: Colors.green,
                      ),
                      onPressed: () async {
                        await API.edita(_tarefaAtual);
                        setState(() {
                          _isEditing = false;
                        });
                      },
                    ),
                    if (!_tarefaAtual.rascunho)
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () async {
                          await API.deleta(_tarefaAtual.id);
                          setState(() {
                            _isEditing = false;
                          });
                        },
                      ),
                  ],
                ),
              ],
            )
        ],
      ),
    );
  }

  Widget _buildBottomActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildCheckBox(
          label: 'dia sem.',
          value: _tarefaAtual.diaSemana,
          onChanged: (bool? value) {
            setState(() {
              _tarefaAtual = _tarefaAtual.copyWith(diaSemana: value);
            });
          },
        ),
        _buildCheckBox(
          label: 'sab',
          value: _tarefaAtual.sabado,
          onChanged: (bool? value) {
            setState(() {
              _tarefaAtual = _tarefaAtual.copyWith(sabado: value);
            });
          },
        ),
        _buildCheckBox(
          label: 'dom',
          value: _tarefaAtual.domingo,
          onChanged: (bool? value) {
            setState(() {
              _tarefaAtual = _tarefaAtual.copyWith(domingo: value);
            });
          },
        ),
      ],
    );
  }

  Widget _buildCheckBox({required String label, required ValueChanged<bool?> onChanged, required bool value}) {
    return Column(
      children: [
        Checkbox(value: value, onChanged: onChanged),
        Text(
          label,
          style: const TextStyle(fontSize: 12),
        ),
      ],
    );
  }

  //dispose para o botão de play
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
