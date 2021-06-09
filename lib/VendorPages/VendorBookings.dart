//this is vendor homepage . here the vendors bookings will appear . he can accept/deny here .
import 'package:flutter/material.dart';

class VendorBookings extends StatefulWidget {
  @override
  _VendorBookingsState createState() => _VendorBookingsState();
}

class _VendorBookingsState extends State<VendorBookings> {
  int x = 2;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Text(
                  'My booking requests',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[600],
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      for (int i = 0; i < x; i++)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: new Card(
                            elevation: 10,
                            color: Colors.blueGrey[50],
                            shadowColor: Colors.blueGrey[600],
                            child: Container(
                              width: 380,
                              height: 250,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: FlatButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (_) => AlertDialog(
                                                  title: Text('Details'),
                                                  content: Container(
                                                    height: 200,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Phone :'),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  '8989898989'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Email :'),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'ajdgs@gmail.com'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Pet Type :'),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  Text('Dog'),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                  'Pet Name:'),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child:
                                                                  Text('Bruno'),
                                                            )
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ));
                                      },

                                      textColor: Colors.blueGrey[600],

                                      //padding: const EdgeInsets.all(1.0),
                                      child: const Text('Mr.ABD',
                                          style: TextStyle(
                                              fontSize: 15,
                                              decoration:
                                                  TextDecoration.underline)),
                                    ),
                                    /*Text('Mr. ABD',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                          color: Colors.blueGrey[600],
                                        )),*/
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Text('Service Type',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueGrey[600])),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 60.0),
                                        child: Text('Checkup',
                                            style: TextStyle(
                                                color: Colors.blueGrey[600])),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Text('Date and Time',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueGrey[600])),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 50.0),
                                        child: Text('21-03-2021 15:30 ',
                                            style: TextStyle(
                                                color: Colors.blueGrey[600])),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Text('Addt. Info.',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueGrey[600])),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 75.0),
                                        child: Text('Skin Allergy',
                                            style: TextStyle(
                                                color: Colors.blueGrey[600])),
                                      )
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 28.0),
                                        child: Text('Payment Status',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blueGrey[600])),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 45.0),
                                        child: Text('Paid',
                                            style: TextStyle(
                                                color: Colors.blueGrey[600])),
                                      )
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: RaisedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                      title: Text(
                                                          'Accepted, thank you!'),
                                                      content: Container(
                                                        height: 130,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'If by any chance, you want to deny this request later please go to Profile>Upcoming Bookings>status \n Note: This has to be done prior to 24 hrs of the service. ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ));
                                          },

                                          textColor: Colors.white,
                                          color: Colors.blueGrey[600],
                                          //padding: const EdgeInsets.all(1.0),
                                          child: const Text('Accept',
                                              style: TextStyle(fontSize: 12)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(15.0),
                                        child: RaisedButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (_) => AlertDialog(
                                                      title: Text('Denied!'),
                                                      content: Container(
                                                        height: 130,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Text(
                                                                  'If by any chance, you want to accept this request later please go to Profile>Upcoming Bookings>status \n Note: This has to be done prior to 24 hrs of the service. ',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ));
                                          },
                                          textColor: Colors.white,
                                          color: Colors.blueGrey[600],

                                          //padding: const EdgeInsets.all(10.0),
                                          child: const Text('Deny',
                                              style: TextStyle(fontSize: 12)),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
