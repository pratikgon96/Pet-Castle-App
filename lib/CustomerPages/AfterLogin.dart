// This is just a navigation page , there is no functionality
import 'package:flutter/material.dart';

import 'package:petcastle/CustomerPages/CustomerList.dart';

import 'package:petcastle/CustomerPages/MyProfile.dart';

import 'package:shared_preferences/shared_preferences.dart';

class AfterLogin extends StatefulWidget {
  @override
  _AfterLoginState createState() => _AfterLoginState();
}

class _AfterLoginState extends State<AfterLogin> {
  String finalEmail;
  Future getValidationData() async {
    WidgetsFlutterBinding.ensureInitialized();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var obtainedEmail = prefs.getString('username');
    setState(() {
      finalEmail = obtainedEmail;
    });
    print(finalEmail);
  }

  @override
  void initState() {
    getValidationData().whenComplete(() async {
      if (finalEmail == null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => MyProfile(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => CL(),
          ),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Container(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Welcome'),
          )),
        ),
      ),
    );
  }
}
