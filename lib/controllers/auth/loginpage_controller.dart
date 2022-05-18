import 'package:esalakanmi/controllers/auth/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../screens/homepage.dart';

class LogInPageController extends StatefulWidget {
  const LogInPageController({Key? key}) : super(key: key);

  @override
  State<LogInPageController> createState() => _LogInPageControllerState();
}

class _LogInPageControllerState extends State<LogInPageController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const HomePage();
            } else {
              return const LogInPage();
            }
          },
        ),
      ),
    );
  }
}
