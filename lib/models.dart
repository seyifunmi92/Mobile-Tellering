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

class TellerCustomer {
  TellerCustomer({
    this.customerid,
    this.firstname,
    this.surname,
    this.accountnumber,
    this.phone,
  });

  String? customerid;
  String? firstname;
  String? surname;
  String? accountnumber;
  String? phone;

  factory TellerCustomer.fromJson(Map<String, dynamic> json) => TellerCustomer(
        customerid: json["customerid"],
        firstname: json["firstname"],
        surname: json["surname"],
        accountnumber: json["accountnumber"],
        phone: json["phone"],
      );

  Map<String, dynamic> toJson() => {
        "customerid": customerid,
        "firstname": firstname,
        "surname": surname,
        "accountnumber": accountnumber,
        "phone": phone,
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

class Tellertransaction {
  Tellertransaction({
    this.amount,
    this.transactionReference,
    this.naration,
    this.toAccountNumber,
    this.toAccountName,
    this.createdate,
  });

  double? amount;
  String? transactionReference;
  String? naration;
  String? toAccountNumber;
  String? toAccountName;
  DateTime? createdate;

  factory Tellertransaction.fromJson(Map<String, dynamic> json) =>
      Tellertransaction(
        amount: json["amount"],
        transactionReference: json["transactionReference"],
        naration: json["naration"],
        toAccountNumber: json["toAccountNumber"],
        toAccountName: json["toAccountName"],
        createdate: DateTime.parse(json["createdate"]),
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "transactionReference": transactionReference,
        "naration": naration,
        "toAccountNumber": toAccountNumber,
        "toAccountName": toAccountName,
        "createdate": createdate!.toIso8601String(),
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

class AccountDetails {
  AccountDetails({
    this.id,
    this.accountnumber,
    this.accounttitle,
    this.accountdesc,
    this.prodname,
    this.bkbal,
    this.address,
    this.bankname,
    this.phone,
    this.odProd,
    this.allowSi,
    this.siFloor,
    this.od,
    this.pendingc,
    this.cintrate,
    this.dintrate,
    this.apptype,
    this.branch,
    this.branchcode,
    this.customerid,
    this.status,
    this.prodstatus,
    this.proddesc,
    this.effbal,
    this.charges,
    this.productCode,
    this.totalCharge,
    this.acctty,
    this.closingCharge,
    this.officercode,
    this.disableview,
    this.source,
    this.holdbal,
    this.usebal,
    this.acctstatus,
    this.email,
  });

  int? id;
  String? accountnumber;
  String? accounttitle;
  String? accountdesc;
  String? prodname;
  double? bkbal;
  String? address;
  String? bankname;
  String? phone;
  int? odProd;
  int? allowSi;
  double? siFloor;
  double? od;
  double? pendingc;
  double? cintrate;
  double? dintrate;
  String? apptype;
  String? branch;
  String? branchcode;
  int? customerid;
  int? status;
  int? prodstatus;
  String? proddesc;
  double? effbal;
  double? charges;
  String? productCode;
  double? totalCharge;
  String? acctty;
  double? closingCharge;
  dynamic officercode;
  int? disableview;
  dynamic source;
  double? holdbal;
  double? usebal;
  String? acctstatus;
  String? email;

  factory AccountDetails.fromJson(Map<String, dynamic> json) => AccountDetails(
        id: json["id"],
        accountnumber: json["accountnumber"],
        accounttitle: json["accounttitle"],
        accountdesc: json["accountdesc"],
        prodname: json["prodname"],
        bkbal: json["bkbal"].toDouble(),
        address: json["address"],
        bankname: json["bankname"],
        phone: json["phone"],
        odProd: json["odProd"],
        allowSi: json["allowSI"],
        siFloor: json["siFloor"],
        od: json["od"],
        pendingc: json["pendingc"],
        cintrate: json["cintrate"],
        dintrate: json["dintrate"],
        apptype: json["apptype"],
        branch: json["branch"],
        branchcode: json["branchcode"],
        customerid: json["customerid"],
        status: json["status"],
        prodstatus: json["prodstatus"],
        proddesc: json["proddesc"],
        effbal: json["effbal"].toDouble(),
        charges: json["charges"],
        productCode: json["productCode"],
        totalCharge: json["totalCharge"],
        acctty: json["acctty"],
        closingCharge: json["closingCharge"],
        officercode: json["officercode"],
        disableview: json["disableview"],
        source: json["source"],
        holdbal: json["holdbal"],
        usebal: json["usebal"].toDouble(),
        acctstatus: json["acctstatus"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "accountnumber": accountnumber,
        "accounttitle": accounttitle,
        "accountdesc": accountdesc,
        "prodname": prodname,
        "bkbal": bkbal,
        "address": address,
        "bankname": bankname,
        "phone": phone,
        "odProd": odProd,
        "allowSI": allowSi,
        "siFloor": siFloor,
        "od": od,
        "pendingc": pendingc,
        "cintrate": cintrate,
        "dintrate": dintrate,
        "apptype": apptype,
        "branch": branch,
        "branchcode": branchcode,
        "customerid": customerid,
        "status": status,
        "prodstatus": prodstatus,
        "proddesc": proddesc,
        "effbal": effbal,
        "charges": charges,
        "productCode": productCode,
        "totalCharge": totalCharge,
        "acctty": acctty,
        "closingCharge": closingCharge,
        "officercode": officercode,
        "disableview": disableview,
        "source": source,
        "holdbal": holdbal,
        "usebal": usebal,
        "acctstatus": acctstatus,
        "email": email,
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

class StateList {
  StateList({
    this.statecode,
    this.statename,
    this.towncode,
    this.townname,
  });

  String? statecode;
  String? statename;
  String? towncode;
  String? townname;

  factory StateList.fromJson(Map<String, dynamic> json) => StateList(
        statecode: json["statecode"],
        statename: json["statename"],
        towncode: json["towncode"],
        townname: json["townname"],
      );

  Map<String, dynamic> toJson() => {
        "statecode": statecode,
        "statename": statename,
        "towncode": towncode,
        "townname": townname,
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
