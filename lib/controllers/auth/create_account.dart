import 'package:esalakanmi/controllers/shared_pref/shared_pref.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import '../database_controller.dart';
import 'package:intl/intl.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  final databaseController = DatabaseController();

  final emailController = TextEditingController();
  final firstnameController = TextEditingController();
  final middlenameController = TextEditingController();
  final lastnameController = TextEditingController();
  final barangayController = TextEditingController();
  final municipalityController = TextEditingController();
  final provinceController = TextEditingController();
  final passwordController = TextEditingController();

  bool isChecked = false;
  bool isShow = true;
  var d;
  String? genderValue;
  // @override
  // void dispose() {
  //   emailController.dispose();
  //   firstnameController.dispose();
  //   middlenameController.dispose();
  //   lastnameController.dispose();
  //   barangayController.dispose();
  //   municipalityController.dispose();
  //   provinceController.dispose();
  //   passwordController.dispose();

  //   super.dispose();
  // }
  final contactRegex = RegExp(r'^(09|\+639)\d{9}$');
  final emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  String contact = '';
  DateTime dateTime = DateTime.now();

  final genderItem = ["Male", "Female", "Others"];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('e-SalakanMi'),
          backgroundColor: Colors.blue[900],
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
              child: Column(
                children: [
                  Text(
                    'Registration',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.0,
                        color: Colors.blue[900]),
                  ),

                  const SizedBox(height: 30.0),
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

                  const SizedBox(
                    height: 15.0,
                  ), // First Name
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: firstnameController,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "First Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "First Name Field is Required";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 15.0,
                  ),
                  // Middle Name
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: middlenameController,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Middle Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Middle Name Field is Required";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 15.0,
                  ),
                  // Last Name
                  TextFormField(
                    keyboardType: TextInputType.name,
                    controller: lastnameController,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Last Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Last Name Field is Required";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 15.0,
                  ),
                  // Barangay Name
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    controller: barangayController,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Barangay / Street",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Barangay Field is Required";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 15.0,
                  ),

                  // Municipality
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    controller: municipalityController,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "Municipality",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Municipality Field is Required";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 15.0,
                  ),
                  // City Province
                  TextFormField(
                    keyboardType: TextInputType.streetAddress,
                    controller: provinceController,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: "City / Province",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "City / Province Field is Required";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(
                    height: 15.0,
                  ),
// Contact Number
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    // controller: contact,
                    cursorColor: Colors.black,
                    textInputAction: TextInputAction.next,

                    decoration: InputDecoration(
                      labelText: "Contact Number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),

                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a contact number";
                      }

                      if (!contactRegex.hasMatch(value)) {
                        return "Enter a valid contact number";
                      }
                      return null;
                    },
                    onChanged: (value) => setState(() => contact = value),
                    // ^(09|\+639)\d{9}$
                  ),
                  const SizedBox(height: 15.0),
                  // Gender
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 5.0, horizontal: 15.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Gender"),
                        SizedBox(
                          width: 140.0,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              iconSize: 40,
                              value: genderValue,
                              // isExpanded: true,
                              items: genderItem.map(buildGenderList).toList(),
                              onChanged: (genderValue) {
                                setState(() {
                                  this.genderValue = genderValue as String?;
                                });
                                // print(genderValue);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 15.0),
                  // Date Picker
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20.0, horizontal: 20.0),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                    onPressed: () {
                      showDatePicker(
                              context: context,
                              initialDate: dateTime,
                              firstDate: DateTime(1946),
                              lastDate: DateTime(2030))
                          .then((value) {
                        setState(() {
                          dateTime = value!;
                          d = DateFormat.yMMMd().format(dateTime);
                        });
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        d != null
                            ? Text(
                                "$d",
                                style: const TextStyle(color: Colors.black),
                              )
                            : const Text(
                                'Month / Day / Year',
                                style: TextStyle(color: Colors.black),
                              ),
                        const Icon(
                          Icons.calendar_month,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 15.0,
                  ),

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
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * 0.08,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blue[900],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0))),
                      onPressed: () {
                        const uid = Uuid();
                        final uidRes = uid.v4();
                        final formKey = _formKey.currentState!.validate();
                        if (_formKey.currentState!.validate()) {
                          SharedPref.setUsername(firstnameController.text);
                          databaseController.createAccount(
                            _formKey,
                            emailController,
                            passwordController,
                            context,
                          );
                          // SharedPref.setUsername(firstnameController.text);
                          // SharedPref.setEmail(emailController.text);
                          databaseController.userInfo(
                            uidRes,
                            emailController,
                            firstnameController.text,
                            middlenameController.text,
                            lastnameController.text,
                            barangayController.text,
                            municipalityController.text,
                            provinceController.text,
                            contact,
                            genderValue,
                            d,
                          );
                        }
                      },
                      child: const Text("REGISTER!"),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildGenderList(String item) => DropdownMenuItem(
        value: item,
        child: Text(item),
      );
}
