// This is the Home page for the customer .
//This contains a carousel and the categories of services for the customer.
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:petcastle/CustomerPages/MyDoctor.dart';

class AppHome extends StatefulWidget {
  @override
  _AppHomeState createState() => _AppHomeState();
}

class _AppHomeState extends State<AppHome> {
  List<String> onlyImages = [
    "assets/images/doctor1.jpg",
    "assets/images/trainer1.jpg",
    "assets/images/hostel1.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return new Scaffold(
        body: SingleChildScrollView(
      child: new Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  initialPage: 0,
                  aspectRatio: 2.0,
                  enlargeCenterPage: true,
                ),
                items: onlyImages
                    .map((item) => Container(
                          child: Image.asset(
                            item,
                            fit: BoxFit.cover,
                            width: data.size.width,
                          ),
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0),
              child: SingleChildScrollView(
                child: Container(
                  height: data.size.height / 1.9,
                  //color: Colors.red[200],
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: data.size.height / 4,
                                  width: data.size.width / 2.1,
                                  //color: Colors.blue,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.asset(
                                            'assets/images/doctor1.jpg',
                                            width: 150,
                                            height: 100,
                                          ),
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyDoctor()),
                                            );
                                          },
                                          child: const Text('Pet Doctor',
                                              style: TextStyle(fontSize: 15)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  //color: Colors.blue,
                                  height: data.size.height / 4,
                                  width: data.size.width / 2.1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.asset(
                                            'assets/images/trainer1.jpg',
                                            width: 150,
                                            height: 100,
                                          ),
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyDoctor()),
                                            );
                                          },
                                          child: const Text('Pet Trainer',
                                              style: TextStyle(fontSize: 15)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Container(
                                  // color: Colors.blue,
                                  height: data.size.height / 4,
                                  width: data.size.width / 2.1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.asset(
                                            'assets/images/groomer1.jpg',
                                            width: 150,
                                            height: 100,
                                          ),
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyDoctor()),
                                            );
                                          },
                                          child: const Text('Pet Grooomer',
                                              style: TextStyle(fontSize: 15)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Container(
                                  // color: Colors.blue,
                                  height: data.size.height / 4,
                                  width: data.size.width / 2.1,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.asset(
                                            'assets/images/hostel1.jpg',
                                            width: 150,
                                            height: 100,
                                          ),
                                        ),
                                        FlatButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyDoctor()),
                                            );
                                          },
                                          child: const Text('Pet Hostel',
                                              style: TextStyle(fontSize: 15)),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
