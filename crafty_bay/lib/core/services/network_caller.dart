import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

part '../models/network_response.dart';

class NetworkCaller {
  final Logger _logger = Logger();

  final Map<String, String> Function() headers;
  final VoidCallback onUnauthorize;

  NetworkCaller({required this.headers, required this.onUnauthorize});

  Future<NetworkResponse> getRequest(String url) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url);
      Response response = await get(uri, headers: headers());
      _logResponse(url, response);

      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return NetworkResponse(
          isSuccess: true,
          responseCode: response.statusCode,
          body: decodedData,
        );
      } else if (response.statusCode == 401) {
        onUnauthorize();
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage: 'Un-authorize',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage:
              decodedData['msg'], // TODO: Decouple this data variable
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        responseCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  Future<NetworkResponse> postRequest(
    String url, {
    Map<String, dynamic>? body,
    bool isFromLogin = false,
  }) async {
    try {
      Uri uri = Uri.parse(url);

      _logRequest(url, body: body);
      Response response = await post(
        uri,
        headers: headers(),
        body: jsonEncode(body),
      );
      _logResponse(url, response);

      final decodedData = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(
          isSuccess: true,
          responseCode: response.statusCode,
          body: decodedData,
        );
      } else if (response.statusCode == 401) {
        if (!isFromLogin) {
          onUnauthorize();
        }
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage: 'Un-authorize',
        );
      } else {
        return NetworkResponse(
          isSuccess: false,
          responseCode: response.statusCode,
          errorMessage: decodedData['msg'],
        );
      }
    } catch (e) {
      return NetworkResponse(
        isSuccess: false,
        responseCode: -1,
        errorMessage: e.toString(),
      );
    }
  }

  void _logRequest(String url, {Map<String, dynamic>? body}) {
    _logger.i(
      'URL: $url\n'
      'Body: $body',
    );
  }

  void _logResponse(String url, Response response) {
    _logger.i(
      'URL: $url\n'
      'Status Code: ${response.statusCode}\n'
      'Body: ${response.body}',
    );
  }
}
