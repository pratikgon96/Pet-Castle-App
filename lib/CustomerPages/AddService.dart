//this is a form with dropdowns to book a service
// this is displayed after the user clicks on  + icon in selectedservice.dart page
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/Bill.dart';
import 'package:petcastle/CustomerPages/Book.dart';
import 'package:petcastle/CustomerPages/SelectedService.dart';
import 'package:petcastle/CustomerPages/selectedservicecards.dart';

class AddService extends StatefulWidget {
  @override
  _AddServiceState createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
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
        ),
        body: Center(
          child: new Container(
              margin: const EdgeInsets.all(15.0),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blueGrey[600]),
                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
              child: Container(
                height: 250,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Select your service  =>  '),
                          ),
                          DropdownButton<String>(
                            value: dropdownValue,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.blueGrey[600]),
                            underline: Container(
                              height: 2,
                              //color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue = newValue;
                              });
                            },
                            items: <String>['Checkup', 'Vaccine', 'Surgery']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Select your Pet  =>  '),
                          ),
                          DropdownButton<String>(
                            value: dropdownValue2,
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(color: Colors.blueGrey[600]),
                            underline: Container(
                              height: 2,
                              //color: Colors.deepPurpleAccent,
                            ),
                            onChanged: (String newValue) {
                              setState(() {
                                dropdownValue2 = newValue;
                              });
                            },
                            items: <String>['Bruno', 'Lilly', 'Simba']
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Choose a date =>'),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(Icons.calendar_today),
                                onPressed: () => _selectDate(context),
                                color: Colors.blueGrey[600],
                              ),
                              Text(
                                "${selectedDate.toLocal()}".split(' ')[0],
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.blueGrey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SSC()),
                            );
                          },
                          textColor: Colors.white,
                          color: Colors.blueGrey[600],
                          padding: const EdgeInsets.all(5.0),
                          child: const Text('Proceed',
                              style: TextStyle(fontSize: 15)),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}
