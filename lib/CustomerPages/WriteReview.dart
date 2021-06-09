import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:petcastle/Login/LogInScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
String result;
//String emailO;
class Review{
  String idO;
  String idV;
  String idS;
  String emailV;
  String emailO;
  String rating;
  String review;
  Review(){
    this.idO = idO;
    this.idV = idV;
    this.idS = idS;
    this.emailO = emailO;
    this.emailV = emailV;
    this.rating = rating;
    this.review = review;
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'Owner_id': idO,
      'Vendor_id': idV,
      'Service_id': idS,
      'Owner_email': emailO,
      'Vendor_email': emailV,
      'Review_stars': rating,
      'Review_text': review,
    };
  }
  Review.fromJson(Map<String, dynamic> json)
      :
        idO = json['Owner_id'],
        idV = json['Vendor_id'],
        idS = json['Service_id'],
        emailO = json['Owner_email'],
        emailV = json['Vendor_email'],
        rating = json['Review_stars'],
        review = json['Review_text'];

}

Review r1 = new Review();

Future<http.Response> _postReview()  async {
  print("post id starts");
  prefs = await SharedPreferences.getInstance();
  r1.emailO = await prefs.getString("username");
  r1.emailV = "pratikgon012@gmail.com";
 // r1.idV = 'v1';
  r1.idS = 's1';
  var body = jsonEncode(r1);
  var url = Uri.parse("http://192.168.0.156:8090/review");
  //final response = await http.Client().post("http://192.168.0.9:8080/login",body: json.encode("hello"));
  await http.post(url, body: body ).then((http.Response response) {
    if (response.statusCode == 200) {
      print("----------------------------------------------------------");
      print(" jsafjdsfkjdshgkjfdkg " +response.body);
      result = response.body;
      print("post id done");
      return ;
    }

  });

}

class WriteReview extends StatefulWidget {
  @override
  _WriteReviewState createState() => _WriteReviewState();
}

class _WriteReviewState extends State<WriteReview> {
  TextEditingController reviewController = TextEditingController();

  //TextEditingController _ratingController;
  double _rating;

  //double _userRating;
  int _ratingBarMode = 1;
  double _initialRating = 0.0;
  bool _isRTLMode = false;
  bool _isVertical = false;

  IconData _selectedIcon;

  @override
  void initState() {
    super.initState();
    saveDetails();
    //_ratingController = TextEditingController(text: r1.rating);
    // _rating = _initialRating;
  }

  void saveDetails() async {
    prefs = await SharedPreferences.getInstance();
    r1.emailO = await prefs.getString("username");
    //prefs.setString('username', username);
    //prefs.setString('password', password);
  }

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    final h = data.size.height;
    final w = data.size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Feedback'),
        backgroundColor: Colors.blueGrey[600],
      ),
      body: Directionality(
        textDirection: _isRTLMode ? TextDirection.rtl : TextDirection.ltr,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 40.0,
              ),
              //_heading('Rating Bar'),
              _ratingBar(_ratingBarMode),
              SizedBox(height: 20.0),
              Text(
                'Rating: $_rating',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Form(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.blueGrey[600], width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  ),
                  width: w * 0.8,
                  height: h * 0.3,
                  child: TextFormField(
                    controller: reviewController,
                    maxLines: 100,
                    keyboardType: TextInputType.multiline,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter pet name';
                      }
                      return null;
                    },
                    decoration: new InputDecoration(
                      // prefixIcon: Icon(Icons.alternate_email),
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Write here ...",
                        hintStyle: TextStyle(fontSize: 13)),
                  ),
                ),
              ),
              FlatButton(
                  onPressed: () async {
                    r1.rating = _rating.toString();
                    r1.review = reviewController.text.toString();

                    await _postReview();
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => MyStatefulWidget()),
                    // );
                  },
                  child: Text(
                    'Submit Review',
                    style: TextStyle(decoration: TextDecoration.underline),
                  )),
            ],

          ),
        ),
      ),
    );
  }

  // Widget _radio(int value) {
  //   return Expanded(
  //     child: RadioListTile<int>(
  //       value: value,
  //       groupValue: _ratingBarMode,
  //       dense: true,
  //       title: Text(
  //         'Mode $value',
  //         style: TextStyle(
  //           fontWeight: FontWeight.w300,
  //           fontSize: 12.0,
  //         ),
  //       ),
  //       onChanged: (value) {
  //         setState(() {
  //           _ratingBarMode = value;
  //         });
  //       },
  //     ),
  //   );
  // }

  Widget _ratingBar(int mode) {
    switch (mode) {
      case 1:
        return RatingBar.builder(
          initialRating: _initialRating,
          minRating: 1,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          unratedColor: Colors.amber.withAlpha(50),
          itemCount: 5,
          itemSize: 50.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) =>
              Icon(
                _selectedIcon ?? Icons.star,
                color: Colors.amber,
              ),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      case 2:
        return RatingBar(
          initialRating: _initialRating,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          allowHalfRating: true,
          itemCount: 5,
          ratingWidget: RatingWidget(
            full: _image('assets/heart.png'),
            half: _image('assets/heart_half.png'),
            empty: _image('assets/heart_border.png'),
          ),
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      case 3:
        return RatingBar.builder(
          initialRating: _initialRating,
          direction: _isVertical ? Axis.vertical : Axis.horizontal,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return Icon(
                  Icons.sentiment_very_dissatisfied,
                  color: Colors.red,
                );
              case 1:
                return Icon(
                  Icons.sentiment_dissatisfied,
                  color: Colors.redAccent,
                );
              case 2:
                return Icon(
                  Icons.sentiment_neutral,
                  color: Colors.amber,
                );
              case 3:
                return Icon(
                  Icons.sentiment_satisfied,
                  color: Colors.lightGreen,
                );
              case 4:
                return Icon(
                  Icons.sentiment_very_satisfied,
                  color: Colors.green,
                );
              default:
                return Container();
            }
          },
          onRatingUpdate: (rating) {
            setState(() {
              _rating = rating;
            });
          },
          updateOnDrag: true,
        );
      default:
        return Container();
    }
  }

  Widget _image(String asset) {
    return Image.asset(
      asset,
      height: 30.0,
      width: 30.0,
      color: Colors.amber,
    );
  }
}

//   Widget _heading(String text) => Column(
//     children: [
//       Text(
//         text,
//         style: TextStyle(
//           fontWeight: FontWeight.w300,
//           fontSize: 24.0,
//         ),
//       ),
//       SizedBox(
//         height: 20.0,
//       ),
//     ],
//   );
// }

// class IconAlert extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       title: Text(
//         'Select Icon',
//         style: TextStyle(
//           fontWeight: FontWeight.w300,
//         ),
//       ),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       titlePadding: EdgeInsets.all(12.0),
//       contentPadding: EdgeInsets.all(0),
//       // content: Wrap(
//       //   children: [
//       //     _iconButton(context, Icons.home),
//       //     _iconButton(context, Icons.airplanemode_active),
//       //     _iconButton(context, Icons.euro_symbol),
//       //     _iconButton(context, Icons.beach_access),
//       //     _iconButton(context, Icons.attach_money),
//       //     _iconButton(context, Icons.music_note),
//       //     _iconButton(context, Icons.android),
//       //     _iconButton(context, Icons.toys),
//       //     _iconButton(context, Icons.language),
//       //     _iconButton(context, Icons.landscape),
//       //     _iconButton(context, Icons.ac_unit),
//       //     _iconButton(context, Icons.star),
//       //   ],
//       // ),
//     );
//   }
//
//   Widget _iconButton(BuildContext context, IconData icon) => IconButton(
//     icon: Icon(icon),
//     onPressed: () => Navigator.pop(context, icon),
//     splashColor: Colors.amberAccent,
//     color: Colors.amber,
//   );
// }









//   final _formKey = GlobalKey<FormState>();
//   TextEditingController reviewController = TextEditingController();
//   int x = 5;
//   @override
//   Widget build(BuildContext context) {
//     final data = MediaQuery.of(context);
//     final h = data.size.height;
//     final w = data.size.width;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Feedback'),
//         backgroundColor: Colors.blueGrey[600],
//       ),
//       body: Center(
//         child: Column(
//           children: [
//             Container(
//               //color: Colors.blueGrey,
//               // height: 20,
//               width: data.size.width * 0.4,
//               alignment: Alignment.centerRight,
//               //color: Colors.blue[100],
//               child: Row(
//                 children: <Widget>[
//                   for (int i = 0; i < x; i++)
//                     Icon(Icons.star,
//                         color: Colors.yellow[700],
//                         size: data.size.width * 0.05),
//                   for (int j = 0; j < 5 - x; j++)
//                     Icon(Icons.star_border_purple500_outlined,
//                         size: data.size.width * 0.05),
//                 ],
//               ),
//             ),
//             Form(
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.blueGrey[600], width: 1.0),
//                   borderRadius: BorderRadius.all(Radius.circular(15.0)),
//                 ),
//                 width: w * 0.8,
//                 height: h * 0.3,
//                 child: TextFormField(
//                   controller: reviewController,
//                   maxLines: 100,
//                   keyboardType: TextInputType.multiline,
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please enter pet name';
//                     }
//                     return null;
//                   },
//                   decoration: new InputDecoration(
//                     // prefixIcon: Icon(Icons.alternate_email),
//                       border: InputBorder.none,
//                       focusedBorder: InputBorder.none,
//                       enabledBorder: InputBorder.none,
//                       errorBorder: InputBorder.none,
//                       disabledBorder: InputBorder.none,
//                       hintText: "Write here ...",
//                       hintStyle: TextStyle(fontSize: 13)),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
