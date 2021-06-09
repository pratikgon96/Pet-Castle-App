//forgot password from login
//bugs are there , commented those , willl work
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AppHome.dart';
import 'package:petcastle/Login/ChangePassword.dart';
import 'package:petcastle/Login/ChangePasswordV.dart';
import 'package:petcastle/Login/verifyotp.dart';
import 'package:petcastle/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class FPOTP extends StatefulWidget {
  @override
  _FPOTPState createState() => _FPOTPState();
}

class _FPOTPState extends State<FPOTP> {
  SharedPreferences prefs;

  TextEditingController otpController = TextEditingController();
  @override
  void initState() {

    super.initState();
    initiatePreferences();
  }
  void initiatePreferences() async {
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
                        //print('this is entered otp $pin');

                        prefs.setString('enteredotp', pin.toString());
                        // Navigator.push(context,
                        //     MaterialPageRoute(builder: (context) => vOTP()));
                      }, // end onSubmit
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: RaisedButton(
                      child: Text('Continue'),
                      textColor: Colors.white,
                      color: Colors.blueGrey[600],
                      onPressed: () {
                        String enteredOTP = prefs.getString('enteredotp');
                        String Otp = prefs.getString("otp");
                        String OtpV = prefs.getString("otpV");
                        print(Otp);
                        print(enteredOTP);
                        if(enteredOTP == Otp) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePassword()));
                        }
                        else if(enteredOTP == OtpV){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChangePasswordV()));
                        }
                        else{
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
                      },
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
