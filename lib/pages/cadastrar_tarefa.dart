import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/tarefa.dart';
import '../services/api.dart';

class CadastrarTarefa extends StatefulWidget {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Cadastrar a tarefa",
          style: TextStyle(
            fontSize: 32,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome da tarefa';
                  }
                  return value;
                },
                // ignore: prefer_const_constructors
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  hintText: 'Informe o nome da tarefa',
                ),
                onChanged: (newValue) {
                  nome = newValue;
                },
              ),
              DropdownButton(
                hint: const Text('Escolha a prioridade'),
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
              ElevatedButton(
                onPressed: () {
                  selectTime(context);
                },
                child: const Text('Definir Horário Limite',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                    )),
              ),
              CheckboxListTile(
                title: const Text('Dias de semana'),
                value: diassem,
                onChanged: (bool? value) {
                  setState(() => diassem = value!);
                },
              ),
              CheckboxListTile(
                title: const Text('Sábados'),
                value: sabados,
                onChanged: (bool? value) {
                  setState(() => sabados = value!);
                },
              ),
              CheckboxListTile(
                  title: const Text('Domingos'),
                  value: domingos,
                  onChanged: (bool? value) {
                    setState(() => domingos = value!);
                  }),
              ElevatedButton(
                onPressed: () {
                  enviaDados();
                },
                child: const Text('Salvar',
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.black,
                    )),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancelar',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                  ),
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
      horarios: [],
      diasSemanaHabilitado: diasSemana,
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
