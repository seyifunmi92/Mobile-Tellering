import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teller/newservice.dart';
import 'package:teller/signup.dart';
import 'package:teller/welcome.dart';
import 'package:teller/welcome.dart';
import 'package:teller/services.dart';
import 'package:teller/constants.dart';
import 'package:teller/textstyle.dart';
import 'package:teller/login.dart';
import 'package:teller/models.dart';
import 'package:provider/provider.dart';
import 'package:teller/services.dart';
import 'package:teller/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teller/models.dart';
import 'dart:convert';
import 'dart:math';
import 'package:teller/tellerrequest.dart';

class CheckMessage extends StatefulWidget {
  //final UserRegistration userRegistration;
  const CheckMessage({Key? key}) : super(key: key);

  @override
  _CheckMessageState createState() => _CheckMessageState();
}

class _CheckMessageState extends State<CheckMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Confirmation Page",
          style: TextStyle(
            fontFamily: "OpenSans",
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          const Center(
              child: Text(
            "Check your email to get your user Id and password",
            style: TextStyle(
              fontFamily: "OpenSans",
              color: Colors.blueGrey,
              fontSize: 15,
            ),
          )),
          const SizedBox(
            height: 50,
          ),
          GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "I didnt get the code?",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.blueGrey,
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Resend Message?",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
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
                tileMode:
                    TileMode.repeated, // repeats the gradient over the canvas
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              child: const Center(
                child: Text(
                  'PROCEED TO LOGIN',
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
          const SizedBox(
            height: 420,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => SignUp()));
            },
            child: Column(
              children: const [
                Text(
                  "Back",
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    color: Colors.blueGrey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
