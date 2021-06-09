import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AddMorePet.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/OwnerEditProfile.dart';

import '../main.dart';

SharedPreferences prefs;
String Email;
var result;
String S,P;

class DispOwn {
  final String Name;
  final String Email;
  final String Phno;
  final String Location;

  DispOwn({@required this.Name, @required this.Email, @required this.Phno, @required this.Location});

  factory DispOwn.fromJson(Map<String, dynamic> json) {
    return DispOwn(
      Name: json['Owner_name'],
      Email: json['Owner_email'],
      Phno: json['Owner_phno'],
      Location: json['Owner_location'],
    );
  }
}

Future<DispOwn> fetchProfile() async {
  prefs = await SharedPreferences.getInstance();
  print("entered preferenes");
  // await DartArr.clear();
  Email = await prefs.getString("username");
  print(Email);
  var queryParameters = {
    'key': Email,

  };
  //var body = Email;
  final response =
  await http.get(Uri.http('192.168.0.156:8090', '/dispown',queryParameters));
  // final response =
  // await http.get(Uri.parse("http://192.168.0.156:8090/dispOwner"));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    result = response.body;
    return DispOwn.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
Future<void> delOwner() async {
  prefs = await SharedPreferences.getInstance();
  Email = await prefs.getString("username");
  //newPassword = await prefs.getString("newPassword");

  var queryParameters = {
    'key': Email,
  };
  final response =
  await http.get(Uri.http('192.168.0.156:8090', '/delowner',queryParameters));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    result = response.body;

  } else {
    throw Exception('Failed to load');
  }
}
  class ViewProfile extends StatefulWidget {
    ViewProfile({Key key}) : super(key: key);
  @override
  _ViewProfileState createState() => _ViewProfileState();
  }
class _ViewProfileState extends State<ViewProfile> {

  // SharedPreferences prefs;
  // String finalEmail;
  // String finalPhone;
  // String finalName;
  // String finalCity;
  // Future customerData() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var custEmail = prefs.getString('customeremail')?? "Not printing yet";
  //   var custPhone = prefs.getString('customerphone')?? "Not printing yet";
  //   var custName = prefs.getString('customername')?? "Not printing yet";
  //   var custCity = prefs.getString('customercity')?? "Not printing yet";
  //   setState(() {
  //     finalEmail = custEmail;
  //     finalName = custName;
  //     finalPhone = custPhone;
  //     finalCity = custCity;
  //   });
  //   print(finalEmail);
  //   print(finalPhone);
  //   print(finalName);
  // }
  Future<DispOwn> futureDispOwn;

  @override
  void initState() {
    super.initState();

    futureDispOwn = fetchProfile();
    //initiatePreferences();
  }


  void initiatePreferences() async {
    prefs = await SharedPreferences.getInstance();
    print("entered preferenes");
    // await DartArr.clear();
    Email = await prefs.getString("username");
    print(Email);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF546E7A),
        title: Text('My Profile', style: TextStyle(fontSize: 15)),
      ),

      body: Column(

        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: new Card(
              elevation: 10,
              color: Colors.blueGrey[100],
              child: Container(
                width: 380,
                height: 250,
                //child: Row(
                //children: [
                // Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),

                child: FutureBuilder<DispOwn>(
                  future: futureDispOwn,

                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      S = snapshot.data.Name;
                      P = snapshot.data.Phno;
                      print("profile is on process");
                      return ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Card(
                                elevation: 10,
                                color: Colors.blueGrey[100],
                                child: Container(
                                  width: 380,
                                  height: 250,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 0),
                                        child: Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Full Name =>  ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 12),
                                                  ),
                                                  Text (
                                                    (snapshot.data.Name)
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Email Id =>  ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    (snapshot.data.Email)
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'Phone Number =>  ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    (snapshot.data.Phno)
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(
                                                  8.0),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'City =>  ',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 12),
                                                  ),
                                                  Text(
                                                    (snapshot.data.Location)
                                                        .toString(),
                                                    style: TextStyle(
                                                        fontWeight: FontWeight
                                                            .bold,
                                                        fontSize: 12),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      );
                      // var send = 'Name :- ' +snapshot.data.Name+'\n\n Email :-  ' +snapshot.data.Email+ '\n\n Phone Number :- ' +snapshot.data.Phno+ '\n\n City :- ' +snapshot.data.Location;
                      //
                      // return Text("${send}");

                      //return Text(snapshot.data.Name);

                      //return Text(snapshot.data.Name);
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }

                    // By default, show a loading spinner.
                    return CircularProgressIndicator();
                  },

                ),

              ),
            ),
          ),
          FlatButton(
              onPressed: () async{
                prefs = await SharedPreferences.getInstance();
                prefs.setString('name', S);
                prefs.setString('Phone', P);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => OwnerEditProfile()),
                );
              },
              child: Text(
                'Edit',
                style: TextStyle(decoration: TextDecoration.underline),
              )),
          FlatButton(
              onPressed: () async{
                await delOwner();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyStatefulWidget()),
                );
              },
              child: Text(
                'Delete Profile',
                style: TextStyle(decoration: TextDecoration.underline),
              )),

        ],
      ),
    );


    // SharedPreferences prefs;
  }


}

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       backgroundColor: Color(0xFF546E7A),
  //       title: const Text('Pet Castle'),
  //     ),
  //     body: Container(
  //         child: Column(
  //           //mainAxisAlignment: MainAxisAlignment.center,
  //           children: <Widget>[
  //             Padding(
  //               padding: const EdgeInsets.all(8.0),
  //               child: Container(
  //                 child: Column(
  //                   children: [
  //                     new Card(
  //                       elevation: 10,
  //                       color: Colors.blueGrey[100],
  //                       child: Container(
  //                         width: 380,
  //                         height: 200,
  //                         child: Row(
  //                           children: [
  //                             Padding(
  //                               padding: const EdgeInsets.symmetric(
  //                                   vertical: 0, horizontal: 0),
  //                               child: Column(
  //                                 mainAxisAlignment:
  //                                     MainAxisAlignment.spaceEvenly,
  //                                 crossAxisAlignment: CrossAxisAlignment.center,
  //                                 children: [
  //                                   Padding(
  //                                     padding: const EdgeInsets.all(8.0),
  //                                     child: Row(
  //                                       children: [
  //                                         Text(
  //                                           'Name =>  ',
  //                                           style: TextStyle(
  //                                               fontWeight: FontWeight.bold,
  //                                               fontSize: 12),
  //                                         ),
  //                                         Text(
  //                                           finalName,
  //                                           style: TextStyle(
  //                                               fontWeight: FontWeight.bold,
  //                                               fontSize: 12),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   Padding(
  //                                     padding: const EdgeInsets.all(8.0),
  //                                     child: Row(
  //                                       children: [
  //                                         Text(
  //                                           'Phone =>  ',
  //                                           style: TextStyle(
  //                                               fontWeight: FontWeight.bold,
  //                                               fontSize: 12),
  //                                         ),
  //                                         Text(
  //                                           finalPhone,
  //                                           style: TextStyle(
  //                                               fontWeight: FontWeight.bold,
  //                                               fontSize: 12),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   Padding(
  //                                     padding: const EdgeInsets.all(8.0),
  //                                     child: Row(
  //                                       children: [
  //                                         Text(
  //                                           'Email =>  ',
  //                                           style: TextStyle(
  //                                               fontWeight: FontWeight.bold,
  //                                               fontSize: 12),
  //                                         ),
  //                                         Text(
  //                                           finalEmail,
  //                                           style: TextStyle(
  //                                               fontWeight: FontWeight.bold,
  //                                               fontSize: 12),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                   Padding(
  //                                     padding: const EdgeInsets.all(8.0),
  //                                     child: Row(
  //                                       children: [
  //                                         Text(
  //                                           'City =>  ',
  //                                           style: TextStyle(
  //                                               fontWeight: FontWeight.bold,
  //                                               fontSize: 12),
  //                                         ),
  //                                         Text(
  //                                           finalCity,
  //                                           style: TextStyle(
  //                                               fontWeight: FontWeight.bold,
  //                                               fontSize: 12),
  //                                         ),
  //                                       ],
  //                                     ),
  //                                   ),
  //                                 ],
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                     FlatButton(
  //                       onPressed: () {},
  //                       child: Text(
  //                         'Edit?',
  //                         style: TextStyle(
  //                             fontSize: 12,
  //                             decoration: TextDecoration.underline,
  //                             color: Colors.blueGrey[600]),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //             )
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
