import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teller/cashDepostit.dart';
import 'package:teller/welcome.dart';
import 'package:teller/welcome.dart';
import 'package:teller/services.dart';
import 'package:teller/constants.dart';
import 'package:teller/textstyle.dart';
import 'package:teller/login.dart';
import 'package:teller/teller.dart';
import 'package:teller/customer.dart';
import 'package:teller/openAccount.dart';
import 'package:teller/home.dart';

class DailyCollections extends StatefulWidget {
  const DailyCollections({Key? key}) : super(key: key);
  @override
  _DailyCollectionsState createState() => _DailyCollectionsState();
}

class _DailyCollectionsState extends State<DailyCollections> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Daily Activity Summary",
          style: TextStyle(fontFamily: "OpenSans"),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Center(
            child: Container(
              width: 320,
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
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
                // ignore: prefer_const_literals_to_create_immutables
                boxShadow: [
                  const BoxShadow(
                    color: Colors.blue,
                    offset: Offset.zero,
                    blurStyle: BlurStyle.outer,
                    blurRadius: 10.0,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/homee');
                },
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    const SizedBox(
                      height: 17,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: const [
                        // ignore: prefer_const_constructors
                        SizedBox(
                          width: 50,
                        ),
                        Text(
                          " Summary Collections For Today",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white,
                              fontFamily: "OpenSans"),
                        ),
                      ],
                    ),
                    // ignore: prefer_const_constructors
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // ignore: prefer_const_constructors
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Center(
                                  child: Text(
                                    "                        System Date : May 4, 2022",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: Colors.white,
                                        fontFamily: "OpenSans"),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: const [
                                Text(
                                  "                            Calendar Date : May 5, 2022",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: "OpenSans"),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "                     Teller ID : 1025",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontFamily: "OpenSans"),
                                ),
                              ],
                            ),
                            const Text(
                              "                          Till Balance : -\$504,000",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontFamily: "OpenSans"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Search",
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black26,
                    fontFamily: "OpenSans"),
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  Container(
                    width: 350,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        hintText: "  Enter Account Number/Name",
                        hintStyle: TextStyle(
                            color: Colors.black45,
                            letterSpacing: 0.0,
                            fontSize: 15,
                            fontFamily: "OpenSans"),
                        border: InputBorder.none,
                        // prefixIcon:  Padding(
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
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 123,
            width: 480,
            child: Column(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
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
                                    "1",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontFamily: "OpenSans"),
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
                                        fontSize: 11,
                                        fontFamily: "OpenSans"),
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
                                    "3",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontFamily: "OpenSans"),
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
                      SizedBox(
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
                                      // fontSize: 11,
                                      // fontFamily: "OpenSans"
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
                                        fontSize: 11,
                                        fontFamily: "OpenSans"),
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
                                        fontSize: 11,
                                        fontFamily: "OpenSans"),
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
                                    "Wale",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontFamily: "OpenSans"),
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
                      SizedBox(
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
                                      // fontSize: 14,
                                      // fontFamily: "OpenSans"
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
                                    "Olawale",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontFamily: "OpenSans"),
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
                                        fontSize: 11,
                                        fontFamily: "OpenSans"),
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
                                        fontSize: 11,
                                        fontFamily: "OpenSans"),
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
                      SizedBox(
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
                                      // fontSize: 11,
                                      // fontFamily: "OpenSans"
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
                                        fontSize: 11,
                                        fontFamily: "OpenSans"),
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
                                    "Joy",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontFamily: "OpenSans"),
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
                                        fontSize: 11,
                                        fontFamily: "OpenSans"),
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
                                    "0129239387",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontFamily: "OpenSans"),
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
                                      fontFamily: "OpenSans",
                                      fontSize: 11,
                                      //fontFamily: "OpenSans"
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
                                    "1234567890",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontFamily: "OpenSans"),
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
                ),
              ],
            ),
            color: Colors.black26,
          ),
          const SizedBox(
            height: 200,
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
  }

  void getListCollections(int loginuserid) {
    ServiceClass serviceClass = ServiceClass();
    serviceClass.getTransactionList(loginuserid).then((value) => value);
  }
}
