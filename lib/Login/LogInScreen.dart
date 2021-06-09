//Login page for customer
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AfterLogin.dart';
import 'package:petcastle/Login/ForgotPasswordOTP.dart';
import 'package:petcastle/Login/SignUpScreen.dart';
import 'package:petcastle/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


SharedPreferences prefs;
String Email;
String Otpnew;

String result;
class Login{
  String Email;
  String Password;
  Login(){
    this.Email = Email;
    this.Password = Password;
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{

      'Email': Email,
      'Password': Password
    };
  }
  Login.fromJson(Map<String, dynamic> json)
      :
        Email = json['Email'],
        Password = json['Password'];


}
Login l1 = new Login();
// void  _getData() async {
//   var url ="http://192.168.0.156:8090/login";
//   final response = await http.get(url);
//   result = response.body;
//   //response.body.Close();
//   print("the result is");
//   print(result);



class Otp{
  // final String otp;
  // final String Email;
  // Otp({@required this.otp, @required this.Email});
  //
  // factory Otp.fromJson(Map<String, dynamic> json) {
  //   return Otp(
  //     Email: "gon.pratik@gmail.com",
  //     otp: "1234",
  //   );
  // }



}

Future<http.Response> _postData()  async {
  print("post id starts");

  var body = jsonEncode(l1);
  var url = Uri.parse("http://192.168.0.156:8090/loginowner");
  //final response = await http.Client().post("http://192.168.0.9:8080/login",body: json.encode("hello"));
  await http.post(url, body: body ).then((http.Response response) {
    if (response.statusCode == 200) {
      print("----------------------------------------------------------");
      print(" jsafjdsfkjdshgkjfdkg " +response.body);
      result = response.body;
      print("post id done");
      return ;
    }

  });

}

Future<Otp> fetchOtp() async {
  prefs = await SharedPreferences.getInstance();
  Email = await prefs.getString("username");
  Otpnew = await prefs.getString("otp");

  var queryParameters = {
    'key': Email,
    'key1': Otpnew,

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
    throw Exception('Failed to load album');
  }
}


class LogIn extends StatefulWidget {
  @override
  _LogInState createState() => _LogInState();
}


class _LogInState extends State<LogIn> {
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
    int otp = random.nextInt(9000) + 1000; // from 10 upto 99 included
    String genOtp = otp.toString();
    Email = await prefs.getString("username");
    await prefs.setString('otp', genOtp);
    print(Email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pet castle"),
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
                      'Login as a customer',
                      style:
                          TextStyle(fontSize: 24, color: Colors.blueGrey[600]),
                    ),
                    height: 100,
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
                          l1.Email = usernameController.text;
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
                          l1.Password = passwordController.text;

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
                     
                      child:RaisedButton(
                        onPressed: () async {

                          l1.Email = usernameController.text.toString();
                          l1.Password =passwordController.text.toString();


                         await  _postData();
                          print("entered post");
                         // _getData();
                         // print("entered get ");
                          if (result == "yes") {
                            //l1.Email = usernameController.text;
                            //l1.Password = passwordController.text;
                            print(l1.Email);
                            prefs.setString("username", l1.Email);
                            print("set username");
                            print(prefs.getString("username"));
                            bool userFound = true;

                            if (userFound) {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyStatefulWidget()),
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
                                        "There is no account with this username . Please SignUp"),
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
                      ,
                        color: Colors.blueGrey[600],
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: FlatButton(
                          child: Text(
                            'Forgot Password?',
                            style:
                                TextStyle(decoration: TextDecoration.underline),
                          ),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 100.0),
                      child: TextButton(
                        onPressed: () {},
                        child: Text("Don't have an account?",
                            style: TextStyle(color: Colors.blueGrey[600])),
                      ),
                    ),
                    Container(
                      width: 100,
                      
                      child: RaisedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpScreen()),
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