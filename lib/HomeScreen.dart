import 'package:flutter/material.dart';
import 'package:travelph/main.dart';

import './EditProfileScreen.dart';
import './PlaceScreen.dart';
import './SavedPlacesScreen.dart';
import 'DatabaseHelper.dart';

class HomeScreen extends StatefulWidget {
  Map account;
  HomeScreen(this.account);

  @override
  State<HomeScreen> createState() => _HomeScreenState(account);
}

class _HomeScreenState extends State<HomeScreen> {
  Map account;
  _HomeScreenState(this.account);

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 0) {
    } else if (_selectedIndex == 1) {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => SavedPlacesScreen(account),
        ),
      );
    } else {
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => EditProfileScreen(account),
        ),
      );
    }
  }

  bool alreadyBookmarked = false;

  Future<bool?> checkIfPlaceIsBookmarked(
      String placeName, int accountID) async {
    final dbHelper = DatabaseHelper.instance;

    if (await dbHelper.checkIfPlaceIsAlreadyBookmarked(placeName, accountID)) {
      alreadyBookmarked = true;
    } else {
      alreadyBookmarked = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: NavDrawer(account),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://media.discordapp.net/attachments/1042008792545624067/1050057709321465887/image.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          //Pagudpud Beach - Ilocos Norte
          Positioned(
            top: 90,
            left: 135,
            child: IconButton(
              icon: Image.network(
                'https://cdn.discordapp.com/attachments/1042817502071246878/1042817524812763176/unknown.png',
                width: 32,
                height: 32,
              ),
              onPressed: () {
                final placeDetails = {
                  'placeName': 'Pagudpud Beach',
                  'placeLocation': 'Pagudpud, Ilocos Norte',
                  'placeDescription':
                      'It is known as the “Boracay of the North”, but it has so much more to offer apart from its pristine coastline. Pagudpud\'s Bangui Bay also features 20 wind turbines, which makes it Southeast Asia\'s first windmill farm. Pagudpud is also a highly popular surfing site.',
                  'placeImage':
                      'https://images.pexels.com/photos/457882/pexels-photo-457882.jpeg?auto=compress&cs=tinysrgb&w=1600',
                };

                checkIfPlaceIsBookmarked(
                    placeDetails['placeName']!, account['accountID']);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaceScreen(
                          account, placeDetails, alreadyBookmarked)),
                );
              },
            ),
          ),
          //Burnham Park - Bagui
          Positioned(
            top: 160,
            left: 125,
            child: IconButton(
              icon: Image.network(
                'https://cdn.discordapp.com/attachments/1042817502071246878/1042817524812763176/unknown.png',
                width: 32,
                height: 32,
              ),
              onPressed: () {
                final placeDetails = {
                  'placeName': 'Burnham Park',
                  'placeLocation': 'Baguio, Benguet',
                  'placeDescription':
                      'Pretty and historic urban park located in downtown Baguio, Philippines',
                  'placeImage':
                      'https://images.unsplash.com/photo-1656339129844-1b4b3cff774c?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=735&q=80',
                };

                checkIfPlaceIsBookmarked(
                    placeDetails['placeName']!, account['accountID']);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaceScreen(
                          account, placeDetails, alreadyBookmarked)),
                );
              },
            ),
          ),
          //Manila City - NCR
          Positioned(
            top: 230,
            right: 210,
            child: IconButton(
              icon: Image.network(
                'https://cdn.discordapp.com/attachments/1042817502071246878/1042817524812763176/unknown.png',
                width: 32,
                height: 32,
              ),
              onPressed: () {
                final placeDetails = {
                  'placeName': 'Manila City',
                  'placeLocation': 'Manila, NCR',
                  'placeDescription':
                      'Manila, capital and chief city of the Philippines. The city is the centre of the country\'s economic, political, social, and cultural activity. A densely populated bayside city on the island of Luzon, which mixes Spanish colonial architecture with modern skyscrapers.',
                  'placeImage':
                      'https://images.unsplash.com/photo-1519010470956-6d877008eaa4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=688&q=80',
                };

                checkIfPlaceIsBookmarked(
                    placeDetails['placeName']!, account['accountID']);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaceScreen(
                          account, placeDetails, alreadyBookmarked)),
                );
              },
            ),
          ),
          //Suyac Mangrove - Negros Occidental
          Positioned(
            bottom: 180,
            right: 126,
            child: IconButton(
              icon: Image.network(
                'https://cdn.discordapp.com/attachments/1042817502071246878/1042817524812763176/unknown.png',
                width: 32,
                height: 32,
              ),
              onPressed: () {
                final placeDetails = {
                  'placeName': 'Suyac Mangrove',
                  'placeLocation': 'Sagay, Negros Occidental',
                  'placeDescription':
                      'The park is home to one of the oldest and largest Sonneratia Alba mangrove on Negros Island, and includes other mangrove species. It is located in the center of the 32,000-hectare Sagay Marine Reserve, the first of its kind in the country and established sometime in the 80s.',
                  'placeImage':
                      'https://images.unsplash.com/photo-1556768555-ee22fbdc8a61?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                };

                checkIfPlaceIsBookmarked(
                    placeDetails['placeName']!, account['accountID']);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaceScreen(
                          account, placeDetails, alreadyBookmarked)),
                );
              },
            ),
          ),
          //Cebu City - Cebu Island
          Positioned(
            bottom: 170,
            right: 104,
            child: IconButton(
              icon: Image.network(
                'https://cdn.discordapp.com/attachments/1042817502071246878/1042817524812763176/unknown.png',
                width: 32,
                height: 32,
              ),
              onPressed: () {
                final placeDetails = {
                  'placeName': 'Cebu City',
                  'placeLocation': 'Cebu City, Cebu Island',
                  'placeDescription':
                      'It is one of the country\'s largest cities and is a bustling port. Its harbour is provided by the sheltered strait between Mactan Island and the coast. The country\'s oldest settlement, it is also one of its most historic and retains much of the flavour of its long Spanish heritage.',
                  'placeImage':
                      'https://images.unsplash.com/photo-1505261476952-32e25cbfc755?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1511&q=80',
                };

                checkIfPlaceIsBookmarked(
                    placeDetails['placeName']!, account['accountID']);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaceScreen(
                          account, placeDetails, alreadyBookmarked)),
                );
              },
            ),
          ),
          //Yapak Beach - Aklan
          Positioned(
            bottom: 230,
            left: 195,
            child: IconButton(
              icon: Image.network(
                'https://cdn.discordapp.com/attachments/1042817502071246878/1042817524812763176/unknown.png',
                width: 32,
                height: 32,
              ),
              onPressed: () {
                final placeDetails = {
                  'placeName': 'Yapak Beach',
                  'placeLocation': 'Malay, Aklan',
                  'placeDescription':
                      'Along the northern shores of Boracay is the pristine 800-meter Yapak Beach, more popularly known as Puka Beach for its plethora of white sand coupled with puka shells, a naturally occurring bead-like seashell.',
                  'placeImage':
                      'https://boracaybeach.guide/wp-content/uploads/2020/04/Puka-Beach-Boracay-Beach-Island-Guide-in-the-Philippines-.jpg',
                };

                checkIfPlaceIsBookmarked(
                    placeDetails['placeName']!, account['accountID']);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaceScreen(
                          account, placeDetails, alreadyBookmarked)),
                );
              },
            ),
          ),
          //Tuka Marine Park - Sarangani
          Positioned(
            bottom: 20,
            right: 65,
            child: IconButton(
              icon: Image.network(
                'https://cdn.discordapp.com/attachments/1042817502071246878/1042817524812763176/unknown.png',
                width: 32,
                height: 32,
              ),
              onPressed: () {
                final placeDetails = {
                  'placeName': 'Tuka Marine Park',
                  'placeLocation': 'Kiamba, Sarangani',
                  'placeDescription':
                      'Tuka Marine Park in Kiamba, Sarangani is a true marvel for everyone who finds joy in exploring life underneath the seas. It is a marine sanctuary that boasts colorful and rich marine biodiversity that has been thriving for years through the protection and conservation efforts of the surrounding community.',
                  'placeImage':
                      'https://vismin.ph/wp-content/uploads/2021/04/Tuna-Marine-Park-Sarangani-13-1024x572.jpg',
                };

                checkIfPlaceIsBookmarked(
                    placeDetails['placeName']!, account['accountID']);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaceScreen(
                          account, placeDetails, alreadyBookmarked)),
                );
              },
            ),
          ),
          //Davao City - Davao del Sur
          Positioned(
            bottom: 50,
            right: 38,
            child: IconButton(
              icon: Image.network(
                'https://cdn.discordapp.com/attachments/1042817502071246878/1042817524812763176/unknown.png',
                width: 32,
                height: 32,
              ),
              onPressed: () {
                final placeDetails = {
                  'placeName': 'Davao City',
                  'placeLocation': 'Davao, Davao del Sur',
                  'placeDescription':
                      'It is a popular tourist destination because it has got a lot of varied sites that you can visit. There are different kinds of museums and parks that you can visit. The place is also home to one of the tallest mountains, Mount Apo.',
                  'placeImage':
                      'https://content.r9cdn.net/rimg/dimg/18/6b/dbb048f0-city-17145-17ea231f3b1.jpg?crop=true&width=1366&height=768&xhint=1433&yhint=1209',
                };

                checkIfPlaceIsBookmarked(
                    placeDetails['placeName']!, account['accountID']);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaceScreen(
                          account, placeDetails, alreadyBookmarked)),
                );
              },
            ),
          ),
          //Magpupungko Beach - Surigao del Norte
          Positioned(
            bottom: 120,
            right: 15,
            child: IconButton(
              icon: Image.network(
                'https://cdn.discordapp.com/attachments/1042817502071246878/1042817524812763176/unknown.png',
                width: 32,
                height: 32,
              ),
              onPressed: () {
                final placeDetails = {
                  'placeName': 'Magpupungko Beach',
                  'placeLocation': 'Siaorgao, Surigao del Norte',
                  'placeDescription':
                      'Magpupungko boasts a beautiful white sand beach overlooking a stunning ocean with big waves clashing onto the rocks at a far distance. There\'s a chill atmosphere at the beach, and it\'s a good time to relax after an adventurous experience at the rock pools and cliff diving spots.',
                  'placeImage':
                      'https://unexploredfootsteps.com/wp-content/uploads/2020/04/Siargao-Rock-Pools.jpeg',
                };

                checkIfPlaceIsBookmarked(
                    placeDetails['placeName']!, account['accountID']);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PlaceScreen(
                          account, placeDetails, alreadyBookmarked)),
                );
              },
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[800],
        onTap: _onItemTapped,
      ),
    );
  }
}

class NavDrawer extends StatelessWidget {
  Map account;
  NavDrawer(this.account);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 220,
      child: ListView(
        children: [
          ListTile(
            leading: Icon(Icons.account_circle, size: 45),
            title: Text(
                account['accountFirstName'] + " " + account['accountLastName'],
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          Divider(thickness: 2),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () => {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => HomeScreen(account),
                ),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Saved Places'),
            onTap: () => {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => SavedPlacesScreen(account),
                ),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => EditProfileScreen(account),
                ),
              )
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(color: Colors.red),
            ),
            onTap: () => {
              Navigator.pushReplacement<void, void>(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => StartUpScreen(),
                ),
              )
            },
          ),
        ],
      ),
    );
  }
}
