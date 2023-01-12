import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:sqflite/sqflite.dart';

import './PlaceCommentsScreen.dart';
import './DatabaseHelper.dart';

class PlaceScreen extends StatefulWidget {
  Map account;
  Map placeDetails;
  bool alreadyBookmarked;
  PlaceScreen(this.account, this.placeDetails, this.alreadyBookmarked);

  @override
  State<PlaceScreen> createState() =>
      _PlaceScreenState(account, placeDetails, alreadyBookmarked);
}

class _PlaceScreenState extends State<PlaceScreen> {
  Map account;
  Map placeDetails;
  bool alreadyBookmarked;
  _PlaceScreenState(this.account, this.placeDetails, this.alreadyBookmarked);

  //NAVIGATION ANIMATION FOR PLACE COMMENTS (UP-DOWN)
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          PlaceCommentsScreen(
        account,
        placeDetails['placeName'],
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 1.0);
        const end = Offset.zero;
        const curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  final dbHelper = DatabaseHelper.instance;

  getPlaceDetails() {
    return {
      DatabaseHelper.columnPlaceName: placeDetails['placeName'],
      DatabaseHelper.columnPlaceLocation: placeDetails['placeLocation'],
      DatabaseHelper.columnPlaceDescription: placeDetails['placeDescription'],
      DatabaseHelper.columnPlaceImage: placeDetails['placeImage'],
      DatabaseHelper.columnPlaceAccountID: account['accountID'],
    };
  }

  void _insertPlaceIntoTable(value) async {
    await dbHelper.insertPlaceIntoTable(value);
  }

  void _deletePlaceInsideTable(String placeName, int accountID) async {
    await dbHelper.deletePlaceInsideTable(placeName, accountID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: HexColor("#3f60a0"),
      ),
      body: Container(
        child: Column(
          children: [
            //top container
            Expanded(
              flex: 7,
              child: Container(
                constraints: BoxConstraints.expand(),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(placeDetails['placeImage']),
                      fit: BoxFit.cover),
                ),
              ),
            ),
            //bottom container
            Expanded(
              flex: 3,
              child: Container(
                margin: EdgeInsets.fromLTRB(15, 15, 15, 5),
                child: Column(
                  children: [
                    //for place name and icons
                    Expanded(
                      flex: 2,
                      child: Row(
                        children: [
                          Text(
                            placeDetails['placeName'],
                            style: TextStyle(
                              color: HexColor("#3f60a0"),
                              fontSize: 17,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            constraints: BoxConstraints(),
                            icon: Icon(
                              Icons.add_comment_outlined,
                              color: HexColor("#3f60a0"),
                            ),
                            onPressed: () {
                              Navigator.of(context).push(_createRoute());
                            },
                          ),
                          IconButton(
                            padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                            constraints: BoxConstraints(),
                            icon: alreadyBookmarked == false
                                ? Icon(
                                    Icons.bookmark_border,
                                    color: HexColor("#3f60a0"),
                                  )
                                : Icon(
                                    Icons.bookmark,
                                    color: HexColor("#3f60a0"),
                                  ),
                            onPressed: () => setState(() {
                              if (!alreadyBookmarked) {
                                //if bookmark is not pressed

                                _insertPlaceIntoTable(getPlaceDetails());
                              } else {
                                _deletePlaceInsideTable(
                                    placeDetails['placeName'],
                                    account['accountID']);
                              }
                              alreadyBookmarked = !alreadyBookmarked;
                            }),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          placeDetails['placeLocation'],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: HexColor("#3c5062"),
                            fontSize: 10,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                    ),

                    //for description
                    Expanded(
                      flex: 7,
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Text(
                          placeDetails['placeDescription'],
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: HexColor("#3b4848"),
                            fontSize: 11,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w500,
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
    );
  }
}
