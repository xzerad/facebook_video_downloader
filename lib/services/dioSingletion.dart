import 'package:dio/dio.dart';

class DioSingleton{
  static final Dio _dio = Dio();
  static get dio => _dio;
}