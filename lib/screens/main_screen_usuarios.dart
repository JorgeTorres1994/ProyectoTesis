/*import 'package:app_web_proyecto_final/screens/dashboard_screen_usuario.dart';
import 'package:flutter/material.dart';
import 'package:app_web_proyecto_final/inner_screens/LoginScreen.dart';
import 'package:app_web_proyecto_final/responsive.dart';
import 'package:app_web_proyecto_final/widgets/side_menu.dart';

class MainScreenUsuario extends StatelessWidget {
  final bool isAuthenticated;

  MainScreenUsuario({Key? key, required this.isAuthenticated})
      : super(key: key) {
    print('MainScreen constructor - isAuthenticated: $isAuthenticated');
  }

  @override
  Widget build(BuildContext context) {
    print('MainScreen build - isAuthenticated: $isAuthenticated');
    return Responsive(
      mobile: Scaffold(
        body: SafeArea(
          child: isAuthenticated ? DashBoardScreenUsuario() : LoginScreen(),
        ),
      ),
      desktop: Scaffold(
        drawer: const SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child:
                    isAuthenticated ? DashBoardScreenUsuario() : LoginScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
*/

import 'package:app_web_proyecto_final/screens/dashboard_screen_usuario.dart';
import 'package:flutter/material.dart';
import 'package:app_web_proyecto_final/inner_screens/LoginScreen.dart';
import 'package:app_web_proyecto_final/responsive.dart';
import 'package:app_web_proyecto_final/widgets/side_menu.dart';

class MainScreenUsuario extends StatelessWidget {
  final bool isAuthenticated;

  MainScreenUsuario({Key? key, required this.isAuthenticated})
      : super(key: key) {
    print('MainScreen constructor - isAuthenticated: $isAuthenticated');
  }

  @override
  Widget build(BuildContext context) {
    print('MainScreen build - isAuthenticated: $isAuthenticated');
    return Responsive(
      mobile: Scaffold(
        body: SafeArea(
          child: isAuthenticated ? DashBoardScreenUsuario() : LoginScreen(),
        ),
      ),
      desktop: Scaffold(
        drawer: const SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child:
                    isAuthenticated ? DashBoardScreenUsuario() : LoginScreen(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
