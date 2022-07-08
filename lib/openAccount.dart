import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:teller/cashDepostit.dart';
import 'package:teller/welcome.dart';
import 'package:teller/welcome.dart';
import 'package:teller/services.dart';
import 'package:teller/constants.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:teller/textstyle.dart';
import 'package:teller/login.dart';
import 'package:teller/teller.dart';
import 'package:teller/customer.dart';
import 'package:teller/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teller/widgets/appbar.dart';
import 'models.dart';
import 'package:teller/widgets/appbar.dart';

class OpenAccount extends StatefulWidget {
  int userId;
  OpenAccount(this.userId);

  @override
  _OpenAccountState createState() => _OpenAccountState();
}

class _OpenAccountState extends State<OpenAccount>
    with SingleTickerProviderStateMixin {
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

  List<Tellertransaction> myData = [];
  late Future<List<Tellertransaction>> myDatay;

  setFuture() {
    myDatay = getListCollections(widget.userId);
  }

  late AnimationController anicontroller;

  final _format = NumberFormat("#,###,000");
  GetBalance? customerBalance;
  bool showData = false;
  bool showBalance = false;
  bool loading = false;
  bool userData = true;
  @override
  void initState() {
    setState(() {
      loading = true;
    });
    anicontroller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    anicontroller.repeat();
    print("seyiaraaa");
    //setFuture();
    getListCollections(widget.userId);
    super.initState();
  }

  @override
  void dispose() {
    anicontroller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    //print("Welcome seyi.. device width - $_width");
    return loading
        ? _filterDialog(context)
        : Scaffold(
            backgroundColor: kBackgroundHome2,
            appBar: TellerAppBar(
              context, "List Of Daily Collections",
              //      actions: [
              //   InkWell(
              //     onTap: () {},
              //     child: Icon(Icons.search_sharp),
              //   )

              // ]
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: _width * .01),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .02,
                  ),
                  Expanded(
                      child: ListView.builder(
                    itemCount: myData.length,
                    itemBuilder: (BuildContext context, int index) {
                      var _transData = myData[index];
                      return Padding(
                        padding: EdgeInsets.only(
                          bottom: _height * .01,
                        ),
                        child: Card(
                          color: Colors.transparent,
                          child: Container(
                            height: _height * .24,
                            width: _width * .92,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurStyle: BlurStyle.outer,
                                  blurRadius: 5,
                                  spreadRadius: 0,
                                  offset: Offset.zero,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            //color: Colors.black12,
                            //height: 230,
                            child: InkWell(
                              onTap: () {},
                              child: Center(
                                // tileColor: Colors.amber,
                                //cor: Colors.black12,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      _width * .04,
                                      _height * .012,
                                      _width * .04,
                                      _height * .012),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Cash Deposit",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                fontSize: _height * .019,
                                                color: kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: _height * .01,
                                      ),
                                      DottedLine(
                                        dashColor:
                                            kPrimaryColor.withOpacity(0.2),
                                      ),
                                      SizedBox(
                                        height: _height * .01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Account Number",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: _height * .013,
                                                color: kPrimaryColor),
                                          ),
                                          Text(
                                            _transData.toAccountNumber
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: _height * .013,
                                                color: kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: _height * .01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Account Name",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: _height * .013,
                                                color: kPrimaryColor),
                                          ),
                                          Text(
                                            _transData.toAccountName.toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: _height * .013,
                                                color: kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: _height * .01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Amount",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: _height * .013,
                                                color: kPrimaryColor),
                                          ),
                                          Text(
                                            "N ${_format.format(_transData.amount)}.00",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: _height * .013,
                                                color: kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: _height * .01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Narration",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: _height * .013,
                                                color: kPrimaryColor),
                                          ),
                                          Text(
                                            _transData.naration.toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: _height * .013,
                                                color: kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: _height * .01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Transaction Reference",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: _height * .013,
                                                color: kPrimaryColor),
                                          ),
                                          Text(
                                            _transData.transactionReference
                                                .toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: _height * .013,
                                                color: kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: _height * .01,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Date",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: _height * .013,
                                                color: kPrimaryColor),
                                          ),
                                          Text(
                                            "${_transData.createdate!.day}-${_transData.createdate!.month}-${_transData.createdate!.year}",
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontSize: _height * .013,
                                                color: kPrimaryColor),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ))
                ],
              ),
            ));
  }

  getListCollections(int loginuserid) async {
    ServiceClass serviceClass = ServiceClass();
    serviceClass.getTransactionList(loginuserid).then((value) => output(value));
  }

  void output(String myresponse) {
    //if(myresponse.co)
    print("Yeahgaaa");
    print(myresponse);
    print("this has happend");
    if (myresponse.contains("amount")) {
      var bodyT = jsonDecode(myresponse);
      print(bodyT);
      dynamic value = bodyT;
      setState(() {
        loading = false;
        myData = value
            .map<Tellertransaction>((e) => Tellertransaction.fromJson(e))
            .toList();
        print(myData[0].naration);
      });
    } else {
      showMessage("An error encountered...");
      setState(() {
        loading = false;
      });
    }
  }

  Widget _filterDialog(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    var containerheight = _height * .354;
    var _mypadding = SizedBox(height: containerheight * .12);
    return Scaffold(
      //backgroundColor: Colors.black45,
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
}
