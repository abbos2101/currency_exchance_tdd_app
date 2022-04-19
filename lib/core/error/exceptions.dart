import 'package:dio/dio.dart';

class ServerException implements Exception {
  final Response response;

  const ServerException(this.response);
}

class CacheException implements Exception {}
