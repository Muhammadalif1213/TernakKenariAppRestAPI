import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'dart:developer';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rest_api/data/models/request/auth/login_request_model.dart';
import 'package:rest_api/data/models/request/auth/register_request_model.dart';
import 'package:rest_api/data/models/request/buyer/buyer_profile_request_model.dart';
import 'package:rest_api/data/models/response/buyer/buyer_profile_response_model.dart';
import 'package:rest_api/services/services_http_client.dart';

class ProfileBuyerRepository {
  final ServicesHttpClient _serviceHttpClient;

  ProfileBuyerRepository(this._serviceHttpClient);

  Future<Either<String, BuyerProfileResponseModel>> addProfileBuyer(
    BuyerProfileRequestModel requestModel,
  ) async {
    try {
      final response = await _serviceHttpClient.postWithToken(
        "buyer/profile",
        requestModel.toMap()
      );

      if (response.statusCode == 201) {
        final jsonResponse = json.decode(response.body);
        final profileResponse = BuyerProfileResponseModel.fromJson(
          jsonResponse,
        );
        return Right(profileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while adding profile: $e");
    }
  }

  Future<Either<String, BuyerProfileResponseModel>> getProfileBuyer() async {
    try {
      final response = await _serviceHttpClient.get("buyer/profile");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final profileResponse = BuyerProfileResponseModel.fromJson(
          jsonResponse,
        );
        log("Profile Response: $profileResponse");
        return Right(profileResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      return Left("An error occurred while fetching profile: $e");
    }
  }
}
