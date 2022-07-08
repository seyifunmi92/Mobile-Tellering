import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teller/welcome.dart';
import 'package:teller/welcome.dart';
import 'package:teller/services.dart';
import 'package:teller/constants.dart';
import 'package:teller/textstyle.dart';
import 'package:teller/login.dart';
import 'package:teller/Home.dart';
import 'package:teller/depositConfirmation.dart';


class CashDeposit extends StatefulWidget {
  const CashDeposit({Key? key}) : super(key: key);

  @override
  _CashDepositState createState() => _CashDepositState();
}

class _CashDepositState extends State<CashDeposit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Cash Deposit"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            // Center(
            //   child:
            // ),
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 30,
              ),
              child: Column(
                children: <Widget>[
                  Column(
                    children: const [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage("lib/images/saleoimage.jpeg"),
                      ),
                      SizedBox(height: 10,),
                      // Text("SELECT ACCOUNT FOR DEPOSIT",
                      //   style: TextStyle(
                      //     fontWeight: FontWeight.bold,
                      //     color: kPrimaryColor,
                      //     fontSize: 20,
                      //   ),
                      // ),
                      SizedBox(height: 20,),
                      // Container(
                      //   width: 260,
                      //   decoration: BoxDecoration(
                      //     color: Colors.black26,
                      //     borderRadius: BorderRadius.circular(10),
                      //   ),
                      //   child: const TextField(
                      //     decoration: InputDecoration(
                      //       hintText: "      Enter Account Number/Name",
                      //       hintStyle: TextStyle(
                      //         color: Colors.white,
                      //         letterSpacing: 1.0,
                      //         fontSize: 13,
                      //       ),
                      //       border: InputBorder.none,
                      //       // prefixIcon: Padding(
                      //       //   padding: const EdgeInsets.all(0),
                      //       //   child: Icon(
                      //       //     Icons.email_sharp,
                      //       //     size: 15,
                      //       //     color: Colors.white,
                      //       //   ),
                      //       // ),
                      //     ),
                      //     textInputAction: TextInputAction.next,
                      //     keyboardType: TextInputType.emailAddress,
                      //   ),
                      // ),
                    ],
                  ),
                  // const SizedBox(
                  //   height: 30,
                  // ),
                  // Container(
                  //   height: 40,
                  //   width: 180,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.circular(30),
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
                  //       children: const <Widget>[
                  //         SizedBox(
                  //           width: 20,
                  //         ),
                  //         // Icon(
                  //         //   Icons.atm_sharp,
                  //         // ),
                  //         SizedBox(
                  //           width: 0,
                  //         ),
                  //         Center(
                  //           child: Text(
                  //             "              Enter",
                  //             style: TextStyle(
                  //               fontSize: 16,
                  //               color: Colors.white,
                  //             ),
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(height: 0,),
                  const Text("Customer Name : Oluwatobi Adeleke",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30,),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: 60,
                      width: 330,
                      child: Column(
                        children: [
                          Container(
                            width: 350,
                            height: 60,
                            child: Column(
                              children: [
                                const SizedBox(height: 10,),
                                Row(
                                    children : [
                                      const SizedBox( width: 20,),
                                      InkWell(
                                        onTap: (){},
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 5,
                                        ),
                                      ),
                                      const SizedBox(width: 20,),
                                      Column(
                                        children: const [

                                          Text("Customer Account 1 : 012345738",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text("Account Balance : \$200",
                                            style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )

                                    ]
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey,
                            ),
                          ),
                          // SizedBox(height: 10,),
                          // Container(
                          //   width: 330,
                          //   height: 80,
                          //   child: Column(
                          //     children: [
                          //       const SizedBox(height: 10,),
                          //       Row(
                          //           children : [
                          //             const SizedBox( width: 20,),
                          //             InkWell(
                          //               onTap: (){},
                          //               child: const CircleAvatar(
                          //                 backgroundColor: Colors.white,
                          //                 radius: 5,
                          //               ),
                          //             ),
                          //             const SizedBox(width: 20,),
                          //             Column(
                          //               children: const [
                          //
                          //                 Text("Customer Account 2 : 012345738",
                          //                   style: TextStyle(
                          //                     fontSize: 15,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //                 Text("Account Balance : \$600",
                          //                   style: TextStyle(
                          //                     fontSize: 15,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //               ],
                          //             )
                          //
                          //           ]
                          //       ),
                          //     ],
                          //   ),
                          //   color: Colors.grey,
                          // ),
                          //SizedBox(height: 10,),

                          // Container(
                          //   width: 330,
                          //   height: 80,
                          //   child: Column(
                          //     children: [
                          //       const SizedBox(height: 10,),
                          //       Row(
                          //           children : [
                          //             const SizedBox( width: 20,),
                          //             InkWell(
                          //               onTap: (){},
                          //               child: const CircleAvatar(
                          //                 backgroundColor: Colors.white,
                          //                 radius: 5,
                          //               ),
                          //             ),
                          //             const SizedBox(width: 20,),
                          //             Column(
                          //               children: const [
                          //
                          //                 Text("Customer Account 3 : 012345738",
                          //                   style: TextStyle(
                          //                     fontSize: 15,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //                 Text("Account Balance : \$100",
                          //                   style: TextStyle(
                          //                     fontSize: 15,
                          //                     fontWeight: FontWeight.bold,
                          //                   ),
                          //                 ),
                          //               ],
                          //             )
                          //
                          //           ]
                          //       ),
                          //     ],
                          //   ),
                          //   color: Colors.grey,
                          // ),
                        ],
                      ),
                    ),
                    // Container(
                    //   height: 300,
                    //   width: 485,
                    //   child: Column(
                    //     children: [
                    //       Row(
                    //         children: [
                    //           Column(
                    //             children: [
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("Select",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.purple,
                    //
                    //               ),
                    //               const SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children:  [
                    //                     const SizedBox(height: 10,),
                    //                     Center(
                    //                       child: InkWell(
                    //                         onTap: (){},
                    //                         child: const CircleAvatar(
                    //                           backgroundColor: Colors.white,
                    //                           radius: 5,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //
                    //               color: Colors.grey,
                    //               ),
                    //               SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children:  [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: InkWell(
                    //                         onTap: (){},
                    //                         child: const CircleAvatar(
                    //                           backgroundColor: Colors.white,
                    //                           radius: 5,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.white12,
                    //
                    //               ),
                    //               const SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children:  [
                    //                     const SizedBox(height: 10,),
                    //                     Center(
                    //                       child: InkWell(
                    //                         onTap: (){},
                    //                         child: const CircleAvatar(
                    //                           backgroundColor: Colors.white,
                    //                           radius: 5,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.grey,
                    //
                    //               ),
                    //             ],
                    //           ),
                    //           const SizedBox(width: 1,),
                    //           Column(
                    //             children: [
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("S/N",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.purple,
                    //
                    //               ),
                    //               SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("1",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.grey,
                    //
                    //               ),
                    //               const SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("2",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.white10,
                    //
                    //               ),
                    //               SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("3",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.grey,
                    //
                    //               ),
                    //             ],
                    //           ),
                    //           SizedBox(width: 1,),
                    //           Column(
                    //             children: [
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("First Name",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.purple,
                    //
                    //               ),
                    //               SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("Efe",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.grey,
                    //
                    //               ),
                    //               const SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("Seyi",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.white10,
                    //
                    //               ),
                    //               SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("Wale",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.grey,
                    //
                    //               ),
                    //             ],
                    //           ),
                    //           SizedBox(width: 1,),
                    //           Column(
                    //             children: [
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("Surname",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.purple,
                    //
                    //               ),
                    //               SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("Olawale",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.grey,
                    //
                    //               ),
                    //               SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("Ade",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.white10,
                    //
                    //               ),
                    //               SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("Taiwo",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.grey,
                    //
                    //               ),
                    //             ],
                    //           ),
                    //           SizedBox(width: 1,),
                    //           Column(
                    //             children: [
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("Other Name",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.purple,
                    //
                    //               ),
                    //               SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("Jide",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.grey,
                    //
                    //               ),
                    //               SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("Joy",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.white10,
                    //
                    //               ),
                    //               const SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("Alli",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.grey,
                    //
                    //               ),
                    //             ],
                    //           ),
                    //           const SizedBox(width: 1,),
                    //           Column(
                    //             children: [
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("Acct No",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.purple,
                    //
                    //               ),
                    //               SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("0129239387",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.grey,
                    //
                    //               ),
                    //               const SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("2293933345",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.white10,
                    //
                    //               ),
                    //               SizedBox(height: 1,),
                    //               Container(
                    //                 child: Column(
                    //                   children: const [
                    //                     SizedBox(height: 10,),
                    //                     Center(
                    //                       child: Text("1234567890",
                    //                         style: TextStyle(
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //                 height: 30,
                    //                 width: 80,
                    //                 color: Colors.grey,
                    //
                    //               ),
                    //             ],
                    //           ),
                    //
                    //
                    //
                    //
                    //         ],
                    //       ),
                    //     ],
                    //   ),
                    //   color: Colors.black26,
                    // ),

                  ),
                  //       Container(
                  //         decoration: BoxDecoration(
                  //           color: Colors.grey.withOpacity(0.5),
                  //           borderRadius: BorderRadius.circular(5),
                  //         ),
                  //         child: const TextField(
                  //           decoration: InputDecoration(
                  //             hintText: "Password",
                  //             hintStyle: TextStyle(
                  //               color: Colors.white,
                  //               letterSpacing: 1.0,
                  //               fontSize: 13,
                  //             ),
                  //             prefixIcon: Padding(
                  //               padding: EdgeInsets.all(0),
                  //               child: Icon(
                  //                 Icons.lock,
                  //                 size: 15,
                  //                 color: Colors.white,
                  //               ),
                  //             ),
                  //             border: InputBorder.none,
                  //           ),
                  //           textInputAction: TextInputAction.done,
                  //           keyboardType: TextInputType.number,
                  //           obscureText: true,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  const SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                       Text("Enter Amount:",
                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                       ),
                       ),
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                      const SizedBox(width: 10,),
                      Container(
                        width: 320,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.0,
                              fontSize: 13,
                            ),
                            border: InputBorder.none,
                            // prefixIcon: Padding(
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
                    ],
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                       Text("Amount in words:",

                       style: TextStyle(
                         fontWeight: FontWeight.bold,
                       ),),
                    ],
                  ),
                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                      const SizedBox(width: 10,),


                      Container(
                        width: 320,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.0,
                              fontSize: 13,
                            ),
                            border: InputBorder.none,
                            // prefixIcon: Padding(
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
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: const [
                      Text("Enter Narration:",

                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),),
                    ],
                  ),
                  SizedBox(height: 10,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children:  [
                      const SizedBox(width: 10,),


                      Container(
                        width: 320,
                        decoration: BoxDecoration(
                          color: Colors.black26,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            hintText: "",
                            hintStyle: TextStyle(
                              color: Colors.white,
                              letterSpacing: 1.0,
                              fontSize: 13,
                            ),
                            border: InputBorder.none,
                            // prefixIcon: Padding(
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
                    ],
                  ),
                  const SizedBox(height: 20,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Container(
                        height: 40,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DepositConfirmation()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: const <Widget>[
                              // SizedBox(
                              //   width: 20,
                              // ),
                              // Icon(
                              //   Icons.atm_sharp,
                              // ),
                              // SizedBox(
                              //   width: 25,
                              // ),
                              Center(
                                child: Text(
                                  "Make Deposit",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 30,),
                      // SizedBox(height: 20,),

                      // Container(
                      //   height: 40,
                      //   width: 150,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(25),
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
                      //       children: const <Widget>[
                      //         // SizedBox(
                      //         //   width: 20,
                      //         // ),
                      //         // Icon(
                      //         //   Icons.atm_sharp,
                      //         // ),
                      //         SizedBox(
                      //           width: 25,
                      //         ),
                      //         Center(
                      //           child: Text(
                      //             "View Balance",
                      //             style: TextStyle(
                      //               fontSize: 16,
                      //               color: Colors.white,
                      //             ),
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 70,),
            Container(
              height: 40,
              width: 350,
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
                  // Navigator.push(context, MaterialPageRoute(builder:(context)  => Home()));

                },
                child: Row(
                  children: const <Widget>[
                    SizedBox(width: 120,),

                    // Icon(
                    //   Icons.atm_sharp,
                    // ),
                    // SizedBox(
                    //   width: 0,
                    // ),
                    Center(
                      child: Text(
                        "Back To Menu",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
