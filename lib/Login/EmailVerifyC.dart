//email verification through otp for vendor
//to be done(function)
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AppHome.dart';
import 'package:petcastle/Login/ChangePassword.dart';
import 'package:petcastle/Login/SignUpScreen.dart';
import 'package:petcastle/Login/verifyotp.dart';
import 'package:petcastle/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class EmailC extends StatefulWidget {
  @override
  _EmailCState createState() => _EmailCState();
}

class _EmailCState extends State<EmailC> {
  final _formKey = GlobalKey<FormState>();
  SharedPreferences prefs;
  TextEditingController otpController = TextEditingController();
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
        title: Text("Pet castle"),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Text(
                      'OTP VERIFICATION',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueGrey[600]),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                          'We have sent the OTP to your email , please enter it below '),
                    ),
                  ),
                   Padding(
                     padding: const EdgeInsets.all(50.0),
                     child: PinEntryTextField(
                      showFieldAsBox: true,
                       onSubmit: (String pin) async {
                        print('this is entered otp');
                  //     //
                        prefs.setString('enteredotp', pin.toString());
                  //     //   Navigator.push(context,
                  //     //       MaterialPageRoute(builder: (context) => vOTP()));
                       }, // end onSubmit
                    ),
                   ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: RaisedButton(
                      child: Text('Continue'),
                      textColor: Colors.white,
                      color: Colors.blueGrey[600],
                      onPressed: () async {
                        String Otp = prefs.getString("otp");
                            print(Otp);
                        String enteredOTP = prefs.getString('enteredotp');
                             print(enteredOTP);
                             bool userFound = false;
                             if (enteredOTP == Otp) {
                               userFound = true;
                             }
                             if (userFound == true) {
                               Navigator.pushReplacement(
                                   context,
                                   MaterialPageRoute(
                                       builder: (context) =>
                                           MyStatefulWidget()));
                             } else {
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
                                     content:
                                     Text("Invalid OTP Please try again"),
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: FlatButton(
                      child: Text('Resend OTP'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ), // end PinEntryTextField()
            ), // end Padding()
          ),
        ),
      ),
    );
  }
}
