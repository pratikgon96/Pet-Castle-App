// This is the list of cards containing Clinics for the service Pet DOctors
// THis contains a sort button , a fliter by button and a list of cards
import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/SelectedService.dart';
import 'package:petcastle/CustomerPages/SortBy.dart';

// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEna

class MyDoctor extends StatefulWidget {
  @override
  _State createState() => new _State();
}

//State is information of the application that can change over time or when some actions are taken.
class _State extends State<MyDoctor> {
  int x = 4;
  int y = 5;
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Pet clinics '),
        backgroundColor: Colors.blueGrey[600],
      ),
      //hit Ctrl+space in intellij to know what are the options you can use in flutter widgets
      body: SingleChildScrollView(
        child: new Container(
          padding: new EdgeInsets.all(1.0),
          child: new Center(
            child: new Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SortBy()));
                      },
                      textColor: Colors.white,
                      color: Colors.blueGrey[600],
                      padding: const EdgeInsets.all(8.0),
                      child:
                          const Text('Sortby', style: TextStyle(fontSize: 10)),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => SortBy()));
                      },
                      textColor: Colors.white,
                      color: Colors.blueGrey[600],
                      padding: const EdgeInsets.all(8.0),
                      child: const Text('Filterby',
                          style: TextStyle(fontSize: 10)),
                    ),
                  ],
                ),
                //new card begins here
                for (int j = 0; j < y; j++)
                  new Card(
                    elevation: 5,
                    child: new Container(
                      height: 200,
                      padding: new EdgeInsets.all(30.0),
                      child: new Row(
                        children: <Widget>[
                          Image.asset('assets/images/doctor1.jpg',
                              height: 200, width: 100),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              FlatButton(
                                child: Text('ABC Pet Clinic'),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SelectedService()),
                                  );
                                },
                              ),
                              Row(
                                children: <Widget>[
                                  for (int i = 0; i < x; i++)
                                    Icon(Icons.star, color: Colors.green),
                                  for (int j = 0; j < 5 - x; j++)
                                    Icon(Icons.star, color: Colors.black),
                                ],
                              ),
                              Text('13 reviews'),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Vaccination',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text('Checkup',
                                        style: TextStyle(
                                            decoration:
                                                TextDecoration.underline)),
                                  )
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
