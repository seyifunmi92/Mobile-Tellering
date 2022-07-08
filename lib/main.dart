import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teller/checkmessage.dart';
import 'package:teller/pref.dart';
import 'package:teller/succes.dart';
import 'package:teller/walletfund.dart';
import 'package:teller/welcome.dart';
import 'package:teller/welcome.dart';
import 'package:teller/services.dart';
import 'package:teller/constants.dart';
import 'package:teller/textstyle.dart';
import 'package:teller/login.dart';
import 'package:teller/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teller/tellerrequest.dart';
import 'package:intl/intl.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';

void main() => runApp(ChangeNotifierProvider(
      create: (context) => ServiceClass(),
      child: const MyApp(),
    ));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Text",
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Welcome(),
    );
  }
}
