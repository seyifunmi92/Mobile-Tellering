import 'dart:convert';

import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';
import 'package:teller/checkmessage.dart';
import 'package:teller/succes.dart';
import 'package:teller/teller.dart';
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
  const FundTeller({Key? key}) : super(key: key);

  @override
  _FundTellerState createState() => _FundTellerState();
}


class _FundTellerState extends State<FundTeller> {
  List<ScanResult>? scanResult;

  FlutterBlue flutterBlue = FlutterBlue.instance;
  final _scaffoldKey =  GlobalKey<ScaffoldState>();
  bool buttonActive = false;
  TextEditingController loginC = TextEditingController();
  TextEditingController fundingC = TextEditingController();
  bool networkError = false;


  showMessage(String message,
      [Duration duration = const Duration(seconds: 4)]){
    _scaffoldKey.currentState!.showSnackBar(SnackBar(
      content: Text(message),
      duration: duration,
      action: SnackBarAction(
        label: "CLOSE",
        onPressed: (){_scaffoldKey.currentState!.removeCurrentSnackBar();},
      ),
    )
    );
  }
  @override
  Widget build(BuildContext context) {
    // flutterBlue.startScan(timeout: const Duration(seconds: 4));
    // var subscription = flutterBlue.scanResults.listen((results) {
    //   for(ScanResult r in results){
    //     print("${r.device.name} has been found! rssi: ${r.rssi}");
    //   }
    // });
    //
    // flutterBlue.stopScan();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("FUND MOBILE TELLER",
          style: TextStyle(
            fontFamily: "OpenSans",

          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 35,
          ),
          const Text(
            "Please enter the following",
            style: TextStyle(
                fontSize: 15,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w500,
                color: Colors.black),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 40,),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,),
            child: Row(
                children: [
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
                            }
                            else {
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

                              fontSize: 12,
                              //fontFamily: "Poppins",
                              fontWeight: FontWeight.w400,
                              //color: kColorBlack.withOpacity(.3)),
                              //border: InputBorder.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20,),
                        TextField(
                          controller: fundingC,
                          //controller: emailC,
                          cursorColor: Colors.blue,
                          // style: kmediumTextBold(kColorBlack),
                          keyboardType: TextInputType.number,
                          onChanged: (text2) {
                            if (loginC.text.isNotEmpty || text2.isNotEmpty) {
                              setState(() {
                                buttonActive = true;
                              });
                            }
                            else if (loginC.text.isEmpty || text2.isEmpty) {
                              setState(() {
                                buttonActive = false;
                              });
                            }
                            else if (loginC.text.isNotEmpty || fundingC.text
                                .isEmpty) {
                              setState(() {
                                buttonActive = false;
                              });
                            }
                            else {
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
                            hintText: "Funding request id",
                            hintStyle: TextStyle(
                              fontSize: 12,
                              fontFamily: "OpenSans",
                              fontWeight: FontWeight.w400,
                              //color: kColorBlack.withOpacity(.3)),
                              //border: InputBorder.none,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
            ),
          ),
          const SizedBox(height: 50,),
          Container(
            height: 40,
            width: 350,
            decoration: buttonActive ?

            BoxDecoration(
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
            ) : BoxDecoration(
              // ignore: prefer_const_constructors
              color: Colors.grey,
              borderRadius: BorderRadius.circular(5),
            ),
            child: InkWell(
              onTap: buttonActive ? () {
                if (loginC.text.isNotEmpty && fundingC.text.isNotEmpty) {
                  mywalletFund();
                  loginC.clear();
                  fundingC.clear();
                  Future.delayed(const Duration(seconds: 5));
                  //succesfulSignUp();
                }
              }
                  : null,
              child: const Center(
                child: Text(
                  'SUBMIT',
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
            height: 330,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Teller()));
            },
            child: const Text(
              "BACK",
              style: TextStyle(
                fontFamily: "OpenSans",
                letterSpacing: 3.0,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
    //flutterBlue.startScan(timeout : Duration(seconds: 4));
  }

  void findBluetoothDevices(){
    flutterBlue.startScan(timeout: const Duration(seconds: 4));
    flutterBlue.scanResults.listen((results) {
      setState(() {
        scanResult = results;
      });
    });
    flutterBlue.stopScan();
  }
  void printWithDevice(BluetoothDevice device)async{
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
    serviceClass.RequestFund(int.parse(loginC.text), fundingC.text).then((value) => output(value));
  }

  void output(ResponseTeller _teller){
    var bodyT = jsonDecode(_teller.responseBody!);
    print("we are in second haven now bro..lets fund the teller");
    print(_teller);
    print(_teller.responseCode);
    if(_teller.responseCode == 700){
      showMessage("Network Error Occured...");
    }
    else{
      if(_teller.responseCode == 200){
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Success()));
        if(bodyT["status"] == "Successful"){
          FundMobileTeller _fundmobileteller = FundMobileTeller.fromJson(bodyT["data"]);
          Provider.of<ServiceClass>(context, listen: false).notifyFundiing(_fundmobileteller);
          print("Inioluwa this is the value - $_fundmobileteller");
        }
        else{
          if(_teller.responseCode == 404){
            showMessage("Error occured..Resource not found");
          }
          else if(
          _teller.responseCode == 401){
            showMessage("Incorrect Password, Please try again");
          }
          else{
            showMessage("Error encountered....");
          }
        }
      }
    }

  }

}



