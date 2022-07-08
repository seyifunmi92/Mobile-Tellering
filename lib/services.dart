import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:teller/welcome.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:teller/signup.dart';
import 'package:teller/models.dart';
import 'package:teller/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teller/shared.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';



class ServiceClass extends ChangeNotifier {
  String BaseUrl = "http://41.184.40.66:5559/swagger/index.html?urls.primaryName=Mobile%20Tellering%20Channel";
  int CurrentIndex = 0;
  bool iscConnected = false;
  bool _loggedIn = false;
  bool isSuccessful = false;

  late UserRegistration TellerUsers = UserRegistration(
    email: "",
    phoneno: "",
    securedkey: "",
  );

  late FundMobileTeller fundTellernow = FundMobileTeller(
    loginUserId: 0,
    fundingrequesid: "",
  );

  late login MyLogin = login(
    username: "",
    password: "",
  );

  late MobileTellerFund Myrequest = MobileTellerFund(
    loginUserId: 0,
    requestedamount: 0,
  );

  void notifyFundiing(FundMobileTeller funding){
    fundTellernow = funding;
    notifyListeners();
  }

  // get loginUserid => null;

  void notifySignin(UserRegistration tellerUser) {
    TellerUsers = tellerUser;
    notifyListeners();
  }
  void notifyLogin(login _myLogin) {
    MyLogin = _myLogin;
    notifyListeners();
  }
  void notifyTeller(MobileTellerFund _request) {
    Myrequest = _request;
    notifyListeners();
  }

  Future<UserRegistration?> userRegistration(String email, String Phoneno,
      {String? securedKey}) async {
    UserRegistration? result;
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = {
      HttpHeaders.authorizationHeader: "Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiNjk4ODYxIiwiZXhwIjoxNjU1MjQwODM1LCJpc3MiOiJjbGlxYXV0b21hdGlvbnNlcnZpY2VzIiwiYXVkIjoiY2xpcW1pY3Jvc2VydmljZXMifQ.5wyQ1YHIkLU05berxeXDgsZI8D0QDyTPE7W9pMJm6q4",
      "Content-Type": "application/json",
    };
    try {
      print(userRegistration);
      var mydata = jsonEncode(<String, Object>{
        "email": email,
        "phoneno": Phoneno,
        "securedKey": "oLymp!12",
      }
      );
      print("We are inside Signup now");
      var url = Uri.parse(
          BaseUrl + "/MobileTeller/PostECliqMobileTellerUserRegistration");
      http.Response myresponse = (await http.post(
          url, body: mydata, headers: headers));
      print(myresponse);
      print(url);
      print("Hello Seyi this is the response - ${myresponse}");
      print("Hello Seyi this is the response - ${myresponse.body}");
      if (myresponse.statusCode == 200) {
        var _body = json.decode(myresponse.body);
        result = UserRegistration.fromJson(_body);
        print("Hello Seyi this is the response - ${myresponse.body}");
        print("We are all good...response is 200");
        print(myresponse.body);
        print(myresponse.statusCode);
      }
      else {
        print("Hello Seyi this is the response - ${myresponse.body}");
        print(myresponse.body);
        print("This is the instance now seyi - ${myresponse.body}");
        print("not successful bro");
      }
    }
    catch (myerror) {
      print("Error messages now");
      //return myerror.message;
    }
    return result;
  }
  Future<ResponseObject> userReg(String email, String Phoneno,String corebankingid, {String? securedkey}) async {
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = <String, String>{
      HttpHeaders
          .authorizationHeader: "Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiNjk4ODYxIiwiZXhwIjoxNjU3MTI2OTU1LCJpc3MiOiJjbGlxYXV0b21hdGlvbnNlcnZpY2VzIiwiYXVkIjoiY2xpcW1pY3Jvc2VydmljZXMifQ.8hb3Imt2JvWjKTJ4EMIBGaDsWULnVWIEyLxMxYosSyo",
      "Content-Type": "application/json",
    };
    ResponseObject responseObject;
    var mydata = jsonEncode(<String, Object>{
      "email": email,
      "phoneno": Phoneno,
      "securedKey": "oLymp!12",
      "corebankingid": corebankingid,
    });
    var url = Uri.parse(
        BaseUrl + "/MobileTeller/PostECliqMobileTellerUserRegistration");
    final response = await http.post(url, body: mydata, headers: headers);
    if (response.statusCode == 200) {
      print("Hello seyi,this is the response - ${response.body}");
      print(response);
      responseObject = ResponseObject(responseBody: response.body, responseCode: response.statusCode);
      return responseObject;
      // print("We are all good now bro....${response.body}");
      // final seyidata = jsonDecode(response.body);
      // print(seyidata);
      // return UserRegistration.fromJson(seyidata);
    }
    else {
      responseObject = ResponseObject(responseBody: "Network Error", responseCode: 700);
      print("Hello Seyi, This is not successful bro");
      print(response.body);
      print(response);
      throw Exception("Not Successful");
    }
  }

  Future<ResponseLogin> myLogin(String username, String password) async {
    String BaseUrl = "http://41.184.40.66:5559/api/v1";
    var headers = <String, String>{
      HttpHeaders
          .authorizationHeader: "Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiODk0NjQzIiwiZXhwIjoxNjU2NTc2MDcyLCJpc3MiOiJjbGlxYXV0b21hdGlvbnNlcnZpY2VzIiwiYXVkIjoiY2xpcW1pY3Jvc2VydmljZXMifQ.H39a3s6a99Ey-hbqW70p7gKwM-L9JM7n_9-t0SgA_lQ",
      "Content-Type": "application/json",
    };
    ResponseLogin responseLogin;
    var mydata = jsonEncode(<String, Object>{
      "username": username,
      "password": password,
      //"securedKey" : "oLymp!12",
    });
    var url = Uri.parse(BaseUrl + "/Account/jwt-appadmintoken");
    final response = await http.post(url, body: mydata, headers: headers);
    if (response.statusCode == 200) {
      print("Hello seyi,this is the response - ${response.body}");
      print(response);
      responseLogin = ResponseLogin(responseBody: response.body, responseCode: response.statusCode);
      print("We are all good now bro....${response.body}");
      return responseLogin;
      // final seyidata = jsonDecode(response.body);
      // print(seyidata);
      // return login.fromJson(seyidata);
    }
    else {
      responseLogin = ResponseLogin(responseBody: "Network Error", responseCode: 700);
      print("Hello Seyi, This is not successful bro");
      print(response.body);
      print(response);
      throw Exception("Not Successful");
    }
  }

  Future<ResponseTeller> requestTeller(int loginUserId,
      int requestedamount) async {
    SharedPreferences mypref = await SharedPreferences.getInstance();
    String? token = mypref.getString("Token");
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = <String, String>{
      HttpHeaders
          .authorizationHeader: "Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiNDI0NjAxIiwiZXhwIjoxNjU3MTM5NTQ4LCJpc3MiOiJjbGlxYXV0b21hdGlvbnNlcnZpY2VzIiwiYXVkIjoiY2xpcW1pY3Jvc2VydmljZXMifQ.knbPtJy35JwZgTZXnwsPKPmuqKUcLV2g4FCm6gOElX0",
      "Content-Type": "application/json",
    };
    ResponseTeller responseTeller;
    var mydata = jsonEncode(<String, Object>{
      "loginUserId": loginUserId,
      "requestedamount": requestedamount,
    });
    var url = Uri.parse(
        BaseUrl + "/MobileTeller/PosteCliqRequestMobileTellerFund");
    final response = await http.post(url, body: mydata, headers: headers);
    if (response.statusCode == 200) {
      //succesfulSignUp();
      print("Hello seyi,this is the response - ${response.body}");
      print(response);
      responseTeller = ResponseTeller(responseBody: response.body,responseCode: response.statusCode);
      print("We are all good now bro....${response.body}");
      //final seyidata = jsonDecode(response.body);
      //print(seyidata);
     return responseTeller;
    }
    else {
      responseTeller = ResponseTeller(responseBody: "Network Error", responseCode: 700);
      print("Hello Seyi, This is not successful bro");
      print(response.body);
      print(response);
      throw Exception("Not Successful");
    }
  }

  Future<MobileTellerRequestList> TellerRequest(int loginUserId) async {
    SharedPreferences mypref = await SharedPreferences.getInstance();
    String? token = mypref.getString("Token");
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = <String, String>{
      HttpHeaders
          .authorizationHeader: "Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiNDI0NjAxIiwiZXhwIjoxNjU3MTM2MDM2LCJpc3MiOiJjbGlxYXV0b21hdGlvbnNlcnZpY2VzIiwiYXVkIjoiY2xpcW1pY3Jvc2VydmljZXMifQ.W7EpuAUR9R1UvjVOnMQfzpMVPAHTVSANVdPcgSN9TDQ",
      "Content-Type": "application/json",
    };
    Map<String, int> queryParams = {
      'loginUserId': loginUserId,
    };
    MobileTellerRequestList mobileTellerRequestList;
    var url = Uri.parse(
        BaseUrl + "/MobileTeller//api/v8/MobileTeller/GeteCliqMobileTellerRequestList" + "?" + queryParams.toString());
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      print("Hello seyi,this is the response - ${response.body}");
      print(response);
      //mobileTellerRequestList = MobileTellerRequestList();
      print("We are all good now bro....${response.body}");
      final seyidata = jsonDecode(response.body);
      print(seyidata);
      return MobileTellerRequestList.fromJson(seyidata);
    }
    else {
      print("Hello Seyi, This is not successful bro");
      print(response.body);
      print(response);
      throw Exception("Not Successful");
    }
  }

  Future<ResponseTeller> RequestFund(int loginUserId,
      String fundingrequesid) async {
    SharedPreferences mypref = await SharedPreferences.getInstance();
    String? token = mypref.getString("Token");
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = <String, String>{
      HttpHeaders
          .authorizationHeader: "Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiNDI0NjAxIiwiZXhwIjoxNjU3MTM5NTQ4LCJpc3MiOiJjbGlxYXV0b21hdGlvbnNlcnZpY2VzIiwiYXVkIjoiY2xpcW1pY3Jvc2VydmljZXMifQ.knbPtJy35JwZgTZXnwsPKPmuqKUcLV2g4FCm6gOElX0",
      "Content-Type": "application/json",
    };
    ResponseTeller responseTeller;
    var mydata = jsonEncode(<String, Object>{
      "loginUserId": loginUserId,
      "fundingrequesid": "3fa85f64-5717-4562-b3fc-2c963f66afa6",
    });
    var url = Uri.parse(
        BaseUrl + "/MobileTeller/PosteCliqRequestMobileTellerFund");
    final response = await http.post(url, body: mydata, headers: headers);
    if (response.statusCode == 200) {
      //succesfulSignUp();
      print("Hello seyi,this is the response - ${response.body}");
      print(response.statusCode);
      print(response.body);
      print(response);
      responseTeller = ResponseTeller(responseBody: response.body,responseCode: response.statusCode);
      print("We are all good now bro....${response.body}");
      //final seyidata = jsonDecode(response.body);
      //print(seyidata);
      return responseTeller;
    }
    else {
      responseTeller = ResponseTeller(responseBody: "Network Error", responseCode: 700);
      print("Hello Seyi, This is not successful bro");
      print(response.body);
      print(response);
      throw Exception("Not Successful");
    }
  }

}



