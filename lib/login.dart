import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teller/constants.dart';
import 'package:teller/models.dart';
import 'package:teller/signup.dart';
import 'package:teller/welcome.dart';
import 'package:teller/welcome.dart';
import 'package:teller/services.dart';
import 'package:teller/security.dart';
import 'package:teller/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  showMessage(String message,
      [Duration duration = const Duration(seconds: 4)]) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(message),
      duration: duration,
      action: SnackBarAction(
        label: "CLOSE",
        onPressed: () {
          _scaffoldKey.currentState!.removeCurrentSnackBar();
        },
      ),
    ));
  }

  bool emailError = false;
  bool showloading = false;
  bool buttonOn = false;
  bool networkError = true;
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/teller.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black26, BlendMode.darken),
            ),
          ),
        ),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.black45,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    SizedBox(
                      width: 0,
                    ),
                    // Image(
                    //   image: AssetImage('lib/images/saleologo.png'),
                    //   height: 55,
                    // ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'WELCOME',
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    letterSpacing: 2.0,
                    color: kSecondaryColor,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          onChanged: (text2) {
                            if (usernameC.text.isNotEmpty || text2.isNotEmpty) {
                              setState(() {
                                buttonOn = true;
                              });
                            } else if (usernameC.text.isEmpty ||
                                text2.isEmpty) {
                              setState(() {
                                buttonOn = false;
                              });
                            } else if (usernameC.text.isNotEmpty ||
                                passwordC.text.isEmpty) {
                              setState(() {
                                buttonOn = false;
                              });
                            } else {
                              setState(() {
                                buttonOn = false;
                              });
                            }

                            // if (text.contains("@")) {
                            //   if (text.split("@")[1].contains(".")){
                            //     setState(() {
                            //       emailIcon = "email_icon2";
                            //     });
                            //   }else{
                            //     setState(() {
                            //       emailIcon = "email_icon";
                            //     });
                            //   }
                            // }else{
                            //   setState(() {
                            //     emailIcon = "email_icon";
                            //   });
                            // }
                          },
                          controller: usernameC,
                          decoration: const InputDecoration(
                            hintText: "Username",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.0,
                              fontSize: 13,
                              fontFamily: "OpenSans",
                            ),
                            border: InputBorder.none,
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(0),
                              child: Icon(
                                Icons.email_sharp,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: TextField(
                          style: const TextStyle(
                            color: Colors.white,
                          ),
                          onChanged: (text2) {
                            if (usernameC.text.isNotEmpty || text2.isNotEmpty) {
                              setState(() {
                                buttonOn = true;
                              });
                            } else if (usernameC.text.isEmpty ||
                                text2.isEmpty) {
                              setState(() {
                                buttonOn = false;
                              });
                            } else if (usernameC.text.isNotEmpty ||
                                passwordC.text.isEmpty) {
                              setState(() {
                                buttonOn = false;
                              });
                            } else {
                              setState(() {
                                buttonOn = false;
                              });
                            }

                            // if (text.contains("@")) {
                            //   if (text.split("@")[1].contains(".")){
                            //     setState(() {
                            //       emailIcon = "email_icon2";
                            //     });
                            //   }else{
                            //     setState(() {
                            //       emailIcon = "email_icon";
                            //     });
                            //   }
                            // }else{
                            //   setState(() {
                            //     emailIcon = "email_icon";
                            //   });
                            // }
                          },
                          controller: passwordC,
                          decoration: const InputDecoration(
                            hintText: "Password",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              fontFamily: "OpenSans",
                              letterSpacing: 1.0,
                              fontSize: 13,
                            ),
                            prefixIcon: Padding(
                              padding: EdgeInsets.all(0),
                              child: Icon(
                                Icons.lock,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: true,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 40,
                        width: 350,
                        decoration: buttonOn
                            ? BoxDecoration(
                                // ignore: prefer_const_constructors
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  // 10% of the width, so there are ten blinds.
                                  // ignore: prefer_const_literals_to_create_immutables
                                  colors: <Color>[
                                    kPrimaryColor,
                                    kSecondaryColor,
                                  ], // red to yellow
                                  tileMode: TileMode
                                      .repeated, // repeats the gradient over the canvas
                                ),
                                borderRadius: BorderRadius.circular(5),
                              )
                            : BoxDecoration(
                                // ignore: prefer_const_constructors
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(5),
                              ),
                        child: InkWell(
                          onTap: buttonOn
                              ? () {
                                  if (usernameC.text.isNotEmpty &&
                                      passwordC.text.isNotEmpty) {
                                    logon();
                                    usernameC.clear();
                                    passwordC.clear();
                                  }
                                }
                              : null,
                          child: const Center(
                            child: Text(
                              'LOGIN',
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                color: Colors.white,
                                letterSpacing: 3.0,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // TextButton(
                //   child: Text(
                //     'FORGOT PASSWORD?',
                //     style: TextStyle(
                //       letterSpacing: 4.0,
                //       color: Colors.blue,
                //       fontSize: 13,
                //     ),
                //   ),
                //   onPressed: () {},
                // ),
                const SizedBox(
                  height: 300,
                ),
                const Text(
                  'DONT HAVE AN ACCOUNT?',
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    letterSpacing: 7.0,
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: 350,
                  decoration: BoxDecoration(
                    // ignore: prefer_const_constructors
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      // 10% of the width, so there are ten blinds.
                      // ignore: prefer_const_literals_to_create_immutables
                      colors: <Color>[
                        kPrimaryColor,
                        kSecondaryColor,
                      ], // red to yellow
                      tileMode: TileMode
                          .repeated, // repeats the gradient over the canvas
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                    child: const Center(
                      child: Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontFamily: "OpenSans",
                          color: Colors.white,
                          letterSpacing: 3.0,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void logon() {
    print("hello seyi araoluwa");
    print("We are In Login now...");
    ServiceClass serviceClass = ServiceClass();
    serviceClass
        .myLogin(usernameC.text, passwordC.text)
        .then((value) => output(value));
  }

  void output(ResponseLogin _login) {
    var bodyT = jsonDecode(_login.responseBody!);
    print("we are in Login - second haven now bro..");
    print(_login);
    print(_login.responseCode);
    if (_login.responseCode == 700) {
      showMessage("Network error occured...");
    } else {
      if (_login.responseCode == 200) {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Home()));
        if (bodyT["status"] == "Successful") {
          setState(() {
            emailError = false;
            showloading = false;
          });
          login _logon = login.fromJson(bodyT["data"]);
          Provider.of<ServiceClass>(context, listen: false).notifyLogin(_logon);
          print(_logon);
        } else {
          if (_login.responseCode == 404) {
            setState(() {
              emailError = true;
            });
            showMessage("Error occured..Resource not found");
          } else if (_login.responseCode == 401) {
            setState(() {
              emailError = true;
            });
            showMessage("Incorrect Password, Please try again");
          } else {
            setState(() {
              showloading = false;
            });
            showMessage("Error encountered....");
          }
        }
      }
    }
  }
}
