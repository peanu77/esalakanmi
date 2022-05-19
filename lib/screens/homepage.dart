import 'package:esalakanmi/controllers/shared_pref/shared_pref.dart';
import 'package:esalakanmi/screens/reportincident_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('user_info');
  String? incidentValue;
  var data;

  Position? _currentPosition;
  String? _currentAddress;
  TwilioFlutter? twilioFlutter;

  @override
  void initState() {
    twilioFlutter = TwilioFlutter(
        accountSid: "ACbb9ea8f5dbdecee31f7b729bf2d531ea",
        authToken: "3a5a523b2edde0f39cf30688f413b2de",
        twilioNumber: "+12542796811");

    super.initState();
  }

  List numList = [
    '+639505259391',
    "+639167913875",
    "+639982292385",
    "+639981783349",
    "+639453741453"
  ];

  Future sendSms(message, userNum) async {
    await twilioFlutter
        ?.sendSMS(
            toNumber: "$userNum",
            messageBody:
                "EMEGERGENCY: $incidentValue, Someone needs help at maps.google.com/maps?saddr=${_currentPosition?.latitude},${_currentPosition?.longitude} in $_currentAddress Please Respond immediately!!!'")
        .then((value) => print('Done'));
    // twilioFlutter?.sendSMS(
    //   toNumber: '+639505259391',
    //   messageBody:
    //       'EMEGERGENCY: Vehicular Accident, Someone needs help at maps.google.com/maps?saddr=16.52536348,120.34113977 Please Respond immediately!!!',
    // );
  }

  final incidentItem = [
    "Vehicular accident",
    "Fire",
    "Robbery",
    "Harrastment",
    "Assault",
    "Theft",
    "Burglary",
    "Kidnapping",
    "Vandalism"
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          'e-SalakanMi',
          style: TextStyle(fontSize: 20.0, color: Colors.white),
        ),
        elevation: 0.0,
        backgroundColor: Colors.blue[900],
        actions: [
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
              SharedPreferences _preferences =
                  SharedPreferences.getInstance() as SharedPreferences;

              _preferences.remove('username');
            },
            icon: const Icon(Icons.logout_outlined),
          )
        ],
      ),
      // backgroundColor: Colors.blue[900],
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                'assets/bg.jpg',
              ),
              fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              const Text(
                'Welcome!',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0),
              Text(
                "${SharedPref.getUsername() ?? ""}",
                style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30.0),
              // Text(
              //   "${data != null ? data['firstname'] : ""} ",
              //   style: const TextStyle(color: Colors.orange),
              // ),
              // if (_currentPosition != null)
              //   Text(
              //       "LAT: ${_currentPosition?.latitude}, LNG: ${_currentPosition?.longitude}"),

              //

              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ReportIncidentPage())),
                child: const Text(
                  'Send Report',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),

              const Spacer(flex: 2),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Select Category ',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  const SizedBox(height: 15.0),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                    ),
                    width: 190.0,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        iconSize: 40,
                        value: incidentValue,
                        // isExpanded: true,
                        items: incidentItem.map(buildIncidentList).toList(),
                        style: const TextStyle(
                            fontSize: 14.0, color: Colors.black),
                        onChanged: (categoryValue) {
                          setState(() {
                            this.incidentValue = categoryValue as String?;
                          });

                          // print(incidentValue);
                        },
                      ),
                    ),
                  ),
                ],
              ),

              const Spacer(
                flex: 3,
              ),

              if (_currentAddress != null)
                Text(
                  "My Current Location : ${_currentAddress!}",
                  style: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              const SizedBox(
                height: 50.0,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(40.0)),
                onPressed: incidentValue != '' && incidentValue != null
                    ? () {
                        _determinePosition();
                        _getCurrentLocation();
                        multipleSMS();
                      }
                    : null,
                child: const Icon(
                  Icons.notifications_on_outlined,
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Click to send your location',
                style: TextStyle(color: Colors.white),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    ));
  }

  multipleSMS() {
    for (var i = 0; i <= numList.length; i++) {
      sendSms(context, numList[i].toString());
    }
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  DropdownMenuItem<String> buildIncidentList(String incidentItem) =>
      DropdownMenuItem(
        value: incidentItem,
        child: Text(incidentItem),
      );
  getUserData(snapshot) {
    snapshot.data?.docs.forEach((doc) => {data = doc.data()});
  }
}
