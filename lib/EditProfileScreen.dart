import 'package:flutter/material.dart';

import './HomeScreen.dart';
import 'DatabaseHelper.dart';
import 'SignInScreen.dart';
import './SavedPlacesScreen.dart';

class EditProfileScreen extends StatefulWidget {
  Map account;
  EditProfileScreen(this.account);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState(account);
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Map account;
  _EditProfileScreenState(this.account);

  int _selectedIndex = 2;

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
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => SavedPlacesScreen(account),
        ),
      );
    } else {}
  }

  bool currentlyEditing = false;
  bool areTextFieldsEnabled = false;

  bool _obscurePasswordTextField = true;
  bool _obscureConfirmPasswordTextField = true;
  bool _obscurePasswordIcon = true;
  bool _obscureConfirmPasswordIcon = true;

  bool firstNameTextFieldEmpty = false;
  bool lastNameTextFieldEmpty = false;
  bool usernameTextFieldEmpty = false;
  bool passwordTextFieldEmpty = false;
  bool confirmPasswordTextFieldEmpty = false;

  TextEditingController firstNameTextField = TextEditingController();
  TextEditingController lastNameTextField = TextEditingController();
  TextEditingController usernameTextField = TextEditingController();
  TextEditingController passwordTextField = TextEditingController();
  TextEditingController confirmPasswordTextField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(account),
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        body: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 2,
              child: Text(
                "Profile",
                style: TextStyle(
                  fontSize: 50,
                  fontFamily: 'Mont',
                  fontWeight: FontWeight.w900,
                ),
              ),
            ), //FIRST EXPANDED AT TOP
            Expanded(
              flex: 8,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 145,
                          margin: EdgeInsets.only(right: 10),
                          child: TextField(
                            //FIRST NAME
                            style: TextStyle(fontFamily: 'Mont'),
                            controller: firstNameTextField
                              ..text = account[
                                  'accountFirstName'], //cascading operator (..)
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              border: OutlineInputBorder(),
                              enabled: areTextFieldsEnabled,
                              errorText: firstNameTextFieldEmpty
                                  ? 'First Name is required'
                                  : null,
                            ),
                          ),
                        ),
                        Container(
                          width: 145,
                          child: TextField(
                            //LAST NAME
                            style: TextStyle(fontFamily: 'Mont'),
                            controller: lastNameTextField
                              ..text = account[
                                  'accountLastName'], //cascading operator (..),
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              border: OutlineInputBorder(),
                              enabled: areTextFieldsEnabled,
                              errorText: lastNameTextFieldEmpty
                                  ? 'Last Name is required'
                                  : null,
                            ),
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 300,
                      margin: EdgeInsets.only(top: 10),
                      child: TextField(
                        //USERNAME
                        style: TextStyle(fontFamily: 'Mont'),
                        controller: usernameTextField
                          ..text = account[
                              'accountUsername'], //cascading operator (..),
                        decoration: InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                          enabled: areTextFieldsEnabled,
                          errorText: usernameTextFieldEmpty
                              ? 'Username is required'
                              : null,
                        ),
                      ),
                    ),
                    Container(
                      width: 300,
                      margin: EdgeInsets.only(top: 10),
                      child: TextField(
                        //PASSWORD
                        style: TextStyle(fontFamily: 'Mont'),
                        controller: passwordTextField,
                        obscureText: _obscurePasswordTextField,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            enabled: areTextFieldsEnabled,
                            errorText: passwordTextFieldEmpty
                                ? 'Password is required'
                                : null,
                            suffixIcon: IconButton(
                              icon: Icon(_obscurePasswordIcon
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                _obscurePasswordTextField =
                                    !_obscurePasswordTextField;

                                _obscurePasswordIcon = !_obscurePasswordIcon;
                                setState(() {});
                              },
                            )),
                      ),
                    ),
                    Container(
                      width: 300,
                      margin: EdgeInsets.only(top: 10),
                      child: TextField(
                        //CONFIRM PASSWORD
                        style: TextStyle(fontFamily: 'Mont'),
                        controller: confirmPasswordTextField,
                        obscureText: _obscureConfirmPasswordTextField,
                        decoration: InputDecoration(
                            labelText: 'Confirm Password',
                            border: OutlineInputBorder(),
                            enabled: areTextFieldsEnabled,
                            errorText: confirmPasswordTextFieldEmpty
                                ? 'Confirm Password is required'
                                : null,
                            suffixIcon: IconButton(
                              icon: Icon(_obscureConfirmPasswordIcon
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(() {
                                  _obscureConfirmPasswordTextField =
                                      !_obscureConfirmPasswordTextField;

                                  _obscureConfirmPasswordIcon =
                                      !_obscureConfirmPasswordIcon;
                                });
                              },
                            )),
                      ),
                    )
                  ],
                ),
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
        floatingActionButton: FloatingActionButton(
            child: !currentlyEditing ? Icon(Icons.edit) : Icon(Icons.save),
            onPressed: () {
              setState(() {
                if (!currentlyEditing) {
                  //if not currently editing then edit mode
                  currentlyEditing = !currentlyEditing;
                  areTextFieldsEnabled = !areTextFieldsEnabled;
                } else {
                  //if currently editing then check if text fields are empty
                  firstNameTextField.text.isEmpty
                      ? firstNameTextFieldEmpty = true
                      : firstNameTextFieldEmpty = false;

                  lastNameTextField.text.isEmpty
                      ? lastNameTextFieldEmpty = true
                      : lastNameTextFieldEmpty = false;

                  usernameTextField.text.isEmpty
                      ? usernameTextFieldEmpty = true
                      : usernameTextFieldEmpty = false;

                  passwordTextField.text.isEmpty
                      ? passwordTextFieldEmpty = true
                      : passwordTextFieldEmpty = false;

                  confirmPasswordTextField.text.isEmpty
                      ? confirmPasswordTextFieldEmpty = true
                      : confirmPasswordTextFieldEmpty = false;

                  if (!firstNameTextFieldEmpty &&
                      !lastNameTextFieldEmpty &&
                      !usernameTextFieldEmpty &&
                      !passwordTextFieldEmpty &&
                      !confirmPasswordTextFieldEmpty) //if all fields are not empty and currently editing
                  {
                    if (passwordTextField.text ==
                        confirmPasswordTextField.text) {
                      //check if password and confirmPassword is the same
                      currentlyEditing = !currentlyEditing;
                      areTextFieldsEnabled = !areTextFieldsEnabled;

                      Map<String, String> getAccountDetails() {
                        //gets the account details from the text fields
                        return {
                          DatabaseHelper.columnAccountUsername:
                              usernameTextField.text,
                          DatabaseHelper.columnAccountPassword:
                              passwordTextField.text,
                          DatabaseHelper.columnAccountFirstName:
                              firstNameTextField.text,
                          DatabaseHelper.columnAccountLastName:
                              lastNameTextField.text,
                        };
                      }

                      final dbHelper = DatabaseHelper.instance;

                      dbHelper.updateAccount(
                          getAccountDetails(), account['accountUsername']);

                      Map<String, String> getAccountDetails2() {
                        //gets the account details from the text fields
                        return {
                          DatabaseHelper.columnCommentFullName:
                              firstNameTextField.text +
                                  " " +
                                  lastNameTextField.text,
                        };
                      }

                      dbHelper.updateAccountComment(
                          getAccountDetails2(),
                          account['accountFirstName'] +
                              " " +
                              account['accountLastName']);

                      Future<void> showMyDialog() async {
                        return showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Update Successful'),
                              content: Text("Kindly log-in again.",
                                  textAlign: TextAlign.center),
                              icon: Icon(Icons.check),
                              iconColor: Colors.green,
                              actions: <Widget>[
                                TextButton(
                                  child: const Text('Dismiss'),
                                  onPressed: () {
                                    Navigator.pushReplacement<void, void>(
                                      //moves the screen to the SignInScreen
                                      context,
                                      MaterialPageRoute<void>(
                                        builder: (BuildContext context) =>
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
                      Future<void> showMyDialog() async {
                        return showDialog<void>(
                          context: context,
                          barrierDismissible: false, // user must tap button!
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Update Failed'),
                              icon: Icon(Icons.error),
                              iconColor: Colors.red,
                              content: SingleChildScrollView(
                                  child: Text('Password is not the same!',
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
                  }
                }
              });
            }));
  }
}
