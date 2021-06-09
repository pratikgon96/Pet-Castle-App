//sign up for customer
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
//import 'package:mailer/mailer.dart';
//import 'package:mailer/smtp_server/gmail.dart';

import 'package:petcastle/Login/EmailVerifyC.dart';
import 'package:petcastle/Login/LogInScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:email_validator/email_validator.dart';
import 'package:toast/toast.dart';
import 'dart:math';

//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:device_info/device_info.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Random random = new Random();
int otp = random.nextInt(9000) + 1000; // from 10 upto 99 included
String genOtp = otp.toString();

//DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

String result;

class Signup {
  String Name;
  String Phno;
  String Password;
  String Email;
  String Device = "samsung";
  String Location;
  String Status = "active";
  Signup() {
    this.Name = Name;
    this.Phno = Phno;
    this.Password = Password;
    this.Email = Email;
    this.Device = Device;
    this.Location = Location;
    this.Status = Status;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Owner_name': Name,
      'Owner_email': Email,
      'Owner_password': Password,
      'Owner_phno': Phno,
      'Owner_device': Device,
      'Owner_location': Location,
      'Owner_status': Status
    };
  }

  Signup.fromJson(Map<String, dynamic> json)
      : Name = json['Owner_name'],
        Email = json['Owner_email'],
        Password = json['Owner_password'],
        Phno = json['Owner_phno'],
        Device = json['Owner_device'],
        Location = json['Owner_Location'],
        Status = json['Owner_Status'];
}

Signup s1 = new Signup();

Future<http.Response> _postData() async {
  //HttpClientRequest Response = await HttpClient().post("http://192.168.0.9", 8090, x);
  print("post id starts");
  s1.Device = "samsung";
  s1.Status = "active";
  print("hi");
  // var conv = s1.toJson();
  //var x  = s1.toJson();

  //var body2 = jsonEncode(s1);
  print(s1);
  print("=-------------------------------------------------------");
  print("values");
  print(s1.Name);
  print(s1.Password);
  var body = jsonEncode(s1);
  var url = Uri.parse("http://192.168.0.156:8090/signupowner");
  //final response = await http.Client().post("http://192.168.0.9:8080/getur2",body: json.encode("hello"));
  await http.post(url, body: body).then((http.Response response) {
    if (response.statusCode == 200) {
      result = response.body;
      print("post id done");
      return;
    }
  });
}

int test = 0;

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  Future<void> sendMail() async {
    //prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('username');
    print(email);
   // var url = "192.168.0.156";
    String host;
    int port;
   // String username = 'shadowthrone@opentrash.com';
   // String password = 'hopeless';
    String username = 'demoshouryatest@gmail.com';
    String password = 'Demo@1234';

    String receiver_email = '$email';
    print(receiver_email);
    //final smtpServer = new SmtpServer(url,username: username, password: password,port : 8090);
    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username)
      ..recipients.add(receiver_email)
      ..subject = 'YOUR OTP IS : $genOtp'
      ..html = "<h3>Thanks for connecting with us!</h3>\n<p></p>";
    try {
      final sendReport = await send(message, smtpServer);
      showToast('Message Send Check your mail',
          gravity: Toast.CENTER, duration: 3);
      print('Message sent: ' +
          sendReport.toString()); //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n' +
          e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
  }

  void _submit() async {
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      test = 1;
      //await _postData();
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => LogIn()),
      // );
    }
    _formKey.currentState.save();
  }

  TextEditingController fullNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _obscureText = false;
  SharedPreferences prefs;

  var cities = ["Hyderabad", "Bangalore", "Delhi"];
  var _city = "Bangalore";

  @override
  void initState() {
    super.initState();
    saveDetails();
  }

  void saveDetails() async {
    prefs = await SharedPreferences.getInstance();
    //prefs.setString('username', username);
    //prefs.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign up as customer'),
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
                SizedBox(
                  height: 80,
                ),
                Column(
                  children: [
                    TextFormField(
                        controller: fullNameController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length < 5) {
                            return 'Name should be greater than 5 characters';
                          }

                          s1.Name = value;
                          // print(s1.Name);
                          return null;
                        },
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.person_pin_rounded),
                            hintText: "Enter your full name")),
                    TextFormField(
                        controller: phoneNumberController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length != 10) {
                            return 'Phone number should be 10 digits only';
                          }
                          s1.Phno = value;
                          return null;
                        },
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.phone_rounded),
                            hintText: "Enter your phone number ")),
                    TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          const pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
                          final regExp = RegExp(pattern);

                          if (!regExp.hasMatch(value)) {
                            return 'Please enter valid email';
                          } else if (value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length < 5) {
                            return 'Email should be greater than 5 characters';
                          }
                          s1.Email = value;
                          return null;
                        },
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.email_outlined),
                            hintText: "Enter your email address")),
                    TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length < 8) {
                            return 'Password should be greater than 8 characters';
                          } else if (value != confirmPasswordController.text) {
                            return 'Password and confirm password are not same';
                          }
                          s1.Password = value;
                          return null;
                        },
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: "Enter your password")),
                    TextFormField(
                      controller: confirmPasswordController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter password';
                        } else if (value.length < 8) {
                          return 'Password should be greater than 8 characters';
                        } else if (value != passwordController.text) {
                          return 'Password and confirm password are not same';
                        }

                        return null;
                      },
                      obscureText: _obscureText,
                      decoration: new InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: "Confirm your Password"),
                    ),
                    DropdownButtonFormField(
                      items: cities.map((String city) {
                        return new DropdownMenuItem(
                            value: city,
                            child: Row(
                              children: <Widget>[
                                Text(city),
                              ],
                            ));
                      }).toList(),
                      onChanged: (newValue) {
                        //s1.Location = newValue;
                        s1.Location = newValue;
                        setState(() => _city = newValue);
                      },
                      value: _city,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        prefixIcon: Icon(Icons.location_on),
                        hintText: "Choose city",
                      ),
                    )
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
                          s1.Name = fullNameController.text.toString();
                          s1.Email = emailController.text.toString();
                          s1.Password = passwordController.text.toString();
                          s1.Phno = phoneNumberController.text.toString();
                          s1.Location = _city;
                          //l1.Email = usernameController.text.toString();
                          //l1.Password =passwordController.text.toString();
                          await prefs.setString('username', s1.Email);
                          await prefs.setString('otp', genOtp);
                          await sendMail();
                          //prefs = await SharedPreferences.getInstance();
                          await _submit();
                          if (test == 1) {
                            await _postData();

                            print("entered post");
                            // _getData();
                            // print("entered get ");
                            if (result == "yes") {
                              //l1.Email = usernameController.text;
                              //l1.Password = passwordController.text;
                              bool userFound = true;

                              if (userFound) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EmailC()),
                                );
                              }
                            }
                            if (test == 1) {
                              if (result == "no") {
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
                                          "An account exists with this username . Please login ."),
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
                            }
                          }
                        },
                        color: Colors.blueGrey[600],
                        child: Text(
                          'Register',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 48.0),
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Already have an account?",
                            style: TextStyle(color: Colors.blueGrey[600])),
                      ),
                    ),
                    Container(
                      width: 100,
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Colors.blueGrey[600],
                        child: Text(
                          'Login',
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
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

   void showToast(String msg, {int duration, int gravity}) {
     Toast.show(msg, context, duration: duration, gravity: gravity);
   }
}
