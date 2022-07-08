import 'dart:convert';
import 'dart:math';
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
import 'package:teller/fundteller.dart';

class ServiceClass extends ChangeNotifier {
  String BaseUrl = "http://41.184.40.66:5559/api/v8";
  int CurrentIndex = 0;
  bool iscConnected = false;
  bool _loggedIn = false;
  bool isLoading = false;
  bool isSuccessful = false;
  String getStates = "Select State";
  late Responselogin tellerUser = Responselogin(
    username: "",
    role: Object,
    originalUserName: "",
    accessToken: "",
  );
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

  void notifyFundiing(FundMobileTeller funding) {
    fundTellernow = funding;
    notifyListeners();
  }

  // get loginUserid => null;

  void notifySignin(UserRegistration tellerUser) {
    TellerUsers = tellerUser;
    notifyListeners();
  }

  void notifyLogin(Responselogin _myLogin) {
    tellerUser = _myLogin;
    notifyListeners();
  }

  void notifyTeller(MobileTellerFund _request) {
    Myrequest = _request;
    notifyListeners();
  }

  void selectCountry(context, screen) {
    void finish(BuildContext context, [Object? result]) {
      if (Navigator.canPop(context)) Navigator.pop(context, result);
    }

    Navigator.push(context, MaterialPageRoute(builder: (context) => screen()));
    notifyListeners();
  }

  void getToken(String toked) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var myTok = sharedPreferences.setString("tokeny", toked);
    print("this has been stored");
    print(myTok);
    notifyListeners();
  }

  void getUserToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var myT = sharedPreferences.getString("tokeny");
    print(myT);
    notifyListeners();
  }

  Future<UserRegistration?> userRegistration(String email, String Phoneno,
      {String? securedKey}) async {
    UserRegistration? result;
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = {
      HttpHeaders.authorizationHeader:
          "Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiNjk4ODYxIiwiZXhwIjoxNjU1MjQwODM1LCJpc3MiOiJjbGlxYXV0b21hdGlvbnNlcnZpY2VzIiwiYXVkIjoiY2xpcW1pY3Jvc2VydmljZXMifQ.5wyQ1YHIkLU05berxeXDgsZI8D0QDyTPE7W9pMJm6q4",
      "Content-Type": "application/json",
    };
    try {
      print(userRegistration);
      var mydata = jsonEncode(<String, Object>{
        "email": email,
        "phoneno": Phoneno,
        "securedKey": "oLymp!12",
      });
      print("We are inside Signup now");
      var url = Uri.parse(
          BaseUrl + "/MobileTeller/PostECliqMobileTellerUserRegistration");
      http.Response myresponse =
          (await http.post(url, body: mydata, headers: headers));
      print(myresponse);

      if (myresponse.statusCode == 200) {
        var _body = json.decode(myresponse.body);
        result = UserRegistration.fromJson(_body);
        print("Hello Seyi this is the response - ${myresponse.body}");
        print("We are all good...response is 200");
        print(myresponse.body);
        print(myresponse.statusCode);
      } else {
        print("Hello Seyi this is the response - ${myresponse.body}");
        print(myresponse.body);
        print("This is the instance now seyi - ${myresponse.body}");
        print("not successful bro");
      }
    } catch (myerror) {
      print("Error messages now");
      //return myerror.message;
    }
    return result;
  }

  Future<ResponseObject> userReg(
      String email, String Phoneno, String corebankingid,
      {String? securedkey}) async {
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? _tokes = await sharedPreferences.getString("tokeny");
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $_tokes",
      "Content-Type": "application/json",
    };
    ResponseObject responseObject;
    try {
      var mydata = jsonEncode(<String, Object>{
        "email": email,
        "phoneno": Phoneno,
        "securedKey": "oLymp!12",
        "corebankingid": corebankingid,
      });
      var url = Uri.parse(
          BaseUrl + "/MobileTeller/PostECliqMobileTellerUserRegistration");
      final response = await http.post(url, body: mydata, headers: headers);
      print(response.statusCode);
      print(response.body);
      responseObject = ResponseObject(
          responseBody: response.body, responseCode: response.statusCode);
      return responseObject;
    } on SocketException catch (e) {
      responseObject =
          ResponseObject(responseBody: "Network Error", responseCode: 700);
      print("Hello Seyi, This is not successful bro");
      return responseObject;
    }
  }

  Future<ResponseLogin> myLogin(String username, String password) async {
    String BaseUrl = "http://41.184.40.66:5559/api/v1";
    var headers = <String, String>{
      HttpHeaders.authorizationHeader:
          "Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiODk0NjQzIiwiZXhwIjoxNjU2NTc2MDcyLCJpc3MiOiJjbGlxYXV0b21hdGlvbnNlcnZpY2VzIiwiYXVkIjoiY2xpcW1pY3Jvc2VydmljZXMifQ.H39a3s6a99Ey-hbqW70p7gKwM-L9JM7n_9-t0SgA_lQ",
      "Content-Type": "application/json",
    };
    ResponseLogin responseLogin;
    try {
      var mydata = jsonEncode(<String, Object>{
        "username": username,
        "password": password,
        //"securedKey" : "oLymp!12",
      });
      var url = Uri.parse(BaseUrl + "/Account/jwt-appadmintoken");
      print("mygyt");
      print(url);
      final response = await http.post(url, body: mydata, headers: headers);
      responseLogin = ResponseLogin(
          responseBody: response.body, responseCode: response.statusCode);
      return responseLogin;
    } on SocketException catch (e) {
      responseLogin =
          ResponseLogin(responseBody: "Network Error", responseCode: 700);
      print("Hello Seyi, This is not successful bro");
      return responseLogin;
    }
  }

  Future<ResponseLogin> myLoginn(String username, String password) async {
    String BaseUrl = "http://41.184.40.66:5559/api/v1";
    var headers = <String, String>{
      HttpHeaders.authorizationHeader:
          "Bearer eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTI1NiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1lIjoiODk0NjQzIiwiZXhwIjoxNjU2NTc2MDcyLCJpc3MiOiJjbGlxYXV0b21hdGlvbnNlcnZpY2VzIiwiYXVkIjoiY2xpcW1pY3Jvc2VydmljZXMifQ.H39a3s6a99Ey-hbqW70p7gKwM-L9JM7n_9-t0SgA_lQ",
      "Content-Type": "application/json",
    };
    ResponseLogin responseLogin;
    try {
      var mydata = jsonEncode(<String, Object>{
        "username": "313161",
        "password": "uwpy2083SO",
        //"securedKey" : "oLymp!12",
      });
      var url = Uri.parse(BaseUrl + "/Account/jwt-appadmintoken");
      print(url);
      final response = await http.post(url, body: mydata, headers: headers);
      responseLogin = ResponseLogin(
          responseBody: response.body, responseCode: response.statusCode);
      return responseLogin;
    } on SocketException catch (e) {
      responseLogin =
          ResponseLogin(responseBody: "Network Error", responseCode: 700);
      print("Hello Seyi, This is not successful bro");
      return responseLogin;
    }
  }

  Future<ResponseTeller> requestTeller(
      int loginUserId, int requestedamount) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("Token");
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer  $token",
      "Content-Type": "application/json",
    };
    ResponseTeller responseTeller;
    try {
      var mydata = jsonEncode(<String, Object>{
        "loginUserId": loginUserId,
        "requestedamount": requestedamount,
      });
      var url =
          Uri.parse(BaseUrl + "/MobileTeller/PosteCliqRequestMobileTellerFund");
      final response = await http.post(url, body: mydata, headers: headers);
      print(response);
      responseTeller = ResponseTeller(
          responseBody: response.body, responseCode: response.statusCode);
      print("We are all good now bro....${response.body}");

      return responseTeller;
    } on SocketException catch (e) {
      responseTeller =
          ResponseTeller(responseBody: "Network Error", responseCode: 700);
      print("Hello Seyi, This is not successful bro");
      throw Exception("Not Successful");
    }
  }

  Future<MobileTellerRequestList> TellerRequest(int loginUserId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("Token");
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Content-Type": "application/json",
    };
    Map<String, int> queryParams = {
      'loginUserId': loginUserId,
    };
    MobileTellerRequestList mobileTellerRequestList;
    var url = Uri.parse(BaseUrl +
        "/MobileTeller//api/v8/MobileTeller/GeteCliqMobileTellerRequestList" +
        "?" +
        queryParams.toString());
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      print("Hello seyi,this is the response - ${response.body}");
      print(response);
      //mobileTellerRequestList = MobileTellerRequestList();
      print("We are all good now bro....${response.body}");
      final seyidata = jsonDecode(response.body);
      print(seyidata);
      return MobileTellerRequestList.fromJson(seyidata);
    } else {
      print("Hello Seyi, This is not successful bro");
      print(response.body);
      print(response);
      throw Exception("Not Successful");
    }
  }

  Future<ResponseTeller> RequestFund(
      int loginUserId, String fundingrequesid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("Token");

    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Content-Type": "application/json",
    };
    ResponseTeller responseTeller;
    var mydata = jsonEncode(<String, Object>{
      "loginUserId": loginUserId,
      "fundingrequesid": fundingrequesid,
    });
    var url =
        Uri.parse(BaseUrl + "/MobileTeller/PosteCliqRequestMobileTellerFund");
    final response = await http.post(url, body: mydata, headers: headers);
    if (response.statusCode == 200) {
      //succesfulSignUp();
      print("Hello seyi,this is the response - ${response.body}");
      print(response.statusCode);
      print(response.body);
      print(response);
      responseTeller = ResponseTeller(
          responseBody: response.body, responseCode: response.statusCode);
      print("We are all good now bro....${response.body}");
      //final seyidata = jsonDecode(response.body);
      //print(seyidata);
      return responseTeller;
    } else {
      responseTeller =
          ResponseTeller(responseBody: "Network Error", responseCode: 700);
      print("Hello Seyi, This is not successful bro");
      print(response.body);
      print(response);
      throw Exception("Not Successful");
    }
  }

  Future<List<RequestDetail>> _tellerRequestDetail(
      int loginUserId, String fundingrequesid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("Token");
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Content-Type": "application/json",
    };
    RequestDetail requestDetail;
    var url = Uri.parse(BaseUrl +
        "/MobileTeller/GeteCliqMobileTellerRequestDetail?loginuserid=$loginUserId&fundingrequesid=$fundingrequesid");
    final response = await http.get(url, headers: headers);
    print("This - ${response.body}");
    if (response.statusCode == 200) {
      var myresponse = jsonDecode(response.body);
      List<RequestDetail> _list = [];
      for (var u in myresponse) {
        _list.add(RequestDetail.fromJson(u));
      }
      print(_list);
      print("Hello seyi,this is the response - ${response.body}");
      print("We are all good now bro....${response.body}");
      return _list;
    } else {
      print("Hello Seyi, This is not successful bro");
      print(response.body);
      throw Exception("Not Successful");
    }
  }

  Future<String> tellerRequestDetail(
      int loginUserId, String fundingrequesid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("Token");
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Content-Type": "application/json",
    };
    try {
      var url = Uri.parse(BaseUrl +
          "/MobileTeller/GeteCliqMobileTellerRequestDetail?loginuserid=$loginUserId&fundingrequesid=$fundingrequesid");
      final response = await http.get(url, headers: headers);
      print("Seyi my gee, take this, we are aall good - ${response.body}");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.body;
      }
    } on SocketException catch (e) {
      print("Error messages now ooooo");
      return "Network Error";
    }
  }

  Future<String> getBalance(int loginUserId) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("Token");
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Content-Type": "application/json",
    };
    try {
      var url = Uri.parse(BaseUrl +
          "/MobileTeller/GeteCliqMobileTellerBalance?loginuserid=$loginUserId");
      final response = await http.get(url, headers: headers);
      print("This - ${response.body}");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.body;
      }
    } on SocketException catch (e) {
      print("Error messages bruv");
      return "Network Error";
    }
  }

  Future<String> depositCash(
      int loginuserid,
      String transactionreference,
      DateTime trandate,
      String narration,
      String accountnumber,
      String acctname,
      int amount) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("Token");
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Content-Type": "application/json",
    };

    var mydata = jsonEncode(<String, Object>{
      "loginuserid": loginuserid,
      "transactionreference": transactionreference,
      "trandate": trandate.toIso8601String(),
      "narration": narration,
      "accountnumber": accountnumber,
      "acctname": acctname,
      "amount": amount,
    });
    try {
      var url =
          Uri.parse(BaseUrl + "/MobileTeller/PosteCliqMobileTellerCollection");
      final response = await http.post(url, body: mydata, headers: headers);
      print("Oluwaseyi take response - ${response.body}");
      if (response.statusCode == 200) {
        print("All good man, you are a great software engineer");
        return response.body;
      } else {
        return response.body;
      }
    } on SocketException catch (e) {
      print("Seyi no vex - e no work");
      return e.message;
    }
  }

  Future<String?> liquidateCash(
    int loginuserid,
    String transactionreference,
    DateTime trandate,
    String narration,
  ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("Token");
    String BaseUrl = "http://41.184.40.66:5559/api/v8";
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Content-Type": "application/json",
    };
    var mydata = jsonEncode(<String, Object>{
      "loginuserid": loginuserid,
      "transactionreference": transactionreference,
      "trandate": trandate.toIso8601String(),
      "narration": narration,
    });
    try {
      var url =
          Uri.parse(BaseUrl + "/MobileTeller/PosteCliqMobileTellerLiquidation");
      final response = await http.post(url, body: mydata, headers: headers);
      print("Oluwaseyimii take response - ${response.body}");
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.body;
      }
    } on SocketException catch (e) {
      print("Seyi no vex oo - e no work");
      return e.message;
    }
  }

  Future<List<TellerCustomer>> getTellerCustomer(int loginuserid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("Token");
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Content-Type": "application/json",
    };

    var url = Uri.parse(
        BaseUrl + "/MobileTeller/GeteTellerCustomer?loginuserid=$loginuserid");
    final _response = await http.get(url, headers: headers);
    print("_hdhdhhd - $_response");
    print(_response.body);
    if (_response.statusCode == 200) {
      print("Seyi u are a badass engineer..Nice one");
      var myresponse = jsonDecode(_response.body);
      List<TellerCustomer> _list = [];
      for (var u in myresponse) {
        _list.add(TellerCustomer.fromJson(u));
      }
      return _list;
    } else {
      print("why, this thing don fail o");
      throw Exception("Not successful");
    }
  }

  Future<String> getAccountDetail(String acccountnumber) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("Token");
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Content-Type": "application/json",
    };
    try {
      var url = Uri.parse(
          BaseUrl + "/MobileTeller/GetAccountDetail?acctNo=$acccountnumber");
      final response = await http.post(url, headers: headers);
      print(response.statusCode);
      print(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return response.body;
      }
//print()

    } on SocketException catch (e) {
      print("Errors bruh");
      return e.message;
    }
  }

  Future<String> getTransactionList(int loginuserid) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("Token");
    var headers = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Content-Type": "application/json",
    };
    try {
      var url = Uri.parse(BaseUrl +
          "/MobileTeller/GeteCliqMobileTellerPosting?loginuserid=$loginuserid");
      final response = await http.get(url, headers: headers);
      print(response.runtimeType);
      print("hellpo seyi this is am");
      print(response.body);
      if (response.statusCode == 200) {
        print("This is successful bro");
        return response.body;
      } else {
        return response.body;
      }
    } on SocketException catch (e) {
      print("Errors Bruh");
      return e.message;
    }
  }

  Future<String> getStateList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString("Token");

    var headers = <String, String>{
      HttpHeaders.authorizationHeader: "Bearer $token",
      "Content-Type": "application/json",
    };
    try {
      var url = Uri.parse(BaseUrl + "/MobileTeller/GeteCoreStateList");
      final response = await http.get(url, headers: headers);
      print(response.body);
      if (response.statusCode == 200) {
        print("Great Success guy");
        return response.body;
      } else {
        return response.body;
      }
    } on SocketException catch (e) {
      print("Error bro");
      return e.message;
    }
  }

  Widget filterDialog(BuildContext context, AnimationController control) {
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
            animation: control,
            builder: (context, child) {
              return Transform.rotate(
                angle: control.value * 2 * pi,
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
