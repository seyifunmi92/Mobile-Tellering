import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teller/constants.dart';
import 'package:teller/models.dart';
import 'package:teller/signup.dart';
import 'package:teller/welcome.dart';
import 'package:teller/welcome.dart';
import 'package:teller/services.dart';
import 'package:teller/security.dart';
import 'package:teller/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  Responselogin? loginData;
  late AnimationController anicontroller;
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

  bool visiblePass = false;
  String passText = "show";
  bool _obscureText = true;
  bool emailError = false;
  bool showloading = false;
  bool buttonOn = false;
  bool networkError = true;
  bool setAnimation = true;
  bool showData = false;
  TextEditingController usernameC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  SharedPreferences? sharedPreferences;
  void onChange() {
    setState(() {
      setAnimation = false;
    });
  }

  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 20), onChange);
    super.initState();
    anicontroller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    anicontroller.repeat();
  }

  @override
  void dispose() {
    anicontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (showloading) {
    //   print("o click");

    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return _filterDialog(context);
    //       });
    // }

    // showloading
    //     ? showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return _filterDialog(context);
    //         })
    //     : null;
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/teller.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(Colors.black87, BlendMode.darken),
            ),
          ),
        ),
        Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _height * .08,
                ),
                Container(
                  height: 80,
                  child: Image.asset(
                    "lib/images/ttteller.png",
                    fit: BoxFit.cover,
                  ),
                ),

                // SizedBox(
                //   height: _height * .05,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[],
                ),
                SizedBox(
                  height: _height * .015,
                ),
                Text(
                  'WELCOME TELLER',
                  style: GoogleFonts.openSans(
                    //fontFamily: "OpenSans",
                    letterSpacing: 2.0,
                    color: kSecondaryColor,
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(
                  height: _height * .05,
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: _width * .025,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: TextField(
                          style: GoogleFonts.ubuntu(
                            color: Colors.white,
                          ),
                          onChanged: (text2) {
                            if (usernameC.text.isNotEmpty || text2.isNotEmpty) {
                              setState(() {
                                buttonOn = true;
                              });
                            } else if (usernameC.text.isEmpty ||
                                text2.isEmpty) {
                              setState(() {
                                buttonOn = false;
                              });
                            } else if (usernameC.text.isNotEmpty ||
                                passwordC.text.isEmpty) {
                              setState(() {
                                buttonOn = false;
                              });
                            } else {
                              setState(() {
                                buttonOn = false;
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
                          controller: usernameC,
                          decoration: InputDecoration(
                            hintText: "User ID",
                            hintStyle: GoogleFonts.ubuntu(
                              color: Colors.grey[300],
                              letterSpacing: 1.0,
                              fontSize: 14,
                              //fontFamily: "OpenSans",
                            ),
                            border: InputBorder.none,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(0),
                              child: Icon(
                                Icons.email_sharp,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(
                        height: _height * .01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: TextField(
                          style: GoogleFonts.ubuntu(
                            color: Colors.white,
                          ),
                          onChanged: (text2) {
                            if (usernameC.text.isNotEmpty || text2.isNotEmpty) {
                              setState(() {
                                buttonOn = true;
                              });
                            } else if (usernameC.text.isEmpty ||
                                text2.isEmpty) {
                              setState(() {
                                buttonOn = false;
                              });
                            } else if (usernameC.text.isNotEmpty ||
                                passwordC.text.isEmpty) {
                              setState(() {
                                buttonOn = false;
                              });
                            } else {
                              setState(() {
                                buttonOn = false;
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
                          controller: passwordC,
                          decoration: InputDecoration(
                            hintText: "Password",
                            hintStyle: GoogleFonts.ubuntu(
                              color: Colors.grey[300],
                              //fontFamily: "OpenSans",
                              letterSpacing: 1.0,
                              fontSize: 14,
                            ),
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(0),
                              child: Icon(
                                Icons.lock,
                                size: 20,
                                color: Colors.grey,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: EdgeInsets.all(0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _toggle();
                                    visiblePass = true;
                                  });
                                },
                                child: const Icon(
                                  Icons.visibility,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            border: InputBorder.none,
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: visiblePass ? false : true,
                        ),
                      ),
                      SizedBox(
                        height: _height * .02,
                      ),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: _width * .025),
                        height: _height * .053,
                        width: _width * .95,
                        decoration: buttonOn
                            ? BoxDecoration(
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
                              )
                            : BoxDecoration(
                                // ignore: prefer_const_constructors
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(0),
                              ),
                        child: InkWell(
                          onTap: buttonOn
                              ? () {
                                  // setState(() {
                                  //   print("loader3223");
                                  //   showloading = true;
                                  // });

                                  if (usernameC.text.isNotEmpty &&
                                      passwordC.text.isNotEmpty) {
                                    setState(() {
                                      showloading = true;
                                    });

                                    // if (showloading) {
                                    //   print("kslskls");

                                    logon();
                                    //logon();
                                    //usernameC.clear();
                                    //passwordC.clear();
                                  }
                                  // else if (showloading == true) {
                                  //   showDialog(
                                  //           context: context,
                                  //           builder: (BuildContext context) {
                                  //             return _filterDialog(context);
                                  //           })
                                  //       //.
                                  //       // then((value) => logon())
                                  //       ;
                                  // }
                                }
                              : null,
                          child: const Center(
                            child: Text(
                              'LOGIN',
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
                    ],
                  ),
                ),
                // const SizedBox(
                //   height: 20,
                // ),
                // TextButton(
                //   child: Text(
                //     'FORGOT PASSWORD?',
                //     style: TextStyle(
                //       letterSpacing: 4.0,
                //       color: Colors.blue,
                //       fontSize: 13,
                //     ),
                //   ),
                //   onPressed: () {},
                // ),
                SizedBox(
                  height: _height * .3,
                ),
                const Text(
                  'NEW TELLER?',
                  style: TextStyle(
                    fontFamily: "OpenSans",
                    letterSpacing: 7.0,
                    color: Colors.white,
                    fontSize: 10,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  height: _height * .053,
                  width: _width * .95,
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
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUp()));
                    },
                    child: const Center(
                      child: Text(
                        'SIGN UP',
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

                // showDialog(
                //       context: context,
                //       builder: (BuildContext context) {
                //         return _filterDialog(context);
                //       });
              ],
            ),
          ),
        ),
        Visibility(
          visible: showloading,
          child: _filterDialog(context),
        ),
        // Visibility(
        //   visible: showloading,
        //   child:
        // ),
      ],
    );
  }

  Widget _filterDialog(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    var containerheight = _height * .354;
    var _mypadding = SizedBox(height: containerheight * .12);
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Container(
          //height: 50,
          width: _width * .20,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
          child: AnimatedBuilder(
            animation: anicontroller,
            builder: (context, child) {
              return Transform.rotate(
                angle: anicontroller.value * 2 * pi,
                child: child,
              );
            },
            child: Image.asset(
              "lib/images/roundt.png",
              fit: BoxFit.contain,
            ),
          ),
        ),
        // CircularProgressIndicator(
        //   color: Colors.blue,
        //   strokeWidth: 20,
        // ),
      ),
    );
  }

  void logon() {
    print("hello seyi araoluwa");
    print("We are In Login now...");
    ServiceClass serviceClass = ServiceClass();
    serviceClass
        .myLogin(usernameC.text, passwordC.text)
        .then((value) => output(value));
  }

  Future<void> output(ResponseLogin _login) async {
    var bodyT = jsonDecode(_login.responseBody!);
    print("we are in Login - second haven now bro..");
    //print(_login);
    print(_login.responseBody);
    if (_login.responseCode == 700) {
      setState(() {
        showloading = false;
      });
      showMessage("Network error occured...");
    } else {
      if (_login.responseCode == 200) {
        setState(() {
          showloading = false;
        });
        if (bodyT["username"] != null) {
          print("SEYI BABA");
          Responselogin _logon = Responselogin.fromJson(bodyT);
          print(_logon);
          Provider.of<ServiceClass>(context, listen: false).notifyLogin(_logon);
          SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          //sharedPreferences.setString("username", usernameC.text);
          //sharedPreferences.setString("password", passwordC.text);
          sharedPreferences.setString("Token", _logon.accessToken!);
          sharedPreferences.setString("username", _logon.username!);
          sharedPreferences.setString("role", _logon.role ?? "");
          sharedPreferences.setString(
              "originalUserName", _logon.originalUserName!);
          sharedPreferences.setString(
              "refreshToken", _logon.refreshToken!.tokenString!);
          setState(() {
            //emailError = false;
            showloading = false;
            showData = true;
          });
          var userId = sharedPreferences.getString("username");
          var myshared = sharedPreferences.getString("Token");
          var _myshared = sharedPreferences.getString("password");
          print("Lets get shared data");
          print(myshared);
          print(userId);
          //var pass = int.parse();
          //print("Araggf = $pass");
          print("jsjs");
          Navigator.pop(context);
          print("show now");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Home(int.parse(userId!))));
        }
        // else {
        //   print(_login.responseBody);
        //   print("wahala load");
        //   return showDialog(
        //       context: context,
        //       builder: (BuildContext context) {
        //         return _filterDialog(context);
        //       });
        // }
        // showData
        //     ? Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => Home(int.parse(userId!))))
        //     : showDialog(
        //         context: context,
        //         builder: (BuildContext context) {
        //           return _filterDialog(context);
        //         });

      } else if (_login.responseCode == 404) {
        setState(() {
          emailError = true;
          showloading = false;
        });
        showMessage("Invalid Username, Please check and try again");
      } else if (_login.responseCode == 401) {
        print("401 loadddddd");

        setState(() {
          emailError = true;
          showloading = false;
        });
        showMessage("Incorrect Password, Please check and try again");
      } else {
        print("loadddddd");
        setState(() {
          print("loadddddderererr");
          showloading = false;
        });
        showMessage("Error encountered....");
      }
    }
  }
}
