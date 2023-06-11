import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logout_bloc.dart';

class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
   final theme = Theme.of(context);
   final bloc = LogoutBlock();
   
    return Scaffold(
      body: BlocBuilder<LogoutBlock, LogoutState>(
              bloc: bloc,
              builder: (context, state) {
                return  Drawer(
        child: Column( 
                 
                    children: [
                      const Spacer(),
                      ElevatedButton(
                        onPressed: () {
                        bloc.add(const TryToLogoutEvent());
                      },
                      child: state is LogoutLoadingState
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Deslogar",
                              style: theme.textTheme.bodyLarge,
                            ),
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                );
              },
      ),
      );
    
  }
}