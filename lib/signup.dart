import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teller/newservice.dart';
import 'package:teller/welcome.dart';
import 'package:teller/welcome.dart';
import 'package:teller/services.dart';
import 'package:teller/constants.dart';
import 'package:teller/textstyle.dart';
import 'package:teller/login.dart';
import 'package:teller/models.dart';
import 'package:provider/provider.dart';
import 'package:teller/services.dart';
import 'package:teller/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teller/models.dart';
import 'dart:convert';
import 'dart:math';
import 'package:teller/checkmessage.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  Responselogin? respLog;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool buttonActive = false;
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController coreC = TextEditingController();
  bool networkError = false;
  bool emailError = false;
  bool getToken = false;
  bool showloading = false;
  String emailErrortext = "Incorrect email address, please enter and try again";
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

  @override
  void initState() {
    mylog();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Sign Up For Mobile Teller",
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
                    const SizedBox(
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
                        signUp();
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
            height: 330,
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const Login()));
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
  }

  // Future<void> succesfulSignUp() async {
  //   var login = await userReg(emailC.text, phoneC.text);
  //   if (login != null) {
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
  //   }
  // }

  void mylog() {
    Provider.of<ServiceClass>(context, listen: false)
        .myLoginn("username", "password")
        .then((value) => _output(value));
  }

  Future<void> _output(ResponseLogin logons) async {
    var bodyT = jsonDecode(logons.responseBody!);
    if (logons.responseCode == 200) {
      setState(() {
        getToken = true;
        respLog = Responselogin.fromJson(bodyT);
      });
      //context.read<ServiceClass>().getToken(respLog!.accessToken!);
      Provider.of<ServiceClass>(context, listen: false)
          .getToken(respLog!.accessToken!);
      Provider.of<ServiceClass>(context, listen: false).getUserToken();
    } else {
      setState(() {
        getToken = false;
      });
    }
  }

  void signUp() {
    print("hello seyi araoluwa");
    print("We are In sign up now...");
    ServiceClass serviceClass = ServiceClass();
    serviceClass
        .userReg(emailC.text, phoneC.text, coreC.text)
        .then((value) => output(value));
  }

  void output(ResponseObject object) {
    var bodyT = jsonDecode(object.responseBody!);
    print("we are in second haven now bro..");
    print(object);
    print(object.responseCode);
    if (object.responseCode == 700) {
      showMessage("Network error occured...");
    } else {
      if (object.responseCode == 200) {
        if (bodyT["responseMessage"] == "Success") {
          print("seyiara this is skkk");
          setState(() {
            emailError = false;
            showloading = false;
          });
          UserRegistration userRegistration = UserRegistration.fromJson(bodyT);
          Provider.of<ServiceClass>(context, listen: false)
              .notifySignin(userRegistration);
          print(userRegistration);
          Navigator.pop(context);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CheckMessage()));
        }
      } else {
        if (object.responseCode == 404) {
          setState(() {
            emailError = true;
          });
          showMessage("Error occured..Resource not found");
        } else if (object.responseCode == 401) {
          setState(() {
            emailError = true;
          });
          showMessage("Error encountered...");
        } else {
          setState(() {
            showloading = false;
          });
          showMessage("Error encountered....");
        }
      }
    }
    // if(.contains("Network Error")){
    //
    //   setState(() {
    //     networkError = true;
    //   });
    //   showMessage("Network Error");
    // }
    // else{
    //   var bodyT = jsonDecode(body);
    //   if((bodyT["status"]) == "Successful") {
    //     var _mydata = json.decode(body);
    //     print(_mydata);
    //      Navigator.push(context, MaterialPageRoute(builder: (context) => CheckMessage()));
    //   }
    //   else{
    //     showMessage(bodyT["message"]);
    //     Provider.of<ServiceClass>(context, listen: false).userReg(emailC.text, phoneC.text);
    //   }
    // }
  }
}
