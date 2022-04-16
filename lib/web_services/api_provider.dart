import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:urban_home/constant/constant.dart';
import 'package:urban_home/pages/auth/login.dart';

class ApiProvider {
  static String baseUrl = "https://brijesh-patel.herokuapp.com";
  static final s = SharedPreferences.getInstance();

  /// function for auto login
  static Future autoLogin() async {
    SharedPreferences sp = await s;
    bool b = sp.containsKey("TOKEN");
    print(b);
    return b;
  }

  /// This Function is used for LogOut
  static logout(context) async {
    final _sp = await s;
    _sp.clear();
    Navigator.pushAndRemoveUntil(
        context, MaterialPageRoute(builder: (c) => Login()), (route) => false);
    Fluttertoast.showToast(
        msg: "Logout Successful", backgroundColor: primaryColor);
    print(_sp.setBool("DB_VISITED", true));
  }

  static sendOTP(String number) async {
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode({"number": number});

    var url = baseUrl + "/api/userOtp";

    try {
      final r = await post(Uri.parse(url), body: body, headers: headers);
      print(r.body);
      if (r.statusCode >= 200 && r.statusCode <= 210) {
        Fluttertoast.showToast(
            msg: jsonDecode(r.body)['Otp'].toString(),
            toastLength: Toast.LENGTH_LONG);
      } else {
        Fluttertoast.showToast(
            msg: 'Some error occured try again later',
            toastLength: Toast.LENGTH_LONG);
      }
      return r;
    } on Exception catch (e) {
      return Future.error(e.toString());
      // TODO
    }
  }

  static validateOtp(String number, String otp) async {
    SharedPreferences sp = await s;
    var headers = {'Content-Type': 'application/json'};

    var body = jsonEncode({"number": '+91' + number, "otp": otp});

    var url = baseUrl + "/api/verifyOtp";

    try {
      final Response r =
          await post(Uri.parse(url), body: body, headers: headers);
      if (r.statusCode >= 200 && r.statusCode <= 210) {
        var body = jsonDecode(r.body);
        sp.setString("TOKEN", body["token"]);
        print(body);
      }
      return r;
    } on Exception catch (e) {
      return Future.error(e.toString());
    }
  }

  static registerUser(String name, String email, String imagePath) async {
    SharedPreferences sp = await s;
    final token = sp.getString('TOKEN');
    var headers = {'Authorization': 'Bearer ${token}'};
    var request = http.MultipartRequest('POST',
        Uri.parse('https://brijesh-patel.herokuapp.com/api/userdetail'));
    request.fields.addAll({'email': email, 'name': name});
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }

  static updateUser(String name, String email, String imagePath) async {
    SharedPreferences sp = await s;
    final token = sp.getString('TOKEN');
    var headers = {'Authorization': 'Bearer ${token}'};

    var request =
        http.MultipartRequest('PUT', Uri.parse('$baseUrl/api/updateuser'));
    request.fields.addAll({'name': name, 'email': email});
    request.files.add(await http.MultipartFile.fromPath('image', imagePath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Fluttertoast.showToast(
          msg: 'Profile Updated', toastLength: Toast.LENGTH_LONG);
    } else {
      print(response.reasonPhrase);
      Fluttertoast.showToast(
          msg: 'Some error occured try again later',
          toastLength: Toast.LENGTH_LONG);
    }
  }

  static postMethod(var body, String restUrl) async {
    SharedPreferences sp = await s;
    final token = sp.getString('TOKEN');
    var url = baseUrl + restUrl;
    body = jsonEncode(body);
    try {
      final http.Response r = await http.post(Uri.parse(url),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${token}'
          },
          body: body);
      print(r.statusCode);
      return r.statusCode;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

//
  static postMethodAuthorized(String restUrl) async {
    SharedPreferences sp = await s;
    final token = sp.getString('TOKEN');
    var url = baseUrl + restUrl;
    try {
      final http.Response r = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
      );
      print(r.statusCode);
      dynamic body = jsonDecode(r.body);
      return body;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

//
  static getMethod(String restUrl) async {
    // SharedPreferences sp = await s;
    // final token = sp.getString('TOKEN');
    var url = baseUrl + restUrl;

    try {
      http.Response r = await http.get(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer ${token}'
        },
      );
      print(r.request);
      var body = jsonDecode(r.body);
      return body;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

//
  static getMethodAuthorized(String restUrl) async {
    SharedPreferences sp = await s;
    final token = sp.getString('TOKEN');
    var url = baseUrl + restUrl;
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${token}'
    };

    try {
      http.Response r = await http.get(Uri.parse(url), headers: headers);
      print(r.request.toString() + 'here');
      var body = jsonDecode(r.body);
      print(body);
      return body;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

//
  static favPostMethod(String restUrl) async {
    var url = baseUrl + restUrl;
    try {
      final http.Response r = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          // 'Authorization': 'Bearer ${user.authToken}'
        },
      );
      print(r.statusCode);
      dynamic data = jsonDecode(r.body);
      return data;
    } on Exception catch (e) {
      print(e.toString());
    }
  }

//
  static deleteMethod(String restUrl) async {
    SharedPreferences sp = await s;
    final token = sp.getString('TOKEN');
    var url = baseUrl + restUrl;
    try {
      final http.Response r = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
      );
      print(r.statusCode.toString() + r.request.toString());
    } on Exception catch (e) {
      print(e.toString());
    }
  }

//
  static addNotification() async {
    SharedPreferences sp = await s;
    final token = sp.getString('TOKEN');
    var url = 'https://urban-home.herokuapp.com/api/addnotification';
    try {
      final http.Response r = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}'
        },
      );
    } on Exception catch (e) {
      print(e.toString());
    }
  }
}
