import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ot/services/shared_reference_page.dart';
import '../models/tarefa.dart';
import '../services/api.dart';

class CadastrarTarefa extends StatefulWidget {
  const CadastrarTarefa({super.key});

  @override
  State<CadastrarTarefa> createState() => _CadastrarTarefaState();
}

class _CadastrarTarefaState extends State<CadastrarTarefa> {
  final List<String> _locations = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10'
  ];
  String? _selectedLocation;
  final TimeOfDay _time = TimeOfDay.now();
  late TimeOfDay picked;
  bool diassem = true;
  bool sabados = false;
  bool domingos = false;
  String nome = "";
  int prioridade = 0;
  String horario = "";
  String idUser = "0";
  int? tarefEditID;
  @override
  void initState() {
    super.initState();
    SharedPrefUtils.readTarefEditID().then((vlr) {
      setState(() {
        if (vlr == 0) {
          debugPrint('Nova Tarefa');
        } else {
          debugPrint('EDIÇÃO');
        }
      });
    });
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
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListView(
            padding: EdgeInsets.zero,
            scrollDirection: Axis.vertical,
            children: [
              TextFormField(
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
                onChanged: (newValue) {
                  nome = newValue;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButton(
                hint: const Text('Escolha a prioridade'),
                dropdownColor: const Color(0xffE5D9B6),
                style: theme.textTheme.bodyMedium,
                value: _selectedLocation,
                onChanged: (newValue) {
                  prioridade = newValue as int;
                  setState(() => _selectedLocation = newValue.toString());
                },
                items: _locations.map((location) {
                  return DropdownMenuItem(
                    value: location,
                    child: Text(location),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    selectTime(context);
                  },
                  child: Text(
                    'Definir Horário Limite',
                    //textDirection: TextDirection.ltr,
                    style: theme.textTheme.bodyLarge,
                  ),
                ),
              ),
              CheckboxListTile(
                title: Text(
                  'Dias de semana',
                  style: theme.textTheme.bodyMedium,
                ),
                value: diassem,
                onChanged: (bool? value) {
                  setState(() => diassem = value!);
                },
              ),
              CheckboxListTile(
                title: Text(
                  'Sábados',
                  style: theme.textTheme.bodyMedium,
                ),
                value: sabados,
                onChanged: (bool? value) {
                  setState(() => sabados = value!);
                },
              ),
              CheckboxListTile(
                  title: Text(
                    'Domingos',
                    style: theme.textTheme.bodyMedium,
                  ),
                  value: domingos,
                  onChanged: (bool? value) {
                    setState(() => domingos = value!);
                  }),
              const SizedBox(
                height: 100,
              ),
              ElevatedButton(
                onPressed: () {
                  enviaDados();
                },
                child: Text(
                  'Salvar',
                  textDirection: TextDirection.ltr,
                  style: theme.textTheme.bodyLarge,
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancelar',
                  textDirection: TextDirection.ltr,
                  style: theme.textTheme.bodyLarge,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> selectTime(BuildContext context) async {
    picked = (await showTimePicker(
      context: context,
      initialTime: _time,
    ))!;

    horario = '${picked.hour} : ${picked.minute}';
    // ignore: todo
    //TODO: VER DATETIME
  }

  Future<void> enviaDados() async {
    final userId = await SharedPrefUtils.readId();
    if (userId == null) {
      return;
    }
    final tarefa = Tarefa(
      idUser: userId,
      nome: nome,
      prioridade: prioridade,
      hora: horario,
      habDiaSem: diassem,
      hamSab: sabados,
      habDom: domingos,
      habilitado: true,
    );

    API.cadastra(tarefa).then((response) {
      setState(() {
        var ret = json.decode(response.body);
        if (ret['OK'] == 1) {
          Navigator.pop(context);
        } else {
          // COLOCAR UMA MENSAGEM DE ERRO AQUI
          debugPrint('Deu errado');
        }
      });
    });
  }
}
