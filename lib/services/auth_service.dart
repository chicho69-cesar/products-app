import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyByasZB7FD9YhfUzWjF0X01BTDM0Nr-1bQ';

  //* If we return something something is bad, if we return null all is good
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken
    });

    final response = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedRes = json.decode(response.body);

    if (decodedRes.containsKey('idToken')) {
      // Guardar token en el secure storage
      return null;
    } else {
      // Mostrar un error 
      return decodedRes['error']['message'];
    }
  }
}
