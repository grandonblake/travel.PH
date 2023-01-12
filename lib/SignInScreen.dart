import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './SignUpScreen.dart';
import './DatabaseHelper.dart';
import './HomeScreen.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final dbHelper = DatabaseHelper.instance;
  // show the password or not
  bool _isObscure = true;

  final textUsername = TextEditingController();
  final textPassword = TextEditingController();
  bool _validate = false;
  bool _validate2 = false;

  @override
  void dispose() {
    textUsername.dispose();
    textPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: 'Mont',
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 5),
                child: Text(
                  'To continue using this app,',
                  style: TextStyle(
                    height: 1,
                    fontSize: 14,
                    fontFamily: 'Mont',
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Text(
                  'please sign in first.',
                  style: TextStyle(
                    height: 1,
                    fontSize: 14,
                    fontFamily: 'Mont',
                  ),
                ),
              ),
              Container(
                width: 250,
                height: 250,
                padding: EdgeInsets.all(0.0),
                child: Image.asset(
                  'assets/images/title.png',
                  fit: BoxFit.fill,
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  width: 320,
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    style: TextStyle(fontFamily: 'Mont'),
                    controller: textUsername,
                    autocorrect: true,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      errorText: _validate ? 'Username is required' : null,
                    ),
                  )),
              Container(
                width: 320,
                padding: EdgeInsets.all(10.0),
                child: TextField(
                  style: TextStyle(fontFamily: 'Mont'),
                  controller: textPassword,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                      errorText: _validate2 ? 'Password is required' : null,
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          })),
                ),
              ),
              Container(
                  width: 320,
                  height: 65,
                  padding: EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        textUsername.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                        textPassword.text.isEmpty
                            ? _validate2 = true
                            : _validate2 = false;

                        dbHelper
                            .getAccountDetails(textUsername.text)
                            .then((value) {
                          //runs the getAccountLogin in DatabaseHelper.dart then the result/value returned will go inside the if-else statement
                          if (textUsername.text.isEmpty ||
                              textPassword.text.isEmpty) {
                            //if username textfield OR password textfield is empty
                            Future<void> showMyDialog() async {
                              return showDialog<void>(
                                context: context,
                                barrierDismissible:
                                    false, // user must tap button!
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text('Log-in Error'),
                                    icon: Icon(Icons.error),
                                    iconColor: Colors.red,
                                    content: SingleChildScrollView(
                                        child: Text('Incomplete Login Details!',
                                            textAlign: TextAlign.center)),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('Dismiss'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }

                            //runs the alertDialog
                            showMyDialog();
                          } else {
                            if (value == null) {
                              //if account doesn't exist

                              Future<void> showMyDialog() async {
                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Log-in Error'),
                                      icon: Icon(Icons.error),
                                      iconColor: Colors.red,
                                      content: SingleChildScrollView(
                                          child: Text('Account does not exist!',
                                              textAlign: TextAlign.center)),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Dismiss'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }

                              //runs the alertDialog
                              showMyDialog();
                            } else {
                              //if account exists

                              if (textPassword.text !=
                                  value['accountPassword']) {
                                //if password in textField is not the same with account's password
                                Future<void> showMyDialog() async {
                                  return showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Log-in Error'),
                                        icon: Icon(Icons.error),
                                        iconColor: Colors.red,
                                        content: SingleChildScrollView(
                                            child: Text(
                                                'Incorrect Login Details!',
                                                textAlign: TextAlign.center)),
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Dismiss'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }

                                //runs the alertDialog
                                showMyDialog();
                              } else {
                                Future<void> showMyDialog() async {
                                  return showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Log-in Successful'),
                                        icon: Icon(Icons.check),
                                        iconColor: Colors.green,
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Dismiss'),
                                            onPressed: () {
                                              Navigator.pushReplacement<void,
                                                  void>(
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          HomeScreen(value),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                }

                                //runs the alertDialog
                                showMyDialog();
                              }
                            }
                          }
                        });
                      });
                    },
                    child: Text('Sign In'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )),
              Container(
                padding: EdgeInsets.all(5.0),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Don\'t have an account yet? ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextSpan(
                          text: 'Sign Up now!',
                          style: TextStyle(color: Colors.blueAccent),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement<void, void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      SignUpScreen(),
                                ),
                              );
                            }),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
