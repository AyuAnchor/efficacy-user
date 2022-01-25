import 'package:dio/dio.dart';

class NetworkEngine {
  late Dio _dio;

  final baseUrl = "https://localhost:3000/";

  Service() {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: 25,
        receiveTimeout: 60,
      ),
    );
    initializeInterceptor();
  }

  Future<Response> post(
      {required Map<String, dynamic> data, required String endPoint}) async {
    Response response;
    try {
      response = await _dio.post(endPoint, data: data);
      return response;
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }
  }

  initializeInterceptor() {
    _dio.interceptors
        .add(InterceptorsWrapper(onError: (error, errorInterceptorHandler) {
      print(error.message);
    }, onRequest: (request, requestInterceptorHandler) {
      print("${request.method} | ${request.path}");
    }, onResponse: (response, responseInterceptorHandler) {
      print('${response.statusCode} ${response.statusCode} ${response.data}');
    }));
  }
}