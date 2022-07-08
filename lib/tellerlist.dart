import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
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
  void setFuture (){
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
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Teller Request List",style: TextStyle(
          fontFamily: "OpenSans",
          fontSize: 18,
          //color: Colors.red,
        ),),
      ),
      body: FutureBuilder<List<MobileTellerRequestList>>(
        future: tellerrequestList,
        builder: (context, snapshot){
          print("This-  ${snapshot.data}");
          if(snapshot.connectionState == ConnectionState.waiting){
            return  Column(
              children: const [
                CircularProgressIndicator(),
                SizedBox(height: 20,),
                Text("Please Wait"),
              ],
            );
          }
          else if(snapshot.hasError){
            return const Text("Error Loading list, please try again");
          }
          else if(snapshot.hasData){
            var mydata = snapshot.data!.length;
            return ListView.builder(
              itemCount: mydata,
              itemBuilder: (BuildContext context, int index){
                MobileTellerRequestList _users = snapshot.data![index];
                return  Card(
                  child: ListTile(
                    title: Column(
                      children: [
                        const SizedBox(height: 10,),
                        Row(
                          children: [
                             const Text("Loginuserid  :                 ",
                            style: TextStyle(
                              fontFamily: "OpenSans",
                              fontSize: 13,
                              color: Colors.grey,
                            ),
                            ),
                            Text(_users.loginUserId.toString(),
                                style: const TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 13,
                                  color: Colors.grey,
                                )
                            ),
                          ],
                        ),
                        const SizedBox(height: 0.5,),
                        Row(
                          children: [
                            const Text("Requested Amount  :    ",
                                style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 13,
                                  color: Colors.grey,
                                )
                            ),

                            Text(_users.requestedamount.toString(),
                                style: const TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 13,
                                  color: Colors.grey,
                                )
                            ),
                          ],
                        ),
                        const SizedBox(height: 0.5,),
                        Row(
                          children: [
                            const Text("Created By :                      ",
                                style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 13,
                                  color: Colors.grey,
                                )
                            ),
                            Text(_users.createdBy.toString(),
                                style: const TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 13,
                                  color: Colors.grey,
                                )
                            ),
                          ],
                        ),
                        const SizedBox(height: 0.5,),
                        Row(
                          children: [
                            const Text("Approved :                      ",
                                style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 13,
                                  color: Colors.grey,
                                )
                            ),

                            Text(_users.approved.toString(),
                                style: const TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 13,
                                  color: Colors.grey,
                                )
                            ),
                          ],
                        ),
                        const SizedBox(height: 0.5,),
                        Row(
                          children: [
                            const Text("Status :                            ",
                                style: TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 13,
                                  color: Colors.grey,
                                )
                            ),

                            Text(_users.status.toString(),
                                style: const TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 13,
                                  color: Colors.grey,
                                )
                            ),
                          ],
                        ),
                        const SizedBox(height: 0.5,),
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
                                  fontSize: 13,
                                  color: Colors.grey,
                                )
                            ),

                            Text(_users.createdate.toString(),
                                style: const TextStyle(
                                  fontFamily: "OpenSans",
                                  fontSize: 13,
                                  color: Colors.grey,
                                )
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                      ],
                    ),

                    subtitle: Text("Funding Request Id -                ${_users.id.toString()}",
                        style: const TextStyle(
                          fontFamily: "OpenSans",
                          fontSize: 10,
                          color: Colors.red,
                        ),
                    ),
                  ),
                );
              },
            );
          }
          else{
            return Text("This is the ${snapshot.error}");
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> const Success()));
        },
        child: const Text("Back"),
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

  Future<List<MobileTellerRequestList>> myTellerRequest(int loginUserId) async {
    SharedPreferences mypref = await SharedPreferences.getInstance();
    String? token = mypref.getString("Token");
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = <String, String>{
      HttpHeaders
          .authorizationHeader: "Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiNDI0NjAxIiwiZXhwIjoxNjU3MTM5NTQ4LCJpc3MiOiJjbGlxYXV0b21hdGlvbnNlcnZpY2VzIiwiYXVkIjoiY2xpcW1pY3Jvc2VydmljZXMifQ.knbPtJy35JwZgTZXnwsPKPmuqKUcLV2g4FCm6gOElX0",
      "Content-Type": "application/json",
    };
    // Map<String, int> queryParams = {
    //   'loginUserId': loginUserId,
    // };
    MobileTellerRequestList mobileTellerRequestList;
    var url = Uri.parse(
        BaseUrl + "/MobileTeller/GeteCliqMobileTellerRequestList?loginuserid=$loginUserId");
    final response = await http.get(url, headers: headers);
    print("This - ${response.body}");
    if (response.statusCode == 200) {
      var myresponse = jsonDecode(response.body);
      List<MobileTellerRequestList> _list = [];
      for(var u in myresponse){
        _list.add(MobileTellerRequestList.fromJson(u));
      }
      print(_list);
      print(_list.length);
      print("Hello seyi,this is the response - ${response.body}");
      print("We are all good now bro....${response.body}");
      return _list;
    }
    else {
      print("Hello Seyi, This is not successful bro");
      print(response.body);
      print(response);
      throw Exception("Not Successful");
    }
  }
}

