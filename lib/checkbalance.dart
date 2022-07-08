import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:teller/checkmessage.dart';
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
import 'package:teller/teller.dart';
import 'models.dart';

class CheckBalance extends StatefulWidget {
  int ID;
  CheckBalance(this.ID);
  @override
  _CheckBalanceState createState() => _CheckBalanceState();
}

class _CheckBalanceState extends State<CheckBalance> {
  final _format = NumberFormat("#,###,000");

  getSharedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? username = sharedPreferences.getString("username");
    print(username);
    //var seyi = MobileTellerRequestList(loginUserId: int.parse(username!));
    return username;
  }

  bool showData = false;
  bool showBalance = false;
  GetBalance? customerBalance;
  bool loading = true;
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

  late GetBalance getBalance;
  //late Future<List<GetBalance>> getCustomerBalance;
  // void setFuture() {
  //   getCustomerBalance = balance();
  // }

  @override
  void initState() {
    // TODO: implement initState
    //getBalance(widget.ID);
    //getCustomerBalance();
    balance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            showData
                ? Container(
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
                      borderRadius: BorderRadius.circular(0),
                    ),
                    width: _width,
                    height: _height * 0.35,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        //RequestDetail mydata = _request!.createdate.toString;
                        showData
                            ? const Text(
                                "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "OpenSans",
                                ),
                              )
                            : const CircularProgressIndicator(),

                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Image(
                            image: AssetImage("lib/images/ttteller.png"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Teller balance",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "OpenSans",
                            letterSpacing: 0,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        showData
                            ? Text(
                                "₦${_format.format(customerBalance!.currentbalance)}.00",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: "OpenSans",
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const CircularProgressIndicator(),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 13,
                            fontFamily: "OpenSans",
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Text()
                      ],
                    ),
                  )
                : Container(
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
                      borderRadius: BorderRadius.circular(0),
                    ),
                    width: _width,
                    height: _height * 0.35,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        //RequestDetail mydata = _request!.createdate.toString;
                        showData
                            ? const Text(
                                "",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontFamily: "OpenSans",
                                ),
                              )
                            : const Text(""),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Image(
                            image: AssetImage("lib/images/ttteller.png"),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Teller balance",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: "OpenSans",
                            letterSpacing: 0,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),

                        showData
                            ? Text(
                                "₦${customerBalance!.currentbalance.toString()}0",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: "OpenSans",
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : const Text(
                                "₦0.00",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                  fontFamily: "OpenSans",
                                  letterSpacing: 0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "",
                          style: TextStyle(
                            color: Colors.amber,
                            fontSize: 13,
                            fontFamily: "OpenSans",
                            letterSpacing: 0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Text()
                      ],
                    ),
                  ),
            const SizedBox(
              height: 25,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Login User Id",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontFamily: "OpenSans",
                    letterSpacing: 0,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 170,
                ),
                showData
                    ? Text(
                        customerBalance!.loginUserId.toString(),
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontFamily: "OpenSans",
                          letterSpacing: 0,
                          //fontWeight: FontWeight.bold,
                        ),
                      )
                    : FutureBuilder(
                        future: getSharedData(),
                        builder: (context, snapshot) {
                          var _loginuser = snapshot.data ?? "";
                          print("Ararayghsb - $_loginuser");
                          if (snapshot.hasData) {
                            return Text(
                              _loginuser.toString(),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontFamily: "OpenSans",
                                letterSpacing: 0,
                                //fontWeight: FontWeight.bold,
                              ),
                            );
                          } else
                            return CircularProgressIndicator();
                        },
                      ),
              ],
            ),
            const Divider(
              height: 60,
              color: Colors.grey,
            ),
            // const SizedBox(
            //   height: 25,
            // ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Amount Collected",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontFamily: "OpenSans",
                    letterSpacing: 0,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 130,
                ),
                showData
                    ? Text(
                        "₦${customerBalance!.amountcollected.toString()}0",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontFamily: "OpenSans",
                          letterSpacing: 0,
                          //fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Text(
                        "₦0.00",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontFamily: "OpenSans",
                          letterSpacing: 0,
                          //fontWeight: FontWeight.bold,
                        ),
                      )
              ],
            ),
            const Divider(
              height: 60,
              color: Colors.grey,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Current Balance",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontFamily: "OpenSans",
                    letterSpacing: 0,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 130,
                ),
                showData
                    ? Text(
                        "₦${customerBalance!.currentbalance.toString()}0",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontFamily: "OpenSans",
                          letterSpacing: 0,
                          //fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Text(
                        "   ₦0.00",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontFamily: "OpenSans",
                          letterSpacing: 0,
                          //fontWeight: FontWeight.bold,
                        ),
                      )
              ],
            ),
            const Divider(
              height: 60,
              color: Colors.grey,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  "Total Amount Collected",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 20,
                    fontFamily: "OpenSans",
                    letterSpacing: 0,
                    //fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 70,
                ),
                showData
                    ? Text(
                        "₦${customerBalance!.totalamountCollected.toString()}0",
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontFamily: "OpenSans",
                          letterSpacing: 0,
                          //fontWeight: FontWeight.bold,
                        ),
                      )
                    : const Text(
                        "  ₦0.00",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontFamily: "OpenSans",
                          letterSpacing: 0,
                          //fontWeight: FontWeight.bold,
                        ),
                      )
              ],
            ),
            const Divider(
              height: 60,
              color: Colors.grey,
            ),
            const SizedBox(
              height: 120,
            ),
            FutureBuilder(
              future: getSharedData(),
              builder: (context, snapshot) {
                var _loginuser = snapshot.data ?? "";
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
            //bodyCustom(customerBalance!.loginUserId.toString()),
          ],
        ),
      ),

      // appBar: AppBar(
      //   automaticallyImplyLeading: false,
      //   title: Column(
      //     children: <Widget>[
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         crossAxisAlignment: CrossAxisAlignment.center,
      //         children: const <Widget>[
      //           SizedBox(
      //             width: 0,
      //           ),
      //           // Text(
      //           //   "HOME PAGE",
      //           //   style: TextStyle(
      //           //     color: Colors.black,
      //           //     fontSize: 15,
      //           //     fontWeight: FontWeight.bold,
      //           //   ),
      //           // ),
      //         ],
      //       ),
      //       const SizedBox(
      //         height: 20,
      //       ),
      //       Container(
      //         width: 320,
      //         height: 120,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(5),
      //           // ignore: prefer_const_constructors
      //           gradient: LinearGradient(
      //             begin: Alignment.topLeft,
      //             end: Alignment.bottomRight,
      //             // 10% of the width, so there are ten blinds.
      //             // ignore: prefer_const_literals_to_create_immutables
      //             colors: <Color>[
      //               kPrimaryColor,
      //               kSecondaryColor,
      //             ], // red to yellow
      //             tileMode:
      //                 TileMode.repeated, // repeats the gradient over the canvas
      //           ),
      //           // ignore: prefer_const_literals_to_create_immutables
      //           boxShadow: [
      //             const BoxShadow(
      //               color: Colors.blue,
      //               offset: Offset.zero,
      //               blurStyle: BlurStyle.outer,
      //               blurRadius: 10.0,
      //               spreadRadius: 0.0,
      //             ),
      //           ],
      //         ),
      //         child: InkWell(
      //           onTap: () {
      //             Navigator.pushNamed(context, '/homee');
      //           },
      //           child: Column(
      //             // ignore: prefer_const_literals_to_create_immutables
      //             children: [
      //               const SizedBox(
      //                 height: 17,
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 children: const [
      //                   // ignore: prefer_const_constructors
      //                   SizedBox(
      //                     width: 10,
      //                   ),
      //                   //Text(customerList[0].loginUserId.toString()),
      //                   Text(
      //                     "                   Fund Balance",
      //                     style: TextStyle(
      //                       fontFamily: "OpenSans",
      //                       fontWeight: FontWeight.bold,
      //                       fontSize: 20,
      //                     ),
      //                   ),
      //                 ],
      //               ),
      //               // ignore: prefer_const_constructors
      //               SizedBox(
      //                 height: 10,
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.start,
      //                 children: [
      //                   // ignore: prefer_const_constructors
      //                   SizedBox(
      //                     width: 10,
      //                   ),
      //                   Column(
      //                     children: [
      //                       Row(
      //                         mainAxisAlignment: MainAxisAlignment.start,
      //                         children: const [
      //                           Center(
      //                             child: Text(
      //                               "                           System Date : May 4, 2022",
      //                               style: TextStyle(
      //                                 fontFamily: "OpenSans",
      //                                 fontWeight: FontWeight.bold,
      //                                 fontSize: 12,
      //                               ),
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       // Row(
      //                       //   mainAxisAlignment: MainAxisAlignment.start,
      //                       //   children: const [
      //                       //
      //                       //     Text(
      //                       //       "                            Calendar Date : May 5, 2022",
      //                       //       style: TextStyle(
      //                       //         fontFamily: "OpenSans",
      //                       //
      //                       //         fontWeight: FontWeight.bold,
      //                       //         fontSize: 12,
      //                       //       ),
      //                       //     ),
      //                       //   ],
      //                       // ),
      //                       // Row(
      //                       //   mainAxisAlignment: MainAxisAlignment.start,
      //                       //   crossAxisAlignment: CrossAxisAlignment.start,
      //                       //   children: const [
      //                       //     Text(
      //                       //       "                     Teller ID : 1025",
      //                       //       style: TextStyle(
      //                       //         fontFamily: "OpenSans",
      //                       //
      //                       //         fontWeight: FontWeight.bold,
      //                       //         fontSize: 12,
      //                       //       ),
      //                       //     ),
      //                       //   ],
      //                       // ),
      //                       const Text(
      //                         "                          Till Balance : -\$504,000",
      //                         style: TextStyle(
      //                           fontFamily: "OpenSans",
      //                           fontWeight: FontWeight.bold,
      //                           fontSize: 12,
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 ],
      //               ),
      //             ],
      //           ),
      //         ),
      //       ),
      //       const SizedBox(
      //         height: 25,
      //       ),
      //       // Row(
      //       //   mainAxisAlignment: MainAxisAlignment.start,
      //       //   children: const [
      //       //     Text(
      //       //       "Menu",
      //       //       style: TextStyle(
      //       //         fontFamily: "OpenSans",
      //       //
      //       //         color: kPrimaryColor,
      //       //         fontSize: 20,
      //       //         fontWeight: FontWeight.bold,
      //       //       ),
      //       //     ),
      //       //   ],
      //       // ),
      //     ],
      //   ),
      //   toolbarHeight: 180,
      //   backgroundColor: kBackgroundHome2,
      //   elevation: 0.0,
      //   // ignore: prefer_const_constructors
      //   shape: RoundedRectangleBorder(
      //     // ignore: prefer_const_constructors
      //     borderRadius: BorderRadius.only(
      //       bottomLeft: const Radius.circular(15),
      //       bottomRight: const Radius.circular(15),
      //     ),
      //   ),
      // ),
      // body: Column(
      //   children: [
      //     const SizedBox(
      //       height: 20,
      //     ),
      //     Center(
      //       child: Container(
      //         height: 80,
      //         width: 400,
      //         color: Colors.white54,
      //         child: Column(
      //           children: const [
      //             SizedBox(
      //               height: 10,
      //             ),
      //             Text(
      //               "Balance : ",
      //               style: TextStyle(fontFamily: "OpenSans"),
      //             ),
      //             SizedBox(
      //               height: 20,
      //             ),
      //             Text("Collection: ",
      //                 style: TextStyle(fontFamily: "OpenSans")),
      //           ],
      //         ),
      //       ),
      //     ),
      //     const SizedBox(
      //       height: 20,
      //     ),
      //     //Text(customerList[0].currentbalance.toString()),
      //     const Text("Transaction History",
      //         style: TextStyle(fontFamily: "OpenSans")),
      //     //bodyCustom(GetBalance(loginUserId: 313161)),
      //     //...customerList.map((e) => bodyCustom(e)),
      //     showBalance
      //         ? Text(customerBalance!.currentbalance.toString())
      //         : const CircularProgressIndicator()
      //   ],
      // ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //             builder: (context) => Home(customerBalance!.loginUserId!)));
      //   },
      //   child: const Text("Back"),
      // ),
    );
  }

  Widget bodyCustom(String _mydetail) => Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_mydetail),
            ],
          ),
        ],
      );

  Future<void> balance() async {
    ServiceClass serviceClass = ServiceClass();
    serviceClass.getBalance(widget.ID).then((value) => (output(value)));
  }

  void output(String body) {
    print("YEAH, lets get balance now...");
    print(body);
    if (body.contains("No balance for this user")) {
      showMessage("No balance for this user");
      setState(() {
        loading = false;
      });
    } else {
      var bodyT = jsonDecode(body);
      if (bodyT["loginUserId"] != null) {
        setState(() {
          customerBalance = GetBalance.fromJson(bodyT);
          showBalance = true;
          showData = true;
        });
      } else {
        showMessage(bodyT["message"]);
      }
    }
  }
}
