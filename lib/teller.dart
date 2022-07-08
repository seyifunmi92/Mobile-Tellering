import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teller/models.dart';
import 'package:teller/security.dart';
import 'package:teller/tellerlist.dart';
import 'package:teller/walletfund.dart';
import 'package:teller/welcome.dart';
import 'package:teller/welcome.dart';
import 'package:teller/services.dart';
import 'package:teller/constants.dart';
import 'package:teller/textstyle.dart';
import 'package:teller/login.dart';
import 'package:teller/teller.dart';
import 'package:teller/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teller/tellerlist.dart';
import 'package:teller/tellerrequest.dart';




class Teller extends StatefulWidget {
  const Teller({Key? key}) : super(key: key);
  @override
  _TellerState createState() => _TellerState();
}

class _TellerState extends State<Teller> {
 List<MobileTellerRequestList> contain = [];
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
                          " Welcome Teller : Seyi Fatunmole",
                          style: TextStyle(
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w800,
                            //fontWeight: FontWeight.bold,
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
                                      fontWeight: FontWeight.w800,
                                      //fontWeight: FontWeight.bold,
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
                                    fontWeight: FontWeight.w800,
                                    //fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                // Text(
                                //   "                     Teller ID : 1025",
                                //   style: TextStyle(
                                //     fontWeight: FontWeight.bold,
                                //     fontSize: 12,
                                //   ),
                                // ),
                              ],
                            ),
                            // const Text(
                            //   "                          Till Balance : -\$504,000",
                            //   style: TextStyle(
                            //     fontWeight: FontWeight.bold,
                            //     fontSize: 12,
                            //   ),
                            // ),
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
              children: [
                Row(
                  children: const [
                    Text(
                      "Teller Name : Seyi Fatunmole",
                      style: TextStyle(
                        fontFamily: "OpenSans",

                        color: kPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: 110,),
                    Text(
                      "Teller ID : 1025",
                      style: TextStyle(
                        fontFamily: "OpenSans",

                        color: kPrimaryColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
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
                onTap: () {},
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
                      "Reset Password",
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Security()));
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
                      "Change Answer to Secret Question",
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WalletFund()));
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
                      "Wallet Fund Request",
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
            ...contain.map((e) => containerCustom(
              e,
            )),

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
                   Navigator.push(
                       context, MaterialPageRoute(builder: (context) => TellerRequest()));
                  //getTeller();
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
                      "Wallet Fund Request List",
                      style: TextStyle(
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
                      "Total Collections Today",
                      style: TextStyle(
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
                      "Till Balance",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // SizedBox(height: 5,),
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
            //       tileMode:
            //       TileMode.repeated, // repeats the gradient over the canvas
            //     ),
            //   ),
            //   child: InkWell(
            //     onTap: () {},
            //     child: Row(
            //       children: <Widget>[
            //         const SizedBox(
            //           width: 20,
            //         ),
            //         const Icon(
            //           Icons.point_of_sale,
            //         ),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //         Text(
            //           "Account Opened",
            //           style: TextStyle(
            //             fontSize: 16,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 5,),
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
            //       tileMode:
            //       TileMode.repeated, // repeats the gradient over the canvas
            //     ),
            //   ),
            //   child: InkWell(
            //     onTap: () {},
            //     child: Row(
            //       children: <Widget>[
            //         const SizedBox(
            //           width: 20,
            //         ),
            //         const Icon(
            //           Icons.point_of_sale,
            //         ),
            //         const SizedBox(
            //           width: 10,
            //         ),
            //         Text(
            //           "Print Receipt",
            //           style: TextStyle(
            //             fontSize: 16,
            //             color: Colors.white,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            const SizedBox(
              height: 120,
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => Home()));
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


  Widget containerCustom(MobileTellerRequestList mylist) => Container(
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TellerRequest()));
        //getTeller();
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
            "Wallet Fund Request List",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );


  void getTeller(int loginUserId) {
    print("hello seyi araoluwa");
    print("We are In Teller Request now oo now...");
    ServiceClass serviceClass = ServiceClass();
    serviceClass.TellerRequest(loginUserId).then((value) =>
        MaterialPageRoute(builder: (context) => TellerList(loginUserId)));
  }
}
