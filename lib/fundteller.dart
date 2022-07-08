import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:teller/cashDepostit.dart';
import 'package:teller/checkmessage.dart';
import 'package:teller/succes.dart';
import 'package:teller/teller.dart';
import 'package:teller/tellerlist.dart';
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
//import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:teller/BluePrint.dart';
import 'models.dart';

class FundTeller extends StatefulWidget {
  int ID;
  String requestID;
  FundTeller(this.ID, this.requestID);
  @override
  _FundTellerState createState() => _FundTellerState();
}

class _FundTellerState extends State<FundTeller> {
  bool createNull = false;
  bool showData = false;
  List<ScanResult>? scanResult;
  RequestDetail? _request;
  FlutterBlue flutterBlue = FlutterBlue.instance;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool buttonActive = false;
  TextEditingController loginC = TextEditingController();
  TextEditingController fundingC = TextEditingController();
  bool networkError = false;

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

  late Future tellerDetails;
  void setFuture() {
    tellerDetails = getRequestDetail();
  }

  @override
  void initState() {
    setFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;

    return Container(
      child: Scaffold(
        body: showData
            ? Column(
                children: [
                  Container(
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
                            ? Row(
                                children: [
                                  const SizedBox(
                                    width: 300,
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        // 10% of the width, so there are ten blinds.
                                        // ignore: prefer_const_literals_to_create_immutables
                                        colors: <Color>[
                                          Colors.grey.withOpacity(0.5),
                                          const Color(0xff30b8b1),
                                        ], // red to yellow
                                        tileMode: TileMode
                                            .repeated, // repeats the gradient over the canvas
                                      ),
                                      borderRadius: BorderRadius.circular(15),
                                      //color: Color(0xff2c9c96).withOpacity(1.0),
                                    ),
                                    height: 33,
                                    width: 120,
                                    child: Center(
                                        child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const CashDeposit()));
                                      },
                                      child: const Text(
                                        "Make Deposit",
                                        style: TextStyle(
                                            color: Colors.white,
                                            //fontWeight: FontWeight.bold,
                                            fontFamily: "OpenSans"),
                                      ),
                                    )),
                                  ),
                                ],
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
                          "Teller Request Details",
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
                                "₦${_request!.requestedamount.toString()}0",
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
                        Text(
                          "Funding Request Id : ${_request!.id.toString()}",
                          style: const TextStyle(
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
                              _request!.loginUserId.toString(),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontFamily: "OpenSans",
                                letterSpacing: 0,
                                //fontWeight: FontWeight.bold,
                              ),
                            )
                          : const CircularProgressIndicator()
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
                        "Amount",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontFamily: "OpenSans",
                          letterSpacing: 0,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 200,
                      ),
                      showData
                          ? Text(
                              "₦${_request!.requestedamount.toString()}0",
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontFamily: "OpenSans",
                                letterSpacing: 0,
                                //fontWeight: FontWeight.bold,
                              ),
                            )
                          : const CircularProgressIndicator()
                    ],
                  ),
                  const Divider(
                    height: 60,
                    color: Colors.grey,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 20,
                        ),
                        const Text(
                          "Date",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 20,
                            fontFamily: "OpenSans",
                            letterSpacing: 0,
                            //fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          width: 210,
                        ),
                        showData
                            ? Text(
                                _request!.createdate.toString(),
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontFamily: "OpenSans",
                                  letterSpacing: 0,
                                  //fontWeight: FontWeight.bold,
                                ),
                              )
                            : const CircularProgressIndicator()
                      ],
                    ),
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
                        "Created By",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontFamily: "OpenSans",
                          letterSpacing: 0,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 183,
                      ),
                      createNull
                          ? const Text(
                              "Loading..",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontFamily: "OpenSans",
                                letterSpacing: 0,
                                //fontWeight: FontWeight.bold,
                              ),
                            )
                          : Text(
                              _request!.createdBy.toString(),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontFamily: "OpenSans",
                                letterSpacing: 0,
                                //fontWeight: FontWeight.bold,
                              ),
                            )

                      // showData
                      //     ? if(_request!.createdBy.toString().contains("null")){
                      //     return ext("Customer Details Loading");
                      //     }
                      //     else {}

                      // "₦${_request!.requestedamount.toString()}",
                      // style: const TextStyle(
                      //   color: Colors.black54,
                      //   fontSize: 20,
                      //   fontFamily: "OpenSans",
                      //   letterSpacing: 0,
                      //   //fontWeight: FontWeight.bold,
                      // ),

                      //: const CircularProgressIndicator()
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
                        "Status",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontFamily: "OpenSans",
                          letterSpacing: 0,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 230,
                      ),
                      showData
                          ? Text(
                              _request!.status.toString(),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontFamily: "OpenSans",
                                letterSpacing: 0,
                                //fontWeight: FontWeight.bold,
                              ),
                            )
                          : const CircularProgressIndicator()
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
                        "Approved",
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 20,
                          fontFamily: "OpenSans",
                          letterSpacing: 0,
                          //fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        width: 210,
                      ),
                      showData
                          ? Text(
                              _request!.approved.toString(),
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 20,
                                fontFamily: "OpenSans",
                                letterSpacing: 0,
                                //fontWeight: FontWeight.bold,
                              ),
                            )
                          : const CircularProgressIndicator()
                    ],
                  ),
                  const Divider(
                    height: 60,
                    color: Colors.grey,
                  ),
                ],
              )
            : Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: _height * .5,
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

        //appBar: AppBar(
        //title: ...myResult.map((e) => bodyCustom())),
        //),
        //backgroundColor: Colors.green,
        // body: FutureBuilder(
        //     future: tellerDetails,
        //     builder: (context, snapshot) {
        //       print("Hello Seyi, ${snapshot.data}");
        //       if (snapshot.connectionState == ConnectionState.waiting) {
        //         return Column(
        //           children: const [
        //             CircularProgressIndicator(),
        //             SizedBox(
        //               height: 20,
        //             ),
        //             Text("Please Wait"),
        //           ],
        //         );
        //       } else if (snapshot.hasError) {
        //         return Center(child: Text(snapshot.error.toString()));
        //       } else if (snapshot.hasData) {
        //         var mydata = snapshot.data;
        //         print("Segun -$mydata");
        //         print(mydata.runtimeType);
        //         return Column(
        //           children: [
        //             Container(
        //               decoration: BoxDecoration(
        //                 // ignore: prefer_const_constructors
        //                 gradient: LinearGradient(
        //                   begin: Alignment.topLeft,
        //                   end: Alignment.bottomRight,
        //                   // 10% of the width, so there are ten blinds.
        //                   // ignore: prefer_const_literals_to_create_immutables
        //                   colors: <Color>[
        //                     kPrimaryColor,
        //                     kSecondaryColor,
        //                   ], // red to yellow
        //                   tileMode: TileMode
        //                       .repeated, // repeats the gradient over the canvas
        //                 ),
        //                 borderRadius: BorderRadius.circular(0),
        //               ),
        //               width: _width,
        //               height: _height * 0.3,
        //               //color: Colors.amber,
        //               // child: bodyCustom(RequestDetail(
        //               //     loginUserId: 313161,
        //               //     id: "368df6e3-25de-4187-aab9-08da6360176b")),
        //               //child: Text(),
        //               //child: Text(),
        //             ),
        //           ],
        //         );
        //       } else {
        //         return Text("This is the ${snapshot.error}");
        //       }
        //     }
        // child: Column(
        //   children: [
        //     Container(
        //       decoration: BoxDecoration(
        //         // ignore: prefer_const_constructors
        //         gradient: LinearGradient(
        //           begin: Alignment.topLeft,
        //           end: Alignment.bottomRight,
        //           // 10% of the width, so there are ten blinds.
        //           // ignore: prefer_const_literals_to_create_immutables
        //           colors: <Color>[
        //             kPrimaryColor,
        //             kSecondaryColor,
        //           ], // red to yellow
        //           tileMode:
        //               TileMode.repeated, // repeats the gradient over the canvas
        //         ),
        //         borderRadius: BorderRadius.circular(0),
        //       ),

        //       width: _width,
        //       height: _height * 0.3,
        //       //color: Colors.amber,
        //       // child: bodyCustom(RequestDetail(
        //       //     loginUserId: 313161,
        //       //     id: "368df6e3-25de-4187-aab9-08da6360176b")),
        //     ),
        //   ],
        // ),
        //),
        // body: Column(
        //   children: [
        //     const SizedBox(
        //       height: 35,
        //     ),
        //     const Text(
        //       "Please enter the following",
        //       style: TextStyle(
        //           fontSize: 15,
        //           fontFamily: "OpenSans",
        //           fontWeight: FontWeight.w500,
        //           color: Colors.black),
        //       textAlign: TextAlign.start,
        //     ),
        //     const SizedBox(
        //       height: 40,
        //     ),
        //     Container(
        //       padding: const EdgeInsets.all(10),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(10),
        //         color: Colors.white,
        //       ),
        //       child: Row(children: [
        //         //SvgPicture.asset("assets/svg/${emailIcon}.svg"),
        //         const SizedBox(
        //           width: 5,
        //         ),
        //         Expanded(
        //           flex: 1,
        //           child: Column(
        //             children: [
        //               TextField(
        //                 controller: loginC,
        //                 //controller: emailC,
        //                 cursorColor: Colors.blue,
        //                 // style: kmediumTextBold(kColorBlack),
        //                 keyboardType: TextInputType.emailAddress,
        //                 onChanged: (text1) {
        //                   if (text1.isNotEmpty) {
        //                     setState(() {
        //                       buttonActive = true;
        //                     });
        //                   } else {
        //                     setState(() {
        //                       buttonActive = false;
        //                     });
        //                   }
        //                   // if (text.contains("@")) {
        //                   //   if (text.split("@")[1].contains(".")){
        //                   //     setState(() {
        //                   //       emailIcon = "email_icon2";
        //                   //     });
        //                   //   }else{
        //                   //     setState(() {
        //                   //       emailIcon = "email_icon";
        //                   //     });
        //                   //   }
        //                   // }else{
        //                   //   setState(() {
        //                   //     emailIcon = "email_icon";
        //                   //   });
        //                   // }
        //                 },
        //                 decoration: const InputDecoration(
        //                   hintText: "Login User Id",
        //                   hintStyle: TextStyle(
        //                     fontFamily: "OpenSans",

        //                     fontSize: 12,
        //                     //fontFamily: "Poppins",
        //                     fontWeight: FontWeight.w400,
        //                     //color: kColorBlack.withOpacity(.3)),
        //                     //border: InputBorder.none,
        //                   ),
        //                 ),
        //               ),
        //               const SizedBox(
        //                 height: 20,
        //               ),
        //               TextField(
        //                 controller: fundingC,
        //                 //controller: emailC,
        //                 cursorColor: Colors.blue,
        //                 // style: kmediumTextBold(kColorBlack),
        //                 keyboardType: TextInputType.number,
        //                 onChanged: (text2) {
        //                   if (loginC.text.isNotEmpty || text2.isNotEmpty) {
        //                     setState(() {
        //                       buttonActive = true;
        //                     });
        //                   } else if (loginC.text.isEmpty || text2.isEmpty) {
        //                     setState(() {
        //                       buttonActive = false;
        //                     });
        //                   } else if (loginC.text.isNotEmpty ||
        //                       fundingC.text.isEmpty) {
        //                     setState(() {
        //                       buttonActive = false;
        //                     });
        //                   } else {
        //                     setState(() {
        //                       buttonActive = false;
        //                     });
        //                   }
        //                   // if (text.contains("@")) {
        //                   //   if (text.split("@")[1].contains(".")){
        //                   //     setState(() {
        //                   //       emailIcon = "email_icon2";
        //                   //     });
        //                   //   }else{
        //                   //     setState(() {
        //                   //       emailIcon = "email_icon";
        //                   //     });
        //                   //   }
        //                   // }else{
        //                   //   setState(() {
        //                   //     emailIcon = "email_icon";
        //                   //   });
        //                   // }
        //                 },
        //                 decoration: const InputDecoration(
        //                   hintText: "Funding request id",
        //                   hintStyle: TextStyle(
        //                     fontSize: 12,
        //                     fontFamily: "OpenSans",
        //                     fontWeight: FontWeight.w400,
        //                     //color: kColorBlack.withOpacity(.3)),
        //                     //border: InputBorder.none,
        //                   ),
        //                 ),
        //               ),
        //             ],
        //           ),
        //         ),
        //       ]),
        //     ),
        //     const SizedBox(
        //       height: 50,
        //     ),
        //     Container(
        //       height: 40,
        //       width: 350,
        //       decoration: buttonActive
        //           ? BoxDecoration(
        //               // ignore: prefer_const_constructors

        //               gradient: const LinearGradient(
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
        //               borderRadius: BorderRadius.circular(5),
        //             )
        //           : BoxDecoration(
        //               // ignore: prefer_const_constructors
        //               color: Colors.grey,
        //               borderRadius: BorderRadius.circular(5),
        //             ),
        //       child: InkWell(
        //         onTap: buttonActive
        //             ? () {
        //                 if (loginC.text.isNotEmpty && fundingC.text.isNotEmpty) {
        //                   mywalletFund();
        //                   loginC.clear();
        //                   fundingC.clear();
        //                   Future.delayed(const Duration(seconds: 5));
        //                   //succesfulSignUp();
        //                 }
        //               }
        //             : null,
        //         child: const Center(
        //           child: Text(
        //             'SUBMIT',
        //             style: TextStyle(
        //               fontFamily: "OpenSans",
        //               color: Colors.white,
        //               letterSpacing: 3.0,
        //               fontSize: 10,
        //               fontWeight: FontWeight.bold,
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //     const SizedBox(
        //       height: 330,
        //     ),
        //     InkWell(
        //       onTap: () {
        //         Navigator.push(
        //             context, MaterialPageRoute(builder: (context) => Teller()));
        //       },
        //       child: const Text(
        //         "BACK",
        //         style: TextStyle(
        //           fontFamily: "OpenSans",
        //           letterSpacing: 3.0,
        //           fontSize: 12,
        //         ),
        //       ),
        //     ),
        //   ],
        // ),

        floatingActionButton: FloatingActionButton(
          //backgroundColor: Colors.grey,
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => TellerList(widget.ID)));
          },
          child: const Text(
            "Back",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontFamily: "OpenSans",
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
    //flutterBlue.startScan(timeout : Duration(seconds: 4));
  }

  // Widget bodyCustom(RequestDetail _mydetail) => Column(
  //       children: [
  //         const SizedBox(
  //           height: 50,
  //         ),
  //         Text(_mydetail.requestedamount.toString()),
  //       ],
  //     );

  Future<void> getRequestDetail() async {
    print("Brother, lets see how it is now");
    ServiceClass serviceClass = ServiceClass();
    serviceClass
        .tellerRequestDetail(widget.ID, widget.requestID)
        .then((value) => _output(value));
  }

  void _output(String body) {
    print("Sheyilee - You wanna check the detail now");
    print(body);
    var bodyT = jsonDecode(body);
    if (bodyT["status"] == "active") {
      print("SEYOI BABA");
      setState(() {
        _request = RequestDetail.fromJson(bodyT);
        showData = true;
        //createNull = true;
      });
    } else {
      showMessage(bodyT["message"]);
    }
  }

  void findBluetoothDevices() {
    flutterBlue.startScan(timeout: const Duration(seconds: 4));
    flutterBlue.scanResults.listen((results) {
      setState(() {
        scanResult = results;
      });
    });
    flutterBlue.stopScan();
  }

  void printWithDevice(BluetoothDevice device) async {
    await device.connect();
    final mygen = Generator(PaperSize.mm58, await CapabilityProfile.load());
    final printer = BluePrint();
    printer.addDevice(mygen.text("This is good"));
    printer.addDevice(mygen.feed(1));
    printer.addDevice(mygen.text("hello, lets print"));
    printer.addDevice(mygen.qrcode("https://altospos.com"));
    printer.addDevice(mygen.text("Congratulations, this is working"));
  }

  void mywalletFund() {
    print("hello seyi araoluwa");
    print("We are In teller fund now now..Lets do this.");
    ServiceClass serviceClass = ServiceClass();
    serviceClass.RequestFund(int.parse(loginC.text), fundingC.text)
        .then((value) => output(value));
  }

  void output(ResponseTeller _teller) {
    var bodyT = jsonDecode(_teller.responseBody!);
    print("we are in second haven now bro..lets fund the teller");
    print(_teller);
    print(_teller.responseCode);
    if (_teller.responseCode == 700) {
      showMessage("Network Error Occured...");
    } else {
      if (_teller.responseCode == 200) {
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Success()));
        if (bodyT["status"] == "Successful") {
          FundMobileTeller _fundmobileteller =
              FundMobileTeller.fromJson(bodyT["data"]);
          Provider.of<ServiceClass>(context, listen: false)
              .notifyFundiing(_fundmobileteller);
          print("Inioluwa this is the value - $_fundmobileteller");
        } else {
          if (_teller.responseCode == 404) {
            showMessage("Error occured..Resource not found");
          } else if (_teller.responseCode == 401) {
            showMessage("Incorrect Password, Please try again");
          } else {
            showMessage("Error encountered....");
          }
        }
      }
    }
  }
}
