import 'package:esalakanmi/controllers/auth/create_account.dart';
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
    return SafeArea(
      child: Scaffold(
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              const SizedBox(
                height: 30.0,
              ),
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
              const SizedBox(
                height: 60.0,
              ),
              Container(
                child: Text(
                  'A Mobile-based Application for Emergency Incident Reporting',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 20.0),
              Container(
                width: double.infinity,
                height: 130.0,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/landing_logo.png'),
                      fit: BoxFit.fitWidth),
                ),
              ),
              const Spacer(),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 70.0)),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const LogInPageController(),
                  ),
                ),
                child: const Text('Sign In'),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50.0)),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const CreateAccountPage())),
                child: const Text('REGISTER HERE!'),
              ),
              const SizedBox(height: 20.0),
              Container(
                child: Text(
                  'Send a incident from your smartphone and send photo.',
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 50.0)
            ],
          ),
        ),
      ),
    );
  }
}
