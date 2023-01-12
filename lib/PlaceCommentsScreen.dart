import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import './DatabaseHelper.dart';

class PlaceCommentsScreen extends StatefulWidget {
  Map account;
  String placeName;
  PlaceCommentsScreen(
    this.account,
    this.placeName,
  );

  @override
  State<PlaceCommentsScreen> createState() =>
      _PlaceCommentsScreenState(account, placeName);
}

class _PlaceCommentsScreenState extends State<PlaceCommentsScreen> {
  Map account;
  String placeName;
  _PlaceCommentsScreenState(this.account, this.placeName);

  final dbHelper = DatabaseHelper.instance;

  TextEditingController commentTextFieldValue = TextEditingController();

  Future<List<Map>> _fetchCommentsFromTable(String placeName) async {
    return await dbHelper.getCommentOfPlace(placeName);
  }

  getCommentDetails() {
    return {
      DatabaseHelper.columnCommentFullName:
          account['accountFirstName'] + " " + account['accountLastName'],
      DatabaseHelper.columnCommentPlaceName: placeName,
      DatabaseHelper.columnCommentText: commentTextFieldValue.text,
    };
  }

  void _insertCommentIntoTable(value) async {
    await dbHelper.insertCommentIntoTable(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Flex(
      direction: Axis.vertical,
      children: [
        Expanded(
          flex: 1,
          child: Container(
              width: double.infinity,
              color: HexColor("#3f60a0"),
              margin: EdgeInsets.only(top: 5),
              child: Transform.scale(
                scale: 1.5,
                child: IconButton(
                  icon: Icon(Icons.expand_less),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              )),
        ),
        Expanded(
          flex: 8,
          child: FutureBuilder<List<Map>>(
            future: _fetchCommentsFromTable(placeName),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                    child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: Icon(Icons.account_circle, size: 50),
                            title: Text(
                                snapshot.data![index]['commentFullName'],
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold)),
                            subtitle: Text(snapshot.data![index]['commentText'],
                                style: TextStyle(fontSize: 12)),
                          );
                        }));
              } else if (snapshot.hasError) {
                return new Text("${snapshot.error}");
              }
              return new Container(
                alignment: AlignmentDirectional.center,
                child: new CircularProgressIndicator(),
              );
            },
          ),
        ),
        Expanded(
            flex: 1,
            child: ListTile(
              tileColor: HexColor("#3f60a0"),
              leading: Icon(Icons.attach_file, size: 30, color: Colors.white),
              title: TextField(
                controller: commentTextFieldValue,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 2, color: Colors.white)),
                  hintText: 'Write a comment...',
                  hintStyle: TextStyle(color: Colors.white),
                ),
              ),
              trailing: IconButton(
                  icon: Icon(Icons.send, size: 30),
                  color: Colors.white,
                  onPressed: () {
                    _insertCommentIntoTable(getCommentDetails());
                    setState(() {});

                    commentTextFieldValue.clear();
                  }),
            ))
      ],
    ));
  }
}
