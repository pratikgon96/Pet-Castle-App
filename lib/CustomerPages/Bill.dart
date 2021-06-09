//after selecting services and proceeding , this bill will appear
//this is displayed when user clicks on proceed button in selectedservicecards.dart
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/PaymentMethod.dart';

class Bill extends StatefulWidget {
  @override
  _BillState createState() => _BillState();
}

class _BillState extends State<Bill> {
  int x = 2;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Bill'),
          backgroundColor: Colors.blueGrey[600],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    children: [
                      new Card(
                        elevation: 10,
                        color: Colors.blueGrey[100],
                        child: Container(
                          width: 380,
                          height: 50,
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 80),
                                child: Row(
                                  children: [
                                    Text(
                                      'Service --',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Pet--',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Date--',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      ' Price',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      for (int i = 0; i < x; i++)
                        new Card(
                          elevation: 10,
                          child: Container(
                            width: 380,
                            height: 50,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 0, horizontal: 30),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Checkup'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('Bruno'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('21-02-2021'),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text('500'),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 50.0),
                        child: new Card(
                          elevation: 10,
                          child: Container(
                            width: 300,
                            color: Colors.blueGrey[600],
                            child: RaisedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentMethod()),
                                );
                              },
                              color: Colors.blueGrey[600],
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Total',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    '1000',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 70.0),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentMethod()),
                            );
                          },
                          textColor: Colors.white,
                          color: Colors.blueGrey[600],
                          padding: const EdgeInsets.all(10.0),
                          child: const Text('Proceed to payment ',
                              style: TextStyle(fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
