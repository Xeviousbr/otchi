import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/tarefa.dart';
import '../services/api.dart';

class CadastrarTarefa extends StatefulWidget {
  const CadastrarTarefa({super.key});

  @override
  State<CadastrarTarefa> createState() => _CadastrarTarefaState();
}

class _CadastrarTarefaState extends State<CadastrarTarefa> {
  final List<String> _locations = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
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
                  setState(() {
                    nome = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              DropdownButton(
                hint: const Text('Escolha a prioridade'),
                value: _selectedLocation,
                dropdownColor: const Color(0xffE5D9B6),
                style: theme.textTheme.bodyMedium,
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
              ElevatedButton(
                onPressed: () {
                  selectTime(context);
                },
                child: Text(
                  'Definir Horário Limite',
                  textDirection: TextDirection.ltr,
                  style: theme.textTheme.bodyLarge,
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
                },
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
              const SizedBox(height: 16),
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
    // todo: ler os dados da tela e preencher esse objeto abaixo
    final id = (ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?)?['id'] as String?;
    final tarefa = Tarefa(
      id: id ?? const Uuid().v1(),
      nome: nome,
      prioridade: prioridade,
      habilitado: true,
      diasSemanaHabilitado: diasSemana,
      tempo: 0,
      acao: TarefaAcao.inicial(),
    );

    if (id == null) {
      await API.cadastra(tarefa);
    } else {
      await API.edita(tarefa);
    }
    //todo: add tratamento de erro
    Navigator.of(context).pop();
  }
}
