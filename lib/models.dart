import 'dart:io';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teller/cashDepostit.dart';
import 'package:teller/dailyCollections.dart';
import 'package:teller/welcome.dart';
import 'package:teller/welcome.dart';
import 'package:teller/services.dart';
import 'package:teller/constants.dart';
import 'package:teller/textstyle.dart';
import 'package:teller/login.dart';
import 'package:teller/teller.dart';
import 'package:teller/customer.dart';
import 'package:teller/openAccount.dart';
import 'package:teller/summaryAccount.dart';
import 'package:teller/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class login {
  login({
    this.username,
    this.password,
  });
  String? username;
  String? password;

  factory login.fromJson(Map<String, dynamic> json) => login(
        username: json["username"],
        password: json["password"],
      );
  Map<String, dynamic> toJson() => {
        "username": username,
        "password": password,
      };

  @override
  String toString() {
    return super.toString();
  }
}

class UserRegistration {
  UserRegistration(
      {this.email, this.phoneno, this.securedkey, this.corebankingid});

  String? email;
  String? phoneno;
  String? securedkey;
  String? corebankingid;

  factory UserRegistration.fromJson(Map<String, dynamic> json) =>
      UserRegistration(
        email: json["email"],
        phoneno: json["phoneno"],
        securedkey: json["securedkey"],
        corebankingid: json["corebankingid"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "phoneno": phoneno,
        "securedkey": securedkey,
        "corebankingid": corebankingid,
      };
}

class MobileTellerFund {
  MobileTellerFund({
    this.loginUserId,
    this.requestedamount,
  });

  int? loginUserId;
  int? requestedamount;

  factory MobileTellerFund.fromJson(Map<String, dynamic> json) =>
      MobileTellerFund(
        loginUserId: json["loginUserId"],
        requestedamount: json["requestedamount"],
      );

  Map<String, dynamic> toJson() => {
        "loginUserId": loginUserId,
        "requestedamount": requestedamount,
      };
}

class MobileTellerRequest {
  MobileTellerRequest({
    this.id,
    this.loginUserId,
    this.requestedamount,
    this.createdate,
    this.createdBy,
    this.approved,
    this.status,
  });

  String? id;
  int? loginUserId;
  int? requestedamount;
  DateTime? createdate;
  int? createdBy;
  bool? approved;
  String? status;

  factory MobileTellerRequest.fromJson(Map<String, dynamic> json) =>
      MobileTellerRequest(
        id: json["id"],
        loginUserId: json["loginUserId"],
        requestedamount: json["requestedamount"],
        createdate: DateTime.parse(json["createdate"]),
        createdBy: json["createdBy"],
        approved: json["approved"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "loginUserId": loginUserId,
        "requestedamount": requestedamount,
        "createdate": createdate!.toIso8601String(),
        "createdBy": createdBy,
        "approved": approved,
        "status": status,
      };
}

class FundMobileTeller {
  FundMobileTeller({
    this.loginUserId,
    this.fundingrequesid,
  });

  int? loginUserId;
  String? fundingrequesid;

  factory FundMobileTeller.fromJson(Map<String, dynamic> json) =>
      FundMobileTeller(
        loginUserId: json["loginUserId"],
        fundingrequesid: json["fundingrequesid"],
      );

  Map<String, dynamic> toJson() => {
        "loginUserId": loginUserId,
        "fundingrequesid": fundingrequesid,
      };
}

class MobileTellerCollection {
  MobileTellerCollection({
    this.loginuserid,
    this.isOcode,
    this.transactionreference,
    this.trandate,
    this.narration,
    this.accountnumber,
    this.acctname,
    this.amount,
  });

  int? loginuserid;
  String? isOcode;
  String? transactionreference;
  DateTime? trandate;
  String? narration;
  String? accountnumber;
  String? acctname;
  int? amount;

  factory MobileTellerCollection.fromJson(Map<String, dynamic> json) =>
      MobileTellerCollection(
        loginuserid: json["loginuserid"],
        isOcode: json["isOcode"],
        transactionreference: json["transactionreference"],
        trandate: DateTime.parse(json["trandate"]),
        narration: json["narration"],
        accountnumber: json["accountnumber"],
        acctname: json["acctname"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "loginuserid": loginuserid,
        "isOcode": isOcode,
        "transactionreference": transactionreference,
        "trandate": trandate!.toIso8601String(),
        "narration": narration,
        "accountnumber": accountnumber,
        "acctname": acctname,
        "amount": amount,
      };
}

class MobileTellerLiquidation {
  MobileTellerLiquidation({
    this.loginuserid,
    this.isOcode,
    this.transactionreference,
    this.trandate,
    this.narration,
  });

  int? loginuserid;
  String? isOcode;
  String? transactionreference;
  DateTime? trandate;
  String? narration;

  factory MobileTellerLiquidation.fromJson(Map<String, dynamic> json) =>
      MobileTellerLiquidation(
        loginuserid: json["loginuserid"],
        isOcode: json["isOcode"],
        transactionreference: json["transactionreference"],
        trandate: DateTime.parse(json["trandate"]),
        narration: json["narration"],
      );

  Map<String, dynamic> toJson() => {
        "loginuserid": loginuserid,
        "isOcode": isOcode,
        "transactionreference": transactionreference,
        "trandate": trandate!.toIso8601String(),
        "narration": narration,
      };
}

class ResponseObject {
  int? responseCode;
  String? responseBody;

  ResponseObject({
    this.responseCode,
    this.responseBody,
  });
}

class GetBalance {
  GetBalance({
    this.loginUserId,
    this.amountcollected,
    this.currentbalance,
    this.totalamountCollected,
  });

  int? loginUserId;
  double? amountcollected;
  double? currentbalance;
  double? totalamountCollected;

  factory GetBalance.fromJson(Map<String, dynamic> json) => GetBalance(
        loginUserId: json["loginUserId"],
        amountcollected: json["amountcollected"],
        currentbalance: json["currentbalance"],
        totalamountCollected: json["totalamountCollected"],
      );

  Map<String, dynamic> toJson() => {
        "loginUserId": loginUserId,
        "amountcollected": amountcollected,
        "currentbalance": currentbalance,
        "totalamountCollected": totalamountCollected,
      };
}

class ResponseLogin {
  int? responseCode;
  String? responseBody;

  ResponseLogin({
    this.responseCode,
    this.responseBody,
  });
}

class cashDeposit {
  cashDeposit({
    this.loginuserid,
    this.transactionreference,
    this.trandate,
    this.narration,
    this.accountnumber,
    this.acctname,
    this.amount,
  });

  int? loginuserid;
  String? transactionreference;
  DateTime? trandate;
  String? narration;
  String? accountnumber;
  String? acctname;
  int? amount;

  factory cashDeposit.fromJson(Map<String, dynamic> json) => cashDeposit(
        loginuserid: json["loginuserid"],
        transactionreference: json["transactionreference"],
        trandate: DateTime.parse(json["trandate"]),
        narration: json["narration"],
        accountnumber: json["accountnumber"],
        acctname: json["acctname"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "loginuserid": loginuserid,
        "transactionreference": transactionreference,
        "trandate": trandate!.toIso8601String(),
        "narration": narration,
        "accountnumber": accountnumber,
        "acctname": acctname,
        "amount": amount,
      };
}

class CashLiquidation {
  CashLiquidation({
    this.loginuserid,
    this.transactionreference,
    this.trandate,
    this.narration,
  });

  int? loginuserid;
  String? transactionreference;
  DateTime? trandate;
  String? narration;

  factory CashLiquidation.fromJson(Map<String, dynamic> json) =>
      CashLiquidation(
        loginuserid: json["loginuserid"],
        transactionreference: json["transactionreference"],
        trandate: DateTime.parse(json["trandate"]),
        narration: json["narration"],
      );

  Map<String, dynamic> toJson() => {
        "loginuserid": loginuserid,
        "transactionreference": transactionreference,
        "trandate": trandate!.toIso8601String(),
        "narration": narration,
      };
}

class Responselogin {
  Responselogin({
    this.username,
    this.role,
    this.originalUserName,
    this.accessToken,
    this.refreshToken,
  });

  String? username;
  dynamic role;
  String? originalUserName;
  String? accessToken;
  RefreshToken? refreshToken;

  factory Responselogin.fromJson(Map<String, dynamic> json) => Responselogin(
        username: json["username"],
        role: json["role"],
        originalUserName: json["originalUserName"],
        accessToken: json["accessToken"],
        refreshToken: RefreshToken.fromJson(json["refreshToken"]),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "role": role,
        "originalUserName": originalUserName,
        "accessToken": accessToken,
        "refreshToken": refreshToken!.toJson(),
      };
}

class RefreshToken {
  RefreshToken({
    this.username,
    this.tokenString,
    this.expireAt,
  });

  String? username;
  String? tokenString;
  DateTime? expireAt;

  factory RefreshToken.fromJson(Map<String, dynamic> json) => RefreshToken(
        username: json["username"],
        tokenString: json["tokenString"],
        expireAt: DateTime.parse(json["expireAt"]),
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "tokenString": tokenString,
        "expireAt": expireAt?.toIso8601String(),
      };
}

class MobileTellerRequestList {
  MobileTellerRequestList({
    this.id,
    this.loginUserId,
    this.requestedamount,
    this.createdate,
    this.createdBy,
    this.approved,
    this.status,
  });

  String? id;
  int? loginUserId;
  double? requestedamount;
  DateTime? createdate;
  int? createdBy;
  bool? approved;
  String? status;

  factory MobileTellerRequestList.fromJson(Map<String, dynamic> json) =>
      MobileTellerRequestList(
        id: json["id"],
        loginUserId: json["loginUserId"],
        requestedamount: json["requestedamount"],
        createdate: DateTime.parse(json["createdate"]),
        createdBy: json["createdBy"],
        approved: json["approved"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "loginUserId": loginUserId,
        "requestedamount": requestedamount,
        "createdate": createdate!.toIso8601String(),
        "createdBy": createdBy,
        "approved": approved,
        "status": status,
      };
}

class RequestDetail {
  RequestDetail({
    this.id,
    this.loginUserId,
    this.requestedamount,
    this.createdate,
    this.createdBy,
    this.approved,
    this.status,
  });

  String? id;
  int? loginUserId;
  double? requestedamount;
  DateTime? createdate;
  int? createdBy;
  bool? approved;
  String? status;

  factory RequestDetail.fromJson(Map<String, dynamic> json) => RequestDetail(
        id: json["id"],
        loginUserId: json["loginUserId"],
        requestedamount: json["requestedamount"],
        createdate: DateTime.parse(json["createdate"]),
        createdBy: json["createdBy"],
        approved: json["approved"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "loginUserId": loginUserId,
        "requestedamount": requestedamount,
        "createdate": createdate!.toIso8601String(),
        "createdBy": createdBy,
        "approved": approved,
        "status": status,
      };
}

class ResponseTeller {
  int? responseCode;
  String? responseBody;

  ResponseTeller({
    this.responseCode,
    this.responseBody,
  });
}
