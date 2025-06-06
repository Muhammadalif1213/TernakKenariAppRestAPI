import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:rest_api/data/models/response/burung_semua_tersedia_model.dart';
import 'package:rest_api/services/services_http_client.dart'; // Import for SocketException

class GetAllBurungTersediaRepository {
  final ServicesHttpClient
  httpClient; // Menggunakan http.Client untuk konsistensi

  GetAllBurungTersediaRepository(this.httpClient);

  Future<Either<String, BurungSemuaTersediaModel>>
  getAllBurungTersedia() async {
    try {
      final response = await httpClient.get("buyer/burung-semua-tersedia");

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final burungTersediaResponse = BurungSemuaTersediaModel.fromJson(
          jsonResponse,
        );
        return Right(burungTersediaResponse);
      } else {
        final errorMessage = json.decode(response.body);
        return Left(errorMessage['message'] ?? 'Unknown error occurred');
      }
    } catch (e) {
      if (e is SocketException) {
        return Left("No Internet connection");
      } else if (e is FormatException) {
        return Left("Invalid response format");
      } else if (e is http.ClientException) {
        return Left("HTTP error: ${e.message}");
      } else {
        return Left("An unexpected error occurred: $e");
      }
    }
  }
}
