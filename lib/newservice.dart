import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teller/welcome.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:teller/signup.dart';
import 'package:teller/models.dart';
import 'package:teller/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teller/shared.dart';


class User {
  int? userId;
  String? name;
  String? email;
  String? phone;
  String? type;
  String? token;
  String? renewalToken;

  User({this.userId, this.name, this.email, this.phone, this.type, this.token, this.renewalToken});

  factory User.fromJson(Map<String, dynamic> responseData) {
    return User(
        userId: responseData['id'],
        name: responseData['name'],
        email: responseData['email'],
        phone: responseData['phone'],
        type: responseData['type'],
        token: responseData['access_token'],
        renewalToken: responseData['renewal_token']
    );
  }
}
enum Status {
  loggedIn,
  notLoggedIn,
  registered,
  authenticating,
  registering,
  loggedOut,
  notRegistered,
  authenticated,
}

class NewService extends ChangeNotifier{
  String BaseUrl = "http://41.184.40.66:5559/api/v8";
  Status _loggedInStatus = Status.notLoggedIn;
  Status _registeredStatus = Status.notRegistered;
  Status get loggedInStatus => _loggedInStatus;
  Status get registeredStatus => _registeredStatus;



  Future<Map<String, dynamic>> login(String email, String password)async{
    var headers = {
      HttpHeaders.authorizationHeader: "Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiNjk4ODYxIiwiZXhwIjoxNjU1MjQwODM1LCJpc3MiOiJjbGlxYXV0b21hdGlvbnNlcnZpY2VzIiwiYXVkIjoiY2xpcW1pY3Jvc2VydmljZXMifQ.5wyQ1YHIkLU05berxeXDgsZI8D0QDyTPE7W9pMJm6q4",
      "Content-Type" : "application/json",
    };
    var myresult;
    final Map<String, dynamic> loginData = {
      "email" : email,
      "password" : password,
    };
    _loggedInStatus = Status.authenticating;
    notifyListeners();
    var url = Uri.parse(BaseUrl + "/MobileTeller/PostECliqMobileTellerUserRegistration");
    http.Response myresponse = (await http.post(url, body: json.encode(loginData),headers:headers ));
    if(myresponse.statusCode == 200){
      print("Hello seyi, this is the ${myresponse.body}");
      print("Bro, we are all good, ${registeredStatus}");

      final Map<String, dynamic> responseData = json.decode(myresponse.body);
      var userData = responseData["data"];
      UserRegistration authenticateUser = UserRegistration.fromJson(userData);
      SavedData().saveUser(authenticateUser);
      _loggedInStatus = Status.loggedIn;
      notifyListeners();
      myresult = {
        "status" : true,
        "message" : "Successful",
        "user" : authenticateUser,
      };
    }
    else
      {
        var apiError = json.decode(myresponse.body)["error"];
        _loggedInStatus = Status.notLoggedIn;
        notifyListeners();

        myresult = {
          "status" : false,
          "message" : apiError,
        };
        print("Not successful bro");
        print(apiError);
        print(myresponse.body);
      }
    return myresult;
  }

  Future<http.Response> userRegister(String email, String Phoneno)async{
    var headers = {
      HttpHeaders.authorizationHeader: "Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiNjk4ODYxIiwiZXhwIjoxNjU1MjQwODM1LCJpc3MiOiJjbGlxYXV0b21hdGlvbnNlcnZpY2VzIiwiYXVkIjoiY2xpcW1pY3Jvc2VydmljZXMifQ.5wyQ1YHIkLU05berxeXDgsZI8D0QDyTPE7W9pMJm6q4",
      "Content-Type" : "application/json",
    };
    var mydata = jsonEncode(<String, Object>{
      "email" : email,
      "phoneno" : Phoneno,
      "securedKey" : "oLymp!12",
    });
    _registeredStatus = Status.registering;
    notifyListeners();
    var url = Uri.parse(BaseUrl + "/MobileTeller/PostECliqMobileTellerUserRegistration");
    http.Response response = await http.post(url, body: json.encode(mydata),headers: headers).then(onValue).catchError(onError);
    return response;
    // return await http.post(
    //   url,
    //   body: json.encode(mydata),
    //   headers: headers,
    // ).then(onValue).catchError(onError);
  }
  static Future onValue(http.Response response)async{
    var result;

    final myresponseData = json.decode(response.body);
    if(response.statusCode == 200){

      var myUserData = myresponseData["data"];
      UserRegistration authenticateUser = UserRegistration.fromJson(myUserData);
      SavedData().saveUser(authenticateUser);

      result = {
        "status" : true,
        "message" : "Successfully registered",
        "data" : authenticateUser,
      };

    }
    else{

      result = {
        "status" : false,
        "message" : "Registration failed",
        "data" : myresponseData,
      };
      print(myresponseData);
    }
  }
 static Future onError(error)async{

    print(error);
    print("This is the ${error}");
    return {
      "status" : false,
      "message" : "Registration failed",
      "data" : error,

    };
 }








}