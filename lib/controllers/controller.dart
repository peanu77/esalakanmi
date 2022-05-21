import 'package:url_launcher/url_launcher.dart';

Future<void> launchUrl(url) async {
  if (await canLaunch(url)) {
    await launch(url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'headers_key': 'headers_value'});
  }
}

Future<void> launchPhoneCall(String num) async {
  if (await canLaunch(num)) {
    await launch(num);
  } else {
    throw 'There is an error launching $num';
  }
}
