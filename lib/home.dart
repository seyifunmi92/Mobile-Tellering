import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teller/cashDepostit.dart';
import 'package:teller/dailyCollections.dart';
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





class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
  Widget build(BuildContext context) {
    return Scaffold(

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
              width: 320,
              height: 120,
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
                  tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
                ),
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  const BoxShadow(
                    color: Colors.blue,
                    offset: Offset.zero,
                    blurStyle: BlurStyle.outer,
                    blurRadius: 10.0,
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
                      children: const [
                        // ignore: prefer_const_constructors
                         SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Welcome Teller : Seyi Fatunmole",
                          style: TextStyle(
                            fontFamily: "OpenSans",

                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Center(
                                  child: Text(
                                    "                           System Date : May 4, 2022",
                                    style: TextStyle(
                                      fontFamily: "OpenSans",

                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [

                                Text(
                                  "                            Calendar Date : May 5, 2022",
                                  style: TextStyle(
                                    fontFamily: "OpenSans",

                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "                     Teller ID : 1025",
                                  style: TextStyle(
                                    fontFamily: "OpenSans",

                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            const Text(
                              "                          Till Balance : -\$504,000",
                              style: TextStyle(
                                fontFamily: "OpenSans",

                                fontWeight: FontWeight.bold,
                                fontSize: 12,
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        toolbarHeight: 180,
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
              children: [

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
                borderRadius: BorderRadius.circular(15),
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
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)  => Teller()));

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
                borderRadius: BorderRadius.circular(15),
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
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder:(context)  => Customer()));

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
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
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
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> CashDeposit()));
                },
                child: Row(
                  children: <Widget>[
                    const SizedBox(
                      width: 20,
                    ),
                    const Icon(
                      Icons.wifi,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Cash Deposit",
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
                borderRadius: BorderRadius.circular(15),
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
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> OpenAccount()));

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
            SizedBox(height: 5,),
            Container(
              height: 50,
              width: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
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
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context , MaterialPageRoute(builder: (context)=> DailyCollections()));
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
            const SizedBox(height: 5,),
            Container(
              height: 50,
              width: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
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
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> SummaryAccount()));
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
            const SizedBox(height: 5,),
            Container(
              height: 50,
              width: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
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
                  tileMode:
                  TileMode.repeated, // repeats the gradient over the canvas
                ),
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/bills');
                },
                child: const Center(
                  child: Text(
                    "BACK",
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
    );
  }
}
