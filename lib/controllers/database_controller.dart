import 'package:esalakanmi/controllers/auth/loginpage_controller.dart';
import 'package:esalakanmi/controllers/shared_pref/shared_pref.dart';
import 'package:esalakanmi/screens/admin/homepage.dart';
import 'package:esalakanmi/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class DatabaseController {
  signIn(emailController, passwordController, context) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Invalid email',
              ),
            ),
          );
          break;

        case "user-not-found":
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User not found'),
            ),
          );
          break;

        case "wrong-password":
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid password'),
            ),
          );
          break;

        default:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please check your credentials and try again'),
            ),
          );
      }
    }
  }

  Future createAccount(
      formKey, emailController, passwordController, context) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trimLeft());
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const LogInPageController()),
          (route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Email already in use'),
          ),
        );
      }

      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Enter a strong password'),
          ),
        );
      }
    }
  }

  Future userInfo(
      uid,
      emailController,
      firstnameController,
      middlenameController,
      lastnameController,
      barangayController,
      municipalityController,
      provinceController,
      contact,
      genderValue,
      d) async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('user_info');
    // Create user data
    var data = {
      'uuid': uid,
      'email': emailController,
      'firstname': firstnameController,
      'middlename': middlenameController,
      'lastname': lastnameController,
      'barangay': barangayController,
      'municipality': municipalityController,
      'province': provinceController,
      'contact': contact,
      'gender': genderValue,
      'birthday': d,
      'created': DateFormat.yMMMd().format(DateTime.now()),
    };

    ref.add(data);
  }

  incidentReport(
    email,
    desc,
    category,
    date,
    time,
    lat,
    long,
  ) {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('incident')
        .doc('incident')
        .collection('incident-report');
    // Create user data
    var data = {
      'email': email,
      'description': desc,
      'category': category,
      'date': date,
      'time': time,
      'latitude': lat,
      'longitude': long,
      'created': DateFormat.yMMMd().format(DateTime.now()),
    };

    ref.add(data).then((value) => print('Success'));
  }

  Future myReport(
    email,
    desc,
    category,
    date,
    time,
    lat,
    long,
  ) async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('my-report')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('incident-report');
    // Create user data
    var reportData = {
      'email': email,
      'description': desc,
      'category': category,
      'date': date,
      'time': time,
      'latitude': lat,
      'longitude': long,
      'created': DateFormat.yMMMd().format(DateTime.now()),
    };

    ref.add(reportData).then((value) => print('My Report'));
  }
}
