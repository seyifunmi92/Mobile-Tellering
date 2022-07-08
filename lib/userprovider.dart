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


class UserProvider extends ChangeNotifier{
  UserRegistration _userprovider = UserRegistration();
  UserRegistration get userprovider => _userprovider;
  void setUser(UserRegistration userprovider){
    _userprovider = userprovider;
    notifyListeners();
  }
}