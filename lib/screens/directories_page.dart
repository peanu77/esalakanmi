import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../controllers/controller.dart';
import '../controllers/directories_widget.dart';
import '../controllers/title_widget.dart';

class DirectoriesPage extends StatefulWidget {
  const DirectoriesPage({Key? key}) : super(key: key);

  @override
  State<DirectoriesPage> createState() => _DirectoriesPageState();
}

class _DirectoriesPageState extends State<DirectoriesPage> {
  List numList = [
    "0915-5137-245",
    "0908-9673-034",
    "(072) 607-3095",
    "0915-934-8187",
    "(072) 607-5472",
    "0949-472-4161",
    "0919-546-1800",
    "0908-8863-716",
    "(072) 607-4044",
    "(072) 607-5453",
    "0915-6126-735",
    "0915-6024-072",
    "0928-5203-893",
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Municipality of Bacnotan',
          style: TextStyle(
            color: Colors.blue[900],
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.chevron_left, color: Colors.grey[600]),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              settingsLabelWidget(
                title: "Police Department",
                width: 0.0,
                height: 0.0,
                fontSize: 20.0,
                fontColor: Colors.grey[700],
                fontWeight: FontWeight.w400,
                letterSpacing: 1.0,
              ),
              const SizedBox(height: 20.0),
              TextButton(
                style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(0.0)),
                onPressed: () => launchPhoneCall('tel: ${numList[0]}'),
                child: directoriesWidget(
                  title: "Globe : ${numList[0]}",
                  cardColor: Colors.grey[100],
                  icon: FaIcon(
                    FontAwesomeIcons.phone,
                    color: Colors.grey[600],
                  ),
                  size: size,
                  context: context,
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(0.0)),
                onPressed: () => launchPhoneCall('tel: ${numList[1]}'),
                child: directoriesWidget(
                  title: "Smart : ${numList[1]}",
                  cardColor: Colors.grey[100],
                  icon: FaIcon(
                    FontAwesomeIcons.phone,
                    color: Colors.grey[600],
                  ),
                  size: size,
                  context: context,
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(0.0)),
                onPressed: () => launchPhoneCall('tel: ${numList[2]}'),
                child: directoriesWidget(
                  title: "Tel : ${numList[2]}",
                  cardColor: Colors.grey[100],
                  icon: FaIcon(
                    FontAwesomeIcons.phone,
                    color: Colors.grey[600],
                  ),
                  size: size,
                  context: context,
                ),
              ),
              const SizedBox(height: 20.0),
              settingsLabelWidget(
                title: "Fire Department",
                width: 0.0,
                height: 0.0,
                fontSize: 20.0,
                fontColor: Colors.grey[700],
                fontWeight: FontWeight.w400,
                letterSpacing: 1.0,
              ),
              const SizedBox(height: 10.0),
              TextButton(
                style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(0.0)),
                onPressed: () => launchPhoneCall('tel: ${numList[3]}'),
                child: directoriesWidget(
                  title: "Smart : ${numList[3]}",
                  cardColor: Colors.grey[100],
                  icon: FaIcon(
                    FontAwesomeIcons.phone,
                    color: Colors.grey[600],
                  ),
                  size: size,
                  context: context,
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(0.0)),
                onPressed: () => launchPhoneCall('tel: ${numList[4]}'),
                child: directoriesWidget(
                  title: "Tel : ${numList[4]}",
                  cardColor: Colors.grey[100],
                  icon: FaIcon(
                    FontAwesomeIcons.phone,
                    color: Colors.grey[600],
                  ),
                  size: size,
                  context: context,
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(0.0)),
                onPressed: () => launchPhoneCall('tel: ${numList[3]}'),
                child: directoriesWidget(
                  title: "Smart : ${numList[3]}",
                  cardColor: Colors.grey[100],
                  icon: FaIcon(
                    FontAwesomeIcons.phone,
                    color: Colors.grey[600],
                  ),
                  size: size,
                  context: context,
                ),
              ),
              const SizedBox(height: 20.0),
              settingsLabelWidget(
                title: "Bacnotan District Hospital",
                width: 0.0,
                height: 0.0,
                fontSize: 20.0,
                fontColor: Colors.grey[700],
                fontWeight: FontWeight.w400,
                letterSpacing: 1.0,
              ),
              const SizedBox(height: 10.0),
              TextButton(
                style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(0.0)),
                onPressed: () => launchPhoneCall('tel: ${numList[4]}'),
                child: directoriesWidget(
                  title: "Smart : ${numList[4]}",
                  cardColor: Colors.grey[100],
                  icon: FaIcon(
                    FontAwesomeIcons.phone,
                    color: Colors.grey[600],
                  ),
                  size: size,
                  context: context,
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(0.0)),
                onPressed: () => launchPhoneCall('tel: ${numList[5]}'),
                child: directoriesWidget(
                  title: "Tel : ${numList[5]}",
                  cardColor: Colors.grey[100],
                  icon: FaIcon(
                    FontAwesomeIcons.phone,
                    color: Colors.grey[600],
                  ),
                  size: size,
                  context: context,
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(0.0)),
                onPressed: () => launchPhoneCall('tel: ${numList[6]}'),
                child: directoriesWidget(
                  title: "Tel : ${numList[6]}",
                  cardColor: Colors.grey[100],
                  icon: FaIcon(
                    FontAwesomeIcons.phone,
                    color: Colors.grey[600],
                  ),
                  size: size,
                  context: context,
                ),
              ),
              const SizedBox(height: 20.0),
              settingsLabelWidget(
                title: "Luelco - Bacnotan",
                width: 0.0,
                height: 0.0,
                fontSize: 20.0,
                fontColor: Colors.grey[700],
                fontWeight: FontWeight.w400,
                letterSpacing: 1.0,
              ),
              const SizedBox(height: 10.0),
              TextButton(
                style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(0.0)),
                onPressed: () => launchPhoneCall('tel: ${numList[7]}'),
                child: directoriesWidget(
                  title: "Globe : ${numList[7]}",
                  cardColor: Colors.grey[100],
                  icon: FaIcon(
                    FontAwesomeIcons.phone,
                    color: Colors.grey[600],
                  ),
                  size: size,
                  context: context,
                ),
              ),
              const SizedBox(height: 10.0),
              TextButton(
                style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(0.0)),
                onPressed: () => launchPhoneCall('tel: ${numList[8]}'),
                child: directoriesWidget(
                  title: "Globe : ${numList[8]}",
                  cardColor: Colors.grey[100],
                  icon: FaIcon(
                    FontAwesomeIcons.phone,
                    color: Colors.grey[600],
                  ),
                  size: size,
                  context: context,
                ),
              ),
              const SizedBox(height: 20.0),
              settingsLabelWidget(
                title: "MSWD",
                width: 0.0,
                height: 0.0,
                fontSize: 20.0,
                fontColor: Colors.grey[700],
                fontWeight: FontWeight.w400,
                letterSpacing: 1.0,
              ),
              const SizedBox(height: 10.0),
              TextButton(
                style: TextButton.styleFrom(
                    splashFactory: NoSplash.splashFactory,
                    padding: const EdgeInsets.all(0.0)),
                onPressed: () => launchPhoneCall('tel: ${numList[9]}'),
                child: directoriesWidget(
                  title: "Globe : ${numList[9]}",
                  cardColor: Colors.grey[100],
                  icon: FaIcon(
                    FontAwesomeIcons.phone,
                    color: Colors.grey[600],
                  ),
                  size: size,
                  context: context,
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
