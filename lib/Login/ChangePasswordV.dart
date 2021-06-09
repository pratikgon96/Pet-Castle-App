//This page appears when the user clicks on forget password and enters the correct OTP that is sent to the mail .He can change his password through this .
//has bugs ., commented those . will work
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AppHome.dart';
import 'package:petcastle/CustomerPages/MyDoctor.dart';
import 'package:petcastle/Login/LogInScreenV.dart';
import 'package:petcastle/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



String Email;
String newPassword;
String result;

class changePassV{

}
//changePass cp1 = new changePass();

Future<changePassV> changePasswordV() async {
  prefs = await SharedPreferences.getInstance();
  Email = await prefs.getString("username");
  //newPassword = await prefs.getString("newPassword");

  var queryParameters = {
    'key': Email,
    'key1': newPassword,

  };
  final response =
  await http.get(Uri.http('192.168.0.156:8090', '/changePassV',queryParameters));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    result = response.body;

  } else {
    throw Exception('Failed to load');
  }
}


class ChangePasswordV extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordV> {
  SharedPreferences prefs;

  TextEditingController cpControllerV = TextEditingController();

  @override
  void initState() {
    super.initState();

    saveDetails();
    //futureOtp = fetchOtp();

  }

  void saveDetails() async {
    prefs = await SharedPreferences.getInstance();
    //prefs.setString('username', username);
    //prefs.setString('password', password);
    Email = await prefs.getString("username");
    //await prefs.setString('otp', genOtp);
    print(Email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Pet castle"),
          backgroundColor: Colors.blueGrey[600],
        ),
        body: Center(
          child: Container(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
              child: SingleChildScrollView(
                  child: Form(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          TextFormField(
                              controller: cpControllerV,
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter a text';
                                } else if (value.length < 8) {
                                  return 'Password should contain >= 8 characters';
                                }
                                return null;
                              },
                              decoration: new InputDecoration(
                                  hintText: "Enter your new password")),
                        ],
                      ),
                      Column(children: [
                        Container(
                            width: 100,
                            child: RaisedButton(
                                color: Colors.blueGrey[600],
                                textColor: Colors.white,
                                onPressed: () async {
                                  prefs = await SharedPreferences.getInstance();
                                  prefs.setString('username', l1.Email);
                                  newPassword = cpControllerV.text.toString();
                                  await changePasswordV();

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => VLogIn()),
                                  );
                                },
                                child: Text('Change')))
                      ])
                    ]),
              ))),
        ));
  }
}
