import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rest_api/services/services_http_client.dart';

class AuthRepository {
  final ServicesHttpClient _servicesHttpClient;
  final secureStorage = FlutterSecureStorage();

  AuthRepository(this._servicesHttpClient);
}
