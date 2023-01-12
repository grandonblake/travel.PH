import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import './SignInScreen.dart';

void main() {
  runApp(MaterialApp(
    home: StartUpScreen(),
    debugShowCheckedModeBanner: false,
  ));
}

class StartUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ImageSlideshow(
          width: double.infinity,
          height: double.infinity,
          initialPage: 0,
          indicatorColor: Colors.blue,
          indicatorBackgroundColor: Colors.grey,
          autoPlayInterval: 2000,
          isLoop: true,
          children: [
            Image.asset('assets/images/1.jpg', fit: BoxFit.cover),
            Image.asset('assets/images/2.jpg', fit: BoxFit.cover),
            Image.asset('assets/images/3.jpg', fit: BoxFit.cover),
            Image.asset('assets/images/4.jpg', fit: BoxFit.cover),
            Image.asset('assets/images/5.jpg', fit: BoxFit.cover),
          ]),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigate_next),
          onPressed: () {
            Navigator.pushReplacement<void, void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => SignInScreen(),
              ),
            );
          }),
    );
  }
}
