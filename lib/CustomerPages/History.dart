import 'package:flutter/material.dart';
import 'package:petcastle/CustomerPages/WriteReview.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final h = data.size.height;
    final w = data.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              children: [
                new Card(
                  elevation: 10,
                  color: Colors.blueGrey[100],
                  child: Container(
                    width: w,
                    height: 50,
                    child: Row(
                      children: [
                        Container(
                          width: w * 0.2,
                          // color: Colors.pink,
                          alignment: Alignment.center,
                          child: Text(
                            'Service',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: w * 0.2,
                          // color: Colors.pink,
                          alignment: Alignment.center,
                          child: Text(
                            'Type',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: w * 0.22,
                          // color: Colors.pink,
                          alignment: Alignment.center,
                          child: Text(
                            'Date &Time',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: w * 0.18,
                          // color: Colors.pink,
                          alignment: Alignment.center,
                          child: Text(
                            'Invoice',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: w * 0.15,
                          // color: Colors.pink,
                          alignment: Alignment.center,
                          child: Text(
                            'Review',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 10,
                        child: Container(
                          alignment: Alignment.center,
                          width: w,
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                  alignment: Alignment.center,
                                  width: w * 0.2,
                                  child: Text(' Check up')),
                              Container(
                                  alignment: Alignment.center,
                                  width: w * 0.2,
                                  child: Text('Doctor')),
                              Container(
                                alignment: Alignment.center,
                                width: w * 0.2,
                                child: Text('21-03-2021 15:30 ',
                                    style: TextStyle(fontSize: 12)),
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: w * 0.18,
                                child: Icon(Icons.download_sharp),
                              ),
                              Container(
                                width: w * 0.18,
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => WriteReview(),
                                      ),
                                    );
                                  },
                                  icon: Icon(Icons.rate_review),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}