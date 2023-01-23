import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/tarefa.dart';
import '../services/api.dart';

class CadastrarTarefa extends StatefulWidget {
  const CadastrarTarefa({
    super.key,
    this.tarefa,
  });
  final Tarefa? tarefa;

  @override
  State<CadastrarTarefa> createState() => _CadastrarTarefaState();
}

class _CadastrarTarefaState extends State<CadastrarTarefa> {
  late TimeOfDay pickedI;
  late TimeOfDay pickedF;
  late TimeOfDay _selectedTimeI;
  late TimeOfDay _selectedTimeF;
  late TimeOfDay _timeF = TimeOfDay.now();
  late TimeOfDay _timeI = TimeOfDay.now();
  String horarioI = "";
  String horarioF = "";
  String sHrIn = "Horário Inicial";
  String sHrFn = "Horário Final";
  late List<int> _prioridades;
  late Tarefa _tarefaAtual;

  @override
  void initState() {
    _prioridades = List<int>.generate(10, (index) => index + 1);

    super.initState();
    _tarefaAtual = widget.tarefa ??
        Tarefa(
          id: const Uuid().v1(),
          nome: '',
          prioridade: 1,
          diaSemana: false,
          sabado: false,
          domingo: false,
          habilitado: true,
          acao: TarefaAcao(
            emAndamento: false,
            atualizadaEm: Timestamp.now(),
          ),
          tempo: 0,
        );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cadastrar a tarefa",
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextFormField(
                initialValue: _tarefaAtual.nome,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome da tarefa';
                  }
                  return value;
                },
                decoration: InputDecoration(
                  labelStyle: theme.textTheme.bodyMedium,
                  border: const OutlineInputBorder(),
                  hintText: 'Informe o nome da tarefa',
                ),
                autofocus: true,
                onChanged: (newValue) {
                  setState(() {
                    _tarefaAtual = _tarefaAtual.copyWith(nome: newValue);
                  });
                },
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text('Prioridade'),
                        DropdownButton<int>(
                          hint: const Text('Escolha a prioridade'),
                          value: _tarefaAtual.prioridade,
                          dropdownColor: const Color(0xffE5D9B6),
                          style: theme.textTheme.bodyMedium,
                          onChanged: (int? newValue) {
                            setState(() {
                              _tarefaAtual = _tarefaAtual.copyWith(
                                  prioridade: newValue ?? 0);
                            });
                          },
                          items: _prioridades.map((location) {
                            return DropdownMenuItem<int>(
                              value: location,
                              child: Text('$location'),
                            );
                          }).toList(),
                        ),
                        //
                        ElevatedButton(
                          onPressed: () {
                            selectTimeI(context);
                          },
                          child: Text(
                            sHrIn,
                            textDirection: TextDirection.ltr,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            selectTimeF(context);
                          },
                          child: Text(
                            sHrFn,
                            textDirection: TextDirection.ltr,
                            style: theme.textTheme.bodyLarge,
                          ),
                        ),
                        //
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        CheckboxListTile(
                          title: Text(
                            'Dias de semana',
                            style: theme.textTheme.bodyMedium,
                          ),
                          value: _tarefaAtual.diaSemana,
                          onChanged: (bool? value) {
                            setState(() {
                              _tarefaAtual =
                                  _tarefaAtual.copyWith(diaSemana: value);
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text(
                            'Sábados',
                            style: theme.textTheme.bodyMedium,
                          ),
                          value: _tarefaAtual.sabado,
                          onChanged: (bool? value) {
                            setState(() {
                              _tarefaAtual =
                                  _tarefaAtual.copyWith(sabado: value);
                            });
                          },
                        ),
                        CheckboxListTile(
                          title: Text(
                            'Domingos',
                            style: theme.textTheme.bodyMedium,
                          ),
                          value: _tarefaAtual.domingo,
                          onChanged: (bool? value) {
                            setState(() {
                              _tarefaAtual =
                                  _tarefaAtual.copyWith(domingo: value);
                            });
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  int tempo = await calculaTempo(_tarefaAtual.prioridade);
                  _tarefaAtual.tempo = tempo;
                  enviaDados();
                },
                child: Text(
                  'Salvar',
                  textDirection: TextDirection.ltr,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancelar',
                  textDirection: TextDirection.ltr,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),
              OutlinedButton(
                onPressed: () {
                  API.deleta(_tarefaAtual.id);
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Deletar',
                  textDirection: TextDirection.ltr,
                  style:
                      theme.textTheme.bodyLarge?.copyWith(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectTimeI(BuildContext context) async {
    pickedI = (await showTimePicker(
      context: context,
      initialTime: _timeI,
    ))!;
    if (pickedI != null) {
      setState(() {
        _selectedTimeI = pickedI;
        _timeI = pickedI;
        sHrIn = "Hora Inicial: " + _selectedTimeI.format(context);
      });
    }
    horarioI = '${pickedI.hour} : ${pickedI.minute}';
    // ignore: todo
    //TODO: VER DATETIME
  }

  Future<void> selectTimeF(BuildContext context) async {
    pickedF = (await showTimePicker(
      context: context,
      initialTime: _timeF,
    ))!;
    if (pickedF != null) {
      setState(() {
        _selectedTimeF = pickedF;
        _timeF = pickedF;
        sHrFn = "Hora Inicial: " + _selectedTimeF.format(context);
      });
    }

    horarioF = '${pickedF.hour} : ${pickedF.minute}';
    // ignore: todo
    //TODO: VER DATETIME
  }

  Future<void> enviaDados() async {
    int dias = 0;
    if (_tarefaAtual.diaSemana) {
      dias = 31;
    }
    if (_tarefaAtual.sabado) {
      dias += 32;
    }
    if (_tarefaAtual.domingo) {
      dias += 64;
    }
    print(dias);
    // if (widget.tarefa == null) {
    //   await API.cadastra(_tarefaAtual);
    // } else {
    //   await API.edita(_tarefaAtual);
    // }
    // Navigator.of(context).pop();
  }

  Future<int> calculaTempo(int prioridade) async {
    final tarefas = await API.listaTarefas().first;
    int tempo = 1000;
    if (!tarefas.isEmpty) {
      int auxTempo = 1001;
      for (Tarefa element in tarefas) {
        auxTempo = element.tempo + 1;
        if (prioridade < (element.prioridade + 1)) {
          auxTempo = element.tempo - 1;
          break;
        }
      }
      tempo = auxTempo;
    }
    return tempo;
  }
}
