import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teller/customerDetails.dart';
import 'package:teller/welcome.dart';
import 'package:teller/welcome.dart';
import 'package:teller/services.dart';
import 'package:teller/constants.dart';
import 'package:teller/textstyle.dart';
import 'package:teller/login.dart';
import 'package:teller/home.dart';

import 'models.dart';

//import 'package:google_fonts/google_fonts.dart';

class Customer extends StatefulWidget {
  int ID;
  Customer(this.ID);

  @override
  _CustomerState createState() => _CustomerState();
}

class _CustomerState extends State<Customer> {
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Customer Enquiry"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
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
                  children: [
                    const Text(
                      "SEARCH",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: 260,
                      decoration: BoxDecoration(
                        color: Colors.black26,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const TextField(
                        decoration: InputDecoration(
                          hintText: "      Enter Account Number/Name",
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
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 40,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
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
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CustomerDetails()));
                    },
                    child: Row(
                      children: const <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        // Icon(
                        //   Icons.atm_sharp,
                        // ),
                        SizedBox(
                          width: 0,
                        ),
                        Center(
                          child: Text(
                            "              Enter",
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
                const SizedBox(
                  height: 20,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    height: 123,
                    width: 485,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              children: [
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Select",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.purple,
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: InkWell(
                                          onTap: () {},
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: InkWell(
                                          onTap: () {},
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.white12,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: InkWell(
                                          onTap: () {},
                                          child: const CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: 5,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "S/N",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.purple,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "1",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "2",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.white10,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "3",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "First Name",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.purple,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Efe",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Seyi",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.white10,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Wale",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Surname",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.purple,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Olawale",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Ade",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.white10,
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Taiwo",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Other Name",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.purple,
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Jide",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.grey,
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Joy",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.white10,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Alli",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 1,
                            ),
                            Column(
                              children: [
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "Acct No",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.purple,
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "0129239387",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "2293933345",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.white10,
                                ),
                                SizedBox(
                                  height: 1,
                                ),
                                Container(
                                  child: Column(
                                    children: const [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Center(
                                        child: Text(
                                          "1234567890",
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  height: 30,
                                  width: 80,
                                  color: Colors.grey,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    color: Colors.black26,
                  ),
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
                SizedBox(
                  height: 20,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                          tileMode: TileMode
                              .repeated, // repeats the gradient over the canvas
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: const <Widget>[
                            // SizedBox(
                            //   width: 20,
                            // ),
                            // Icon(
                            //   Icons.atm_sharp,
                            // ),
                            SizedBox(
                              width: 25,
                            ),
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
                    const SizedBox(
                      width: 30,
                    ),
                    // SizedBox(height: 20,),

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
                          tileMode: TileMode
                              .repeated, // repeats the gradient over the canvas
                        ),
                      ),
                      child: InkWell(
                        onTap: () {},
                        child: Row(
                          children: const <Widget>[
                            // SizedBox(
                            //   width: 20,
                            // ),
                            // Icon(
                            //   Icons.atm_sharp,
                            // ),
                            SizedBox(
                              width: 25,
                            ),
                            Center(
                              child: Text(
                                "View Balance",
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
              ],
            ),
          ),
          const SizedBox(
            height: 150,
          ),
          FutureBuilder(
            future: getSharedData(),
            builder: (context, snapshot) {
              var _loginuser = snapshot.data!;
              print("Ararayghsb - $_loginuser");
              if (snapshot.hasData) {
                return Container(
                    width: 320,
                    height: 42,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                    ),
                    child: InkWell(
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
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.0,
                              fontSize: 12,
                            ),
                          ),
                        )));
              } else
                return CircularProgressIndicator();
            },
          ),
          // Container(
          //   height: 50,
          //   width: 350,
          //   decoration: BoxDecoration(
          //     borderRadius: BorderRadius.circular(15),
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
          //           TileMode.repeated, // repeats the gradient over the canvas
          //     ),
          //   ),
          //   child: InkWell(
          //     onTap: () {
          //       Navigator.push(
          //           context,
          //           MaterialPageRoute(
          //               builder: (context) =>
          //                   Home(customerBalance!.loginUserId!)));
          //       // Navigator.push(context, MaterialPageRoute(builder:(context)  => Home()));
          //     },
          //     child: Row(
          //       children: const <Widget>[
          //         SizedBox(
          //           width: 20,
          //         ),
          //         // Icon(
          //         //   Icons.atm_sharp,
          //         // ),
          //         SizedBox(
          //           width: 120,
          //         ),
          //         Center(
          //           child: Text(
          //             "Back To Menu",
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
    );
  }

  Future<void> balance() async {
    ServiceClass serviceClass = ServiceClass();
    serviceClass.getBalance(widget.ID).then((value) => (output(value)));
  }

  void output(String body) {
    print("YEAH, lets get balance now...");
    print(body);
    if (body.contains("No balance for this user")) {
      showMessage("No balance for this user");
      setState(() {
        loading = false;
      });
    } else {
      var bodyT = jsonDecode(body);
      if (bodyT["loginUserId"] != null) {
        setState(() {
          customerBalance = GetBalance.fromJson(bodyT);
          showBalance = true;
          showData = true;
        });
      } else {
        showMessage(bodyT["message"]);
      }
    }
  }
}
