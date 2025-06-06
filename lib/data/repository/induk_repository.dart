import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:rest_api/data/models/request/admin/induk_request_model.dart';
import 'package:rest_api/data/models/response/get_all_induk_response.dart';
import 'package:rest_api/services/services_http_client.dart';

class IndukRepository {
  final ServicesHttpClient _serviceHttpClient;

  IndukRepository(this._serviceHttpClient);

  Future<Either<String, GetIndukById>> addInduk(
    IndukRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        "admin/induk",
        requestModel.toMap(),
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final profileResponse = GetIndukById.fromJson(jsonResponse);
        return Right(profileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while adding induk: $e");
    }
  }

  Future<Either<String, GetAllIndukModel>> getAllInduk() async {
    try {
      final response = await _serviceHttpClient.get("admin/induk");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final profileResponse = GetAllIndukModel.fromJson(jsonResponse);
        return Right(profileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while getting all induk: $e");
    }
  }
}