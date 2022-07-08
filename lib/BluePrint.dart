import 'dart:convert';
import 'dart:math';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
//import 'package:flutter_blue/gen/flutterblue.pb.dart';
import 'package:provider/provider.dart';
import 'package:teller/checkmessage.dart';
import 'package:teller/succes.dart';
import 'package:teller/teller.dart';
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
import 'package:intl/intl.dart';
import 'models.dart';


class BluePrint{
  BluePrint({this.chunk = 512});
  final int chunk;
  final data = List<int>.empty(growable: true);
  void addDevice(List<int> _data){
    data.addAll(_data);
  }

  List<List<int>> getChunks(){
    final mychunks = List<List<int>>.empty(growable: true);
    for(var i = 0; i < data.length; i += chunk){
      mychunks.add(data.sublist(i, min(i + chunk, data.length)));
    }
    return mychunks;
  }

  Future<void> printData(BluetoothDevice device)async{
    final mydata = getChunks();
    final charaxs = await getCharaxs(device);
    for (var i = 0; i < charaxs.length; i++){
      if(await tryPrint(charaxs[i], mydata)){
        break;
      }
    }
  }

  Future<bool> tryPrint(BluetoothCharacteristic charac, List<List<int>> data,)async{
    for(var i = 0; i < data.length; i++){
      try{
        await charac.write(data[i]);
      }
      catch(e){
        return false;
      }
    }
    return true;
  }

  Future<List<BluetoothCharacteristic>>getCharaxs(BluetoothDevice device)async{
    final _services = await device.discoverServices();
    final _response = List<BluetoothCharacteristic>.empty(growable: true);
    for(var i = 0; i < _services.length; i++){
      _response.addAll(_services[i].characteristics);
    }
    return _response;
  }
}
