import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teller/cashDepostit.dart';
import 'package:teller/welcome.dart';
import 'package:teller/welcome.dart';
import 'package:teller/services.dart';
import 'package:teller/constants.dart';
import 'package:teller/textstyle.dart';
import 'package:teller/login.dart';
import 'package:teller/teller.dart';
import 'package:teller/customer.dart';
import 'package:teller/openAccount.dart';
import 'package:teller/home.dart';

import 'models.dart';

class SummaryAccount extends StatefulWidget {
  const SummaryAccount({Key? key}) : super(key: key);

  @override
  _SummaryAccountState createState() => _SummaryAccountState();
}

class _SummaryAccountState extends State<SummaryAccount> {
  getSharedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? username = sharedPreferences.getString("username");
    print(username);
    //var seyi = MobileTellerRequestList(loginUserId: int.parse(username!));
    return username;
  }

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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Summary Account",
          style: TextStyle(fontFamily: "OpenSans"),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 100,
            ),
            const Text(
              "Search",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black26,
                fontFamily: "OpenSans",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: <Widget>[
                Container(
                  width: 350,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: const TextField(
                    decoration: InputDecoration(
                      hintText: "  Enter Account Number/Name",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          letterSpacing: 0.0,
                          fontSize: 15,
                          fontFamily: "OpenSans"),
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
                //   width: 350,
                //   decoration: BoxDecoration(
                //     color: Colors.grey.withOpacity(0.5),
                //     borderRadius: BorderRadius.circular(0),
                //   ),
                //   child: const TextField(
                //     decoration: InputDecoration(
                //       hintText: "  Account Number",
                //       hintStyle: TextStyle(
                //         color: Colors.black,
                //         letterSpacing: 0.0,
                //         fontSize: 15,
                //       ),
                //       // prefixIcon:  Padding(
                //       //   padding: EdgeInsets.all(0),
                //       //   child: Icon(
                //       //     Icons.lock,
                //       //     size: 15,
                //       //     color: Colors.white,
                //       //   ),
                //       // ),
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
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: const Center(
                      child: Text(
                        'ENTER',
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
                SizedBox(
                  height: 320,
                ),
                FutureBuilder(
                  future: getSharedData(),
                  builder: (context, snapshot) {
                    var _loginuser = snapshot.data!;
                    print("Ararayghsb - $_loginuser");
                    if (snapshot.hasData) {
                      return Container(
                          width: 320,
                          height: 42,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
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
                          ),
                          child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Home(
                                            int.parse(_loginuser.toString()))));
                              },
                              child: const Center(
                                child: Text(
                                  "BACK",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.0,
                                    fontSize: 12,
                                  ),
                                ),
                              )));
                    } else
                      return CircularProgressIndicator();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
