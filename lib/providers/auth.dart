import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:salon_clock/models/http_exception.dart';
import '../providers/auth.dart';

class Auth with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  //------------------------------------------------------------------------------------------------------------
  bool get isAuth {
    return _token != null;
  }

  //------------------------------------------------------------------------------------------------------------
  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null; //? if this return null then we are not authenticated or the token is already exipred.
  }

  //------------------------------------------------------------------------------------------------------------
  String get userId {
    return _userId;
  }
  //------------------------------------------------------------------------------------------------------------

  Future<void> _authenticate(
      String email, String password, String urlSegment) async {
    final url = Uri.parse(
        'https://identitytoolkit.googleapis.com/v1/$urlSegment?key=AIzaSyDWd_P7ndAU-bqmmXgJlj45TChhO_Rdnr8');
    try {
      final response = await http.post(url,
          body: json.encode({
            "email": email,
            "password": password,
            "returnSecureToken": true
          }));
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error'][
            'message']); //?I'll forward response data, then access the error key and then in that inner map,
        //?the message key to basically forward that identifier that Firebase gives me as part of the exception I throw.
      }
      _token = responseData['idToken'];
      _userId = responseData['localId'];
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    } catch (error) {
      throw error;
    }
    notifyListeners();
    _autoLogout();
  }

//------------------------------------------------------------------------------------------------------------
  Future<void> singUp(String email, String password) async {
    return _authenticate(email, password, 'accounts:signUp');
  }

//------------------------------------------------------------------------------------------------------------
  Future<void> singIn(String email, String password) async {
    return _authenticate(email, password, 'accounts:signInWithPassword');
  }

//------------------------------------------------------------------------------------------------------------
  void logOut() {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();
  }

  //------------------------------------------------------------------------------------------------------------
  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logOut);
  }
}
