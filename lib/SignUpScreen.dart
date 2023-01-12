import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './DatabaseHelper.dart';
import './SignInScreen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final dbHelper = DatabaseHelper.instance;

  //show the password or not
  bool _isObscure = true;
  bool _isObscure2 = true;
  bool isChecked = false;
  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final _textFirstName = TextEditingController();
  final _textLastName = TextEditingController();
  final _textUsername = TextEditingController();
  final _textPassword = TextEditingController();
  final _textConfirmPassword = TextEditingController();
  bool _validate = false;
  bool _validate2 = false;
  bool _validate3 = false;
  bool _validate4 = false;
  bool _validate5 = false;
  Color checkboxColor = Colors.black;

  Map<String, String> getAccountDetails() {
    //gets the account details from the text fields
    return {
      DatabaseHelper.columnAccountUsername: _textUsername.text,
      DatabaseHelper.columnAccountPassword: _textPassword.text,
      DatabaseHelper.columnAccountFirstName: _textFirstName.text,
      DatabaseHelper.columnAccountLastName: _textLastName.text,
    };
  }

  @override
  void dispose() {
    _textFirstName.dispose();
    _textLastName.dispose();
    _textUsername.dispose();
    _textPassword.dispose();
    _textConfirmPassword.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                width: 250,
                padding: EdgeInsets.only(top: 60.0),
                child: const Text(
                  "Sign Up",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, height: 1, fontSize: 50),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 250,
                padding: EdgeInsets.only(top: 20.0),
                child: const Text(
                  "Please complete your",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      height: 1,
                      fontSize: 15),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 250,
                padding: EdgeInsets.only(bottom: 30.0),
                child: const Text(
                  "biodata correctly",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins',
                      height: 0,
                      fontSize: 15),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    alignment: Alignment.center,
                    width: 160,
                    padding: EdgeInsets.only(right: 2, bottom: 5.0),
                    child: TextFormField(
                      controller: _textFirstName,
                      autocorrect: true,
                      decoration: InputDecoration(
                        labelText: 'First Name',
                        border: OutlineInputBorder(),
                        errorText: _validate ? 'First Name is required' : null,
                      ),
                    )),
                Container(
                    alignment: Alignment.center,
                    width: 160,
                    padding: EdgeInsets.only(left: 2, bottom: 5.0),
                    child: TextFormField(
                      controller: _textLastName,
                      autocorrect: true,
                      decoration: InputDecoration(
                        labelText: 'Last Name',
                        border: OutlineInputBorder(),
                        errorText: _validate2 ? 'Last Name is required' : null,
                      ),
                    )),
              ]),
              Container(
                  width: 340,
                  padding: EdgeInsets.all(10.0),
                  child: TextFormField(
                    controller: _textUsername,
                    autocorrect: true,
                    decoration: InputDecoration(
                      labelText: 'Username',
                      border: OutlineInputBorder(),
                      errorText: _validate3 ? 'Username is required' : null,
                    ),
                  )),
              Container(
                width: 340,
                padding: EdgeInsets.all(10.0),
                child: TextFormField(
                  obscureText: _isObscure,
                  controller: _textPassword,
                  autocorrect: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      errorText: _validate4 ? 'Password is required' : null,
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
                padding: EdgeInsets.all(10.0),
                width: 340,
                child: TextFormField(
                  obscureText: _isObscure2,
                  controller: _textConfirmPassword,
                  autocorrect: true,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      errorText:
                          _validate5 ? 'Confirm Password is required' : null,
                      labelText: 'Confirm Password',
                      suffixIcon: IconButton(
                          icon: Icon(_isObscure2
                              ? Icons.visibility_off
                              : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _isObscure2 = !_isObscure2;
                            });
                          })),
                ),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    padding: EdgeInsets.only(top: 10),
                    child: Checkbox(
                      checkColor: Colors.white,
                      fillColor:
                          MaterialStateProperty.all<Color>(checkboxColor),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                          checkboxColor = Colors.black;
                        });
                      },
                    )),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'I agree to the ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                            text: 'Terms',
                            style: TextStyle(color: Colors.blueAccent),
                            recognizer: TapGestureRecognizer()),
                        TextSpan(
                          text: ' and ',
                          style: TextStyle(color: Colors.grey),
                        ),
                        TextSpan(
                            text: 'Conditions',
                            style: TextStyle(color: Colors.blueAccent),
                            recognizer: TapGestureRecognizer()),
                      ],
                    ),
                  ),
                ),
              ]),
              Container(
                  width: 300,
                  height: 80,
                  padding: EdgeInsets.only(top: 30),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _textFirstName.text.isEmpty
                            ? _validate = true
                            : _validate = false;
                        _textLastName.text.isEmpty
                            ? _validate2 = true
                            : _validate2 = false;
                        _textUsername.text.isEmpty
                            ? _validate3 = true
                            : _validate3 = false;
                        _textPassword.text.isEmpty
                            ? _validate4 = true
                            : _validate4 = false;
                        _textConfirmPassword.text.isEmpty
                            ? _validate5 = true
                            : _validate5 = false;

                        isChecked
                            ? checkboxColor = Colors.black
                            : checkboxColor = Colors.red;

                        //if all fields are not empty and if checkbox is checked
                        if (_validate == false &&
                            _validate2 == false &&
                            _validate3 == false &&
                            _validate4 == false &&
                            _validate5 == false &&
                            isChecked == true) {
                          dbHelper
                              .getAccountUsername(_textUsername.text)
                              .then((value) {
                            //runs the getAccount in DatabaseHelper.dart then the result/value returned will go inside the if-else statement
                            if (value == null) {
                              //if return value is null which means there is no similar account then register

                              if (_textPassword.text ==
                                  _textConfirmPassword.text) {
                                //if Password is the same as confirmPassword
                                dbHelper.insertAccount(
                                    getAccountDetails()); //adds the account details to the database

                                //successfulDialog constructor
                                Future<void> showMyDialog() async {
                                  return showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Registration Successful'),
                                        icon: Icon(Icons.check),
                                        iconColor: Colors.green,
                                        actions: <Widget>[
                                          TextButton(
                                            child: const Text('Dismiss'),
                                            onPressed: () {
                                              Navigator.pushReplacement<void,
                                                  void>(
                                                //moves the screen to the SignInScreen
                                                context,
                                                MaterialPageRoute<void>(
                                                  builder:
                                                      (BuildContext context) =>
                                                          SignInScreen(),
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
                              } else {
                                //if Password is not the same as confirmPassword then show alert dialog

                                //alertDialog constructor
                                Future<void> showMyDialog() async {
                                  return showDialog<void>(
                                    context: context,
                                    barrierDismissible:
                                        false, // user must tap button!
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Registration Failed'),
                                        icon: Icon(Icons.error),
                                        iconColor: Colors.red,
                                        content: SingleChildScrollView(
                                            child: Text(
                                                'Password is not the same!',
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
                              }
                            } else {
                              //if return value is not null which means there is a similar account then show alert dialog

                              //alertDialog constructor
                              Future<void> showMyDialog() async {
                                return showDialog<void>(
                                  context: context,
                                  barrierDismissible:
                                      false, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('Registration Failed'),
                                      icon: Icon(Icons.error),
                                      iconColor: Colors.red,
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: const <Widget>[
                                            Text('Username is already taken!',
                                                textAlign: TextAlign.center),
                                            Text('Kindly use another username.',
                                                textAlign: TextAlign.center),
                                          ],
                                        ),
                                      ),
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
                            }
                          });
                        }
                      });
                    },
                    child: Text('Create your Account'),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )),
              Container(
                padding: EdgeInsets.only(top: 20, left: 5),
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(color: Colors.grey),
                      ),
                      TextSpan(
                          text: 'Sign In now!',
                          style: TextStyle(color: Colors.blueAccent),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushReplacement<void, void>(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (BuildContext context) =>
                                      SignInScreen(),
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
