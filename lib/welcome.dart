import 'package:flutter/material.dart';
import 'package:teller/constants.dart';
import 'package:teller/loading.dart';
import 'package:teller/textstyle.dart';
import 'package:teller/login.dart';
import 'dart:math';
import 'package:google_fonts/google_fonts.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  void setAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
  }

  void repeatAnimation() {
    _animationController.repeat();
  }

  void disposeAnimation() {
    //_animationController.dispose();
  }

  bool showAnimation = false;
  @override
  void initState() {
    setAnimation();
    repeatAnimation();
    super.initState();
  }

  @override
  void dispose() {
    disposeAnimation();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    print("Welcome seyi.. device width - $_width");
    print("Welcome seyi.. device height - $_height");

    return Stack(
      children: [
        Container(
          width: _width,
          height: _height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/tellers.jpg'),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                Colors.black12,
                BlendMode.darken,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.black87,
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _height * .15,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const <Widget>[
                      // SizedBox(
                      //   width: 140,
                      // ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    //  Text(
                    //   'WELCOME TO',
                    //   style: TextStyle(
                    //     letterSpacing: 0.4,
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 20,
                    //   ),
                    // ),
                    // CircleAvatar(
                    //   backgroundImage: AssetImage("lib/images/tteller.jpg"),
                    //   radius: 35,
                    // ),
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Image(
                        image: AssetImage("lib/images/ttteller.png"),
                        //color: Colors.black12,
                        fit: BoxFit.cover,
                        // height: 30,
                      ),
                    ),
                    SizedBox(
                      height: _height * .03,
                    ),
                    const Text(
                      'myTeller',
                      style: TextStyle(
                        letterSpacing: 3.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontFamily: "OpenSans",
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: _height * .03,
                    ),
                    Text(
                      'APPLICATION',
                      style: GoogleFonts.poppins(
                        letterSpacing: 10.0,
                        //fontFamily: "OpenSans",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: _height * .1),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: _width * .025),
                  child: Row(
                    children: [
                      Container(
                        width: _width * .95,
                        height: _height * .053,
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
                            setState(() {
                              showAnimation = true;
                              print("gagagag - Animation set");
                            });
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Login()));
                          },
                          child: const Center(
                            child: Text(
                              'CONTINUE',
                              style: TextStyle(
                                fontFamily: "OpenSans",
                                color: Colors.white,
                                letterSpacing: 2.0,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                // fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Visibility(
          visible: showAnimation,
          child: Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: _width,
              height: _height,
              color: const Color(0xFF000000).withOpacity(0.3),
              child: Stack(
                children: [
                  Positioned(
                    top: _height * 0.4,
                    left: 50,
                    right: 50,
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) {
                          return Transform.rotate(
                            angle: _animationController.velocity * 2 * pi,
                            child: child,
                          );
                        },
                        child: Image.asset(
                          "lib/images/mobiletellera.jpg",
                          width: 70,
                          height: 70,
                          fit: BoxFit.contain,
                        ),
                      ),
                      // child: Image.asset(
                      //   "lib/images/mobiletellera.jpg",
                      //   width: 70,
                      //   height: 70,
                      //   fit: BoxFit.contain,
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
