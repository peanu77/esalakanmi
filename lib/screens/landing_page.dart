import 'package:esalakanmi/controllers/auth/loginpage_controller.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'e-SalakanMi',
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: Image.asset('assets/asterisk.png'),
            ),
            Container(
              child: Text(
                'e-SalakanMi',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.blue[900],
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            Image.asset('assets/landing_logo.png'),
            ElevatedButton(
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const LogInPageController(),
                ),
              ),
              child: Text('Sign In'),
            ),
            OutlinedButton(
              onPressed: () => const LogInPageController(),
              child: Text('REGISTER HERE!'),
            )
          ],
        ),
      ),
    );
  }
}
