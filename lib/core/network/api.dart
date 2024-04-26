import 'dart:async';
import 'dart:convert';

import 'dart:io';
import 'dart:typed_data';
import 'package:doggy_do/core/models/dog_model.dart';
import 'package:doggy_do/core/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as http;

class Api {
  static const serviceEndpoint =
      'https://zjrwjnasl6.execute-api.eu-west-2.amazonaws.com/dev/';

  var client = http.Client();
  final ioClient = HttpClient();

  Api() {
    ioClient.connectionTimeout = const Duration(seconds: 2);
    client = http.IOClient(ioClient);
  }

  Future<String> uploadImage(
      Uint8List bytes, String fileName, UserModel user) async {
    try {
      Uri uri = Uri.parse('$serviceEndpoint/upload');

      final response = await http.post(
        uri,
        body: bytes,
        headers: {
          'file-name': fileName,
          'user-name': user.userName!,
          'dog-name': user.dogName!,
        },
      );

      if (response.statusCode == 200) {
        return "OK";
      } else {
        throw Exception('Failed to upload image: ${response.reasonPhrase}');
      }
    } on SocketException catch (e) {
      throw Exception('Connection Error: $e');
    } on TimeoutException catch (e) {
      throw Exception('Timeout Error: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<DogModel>> fetchDogs(
      int? limit, String? exclusiveStartKey) async {
    final uri = Uri.parse('$serviceEndpoint/dogs');

    try {
      // Construct query parameters
      final queryParams = <String, String>{};
      if (limit != null) {
        queryParams['limit'] = limit.toString();
      }
      if (exclusiveStartKey != null) {
        queryParams['exclusive_start_key'] = exclusiveStartKey;
      }

      final response = await http.get(
        uri.replace(queryParameters: queryParams),
        headers: {
          'x-api-key': 'mvtOF0C0QJ65CoOKhVrdcanmWHR5aQo96I9fxTwx',
        },
      );

      if (response.statusCode == 200) {
        print(response.body);

        final parsed = json.decode(response.body);
        final List<DogModel> dogs = DogModel.listFromJson(response.body);

        return dogs;
      } else {
        throw HttpException('Failed to load dogs: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      throw Exception('Connection Error: $e');
    } on TimeoutException catch (e) {
      throw Exception('Timeout Error: $e');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
