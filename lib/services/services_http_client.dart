import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class ServicesHttpClient {
  final String baseUrl = 'http://10.0.0.2:8000/api';
  final secureStorage = FlutterSecureStorage();

  //post
  Future<http.Response> post(String endpoint, Map<String, dynamic> body) async {
    final url = Uri.parse("$baseUrl$endpoint");
    try {
      final response = await http.post(
        url,
        headers: {
          'Accept': 'application/json',
          'content-type': 'application/json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception("Post request failed: $e");
    }
  }

  //post WITH TOKEN
  Future<http.Response> postWithToken(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final token = await secureStorage.read(key: "token");
    final url = Uri.parse("$baseUrl$endpoint");
    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'content-type': 'application.json',
        },
        body: jsonEncode(body),
      );
      return response;
    } catch (e) {
      throw Exception("Post request failed: $e");
    }
  }

  //get
  Future<http.Response> get(String endpoint) async {
    final token = await secureStorage.read(key: "token");
    final url = Uri.parse("$baseUrl$endpoint");
    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
          'content-type': 'application.json',
        },
      );
      return response;
    } catch (e) {
      throw Exception("Post request failed: $e");
    }
  }

  //put
  //delete
}
