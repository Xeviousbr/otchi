import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ot/login_page/login_page.dart';
import 'cadastrar_tarefa.dart';
import 'tarefa.dart';
import 'api.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OT - Organizador de Tarefas',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  // List<dynamic> list = PegaLista(1);
  List _itens = [];
  void carregaFake() {
    for (int i = 0; i < 5; i++) {
      Map<String, dynamic> item = Map();
      item["id"] = i;
      item["Nome"] = i.toString() + i.toString();
      _itens.add(item);
    }
  }

  static int TotRegs = 0;

  @override
  Widget build(BuildContext context) {
    // print('TotRegs1 = ' + TotRegs.toString());
    carregaFake();
    // _itens = PegaLista(1);
    print("_itens.length = " + _itens.length.toString());
    return Scaffold(
        appBar: AppBar(
          title: const Text('OT - Organizador de Tarefas'),
        ),
        body: Column(children: [
          Column(children: <Widget>[
            Center(
                heightFactor: 2,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CadastrarTarefa()),
                    );
                  },
                  child: const Text('Nova Tarefa',
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontSize: 32,
                        color: Colors.black,
                      )),
                )),
            SizedBox(
              height: 20,
            ),
            TextButton(
              onPressed: () async {
                bool logOut = await logout();
                if (logOut) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => LoginPage()));
                }
              },
              child: const Text(
                'Logout',
                textDirection: TextDirection.ltr,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.red,
                ),
              ),
            ),
            Table(
                border: TableBorder.all(color: Colors.black),
                columnWidths: {},
                children: [
                  for (int i = 0; i < 3; i++)
                    TableRow(children: [
                      Text(_itens[i]["id"].toString(),
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.black,
                          ))
                    ])

                  // for (var =0 to TotRegs)
                  // for (var item in list)
                  //   TableRow(children: [
                  //     Text(item,
                  //         textDirection: TextDirection.ltr,
                  //         style: TextStyle(
                  //           fontSize: 32,
                  //           color: Colors.black,
                  //         ))
                  //   ])
                ])
          ])
        ]));
  }

  Future<bool> logout() async {
    SharedPreferences prefer = await SharedPreferences.getInstance();
    await prefer.clear();
    return true;
  }

  static List PegaLista(int i) {
    List<dynamic> ret = [];
    List _itens = [];
    // List<String> retS = [];
    API.ListaTarefas(1).then((response) {
      print(response.body);
      ret = json.decode(response.body);
      print("ret[0]");
      print(ret[0]);
      print("ret[0][0]");
      print(ret[0][0]);
      TotRegs = ret[0][0];
      print('TotRegs3 = ' + TotRegs.toString());

      for (int i = 1; i < TotRegs; i++) {
        Map<String, dynamic> item = Map();
        item["id"] = ret[i][0];
        item["Nome"] = ret[i][1];
        _itens.add(item);
      }

      // retS = ret.cast<String>();
      // print(retS[1]);
    });
    // print(ret);
    // print(retS);
    // print('TotRegs2 = ' + TotRegs.toString());
    return _itens;
  }
  
}
