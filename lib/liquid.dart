import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teller/cashDepostit.dart';
import 'package:teller/dailyCollections.dart';
import 'package:teller/home.dart';
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
import 'models.dart';

class Liquid extends StatefulWidget {
  const Liquid({Key? key}) : super(key: key);

  @override
  _LiquidState createState() => _LiquidState();
}

class _LiquidState extends State<Liquid> {
  bool buttonActive = false;
  TextEditingController loginC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController narateC = TextEditingController();
  TextEditingController acctC = TextEditingController();
  TextEditingController amtC = TextEditingController();
  TextEditingController acctNameC = TextEditingController();
  TextEditingController transRefC = TextEditingController();
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
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
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
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
              ),
              width: _width,
              height: _height * 0.25,
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  //RequestDetail mydata = _request!.createdate.toString;

                  // const Text(
                  //   "",
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 20,
                  //     fontFamily: "OpenSans",
                  //   ),
                  // ),

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
                    "Deposit Cash Liquidation",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: "OpenSans",
                      letterSpacing: 0,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 20,
                  // ),

                  // const Text(
                  //   "",
                  //   style: TextStyle(
                  //     color: Colors.white,
                  //     fontSize: 30,
                  //     fontFamily: "OpenSans",
                  //     letterSpacing: 0,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),

                  const SizedBox(
                    height: 10,
                  ),
                  // const Text(
                  //   "",
                  //   style: TextStyle(
                  //     color: Colors.amber,
                  //     fontSize: 13,
                  //     fontFamily: "OpenSans",
                  //     letterSpacing: 0,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  // Text()
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // Center(
            //   child:
            // ),

            const Text(
              "Please enter the following details",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 18,
                fontFamily: "OpenSans",
                letterSpacing: 0,
              ),
            ),
            const SizedBox(
              height: 70,
            ),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: Row(children: [
                //SvgPicture.asset("assets/svg/${emailIcon}.svg"),
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      TextField(
                        controller: loginC,
                        //controller: emailC,
                        cursorColor: Colors.blue,
                        // style: kmediumTextBold(kColorBlack),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (text1) {
                          if (text1.isNotEmpty) {
                            setState(() {
                              buttonActive = true;
                            });
                          } else {
                            setState(() {
                              buttonActive = false;
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
                        decoration: const InputDecoration(
                          hintText: "Login User Id",
                          hintStyle: TextStyle(
                            fontFamily: "OpenSans",
                            fontSize: 14,
                            //fontFamily: "Poppins",
                            fontWeight: FontWeight.w400,
                            //color: kColorBlack.withOpacity(.3)),
                            //border: InputBorder.none,
                          ),
                        ),
                      ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // TextField(
                      //   controller: acctC,
                      //   //controller: emailC,
                      //   cursorColor: Colors.blue,
                      //   // style: kmediumTextBold(kColorBlack),
                      //   keyboardType: TextInputType.number,
                      //   onChanged: (text2) {
                      //     if (acctC.text.isNotEmpty || text2.isNotEmpty) {
                      //       setState(() {
                      //         buttonActive = true;
                      //       });
                      //     } else if (acctC.text.isEmpty || text2.isEmpty) {
                      //       setState(() {
                      //         buttonActive = false;
                      //       });
                      //     } else if (acctC.text.isNotEmpty ||
                      //         loginC.text.isEmpty) {
                      //       setState(() {
                      //         buttonActive = false;
                      //       });
                      //     } else {
                      //       setState(() {
                      //         buttonActive = false;
                      //       });
                      //     }
                      //     // if (text.contains("@")) {
                      //     //   if (text.split("@")[1].contains(".")){
                      //     //     setState(() {
                      //     //       emailIcon = "email_icon2";
                      //     //     });
                      //     //   }else{
                      //     //     setState(() {
                      //     //       emailIcon = "email_icon";
                      //     //     });
                      //     //   }
                      //     // }else{
                      //     //   setState(() {
                      //     //     emailIcon = "email_icon";
                      //     //   });
                      //     // }
                      //   },
                      //   decoration: const InputDecoration(
                      //     hintText: "Account Number",
                      //     hintStyle: TextStyle(
                      //       fontSize: 14,
                      //       fontFamily: "OpenSans",
                      //       fontWeight: FontWeight.w400,
                      //       //color: kColorBlack.withOpacity(.3)),
                      //       //border: InputBorder.none,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 0,
                      ),
                      // TextField(
                      //   controller: acctNameC,
                      //   //controller: emailC,
                      //   cursorColor: Colors.blue,
                      //   // style: kmediumTextBold(kColorBlack),
                      //   keyboardType: TextInputType.number,
                      //   onChanged: (text2) {
                      //     if (acctNameC.text.isNotEmpty || text2.isNotEmpty) {
                      //       setState(() {
                      //         buttonActive = true;
                      //       });
                      //     } else if (acctNameC.text.isEmpty || text2.isEmpty) {
                      //       setState(() {
                      //         buttonActive = false;
                      //       });
                      //     } else if (acctNameC.text.isNotEmpty ||
                      //         loginC.text.isEmpty) {
                      //       setState(() {
                      //         buttonActive = false;
                      //       });
                      //     } else {
                      //       setState(() {
                      //         buttonActive = false;
                      //       });
                      //     }
                      //     // if (text.contains("@")) {
                      //     //   if (text.split("@")[1].contains(".")){
                      //     //     setState(() {
                      //     //       emailIcon = "email_icon2";
                      //     //     });
                      //     //   }else{
                      //     //     setState(() {
                      //     //       emailIcon = "email_icon";
                      //     //     });
                      //     //   }
                      //     // }else{
                      //     //   setState(() {
                      //     //     emailIcon = "email_icon";
                      //     //   });
                      //     // }
                      //   },
                      //   decoration: const InputDecoration(
                      //     hintText: "Account Name",
                      //     hintStyle: TextStyle(
                      //       fontSize: 14,
                      //       fontFamily: "OpenSans",
                      //       fontWeight: FontWeight.w400,
                      //       //color: kColorBlack.withOpacity(.3)),
                      //       //border: InputBorder.none,
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextField(
                        controller: narateC,
                        //controller: emailC,
                        cursorColor: Colors.blue,
                        // style: kmediumTextBold(kColorBlack),
                        keyboardType: TextInputType.number,
                        onChanged: (text2) {
                          if (narateC.text.isNotEmpty || text2.isNotEmpty) {
                            setState(() {
                              buttonActive = true;
                            });
                          } else if (narateC.text.isEmpty || text2.isEmpty) {
                            setState(() {
                              buttonActive = false;
                            });
                          } else if (narateC.text.isNotEmpty ||
                              loginC.text.isEmpty) {
                            setState(() {
                              buttonActive = false;
                            });
                          } else {
                            setState(() {
                              buttonActive = false;
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
                        decoration: const InputDecoration(
                          hintText: "Narration",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w400,
                            //color: kColorBlack.withOpacity(.3)),
                            //border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextField(
                        controller: dateC,
                        //controller: emailC,
                        cursorColor: Colors.blue,
                        // style: kmediumTextBold(kColorBlack),
                        keyboardType: TextInputType.number,
                        onChanged: (text2) {
                          if (dateC.text.isNotEmpty || text2.isNotEmpty) {
                            setState(() {
                              buttonActive = true;
                            });
                          } else if (dateC.text.isEmpty || text2.isEmpty) {
                            setState(() {
                              buttonActive = false;
                            });
                          } else if (dateC.text.isNotEmpty ||
                              loginC.text.isEmpty) {
                            setState(() {
                              buttonActive = false;
                            });
                          } else {
                            setState(() {
                              buttonActive = false;
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
                        decoration: const InputDecoration(
                          hintText: "Date (dd-mm-yy)",
                          hintStyle: TextStyle(
                            fontSize: 14,
                            fontFamily: "OpenSans",
                            fontWeight: FontWeight.w400,
                            //color: kColorBlack.withOpacity(.3)),
                            //border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // TextField(
                      //   controller: acctNameC,
                      //   //controller: emailC,
                      //   cursorColor: Colors.blue,
                      //   // style: kmediumTextBold(kColorBlack),
                      //   keyboardType: TextInputType.number,
                      //   onChanged: (text2) {
                      //     if (acctNameC.text.isNotEmpty || text2.isNotEmpty) {
                      //       setState(() {
                      //         buttonActive = true;
                      //       });
                      //     } else if (acctNameC.text.isEmpty || text2.isEmpty) {
                      //       setState(() {
                      //         buttonActive = false;
                      //       });
                      //     } else if (acctNameC.text.isNotEmpty ||
                      //         loginC.text.isEmpty) {
                      //       setState(() {
                      //         buttonActive = false;
                      //       });
                      //     } else {
                      //       setState(() {
                      //         buttonActive = false;
                      //       });
                      //     }
                      //     // if (text.contains("@")) {
                      //     //   if (text.split("@")[1].contains(".")){
                      //     //     setState(() {
                      //     //       emailIcon = "email_icon2";
                      //     //     });
                      //     //   }else{
                      //     //     setState(() {
                      //     //       emailIcon = "email_icon";
                      //     //     });
                      //     //   }
                      //     // }else{
                      //     //   setState(() {
                      //     //     emailIcon = "email_icon";
                      //     //   });
                      //     // }
                      //   },
                      //   decoration: const InputDecoration(
                      //     hintText: "Reference",
                      //     hintStyle: TextStyle(
                      //       fontSize: 14,
                      //       fontFamily: "OpenSans",
                      //       fontWeight: FontWeight.w400,
                      //       //color: kColorBlack.withOpacity(.3)),
                      //       //border: InputBorder.none,
                      //     ),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 20,
                      // ),
                      // TextField(
                      //   controller: amtC,
                      //   //controller: emailC,
                      //   cursorColor: Colors.blue,
                      //   // style: kmediumTextBold(kColorBlack),
                      //   keyboardType: TextInputType.number,
                      //   onChanged: (text2) {
                      //     if (amtC.text.isNotEmpty || text2.isNotEmpty) {
                      //       setState(() {
                      //         buttonActive = true;
                      //       });
                      //     } else if (amtC.text.isEmpty || text2.isEmpty) {
                      //       setState(() {
                      //         buttonActive = false;
                      //       });
                      //     } else if (amtC.text.isNotEmpty ||
                      //         loginC.text.isEmpty) {
                      //       setState(() {
                      //         buttonActive = false;
                      //       });
                      //     } else {
                      //       setState(() {
                      //         buttonActive = false;
                      //       });
                      //     }
                      //     // if (text.contains("@")) {
                      //     //   if (text.split("@")[1].contains(".")){
                      //     //     setState(() {
                      //     //       emailIcon = "email_icon2";
                      //     //     });
                      //     //   }else{
                      //     //     setState(() {
                      //     //       emailIcon = "email_icon";
                      //     //     });
                      //     //   }
                      //     // }else{
                      //     //   setState(() {
                      //     //     emailIcon = "email_icon";
                      //     //   });
                      //     // }
                      //   },
                      //   decoration: const InputDecoration(
                      //     hintText: "Amount (₦)",
                      //     hintStyle: TextStyle(
                      //       fontSize: 14,
                      //       fontFamily: "OpenSans",
                      //       fontWeight: FontWeight.w400,
                      //       //color: kColorBlack.withOpacity(.3)),
                      //       //border: InputBorder.none,
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ]),
            ),
            // Container(
            //   padding: const EdgeInsets.symmetric(
            //     horizontal: 30,
            //   ),
            //   child: Column(
            //     children: <Widget>[
            //       Column(
            //         children: const [
            //           CircleAvatar(
            //             radius: 40,
            //             backgroundImage:
            //                 AssetImage("lib/images/saleoimage.jpeg"),
            //           ),
            //           SizedBox(
            //             height: 10,
            //           ),
            //           // Text("SELECT ACCOUNT FOR DEPOSIT",
            //           //   style: TextStyle(
            //           //     fontWeight: FontWeight.bold,
            //           //     color: kPrimaryColor,
            //           //     fontSize: 20,
            //           //   ),
            //           // ),
            //           SizedBox(
            //             height: 20,
            //           ),
            //           // Container(
            //           //   width: 260,
            //           //   decoration: BoxDecoration(
            //           //     color: Colors.black26,
            //           //     borderRadius: BorderRadius.circular(10),
            //           //   ),
            //           //   child: const TextField(
            //           //     decoration: InputDecoration(
            //           //       hintText: "      Enter Account Number/Name",
            //           //       hintStyle: TextStyle(
            //           //         color: Colors.white,
            //           //         letterSpacing: 1.0,
            //           //         fontSize: 13,
            //           //       ),
            //           //       border: InputBorder.none,
            //           //       // prefixIcon: Padding(
            //           //       //   padding: const EdgeInsets.all(0),
            //           //       //   child: Icon(
            //           //       //     Icons.email_sharp,
            //           //       //     size: 15,
            //           //       //     color: Colors.white,
            //           //       //   ),
            //           //       // ),
            //           //     ),
            //           //     textInputAction: TextInputAction.next,
            //           //     keyboardType: TextInputType.emailAddress,
            //           //   ),
            //           // ),
            //         ],
            //       ),
            //       // const SizedBox(
            //       //   height: 30,
            //       // ),
            //       // Container(
            //       //   height: 40,
            //       //   width: 180,
            //       //   decoration: BoxDecoration(
            //       //     borderRadius: BorderRadius.circular(30),
            //       //     // ignore: prefer_const_constructors
            //       //     gradient: LinearGradient(
            //       //       begin: Alignment.topLeft,
            //       //       end: Alignment.bottomRight,
            //       //       // 10% of the width, so there are ten blinds.
            //       //       // ignore: prefer_const_literals_to_create_immutables
            //       //       colors: <Color>[
            //       //         kPrimaryColor,
            //       //         kSecondaryColor,
            //       //       ], // red to yellow
            //       //       tileMode:
            //       //       TileMode.repeated, // repeats the gradient over the canvas
            //       //     ),
            //       //   ),
            //       //   child: InkWell(
            //       //     onTap: () {},
            //       //     child: Row(
            //       //       children: const <Widget>[
            //       //         SizedBox(
            //       //           width: 20,
            //       //         ),
            //       //         // Icon(
            //       //         //   Icons.atm_sharp,
            //       //         // ),
            //       //         SizedBox(
            //       //           width: 0,
            //       //         ),
            //       //         Center(
            //       //           child: Text(
            //       //             "              Enter",
            //       //             style: TextStyle(
            //       //               fontSize: 16,
            //       //               color: Colors.white,
            //       //             ),
            //       //           ),
            //       //         ),
            //       //       ],
            //       //     ),
            //       //   ),
            //       // ),
            //       const SizedBox(
            //         height: 0,
            //       ),
            //       const Text(
            //         "Customer Name : Oluwatobi Adeleke",
            //         style: TextStyle(
            //           fontSize: 15,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       const SizedBox(
            //         height: 30,
            //       ),

            //       SingleChildScrollView(
            //         scrollDirection: Axis.horizontal,
            //         child: Container(
            //           decoration: BoxDecoration(
            //             color: Colors.black26,
            //             borderRadius: BorderRadius.circular(30),
            //           ),
            //           height: 60,
            //           width: 330,
            //           child: Column(
            //             children: [
            //               Container(
            //                 width: 350,
            //                 height: 60,
            //                 child: Column(
            //                   children: [
            //                     const SizedBox(
            //                       height: 10,
            //                     ),
            //                     Row(children: [
            //                       const SizedBox(
            //                         width: 20,
            //                       ),
            //                       InkWell(
            //                         onTap: () {},
            //                         child: const CircleAvatar(
            //                           backgroundColor: Colors.white,
            //                           radius: 5,
            //                         ),
            //                       ),
            //                       const SizedBox(
            //                         width: 20,
            //                       ),
            //                       Column(
            //                         children: const [
            //                           Text(
            //                             "Customer Account 1 : 012345738",
            //                             style: TextStyle(
            //                               fontSize: 15,
            //                               fontWeight: FontWeight.bold,
            //                             ),
            //                           ),
            //                           Text(
            //                             "Account Balance : \$200",
            //                             style: TextStyle(
            //                               fontSize: 15,
            //                               fontWeight: FontWeight.bold,
            //                             ),
            //                           ),
            //                         ],
            //                       )
            //                     ]),
            //                   ],
            //                 ),
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(5),
            //                   color: Colors.grey,
            //                 ),
            //               ),
            //               // SizedBox(height: 10,),
            //               // Container(
            //               //   width: 330,
            //               //   height: 80,
            //               //   child: Column(
            //               //     children: [
            //               //       const SizedBox(height: 10,),
            //               //       Row(
            //               //           children : [
            //               //             const SizedBox( width: 20,),
            //               //             InkWell(
            //               //               onTap: (){},
            //               //               child: const CircleAvatar(
            //               //                 backgroundColor: Colors.white,
            //               //                 radius: 5,
            //               //               ),
            //               //             ),
            //               //             const SizedBox(width: 20,),
            //               //             Column(
            //               //               children: const [
            //               //
            //               //                 Text("Customer Account 2 : 012345738",
            //               //                   style: TextStyle(
            //               //                     fontSize: 15,
            //               //                     fontWeight: FontWeight.bold,
            //               //                   ),
            //               //                 ),
            //               //                 Text("Account Balance : \$600",
            //               //                   style: TextStyle(
            //               //                     fontSize: 15,
            //               //                     fontWeight: FontWeight.bold,
            //               //                   ),
            //               //                 ),
            //               //               ],
            //               //             )
            //               //
            //               //           ]
            //               //       ),
            //               //     ],
            //               //   ),
            //               //   color: Colors.grey,
            //               // ),
            //               //SizedBox(height: 10,),

            //               // Container(
            //               //   width: 330,
            //               //   height: 80,
            //               //   child: Column(
            //               //     children: [
            //               //       const SizedBox(height: 10,),
            //               //       Row(
            //               //           children : [
            //               //             const SizedBox( width: 20,),
            //               //             InkWell(
            //               //               onTap: (){},
            //               //               child: const CircleAvatar(
            //               //                 backgroundColor: Colors.white,
            //               //                 radius: 5,
            //               //               ),
            //               //             ),
            //               //             const SizedBox(width: 20,),
            //               //             Column(
            //               //               children: const [
            //               //
            //               //                 Text("Customer Account 3 : 012345738",
            //               //                   style: TextStyle(
            //               //                     fontSize: 15,
            //               //                     fontWeight: FontWeight.bold,
            //               //                   ),
            //               //                 ),
            //               //                 Text("Account Balance : \$100",
            //               //                   style: TextStyle(
            //               //                     fontSize: 15,
            //               //                     fontWeight: FontWeight.bold,
            //               //                   ),
            //               //                 ),
            //               //               ],
            //               //             )
            //               //
            //               //           ]
            //               //       ),
            //               //     ],
            //               //   ),
            //               //   color: Colors.grey,
            //               // ),
            //             ],
            //           ),
            //         ),
            //         // Container(
            //         //   height: 300,
            //         //   width: 485,
            //         //   child: Column(
            //         //     children: [
            //         //       Row(
            //         //         children: [
            //         //           Column(
            //         //             children: [
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("Select",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.purple,
            //         //
            //         //               ),
            //         //               const SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children:  [
            //         //                     const SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: InkWell(
            //         //                         onTap: (){},
            //         //                         child: const CircleAvatar(
            //         //                           backgroundColor: Colors.white,
            //         //                           radius: 5,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //
            //         //               color: Colors.grey,
            //         //               ),
            //         //               SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children:  [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: InkWell(
            //         //                         onTap: (){},
            //         //                         child: const CircleAvatar(
            //         //                           backgroundColor: Colors.white,
            //         //                           radius: 5,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.white12,
            //         //
            //         //               ),
            //         //               const SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children:  [
            //         //                     const SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: InkWell(
            //         //                         onTap: (){},
            //         //                         child: const CircleAvatar(
            //         //                           backgroundColor: Colors.white,
            //         //                           radius: 5,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.grey,
            //         //
            //         //               ),
            //         //             ],
            //         //           ),
            //         //           const SizedBox(width: 1,),
            //         //           Column(
            //         //             children: [
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("S/N",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.purple,
            //         //
            //         //               ),
            //         //               SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("1",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.grey,
            //         //
            //         //               ),
            //         //               const SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("2",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.white10,
            //         //
            //         //               ),
            //         //               SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("3",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.grey,
            //         //
            //         //               ),
            //         //             ],
            //         //           ),
            //         //           SizedBox(width: 1,),
            //         //           Column(
            //         //             children: [
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("First Name",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.purple,
            //         //
            //         //               ),
            //         //               SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("Efe",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.grey,
            //         //
            //         //               ),
            //         //               const SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("Seyi",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.white10,
            //         //
            //         //               ),
            //         //               SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("Wale",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.grey,
            //         //
            //         //               ),
            //         //             ],
            //         //           ),
            //         //           SizedBox(width: 1,),
            //         //           Column(
            //         //             children: [
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("Surname",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.purple,
            //         //
            //         //               ),
            //         //               SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("Olawale",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.grey,
            //         //
            //         //               ),
            //         //               SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("Ade",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.white10,
            //         //
            //         //               ),
            //         //               SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("Taiwo",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.grey,
            //         //
            //         //               ),
            //         //             ],
            //         //           ),
            //         //           SizedBox(width: 1,),
            //         //           Column(
            //         //             children: [
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("Other Name",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.purple,
            //         //
            //         //               ),
            //         //               SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("Jide",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.grey,
            //         //
            //         //               ),
            //         //               SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("Joy",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.white10,
            //         //
            //         //               ),
            //         //               const SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("Alli",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.grey,
            //         //
            //         //               ),
            //         //             ],
            //         //           ),
            //         //           const SizedBox(width: 1,),
            //         //           Column(
            //         //             children: [
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("Acct No",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.purple,
            //         //
            //         //               ),
            //         //               SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("0129239387",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.grey,
            //         //
            //         //               ),
            //         //               const SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("2293933345",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.white10,
            //         //
            //         //               ),
            //         //               SizedBox(height: 1,),
            //         //               Container(
            //         //                 child: Column(
            //         //                   children: const [
            //         //                     SizedBox(height: 10,),
            //         //                     Center(
            //         //                       child: Text("1234567890",
            //         //                         style: TextStyle(
            //         //                           color: Colors.white,
            //         //                         ),
            //         //                       ),
            //         //                     ),
            //         //                   ],
            //         //                 ),
            //         //                 height: 30,
            //         //                 width: 80,
            //         //                 color: Colors.grey,
            //         //
            //         //               ),
            //         //             ],
            //         //           ),
            //         //
            //         //
            //         //
            //         //
            //         //         ],
            //         //       ),
            //         //     ],
            //         //   ),
            //         //   color: Colors.black26,
            //         // ),
            //       ),
            //       //       Container(
            //       //         decoration: BoxDecoration(
            //       //           color: Colors.grey.withOpacity(0.5),
            //       //           borderRadius: BorderRadius.circular(5),
            //       //         ),
            //       //         child: const TextField(
            //       //           decoration: InputDecoration(
            //       //             hintText: "Password",
            //       //             hintStyle: TextStyle(
            //       //               color: Colors.white,
            //       //               letterSpacing: 1.0,
            //       //               fontSize: 13,
            //       //             ),
            //       //             prefixIcon: Padding(
            //       //               padding: EdgeInsets.all(0),
            //       //               child: Icon(
            //       //                 Icons.lock,
            //       //                 size: 15,
            //       //                 color: Colors.white,
            //       //               ),
            //       //             ),
            //       //             border: InputBorder.none,
            //       //           ),
            //       //           textInputAction: TextInputAction.done,
            //       //           keyboardType: TextInputType.number,
            //       //           obscureText: true,
            //       //         ),
            //       //       ),
            //       //     ],
            //       //   ),
            //       // ),
            //       const SizedBox(
            //         height: 20,
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: const [
            //           Text(
            //             "Enter Amount:",
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(
            //         height: 10,
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           const SizedBox(
            //             width: 10,
            //           ),
            //           Container(
            //             width: 320,
            //             decoration: BoxDecoration(
            //               color: Colors.black26,
            //               borderRadius: BorderRadius.circular(5),
            //             ),
            //             child: const TextField(
            //               decoration: InputDecoration(
            //                 hintText: "",
            //                 hintStyle: TextStyle(
            //                   color: Colors.white,
            //                   letterSpacing: 1.0,
            //                   fontSize: 13,
            //                 ),
            //                 border: InputBorder.none,
            //                 // prefixIcon: Padding(
            //                 //   padding: const EdgeInsets.all(0),
            //                 //   child: Icon(
            //                 //     Icons.email_sharp,
            //                 //     size: 15,
            //                 //     color: Colors.white,
            //                 //   ),
            //                 // ),
            //               ),
            //               textInputAction: TextInputAction.next,
            //               keyboardType: TextInputType.emailAddress,
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(
            //         height: 10,
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: const [
            //           Text(
            //             "Amount in words:",
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //       SizedBox(
            //         height: 10,
            //       ),

            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           const SizedBox(
            //             width: 10,
            //           ),
            //           Container(
            //             width: 320,
            //             decoration: BoxDecoration(
            //               color: Colors.black26,
            //               borderRadius: BorderRadius.circular(5),
            //             ),
            //             child: const TextField(
            //               decoration: InputDecoration(
            //                 hintText: "",
            //                 hintStyle: TextStyle(
            //                   color: Colors.white,
            //                   letterSpacing: 1.0,
            //                   fontSize: 13,
            //                 ),
            //                 border: InputBorder.none,
            //                 // prefixIcon: Padding(
            //                 //   padding: const EdgeInsets.all(0),
            //                 //   child: Icon(
            //                 //     Icons.email_sharp,
            //                 //     size: 15,
            //                 //     color: Colors.white,
            //                 //   ),
            //                 // ),
            //               ),
            //               textInputAction: TextInputAction.next,
            //               keyboardType: TextInputType.emailAddress,
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(
            //         height: 10,
            //       ),
            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: const [
            //           Text(
            //             "Enter Narration:",
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(
            //         height: 10,
            //       ),

            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.start,
            //         children: [
            //           const SizedBox(
            //             width: 10,
            //           ),
            //           Container(
            //             width: 320,
            //             decoration: BoxDecoration(
            //               color: Colors.black26,
            //               borderRadius: BorderRadius.circular(5),
            //             ),
            //             child: const TextField(
            //               decoration: InputDecoration(
            //                 hintText: "",
            //                 hintStyle: TextStyle(
            //                   color: Colors.white,
            //                   letterSpacing: 1.0,
            //                   fontSize: 13,
            //                 ),
            //                 border: InputBorder.none,
            //                 // prefixIcon: Padding(
            //                 //   padding: const EdgeInsets.all(0),
            //                 //   child: Icon(
            //                 //     Icons.email_sharp,
            //                 //     size: 15,
            //                 //     color: Colors.white,
            //                 //   ),
            //                 // ),
            //               ),
            //               textInputAction: TextInputAction.next,
            //               keyboardType: TextInputType.emailAddress,
            //             ),
            //           ),
            //         ],
            //       ),
            //       const SizedBox(
            //         height: 20,
            //       ),

            //       Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Container(
            //             height: 40,
            //             width: 150,
            //             decoration: BoxDecoration(
            //               borderRadius: BorderRadius.circular(25),
            //               // ignore: prefer_const_constructors
            //               gradient: LinearGradient(
            //                 begin: Alignment.topLeft,
            //                 end: Alignment.bottomRight,
            //                 // 10% of the width, so there are ten blinds.
            //                 // ignore: prefer_const_literals_to_create_immutables
            //                 colors: <Color>[
            //                   kPrimaryColor,
            //                   kSecondaryColor,
            //                 ], // red to yellow
            //                 tileMode: TileMode
            //                     .repeated, // repeats the gradient over the canvas
            //               ),
            //             ),
            //             child: InkWell(
            //               onTap: () {
            //                 Navigator.push(
            //                     context,
            //                     MaterialPageRoute(
            //                         builder: (context) =>
            //                             const DepositConfirmation()));
            //               },
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.center,
            //                 crossAxisAlignment: CrossAxisAlignment.center,
            //                 children: const <Widget>[
            //                   // SizedBox(
            //                   //   width: 20,
            //                   // ),
            //                   // Icon(
            //                   //   Icons.atm_sharp,
            //                   // ),
            //                   // SizedBox(
            //                   //   width: 25,
            //                   // ),
            //                   Center(
            //                     child: Text(
            //                       "Make Deposit",
            //                       style: TextStyle(
            //                         fontSize: 16,
            //                         color: Colors.white,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           ),
            //           const SizedBox(
            //             width: 30,
            //           ),
            //           // SizedBox(height: 20,),

            //           // Container(
            //           //   height: 40,
            //           //   width: 150,
            //           //   decoration: BoxDecoration(
            //           //     borderRadius: BorderRadius.circular(25),
            //           //     // ignore: prefer_const_constructors
            //           //     gradient: LinearGradient(
            //           //       begin: Alignment.topLeft,
            //           //       end: Alignment.bottomRight,
            //           //       // 10% of the width, so there are ten blinds.
            //           //       // ignore: prefer_const_literals_to_create_immutables
            //           //       colors: <Color>[
            //           //         kPrimaryColor,
            //           //         kSecondaryColor,
            //           //       ], // red to yellow
            //           //       tileMode:
            //           //       TileMode.repeated, // repeats the gradient over the canvas
            //           //     ),
            //           //   ),
            //           //   child: InkWell(
            //           //     onTap: () {},
            //           //     child: Row(
            //           //       children: const <Widget>[
            //           //         // SizedBox(
            //           //         //   width: 20,
            //           //         // ),
            //           //         // Icon(
            //           //         //   Icons.atm_sharp,
            //           //         // ),
            //           //         SizedBox(
            //           //           width: 25,
            //           //         ),
            //           //         Center(
            //           //           child: Text(
            //           //             "View Balance",
            //           //             style: TextStyle(
            //           //               fontSize: 16,
            //           //               color: Colors.white,
            //           //             ),
            //           //           ),
            //           //         ),
            //           //       ],
            //           //     ),
            //           //   ),
            //           // ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 150,
            ),
            Container(
              height: 50,
              width: 370,
              decoration: buttonActive
                  ? BoxDecoration(
                      // ignore: prefer_const_constructors

                      gradient: const LinearGradient(
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
                onTap: buttonActive
                    ? () {
                        //succesfulSignUp();
                      }
                    : null,
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
            const SizedBox(
              height: 50,
            ),
            FutureBuilder(
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
                              builder: (context) =>
                                  Home(int.parse(_loginuser.toString()))));
                    },
                    child: const Center(
                      child: Text(
                        "BACK",
                        style: TextStyle(
                            color: Colors.black45,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.0,
                            fontSize: 12,
                            fontFamily: "OpenSans"),
                      ),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
