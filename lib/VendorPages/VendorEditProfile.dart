//editing his profile

//not done
//this is dummy
//dont touch it will become a mess
//just kidding
//oh no i am not
import 'dart:convert';
import 'dart:io';
import 'package:petcastle/Login/SignUpScreenV.dart';
import 'package:petcastle/VendorPages/VendorMyProfile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:petcastle/VendorPages/VendorProfile.dart';
SharedPreferences prefs;
String Email;
//String Name;
String newName;
String newPhoneNo;
String newLocation;
String result;
int test = 0;

//changePass cp1 = new changePass();

Future<void> editvendor() async {
  prefs = await SharedPreferences.getInstance();
  Email = await prefs.getString("username");
  //newPassword = await prefs.getString("newPassword");

  var queryParameters = {
    'key': Email,
    'key1': newName,
    'key2': newPhoneNo,
    'key3': newLocation,

  };
  final response =
  await http.get(Uri.http('192.168.0.156:8090', '/editven',queryParameters));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    result = response.body;

  } else {
    throw Exception('Failed to load');
  }
}


class VendorEditProfile extends StatefulWidget {
  VendorEditProfile({Key key}) : super(key: key);

  @override
  _VendorEditProfileState createState() => _VendorEditProfileState();
}

class _VendorEditProfileState extends State<VendorEditProfile> {
  SharedPreferences prefs;
  final _formKey = GlobalKey<FormState>();
  bool _isEditingText = false;
  bool _isEditingText1 = false;
 // bool _isEditingText2 = false;
  TextEditingController _editingController;
  TextEditingController _editingController1;
 // TextEditingController _editingController2;
  String initialText;
  String initialText1;
  //String initialText2;

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

 // TextEditingController nameController = TextEditingController();
 // TextEditingController phoneController = TextEditingController();
 // TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
 // TextEditingController categoryController = TextEditingController();
 // TextEditingController clinicController = TextEditingController();

  bool _obscureText = false;
  // var categories = [
  //   "Doctor",
  //   "Trainer",
  //   "Groomer",
  //   "Hostel",
  // ];
 // var _category = "Doctor";

  var cities = [
    "Bangalore",
    "Hyderabad",
    "Chennai",
  ];
  var _city = "Bangalore";
  //String finalClinic;
  // String finalEmail;
  // String finalPhone;
  // String finalName;
  //
  // String finalCity;
  // String finalCategory;
  // Future customerData() async {
  //   WidgetsFlutterBinding.ensureInitialized();
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var vendEmail = prefs.getString('vendoremail')?? "Not printing yet";
  //   var vendPhone = prefs.getString('vendorphone')?? "Not printing yet";
  //   var vendName = prefs.getString('vendorname')?? "Not printing yet";
  //
  //   var vendCity = prefs.getString('vendorcity') ?? "Not printing yet";
  //   //var vendCategory = prefs.getString('vendorcategory') ?? "Not printing yet";
  //   //var vendClinic = prefs.getString('vendorclinic');
  //   setState(() {
  //     finalEmail = vendEmail;
  //     finalName = vendName;
  //     finalPhone = vendPhone;
  //
  //     finalCity = vendCity;
  //  //   finalCategory = vendCategory;
  //    // finalClinic = vendClinic;
  //   });
  //   print(finalCategory);
  //   print(finalEmail);
  //   print(finalCity);
  // }
  //Future<dispVen> futureVen;
  void preData() async{

    prefs = await SharedPreferences.getInstance();
    var S = await prefs.getString('name');
    var P = await prefs.getString('Phone');
    var Q = await prefs.getString('City');

    print(S);
  }
  @override
  void initState() {
    preData();
    saveDetails();
    initialText = S;
    initialText1 = P;
   // initialText2 = Q;
    super.initState();
    _editingController = TextEditingController(text: initialText);
    _editingController1 = TextEditingController(text: initialText1);
   // _editingController2 = TextEditingController(text: initialText2);

    //futureVen = fetchVendor();
  }

  @override
  void dispose() {
    _editingController.dispose();
    _editingController1.dispose();
   // _editingController2.dispose();
    super.dispose();
  }

  void saveDetails() async {
    prefs = await SharedPreferences.getInstance();
    //prefs.setString('username', username);
    //prefs.setString('password', password);
    Email = await prefs.getString("username");
    Name = await prefs.getString('name');


  }

  Widget _editTitleTextField() {
    if (_isEditingText)
      return Center(
        child: TextField(
          onSubmitted: (newValue){
            setState(() {
              initialText = newValue;
              _isEditingText =false;
            });
          },
          autofocus: true,
          controller: _editingController,
        ),
      );
    return InkWell(
        onTap: () {
      setState(() {
        _isEditingText = true;
      });
    },
    child: Text(
    initialText,
    style: TextStyle(
    color: Colors.black,
    fontSize: 18.0,
    ),
    )
    );
  }

  Widget _editTitleTextField1() {
    if (_isEditingText1)
      return Center(
        child: TextField(
          onSubmitted: (newValue){
            setState(() {
              initialText1 = newValue;
              _isEditingText1 =false;
            });
          },
          autofocus: true,
          controller: _editingController1,
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText1 = true;
          });
        },
        child: Text(
          initialText1,
          style: TextStyle(
            color: Colors.black,
            fontSize: 18.0,
          ),
        )
    );
  }


  // Widget _editTitleTextField2() {
  //   if (_isEditingText2)
  //     return Center(
  //       child: TextField(
  //         onSubmitted: (newValue){
  //           setState(() {
  //             initialText2 = newValue;
  //             _isEditingText2 =false;
  //           });
  //         },
  //         autofocus: true,
  //         controller: _editingController2,
  //       ),
  //     );
  //   return InkWell(
  //       onTap: () {
  //         setState(() {
  //           _isEditingText2 = true;
  //         });
  //       },
  //       child: Text(
  //         initialText2,
  //         style: TextStyle(
  //           color: Colors.black,
  //           fontSize: 18.0,
  //         ),
  //       )
  //   );
  // }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Edit Vendor Profile'),
//         backgroundColor: Colors.blueGrey[600],
//       ),
//
//
//       body: Column(
//
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: new Card(
//               elevation: 10,
//               color: Colors.blueGrey[100],
//               child: Container(
//                 width: 380,
//                 height: 250,
//                 //child: Row(
//                 //children: [
//                 // Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
//
//                 child: FutureBuilder<dispVen>(
//                   future: futureVen,
//
//                   builder: (BuildContext context, AsyncSnapshot snapshot) {
//                     if (snapshot.hasData) {
//                       print("profile is on process");
//                       return ListView.builder(
//                           itemBuilder: (BuildContext context, int index) {
//                             return Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: new Card(
//                                 elevation: 10,
//                                 color: Colors.blueGrey[100],
//                                 child: Container(
//                                   width: 380,
//                                   height: 250,
//                                   child: Row(
//                                     children: [
//                                       Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             vertical: 0, horizontal: 0),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                           MainAxisAlignment.spaceEvenly,
//                                           crossAxisAlignment:
//                                           CrossAxisAlignment.center,
//                                           children: [
//                                             Padding(
//                                               padding: const EdgeInsets.all(
//                                                   8.0),
//                                               child: Row(
//                                                 children: [
//                                               TextFormField(
//                                                controller: _editingController,
//                                                keyboardType: TextInputType.text,
//                                                   validator: (value) {
//                                                     if (value.isEmpty) {
//                                                       return 'Please enter some text';
//                                                     } else if (value.length < 5) {
//                                                         return 'Name should be greater than 5 characters';
//                                                       }
//                                                       return null;
//                                                   },
//                                                   ),
//                                                   Text(
//                                                     (snapshot.data.Name)
//                                                         .toString(),
//                                                     style: TextStyle(
//                                                         fontWeight: FontWeight
//                                                             .bold,
//                                                         fontSize: 12),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.all(
//                                                   8.0),
//                                               child: Row(
//                                                 children: [
//                                                   Text(
//                                                     'Email Id =>  ',
//                                                     style: TextStyle(
//                                                         fontWeight: FontWeight
//                                                             .bold,
//                                                         fontSize: 12),
//                                                   ),
//                                                   Text(
//                                                     (snapshot.data.Email)
//                                                         .toString(),
//                                                     style: TextStyle(
//                                                         fontWeight: FontWeight
//                                                             .bold,
//                                                         fontSize: 12),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.all(
//                                                   8.0),
//                                               child: Row(
//                                                 children: [
//                                                   Text(
//                                                     'Phone Number =>  ',
//                                                     style: TextStyle(
//                                                         fontWeight: FontWeight
//                                                             .bold,
//                                                         fontSize: 12),
//                                                   ),
//                                                   Text(
//                                                     (snapshot.data.Phno)
//                                                         .toString(),
//                                                     style: TextStyle(
//                                                         fontWeight: FontWeight
//                                                             .bold,
//                                                         fontSize: 12),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                             Padding(
//                                               padding: const EdgeInsets.all(
//                                                   8.0),
//                                               child: Row(
//                                                 children: [
//                                                   Text(
//                                                     'City =>  ',
//                                                     style: TextStyle(
//                                                         fontWeight: FontWeight
//                                                             .bold,
//                                                         fontSize: 12),
//                                                   ),
//                                                   Text(
//                                                     (snapshot.data.Location)
//                                                         .toString(),
//                                                     style: TextStyle(
//                                                         fontWeight: FontWeight
//                                                             .bold,
//                                                         fontSize: 12),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             );
//                           }
//                       );
//                       // var send = 'Name :- ' +snapshot.data.Name+'\n\n Email :-  ' +snapshot.data.Email+ '\n\n Phone Number :- ' +snapshot.data.Phno+ '\n\n City :- ' +snapshot.data.Location;
//                       //
//                       // return Text("${send}");
//
//                       //return Text(snapshot.data.Name);
//
//                       //return Text(snapshot.data.Name);
//                     } else if (snapshot.hasError) {
//                       return Text("${snapshot.error}");
//                     }
//
//                     // By default, show a loading spinner.
//                     return CircularProgressIndicator();
//                   },
//
//                 ),
//
//               ),
//             ),
//           ),
//           FlatButton(
//               onPressed: () async {
//                 newName = nameController.text.toString();
//                 newPhoneNo = phoneController.text.toString();
//                           //var Email = emailController.text.toString();
//                          // s1.License = licenseController.text.toString();
//                          // s1.Password = passwordController.text.toString();
//                           // s1.ClinicName = clinicController.text.toString();
//                          // s1.Service_type = _category;
//                 newLocation = _city;
//                 print(newPhoneNo);
//                 print(newName);
//                 await _submit();
//                 if (test == 1) {
//                   await editvendor();
//                   print("entered editVendor");
//                   print("ok");
//                   bool userFound = true;
//                   if (userFound) {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => VendorProfile()),
//                     );
//                   }
//                 }
//
//               },
//               child: Text(
//                 'Submit',
//                 style: TextStyle(decoration: TextDecoration.underline),
//               )),
//
//         ],
//       ),
//     );
//
//
//
//
//     // SharedPreferences prefs;
//   }
//
//
// }











  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Vendor Profile'),
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
                  height: 20,
                ),
                Column(
                  children: [
                    TextFormField(
                        controller: _editingController,
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
                            prefixIcon: Icon(Icons.person_pin_outlined),
                            hintText: "Enter your full name")),
                    TextFormField(
                        controller: _editingController1,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          } else if (value.length != 10) {
                            return 'Phone number should be 10 digits only';
                          }
                          return null;
                        },
                        decoration: new InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            hintText: "Enter your phone number")),
                    // TextFormField(
                    //     controller: emailController,
                    //     keyboardType: TextInputType.emailAddress,
                    //     validator: (value) {
                    //       if (value.isEmpty) {
                    //         return 'Please enter some text';
                    //       } else if (value.length < 5) {
                    //         return 'Email should be greater than 5 characters';
                    //       }
                    //       return null;
                    //     },
                    //     decoration: new InputDecoration(
                    //         prefixIcon: Icon(Icons.email_outlined),
                    //         hintText: "Enter your email address")),
                    // TextFormField(
                    //     controller: passwordController,
                    //     keyboardType: TextInputType.text,
                    //     validator: (value) {
                    //       if (value.isEmpty) {
                    //         return 'Please enter some text';
                    //       } else if (value.length < 8) {
                    //         return 'Password should be greater than 8 characters';
                    //       } else if (value != confirmPasswordController.text) {
                    //         return 'Password and confirm password are not same';
                    //       }
                    //       return null;
                    //     },
                    //     decoration: new InputDecoration(
                    //         prefixIcon: Icon(Icons.lock_outline),
                    //         hintText: "Enter your password")),
                    // TextFormField(
                    //   controller: confirmPasswordController,
                    //   keyboardType: TextInputType.text,
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return 'Please enter password';
                    //     } else if (value.length < 8) {
                    //       return 'Password should be greater than 8 characters';
                    //     } else if (value != passwordController.text) {
                    //       return 'Password and confirm password are not same';
                    //     }
                    //     return null;
                    //   },
                    //   obscureText: _obscureText,
                    //   decoration: new InputDecoration(
                    //       prefixIcon: Icon(Icons.lock),
                    //       hintText: "Confirm your Password"),
                    // ),
                    // TextFormField(
                    //   controller: licenseController,
                    //   keyboardType: TextInputType.text,
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return 'Please enter license number';
                    //     }
                    //
                    //     return null;
                    //   },
                    //   obscureText: _obscureText,
                    //   decoration: new InputDecoration(
                    //       prefixIcon: Icon(Icons.vpn_key_outlined),
                    //       hintText: "Enter license number"),
                    // ),
                    // TextFormField(
                    //   controller: clinicController,
                    //   keyboardType: TextInputType.text,
                    //   validator: (value) {
                    //     if (value.isEmpty) {
                    //       return 'Please enter your clinic name';
                    //     }
                    //
                    //     return null;
                    //   },
                    //   obscureText: _obscureText,
                    //   decoration: new InputDecoration(
                    //       prefixIcon: Icon(Icons.home_work_outlined),
                    //       hintText: "Enter your clinic name "),
                    // ),
                    // DropdownButtonFormField(
                    //   items: categories.map((String category) {
                    //     return new DropdownMenuItem(
                    //         value: category,
                    //         child: Row(
                    //           children: <Widget>[
                    //             Text(category),
                    //           ],
                    //         ));
                    //   }).toList(),
                    //   onChanged: (newValue) {
                    //     s1.Service_type = newValue;
                    //     // do other stuff with _category
                    //     setState(() => _category = newValue);
                    //   },
                    //   value: _category,
                    //   decoration: InputDecoration(
                    //     contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                    //     prefixIcon: Icon(Icons.miscellaneous_services),
                    //     hintText: "Choose category",
                    //   ),
                    // ),
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
                        // do other stuff with _category
                        newLocation = newValue;
                        setState(() => _city = newValue);
                      },
                      value: _city,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                        prefixIcon: Icon(Icons.location_on_outlined),
                        hintText: "Choose city",
                      ),
                    ),
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
                          newName = _editingController.text.toString();
                          newPhoneNo = _editingController1.text.toString();
                          //var Email = emailController.text.toString();
                         // s1.License = licenseController.text.toString();
                         // s1.Password = passwordController.text.toString();
                          // s1.ClinicName = clinicController.text.toString();
                         // s1.Service_type = _category;
                          newLocation = _city;
                          print(newPhoneNo);
                          print(newName);
                         // prefs = await SharedPreferences.getInstance();
                          //prefs.setString('username', username);
                          //prefs.setString('password', password);

                          //prefs.setString('username', s1.Email);
                         // await fetchOtp();
                          await _submit();
                          if (test == 1) {
                            await editvendor();

                            print("entered editVendor");
                              print("ok");
                              //l1.Email = usernameController.text;
                              //l1.Password = passwordController.text;
                              bool userFound = true;

                              if (userFound) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => VendorProfile()),
                                );
                            }
                          }
                        },
                        color: Colors.blueGrey[600],
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 38.0),
                    //   child: TextButton(
                    //     onPressed: () {},
                    //     child: Text("Already have an account?",
                    //         style: TextStyle(color: Colors.blueGrey[600])),
                    //   ),
                    // ),
                    // Container(
                    //   width: 100,
                    //   child: RaisedButton(
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //     },
                    //     color: Colors.blueGrey[600],
                    //     child: Text(
                    //       'Login',
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}












  //   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF546E7A),
//         title: Text('My Profile', style: TextStyle(fontSize: 15)),
//       ),
//       body: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: nameController,
//                   keyboardType: TextInputType.text,
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter name';
//                     }
//                     return null;
//                   },
//                   obscureText: _obscureText,
//                   decoration: new InputDecoration(hintText: finalName),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: phoneController,
//                   keyboardType: TextInputType.text,
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter phone number';
//                     }
//                     return null;
//                   },
//                   obscureText: _obscureText,
//                   decoration: new InputDecoration(hintText: finalPhone),
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: emailController,
//                   keyboardType: TextInputType.text,
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter email';
//                     }
//                     return null;
//                   },
//                   obscureText: _obscureText,
//                   decoration: new InputDecoration(hintText: finalEmail),
//                 ),
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: TextFormField(
//               //     controller: categoryController,
//               //     keyboardType: TextInputType.text,
//               //     validator: (value) {
//               //       if (value.isEmpty) {
//               //         return 'Please select  category';
//               //       }
//               //       return null;
//               //     },
//               //     obscureText: _obscureText,
//               //     decoration: new InputDecoration(hintText: finalCategory),
//               //   ),
//               // ),
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: TextFormField(
//                   controller: cityController,
//                   keyboardType: TextInputType.text,
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please select city';
//                     }
//                     return null;
//                   },
//                   obscureText: _obscureText,
//                   decoration: new InputDecoration(hintText: finalCity),
//                 ),
//               ),
//               // Padding(
//               //   padding: const EdgeInsets.all(8.0),
//               //   child: TextFormField(
//               //     controller: clinicController,
//               //     keyboardType: TextInputType.text,
//               //     validator: (value) {
//               //       if (value.isEmpty) {
//               //         return 'Please enter clinic / center name';
//               //       }
//               //       return null;
//               //     },
//               //     obscureText: _obscureText,
//               //     decoration: new InputDecoration(hintText: finalClinic),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

