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
      body: Center(
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
    );
  }

  Future<void> selectTime(BuildContext context) async {
    picked = (await showTimePicker(
      context: context,
      initialTime: _time,
    ))!;
    horario = '${picked.hour} : ${picked.minute}'; // TODO: VER DATETIME
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
