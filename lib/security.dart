import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teller/welcome.dart';
import 'package:teller/welcome.dart';
import 'package:teller/services.dart';
import 'package:teller/constants.dart';
import 'package:teller/textstyle.dart';
import 'package:teller/login.dart';
import 'package:teller/home.dart';
import 'package:teller/teller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models.dart';

class Security extends StatefulWidget {
  const Security({Key? key}) : super(key: key);

  @override
  _SecurityState createState() => _SecurityState();
}

class _SecurityState extends State<Security> {
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

  GetBalance? customerBalance;
  bool showData = false;
  bool showBalance = false;
  bool loading = false;
  bool userData = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundHome2,
      body: Column(
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
          Text(
            'SECURITY QUESTION',
            style: TextStyle(
              letterSpacing: 7.0,
              color: Colors.blue[900],
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "OpenSans",
            ),
          ),
          const SizedBox(
            height: 150,
          ),

          Text(
            "Enter Secret Answer to Secret Question",
            style: TextStyle(
              fontFamily: "OpenSans",
              color: Colors.blue[900],
              fontSize: 20,
            ),
          ),

          SizedBox(
            height: 30,
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
                  child: const TextField(
                    decoration: InputDecoration(
                      //hintText: "Username",
                      hintStyle: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.0,
                        fontSize: 13,
                      ),
                      border: InputBorder.none,
                      // prefixIcon:  Padding(
                      //   padding: const EdgeInsets.all(0),
                      //   child: Icon(
                      //     Icons.email_sharp,
                      //     size: 15,
                      //     color: Colors.white,
                      //   ),
                      // ),
                    ),
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // Container(
                //   decoration: BoxDecoration(
                //     color: Colors.grey.withOpacity(0.5),
                //     borderRadius: BorderRadius.circular(5),
                //   ),
                //   child: const TextField(
                //     decoration: InputDecoration(
                //       hintText: "Password",
                //       hintStyle: TextStyle(
                //         color: Colors.white,
                //         letterSpacing: 1.0,
                //         fontSize: 13,
                //       ),
                //       prefixIcon: const Padding(
                //         padding: EdgeInsets.all(0),
                //         child: Icon(
                //           Icons.lock,
                //           size: 15,
                //           color: Colors.white,
                //         ),
                //       ),
                //       border: InputBorder.none,
                //     ),
                //     textInputAction: TextInputAction.done,
                //     keyboardType: TextInputType.number,
                //     obscureText: true,
                //   ),
                // ),
                const SizedBox(
                  height: 20,
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
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  Home(customerBalance!.loginUserId!)));
                    },
                    child: const Center(
                      child: Text(
                        'PROCEED',
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
          // const SizedBox(
          //   height: 250,
          // ),
          // Text(
          //   'DONT HAVE AN ACCOUNT?',
          //   style: TextStyle(
          //     letterSpacing: 7.0,
          //     color: Colors.white,
          //     fontSize: 10,
          //   ),
          // ),
          // const SizedBox(
          //   height: 10,
          // ),
          // Container(
          //   height: 40,
          //   width: 350,
          //   decoration: BoxDecoration(
          //     // ignore: prefer_const_constructors
          //     gradient: LinearGradient(
          //       begin: Alignment.topLeft,
          //       end: Alignment.bottomRight,
          //       // 10% of the width, so there are ten blinds.
          //       // ignore: prefer_const_literals_to_create_immutables
          //       colors: <Color>[
          //         kPrimaryColor,
          //         kSecondaryColor,
          //       ], // red to yellow
          //       tileMode: TileMode
          //           .repeated, // repeats the gradient over the canvas
          //     ),
          //     borderRadius: BorderRadius.circular(5),
          //   ),
          //   child: InkWell(
          //     onTap: () {},
          //     child: Center(
          //       child: Text(
          //         'SIGN UP',
          //         style: TextStyle(
          //           color: Colors.white,
          //           letterSpacing: 3.0,
          //           fontSize: 10,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 300,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Teller()));
            },
            child: const Text(
              "BACK",
              style: TextStyle(
                fontFamily: "OpenSans",
                letterSpacing: 3.0,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
