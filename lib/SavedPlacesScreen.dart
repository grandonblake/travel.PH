import 'package:flutter/material.dart';

import './HomeScreen.dart';
import './EditProfileScreen.dart';
import 'DatabaseHelper.dart';

class SavedPlacesScreen extends StatefulWidget {
  Map account;
  SavedPlacesScreen(this.account);

  @override
  State<SavedPlacesScreen> createState() => _SavedPlacesScreenState(account);
}

class _SavedPlacesScreenState extends State<SavedPlacesScreen> {
  Map account;
  _SavedPlacesScreenState(this.account);

  int _selectedIndex = 1;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 0) {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => HomeScreen(account),
        ),
      );
    } else if (_selectedIndex == 1) {
    } else {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => EditProfileScreen(account),
        ),
      );
    }
  }

  final dbHelper = DatabaseHelper.instance;

  Future<List<Map>> _fetchPlacesOfAccount(int accountID) async {
    return await dbHelper.getPlacesOfAccount(accountID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(account),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Flex(direction: Axis.vertical, children: [
          Expanded(
            flex: 2,
            child: Container(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  'SAVED',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    height: 1,
                    fontSize: 64,
                    fontFamily: 'Mont',
                    color: Color.fromARGB(255, 48, 48, 48),
                  ),
                )),
          ),
          Divider(
            color: Colors.blue[800],
            height: 2,
            thickness: 3,
            indent: 80,
            endIndent: 80,
          ),
          Expanded(
            flex: 8,
            child: FutureBuilder<List<Map>>(
              future: _fetchPlacesOfAccount(account['accountID']),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                      margin: EdgeInsets.only(top: 20, left: 50, right: 50),
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.only(bottom: 10),
                                child: Material(
                                  //material widget avoids color bleeds into its top widget
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                        width: 5,
                                        color: Colors.blue,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    leading: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                        snapshot.data![index]['placeImage'],
                                      ),
                                    ),
                                    tileColor: Colors.blue,
                                    title: Text(
                                      snapshot.data![index]['placeName'],
                                      style: TextStyle(
                                        fontFamily: 'Mont',
                                        fontWeight: FontWeight.bold,
                                        height: 1,
                                        fontSize: 24,
                                        color: Colors.white,
                                      ),
                                    ),
                                    subtitle: Text(
                                      snapshot.data![index]['placeLocation'],
                                      style: TextStyle(
                                        fontFamily: 'Mont',
                                        height: 1,
                                        fontSize: 12,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ));
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
          )
        ]),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bookmark),
              label: 'Saved Places',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            )
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          onTap: _onItemTapped,
        ));
  }
}
