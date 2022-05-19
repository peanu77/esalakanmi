import 'package:esalakanmi/controllers/database_controller.dart';
import 'package:flutter/material.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final databaseController = DatabaseController();
  final _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  bool isShow = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "e-SalakanMi",
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.blue[900],
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),

                  Container(
                    child: Text(
                      'Sign in',
                      style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),

                  const SizedBox(height: 30.0),
                  Container(
                    child: Image.asset('assets/asterisk.png'),
                  ),
                  const SizedBox(height: 30.0),
                  Container(
                    child: Text(
                      'e-SalakanMi',
                      style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.blue[900],
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  // Email
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email Field is Required";
                      }
                      if (!emailRegex.hasMatch(value)) {
                        return "Invalid Email";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  // Password
                  TextFormField(
                    controller: passwordController,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      labelText: "Password",
                      suffixIcon: IconButton(
                        onPressed: () => setState(() => isShow = !isShow),
                        icon: isShow
                            ? const Icon(Icons.visibility_off)
                            : const Icon(Icons.visibility_outlined),
                      ),
                    ),
                    obscureText: isShow,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a password";
                      }
                      if (value.length < 6) {
                        return "Password must be atleast 6 characters";
                      }
                    },
                  ),
                  const SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () => databaseController.signIn(
                        emailController, passwordController, context),
                    child: const Text("SIGN IN"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
