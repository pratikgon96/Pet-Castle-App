//on clicking profile from profile icon , this page is opened .This contains vendor profile , his details and his clinic details etc .
//yet to be done
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:petcastle/Login/SignUpScreenV.dart';
import 'package:petcastle/VendorPages/VendorEditProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petcastle/main.dart';


//import 'VendorServiceCard.dart';

SharedPreferences prefs;
String Email;
var S,P,Q;
//var jsonArr = new List();
//var jsonStr;
var result;
//int x;
//Map<String, dynamic> decoded;
//List<SignupV> dartArrV = new List<SignupV>();
//VService v1 = new VService();
//var viewArr = new List<SignupV>();

// class Album {
//   String Name;
//   String Email;
//   String Phno;
//   String Location;
//   String License;
//   String Service_type;
//   Album() {
//     this.Name = Name;
//     this.Email = Email;
//     this.Phno = Phno;
//     this.Location = Location;
//     this.License = License;
//     this.Service_type = Service_type;
//   }
//   Map<String, dynamic> toJson() {
//     return <String, dynamic>{
//       'Vendor_name': Name,
//       'Vendor_email': Email,
//       'Vendor_phno': Phno,
//       'Vendor_location': Location,
//       'Vendor_license': License,
//       'Vendor_service_type': Service_type
//     };
//   }

//   Album.fromJson(Map<String, dynamic> json)
//       : Name = json['Vendor_name'],
//         Email = json['Vendor_email'],
//         Phno = json['Vendor_phno'],
//         Location = json['Vendor_Location'],
//         License = json['Vendor_license'],
//         Service_type = json['Vendor_service_type'];
// }

//DispV dv1 = new DispV();

class dispVen {
  final String Name;
  final String Email;
  final String Phno;
  final String Location;
  final String License;
  final String Service_type;

  dispVen({@required this.Name, @required this.Email, @required this.Phno, @required this.Location, @required this.License, @required this.Service_type});

  factory dispVen.fromJson(Map<String, dynamic> json) {
    return dispVen(
      Name: json['Vendor_name'],
      Email: json['Vendor_email'],
      Phno: json['Vendor_ph_no'],
      Location: json['Vendor_location'],
      License: json['Vendor_license_no'],
      Service_type: json['Vendor_service_type'],
    );
  }
}

Future<dispVen> fetchVendor() async {
  prefs = await SharedPreferences.getInstance();
  print("entered preferenes");
  // await DartArr.clear();
  Email = await prefs.getString("username");
  print(Email);
  // Email = await prefs.getString("username");
  // print(Email);
  var queryParameters = {
    'key': Email,

  };
  final response =
  await http.get(Uri.http('192.168.0.156:8090', '/dispven',queryParameters));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    result = response.body;
    return dispVen.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<dispVen> delVendor() async {
  prefs = await SharedPreferences.getInstance();
  Email = await prefs.getString("username");
  //newPassword = await prefs.getString("newPassword");

  var queryParameters = {
    'key': Email,
  };
  final response =
  await http.get(Uri.http('192.168.0.156:8090', '/delvendor',queryParameters));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    result = response.body;

  } else {
    throw Exception('Failed to load');
  }
}

// Future<List<String>> _postData() async {
//   print("post id starts");
//   Email = await prefs.getString("username");
//
//   var body = Email;
//   var url = Uri.parse("http://192.168.0.156:8090/dispVendor");
//   //final response = await http.Client().post("http://192.168.0.9:8080/login",body: json.encode("hello"));
//   await http.post(url, body: json.encode(body)).then((http.Response response) {
//     if (response.statusCode == 200) {
//       print("----------------------------------------------------------");
//       print(" jsafjdsfkjdshgkjfdkg " + response.body);
//       result = response.body;
//       jsonArr = json.decode(result);
//     }
//   });
//   return jsonArr;
// }



class VendorMyProfile extends StatefulWidget {
  VendorMyProfile({Key key}) : super(key: key);

  @override
  _VendorMyProfileState createState() => _VendorMyProfileState();
}

class _VendorMyProfileState extends State<VendorMyProfile> {

  Future<dispVen> futureVen;

  @override
  void initState() {
    super.initState();

    futureVen = fetchVendor();
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
                child: FutureBuilder<dispVen>(
                  future: fetchVendor(),

                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                       S = snapshot.data.Name;
                       P = snapshot.data.Phno;
                     //  Q = snapshot.data.Location;
                      var send = 'Name :- ' +snapshot.data.Name+'\n\n Email :-  ' +snapshot.data.Email+ '\n\n Phone Number :- ' +snapshot.data.Phno+ '\n\n City :- ' +snapshot.data.Location+ '\n\n License Number :- ' +snapshot.data.License+ '\n\n Service Type :- ' +snapshot.data.Service_type;

                      return Text("${send}");

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
                print(S);
                prefs = await SharedPreferences.getInstance();
                prefs.setString('name', S);
                prefs.setString('Phone', P);
               // prefs.setString('City', Q);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => VendorEditProfile()),
                );
              },
              child: Text(
                'Edit',
                style: TextStyle(decoration: TextDecoration.underline),
              )),
          FlatButton(
              onPressed: () async{
                await delVendor();
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
