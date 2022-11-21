import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ot/components/theme.dart';

import 'firebase_options.dart';
import 'pages/cadastrar_tarefa.dart';

import 'pages/register_page/register_page.dart';
import 'pages/home/home_page.dart';
import 'pages/login_page/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OT - Organizador de Tarefas',
      theme: theme(),
      routes: {
        '/login': (_) => LoginPage(),
        '/cadastrar_tarefa': (_) => const CadastrarTarefa(),
        '/home': (_) => const HomePage(),
        '/cadastro_user': (_) => const RegisterPage(),
      },
      home: LoginPage(),
    );
  }
}
