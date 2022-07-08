import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teller/checkmessage.dart';
import 'package:teller/fundteller.dart';
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
import 'package:teller/teller.dart';
import 'models.dart';

class TellerList extends StatefulWidget {
  int ID;
  TellerList(this.ID);

  @override
  _TellerListState createState() => _TellerListState();
}

class _TellerListState extends State<TellerList> {
  late Future<List<MobileTellerRequestList>> tellerrequestList;
  void setFuture() {
    tellerrequestList = myTellerRequest(widget.ID);
  }

  @override
  void initState() {
    setFuture();
    //getTellerList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Teller Request List",
          style: TextStyle(
            fontFamily: "OpenSans",
            fontSize: 18,
            //color: Colors.red,
          ),
        ),
      ),
      body: FutureBuilder<List<MobileTellerRequestList>>(
        future: tellerrequestList,
        builder: (context, snapshot) {
          //print("This-  ${snapshot.data}");
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: _height * .4,
                  ),
                  const CircularProgressIndicator(
                    strokeWidth: 10,
                    semanticsLabel: ("Please Wait"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Loading...",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontFamily: "OpenSans",
                      letterSpacing: 0,
                      //fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  SizedBox(
                    height: _height * .4,
                  ),
                  const CircularProgressIndicator(
                    strokeWidth: 10,
                    semanticsLabel: ("Please Wait"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Loading...",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 20,
                      fontFamily: "OpenSans",
                      letterSpacing: 0,
                      //fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            );
          } else if (snapshot.hasData) {
            var mydata = snapshot.data!.length;
            return ListView.builder(
              itemCount: mydata,
              itemBuilder: (BuildContext context, int index) {
                MobileTellerRequestList _users = snapshot.data![index];
                return Card(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  FundTeller(_users.loginUserId!, _users.id!)));
                    },
                    child: ListTile(
                      title: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              const Text(
                                "Loginuserid  :                 ",
                                style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 16,
                                  color: Colors.grey,
                                ),
                              ),
                              Text(_users.loginUserId.toString(),
                                  style: const TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 16,
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 0.5,
                          ),
                          Row(
                            children: [
                              const Text("Requested Amount  :    ",
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 16,
                                    color: Colors.grey,
                                  )),
                              Text('₦${_users.requestedamount.toString()}0',
                                  style: const TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 16,
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 0.5,
                          ),
                          Row(
                            children: [
                              const Text("Created By :                    ",
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 16,
                                    color: Colors.grey,
                                  )),
                              Text(_users.createdBy.toString(),
                                  style: const TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 16,
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 0.5,
                          ),
                          Row(
                            children: [
                              const Text("Approved :                      ",
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 16,
                                    color: Colors.grey,
                                  )),
                              Text(_users.approved.toString(),
                                  style: const TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 16,
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 0.5,
                          ),
                          Row(
                            children: [
                              const Text("Status :                            ",
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 16,
                                    color: Colors.grey,
                                  )),
                              Text(_users.status.toString(),
                                  style: const TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 16,
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 0.5,
                          ),
                          // Row(
                          //   children: [
                          //     const Text("Funding request id :",
                          //         style: TextStyle(
                          //           fontFamily: "OpenSans",
                          //           fontSize: 10,
                          //           color: Colors.red,
                          //         )
                          //     ),
                          //
                          //     Text(_users.id.toString(),
                          //         style: const TextStyle(
                          //           fontFamily: "OpenSans",
                          //           fontSize: 10,
                          //           color: Colors.red,
                          //         )
                          //     ),
                          //   ],
                          // ),
                          Row(
                            children: [
                              const Text("Date Created :               ",
                                  style: TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 16,
                                    color: Colors.grey,
                                  )),
                              Text(_users.createdate.toString(),
                                  style: const TextStyle(
                                    fontFamily: "OpenSans",
                                    fontSize: 16,
                                    color: Colors.grey,
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                      // subtitle: Column(
                      //   children: [
                      //     Row(
                      //       children: [
                      //         // Text(
                      //         //   "Funding Request Id -              ${_users.id.toString()}",
                      //         //   style: const TextStyle(
                      //         //     fontFamily: "OpenSans",
                      //         //     fontSize: 10,
                      //         //     color: Colors.red,
                      //         //   ),
                      //         // ),
                      //       ],
                      //     ),
                      //     const SizedBox(
                      //       height: 20,
                      //     ),
                      //     Row(
                      //       children: [
                      //         textCustom(RequestDetail(
                      //             loginUserId: _users.loginUserId,
                      //             id: _users.id)),
                      //         // InkWell(
                      //         //   onTap: () {
                      //         //     Navigator.push(
                      //         //         context,
                      //         //         MaterialPageRoute(
                      //         //             builder: (context) => FundTeller()));
                      //         //   },
                      //         //   child: const Text(
                      //         //     "Request Detail",
                      //         //     style: TextStyle(
                      //         //       fontSize: 12,
                      //         //       letterSpacing: 1.0,
                      //         //       fontFamily: "OpenSans",
                      //         //       color: Colors.black54,
                      //         //     ),
                      //         //   ),
                      //         // ),
                      //       ],
                      //     ),
                      //   ],
                      // ),
                      // trailing: InkWell(
                      //   onTap: (){},
                      //   child: const Text("Request Detail",
                      //   style: TextStyle(
                      //     fontSize: 5,
                      //   ),
                      //   ),
                      // ),
                    ),
                  ),
                );
              },
            );
          } else {
            return Text("This is the ${snapshot.error}");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => const Teller()));
        },
        child: const Text(
          "Back",
          style: TextStyle(
            fontFamily: "OpenSans",
            fontWeight: FontWeight.bold,
            color: Colors.amberAccent,
          ),
        ),
      ),
    );
  }

  // void getTeller() {
  //   print("hello seyi araoluwa");
  //   print("We are In Teller Request now oo now...");
  //   ServiceClass serviceClass = ServiceClass();
  //   serviceClass.TellerRequest().then((value) =>
  //       MaterialPageRoute(builder: (context) => TellerList()));
  // }
  // getTellerList(int loginUserId) {
  //   print("hello seyi ara of lagos");
  //   print("We are In Teller Request Listing now oo now...");
  //   ServiceClass serviceClass = ServiceClass();
  //   serviceClass.TellerRequest(loginUserId).then((value) =>
  //       MaterialPageRoute(builder: (context) => TellerList()));
  // }
  Widget textCustom(RequestDetail myrequest) => InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      FundTeller(myrequest.loginUserId!, myrequest.id!)));
        },
        child: const Text(
          "View Details",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 12,
            fontFamily: "OpenSans",
            letterSpacing: 0,
            fontWeight: FontWeight.bold,
            //fontStyle: FontStyle.italic,
          ),
        ),
      );

  Future<List<MobileTellerRequestList>> myTellerRequest(int loginUserId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("Token");
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Content-Type": "application/json",
    };
    MobileTellerRequestList mobileTellerRequestList;
    var url = Uri.parse(BaseUrl +
        "/MobileTeller/GeteCliqMobileTellerRequestList?loginuserid=$loginUserId");
    final response = await http.get(url, headers: headers);
    print("This - ${response.body}");
    if (response.statusCode == 200) {
      var myresponse = jsonDecode(response.body);
      List<MobileTellerRequestList> _list = [];
      for (var u in myresponse) {
        _list.add(MobileTellerRequestList.fromJson(u));
      }
      print("We are all good now bro...Flex on and chop rice");
      return _list;
    } else {
      print("Hello Seyi, This is not successful bro");
      print(response.body);
      throw Exception("Not Successful");
    }
  }
}
