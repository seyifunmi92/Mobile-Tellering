import 'package:flutter/material.dart';
import 'package:teller/constants.dart';
import 'package:teller/textstyle.dart';
import 'package:teller/login.dart';



class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
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
          body: Column(
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                height: 5,
              ),
              const SizedBox(
                height: 170,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                    SizedBox(
                      width: 140,
                    ),

                  ],
                ),
              ),
              Center(
                child: Column(
                  children: const [
                    //  Text(
                    //   'WELCOME TO',
                    //   style: TextStyle(
                    //     letterSpacing: 0.4,
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 20,
                    //   ),
                    // ),
                    SizedBox(height: 20,),
                    Text(
                      'MOBILE TELLERING',
                      style: TextStyle(

                        letterSpacing: 3.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                        fontFamily: "OpenSans",
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(height: 20,),

                    Text(
                      'APPLICATION',
                      style: TextStyle(
                        letterSpacing: 10.0,
                        fontFamily: "OpenSans",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 100,
              ),
              Container(
                height: 40,
                width: 350,
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
                  borderRadius: BorderRadius.circular(5),
                ),
                child: InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder:(context)  => Login()));
                  },
                  child: const Center(
                    child:  Text(
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
    );

  }
}
