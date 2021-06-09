//Login page for Vendor
import 'package:flutter/material.dart';

import 'package:petcastle/Login/ForgotPasswordOTP.dart';

import 'package:petcastle/Login/SignUpScreenV.dart';
import 'package:petcastle/VendorPages/VendorHome.dart';

import 'package:shared_preferences/shared_preferences.dart';
//import 'package:petcastle/CustomerPages/AfterLogin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


SharedPreferences prefs;
String Email;
String OtpnewV;

class Login{
  String Email;
  String Password;
  String Type;
  Login(){
    this.Email = Email;
    this.Password = Password;
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{

      'Email': Email,
      'Password': Password,
      'Vendor_service_type' : Type
    };
  }
  Login.fromJson(Map<String, dynamic> json)
      :
        Email = json['Email'],
        Password = json['Password'],
        Type  = json ['Vendor_service_type'];


}
Login l1 = new Login();
// void  _getData() async {
//   var url ="http://192.168.0.9:8090/login";
//   final response = await http.get(url);
//   result = response.body;
//   //response.body.Close();
//   print("the result is");
//   print(result);
//
//
// }
Future<http.Response> _postData()  async {
  print("post id starts");

  var body = jsonEncode(l1);
  var url = Uri.parse("http://192.168.0.156:8090/loginvendor");
  //final response = await http.Client().post("http://192.168.0.9:8080/login",body: json.encode("hello"));
  await http.post(url, body: body ).then((http.Response response) {
    if (response.statusCode == 200) {
      print("----------------------------------------------------------");
      print(" jsafjdsfkjdshgkjfdkg " +response.body);

      result = response.body;
      var result2 = result.split(",");
      result = result2[0];
      l1.Type = result2[1];
      

      print("post id done");
      return ;
    }

  });


}

class Otp{

}

Future<Otp> fetchOtp() async {
  prefs = await SharedPreferences.getInstance();
  Email = await prefs.getString("username");
  OtpnewV = await prefs.getString("otpV");

  var queryParameters = {
    'key': Email,
    'key1': OtpnewV,

  };
  final response =
  await http.get(Uri.http('192.168.0.156:8090', '/sendotp',queryParameters));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    result = response.body;

  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load');
  }
}


class VLogIn extends StatefulWidget {
  @override
  _VLogInState createState() => _VLogInState();
}

class _VLogInState extends State<VLogIn> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = false;
  SharedPreferences prefs;
  String username = "";
  String password = "";

  @override
  void initState() {
    super.initState();
    initiatePreferences();
  }

  void initiatePreferences() async {
    prefs = await SharedPreferences.getInstance();
    final givenUsername = prefs.getString('username') ?? '';
    final givenPassword = prefs.getString('password') ?? '';
    setState(() {
      username = givenUsername;
      password = givenPassword;
    });
    int otpV = random.nextInt(9000) + 1000; // from 10 upto 99 included
    String genOtpV = otpV.toString();
    Email = await prefs.getString("username");
    await prefs.setString('otpV', genOtpV);
    print(Email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet Castle"),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 32),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                  Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: SizedBox(
                    child: Text(
                      'Login as a vendor',
                      style:
                          TextStyle(fontSize: 24, color: Colors.blueGrey[600]),
                    ),
                    height: 120,
                  ),
                ),
                
                Column(
                  children: [
                    TextFormField(
                        controller: usernameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length < 5) {
                            return 'Name should be greater than 5 characters';
                          }
                          return null;
                        },
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: "Enter your username")),
                    TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter password';
                          }
                          return null;
                        },
                        obscureText: true,
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: "Enter your password")),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    Container(
                      width: 100,
                      
                      child: RaisedButton(
                        onPressed: () async {

                          l1.Email = usernameController.text.toString();
                          l1.Password =passwordController.text.toString();

                          await  _postData();
                          print(l1.Type);
                          prefs.setString("service_type", l1.Type);
                          print("getting"+prefs.get("service_type"));
                          print("entered  post");
                          // _getData();
                          print(result);
                          // print("entered get ");
                          if (result == "yes") {
                            //l1.Email = usernameController.text;
                            //l1.Password = passwordController.text;
                            bool userFound = true;


                            prefs.setString("username", l1.Email);
                            if (userFound) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyStatefulWidget2()),
                              );
                            }
                          } if(result == "no") {
                            showDialog(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Icon(
                                    Icons.error,
                                    color: Colors.red,
                                    size: 50,
                                  ),
                                  content: Text(
                                      "Invalid username or password. you need to sign up"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Ok"))
                                  ],
                                );
                              },
                            );
                          }
                        },
                        color: Colors.blueGrey[600],
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    FlatButton(
                        child: Text('Forgot Password?',
                          style: TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.underline)),
                        onPressed: () async{
                          l1.Email = usernameController.text.toString();
                          prefs = await SharedPreferences.getInstance();
                          prefs.setString('username', l1.Email);
                          await fetchOtp();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => FPOTP()),
                          );
                        }),
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: TextButton(
                        onPressed: () {},
                        child: Text(
                          "Don't have an account?",
                          style: TextStyle(color: Colors.blueGrey[600]),
                        ),
                      ),
                    ),
                    Container(
                      width: 100,
                      
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreenV()),
                          );
                        },
                        color: Colors.blueGrey[600],
                        child: Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-forma
    );
  }
}