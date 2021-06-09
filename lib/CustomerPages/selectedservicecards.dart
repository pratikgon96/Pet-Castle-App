//the card showing the pet and the servce
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AddService.dart';
import 'package:petcastle/CustomerPages/Bill.dart';
import 'package:petcastle/CustomerPages/Book.dart';
import 'package:petcastle/CustomerPages/SelectedService.dart';

class SSC extends StatefulWidget {
  @override
  _SSCState createState() => _SSCState();
}

class _SSCState extends State<SSC> {
  int x = 1;
  DateTime selectedDate = DateTime.now();

  _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  String dropdownValue = 'Checkup';
  String dropdownValue2 = 'Bruno';
  bool valuefirst = false;
  bool valuesecond = false;
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Service'),
          backgroundColor: Colors.blueGrey[600],
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddService()),
                );
              },
            ),
          ],
        ),
        body: Center(
          child: new Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 28.0),
                  child: Column(
                    children: [
                      for (int i = 0; i < x; i++)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: new Card(
                            elevation: 10,
                            color: Colors.blueGrey[100],
                            child: Container(
                              width: 350,
                              height: 80,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 0, horizontal: 20),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Service --',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Pet --',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          'Date',
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
                        ),
                    ],
                  ),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Bill()),
                    );
                  },
                  textColor: Colors.white,
                  color: Colors.blueGrey[600],
                  padding: const EdgeInsets.all(10.0),
                  child: const Text('Proceed', style: TextStyle(fontSize: 15)),
                ),
              ],
            ),
          ),
        ));
  }
}
