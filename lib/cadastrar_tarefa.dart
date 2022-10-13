import 'dart:convert';

import 'package:flutter/material.dart';
import 'cadastrar_tarefa.dart';
import 'api.dart';
import 'tarefa.dart';

class CadastrarTarefa extends StatefulWidget {
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
  bool? diassem = true;
  bool? sabados = false;
  bool? domingos = false;
  String nome = "";
  String prioridade = "";
  String horario = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastrar a tarefa",
            style: TextStyle(
              fontSize: 32,
              color: Colors.black,
            )),
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
                prioridade = newValue.toString();
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
                setState(() => diassem = value);
              },
            ),
            CheckboxListTile(
              title: const Text('Sábados'),
              value: sabados,
              onChanged: (bool? value) {
                setState(() => sabados = value);
              },
            ),
            CheckboxListTile(
                title: const Text('Domingos'),
                value: domingos,
                onChanged: (bool? value) {
                  setState(() => domingos = value);
                }),
            ElevatedButton(
              onPressed: () {
                EnviaDados();
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
              child: const Text('Cancelar',
                  textDirection: TextDirection.ltr,
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                  )),
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
    horario = picked.hour.toString() + ":" + picked.minute.toString();
  }

  void EnviaDados() {
    String id = "1";
    Tarefa tarefa = new Tarefa();

    // AQUI DEVE TER O ID RETORNADO PELO LOGIN
    tarefa.idUser = "1";

    tarefa.Nome = nome;
    tarefa.Prioridade = prioridade;
    tarefa.Hora = horario;
    tarefa.HabDiaSem = (diassem == true) ? "1" : "0";
    tarefa.HamSab = (sabados == true) ? "1" : "0";
    tarefa.HabDom = (domingos == true) ? "1" : "0";
    tarefa.Habilitado = "1";
    API.Cadastra(tarefa).then((response) {
      setState(() {
        var ret = json.decode(response.body);
        if (ret['OK'] == 1) {
          Navigator.pop(context);
        } else {
          // COLOCAR UMA MENSAGEM DE ERRO AQUI
          print('Deu errado');
        }
      });
    });
  }
}
