import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teller/cashDepostit.dart';
import 'package:teller/dailyCollections.dart';
import 'package:teller/liquid.dart';
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

class _HomeState extends State<Home> {
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

  // SharedPreferences share =
  //     SharedPreferences.getInstance() as SharedPreferences;

  //late SharedPreferences sharedPreferences;
  GetBalance? customerBalance;
  String? loginID = "";
  bool noBalance = false;
  bool showData = false;
  bool showBalance = false;
  bool loading = false;
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

  // if (SharedPreferences != null)async{
  //   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  //   String? username = sharedPreferences.getString("username");
  //   String? password = sharedPreferences.getString("password");

  //   setState(() {
  //     loginID = username!;
  //   });
  // }

  List seyi = [
    Texts(1, "Transfer to Harley Johnson", "- \$1,000,000", "",
        "Intrabank transfer at 2:41pm"),
    Texts(2, "Airtime Recharge on 08137330706", "- \$200", "/",
        "Airtime recharge at 3:11pm"),
    Texts(3, "Transfer to Aderonke Fatunmole", "- \$500,000", "/",
        "Airtime recharge at 10:00pm"),
    Texts(5, "Airtel Data Recharge on 08033486660", "- \$1,000", "/",
        "Data recharge at 11:06pm"),
    Texts(6, "Transfer to Ebun Fatunmdoole", "- \$5,000", "/",
        "Intrabank transfer at 2:00am"),
    Texts(7, "Transfer to Tomilola Fatunmole", "- \$5,000", "/",
        "Interbank transfer at 3:00am"),
    Texts(8, "Transfer to Damilare Ajayi", "- \$5,000", "/",
        "Interbank transfer at 7:00am"),
    Texts(9, "Credit Alert from Ebun Fatunmole", "+ \$50,000", "/",
        "Account credited at 9:00am"),
    Texts(10, "Credit Alert from Denukan Network Limited", "+ \$500,000", "/",
        "Account credited at 10:00am"),
    Texts(11, "Credit Alert from Adeboye Samson", "+ \$5,000", "/",
        "Account credited at 10:22am"),
    Texts(12, "ATM Charges for month of January", "- \$300", "/",
        "Account debited at 10:35am"),
    Texts(13, "Stamp Duty for month of january", "- \$1,000", "/",
        "Account debited at 11:11am"),
    Texts(14, "Transfer to Oluwatobi Osho", "- \$300,000", "/",
        "Interbank transfer at 11:45am"),
    Texts(15, "Credit Alert from Chapel Of Uncommon grace", "+ \$30,000", "/",
        "Account credited at 11:52am"),
    Texts(16, "Credit Alert from CliqBank HQ", " + \$5000", "/",
        "Account credited at 11:55am"),
  ];
  @override
  void initState() {
    setUser();
    print("BOOS - $loginID");
    balance();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    print("Welcome seyi.. device width - $_width");
    print("Welcome seyi.. device height - $_height");
    return Container(
      width: _width,
      height: _height,
      child: showData
          ? Scaffold(
              key: _scaffoldKey,

              backgroundColor: kBackgroundHome2,

              appBar: AppBar(
                automaticallyImplyLeading: false,
                title: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const <Widget>[
                        SizedBox(
                          width: 0,
                        ),

                        // Text(
                        //   "HOME PAGE",
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontSize: 15,
                        //     fontWeight: FontWeight.bold,
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: _width * .75,
                      height: _height * .125,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
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
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          const BoxShadow(
                            color: Colors.blue,
                            offset: Offset.zero,
                            blurStyle: BlurStyle.outer,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                          ),
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/homee');
                        },
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            const SizedBox(
                              height: 17,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // ignore: prefer_const_constructors
                                SizedBox(
                                  width: 10,
                                ),
                                userData
                                    ?
                                    //final _user = {sharedPreferences.get("username")};

                                    const Text(
                                        "               Welcome Teller  ",
                                        style: TextStyle(
                                          fontFamily: "OpenSans",
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          letterSpacing: 0,
                                          color: Colors.white,
                                        ),
                                      )
                                    : const Text("There was an error")
                              ],
                            ),
                            // ignore: prefer_const_constructors
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // ignore: prefer_const_constructors
                                SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        Center(
                                            // child: Text(
                                            //   "                           System Date : May 4, 2022",
                                            //   style: TextStyle(
                                            //     fontFamily: "OpenSans",
                                            //     fontWeight: FontWeight.bold,
                                            //     fontSize: 12,
                                            //   ),
                                            // ),
                                            ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        // Text(
                                        //   "                            Calendar Date : May 5, 2022",
                                        //   style: TextStyle(
                                        //     fontFamily: "OpenSans",
                                        //     fontWeight: FontWeight.bold,
                                        //     fontSize: 12,
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        noBalance
                                            ? FutureBuilder(
                                                future: getSharedData(),
                                                builder: (context, snapshot) {
                                                  var _loginuser =
                                                      snapshot.data!;
                                                  print(
                                                      "Ararayghsb - $_loginuser");
                                                  if (snapshot.hasData) {
                                                    return Text(
                                                      "                 Teller ID : ${_loginuser.toString()}",
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 14,
                                                        fontFamily: "OpenSans",
                                                        letterSpacing: 1.0,
                                                        //fontWeight: FontWeight.bold,
                                                      ),
                                                    );
                                                  } else
                                                    return CircularProgressIndicator();
                                                },
                                              )
                                            : Text(
                                                "            Teller ID : ${customerBalance!.loginUserId}",
                                                style: const TextStyle(
                                                  fontFamily: "OpenSans",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  letterSpacing: 1.0,
                                                  color: Colors.white,
                                                ),
                                              ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    noBalance
                                        ? const Text(
                                            "                 Till Balance : ₦0.00",
                                            style: TextStyle(
                                              fontFamily: "OpenSans",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              letterSpacing: 1.0,
                                              color: Colors.white,
                                            ),
                                          )
                                        : Text(
                                            "                 Till Balance : ₦${customerBalance!.currentbalance}0",
                                            style: const TextStyle(
                                              fontFamily: "OpenSans",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 14,
                                              color: Colors.white,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        Text(
                          "Menu",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            color: kPrimaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                toolbarHeight: 200,
                backgroundColor: kBackgroundHome2,
                elevation: 0.0,
                // ignore: prefer_const_constructors
                shape: RoundedRectangleBorder(
                  // ignore: prefer_const_constructors
                  borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(15),
                    bottomRight: const Radius.circular(15),
                  ),
                ),
              ),
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
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        // Text(
                        //   "  MENU",
                        //   style: TextStyle(
                        //     color: kPrimaryColor,
                        //     fontSize: 16,
                        //     fontWeight: FontWeight.bold,
                        //     letterSpacing: 2.0,
                        //   ),
                        // ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: 50,
                      width: 380,
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
                                  builder: (context) => Teller()));
                        },
                        child: Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.qr_code,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Teller Profile",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      width: 380,
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
                                  builder: (context) => const WalletFund()));
                        },
                        child: Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.wifi,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Request Fund",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    FutureBuilder(
                      future: getSharedData(),
                      builder: (context, snapshot) {
                        var _loginuser = snapshot.data!;
                        print("Ararayghsb - $_loginuser");
                        if (snapshot.hasData) {
                          return Container(
                              width: 380,
                              height: 50,
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
                                          builder: (context) => TellerList(
                                              int.parse(
                                                  _loginuser.toString()))));
                                },
                                child: Row(
                                  children: const <Widget>[
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.qr_code,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Teller Request List",
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        } else
                          return CircularProgressIndicator();
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    noBalance
                        ? Container(
                            child: FutureBuilder(
                              future: getSharedData(),
                              builder: (context, snapshot) {
                                var _loginuser = snapshot.data!;
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
                    const SizedBox(
                      height: 5,
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

                    Container(
                      height: 50,
                      width: 380,
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
                                  builder: (context) => const CashDeposit()));
                        },
                        child: Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.wifi,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Deposit Cash",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      width: 380,
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
                                  builder: (context) => Liquid()));
                        },
                        child: Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.wifi,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Deposit Cash Liquidation",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      width: 380,
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
                                  builder: (context) => Teller()));
                        },
                        child: Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.qr_code,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Collection Statement",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      width: 380,
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
                      child: FutureBuilder(
                          future: getSharedData(),
                          builder: (context, snapshot) {
                            var _loginuser = snapshot.data!;
                            print("Ararayghsb - $_loginuser");
                            if (snapshot.hasData) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Customer(
                                              int.parse(
                                                  _loginuser.toString()))));
                                },
                                child: Row(
                                  children: const <Widget>[
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.atm_sharp,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Customer Enquiry",
                                      style: TextStyle(
                                        fontFamily: "OpenSans",
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            } else
                              return CircularProgressIndicator();
                          }),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      width: 380,
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
                                  builder: (context) => OpenAccount()));
                        },
                        child: Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.point_of_sale,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Open Account",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      width: 380,
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
                                  builder: (context) =>
                                      const DailyCollections()));
                        },
                        child: Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.point_of_sale,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Daily Collections Summary",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      width: 380,
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
                                  builder: (context) => SummaryAccount()));
                        },
                        child: Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.point_of_sale,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Account Opened",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Container(
                      height: 50,
                      width: 380,
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
                        onTap: () {},
                        child: Row(
                          children: const <Widget>[
                            SizedBox(
                              width: 20,
                            ),
                            Icon(
                              Icons.point_of_sale,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Print Receipt",
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                fontWeight: FontWeight.w800,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    Container(
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
                          Navigator.pushNamed(context, '/bills');
                        },
                        child: const Center(
                          child: Text(
                            "Log Out",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
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
          : Scaffold(
              backgroundColor: kBackgroundHome2,
              body: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: _height * .45,
                    ),
                    const CircularProgressIndicator(
                      strokeWidth: 10,
                      semanticsLabel: ("Please Wait"),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Loading...",
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
              ),
            ),
    );
  }

  Widget containerCustom(MobileTellerRequestList mylist) => Container(
        height: 50,
        width: 380,
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
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
          ),
        ),
        child: FutureBuilder(
          future: getSharedData(),
          builder: (context, snapshot) {
            var _loginuser = snapshot.data!;
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
                  child: Center(
                    child: Row(
                      children: const <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Icon(
                          Icons.point_of_sale,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Get Balance",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ));
            } else
              return CircularProgressIndicator();
          },
        ),
        // child:  InkWell(
        //   onTap: () {

        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => CheckBalance(mylist.loginUserId!)));
        //     //getTeller();
        //   },
        //   child: Row(
        //     children: const <Widget>[
        //       SizedBox(
        //         width: 20,
        //       ),
        //       Icon(
        //         Icons.point_of_sale,
        //       ),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Text(
        //         "Get Balance",
        //         style: TextStyle(
        //           fontFamily: "OpenSans",
        //           fontWeight: FontWeight.w800,
        //           fontSize: 16,
        //           color: Colors.white,
        //         ),
        //       ),
        //     ],
        // ),
        // ),
      );

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
