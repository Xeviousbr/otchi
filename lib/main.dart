import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ot/components/theme.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:ot/services/auth_service.dart';

import 'firebase_options.dart';
import 'pages/cadastrar_tarefa.dart';

import 'pages/register_page/register_page.dart';
import 'pages/home/home_page.dart';
import 'pages/login_page/login_page.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn =
          'https://2ea50cd856ad43bab28274c1a4978720@o4504169361899520.ingest.sentry.io/4504169366945792';
      // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
      // We recommend adjusting this value in production.
      options.tracesSampleRate = 1.0;
    },
  );

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
    return StreamBuilder<bool>(
        stream: AuthService.estaLogado(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return MaterialApp(
            title: 'OT - Organizador de Tarefas',
            theme: theme(),
            routes: {
              '/login': (_) => LoginPage(),
              '/cadastrar_tarefa': (_) => CadastrarTarefa(),
              '/home': (_) => const HomePage(),
              '/cadastro_user': (_) => const RegisterPage(),
            },
            home: snapshot.data! ? const HomePage() : LoginPage(),
          );
        });
  }
}
