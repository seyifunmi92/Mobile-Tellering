import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teller/checkmessage.dart';
import 'package:teller/fundteller.dart';
import 'package:teller/models.dart';
import 'package:teller/tellerlist.dart';
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
import 'package:teller/fundteller.dart';

class Success extends StatefulWidget {
  const Success({Key? key}) : super(key: key);

  @override
  _SuccessState createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Mobile Teller Request",
          style: TextStyle(
            fontFamily: "OpenSans",

          ),
        ),
        centerTitle: true,
      ),

      body: Column(
        children:  [
          const SizedBox(height: 50,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Congratulations ",
                style: TextStyle(
                  fontFamily: "OpenSans",
                  color: Colors.blueGrey,
                  fontSize: 20,
                ),
              ),
              Icon(
                Icons.assignment_turned_in,
                color: Colors.redAccent,
              ),
            ],
          ),

          const SizedBox(height: 50,),

          GestureDetector(
            onTap: (){},

            child:  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text("Your Request for \$200,000 has been approved",
                  style: TextStyle(fontFamily: "OpenSans",
                    color: Colors.blueGrey,
                    fontSize: 14,
                  ),
                ),




              ],
            ),
          ),
          const SizedBox(height: 20,),
          const Text("Please proceed",
            style: TextStyle(fontFamily: "OpenSans",
              color: Colors.blueGrey,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 70,),
          containerCustom(MobileTellerRequestList(loginUserId: 424601)),
          // Container(
          //   height: 40,
          //   width: 350,
          //   decoration: BoxDecoration
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
          //       tileMode: TileMode
          //           .repeated, // repeats the gradient over the canvas
          //     ),
          //     borderRadius: BorderRadius.circular(5),
          //   ),
          //   child: InkWell(
          //     onTap: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context)=> TellerList()));
          //     } ,
          //     child: const Center(
          //       child: Text(
          //         'PROCEED TO CHECK REQUEST LIST',
          //         style: TextStyle(
          //           fontFamily: "OpenSans",
          //           color: Colors.white,
          //           letterSpacing: 3.0,
          //           fontSize: 10,
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),

          const SizedBox(height: 380,),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> WalletFund()));

            },
            child:  Column(
              children: const [
                Text("Back",
                  style: TextStyle(fontFamily: "OpenSans",
                    color: Colors.blueGrey,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),

    );
  }
  Widget containerCustom(MobileTellerRequestList mylist) => Container(
    height: 40,
    width: 350,
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
    ),
    child: InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => TellerList(mylist.loginUserId!)));
        //getTeller();
      },
  child:  const Center(
            child: Text(
              'PROCEED TO CHECK REQUEST LIST',
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
    );

}
