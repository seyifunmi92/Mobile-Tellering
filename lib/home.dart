import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teller/cashDepostit.dart';
import 'package:teller/dailyCollections.dart';
import 'package:teller/liquid.dart';
import 'package:teller/loading.dart';
import 'package:teller/tellercustomery.dart';
import 'package:teller/tellerlist.dart';
import 'package:teller/walletfund.dart';
import 'package:teller/welcome.dart';
import 'package:teller/welcome.dart';
import 'package:teller/services.dart';
import 'package:teller/constants.dart';
import 'package:teller/textstyle.dart';
import 'package:teller/login.dart';
import 'package:teller/teller.dart';
import 'package:teller/customer.dart';
import 'package:teller/openAccount.dart';
import 'package:teller/summaryAccount.dart';
import 'package:teller/models.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'checkbalance.dart';
import 'open.dart';

class Home extends StatefulWidget {
  int ID;
  Home(this.ID);
  @override
  _HomeState createState() => _HomeState();
}

class Texts {
  int? id;
  String content;
  String amount;
  String url = "url";
  String sub;
  Texts(this.id, this.content, this.amount, this.url, this.sub);
  factory Texts.fromJson(dynamic json) {
    return Texts(
      json["id"] as int,
      json["content"] as String,
      json["amount"] as String,
      json["url"] as String,
      json["sub"] as String,
    );
  }
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  getSharedData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? username = sharedPreferences.getString("username");
    print(username);
    //var seyi = MobileTellerRequestList(loginUserId: int.parse(username!));
    return username;
  }

  final _format = NumberFormat("#,###,000");
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
  String? loginID = "";
  late AnimationController anicontroller;
  bool noBalance = false;
  bool showData = false;
  bool showBalance = false;
  bool loading = false;
  bool showloading = false;
  bool userData = true;
  //SharedPreferences sharedPreferences;
  setUser() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? username = sharedPreferences.getString("username");
    String? password = sharedPreferences.getString("password");
    if (sharedPreferences != null) {
      setState(() {
        userData = true;
        loginID = username!;
      });
      print("Welcome Seyi bro");
      print(username);
      print(password);
      return username;
    }
  }

  logOut() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final removeToken = sharedPreferences.remove("Token");
    final removeT = sharedPreferences.remove("FirstInstall");
    final removeUser = sharedPreferences.remove("username");
    if (removeToken != null) {
      print("Logged out ");
      setState(() {
        showloading = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
    }
    return removeToken;
    //return removeT;
  }
  // if (SharedPreferences != null)async{
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? username = sharedPreferences.getString("username");
  //   String? password = sharedPreferences.getString("password");

  //   setState(() {
  //     loginID = username!;
  //   });
  // }
  @override
  void initState() {
    anicontroller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    anicontroller.repeat();
    setUser();
    print("BOOS - $loginID");
    balance();
    super.initState();
  }

  @override
  void dispose() {
    anicontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    print("Welcome seyi.. device width - $_width");
    print("Welcome seyi.. device height - $_height");
    var mypaddingr = SizedBox(width: _width * 0.07436);
    var mypaddingr2 = SizedBox(width: _width * 0.056);
    var mypaddingrh2 = SizedBox(height: _height * 0.026 * 4);
    return Container(
      width: _width,
      height: _height,
      child: showData
          ? Scaffold(
              drawer: Drawer(
                backgroundColor: Colors.black,
              ),
              appBar: AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                //centerTitle: false,
                // leading: Icon(
                //   Icons.menu,
                //   color: Colors.black,
                // ),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: _width * .02,
                    ),
                    Image.asset(
                      "lib/images/ttteller.png",
                      height: _height * .04,
                    ),
                    Text(
                      "Dashboard",
                      style: GoogleFonts.openSans(
                        fontSize: _width * .062,
                        fontWeight: FontWeight.w700,
                        color: kPrimaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              key: _scaffoldKey,
              //backgroundColor: kBackgroundHome2,
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
              //       SizedBox(
              //         height: _height * .05,
              //       ),
              //       Container(
              //         width: _width * .75,
              //         height: _height * .130,
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(0),
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
              //             tileMode: TileMode
              //                 .repeated, // repeats the gradient over the canvas
              //           ),
              //           // ignore: prefer_const_literals_to_create_immutables
              //           boxShadow: [
              //             const BoxShadow(
              //               color: Colors.blue,
              //               offset: Offset.zero,
              //               blurStyle: BlurStyle.outer,
              //               blurRadius: 2.0,
              //               spreadRadius: 0.0,
              //             ),
              //           ],
              //         ),
              //         child: InkWell(
              //           onTap: () {
              //             // Navigator.pushNamed(context, '/homee');
              //           },
              //           child: SingleChildScrollView(
              //             scrollDirection: Axis.vertical,
              //             child: Column(
              //               // ignore: prefer_const_literals_to_create_immutables
              //               children: [
              //                 const SizedBox(
              //                   height: 17,
              //                 ),
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     // ignore: prefer_const_constructors
              //                     SizedBox(
              //                       width: 10,
              //                     ),
              //                     userData
              //                         ?
              //                         //final _user = {sharedPreferences.get("username")};
              //                         const Text(
              //                             "               Welcome Teller  ",
              //                             style: TextStyle(
              //                               fontFamily: "OpenSans",
              //                               fontWeight: FontWeight.bold,
              //                               fontSize: 20,
              //                               letterSpacing: 0,
              //                               color: Colors.white,
              //                             ),
              //                           )
              //                         : const Text("There was an error")
              //                   ],
              //                 ),
              //                 // ignore: prefer_const_constructors
              //                 SizedBox(
              //                   height: 10,
              //                 ),
              //                 Row(
              //                   mainAxisAlignment: MainAxisAlignment.start,
              //                   children: [
              //                     // ignore: prefer_const_constructors
              //                     SizedBox(
              //                       width: 10,
              //                     ),
              //                     Column(
              //                       children: [
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.start,
              //                           children: const [
              //                             Center(
              //                                 // child: Text(
              //                                 //   "                           System Date : May 4, 2022",
              //                                 //   style: TextStyle(
              //                                 //     fontFamily: "OpenSans",
              //                                 //     fontWeight: FontWeight.bold,
              //                                 //     fontSize: 12,
              //                                 //   ),
              //                                 // ),
              //                                 ),
              //                           ],
              //                         ),
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.start,
              //                           children: const [
              //                             // Text(
              //                             //   "                            Calendar Date : May 5, 2022",
              //                             //   style: TextStyle(
              //                             //     fontFamily: "OpenSans",
              //                             //     fontWeight: FontWeight.bold,
              //                             //     fontSize: 12,
              //                             //   ),
              //                             // ),
              //                           ],
              //                         ),
              //                         Row(
              //                           mainAxisAlignment:
              //                               MainAxisAlignment.start,
              //                           crossAxisAlignment:
              //                               CrossAxisAlignment.start,
              //                           children: [
              //                             noBalance
              //                                 ? FutureBuilder(
              //                                     future: getSharedData(),
              //                                     builder: (context, snapshot) {
              //                                       var _loginuser =
              //                                           snapshot.data ?? null;
              //                                       print(
              //                                           "Ararayghsb - $_loginuser");
              //                                       if (snapshot.hasData) {
              //                                         return Text(
              //                                           "                 Teller ID : ${_loginuser.toString()}",
              //                                           style: const TextStyle(
              //                                             color: Colors.white,
              //                                             fontWeight:
              //                                                 FontWeight.bold,
              //                                             fontSize: 14,
              //                                             fontFamily:
              //                                                 "OpenSans",
              //                                             letterSpacing: 1.0,
              //                                             //fontWeight: FontWeight.bold,
              //                                           ),
              //                                         );
              //                                       } else
              //                                         return CircularProgressIndicator();
              //                                     },
              //                                   )
              //                                 : Text(
              //                                     "            Teller ID : ${customerBalance!.loginUserId}",
              //                                     style: const TextStyle(
              //                                       fontFamily: "OpenSans",
              //                                       fontWeight: FontWeight.bold,
              //                                       fontSize: 14,
              //                                       letterSpacing: 1.0,
              //                                       color: Colors.white,
              //                                     ),
              //                                   ),
              //                           ],
              //                         ),
              //                         const SizedBox(
              //                           height: 10,
              //                         ),
              //                         noBalance
              //                             ? const Text(
              //                                 "                 Till Balance : ₦0.00",
              //                                 style: TextStyle(
              //                                   fontFamily: "OpenSans",
              //                                   fontWeight: FontWeight.bold,
              //                                   fontSize: 14,
              //                                   letterSpacing: 1.0,
              //                                   color: Colors.white,
              //                                 ),
              //                               )
              //                             : Text(
              //                                 "                 Till Balance : ₦${_format.format(customerBalance!.currentbalance)}",
              //                                 style: const TextStyle(
              //                                   fontFamily: "OpenSans",
              //                                   fontWeight: FontWeight.bold,
              //                                   fontSize: 14,
              //                                   color: Colors.white,
              //                                   letterSpacing: 0.5,
              //                                 ),
              //                               ),
              //                       ],
              //                     ),
              //                   ],
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ),
              //       ),
              //       const SizedBox(
              //         height: 25,
              //       ),
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.start,
              //         children: const [
              //           Text(
              //             "Menu",
              //             style: TextStyle(
              //               fontFamily: "OpenSans",
              //               color: kPrimaryColor,
              //               fontSize: 18,
              //               fontWeight: FontWeight.bold,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              //   toolbarHeight: 200,
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
              // ignore: prefer_const_constructors
              // body: ListView.builder(
              //   itemCount: seyi.length,
              //   itemBuilder: (BuildContext context, int index) {
              //     Texts ibolo = (seyi[index]);
              //     return Card(
              //       child: ListTile(
              //         key: Key(ibolo.content),
              //         title: Text(
              //           ibolo.content,
              //           style: TextStyle(
              //             color: Colors.blue[900],
              //             fontSize: 13,
              //             letterSpacing: 0.0,
              //             fontWeight: FontWeight.bold,
              //           ),
              //         ),
              //         trailing: Column(
              //           children: [
              //             const SizedBox(
              //               height: 10,
              //             ),
              //             Text(
              //               ibolo.amount,
              //               style: TextStyle(
              //                 color: Colors.red,
              //               ),
              //             ),
              //             const SizedBox(
              //               height: 5,
              //             ),
              //             Container(
              //               color: Colors.transparent,
              //               height: 10,
              //               width: 80,
              //               child: InkWell(
              //                 onTap: () {
              //                   Navigator.pushNamed(context, "/${seyi[index].url}");
              //                 },
              //                 child: const Text(
              //                   "        view details",
              //                   style: TextStyle(
              //                     color: Colors.grey,
              //                     fontSize: 10,
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         ),
              //         subtitle: Text(
              //           ibolo.sub,
              //           style: const TextStyle(
              //             color: Colors.grey,
              //             fontSize: 10,
              //           ),
              //         ),
              //         tileColor: Colors.white,
              //         selectedTileColor: Colors.black,
              //         focusColor: Colors.black,
              //         selectedColor: Colors.black,
              //         hoverColor: Colors.black,
              //       ),
              //       margin: const EdgeInsets.all(0.2),
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(3),
              //       ),
              //       elevation: 0.0,
              //       color: Colors.black26,
              //     );
              //   },
              // ),
              body: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    // Row(
                    //   children: [
                    //     mypaddingr,
                    //     Text(
                    //       "Dashboard",
                    //       style: GoogleFonts.poppins(
                    //         fontSize: _width * .062,
                    //         fontWeight: FontWeight.w600,
                    //         color: kPrimaryColor,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: _height * .02,
                    ),
                    Row(
                      children: [
                        mypaddingr,
                        Container(
                          width: _width * .85,
                          height: _height * .18,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  kPrimaryColor,
                                  Color(0xff292669),
                                ]),
                            //color: kprimarycolor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SingleChildScrollView(
                            child: Column(children: [
                              SizedBox(
                                height: _height * .017,
                              ),
                              //mypaddingrh,
                              Row(
                                children: [
                                  SizedBox(width: _width * .75),
                                ],
                              ),
                              Row(
                                children: [
                                  mypaddingr2,
                                  Image.asset(
                                    "lib/images/ttteller.png",
                                    height: _height * .047,
                                    width: _width * .103,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: _height * .005,
                              ),
                              Row(
                                children: [
                                  mypaddingr2,
                                  Text(
                                    "Welcome Teller : ",
                                    style: GoogleFonts.poppins(
                                      color: Color(0xffE9EDF7),
                                      fontSize: _width * .038,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  noBalance
                                      ? FutureBuilder(
                                          future: getSharedData(),
                                          builder: (context, snapshot) {
                                            var _loginuser =
                                                snapshot.data ?? null;
                                            print("Ararayghsb - $_loginuser");
                                            if (snapshot.hasData) {
                                              return Text(
                                                "${_loginuser.toString()}",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: _width * .038,
                                                  //fontFamily: "OpenSans",
                                                  letterSpacing: 1.0,
                                                  //fontWeight: FontWeight.bold,
                                                ),
                                              );
                                            } else
                                              return CircularProgressIndicator();
                                          },
                                        )
                                      : Text(
                                          customerBalance!.loginUserId
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontSize: _width * .038,
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 1.0,
                                          ),
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: _height * .002,
                              ),
                              Row(
                                children: [
                                  mypaddingr2,
                                  noBalance
                                      ? Text(
                                          "N0.00",
                                          style: GoogleFonts.openSans(
                                            color: Colors.white,
                                            fontSize: _width * .087,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        )
                                      : Text(
                                          "N${_format.format(customerBalance!.currentbalance)}.00",
                                          style: GoogleFonts.openSans(
                                            color: Colors.white,
                                            fontSize: _width * .087,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                ],
                              ),
                            ]),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: const [
                    //     // Text(
                    //     //   "  MENU",
                    //     //   style: TextStyle(
                    //     //     color: kPrimaryColor,
                    //     //     fontSize: 16,
                    //     //     fontWeight: FontWeight.bold,
                    //     //     letterSpacing: 2.0,
                    //     //   ),
                    //     // ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    // Container(
                    //   height: 50,
                    //   width: 380,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
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
                    //   ),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => Teller()));
                    //     },
                    //     child: Row(
                    //       children: const <Widget>[
                    //         SizedBox(
                    //           width: 20,
                    //         ),
                    //         Icon(
                    //           Icons.qr_code,
                    //         ),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           "Teller Profile",
                    //           style: TextStyle(
                    //             fontFamily: "OpenSans",
                    //             fontWeight: FontWeight.w800,
                    //             fontSize: 16,
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: _width * .05),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WalletFund()));
                            },
                            child: Container(
                              width: _width * .9,
                              height: _height * .065,
                              decoration: BoxDecoration(
                                color: Color(0xfffffff),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: Offset.zero,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    _width * .06,
                                    _height * .0157,
                                    _width * .06,
                                    _height * .0157),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Request Funds",
                                      style: GoogleFonts.poppins(
                                        fontSize: _height * .015,
                                        fontWeight: FontWeight.w400,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    Icon(
                                      Icons.request_quote,
                                      color: kPrimaryColor,
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: _height * .01,
                    ),
                    // Container(
                    //   height: 50,
                    //   width: 380,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
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
                    //   ),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => const WalletFund()));
                    //     },
                    //     child: Row(
                    //       children: <Widget>[
                    //         const SizedBox(
                    //           width: 20,
                    //         ),
                    //         const Icon(
                    //           Icons.request_quote,
                    //           color: Colors.white,
                    //         ),
                    //         const SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           "Request Fund",
                    //           style: GoogleFonts.poppins(
                    //             fontWeight: FontWeight.w800,
                    //             fontSize: 16,
                    //             color: Colors.white,
                    //             //fontWeight: FontWeight.bold,
                    //             //fontFamily: "OpenSans",
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: _width * .05),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TellerCustomery(widget.ID)));
                            },
                            child: Container(
                              width: _width * .9,
                              height: _height * .065,
                              decoration: BoxDecoration(
                                color: Color(0xfffffff),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: Offset.zero,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    _width * .06,
                                    _height * .0157,
                                    _width * .06,
                                    _height * .0157),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Teller Customers",
                                      style: GoogleFonts.poppins(
                                        fontSize: _height * .015,
                                        fontWeight: FontWeight.w400,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    Icon(
                                      Icons.person,
                                      color: kPrimaryColor,
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(
                      height: _height * .01,
                    ),
                    // Container(
                    //   height: 50,
                    //   width: 380,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
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
                    //   ),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   TellerCustomery(widget.ID)));
                    //     },
                    //     child: Row(
                    //       children: <Widget>[
                    //         const SizedBox(
                    //           width: 20,
                    //         ),
                    //         const Icon(
                    //           Icons.person,
                    //           color: Colors.white,
                    //         ),
                    //         const SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           "Teller Customers",
                    //           style: GoogleFonts.poppins(
                    //             fontWeight: FontWeight.w800,
                    //             fontSize: 16,
                    //             color: Colors.white,
                    //             //fontWeight: FontWeight.bold,
                    //             //fontFamily: "OpenSans",
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),

                    FutureBuilder(
                      future: getSharedData(),
                      builder: (context, snapshot) {
                        var _loginuser = snapshot.data ?? null;
                        print("Ararayghsb - $_loginuser");
                        if (snapshot.hasData) {
                          return Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: _width * .05),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TellerList(
                                                int.parse(
                                                    _loginuser.toString()))));
                                  },
                                  child: Container(
                                    width: _width * .9,
                                    height: _height * .065,
                                    decoration: BoxDecoration(
                                      color: Color(0xfffffff),
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurStyle: BlurStyle.outer,
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                          offset: Offset.zero,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          _width * .06,
                                          _height * .0157,
                                          _width * .06,
                                          _height * .0157),
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "List of Requests",
                                            style: GoogleFonts.poppins(
                                              fontSize: _height * .015,
                                              fontWeight: FontWeight.w400,
                                              color: kPrimaryColor,
                                            ),
                                          ),
                                          Icon(
                                            Icons.list,
                                            color: kPrimaryColor,
                                          ),
                                        ],
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );

                          // SizedBox(
                          //   height: _height * .02,
                          // ),

                          //  Container(
                          //     width: 380,
                          //     height: 50,
                          //     decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(10),
                          //       // ignore: prefer_const_constructors
                          //       gradient: LinearGradient(
                          //         begin: Alignment.topLeft,
                          //         end: Alignment.bottomRight,
                          //         // 10% of the width, so there are ten blinds.
                          //         // ignore: prefer_const_literals_to_create_immutables
                          //         colors: <Color>[
                          //           kPrimaryColor,
                          //           kSecondaryColor,
                          //         ], // red to yellow
                          //         tileMode: TileMode
                          //             .repeated, // repeats the gradient over the canvas
                          //       ),
                          //     ),
                          //     child: InkWell(
                          //       onTap: () {
                          //         Navigator.push(
                          //             context,
                          //             MaterialPageRoute(
                          //                 builder: (context) => TellerList(
                          //                     int.parse(
                          //                         _loginuser.toString()))));
                          //       },
                          //       child: Row(
                          //         children: <Widget>[
                          //           const SizedBox(
                          //             width: 20,
                          //           ),
                          //           const Icon(
                          //             Icons.list,
                          //             color: Colors.white,
                          //           ),
                          //           const SizedBox(
                          //             width: 10,
                          //           ),
                          //           Text(
                          //             "Teller Request List",
                          //             style: GoogleFonts.poppins(
                          //               fontWeight: FontWeight.w800,
                          //               fontSize: 16,
                          //               color: Colors.white,
                          //               //fontWeight: FontWeight.bold,
                          //               //fontFamily: "OpenSans",
                          //             ),
                          //           ),
                          //         ],
                          //       ),
                          //     ));
                        } else
                          return CircularProgressIndicator();
                      },
                    ),
                    SizedBox(
                      height: _height * .01,
                    ),
                    noBalance
                        ? Container(
                            child: FutureBuilder(
                              future: getSharedData(),
                              builder: (context, snapshot) {
                                var _loginuser = snapshot.data ?? null;
                                print("Ararayghsb - $_loginuser");
                                if (snapshot.hasData) {
                                  return containerCustom(
                                      MobileTellerRequestList(
                                          loginUserId: int.parse(
                                              _loginuser.toString())));
                                } else
                                  return CircularProgressIndicator();
                              },
                            ),
                          )
                        : containerCustom(MobileTellerRequestList(
                            loginUserId: customerBalance!.loginUserId)),
                    SizedBox(
                      height: _height * .01,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: _width * .05),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          TellerCustomery(widget.ID)));
                            },
                            child: Container(
                              width: _width * .9,
                              height: _height * .065,
                              decoration: BoxDecoration(
                                color: Color(0xfffffff),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: Offset.zero,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    _width * .06,
                                    _height * .0157,
                                    _width * .06,
                                    _height * .0157),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Deposit Cash",
                                      style: GoogleFonts.poppins(
                                        fontSize: _height * .015,
                                        fontWeight: FontWeight.w400,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    Icon(
                                      Icons.transfer_within_a_station,
                                      color: kPrimaryColor,
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   height: 50,
                    //   width: 380,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(15),
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
                    //   ),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => Teller()));
                    //     },
                    //     child: Row(
                    //       children: const <Widget>[
                    //         SizedBox(
                    //           width: 20,
                    //         ),
                    //         Icon(
                    //           Icons.qr_code,
                    //         ),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           "Collect Fund",
                    //           style: TextStyle(
                    //             fontFamily: "OpenSans",
                    //             fontWeight: FontWeight.w800,
                    //             fontSize: 16,
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),

                    // Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   TellerCustomery(widget.ID)));
                    SizedBox(
                      height: _height * .01,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: _width * .05),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Liquid(
                                          int.parse(widget.ID.toString()))));
                            },
                            child: Container(
                              width: _width * .9,
                              height: _height * .065,
                              decoration: BoxDecoration(
                                color: Color(0xfffffff),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: Offset.zero,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    _width * .06,
                                    _height * .0157,
                                    _width * .06,
                                    _height * .0157),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Liquidate Till",
                                      style: GoogleFonts.poppins(
                                        fontSize: _height * .015,
                                        fontWeight: FontWeight.w400,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    Icon(
                                      Icons.medication_liquid,
                                      color: kPrimaryColor,
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Container(
                    //   height: 50,
                    //   width: 380,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
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
                    //   ),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   Liquid(int.parse(widget.ID.toString()))));
                    //     },
                    //     child: Row(
                    //       children: <Widget>[
                    //         const SizedBox(
                    //           width: 20,
                    //         ),
                    //         const Icon(
                    //           Icons.medication_liquid,
                    //           color: Colors.white,
                    //         ),
                    //         const SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           "Liquidate Till",
                    //           style: GoogleFonts.poppins(
                    //             fontWeight: FontWeight.w800,
                    //             fontSize: 16,
                    //             color: Colors.white,
                    //             //fontWeight: FontWeight.bold,
                    //             //fontFamily: "OpenSans",
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Container(
                    //   height: 50,
                    //   width: 380,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
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
                    //   ),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => const Teller()));
                    //     },
                    //     child: Row(
                    //       children: const <Widget>[
                    //         SizedBox(
                    //           width: 20,
                    //         ),
                    //         Icon(
                    //           Icons.qr_code,
                    //         ),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           "Collection Statement",
                    //           style: TextStyle(
                    //             fontFamily: "OpenSans",
                    //             fontWeight: FontWeight.w800,
                    //             fontSize: 16,
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),

                    SizedBox(
                      height: _height * .01,
                    ),
                    // Padding(
                    //   padding: EdgeInsets.symmetric(horizontal: _width * .05),
                    //   child: Column(
                    //     children: [
                    //       FutureBuilder(
                    //           future: getSharedData(),
                    //           builder: (context, snapshot) {
                    //             var _loginuser = snapshot.data ?? null;
                    //             print("Ararayghsb - $_loginuser");
                    //             if (snapshot.hasData) {
                    //               return InkWell(
                    //                 onTap: () {
                    //                   Navigator.push(
                    //                       context,
                    //                       MaterialPageRoute(
                    //                           builder: (context) => Liquid(
                    //                               int.parse(
                    //                                   widget.ID.toString()))));
                    //                 },
                    //                 child: Container(
                    //                   width: _width * .9,
                    //                   height: _height * .065,
                    //                   decoration: BoxDecoration(
                    //                     color: Color(0xfffffff),
                    //                     borderRadius: BorderRadius.circular(5),
                    //                     boxShadow: [
                    //                       BoxShadow(
                    //                         color: Colors.black26,
                    //                         blurStyle: BlurStyle.outer,
                    //                         blurRadius: 10,
                    //                         spreadRadius: 0,
                    //                         offset: Offset.zero,
                    //                       ),
                    //                     ],
                    //                   ),
                    //                   child: Padding(
                    //                     padding: EdgeInsets.fromLTRB(
                    //                         _width * .06,
                    //                         _height * .0157,
                    //                         _width * .06,
                    //                         _height * .0157),
                    //                     child: Center(
                    //                         child: Row(
                    //                       mainAxisAlignment:
                    //                           MainAxisAlignment.spaceBetween,
                    //                       children: [
                    //                         Text(
                    //                           "Customer Enquiry",
                    //                           style: GoogleFonts.poppins(
                    //                               fontSize: _height * .015,
                    //                               fontWeight: FontWeight.w400,
                    //                               color: kPrimaryColor),
                    //                         ),
                    //                         Icon(
                    //                           Icons.dashboard_customize_rounded,
                    //                           color: kPrimaryColor,
                    //                         ),
                    //                       ],
                    //                     )),
                    //                   ),
                    //                 ),
                    //               );
                    //             } else
                    //               return CircularProgressIndicator();
                    //           }),
                    //     ],
                    //   ),
                    // ),
                    // SizedBox(
                    //   height: _height * .01,
                    // ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: _width * .05),
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => OpenAcc()), (route) => false);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OpenAcc(
                                          "",
                                          Provider.of<ServiceClass>(context)
                                              .getStates,
                                          "")));
                            },
                            child: Container(
                              width: _width * .9,
                              height: _height * .065,
                              decoration: BoxDecoration(
                                color: Color(0xfffffff),
                                borderRadius: BorderRadius.circular(5),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurStyle: BlurStyle.outer,
                                    blurRadius: 10,
                                    spreadRadius: 0,
                                    offset: Offset.zero,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                    _width * .06,
                                    _height * .0157,
                                    _width * .06,
                                    _height * .0157),
                                child: Center(
                                    child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Open Account",
                                      style: GoogleFonts.poppins(
                                        fontSize: _height * .015,
                                        fontWeight: FontWeight.w400,
                                        color: kPrimaryColor,
                                      ),
                                    ),
                                    Icon(
                                      Icons.point_of_sale,
                                      color: kPrimaryColor,
                                    ),
                                  ],
                                )),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: _height * .01,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: _width * .05),
                      child: Column(
                        children: [
                          FutureBuilder(
                            future: getSharedData(),
                            builder: ((context, snapshot) {
                              if (snapshot.hasData) {
                                var _data = snapshot.data ?? "";
                                print(_data);
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => OpenAccount(
                                                int.parse(_data.toString()))));
                                  },
                                  child: Container(
                                    width: _width * .9,
                                    height: _height * .065,
                                    decoration: BoxDecoration(
                                      color: Color(0xfffffff),
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black26,
                                          blurStyle: BlurStyle.outer,
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                          offset: Offset.zero,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(
                                          _width * .06,
                                          _height * .0157,
                                          _width * .06,
                                          _height * .0157),
                                      child: Center(
                                          child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Daily Collections Summary",
                                            style: GoogleFonts.poppins(
                                                fontSize: _height * .015,
                                                fontWeight: FontWeight.w400,
                                                color: kPrimaryColor),
                                          ),
                                          Icon(
                                            Icons.collections,
                                            color: kPrimaryColor,
                                          ),
                                        ],
                                      )),
                                    ),
                                  ),
                                );
                              } else
                                return CircularProgressIndicator();
                            }),
                          ),
                        ],
                      ),
                    ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Container(
                    //   height: 50,
                    //   width: 380,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
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
                    //   ),
                    //   child: FutureBuilder(
                    //       future: getSharedData(),
                    //       builder: (context, snapshot) {
                    //         var _loginuser = snapshot.data ?? null;
                    //         print("Ararayghsb - $_loginuser");
                    //         if (snapshot.hasData) {
                    //           if(snapshot.hasData){
                    //           return InkWell(
                    //             onTap: () {
                    //               Navigator.push(
                    //                   context,
                    //                   MaterialPageRoute(
                    //                       builder: (context) => Customer(
                    //                           int.parse(
                    //                               _loginuser.toString()))));
                    //             },
                    //             child: Row(
                    //               children: <Widget>[
                    //                 const SizedBox(
                    //                   width: 20,
                    //                 ),
                    //                 const Icon(
                    //                   Icons.dashboard_customize_rounded,
                    //                   color: Colors.white,
                    //                 ),
                    //                 const SizedBox(
                    //                   width: 10,
                    //                 ),
                    //                 Text(
                    //                   "Customer Enquiry",
                    //                   style: GoogleFonts.poppins(
                    //                     fontWeight: FontWeight.w800,
                    //                     fontSize: 16,
                    //                     color: Colors.white,
                    //                     //fontWeight: FontWeight.bold,
                    //                     //fontFamily: "OpenSans",
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           );
                    //         } else
                    //           return CircularProgressIndicator();
                    //       }),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Container(
                    //   height: 50,
                    //   width: 380,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
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
                    //   ),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => const OpenAccount()));
                    //     },
                    //     child: Row(
                    //       children: <Widget>[
                    //         const SizedBox(
                    //           width: 20,
                    //         ),
                    //         const Icon(
                    //           Icons.point_of_sale,
                    //           color: Colors.white,
                    //         ),
                    //         const SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           "Open Account",
                    //           style: GoogleFonts.poppins(
                    //             fontWeight: FontWeight.w800,
                    //             fontSize: 16,
                    //             color: Colors.white,
                    //             //fontWeight: FontWeight.bold,
                    //             //fontFamily: "OpenSans",
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Container(
                    //   height: 50,
                    //   width: 380,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
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
                    //   ),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) =>
                    //                   const DailyCollections()));
                    //     },
                    //     child: Row(
                    //       children: <Widget>[
                    //         const SizedBox(
                    //           width: 20,
                    //         ),
                    //         const Icon(
                    //           Icons.collections,
                    //           color: Colors.white,
                    //         ),
                    //         const SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           "Daily Collections Summary",
                    //           style: GoogleFonts.poppins(
                    //             fontWeight: FontWeight.w800,
                    //             fontSize: 16,
                    //             color: Colors.white,
                    //             //fontWeight: FontWeight.bold,
                    //             //fontFamily: "OpenSans",
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Container(
                    //   height: 50,
                    //   width: 380,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
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
                    //   ),
                    //   child: InkWell(
                    //     onTap: () {
                    //       Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //               builder: (context) => SummaryAccount()));
                    //     },
                    //     child: Row(
                    //       children: const <Widget>[
                    //         SizedBox(
                    //           width: 20,
                    //         ),
                    //         Icon(
                    //           Icons.point_of_sale,
                    //         ),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           "Account Opened",
                    //           style: TextStyle(
                    //             fontFamily: "OpenSans",
                    //             fontWeight: FontWeight.w800,
                    //             fontSize: 16,
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 5,
                    // ),
                    // Container(
                    //   height: 50,
                    //   width: 380,
                    //   decoration: BoxDecoration(
                    //     borderRadius: BorderRadius.circular(10),
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
                    //   ),
                    //   child: InkWell(
                    //     onTap: () {},
                    //     child: Row(
                    //       children: const <Widget>[
                    //         SizedBox(
                    //           width: 20,
                    //         ),
                    //         Icon(
                    //           Icons.point_of_sale,
                    //         ),
                    //         SizedBox(
                    //           width: 10,
                    //         ),
                    //         Text(
                    //           "Print Receipt",
                    //           style: TextStyle(
                    //             fontFamily: "OpenSans",
                    //             fontWeight: FontWeight.w800,
                    //             fontSize: 16,
                    //             color: Colors.white,
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
                    SizedBox(
                      height: _height * .02,
                    ),
                    Container(
                      width: _width * .4,
                      height: _height * .04,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(5),
                        // ignore: prefer_const_constructors
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            showloading = true;
                          });
                          logOut();
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => Loading()));
                          // Navigator.pushNamed(context, '/bills');
                        },
                        child: Center(
                          child: Text(
                            "LOG OUT",
                            style: GoogleFonts.poppins(
                              //fontFamily: "OpenSans",
                              //ontWeight: FontWeight.w100,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              //fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // bottomNavigationBar: SingleChildScrollView(
              //   scrollDirection: Axis.vertical,
              //   child: BottomAppBar(
              //     shape: const CircularNotchedRectangle(),
              //     notchMargin: 10,
              //     color: Colors.transparent,
              //     child: Container(
              //       height: 40,
              //       decoration: const BoxDecoration(
              //         gradient: LinearGradient(
              //           begin: Alignment.topLeft,
              //           end: Alignment.bottomRight,
              //           colors: <Color>[
              //             Color(0xff403109),
              //             Color(0xff211b0b),
              //           ],
              //         ),
              //         borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(20),
              //           topRight: Radius.circular(20),
              //         ),
              //       ),
              //       child: Row(
              //         children: <Widget>[
              //           const SizedBox(
              //             width: 10,
              //           ),
              //           SingleChildScrollView(
              //             scrollDirection: Axis.vertical,
              //             child: Column(
              //               children: <Widget>[
              //                 const SizedBox(
              //                   height: 0,
              //                 ),
              //                 IconButton(
              //                   onPressed: () {
              //                     Navigator.pushNamed(context, '/homee');
              //                   },
              //                   icon: const Icon(
              //                     Icons.home,
              //                     color: Colors.white,
              //                   ),
              //                   color: Colors.white,
              //                 ),
              //                 const Text(
              //                   'Home',
              //                   style: TextStyle(
              //                     fontSize: 12,
              //                     color: Colors.white,
              //                     letterSpacing: 0.5,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           const SizedBox(
              //             width: 40,
              //           ),
              //           SingleChildScrollView(
              //             scrollDirection: Axis.vertical,
              //             child: Column(
              //               children: <Widget>[
              //                 const SizedBox(
              //                   height: 0,
              //                 ),
              //                 IconButton(
              //                   onPressed: () {
              //                     Navigator.pushNamed(context, '/bills');
              //                   },
              //                   icon: const Icon(
              //                     Icons.ad_units,
              //                   ),
              //                   color: Colors.orange,
              //                 ),
              //                 Text(
              //                   'Menu',
              //                   style: TextStyle(
              //                     fontSize: 11,
              //                     color: Colors.orange,
              //                     letterSpacing: 0,
              //                     fontWeight: FontWeight.bold,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           const SizedBox(
              //             width: 33,
              //           ),
              //           SingleChildScrollView(
              //             scrollDirection: Axis.vertical,
              //             child: Column(
              //               children: <Widget>[
              //                 const SizedBox(
              //                   height: 0,
              //                 ),
              //                 IconButton(
              //                   onPressed: () {},
              //                   icon: const Icon(
              //                     Icons.scanner_sharp,
              //                   ),
              //                   color: Colors.white,
              //                 ),
              //                 Text(
              //                   'Scan',
              //                   style: TextStyle(
              //                     fontSize: 12,
              //                     color: Colors.white,
              //                     letterSpacing: 0.5,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           const SizedBox(
              //             width: 33,
              //           ),
              //           SingleChildScrollView(
              //             scrollDirection: Axis.vertical,
              //             child: Column(
              //               children: <Widget>[
              //                 const SizedBox(
              //                   height: 0,
              //                 ),
              //                 IconButton(
              //                   onPressed: () {
              //                     Navigator.pushNamed(context, '/support');
              //                   },
              //                   icon: const Icon(
              //                     Icons.headset_mic_outlined,
              //                   ),
              //                   color: Colors.white,
              //                 ),
              //                 Text(
              //                   'Support',
              //                   style: TextStyle(
              //                     fontSize: 12,
              //                     color: Colors.white,
              //                     letterSpacing: 0.5,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //           const SizedBox(
              //             width: 30,
              //           ),
              //           SingleChildScrollView(
              //             scrollDirection: Axis.vertical,
              //             child: Column(
              //               children: <Widget>[
              //                 const SizedBox(
              //                   height: 0,
              //                 ),
              //                 IconButton(
              //                   onPressed: () {},
              //                   icon: const Icon(
              //                     Icons.manage_accounts,
              //                   ),
              //                   color: Colors.white,
              //                 ),
              //                 Text(
              //                   'Profile',
              //                   style: TextStyle(
              //                     fontSize: 12,
              //                     color: Colors.white,
              //                     letterSpacing: 0.5,
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              // floatingActionButton: FloatingActionButton(
              //   onPressed: () {
              //     //getFireData();
              //   },
              //   child: const Icon(
              //     Icons.add,
              //     color: Colors.white,
              //   ),
              // ),
            )
          : _filterDialog(context),
      // Visibility(
      //     visible: showloading,
      //     child: _filterDialog(context),
      //   ),
      // Scaffold(
      //     backgroundColor: kBackgroundHome2,
      //     body: Center(
      //       child: Column(
      //         children: [
      //           SizedBox(
      //             height: _height * .45,
      //           ),
      //           const CircularProgressIndicator(
      //             strokeWidth: 10,
      //             semanticsLabel: ("Please Wait"),
      //           ),
      //           const SizedBox(
      //             height: 10,
      //           ),
      //           const Text(
      //             "Loading...",
      //             style: TextStyle(
      //               color: Colors.black54,
      //               fontSize: 20,
      //               fontFamily: "OpenSans",
      //               letterSpacing: 0,
      //               //fontWeight: FontWeight.bold,
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
    );
  }

  Widget _filterDialog(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    var containerheight = _height * .354;
    var _mypadding = SizedBox(height: containerheight * .12);
    return Scaffold(
      //backgroundColor: Colors.black45,
      body: Center(
        child: Container(
          //height: 50,
          width: _width * .20,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: AnimatedBuilder(
            animation: anicontroller,
            builder: (context, child) {
              return Transform.rotate(
                angle: anicontroller.value * 2 * pi,
                child: child,
              );
            },
            child: Image.asset(
              "lib/images/roundt.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
        // CircularProgressIndicator(
        //   color: Colors.blue,
        //   strokeWidth: 20,
        // ),
      ),
    );
  }

  Widget containerCustom(MobileTellerRequestList mylist) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _width * .05),
      child: Column(
        children: [
          FutureBuilder(
            future: getSharedData(),
            builder: (context, snapshot) {
              var _loginuser = snapshot.data ?? null;
              print("Ararayghsb - $_loginuser");
              if (snapshot.hasData) {
                return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CheckBalance(
                                  int.parse(_loginuser.toString()))));
                    },
                    child: Container(
                      width: _width * .9,
                      height: _height * .065,
                      decoration: BoxDecoration(
                        color: Color(0xffffffff),
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurStyle: BlurStyle.outer,
                            blurRadius: 10,
                            spreadRadius: 0,
                            offset: Offset.zero,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(_width * .06,
                            _height * .0157, _width * .06, _height * .0157),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Get Balance",
                                style: GoogleFonts.poppins(
                                  fontSize: _height * .015,
                                  fontWeight: FontWeight.w400,
                                  color: kPrimaryColor,
                                ),
                              ),
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                color: kPrimaryColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ));
              } else
                return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );

    // height: 50,
    // width: 380,
    // decoration: BoxDecoration(
    //   borderRadius: BorderRadius.circular(10),
    //   // ignore: prefer_const_constructors
    //   gradient: LinearGradient(
    //     begin: Alignment.topLeft,
    //     end: Alignment.bottomRight,
    //     // 10% of the width, so there are ten blinds.
    //     // ignore: prefer_const_literals_to_create_immutables
    //     colors: <Color>[
    //       kPrimaryColor,
    //       kSecondaryColor,
    //     ], // red to yellow
    //     tileMode: TileMode.repeated, // repeats the gradient over the canvas
    //   ),
    // ),
    // child: FutureBuilder(
    //   future: getSharedData(),
    //   builder: (context, snapshot) {
    //     var _loginuser = snapshot.data ?? null;
    //     print("Ararayghsb - $_loginuser");
    //     if (snapshot.hasData) {
    //       return InkWell(
    //           onTap: () {
    //             Navigator.push(
    //                 context,
    //                 MaterialPageRoute(
    //                     builder: (context) =>
    //                         CheckBalance(int.parse(_loginuser.toString()))));
    //           },
    //           child: Center(
    //             child: Row(
    //               children: <Widget>[
    //                 const SizedBox(
    //                   width: 20,
    //                 ),
    //                 const Icon(
    //                   Icons.account_balance_wallet_outlined,
    //                   color: Colors.white,
    //                 ),
    //                 const SizedBox(width: 10),
    //                 Text(
    //                   "Get Balance",
    //                   style: GoogleFonts.poppins(
    //                     fontWeight: FontWeight.w800,
    //                     fontSize: 16,
    //                     color: Colors.white,
    //                     //fontWeight: FontWeight.bold,
    //                     //fontFamily: "OpenSans",
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ));
    //     } else
    //       return CircularProgressIndicator();
    //   },
    // ),
    // // child:  InkWell(
    // //   onTap: () {

    // //     Navigator.push(
    // //         context,
    // //         MaterialPageRoute(
    // //             builder: (context) => CheckBalance(mylist.loginUserId!)));
    // //     //getTeller();
    // //   },
    // //   child: Row(
    // //     children: const <Widget>[
    // //       SizedBox(
    // //         width: 20,
    // //       ),
    // //       Icon(
    // //         Icons.point_of_sale,
    // //       ),
    // //       SizedBox(
    // //         width: 10,
    // //       ),
    // //       Text(
    // //         "Get Balance",
    // //         style: TextStyle(
    // //           fontFamily: "OpenSans",
    // //           fontWeight: FontWeight.w800,
    // //           fontSize: 16,
    // //           color: Colors.white,
    // //         ),
    // //       ),
    // //     ],
    // // ),
    // // ),
    //);
  }

  Future<void> balance() async {
    ServiceClass serviceClass = ServiceClass();
    serviceClass.getBalance(widget.ID).then((value) => (output(value)));
  }

  void output(String body) {
    print("YEAH, lets get balance now...");
    print(body);
    if (body.contains("no balance exists for user.")) {
      //showMessage("No balance for this user");
      setState(() {
        noBalance = true;
        showData = true;
        loading = false;
        showloading = false;
      });
    } else {
      var bodyT = jsonDecode(body);
      if (bodyT["loginUserId"] != null) {
        setState(() {
          customerBalance = GetBalance.fromJson(bodyT);
          showBalance = true;
          showData = true;
          showloading = false;
        });
      } else {
        showloading = false;
        showMessage(bodyT["message"]);
      }
    }
  }
}
