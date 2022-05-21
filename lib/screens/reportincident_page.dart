import 'dart:io';

import 'package:esalakanmi/controllers/database_controller.dart';
import 'package:esalakanmi/controllers/storage_services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';
import 'package:geocoding/geocoding.dart';

class ReportIncidentPage extends StatefulWidget {
  const ReportIncidentPage({Key? key}) : super(key: key);

  @override
  State<ReportIncidentPage> createState() => _ReportIncidentPageState();
}

class _ReportIncidentPageState extends State<ReportIncidentPage> {
  String? incidentValue;
  String desc = '';

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
  var d;

  Position? _currentPosition;
  String? _currentAddress;

  DateTime dateTime = DateTime.now();
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  Storage storage = Storage();

  Future captureImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print(e);
    }
  }

  TimeOfDay? time;
  @override
  Widget build(BuildContext context) {
    final fileName = image != null ? basename(image!.path) : "No File Selected";

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'e-SalakanMi',
            style: TextStyle(fontSize: 20.0),
          ),
          backgroundColor: Colors.blue[900],
          elevation: 0.0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: StreamBuilder<Object>(
                stream: null,
                builder: (context, snapshot) {
                  return Column(
                    children: [
                      const SizedBox(height: 20.0),
                      Text(
                        'Report Incident',
                        style: TextStyle(
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900],
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      TextFormField(
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                              ),
                              borderRadius: BorderRadius.circular(20.0)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(5.5),
                          ),
                          fillColor: Colors.grey[300],
                          filled: true,
                          border: InputBorder.none,
                          hintText: "Incident Report Description",
                          hintStyle: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                          ),
                        ),
                        validator: (value) => value != null && value.isEmpty
                            ? "Please enter a note"
                            : null,
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.5,
                        ),
                        onChanged: (_val) {
                          desc = _val;
                        },
                      ),

                      const SizedBox(
                        height: 20.0,
                      ),
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
                            const Text("Category"),
                            SizedBox(
                              width: 190.0,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton(
                                  iconSize: 40,
                                  value: incidentValue,
                                  // isExpanded: true,
                                  items: incidentItem
                                      .map(buildIncidentList)
                                      .toList(),
                                  style: const TextStyle(
                                      fontSize: 14.0, color: Colors.black),
                                  onChanged: (categoryValue) {
                                    setState(() {
                                      this.incidentValue =
                                          categoryValue as String?;
                                    });

                                    // print(incidentValue);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
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
                        height: 20.0,
                      ),

                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 20.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0))),
                        onPressed: () async {
                          final initialTime = TimeOfDay.now();
                          final newTime = await showTimePicker(
                            context: context,
                            initialTime: time ?? initialTime,
                          );

                          if (newTime == null) return;

                          setState(() {
                            time = newTime;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            time != null
                                ? Text(
                                    '${time?.hour.toString().padLeft(2, '0')}: ${time?.minute.toString().padLeft(2, '0')} ${time?.period.name.toUpperCase()}',
                                    style: const TextStyle(color: Colors.black),
                                  )
                                : const Text(
                                    'hr / min / period',
                                    style: TextStyle(color: Colors.black),
                                  ),
                            const Icon(
                              Icons.schedule_outlined,
                              color: Colors.black,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height * 0.08,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () => pickImage(),
                          child: const Text('Select Image'),
                        ),
                      ),

                      const SizedBox(height: 20.0),
                      // Capture Image
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () => captureImage(),
                          child: const Text('Capture Image'),
                        ),
                      ),

                      const SizedBox(height: 20.0),
                      // Image Container
                      image != null
                          ? SizedBox(
                              height: 250,
                              width: 150,
                              // color: Colors.orange,
                              child: image != null ? Image.file(image!) : null,
                            )
                          : Container(),
                      const SizedBox(height: 20.0),
                      //  Report
                      // Text('${FirebaseAuth.instance.currentUser?.email}'),
                      // Text("${_currentPosition?.altitude}"),
                      // Text("${_currentPosition?.latitude}"),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.blue[900],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: incidentValue != null &&
                                  incidentValue != '' &&
                                  d != null &&
                                  time != null
                              ? () async {
                                  // _getCurrentLocation();
                                  _determinePosition(context);

                                  if (image == null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('No Files Selected'),
                                      ),
                                    );
                                  }
                                  final path = image!.path;

                                  final resTime =
                                      '${time?.hour.toString().padLeft(2, '0')}: ${time?.minute.toString().padLeft(2, '0')} ${time?.period.name.toUpperCase()}';

                                  DatabaseController databaseController =
                                      DatabaseController();

                                  if (_currentPosition?.latitude != null &&
                                      _currentPosition?.longitude != null) {
                                    databaseController.myReport(
                                      FirebaseAuth.instance.currentUser?.email,
                                      desc,
                                      incidentValue,
                                      d,
                                      resTime,
                                      _currentPosition?.altitude,
                                      _currentPosition?.latitude,
                                    );

                                    databaseController.incidentReport(
                                      FirebaseAuth.instance.currentUser?.email,
                                      desc,
                                      incidentValue,
                                      d,
                                      resTime,
                                      _currentPosition?.altitude,
                                      _currentPosition?.latitude,
                                    );
                                    storage
                                        .uploadFile(path, fileName)
                                        .then((value) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text('Uploaded Successfully'),
                                      ));
                                    });
                                    Navigator.of(context).pop();
                                  }
                                }
                              : null,
                          child: const Text('REPORT'),
                        ),
                      ),
                      const SizedBox(height: 50.0)
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  DropdownMenuItem<String> buildIncidentList(String incidentItem) =>
      DropdownMenuItem(
        value: incidentItem,
        child: Text(incidentItem),
      );

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

  _determinePosition(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error(
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location services are disabled.'),
          ),
        ),
      );
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
        return Future.error(
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Location permissions are denied'),
            ),
          ),
        );
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.

      return Future.error(
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Location permissions are permanently denied, we cannot request permissions.'),
          ),
        ),
      );
    }
    if (permission == LocationPermission.unableToDetermine) {
      return Future.error(
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to determine'),
          ),
        ),
      );
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    });
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
}
