//when user selects a particular clinic or center the details of the services price etsc will be displayed with a +icon to procced to selcting a service

import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/AddService.dart';
import 'package:petcastle/CustomerPages/AppHome.dart';
import 'package:petcastle/CustomerPages/Book.dart';

class SelectedService extends StatefulWidget {
  @override
  _SelectedServiceState createState() => _SelectedServiceState();
}

class _SelectedServiceState extends State<SelectedService> {
  int x = 2;

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
        title: Text('Select services'),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: SingleChildScrollView(
        //change
        child: new Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddService()),
                        );
                      },
                      textColor: Colors.white,
                      color: Colors.blueGrey[600],
                      padding: const EdgeInsets.all(10.0),
                      child: const Text('View Profile',
                          style: TextStyle(fontSize: 15)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AppHome()),
                        );
                      },
                      textColor: Colors.white,
                      color: Colors.blueGrey[600],
                      padding: const EdgeInsets.all(10.0),
                      child: const Text('View Reviews',
                          style: TextStyle(fontSize: 15)),
                    ),
                  ),
                ],
              ),
              new Card(
                elevation: 10,
                color: Colors.blueGrey[100],
                child: Container(
                  width: 200,
                  height: 50,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 0, horizontal: 10),
                        child: Row(
                          children: [
                            Text(
                              'Service Name ',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '--- Price',
                              style: TextStyle(fontWeight: FontWeight.bold),
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
                    width: 200,
                    height: 50,
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 0, horizontal: 20),
                          child: Row(
                            children: [Text('  Check Up      '), Text('  500')],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                              width: 2, color: Colors.blueGrey[600])),
                      child: IconButton(
                        icon: Icon(
                          Icons.add,
                        ),
                        color: Colors.brown[600],
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Book()),
                          );
                        },
                      ),
                    ),
                    Text('Tap the + to book a service',
                        style: TextStyle(
                            color: Colors.blueGrey[600],
                            decoration: TextDecoration.underline)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
