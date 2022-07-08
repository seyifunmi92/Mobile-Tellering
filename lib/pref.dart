import 'package:flutter/material.dart';
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
import 'package:teller/tellerrequest.dart';
import 'package:intl/intl.dart';
//import 'package:flutter_blue/flutter_blue.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pref extends StatefulWidget {
  const Pref({Key? key}) : super(key: key);

  @override
  _PrefState createState() => _PrefState();
}

class _PrefState extends State<Pref> {
  late SharedPreferences mypref;
  Future load() async {
    mypref = await SharedPreferences.getInstance();
  }

  save() async {
    await load();
    mypref.setString("email", emailC.text);
    mypref.setString("phone", phoneC.text);
    mypref.setString("core", coreC.text);
    //mypref!.setInt("integer", 20);
  }

  fetch() async {
    String myname = mypref.getString("string") ?? "";
    int myage = mypref.getInt("integer") ?? 0;
    String em = mypref.getString("email") ?? "";
    print(myname);
    print(myage);
    print(em);
    mypref.get("email");
    mypref.get("phone");
    mypref.get("core");
  }

  Delete() async {
    mypref.remove("string");
    mypref.remove("integer");
  }

  bool buttonActive = false;
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController coreC = TextEditingController();
  @override
  void initState() {
    //fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Test Data Storage",
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
            "Please enter your details below",
            style: TextStyle(
                fontSize: 15,
                fontFamily: "OpenSans",
                fontWeight: FontWeight.w500,
                color: Colors.black),
            textAlign: TextAlign.start,
          ),
          const SizedBox(
            height: 40,
          ),
          Container(
            padding: EdgeInsets.all(10),
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
                      controller: emailC,
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
                        hintText: "Email",
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
                    const SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: phoneC,
                      //controller: emailC,
                      cursorColor: Colors.blue,
                      // style: kmediumTextBold(kColorBlack),
                      keyboardType: TextInputType.number,
                      onChanged: (text2) {
                        if (emailC.text.isNotEmpty || text2.isNotEmpty) {
                          setState(() {
                            buttonActive = true;
                          });
                        } else if (emailC.text.isEmpty || text2.isEmpty) {
                          setState(() {
                            buttonActive = false;
                          });
                        } else if (emailC.text.isNotEmpty ||
                            phoneC.text.isEmpty) {
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
                        hintText: "Phone Number",
                        hintStyle: TextStyle(
                          fontSize: 12,
                          fontFamily: "OpenSans",
                          fontWeight: FontWeight.w400,
                          //color: kColorBlack.withOpacity(.3)),
                          //border: InputBorder.none,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: coreC,
                      //controller: emailC,
                      cursorColor: Colors.blue,
                      // style: kmediumTextBold(kColorBlack),
                      keyboardType: TextInputType.number,
                      onChanged: (text2) {
                        if (emailC.text.isNotEmpty || text2.isNotEmpty) {
                          setState(() {
                            buttonActive = true;
                          });
                        } else if (emailC.text.isEmpty || text2.isEmpty) {
                          setState(() {
                            buttonActive = false;
                          });
                        } else if (emailC.text.isNotEmpty ||
                            phoneC.text.isEmpty) {
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
                        hintText: "Core Banking ID",
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
            ]),
          ),
          const SizedBox(
            height: 50,
          ),
          Container(
            height: 40,
            width: 350,
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
                      if (emailC.text.isNotEmpty &&
                          phoneC.text.isNotEmpty &&
                          coreC.text.isNotEmpty) {
                        save();
                        //signUp();
                        emailC.clear();
                        phoneC.clear();
                        coreC.clear();
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
            height: 100,
          ),
          InkWell(
            onTap: () {
              fetch();
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
          const SizedBox(
            height: 20,
          ),
          const Text("Correvct"),
          if (mypref != null)
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                  "This user with email : ${mypref.get("email")} and phone number : ${mypref.get("phone")} and corebanking id : ${mypref.get("core")}"),
            ),
        ],
      ),
    );
  }
}
