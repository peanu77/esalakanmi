import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('incident')
      .doc('incident')
      .collection('incident-report');

  var data;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Admin'),
          actions: [
            IconButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                icon: Icon(Icons.logout_outlined))
          ],
          backgroundColor: Colors.blue[900],
          elevation: 0.0,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: ref.snapshots(),
          builder: (context, snapshot) {
            getUserData(snapshot);
            print(data);
            return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.blue[900],
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 20.0),
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Date : ${data['date']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Time : ${data['time']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Category : ${data['category']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            'Description : ${data['description']}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          TextButton(
                            onPressed: () => launchUrlString(
                                "maps.google.com/maps?saddr=${data['latitude']},${data['longitude']}"),
                            child: Text(
                              "maps.google.com/maps?saddr=${data['latitude']},${data['longitude']}",
                              style: TextStyle(color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  getUserData(snapshot) {
    snapshot.data?.docs.forEach((doc) => {data = doc.data()});
  }
}
