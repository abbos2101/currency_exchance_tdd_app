import 'package:dio/dio.dart';

class Api {
  final Dio dio = Dio(BaseOptions(
    baseUrl: "https://cbu.uz/uz/arkhiv-kursov-valyut/",
    connectTimeout: 60000,
    receiveTimeout: 60000,
    sendTimeout: 60000,
    validateStatus: (_) => true,
  ));
}
