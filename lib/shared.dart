import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teller/newservice.dart';
import 'package:teller/welcome.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:teller/signup.dart';
import 'package:teller/models.dart';
import 'package:teller/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teller/userprovider.dart';

class SavedData{
 Future<String?> getToken(args)async{
   SharedPreferences myPref = await SharedPreferences.getInstance();
   String? token = myPref.getString("token");
   return token;
 }
 Future<bool?> saveUser(UserRegistration user)async{
   SharedPreferences myPref = await SharedPreferences.getInstance();
   myPref.setString("email", user.email.toString());
   myPref.setString("phoneno", user.phoneno.toString());
   myPref.setString("securedkey", user.securedkey.toString());
 }

 Future<UserRegistration?>getUser(String email, String phoneno, String securedkey)async{
   SharedPreferences myPref = await SharedPreferences.getInstance();
   String? email = myPref.getString("email");
   String? phoneno = myPref.getString("phoneno");
   String? securedkey = myPref.getString("securedkey");
 }

void removeUser()async {
  SharedPreferences myPref = await SharedPreferences.getInstance();
  myPref.remove("email");
  myPref.remove("phoneno");
  myPref.remove("securedkey");
}
}