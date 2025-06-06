import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rest_api/data/models/request/auth/login_request_model.dart';
import 'package:rest_api/data/models/request/auth/register_request_model.dart';
import 'package:rest_api/services/services_http_client.dart';

class AuthRepository {
  final ServicesHttpClient _servicesHttpClient;
  final secureStorage = FlutterSecureStorage();

  AuthRepository(this._servicesHttpClient);

  Future login(LoginRequestModel requestModel) async {}

  Future register(RegisterRequestModel requestModel) async {}
}
