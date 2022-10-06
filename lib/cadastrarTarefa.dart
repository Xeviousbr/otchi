import 'package:flutter/material.dart';
import 'api.dart';

class cadastrarTarefa extends StatefulWidget {
  @override
  State<cadastrarTarefa> createState() => _cadastrarTarefaState();
}

class _cadastrarTarefaState extends State<cadastrarTarefa> {
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
                Navigator.pop(context);
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
    API.getMovie("search").then((response) {
      setState(() {
        print("setState");
        print(response.body);
        // Iterable lista = json.decode(response.body); // Usamos um iterator
      });
    });
  }
}

