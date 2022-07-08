import 'package:flutter/material.dart';
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
import 'package:intl/intl.dart';

class TellerRequest extends StatefulWidget {
  //int ID;
   //TellerRequest(this.ID);

  _TellerRequestState createState() => _TellerRequestState();
}

class _TellerRequestState extends State<TellerRequest> {
  bool buttonActive = false;
  TextEditingController idC = TextEditingController();
  TextEditingController loginUserC = TextEditingController();
  TextEditingController requestedC = TextEditingController();
  TextEditingController dateC = TextEditingController();
  TextEditingController createdC = TextEditingController();
  TextEditingController approvedC = TextEditingController();
  TextEditingController statusC = TextEditingController();
  DateTime now = DateTime.now();
  //String formattedDate = DateFormat("yyyy-MM-dd").format(now);
  bool networkError = false;
  bool emailError = false;
  bool showloading = false;

  String emailErrortext = "Incorrect email address, please enter and try again";
  @override
  void initState() {
   //getTellerList(widget.ID);
    super.initState();
  }
  @override

  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Mobile Teller Request List",
        style:TextStyle(
          fontFamily: "OpenSans",
        ),
        ),
      ),
      // body: SingleChildScrollView(
      //   scrollDirection: Axis.vertical,
      //   child: Column(
      //     children: [
      //       const SizedBox(height: 30,),
      //       Row(
      //         mainAxisAlignment: MainAxisAlignment.center,
      //         children: const [
      //           Text("Please input the following",
      //             style:TextStyle(
      //               fontFamily: "OpenSans",
      //               fontSize: 15,
      //               //fontWeight: FontWeight.bold,
      //             ),
      //           ),
      //         ],
      //       ),
      //
      //           const SizedBox(
      //             height: 10,
      //           ),
      //           Container(
      //             padding: const EdgeInsets.all(10),
      //             decoration: BoxDecoration(
      //               borderRadius: BorderRadius.circular(10),
      //               color: Colors.white,
      //             ),
      //             child: Row(children: [
      //               //SvgPicture.asset("assets/svg/${emailIcon}.svg"),
      //               const SizedBox(
      //                 width: 5,
      //               ),
      //               Expanded(
      //                 flex: 1,
      //                 child: Column(
      //                   children: [
      //                     TextField(
      //                       controller: idC,
      //                       //controller: emailC,
      //                       cursorColor: Colors.blue,
      //                       // style: kmediumTextBold(kColorBlack),
      //                       keyboardType: TextInputType.emailAddress,
      //                       onChanged: (text1) {
      //                         if (text1.isNotEmpty) {
      //                           setState(() {
      //                             buttonActive = true;
      //                           });
      //                         } else {
      //                           setState(() {
      //                             buttonActive = false;
      //                           });
      //                         }
      //                         // if (text.contains("@")) {
      //                         //   if (text.split("@")[1].contains(".")){
      //                         //     setState(() {
      //                         //       emailIcon = "email_icon2";
      //                         //     });
      //                         //   }else{
      //                         //     setState(() {
      //                         //       emailIcon = "email_icon";
      //                         //     });
      //                         //   }
      //                         // }else{
      //                         //   setState(() {
      //                         //     emailIcon = "email_icon";
      //                         //   });
      //                         // }
      //                       },
      //                       decoration: const InputDecoration(
      //                         hintText: "Id",
      //                         hintStyle: TextStyle(
      //                           fontFamily: "OpenSans",
      //                           fontSize: 12,
      //                           //fontFamily: "Poppins",
      //                           fontWeight: FontWeight.w400,
      //                           //color: kColorBlack.withOpacity(.3)),
      //                           //border: InputBorder.none,
      //                         ),
      //                       ),
      //                     ),
      //                     const SizedBox(
      //                       height: 20,
      //                     ),
      //                     TextField(
      //                       controller: loginUserC,
      //                       //controller: emailC,
      //                       cursorColor: Colors.blue,
      //                       // style: kmediumTextBold(kColorBlack),
      //                       keyboardType: TextInputType.number,
      //                       onChanged: (text2) {
      //                         if (idC.text.isNotEmpty || text2.isNotEmpty) {
      //                           setState(() {
      //                             buttonActive = true;
      //                           });
      //                         } else if (idC.text.isEmpty || text2.isEmpty) {
      //                           setState(() {
      //                             buttonActive = false;
      //                           });
      //                         } else if (idC.text.isNotEmpty ||
      //                             loginUserC.text.isEmpty) {
      //                           setState(() {
      //                             buttonActive = false;
      //                           });
      //                         } else {
      //                           setState(() {
      //                             buttonActive = false;
      //                           });
      //                         }
      //                         // if (text.contains("@")) {
      //                         //   if (text.split("@")[1].contains(".")){
      //                         //     setState(() {
      //                         //       emailIcon = "email_icon2";
      //                         //     });
      //                         //   }else{
      //                         //     setState(() {
      //                         //       emailIcon = "email_icon";
      //                         //     });
      //                         //   }
      //                         // }else{
      //                         //   setState(() {
      //                         //     emailIcon = "email_icon";
      //                         //   });
      //                         // }
      //                       },
      //                       decoration: const InputDecoration(
      //                         hintText: "Login User Id",
      //                         hintStyle: TextStyle(
      //                           fontSize: 12,
      //                           fontFamily: "OpenSans",
      //                           fontWeight: FontWeight.w400,
      //                           //color: kColorBlack.withOpacity(.3)),
      //                           //border: InputBorder.none,
      //                         ),
      //                       ),
      //                     ),
      //                     const SizedBox(
      //                       height: 20,
      //                     ),
      //                     TextField(
      //                       controller: requestedC,
      //                       //controller: emailC,
      //                       cursorColor: Colors.blue,
      //                       // style: kmediumTextBold(kColorBlack),
      //                       keyboardType: TextInputType.emailAddress,
      //                       onChanged: (text1) {
      //                         if (text1.isNotEmpty) {
      //                           setState(() {
      //                             buttonActive = true;
      //                           });
      //                         } else {
      //                           setState(() {
      //                             buttonActive = false;
      //                           });
      //                         }
      //                         // if (text.contains("@")) {
      //                         //   if (text.split("@")[1].contains(".")){
      //                         //     setState(() {
      //                         //       emailIcon = "email_icon2";
      //                         //     });
      //                         //   }else{
      //                         //     setState(() {
      //                         //       emailIcon = "email_icon";
      //                         //     });
      //                         //   }
      //                         // }else{
      //                         //   setState(() {
      //                         //     emailIcon = "email_icon";
      //                         //   });
      //                         // }
      //                       },
      //                       decoration: const InputDecoration(
      //                         hintText: "Requested Amount",
      //                         hintStyle: TextStyle(
      //                           fontFamily: "OpenSans",
      //
      //                           fontSize: 12,
      //                           //fontFamily: "Poppins",
      //                           fontWeight: FontWeight.w400,
      //                           //color: kColorBlack.withOpacity(.3)),
      //                           //border: InputBorder.none,
      //                         ),
      //                       ),
      //                     ),
      //                     const SizedBox(
      //                       height: 20,
      //                     ),
      //                     TextField(
      //                       controller: dateC,
      //                       //controller: emailC,
      //                       cursorColor: Colors.blue,
      //                       // style: kmediumTextBold(kColorBlack),
      //                       keyboardType: TextInputType.emailAddress,
      //                       onChanged: (text1) {
      //                         if (text1.isNotEmpty) {
      //                           setState(() {
      //                             buttonActive = true;
      //                           });
      //                         } else {
      //                           setState(() {
      //                             buttonActive = false;
      //                           });
      //                         }
      //                         // if (text.contains("@")) {
      //                         //   if (text.split("@")[1].contains(".")){
      //                         //     setState(() {
      //                         //       emailIcon = "email_icon2";
      //                         //     });
      //                         //   }else{
      //                         //     setState(() {
      //                         //       emailIcon = "email_icon";
      //                         //     });
      //                         //   }
      //                         // }else{
      //                         //   setState(() {
      //                         //     emailIcon = "email_icon";
      //                         //   });
      //                         // }
      //                       },
      //                       decoration: const InputDecoration(
      //                         hintText: "Date Created",
      //                         hintStyle: TextStyle(
      //                           fontFamily: "OpenSans",
      //
      //                           fontSize: 12,
      //                           //fontFamily: "Poppins",
      //                           fontWeight: FontWeight.w400,
      //                           //color: kColorBlack.withOpacity(.3)),
      //                           //border: InputBorder.none,
      //                         ),
      //                       ),
      //                     ),
      //                     const SizedBox(
      //                       height: 20,
      //                     ),
      //                     TextField(
      //                       controller: createdC,
      //                       //controller: emailC,
      //                       cursorColor: Colors.blue,
      //                       // style: kmediumTextBold(kColorBlack),
      //                       keyboardType: TextInputType.emailAddress,
      //                       onChanged: (text1) {
      //                         if (text1.isNotEmpty) {
      //                           setState(() {
      //                             buttonActive = true;
      //                           });
      //                         } else {
      //                           setState(() {
      //                             buttonActive = false;
      //                           });
      //                         }
      //                         // if (text.contains("@")) {
      //                         //   if (text.split("@")[1].contains(".")){
      //                         //     setState(() {
      //                         //       emailIcon = "email_icon2";
      //                         //     });
      //                         //   }else{
      //                         //     setState(() {
      //                         //       emailIcon = "email_icon";
      //                         //     });
      //                         //   }
      //                         // }else{
      //                         //   setState(() {
      //                         //     emailIcon = "email_icon";
      //                         //   });
      //                         // }
      //                       },
      //                       decoration: const InputDecoration(
      //                         hintText: "Created By",
      //                         hintStyle: TextStyle(
      //                           fontFamily: "OpenSans",
      //
      //                           fontSize: 12,
      //                           //fontFamily: "Poppins",
      //                           fontWeight: FontWeight.w400,
      //                           //color: kColorBlack.withOpacity(.3)),
      //                           //border: InputBorder.none,
      //                         ),
      //                       ),
      //                     ),
      //                     const SizedBox(
      //                       height: 20,
      //                     ),
      //                     TextField(
      //                       controller: approvedC,
      //                       //controller: emailC,
      //                       cursorColor: Colors.blue,
      //                       // style: kmediumTextBold(kColorBlack),
      //                       keyboardType: TextInputType.emailAddress,
      //                       onChanged: (text1) {
      //                         if (text1.isNotEmpty) {
      //                           setState(() {
      //                             buttonActive = true;
      //                           });
      //                         } else {
      //                           setState(() {
      //                             buttonActive = false;
      //                           });
      //                         }
      //                         // if (text.contains("@")) {
      //                         //   if (text.split("@")[1].contains(".")){
      //                         //     setState(() {
      //                         //       emailIcon = "email_icon2";
      //                         //     });
      //                         //   }else{
      //                         //     setState(() {
      //                         //       emailIcon = "email_icon";
      //                         //     });
      //                         //   }
      //                         // }else{
      //                         //   setState(() {
      //                         //     emailIcon = "email_icon";
      //                         //   });
      //                         // }
      //                       },
      //                       decoration: const InputDecoration(
      //                         hintText: "Approved(Please Fill Yes/No)",
      //                         hintStyle: TextStyle(
      //                           fontFamily: "OpenSans",
      //
      //                           fontSize: 12,
      //                           //fontFamily: "Poppins",
      //                           fontWeight: FontWeight.w400,
      //                           //color: kColorBlack.withOpacity(.3)),
      //                           //border: InputBorder.none,
      //                         ),
      //                       ),
      //                     ),
      //                     const SizedBox(
      //                       height: 20,
      //                     ),
      //                     TextField(
      //                       controller: statusC,
      //                       //controller: emailC,
      //                       cursorColor: Colors.blue,
      //                       // style: kmediumTextBold(kColorBlack),
      //                       keyboardType: TextInputType.emailAddress,
      //                       onChanged: (text1) {
      //                         if (text1.isNotEmpty) {
      //                           setState(() {
      //                             buttonActive = true;
      //                           });
      //                         } else {
      //                           setState(() {
      //                             buttonActive = false;
      //                           });
      //                         }
      //                         // if (text.contains("@")) {
      //                         //   if (text.split("@")[1].contains(".")){
      //                         //     setState(() {
      //                         //       emailIcon = "email_icon2";
      //                         //     });
      //                         //   }else{
      //                         //     setState(() {
      //                         //       emailIcon = "email_icon";
      //                         //     });
      //                         //   }
      //                         // }else{
      //                         //   setState(() {
      //                         //     emailIcon = "email_icon";
      //                         //   });
      //                         // }
      //                       },
      //                       decoration: const InputDecoration(
      //                         hintText: "Status",
      //                         hintStyle: TextStyle(
      //                           fontFamily: "OpenSans",
      //
      //                           fontSize: 12,
      //                           //fontFamily: "Poppins",
      //                           fontWeight: FontWeight.w400,
      //                           //color: kColorBlack.withOpacity(.3)),
      //                           //border: InputBorder.none,
      //                         ),
      //                       ),
      //                     ),
      //
      //                   ],
      //                 ),
      //               ),
      //             ]),
      //           ),
      //           const SizedBox(
      //             height: 30,
      //           ),
      //           Container(
      //             height: 40,
      //             width: 350,
      //             decoration: buttonActive
      //                 ? BoxDecoration(
      //               // ignore: prefer_const_constructors
      //
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
      //                 : BoxDecoration(
      //               // ignore: prefer_const_constructors
      //               color: Colors.grey,
      //               borderRadius: BorderRadius.circular(5),
      //             ),
      //             child: InkWell(
      //               onTap: buttonActive
      //                   ? () {
      //                 if (idC.text.isNotEmpty && loginUserC.text.isNotEmpty
      //                 && requestedC.text.isNotEmpty && dateC.text.isNotEmpty && createdC.text.isNotEmpty
      //                 && approvedC.text.isNotEmpty && statusC.text.isNotEmpty
      //                 ) {
      //                   //getTellerList();
      //                   //signUp();
      //                   idC.clear();
      //                   loginUserC.clear();
      //                   requestedC.clear();
      //                   dateC.clear();
      //                   createdC.clear();
      //                   approvedC.clear();
      //                   statusC.clear();
      //
      //                   Future.delayed(const Duration(seconds: 5));
      //                   //succesfulSignUp();
      //                 }
      //               }
      //                   : null,
      //               child: const Center(
      //                 child: Text(
      //                   'SUBMIT',
      //                   style: TextStyle(
      //                     fontFamily: "OpenSans",
      //                     color: Colors.white,
      //                     letterSpacing: 3.0,
      //                     fontSize: 10,
      //                     fontWeight: FontWeight.bold,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           ),
      //           const SizedBox(
      //             height: 50,
      //           ),
      //           InkWell(
      //             onTap: () {
      //               Navigator.push(
      //                   context, MaterialPageRoute(builder: (context) => Teller()));
      //             },
      //             child: const Text(
      //               "BACK",
      //               style: TextStyle(
      //                 fontFamily: "OpenSans",
      //                 letterSpacing: 3.0,
      //                 fontSize: 12,
      //               ),
      //             ),
      //           ),
      //         ],
      //       ),
      // ),


    );
  }
  void getTellerList(int loginUserId) {
    print("hello seyi ara of lagos");
    print("We are In Teller Request Listing now oo now...");
    ServiceClass serviceClass = ServiceClass();
    serviceClass.TellerRequest(loginUserId).then((value) =>
        MaterialPageRoute(builder: (context) => Teller()));
  }

}

